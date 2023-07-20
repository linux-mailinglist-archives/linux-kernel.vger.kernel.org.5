Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF2675B59A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjGTR2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbjGTR1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:27:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6F51BF7;
        Thu, 20 Jul 2023 10:27:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 429C361BA7;
        Thu, 20 Jul 2023 17:27:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DAFEC433C8;
        Thu, 20 Jul 2023 17:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689874070;
        bh=1kh3ObTlvQNgnJvRmUsZj0kR/MmUDHQVLFfUagMOtjc=;
        h=From:To:Cc:Subject:Date:From;
        b=QD6XaiB2AWs/f/7Jh0I+EUpKz6saq19ntzsrNtrBCdFajZ1t4oId3GCfYQJZaLVtd
         XG98Ga+5xavB1sdYbbrAb5kAP94SsGvo8sFc2Bf5uG7GxuKI9nhv8/8yTUPUlcj0r9
         Vji9FCrKKR6HoCabeZqqVL/au3URjV5iY6N1K5XUYO9M7bCftM7c4RC3Xb7dEPAKhx
         CcyM3Ye49OIPKCnonjrSS+xJkli2poy8/PoSwkzuxM7B184+K/HzfTqy7Qr1f7DCe/
         9mIrT0eVwxw0Zb7bn7GkqqCkag6uKEwPspbAgxq2/scyB66vCzaTiyuk95vL+hL/7A
         88pea1gAPkVcA==
Received: (nullmailer pid 2918734 invoked by uid 1000);
        Thu, 20 Jul 2023 17:27:49 -0000
From:   Rob Herring <robh@kernel.org>
To:     Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: omap2: Explicitly include correct DT includes
Date:   Thu, 20 Jul 2023 11:27:43 -0600
Message-Id: <20230720172743.2918601-1-robh@kernel.org>
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

Signed-off-by: Rob Herring <robh@kernel.org>
---
v2: Add missing Sob
---
 arch/arm/mach-omap2/board-generic.c | 3 +--
 arch/arm/mach-omap2/omap4-common.c  | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 10d2f078e4a8..fde6ccb3df6e 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -9,11 +9,10 @@
  * to support the OMAP2+ device tree boards with an unique board file.
  */
 #include <linux/io.h>
-#include <linux/of_irq.h>
-#include <linux/of_platform.h>
 #include <linux/irqdomain.h>
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
+#include <linux/mod_devicetable.h>
 
 #include <asm/setup.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index d9ed2a5dcd5e..5d924b85b694 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -12,10 +12,9 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
-#include <linux/platform_device.h>
 #include <linux/memblock.h>
+#include <linux/of.h>
 #include <linux/of_irq.h>
-#include <linux/of_platform.h>
 #include <linux/export.h>
 #include <linux/irqchip/arm-gic.h>
 #include <linux/of_address.h>
-- 
2.40.1

