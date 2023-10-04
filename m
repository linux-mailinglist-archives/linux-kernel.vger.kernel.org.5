Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E407B8498
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243279AbjJDQLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243244AbjJDQK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:10:56 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A47C0;
        Wed,  4 Oct 2023 09:10:52 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D2623E0006;
        Wed,  4 Oct 2023 16:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696435851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VOjmWr0mfjgBp7nTWHYGPwk6e22EOwSF4b0ZHDI/Irc=;
        b=mK6smk9vHL4Vz1l1in2vpkrJfRKPFK5FWJ/iGAp0VFPia3gMZAa1jSIoybLSXms4wEB9+5
        EuY4Q042RL7K5FRQZieMtyubzN4Fvnyr8/udm4tmIqYNj91o0GAEaa9MN/80cprFJd0iYF
        tAT2DermcTvyHEMy2rrieelCWPFbTM/2D6JBQtyGWdjWdEg+AbBo8u6whRPOfBY9gI1LU4
        EH5/7oXEYrasvjmvAxcI+ePVL6Hhe3PLrPI8cotMRE85SvO1BInV+MG/6j8olGOfNSMv5j
        ukHuI4V3mIF/9845SJCizcDJC74Z2HatyWu561L7nvPkKRTrQRMD21BgbOKPNw==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH 03/11] MIPS: support RAM beyond 32-bit
Date:   Wed,  4 Oct 2023 18:10:30 +0200
Message-Id: <20231004161038.2818327-4-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004161038.2818327-1-gregory.clement@bootlin.com>
References: <20231004161038.2818327-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>

Support platforms where RAM is mapped beyond 32-bit.

The kernel parameter ddr32_alias allows to setup the alias to point
outside the first 4 GB of memory.

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/mips/kernel/smp-cps.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 47e76722a306..fcfb19487612 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -34,6 +34,16 @@ static unsigned __init core_vpe_count(unsigned int cluster, unsigned core)
 	return min(smp_max_threads, mips_cps_numvps(cluster, core));
 }
 
+static int ddr32_alias;
+
+static int __init ddr32_alias_setup(char *str)
+{
+	get_option(&str, &ddr32_alias);
+
+	return 0;
+}
+early_param("ddr32_alias", ddr32_alias_setup);
+
 /**
  * plat_core_entry - query reset vector for NMI/reset
  *
@@ -52,7 +62,7 @@ static u32 plat_core_entry(void)
 {
 #if defined(CONFIG_USE_XKPHYS)
 	return (UNCAC_ADDR(mips_cps_core_entry) & 0xffffffff)
-			| CM_GCR_Cx_RESET_BASE_MODE;
+			| ddr32_alias | CM_GCR_Cx_RESET_BASE_MODE;
 #else
 	return CKSEG1ADDR((unsigned long)mips_cps_core_entry);
 #endif
-- 
2.40.1

