Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CA275701F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjGQXAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjGQXAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:00:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8C6198A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 15:59:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2AE4612B4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 22:59:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90C3C433C8;
        Mon, 17 Jul 2023 22:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689634765;
        bh=59X3yR/EgoAgz3Bwg/uGveK+/kUZJPeJEkI0bce8PH0=;
        h=From:To:Cc:Subject:Date:From;
        b=Evr8V0aHxUcMHX6RTsprPl0j9IxHvVbeJY7/iJGy/YVjzkYVrXcujcbvfsfFI/fys
         /QY+Icwoubh28+VOGYIvLHKnUYKivsyE8Igcf+Rm6iHs8PXkV1PGKAVCtLUt+0/NiC
         aRq8xDujB7mlkG9TY4HnrGBq17NtjNnJAQuz4ieFxhabi80vtI3KSAyRJSOtLKzO0X
         vCGvsQJyzNpAb0G0PpyUm+nXw4AlDIphysbV57nwc+VA8xiEeH63CjRLoaOTruHtPt
         MPg3FOAG7ef1oJ7cvq7X17pqFofhcMEf3xexF9iIvVVh0jNHAJhuSYV3sF1wjmGcx8
         /lcfUwtPvQoJQ==
Received: (nullmailer pid 3211693 invoked by uid 1000);
        Mon, 17 Jul 2023 22:54:44 -0000
From:   Rob Herring <robh@kernel.org>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: socfpga: Explicitly include correct DT includes
Date:   Mon, 17 Jul 2023 16:54:40 -0600
Message-Id: <20230717225440.3211576-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it was merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

A couple of other includes are unused and can be dropped too.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-socfpga/l2_cache.c | 2 +-
 arch/arm/mach-socfpga/ocram.c    | 4 +---
 arch/arm/mach-socfpga/pm.c       | 2 ++
 arch/arm/mach-socfpga/socfpga.c  | 4 +---
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-socfpga/l2_cache.c b/arch/arm/mach-socfpga/l2_cache.c
index 99fb95361590..86e011eeb444 100644
--- a/arch/arm/mach-socfpga/l2_cache.c
+++ b/arch/arm/mach-socfpga/l2_cache.c
@@ -3,7 +3,7 @@
  * Copyright Altera Corporation (C) 2016. All rights reserved.
  */
 #include <linux/io.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
 
 #include "core.h"
diff --git a/arch/arm/mach-socfpga/ocram.c b/arch/arm/mach-socfpga/ocram.c
index b4d397e834a0..9f1a249debf6 100644
--- a/arch/arm/mach-socfpga/ocram.c
+++ b/arch/arm/mach-socfpga/ocram.c
@@ -4,10 +4,8 @@
  */
 #include <linux/delay.h>
 #include <linux/io.h>
-#include <linux/genalloc.h>
-#include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_platform.h>
 
 #include "core.h"
 
diff --git a/arch/arm/mach-socfpga/pm.c b/arch/arm/mach-socfpga/pm.c
index 365c0428b21b..ab1c08f971f0 100644
--- a/arch/arm/mach-socfpga/pm.c
+++ b/arch/arm/mach-socfpga/pm.c
@@ -13,7 +13,9 @@
 #include <linux/genalloc.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/suspend.h>
 #include <asm/suspend.h>
 #include <asm/fncpy.h>
diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index 9e4cb2ffd580..4332af2d8b86 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -3,13 +3,11 @@
  *  Copyright (C) 2012-2015 Altera Corporation
  */
 #include <linux/irqchip.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/of_platform.h>
 #include <linux/reboot.h>
 #include <linux/reset/socfpga.h>
 
-#include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/cacheflush.h>
-- 
2.40.1

