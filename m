Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A207B8494
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243264AbjJDQLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbjJDQKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:10:53 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28DA9B;
        Wed,  4 Oct 2023 09:10:49 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7777260003;
        Wed,  4 Oct 2023 16:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696435847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zphNeuBKwavuluA4nnf6uDnS6Nyy4EaH0fzXUOIOYYM=;
        b=KjEvbUqbKE+hHhimKQB2sEaTSSYifdMqsGRX4SqNqrUjX519Vc6KBUKo19UhOljwZBgDb2
        WxnVeMUtcmIGODBEKzBQlEsj13mE/0YtMStD1yOnsnNOZxotHBQPcK2HN/4T2F+Mfxg1Qs
        ZuessHwlQ8gvAPtXqHocasvgOop1Mo5RaJqIEQc+TmWOGfQGbiyHWDD5O/bHbmxlzceM7Q
        vsrY+aCIh6ITSRUeLsYFy+BnVsLxU3DiFyl+a4T0NJ02aSrz7IvgE6saVuF0R4o0DTY4Lo
        0HRtVkGXQ1jMMMyri5AfB3mPBmKS9Eo1TuPhPpVMCZ3womA04etm3tpbrlsMUw==
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
Subject: [PATCH 01/11] MIPS: compressed: Use correct instruction for 64 bit code
Date:   Wed,  4 Oct 2023 18:10:28 +0200
Message-Id: <20231004161038.2818327-2-gregory.clement@bootlin.com>
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

The code clearing BSS already use macro or use correct instruction
depending id the CPU is 32 bits or 64 bits. However, a few
instructions remained 32 bits only.

By using the accurate MACRO, it is now possible to deal with memory
address beyond 32 bits. As a side effect, when using 64bits processor,
it also divides the loop number needed to clear the BSS by 2.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/mips/boot/compressed/head.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/boot/compressed/head.S b/arch/mips/boot/compressed/head.S
index 5795d0af1e1b..d237a834b85e 100644
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
2.40.1

