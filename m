Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795AA80F320
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbjLLQgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235047AbjLLQfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:35:32 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4435E113;
        Tue, 12 Dec 2023 08:35:36 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6CB22FF817;
        Tue, 12 Dec 2023 16:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1702398934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7XY5RosXYCLwcWB1g4w/xI8Tyluf+oMKzZZFQCrss2s=;
        b=YbcdPJ4zbavgv4jdwBSz0ZDghLADAlyp17PeUykF/oogpxrztDatpkFG9+jDAu6NO/WL+C
        Qjr58YFL2xpy7DS10OV2aytcLP3Gv1bk9NUgh4U2Hlvya3glyMpNge9OJyunPYyNCuI/KY
        aPZ+KflXA9kcjQg9AVQFdRuq2wjxhgmUIum+hmyUVJrQVSj/YWSqmoQvTAo+NuaeC4nlnA
        t08SySZ4cau+sgrdudi5CI6ki9Fr7c1LYOzuwFcBBmLB0FmHBlEnpqw/XtkIzgsSfMKTRo
        KXBYMdbYwWweEB+48LtTqm8t8yTqEqC/sjyzdRJq+RysWmVJWR4zzvcX9hY9kw==
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
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH v5 13/22] MIPS: traps: Give more explanations if ebase doesn't belong to KSEG0
Date:   Tue, 12 Dec 2023 17:34:45 +0100
Message-ID: <20231212163459.1923041-14-gregory.clement@bootlin.com>
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

With the expanded support for placing the kernel in XPHYS rather than
just KSEG0, scenarios where ebase doesn't belong to KSEG0 are more
likely to occur. In such cases, we currently experience a substantial
and perplexing stack dump without any accompanying explanation. To
rectify this, we aim to replace the uninformative stack dump with a
warning that offers a clear explanation of the issue.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/mips/kernel/traps.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 089247555c752..67c7c23fe4f73 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -2420,10 +2420,13 @@ void __init trap_init(void)
 		 * EVA is special though as it allows segments to be rearranged
 		 * and to become uncached during cache error handling.
 		 */
-		if (!IS_ENABLED(CONFIG_EVA) && !WARN_ON(ebase_pa >= 0x20000000))
+		if (!IS_ENABLED(CONFIG_EVA) && ebase_pa < 0x20000000)
 			ebase = CKSEG0ADDR(ebase_pa);
 		else
 			ebase = (unsigned long)phys_to_virt(ebase_pa);
+		if (ebase_pa >= 0x20000000)
+			pr_warn("ebase(%pa) should better be in KSeg0",
+				&ebase_pa);
 	}
 
 	if (cpu_has_mmips) {
-- 
2.42.0

