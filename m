Return-Path: <linux-kernel+bounces-100415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 949DF87972C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B234284944
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347E97C087;
	Tue, 12 Mar 2024 15:09:09 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65407B3F5
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 15:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710256148; cv=none; b=O9jtFc6I3a9WSgc4NnaHisXWynx0qu/QvODu3/EQ/AhL172fI6ACrZnV0LZ8r76o5OYuWCvln5EIXJ0z75QWEMS68y6z9HNwiOFXkdlWAC1BCLKNEANrcUZr5+mN+5YT6TuPCvzwt9e94ylv8rwuEzVrXkkeBDRuRCPOAGJ6I7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710256148; c=relaxed/simple;
	bh=C9Y/KDODhfrLhd13V1N0qrg1SxN03un2J+uDzdhWJDY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F25ePLKSfXhSK1P9G7Tp937zjSxThMreZmd6T9LhyqxfaMSJe06kvxbAtkJ185LvhblU+7GlZomcV/xdpXleprM6mxTUV9NimcZ0DPtcrNBYfFyUBnqMiK5kfWfsaw8eIpVu4tRJp/VPMsbWrRWZCigKL6KJnef1wpZjN6F9+mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TvH6M02MDz2Bfqy;
	Tue, 12 Mar 2024 23:06:35 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 874FE18002D;
	Tue, 12 Mar 2024 23:09:01 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Tue, 12 Mar
 2024 23:09:01 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>
CC: <lizetao1@huawei.com>, <quic_jiles@quicinc.com>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: lib: improve usercopy performance by mitigating data dependencies
Date: Tue, 12 Mar 2024 23:08:45 +0800
Message-ID: <20240312150845.1356415-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd500012.china.huawei.com (7.221.188.25)

In the copy_from/to_user scenario, due to the need to accurately
calculate the number of copied bytes for fixup, it is necessary to
increment the values of src and dst after each copy of the data.
Therefore, this introduce RAW dependency which result in some bubble
in pipline and degrade the IPC.

Consider updating the values of src and dst only when the copy is
completed in the current stage to reduce data dependence. But this will
break the function of fixup, so in order to maintain the function of
fixup, a new variable is introduced to record the number of bytes to be
copied in the current stage. Once an access exception occurs, the variable
can be used to determined the final index of access exception by copying
byte-by-byte.

Here are the test result:
  Copy 128 bytes cost on Kunpeng-920(us):
    Without this patch:
    copy_from_user: 1.0187 copy_to_user: 1.1021

    With this patch:
    copy_from_user: 0.9523 copy_to_user: 1.0159

It's about 7% improvement in copy_from/to_user()

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 arch/arm64/include/asm/asm-uaccess.h | 14 +++---
 arch/arm64/lib/copy_from_user.S      | 21 +++++++--
 arch/arm64/lib/copy_template.S       | 66 +++++++++++++++++-----------
 arch/arm64/lib/copy_to_user.S        | 22 +++++++---
 4 files changed, 81 insertions(+), 42 deletions(-)

diff --git a/arch/arm64/include/asm/asm-uaccess.h b/arch/arm64/include/asm/asm-uaccess.h
index 5b6efe8abeeb..ccbde0d0c113 100644
--- a/arch/arm64/include/asm/asm-uaccess.h
+++ b/arch/arm64/include/asm/asm-uaccess.h
@@ -66,19 +66,17 @@ alternative_else_nop_endif
  * This is complicated as there is no post-increment or pair versions of the
  * unprivileged instructions, and USER() only works for single instructions.
  */
-	.macro user_ldp l, reg1, reg2, addr, post_inc
-8888:		ldtr	\reg1, [\addr];
-8889:		ldtr	\reg2, [\addr, #8];
-		add	\addr, \addr, \post_inc;
+	.macro user_ldp l, reg1, reg2, addr, offs_inc
+8888:		ldtr	\reg1, [\addr, \offs_inc];
+8889:		ldtr	\reg2, [\addr, \offs_inc + 8];
 
 		_asm_extable_uaccess	8888b, \l;
 		_asm_extable_uaccess	8889b, \l;
 	.endm
 
-	.macro user_stp l, reg1, reg2, addr, post_inc
-8888:		sttr	\reg1, [\addr];
-8889:		sttr	\reg2, [\addr, #8];
-		add	\addr, \addr, \post_inc;
+	.macro user_stp l, reg1, reg2, addr, offs_inc
+8888:		sttr	\reg1, [\addr, \offs_inc];
+8889:		sttr	\reg2, [\addr, \offs_inc + 8];
 
 		_asm_extable_uaccess	8888b,\l;
 		_asm_extable_uaccess	8889b,\l;
diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
index 34e317907524..c575829b85be 100644
--- a/arch/arm64/lib/copy_from_user.S
+++ b/arch/arm64/lib/copy_from_user.S
@@ -49,7 +49,7 @@
 	.endm
 
 	.macro stp1 reg1, reg2, ptr, val
-	stp \reg1, \reg2, [\ptr], \val
+	stp \reg1, \reg2, [\ptr, \val]
 	.endm
 
 end	.req	x5
@@ -62,12 +62,25 @@ SYM_FUNC_START(__arch_copy_from_user)
 	ret
 
 	// Exception fixups
-9997:	cmp	dst, dstin
+9997:	sub	x7, src, srcin
+	sub	x8, dst, dstin
+	cmp	x7, x8
+	b.le	no_need_to_adjust_src
+	sub	x9, x7, x8
+	sub	src, src, p_copy
+	add	p_copy, p_copy, x9
+no_need_to_adjust_src:
+	cmp	dst, dstin
 	b.ne	9998f
 	// Before being absolutely sure we couldn't copy anything, try harder
-USER(9998f, ldtrb tmp1w, [srcin])
+calculate_bytes_copied:
+USER(9999f, ldtrb tmp1w, [src])
 	strb	tmp1w, [dst], #1
-9998:	sub	x0, end, dst			// bytes not copied
+	add	src, src, #1
+	sub	p_copy, p_copy, #1
+9998:	cmp	p_copy, 0
+	b.ge	calculate_bytes_copied
+9999:	sub	x0, end, dst			// bytes not copied
 	ret
 SYM_FUNC_END(__arch_copy_from_user)
 EXPORT_SYMBOL(__arch_copy_from_user)
diff --git a/arch/arm64/lib/copy_template.S b/arch/arm64/lib/copy_template.S
index 488df234c49a..8832b9fd0257 100644
--- a/arch/arm64/lib/copy_template.S
+++ b/arch/arm64/lib/copy_template.S
@@ -29,6 +29,7 @@ tmp1w	.req	w3
 tmp2	.req	x4
 tmp2w	.req	w4
 dst	.req	x6
+p_copy	.req	x16
 
 A_l	.req	x7
 A_h	.req	x8
@@ -39,6 +40,7 @@ C_h	.req	x12
 D_l	.req	x13
 D_h	.req	x14
 
+	mov	p_copy, 16
 	mov	dst, dstin
 	cmp	count, #16
 	/*When memory length is less than 16, the accessed are not aligned.*/
@@ -82,19 +84,26 @@ D_h	.req	x14
 	* Copy up to 48 bytes of data. At this point we only need the
 	* bottom 6 bits of count to be accurate.
 	*/
+	mov	p_copy, #16
 	ands	tmp1, count, #0x30
 	b.eq	.Ltiny15
 	cmp	tmp1w, #0x20
 	b.eq	1f
 	b.lt	2f
-	ldp1	A_l, A_h, src, #16
-	stp1	A_l, A_h, dst, #16
+	ldp1	A_l, A_h, src, #0
+	stp1	A_l, A_h, dst, #0
+	add	src, src, #16
+	add	dst, dst, #16
 1:
-	ldp1	A_l, A_h, src, #16
-	stp1	A_l, A_h, dst, #16
+	ldp1	A_l, A_h, src, #0
+	stp1	A_l, A_h, dst, #0
+	add	src, src, #16
+	add	dst, dst, #16
 2:
-	ldp1	A_l, A_h, src, #16
-	stp1	A_l, A_h, dst, #16
+	ldp1	A_l, A_h, src, #0
+	stp1	A_l, A_h, dst, #0
+	add	src, src, #16
+	add	dst, dst, #16
 .Ltiny15:
 	/*
 	* Prefer to break one ldp/stp into several load/store to access
@@ -126,20 +135,23 @@ D_h	.req	x14
 	b	.Lexitfunc
 
 .Lcpy_over64:
+	mov	p_copy, #64
 	subs	count, count, #128
 	b.ge	.Lcpy_body_large
 	/*
 	* Less than 128 bytes to copy, so handle 64 here and then jump
 	* to the tail.
 	*/
-	ldp1	A_l, A_h, src, #16
-	stp1	A_l, A_h, dst, #16
+	ldp1	A_l, A_h, src, #0
+	stp1	A_l, A_h, dst, #0
 	ldp1	B_l, B_h, src, #16
-	ldp1	C_l, C_h, src, #16
+	ldp1	C_l, C_h, src, #32
 	stp1	B_l, B_h, dst, #16
-	stp1	C_l, C_h, dst, #16
-	ldp1	D_l, D_h, src, #16
-	stp1	D_l, D_h, dst, #16
+	stp1	C_l, C_h, dst, #32
+	ldp1	D_l, D_h, src, #48
+	stp1	D_l, D_h, dst, #48
+	add	src, src, #64
+	add	dst, dst, #64
 
 	tst	count, #0x3f
 	b.ne	.Ltail63
@@ -152,30 +164,34 @@ D_h	.req	x14
 	.p2align	L1_CACHE_SHIFT
 .Lcpy_body_large:
 	/* pre-get 64 bytes data. */
-	ldp1	A_l, A_h, src, #16
+	ldp1	A_l, A_h, src, #0
 	ldp1	B_l, B_h, src, #16
-	ldp1	C_l, C_h, src, #16
-	ldp1	D_l, D_h, src, #16
+	ldp1	C_l, C_h, src, #32
+	ldp1	D_l, D_h, src, #48
+	add	src, src, #64
 1:
 	/*
 	* interlace the load of next 64 bytes data block with store of the last
 	* loaded 64 bytes data.
 	*/
-	stp1	A_l, A_h, dst, #16
-	ldp1	A_l, A_h, src, #16
+	stp1	A_l, A_h, dst, #0
+	ldp1	A_l, A_h, src, #0
 	stp1	B_l, B_h, dst, #16
 	ldp1	B_l, B_h, src, #16
-	stp1	C_l, C_h, dst, #16
-	ldp1	C_l, C_h, src, #16
-	stp1	D_l, D_h, dst, #16
-	ldp1	D_l, D_h, src, #16
+	stp1	C_l, C_h, dst, #32
+	ldp1	C_l, C_h, src, #32
+	stp1	D_l, D_h, dst, #48
+	ldp1	D_l, D_h, src, #48
+	add	src, src, #64
+	add	dst, dst, #64
 	subs	count, count, #64
 	b.ge	1b
-	stp1	A_l, A_h, dst, #16
+	stp1	A_l, A_h, dst, #0
 	stp1	B_l, B_h, dst, #16
-	stp1	C_l, C_h, dst, #16
-	stp1	D_l, D_h, dst, #16
+	stp1	C_l, C_h, dst, #32
+	stp1	D_l, D_h, dst, #48
+	add	dst, dst, #64
 
 	tst	count, #0x3f
 	b.ne	.Ltail63
-.Lexitfunc:
+.Lexitfunc: mov	p_copy, #0
diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
index 802231772608..89db19e09ca2 100644
--- a/arch/arm64/lib/copy_to_user.S
+++ b/arch/arm64/lib/copy_to_user.S
@@ -44,7 +44,7 @@
 	.endm
 
 	.macro ldp1 reg1, reg2, ptr, val
-	ldp \reg1, \reg2, [\ptr], \val
+	ldp \reg1, \reg2, [\ptr, \val]
 	.endm
 
 	.macro stp1 reg1, reg2, ptr, val
@@ -61,13 +61,25 @@ SYM_FUNC_START(__arch_copy_to_user)
 	ret
 
 	// Exception fixups
-9997:	cmp	dst, dstin
+9997:	sub	x7, src, srcin
+	sub	x8, dst, dstin
+	cmp	x7, x8
+	b.le	no_need_to_adjust_src
+	sub	x9, x7, x8
+	sub	src, src, x9
+	add	p_copy, p_copy, x9
+no_need_to_adjust_src:
+	cmp	dst, dstin
 	b.ne	9998f
 	// Before being absolutely sure we couldn't copy anything, try harder
-	ldrb	tmp1w, [srcin]
-USER(9998f, sttrb tmp1w, [dst])
+calculate_bytes_copied:
+	ldrb	tmp1w, [src], #1
+USER(9999f, sttrb tmp1w, [dst])
 	add	dst, dst, #1
-9998:	sub	x0, end, dst			// bytes not copied
+	sub	p_copy, p_copy, #1
+9998:	cmp	p_copy, 0
+	b.ge	calculate_bytes_copied
+9999:	sub	x0, end, dst			// bytes not copied
 	ret
 SYM_FUNC_END(__arch_copy_to_user)
 EXPORT_SYMBOL(__arch_copy_to_user)
-- 
2.34.1


