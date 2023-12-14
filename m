Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAB48130D7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573192AbjLNNCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573266AbjLNNCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:02:25 -0500
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F352B192
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1702558942;
        bh=nd5y1bL1sccRJEldkma74vvWmJtxp5dwr9ST+xGLvJY=;
        h=From:To:Cc:Subject:Date:From;
        b=hE774fyzx14VKgovBrO0RjwY9yWNcBPXpDPgJm3dEjPJU8P1dIN93JDC2v2BaJ8ei
         lU2LYBQergZegfrWlMi4yBzAh35V0KYBGmGokoZ7Y2LjQCdkN88MI/OwqfLpMf76JD
         +b0kN6LLS1ZvYt/iab8HI+rb34RYVl5gX8Pqu+I0=
Received: from stargazer.. (unknown [113.200.174.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 8563C66B90;
        Thu, 14 Dec 2023 08:02:21 -0500 (EST)
From:   Xi Ruoyao <xry111@xry111.site>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH] LoongArch: Micro-optimize sc_save_fcc and sc_restore_fcc for LA464
Date:   Thu, 14 Dec 2023 21:02:06 +0800
Message-ID: <20231214130206.21219-1-xry111@xry111.site>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On LA464 movcf2gr is 7 times slower than movcf2fr + movfr2gr, and
movgr2cf is 15 times (!) slower than movgr2fr + movfr2cf.

On LA664 movcf2fr + movfr2gr has a similar performance with movcf2gr,
and movgr2fr + movfr2cf has a similar performance with movgr2cf.

To use FP registers in sc_save_fcc and sc_restore_fcc we need to save
FP/LSX/LASX registers before sc_save_fcc, and restore FP/LSX/LASX
registers after sc_restore_fcc.

Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/loongarch/kernel/fpu.S | 94 +++++++++++++++++++++----------------
 1 file changed, 54 insertions(+), 40 deletions(-)

diff --git a/arch/loongarch/kernel/fpu.S b/arch/loongarch/kernel/fpu.S
index d53ab10f4644..ecb127f9a673 100644
--- a/arch/loongarch/kernel/fpu.S
+++ b/arch/loongarch/kernel/fpu.S
@@ -96,43 +96,57 @@
 	.endm
 
 	.macro sc_save_fcc base, tmp0, tmp1
-	movcf2gr	\tmp0, $fcc0
-	move		\tmp1, \tmp0
-	movcf2gr	\tmp0, $fcc1
-	bstrins.d	\tmp1, \tmp0, 15, 8
-	movcf2gr	\tmp0, $fcc2
-	bstrins.d	\tmp1, \tmp0, 23, 16
-	movcf2gr	\tmp0, $fcc3
-	bstrins.d	\tmp1, \tmp0, 31, 24
-	movcf2gr	\tmp0, $fcc4
-	bstrins.d	\tmp1, \tmp0, 39, 32
-	movcf2gr	\tmp0, $fcc5
-	bstrins.d	\tmp1, \tmp0, 47, 40
-	movcf2gr	\tmp0, $fcc6
-	bstrins.d	\tmp1, \tmp0, 55, 48
-	movcf2gr	\tmp0, $fcc7
-	bstrins.d	\tmp1, \tmp0, 63, 56
-	EX	st.d	\tmp1, \base, 0
+	movcf2fr	ft0, $fcc0
+	movcf2fr	ft1, $fcc1
+	movfr2gr.s	\tmp0, ft0
+	movfr2gr.s	\tmp1, ft1
+	EX  st.b	\tmp0, \base, 0
+	EX  st.b	\tmp0, \base, 8
+	movcf2fr	ft0, $fcc2
+	movcf2fr	ft1, $fcc3
+	movfr2gr.s	\tmp0, ft0
+	movfr2gr.s	\tmp1, ft1
+	EX  st.b	\tmp0, \base, 16
+	EX  st.b	\tmp0, \base, 24
+	movcf2fr	ft0, $fcc3
+	movcf2fr	ft1, $fcc4
+	movfr2gr.s	\tmp0, ft0
+	movfr2gr.s	\tmp1, ft1
+	EX  st.b	\tmp0, \base, 32
+	EX  st.b	\tmp0, \base, 40
+	movcf2fr	ft0, $fcc5
+	movcf2fr	ft1, $fcc6
+	movfr2gr.s	\tmp0, ft0
+	movfr2gr.s	\tmp1, ft1
+	EX  st.b	\tmp0, \base, 48
+	EX  st.b	\tmp0, \base, 56
 	.endm
 
 	.macro sc_restore_fcc base, tmp0, tmp1
-	EX	ld.d	\tmp0, \base, 0
-	bstrpick.d	\tmp1, \tmp0, 7, 0
-	movgr2cf	$fcc0, \tmp1
-	bstrpick.d	\tmp1, \tmp0, 15, 8
-	movgr2cf	$fcc1, \tmp1
-	bstrpick.d	\tmp1, \tmp0, 23, 16
-	movgr2cf	$fcc2, \tmp1
-	bstrpick.d	\tmp1, \tmp0, 31, 24
-	movgr2cf	$fcc3, \tmp1
-	bstrpick.d	\tmp1, \tmp0, 39, 32
-	movgr2cf	$fcc4, \tmp1
-	bstrpick.d	\tmp1, \tmp0, 47, 40
-	movgr2cf	$fcc5, \tmp1
-	bstrpick.d	\tmp1, \tmp0, 55, 48
-	movgr2cf	$fcc6, \tmp1
-	bstrpick.d	\tmp1, \tmp0, 63, 56
-	movgr2cf	$fcc7, \tmp1
+	EX	ld.b	\tmp0, \base, 0
+	EX	ld.b	\tmp1, \base, 8
+	movgr2fr.w	ft0, \tmp0
+	movgr2fr.w	ft1, \tmp1
+	movfr2cf	$fcc0, ft0
+	movfr2cf	$fcc1, ft1
+	EX	ld.b	\tmp0, \base, 16
+	EX	ld.b	\tmp1, \base, 24
+	movgr2fr.w	ft0, \tmp0
+	movgr2fr.w	ft1, \tmp1
+	movfr2cf	$fcc2, ft0
+	movfr2cf	$fcc3, ft1
+	EX	ld.b	\tmp0, \base, 32
+	EX	ld.b	\tmp1, \base, 40
+	movgr2fr.w	ft0, \tmp0
+	movgr2fr.w	ft1, \tmp1
+	movfr2cf	$fcc4, ft0
+	movfr2cf	$fcc5, ft1
+	EX	ld.b	\tmp0, \base, 48
+	EX	ld.b	\tmp1, \base, 56
+	movgr2fr.w	ft0, \tmp0
+	movgr2fr.w	ft1, \tmp1
+	movfr2cf	$fcc6, ft0
+	movfr2cf	$fcc7, ft1
 	.endm
 
 	.macro sc_save_fcsr base, tmp0
@@ -449,9 +463,9 @@ SYM_FUNC_END(_init_fpu)
  * a2: fcsr
  */
 SYM_FUNC_START(_save_fp_context)
-	sc_save_fcc	a1 t1 t2
 	sc_save_fcsr	a2 t1
 	sc_save_fp	a0
+	sc_save_fcc	a1 t1 t2
 	li.w		a0, 0				# success
 	jr		ra
 SYM_FUNC_END(_save_fp_context)
@@ -462,8 +476,8 @@ SYM_FUNC_END(_save_fp_context)
  * a2: fcsr
  */
 SYM_FUNC_START(_restore_fp_context)
-	sc_restore_fp	a0
 	sc_restore_fcc	a1 t1 t2
+	sc_restore_fp	a0
 	sc_restore_fcsr	a2 t1
 	li.w		a0, 0				# success
 	jr		ra
@@ -475,9 +489,9 @@ SYM_FUNC_END(_restore_fp_context)
  * a2: fcsr
  */
 SYM_FUNC_START(_save_lsx_context)
-	sc_save_fcc a1, t0, t1
 	sc_save_fcsr a2, t0
 	sc_save_lsx a0
+	sc_save_fcc a1, t0, t1
 	li.w	a0, 0					# success
 	jr	ra
 SYM_FUNC_END(_save_lsx_context)
@@ -488,8 +502,8 @@ SYM_FUNC_END(_save_lsx_context)
  * a2: fcsr
  */
 SYM_FUNC_START(_restore_lsx_context)
-	sc_restore_lsx a0
 	sc_restore_fcc a1, t1, t2
+	sc_restore_lsx a0
 	sc_restore_fcsr a2, t1
 	li.w	a0, 0					# success
 	jr	ra
@@ -501,9 +515,9 @@ SYM_FUNC_END(_restore_lsx_context)
  * a2: fcsr
  */
 SYM_FUNC_START(_save_lasx_context)
-	sc_save_fcc a1, t0, t1
 	sc_save_fcsr a2, t0
 	sc_save_lasx a0
+	sc_save_fcc a1, t0, t1
 	li.w	a0, 0					# success
 	jr	ra
 SYM_FUNC_END(_save_lasx_context)
@@ -514,8 +528,8 @@ SYM_FUNC_END(_save_lasx_context)
  * a2: fcsr
  */
 SYM_FUNC_START(_restore_lasx_context)
-	sc_restore_lasx a0
 	sc_restore_fcc a1, t1, t2
+	sc_restore_lasx a0
 	sc_restore_fcsr a2, t1
 	li.w	a0, 0					# success
 	jr	ra
-- 
2.43.0

