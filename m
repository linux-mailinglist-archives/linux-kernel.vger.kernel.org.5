Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6750C7F928E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 13:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjKZMSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 07:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKZMSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 07:18:20 -0500
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C1DDE
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 04:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1701001106;
        bh=Pp0VZl6n2le2LRNzVsUDddKmd4rLblALXSs+e/wVaNU=;
        h=From:To:Cc:Subject:Date:From;
        b=e19O/nzCGeMeuHB9xEiBiD5Ghr6iOhakbu7rdIEirCFZtleX1bZihbEuQMkx1apRy
         ATuSC50NTFlY6SKT4fJQK/xQYjxHcmfNaoYQ9vb0Fu8McYJXGN3p1ul6KvO4XJxKgW
         nO4jy7CLVRJCkqpf4WTRYj9yPjEgfIZWTwudsUlQ=
Received: from stargazer.. (unknown [124.115.222.149])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id B2ED866B39;
        Sun, 26 Nov 2023 07:18:24 -0500 (EST)
From:   Xi Ruoyao <xry111@xry111.site>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH] LoongArch: Slightly clean up drdtime
Date:   Sun, 26 Nov 2023 20:17:28 +0800
Message-ID: <20231126121727.47303-2-xry111@xry111.site>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we are just discarding the stable clock ID, simply write it into
$zero instead of allocating a temporary register.

Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/loongarch/include/asm/loongarch.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
index 9b4957cefa8a..46366e783c84 100644
--- a/arch/loongarch/include/asm/loongarch.h
+++ b/arch/loongarch/include/asm/loongarch.h
@@ -1098,12 +1098,11 @@
 
 static __always_inline u64 drdtime(void)
 {
-	int rID = 0;
 	u64 val = 0;
 
 	__asm__ __volatile__(
-		"rdtime.d %0, %1 \n\t"
-		: "=r"(val), "=r"(rID)
+		"rdtime.d %0, $zero\n\t"
+		: "=r"(val)
 		:
 		);
 	return val;
-- 
2.43.0

