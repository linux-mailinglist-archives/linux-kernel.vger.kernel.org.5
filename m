Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0160B80F31A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376329AbjLLQgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbjLLQf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:35:26 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAB0115;
        Tue, 12 Dec 2023 08:35:32 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A86D2FF81C;
        Tue, 12 Dec 2023 16:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1702398931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Hs8erXZl4NlWl7+f8VZWG3NaOSPZoMSP8HqcLsJyRM=;
        b=obJtsQ/LHcmycBwrOwk4+lNBMUbkfe7xBCh1X6nSMCVKfdqaokSlUAR6jnhZTxNTDT63Tp
        fRw1gWxHEtB0HO4Mbg52NgKSt+KIMV5iXhOc0uUrO5KTADI8e8qkftwCxVD7erTkaNUCOC
        q7BVeaV0BgK7SRoT9CaYql+kDxgmODUYXiXfQS+Pz+3Z5aib0vw5GYYhVnwfYH/z2cMPlR
        q0gNU4GLFWZLejxjLwwP3uuZ4K/bkLPS/RS43MQAgkYdOvhGOf7Drf+/5UjqYEUuEZ9AuT
        LZ0hbzIKHozNBgXXbQ3Q4yq70uQTU4irE0Oebaz+PsM3jONMNWm5sNBEf4vGMQ==
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
Subject: [PATCH v5 08/22] MIPS: Allow kernel base to be set from Kconfig for all platforms
Date:   Tue, 12 Dec 2023 17:34:40 +0100
Message-ID: <20231212163459.1923041-9-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231212163459.1923041-1-gregory.clement@bootlin.com>
References: <20231212163459.1923041-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 2480a2cdddf1e..518376d578b70 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2868,12 +2868,22 @@ config ARCH_SUPPORTS_KEXEC
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

