Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA86A7541CB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236218AbjGNRyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236728AbjGNRyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:54:17 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E923AA0;
        Fri, 14 Jul 2023 10:53:47 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3476c902f2aso9335525ab.3;
        Fri, 14 Jul 2023 10:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689357157; x=1691949157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IChM5VW1fCXIB3XDIWtNLNdMHW1npRKtBf3BFrldOoY=;
        b=FyZnbGPiwzFPXtZo0PyhDBtGMVBSn+3UitO3WjM7aF3fymlvjvVBVl8aKIenQwHvjt
         qxMK7fzjVdvVJs9t62xTVc/1pM7CsiFeC39Ky16LgKNNkGbumEvgy56An0pc9Hc8AS3I
         oLrwOFqaSVdDSm/fhViGL4OQ8PTaWbwjYmhYlsTUo4ZWeWsExshCQsOIglA4YOtkaXlo
         Fq6ssL+XjtfD0qNxDgeyvPUyDVWEnFk+RZSV4Ed7dSzmfiYDHJrZhAfQ1AxMbpnIyG/u
         cVf9zfeeTwlG6SkhRYdGuP1jhF+fXJFwO1LGptSSiW4hKMjY7kpcb2PkjJiZ0mY0iNQe
         xPDA==
X-Gm-Message-State: ABy/qLbOUR25IXpSEfZ1vQOTWpQPSy0Z+aJhp9oewVoAzyKKxT0gcBOu
        vFBKpJRUwShh8L9tsNOGtGr5W3HqizUI
X-Google-Smtp-Source: APBJJlGOAJHqjDjAYP4ZAPvrz89fYULiALUMkOz67NTDYOuJVqkzKRs4wstt/I43GM14uLGGeWp+1w==
X-Received: by 2002:a92:c945:0:b0:346:779a:ff70 with SMTP id i5-20020a92c945000000b00346779aff70mr4771909ilq.28.1689357156706;
        Fri, 14 Jul 2023 10:52:36 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id d6-20020a02a486000000b0042b0ce92dddsm2633293jam.161.2023.07.14.10.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:52:36 -0700 (PDT)
Received: (nullmailer pid 4068477 invoked by uid 1000);
        Fri, 14 Jul 2023 17:51:56 -0000
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] soc: tegra: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:51:54 -0600
Message-Id: <20230714175155.4068413-1-robh@kernel.org>
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
 drivers/soc/tegra/cbb/tegra-cbb.c     | 4 ----
 drivers/soc/tegra/cbb/tegra194-cbb.c  | 4 +---
 drivers/soc/tegra/cbb/tegra234-cbb.c  | 3 ---
 drivers/soc/tegra/fuse/fuse-tegra20.c | 2 +-
 drivers/soc/tegra/fuse/fuse-tegra30.c | 2 --
 5 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/soc/tegra/cbb/tegra-cbb.c b/drivers/soc/tegra/cbb/tegra-cbb.c
index bd96204a68ee..be76c6aa131c 100644
--- a/drivers/soc/tegra/cbb/tegra-cbb.c
+++ b/drivers/soc/tegra/cbb/tegra-cbb.c
@@ -7,13 +7,9 @@
 #include <linux/cpufeature.h>
 #include <linux/debugfs.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/device.h>
 #include <linux/io.h>
-#include <linux/of_irq.h>
-#include <linux/of_address.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <soc/tegra/fuse.h>
diff --git a/drivers/soc/tegra/cbb/tegra194-cbb.c b/drivers/soc/tegra/cbb/tegra194-cbb.c
index 54d7ce05c636..cf6886f362d3 100644
--- a/drivers/soc/tegra/cbb/tegra194-cbb.c
+++ b/drivers/soc/tegra/cbb/tegra194-cbb.c
@@ -15,12 +15,10 @@
 #include <linux/debugfs.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/device.h>
 #include <linux/io.h>
-#include <linux/of_irq.h>
-#include <linux/of_address.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <soc/tegra/fuse.h>
diff --git a/drivers/soc/tegra/cbb/tegra234-cbb.c b/drivers/soc/tegra/cbb/tegra234-cbb.c
index 5d16161b2566..5cf0e8c34164 100644
--- a/drivers/soc/tegra/cbb/tegra234-cbb.c
+++ b/drivers/soc/tegra/cbb/tegra234-cbb.c
@@ -16,12 +16,9 @@
 #include <linux/debugfs.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/device.h>
 #include <linux/io.h>
-#include <linux/of_irq.h>
-#include <linux/of_address.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <soc/tegra/fuse.h>
diff --git a/drivers/soc/tegra/fuse/fuse-tegra20.c b/drivers/soc/tegra/fuse/fuse-tegra20.c
index 12503f563e36..fdecf7b7c246 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra20.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra20.c
@@ -14,7 +14,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/kobject.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/random.h>
diff --git a/drivers/soc/tegra/fuse/fuse-tegra30.c b/drivers/soc/tegra/fuse/fuse-tegra30.c
index c759fb7c8adc..e94d46372a63 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra30.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra30.c
@@ -10,8 +10,6 @@
 #include <linux/kernel.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/nvmem-provider.h>
-#include <linux/of_device.h>
-#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/random.h>
-- 
2.40.1

