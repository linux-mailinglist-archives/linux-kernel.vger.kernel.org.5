Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD986800986
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378509AbjLALP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378500AbjLALPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:15:18 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460B0D40;
        Fri,  1 Dec 2023 03:15:24 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5247320003;
        Fri,  1 Dec 2023 11:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701429323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F1EYqlVYF1fJ33cC2a0Mertg3uhTJJ/NIkImZDHepJg=;
        b=cEZ5o9uE4LGZadkuuOwl7fpkiHQMqA5b9yqsgl0WwlC0M1iAy6RmUmdRdnuBUOSzBUAXea
        KiAxdemJDnWFYWQRriqNHStSr7XI2UEHimmAda6VwMKahRtiTf3qYMkIkJjOdXlOQFe8sL
        UeRHFy3NfnhiD7xlWQBogldRxQ2IIKkySiQU4MkSEW2we3Ix7nHzoSfAnjRUnfzKrcriMF
        Od/3ekaGRsWjkDqNnXwHj0Udcq8nyW4BLgZCWSbQ5dxqPBUeOsT4Gz/YM8XAnLOqIswhrS
        4YE75U9qK2CHBaViRfv6llhlTkyTjVQ32elD/2YnUTPhiXqLcNxFvo/NNJ/A5w==
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
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH v3 01/22] MIPS: compressed: Use correct instruction for 64 bit code
Date:   Fri,  1 Dec 2023 12:14:44 +0100
Message-ID: <20231201111512.803120-2-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201111512.803120-1-gregory.clement@bootlin.com>
References: <20231201111512.803120-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The code clearing BSS already use macro or use correct instruction
depending if the CPU is 32 bits or 64 bits. However, a few
instructions remained 32 bits only.

By using the accurate MACRO, it is now possible to deal with memory
address beyond 32 bits. As a side effect, when using 64bits processor,
it also divides the loop number needed to clear the BSS by 2.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/mips/boot/compressed/head.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/boot/compressed/head.S b/arch/mips/boot/compressed/head.S
index 5795d0af1e1b2..d237a834b85ee 100644
--- a/arch/mips/boot/compressed/head.S
+++ b/arch/mips/boot/compressed/head.S
@@ -25,8 +25,8 @@
 	/* Clear BSS */
 	PTR_LA	a0, _edata
 	PTR_LA	a2, _end
-1:	sw	zero, 0(a0)
-	addiu	a0, a0, 4
+1:	PTR_S	zero, 0(a0)
+	PTR_ADDIU a0, a0, PTRSIZE
 	bne	a2, a0, 1b
 
 	PTR_LA	a0, (.heap)	     /* heap address */
-- 
2.42.0

