Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3617541D8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236548AbjGNRxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236557AbjGNRwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:52:51 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F733AAE;
        Fri, 14 Jul 2023 10:52:11 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-3456fda4ed1so10442625ab.0;
        Fri, 14 Jul 2023 10:52:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356771; x=1691948771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gvpPOhyiOh3yD5ckolCJs7/jsewuEi/UtNcofsHWiUI=;
        b=DrLckZi09VeG1IG0R0Y5yA7R5/a9hNd1qA9c8W42Y5MgY6k5R/p5en30xJN8lC8s9D
         VgxcmHIqfUD05QEw28iqRsPxofiguR5Uf+Sw3Iwtv0J0mGdrIhlu3RZi4AjVWvNFAflZ
         6RLhFD5rb56JgTyN7WOYlFNfJmIZPVwBKP3XZRJ2APuneQq4VhI2F/mX18aj5ycS312T
         s4CsR0cI6h29ctTS+KepCOOMjDpVOs9wTPBa0IJ017goQqe9MbzTLwnFdMgATTgUZ37W
         RFaEIulSSVzFV7k7x4gPCjwljFU/4ZKwLyaIN6aoT5xQqXdSyG3AbbBxIx/078ZxkkxA
         KPJQ==
X-Gm-Message-State: ABy/qLZdJDEZs9d1OKu1+DqvHume7utt6Aro/HazTeLwZyyDIrzmrTsE
        ES+6mVgCNJuZT2aCwgSZj5xTSd7Wrg==
X-Google-Smtp-Source: APBJJlEL/wWzdm4NOF7GUdE2JbXnddL7ORxSEBMTz29cuUVmEyalK0t4rkP/sMbFXR0nWOasAipLjg==
X-Received: by 2002:a92:d905:0:b0:346:7c6e:1497 with SMTP id s5-20020a92d905000000b003467c6e1497mr5348597iln.21.1689356771318;
        Fri, 14 Jul 2023 10:46:11 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id t3-20020a05663801e300b0042b52dc77e3sm2646184jaq.158.2023.07.14.10.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:46:10 -0700 (PDT)
Received: (nullmailer pid 4056998 invoked by uid 1000);
        Fri, 14 Jul 2023 17:46:00 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hsi: omap_ssi: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:45:54 -0600
Message-Id: <20230714174554.4056851-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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
 drivers/hsi/controllers/omap_ssi_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hsi/controllers/omap_ssi_core.c b/drivers/hsi/controllers/omap_ssi_core.c
index 84ba8b875199..4c1a00f9929e 100644
--- a/drivers/hsi/controllers/omap_ssi_core.c
+++ b/drivers/hsi/controllers/omap_ssi_core.c
@@ -25,6 +25,7 @@
 #include <linux/debugfs.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pm_runtime.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/hsi/hsi.h>
 #include <linux/idr.h>
-- 
2.40.1

