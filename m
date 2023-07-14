Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31948754196
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236644AbjGNRyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236560AbjGNRxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:53:44 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69094359F;
        Fri, 14 Jul 2023 10:53:14 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7866189cff1so84338539f.0;
        Fri, 14 Jul 2023 10:53:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689357133; x=1691949133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UAZXEC0ZZSTboxvyemEYcLPqrWdEtetoC7pYf3hwIVs=;
        b=Jg8C/nVKXRZegyDv/44iMu92dvdWE1i+VS1rqaAgoFy7vTXj27lpE1Is0FMxN05EYG
         78jQmjzUcGqAmTD/39YywefKNKOEm6eRVdsTsptNXFwd5DUrb4EWSVvlt4TfotlluBhA
         EbgP/95Z5FJbnZs4tLQMakjgpPDeyKl4f3oec8OcUS7zvwOSnmm6eWaJ5KP29yNAyDBA
         cyISSyB+8ynW78n7fMcHd5H03DUa6Kumb8J2EyAT04GRg7W8NgxN0+MbqJ1+hF26qWPh
         d/w+rtz/mhHkXlavGYZ3oV6fLLGR/6w0yy+bZB+YfJ4XavdC82YW7cM/1/fcNCLkPLFd
         g93g==
X-Gm-Message-State: ABy/qLaqcr7CjrNQTcGOrI+tUQMxh9h5rEHSFbmklMYnEk/9dBh7Ze1e
        uM+Qwjz5/R9dr2rMT/xE9M3jY4JOTMJM
X-Google-Smtp-Source: APBJJlE9JcsK12a+nn2E92glV3v0m6kTD9dSy4NFGvaTaUE4vjS3fqBwn27Us4irzM5tFOUlsZVZZQ==
X-Received: by 2002:a05:6602:2565:b0:783:63d6:4cb with SMTP id dj5-20020a056602256500b0078363d604cbmr5307703iob.14.1689357132908;
        Fri, 14 Jul 2023 10:52:12 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id ei2-20020a05663829a200b0042b4b1246cbsm2731387jab.148.2023.07.14.10.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:52:12 -0700 (PDT)
Received: (nullmailer pid 4067193 invoked by uid 1000);
        Fri, 14 Jul 2023 17:51:29 -0000
From:   Rob Herring <robh@kernel.org>
To:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: aspeed: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:51:28 -0600
Message-Id: <20230714175128.4067138-1-robh@kernel.org>
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
 drivers/soc/aspeed/aspeed-lpc-snoop.c    | 1 -
 drivers/soc/aspeed/aspeed-p2a-ctrl.c     | 2 +-
 drivers/soc/aspeed/aspeed-uart-routing.c | 3 +--
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index eceeaf8dfbeb..773dbcbc03a6 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -19,7 +19,6 @@
 #include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/poll.h>
 #include <linux/regmap.h>
diff --git a/drivers/soc/aspeed/aspeed-p2a-ctrl.c b/drivers/soc/aspeed/aspeed-p2a-ctrl.c
index 20b5fb2a207c..548f44da28a9 100644
--- a/drivers/soc/aspeed/aspeed-p2a-ctrl.c
+++ b/drivers/soc/aspeed/aspeed-p2a-ctrl.c
@@ -18,8 +18,8 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
diff --git a/drivers/soc/aspeed/aspeed-uart-routing.c b/drivers/soc/aspeed/aspeed-uart-routing.c
index ef8b24fd1851..8c89ad312c1d 100644
--- a/drivers/soc/aspeed/aspeed-uart-routing.c
+++ b/drivers/soc/aspeed/aspeed-uart-routing.c
@@ -5,8 +5,7 @@
  */
 #include <linux/device.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 #include <linux/platform_device.h>
-- 
2.40.1

