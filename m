Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5EE7541DD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236639AbjGNRxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236589AbjGNRwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:52:54 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC603C0F;
        Fri, 14 Jul 2023 10:52:20 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3464c774f23so9784225ab.1;
        Fri, 14 Jul 2023 10:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689357078; x=1691949078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9I3bSbFAKVGP3uG8UeEfKdejisGHLrQ6XlcDJAL2RDg=;
        b=DLwdyX50GA7GntdQ3BPvXzuMgSeQ0JOPXcePTKeLiRggcHmcMBj1YMaHgubETHprRm
         BcRykHJ+CGsoWVlOkVlpngDkHIP0r1dNrtc41/y8R+6dgBKVUpV0ivmvJcRirJpMTIs1
         nrj/2+jF5H6zHquQbEAtGQgXMWLzk4r88NIozqrKH7St1uWExgljNFWqK7fz+o/y4qTP
         rIHxg8C/1HV12TWGIWemBaBPBxnBxKx3mOX1JhaLP4eTIpqUKpB65ZQwzi0nHgjrLaEh
         8aZhWDyrZXUDixtybphIOtB9FUdgxFWyEMxNUQlFZvRVrEnouOEmopoymsE0j9JErOmk
         FVgw==
X-Gm-Message-State: ABy/qLa87lj13jVjfegMYgHTsb37k6F31QQjs9qQnthAIzVTlvw7eIbC
        x/xNFbo8iqOCZE3AYl40rA==
X-Google-Smtp-Source: APBJJlGfb92CgkIPb+2FsxwG1eOBdUeQ6pi5jmjVa3LHCgoLhUI39SA2CM596plF6yRDK1jxGt9m2A==
X-Received: by 2002:a92:dc04:0:b0:345:f28f:cc26 with SMTP id t4-20020a92dc04000000b00345f28fcc26mr5039133iln.24.1689357078318;
        Fri, 14 Jul 2023 10:51:18 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id x16-20020a920610000000b00345f01b3463sm2832093ilg.42.2023.07.14.10.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:51:17 -0700 (PDT)
Received: (nullmailer pid 4065963 invoked by uid 1000);
        Fri, 14 Jul 2023 17:50:48 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] parport: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:50:42 -0600
Message-Id: <20230714175042.4065815-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it as merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/parport/parport_sunbpp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/parport/parport_sunbpp.c b/drivers/parport/parport_sunbpp.c
index 865fc41dbb6c..c81d4d86994b 100644
--- a/drivers/parport/parport_sunbpp.c
+++ b/drivers/parport/parport_sunbpp.c
@@ -28,7 +28,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 
 #include <linux/parport.h>
 
-- 
2.40.1

