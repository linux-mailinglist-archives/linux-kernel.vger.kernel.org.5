Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEB58009B0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378691AbjLALPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378515AbjLALPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:15:24 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6AC10FC;
        Fri,  1 Dec 2023 03:15:28 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EB6E024000A;
        Fri,  1 Dec 2023 11:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701429326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p5Y4+QQx6IQCL0sfRkqEobRfltIrsUFlmPw44Fo9wsE=;
        b=hk1EPBxxfDuPRzao8dYSg9XjL+82XECa5mha/s8D7odiVcFQjquvJ3U14VjT49wpLmmkv3
        /feO+rjiGPq54X/fc0IrKYMitvllF6vnYmb1uoOJJqFSZBLMpsOzmQkme/VJMT/KYIgVsm
        D7KHq2QfS/qZQtRMBKO3IjIa57GYXjhzjEdHAPGi7Thn4IUmxDA6gxtnyhag0QNfQg/9GE
        f7ztQY5GnLgI0PClHxacQC9T2aqqNxl9+XrWbelK5Hi14PZnpSEXl2XFjZxpwTrYTJ0Qqu
        dg/wcjEtjn41Jz4Olzu9g+6mCvrGS2FD/1sQc/NUoOVFpcl0sBY3QlOJJGxTCQ==
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
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH v3 05/22] MIPS: Fix set_uncached_handler for ebase in XKPHYS
Date:   Fri,  1 Dec 2023 12:14:48 +0100
Message-ID: <20231201111512.803120-6-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201111512.803120-1-gregory.clement@bootlin.com>
References: <20231201111512.803120-1-gregory.clement@bootlin.com>
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

ebase may be in XKPHYS if memblock unable to allocate memory
within KSEG0 physical range.

To map ebase into uncached space we just convert it back to
physical address and then use platform's TO_UNCAC helper
to create mapping.

Co-developed-by: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Co-developed-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/mips/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 60c513c51684f..230728d76d11f 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -2346,7 +2346,7 @@ static const char panic_null_cerr[] =
 void set_uncached_handler(unsigned long offset, void *addr,
 	unsigned long size)
 {
-	unsigned long uncached_ebase = CKSEG1ADDR(ebase);
+	unsigned long uncached_ebase = TO_UNCAC(__pa(ebase));
 
 	if (!addr)
 		panic(panic_null_cerr);
-- 
2.42.0

