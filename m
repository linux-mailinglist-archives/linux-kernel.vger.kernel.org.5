Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EBF76435D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 03:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjG0BUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 21:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjG0BUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 21:20:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8193CA3;
        Wed, 26 Jul 2023 18:20:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1788461CE6;
        Thu, 27 Jul 2023 01:20:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 228DBC433C7;
        Thu, 27 Jul 2023 01:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690420848;
        bh=V9RQoD3GdgkmyIdiyKx+50kQLweqOpaZwUHyRYOloZY=;
        h=From:To:Cc:Subject:Date:From;
        b=BdGNu3ARrlkaP+iMKnBbg9T35KACQM8jWbXvYxYUIIgBsFQPmId9Zp6Kd6o1kwJ5l
         SKR9vFtLwl0a6D+F4keqHMC8CzRJS4OSUntkVeSzfkcFpB/nS4iUaHBr9ojIo7l0HX
         8tAxK8BeUkhgTYDGBNlGu0sU8CT5PpgEoTkpd8ttSCKjJQcqJx5BNe+9Pa/kvrusj/
         5TNk6fABzlqREDmOXZKDiBMF5s8OkSEx/pU5jlkymLzZoosWJsBdq2JUvq6hLu7PjL
         1E80LPJj5fbF649KVF2ON+sY7G08/VJsy9KrrGyleHOHrY8UHyDaoFdh7AB97PLHVA
         tANd7ik+nlraQ==
Received: (nullmailer pid 3934187 invoked by uid 1000);
        Thu, 27 Jul 2023 01:20:46 -0000
From:   Rob Herring <robh@kernel.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        John Crispin <john@phrozen.org>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: More explicit DT include clean-ups
Date:   Wed, 26 Jul 2023 19:20:39 -0600
Message-Id: <20230727012040.3934021-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple more clean-ups in the MIPS code.

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
I've now built all MIPS defconfigs in my tree which removes the implicit
includes. So I found a few more fixes. This can be squashed into the
previous commit if desired.
---
 arch/mips/cavium-octeon/octeon-platform.c | 2 ++
 arch/mips/cavium-octeon/octeon-usb.c      | 2 ++
 arch/mips/ralink/ill_acc.c                | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index ce05c0dd3acd..60da1b2091f5 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -8,8 +8,10 @@
  */
 
 #include <linux/etherdevice.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/of_fdt.h>
+#include <linux/platform_device.h>
 #include <linux/libfdt.h>
 
 #include <asm/octeon/octeon.h>
diff --git a/arch/mips/cavium-octeon/octeon-usb.c b/arch/mips/cavium-octeon/octeon-usb.c
index 2add435ad038..add0f23592b3 100644
--- a/arch/mips/cavium-octeon/octeon-usb.c
+++ b/arch/mips/cavium-octeon/octeon-usb.c
@@ -15,7 +15,9 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 
 /*
  * USB Control Register
diff --git a/arch/mips/ralink/ill_acc.c b/arch/mips/ralink/ill_acc.c
index f395ae218470..25341b2319d0 100644
--- a/arch/mips/ralink/ill_acc.c
+++ b/arch/mips/ralink/ill_acc.c
@@ -5,8 +5,10 @@
  */
 
 #include <linux/interrupt.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/of_irq.h>
+#include <linux/platform_device.h>
 
 #include <asm/mach-ralink/ralink_regs.h>
 
-- 
2.40.1

