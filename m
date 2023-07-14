Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6393D75409B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236133AbjGNRki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236126AbjGNRkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:40:33 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FBE3A94;
        Fri, 14 Jul 2023 10:40:29 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-78666f06691so88019239f.0;
        Fri, 14 Jul 2023 10:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356429; x=1691948429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Me3eQAxtkYEt1As/TJ8gtlG9I7mp3faMQUIZ1X3guVM=;
        b=EqVhtWli27ME9+FIFN/qQWDHJno30DtkuzDhhhIA5ecE1IxtKsoze647erJl5UMptz
         s8JjQSVx4o5PG/c6/ojmyMhBsJF5cVUCX33apuAYms8bQAT4OBZrYchybes+tFT2v15k
         X6Hn8AbXEQ3zf1RqaF+8NmjwhGGSTbRt9TKbiCSwqntkNwaHYQBdUgrZNqtz7EoX371S
         6STyDlD1I54FZ8Mf6oId/TpFTd0stuw4wU4DgHqpxku90rKGuYEjH0Ss/6fmJTHsXdM/
         BqtZLedePQQYe4ohLVkGvM0mUkxL47ODQ747bC+DfQmuTXiNObwCJIk0G/QzNo887+yW
         /asw==
X-Gm-Message-State: ABy/qLaa+9xGD4knNMk3LIiSpmrvzXIxQCkgO+WA/ijk08fr30A0wcso
        XAajKSgxXH2Ewrjmkgtd6Onb6qSuUA==
X-Google-Smtp-Source: APBJJlHxEqwUSGqf8oHHKwjtywph6EMwM1DtmtII+Y+8QWLovfd5P5qKIMaW4TcFAxw+Y4tCYFtzNA==
X-Received: by 2002:a5d:924c:0:b0:785:d06d:7b04 with SMTP id e12-20020a5d924c000000b00785d06d7b04mr5250377iol.1.1689356429010;
        Fri, 14 Jul 2023 10:40:29 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id i15-20020a02cc4f000000b0042b35c7b8c5sm2812180jaq.61.2023.07.14.10.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:40:28 -0700 (PDT)
Received: (nullmailer pid 4040049 invoked by uid 1000);
        Fri, 14 Jul 2023 17:40:27 -0000
From:   Rob Herring <robh@kernel.org>
To:     Michal Simek <monstr@monstr.eu>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] microblaze: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:40:23 -0600
Message-Id: <20230714174023.4039938-1-robh@kernel.org>
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
 arch/microblaze/kernel/reset.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/microblaze/kernel/reset.c b/arch/microblaze/kernel/reset.c
index 5f4722908164..2f66c7963084 100644
--- a/arch/microblaze/kernel/reset.c
+++ b/arch/microblaze/kernel/reset.c
@@ -9,7 +9,6 @@
 
 #include <linux/init.h>
 #include <linux/delay.h>
-#include <linux/of_platform.h>
 #include <linux/reboot.h>
 
 void machine_shutdown(void)
-- 
2.40.1

