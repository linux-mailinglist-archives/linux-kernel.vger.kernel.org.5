Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BC97F62D3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346111AbjKWP1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346120AbjKWP07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:26:59 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1E710DD;
        Thu, 23 Nov 2023 07:27:02 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7A11740006;
        Thu, 23 Nov 2023 15:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700753220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GhAHp/WqUVYuPSI+XZI84BEZNCI93fSEr9ostuA7S3A=;
        b=TueHfQu03SEyVHx3lV5K7yzAtdC7P3Mdc6pE3OhcGReI+OOaHzPv81zZDxcAHpR35bRob9
        ulF1v9Xl8kC0HHEKppienSZQhoHu0ydwQYwGMHMWWNxxbUJ7Y0xJtrTmlYwfRZdG5sbH5B
        EgsGN6rX1MlfaaysEzj4v0o93vrik0gOkvGsE0jS9+KKOBB1Qpn35n0uDokZBUGeRPE+bR
        xMot03qv4MGksrHFJj58zT+D1MfbAEVGkeklyZY1b/sNdkuA103VmVv5gNukC+8V9uavX0
        4OGXu0Wbv3nCg8avV3hqcbOwneraRnfvSaHWlo8v1Og51PFPiFEsOfs7FBGe0Q==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 08/21] MIPS: Allow kernel base to be set from Kconfig for all platforms
Date:   Thu, 23 Nov 2023 16:26:25 +0100
Message-ID: <20231123152639.561231-9-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231123152639.561231-1-gregory.clement@bootlin.com>
References: <20231123152639.561231-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

There are some platforms in wild that generic loading address won't
work with them due to memory layout.

Allow PHYSICAL_START to be override from Kconfig, introduce
PHYSICAL_START_BOOL symbol as powerpc did.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 76db82542519c..f7fa4f231c6c6 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2862,12 +2862,22 @@ config ARCH_SUPPORTS_KEXEC
 config ARCH_SUPPORTS_CRASH_DUMP
 	def_bool y
 
+config PHYSICAL_START_BOOL
+	bool "Set physical address where the kernel is loaded"
+	default y if CRASH_DUMP
+	help
+	  This gives the CKSEG0, KSEG0 or XKPHYS address where the kernel
+	  is loaded.
+
+	  Say N here unless you know what you are doing.
+
 config PHYSICAL_START
-	hex "Physical address where the kernel is loaded"
-	default "0xffffffff84000000"
-	depends on CRASH_DUMP
+	hex "Physical address where the kernel is loaded" if PHYSICAL_START_BOOL
+	default "0xffffffff84000000" if CRASH_DUMP
+	default "0xffffffff80100000"
 	help
-	  This gives the CKSEG0 or KSEG0 address where the kernel is loaded.
+	  This gives the CKSEG0, KSEG0 or XKPHYS address where the kernel
+	  is loaded.
 	  If you plan to use kernel for capturing the crash dump change
 	  this value to start of the reserved region (the "X" value as
 	  specified in the "crashkernel=YM@XM" command line boot parameter
-- 
2.42.0

