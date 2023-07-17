Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03C6757028
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjGQXA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjGQXAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:00:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC60219A1;
        Mon, 17 Jul 2023 16:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D3F6612E4;
        Mon, 17 Jul 2023 22:59:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBBBC433C8;
        Mon, 17 Jul 2023 22:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689634797;
        bh=f4dpWd1j2PaSct6KkkWMV6D3aNGQhrnp1Irz3n7TOxo=;
        h=From:To:Cc:Subject:Date:From;
        b=ZF/V9Rh76Uvzf5bLkDsX24rckkexgIKjmNcJnH6XqXWX18l5UZpOgWdjNDld3qNBU
         u67beRicWG5tR1H4XZxwfWEJXLYGQKGvG+75ud2Kgwk/B0YeCtLBckRZl2zB/x5ypz
         wsJzgOZymTf5njooRRc9XAizbOg4vK/gYEaFb8z0XKE+TMQgfrBbwnJwpIZQpiMHt6
         HvFDKAq+h+59nFh9HWF9pjQuqkLj0UCN7rXnv5eH0YVnDGC1rnwvQmBelALxuF/E2m
         oy+04VYNVQQuBJxBEYPreftMWNQ9ELMpV2iy3D0D50sfz4zmznMPsbUzLFatEMsLZT
         /JI0Fq/8r4/Sg==
Received: (nullmailer pid 3211975 invoked by uid 1000);
        Mon, 17 Jul 2023 22:54:54 -0000
From:   Rob Herring <robh@kernel.org>
To:     Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: omap2: Explicitly include correct DT includes
Date:   Mon, 17 Jul 2023 16:54:52 -0600
Message-Id: <20230717225452.3211901-1-robh@kernel.org>
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

