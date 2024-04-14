Return-Path: <linux-kernel+bounces-143437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0738A390F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 02:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D59E0284672
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 00:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED648819;
	Sat, 13 Apr 2024 00:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GeL4Qu/t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCD2173;
	Sat, 13 Apr 2024 00:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712967056; cv=none; b=NowHFCK47vkMIvIddga61XUnNojAQ2WmFksZVBS+o6qxymzS8PPY773TUN/8A9cRt/PLhdR4lwUTfPfcCzkBPkVHVXP9zdWPgIyoU+BOHexjB6+2ihUNR/UOXnKztf5oC7Wc3WZ/ZUCPTiRdSaDet5utWkpsApstjuh52mdnPlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712967056; c=relaxed/simple;
	bh=Z8GUTbMJy+y/54gkujb4Y6UhE78sNAGci8LEMqGuIbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qqaed3x4j7G3ONkGB8G9rHozFa9m4iRUwaiXSlQQH5nt017PpHyZj1P4LV6x7gubXrM+h3kdTIDRcNCSx2Sy+YDFYSIeFbzG6WOKVoWqFwNCP+ETM15RFvEjNeQ59gTPjZKUG/vUjDG/mhGwobdTiA2xxUE5gCeNgvgc1kZK9iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GeL4Qu/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4B1C113CC;
	Sat, 13 Apr 2024 00:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712967055;
	bh=Z8GUTbMJy+y/54gkujb4Y6UhE78sNAGci8LEMqGuIbk=;
	h=From:To:Cc:Subject:Date:From;
	b=GeL4Qu/tbmDO8Z/KKnxirUpjWwmO/5AFkZQN8xkjZCHfQzDZHu682IqrK6mwJyJ/a
	 nLrlfr/0DVXD4VjZuoP1sRjG2M/TnDrfFJpOl5r0Q8nIsftdWYRHmCJyfs3pF9qDw4
	 mU7ye4SQdh8ZCHl8XQCDMnKxLfjXAK3yNK2PsPockoj/GbYvtgI3EgDuT2hOSdECWC
	 rqppcAQ9rmaihAhQplIeszglcXNcoFPEZbbpv6jUz5+8vLM3ktrH4ZoslqGdh1cJsE
	 Qz3E7SyRyaBhN0xPYJ5qd4rG0FieYbAHxL9DyIchiFo59eEQiIDQF4vtnuicnFk16R
	 8YBwjMrs3GeCQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	"Chang S . Bae" <chang.seok.bae@intel.com>
Subject: [PATCH] crypto: x86/aesni-xts - deduplicate aesni_xts_enc() and aesni_xts_dec()
Date: Fri, 12 Apr 2024 17:09:47 -0700
Message-ID: <20240413000947.67988-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Since aesni_xts_enc() and aesni_xts_dec() are very similar, generate
them from a macro that's passed an argument enc=1 or enc=0.  This
reduces the length of aesni-intel_asm.S by 112 lines while still
producing the exact same object file in both 32-bit and 64-bit mode.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/crypto/aesni-intel_asm.S | 270 +++++++++---------------------
 1 file changed, 79 insertions(+), 191 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index 1cb55eea2efa..3a3e46188dec 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -2823,32 +2823,28 @@ SYM_FUNC_END(aesni_ctr_enc)
 .Lgf128mul_x_ble_mask:
 	.octa 0x00000000000000010000000000000087
 .previous
 
 /*
- * _aesni_gf128mul_x_ble:		internal ABI
- *	Multiply in GF(2^128) for XTS IVs
+ * _aesni_gf128mul_x_ble: Multiply in GF(2^128) for XTS IVs
  * input:
  *	IV:	current IV
  *	GF128MUL_MASK == mask with 0x87 and 0x01
  * output:
  *	IV:	next IV
  * changed:
- *	CTR:	== temporary value
+ *	KEY:	== temporary value
  */
-#define _aesni_gf128mul_x_ble() \
-	pshufd $0x13, IV, KEY; \
-	paddq IV, IV; \
-	psrad $31, KEY; \
-	pand GF128MUL_MASK, KEY; \
-	pxor KEY, IV;
+.macro _aesni_gf128mul_x_ble
+	pshufd $0x13, IV, KEY
+	paddq IV, IV
+	psrad $31, KEY
+	pand GF128MUL_MASK, KEY
+	pxor KEY, IV
+.endm
 
-/*
- * void aesni_xts_enc(const struct crypto_aes_ctx *ctx, u8 *dst,
- *		      const u8 *src, unsigned int len, le128 *iv)
- */
-SYM_FUNC_START(aesni_xts_enc)
+.macro	_aesni_xts_crypt	enc
 	FRAME_BEGIN
 #ifndef __x86_64__
 	pushl IVP
 	pushl LEN
 	pushl KEYP
@@ -2863,39 +2859,50 @@ SYM_FUNC_START(aesni_xts_enc)
 	movdqa .Lgf128mul_x_ble_mask(%rip), GF128MUL_MASK
 #endif
 	movups (IVP), IV
 
 	mov 480(KEYP), KLEN
+.if !\enc
+	add $240, KEYP
+
+	test $15, LEN
+	jz .Lxts_loop4\@
+	sub $16, LEN
+.endif
 
-.Lxts_enc_loop4:
+.Lxts_loop4\@:
 	sub $64, LEN
-	jl .Lxts_enc_1x
+	jl .Lxts_1x\@
 
 	movdqa IV, STATE1
 	movdqu 0x00(INP), IN
 	pxor IN, STATE1
 	movdqu IV, 0x00(OUTP)
 
-	_aesni_gf128mul_x_ble()
+	_aesni_gf128mul_x_ble
 	movdqa IV, STATE2
 	movdqu 0x10(INP), IN
 	pxor IN, STATE2
 	movdqu IV, 0x10(OUTP)
 
-	_aesni_gf128mul_x_ble()
+	_aesni_gf128mul_x_ble
 	movdqa IV, STATE3
 	movdqu 0x20(INP), IN
 	pxor IN, STATE3
 	movdqu IV, 0x20(OUTP)
 
-	_aesni_gf128mul_x_ble()
+	_aesni_gf128mul_x_ble
 	movdqa IV, STATE4
 	movdqu 0x30(INP), IN
 	pxor IN, STATE4
 	movdqu IV, 0x30(OUTP)
 
+.if \enc
 	call _aesni_enc4
+.else
+	call _aesni_dec4
+.endif
 
 	movdqu 0x00(OUTP), IN
 	pxor IN, STATE1
 	movdqu STATE1, 0x00(OUTP)
 
@@ -2909,63 +2916,84 @@ SYM_FUNC_START(aesni_xts_enc)
 
 	movdqu 0x30(OUTP), IN
 	pxor IN, STATE4
 	movdqu STATE4, 0x30(OUTP)
 
-	_aesni_gf128mul_x_ble()
+	_aesni_gf128mul_x_ble
 
 	add $64, INP
 	add $64, OUTP
 	test LEN, LEN
-	jnz .Lxts_enc_loop4
+	jnz .Lxts_loop4\@
 
-.Lxts_enc_ret_iv:
+.Lxts_ret_iv\@:
 	movups IV, (IVP)
 
-.Lxts_enc_ret:
+.Lxts_ret\@:
 #ifndef __x86_64__
 	popl KLEN
 	popl KEYP
 	popl LEN
 	popl IVP
 #endif
 	FRAME_END
 	RET
 
-.Lxts_enc_1x:
+.Lxts_1x\@:
 	add $64, LEN
-	jz .Lxts_enc_ret_iv
+	jz .Lxts_ret_iv\@
+.if \enc
 	sub $16, LEN
-	jl .Lxts_enc_cts4
+	jl .Lxts_cts4\@
+.endif
 
-.Lxts_enc_loop1:
+.Lxts_loop1\@:
 	movdqu (INP), STATE
+.if \enc
 	pxor IV, STATE
 	call _aesni_enc1
+.else
+	add $16, INP
+	sub $16, LEN
+	jl .Lxts_cts1\@
 	pxor IV, STATE
-	_aesni_gf128mul_x_ble()
+	call _aesni_dec1
+.endif
+	pxor IV, STATE
+	_aesni_gf128mul_x_ble
 
 	test LEN, LEN
-	jz .Lxts_enc_out
+	jz .Lxts_out\@
 
+.if \enc
 	add $16, INP
 	sub $16, LEN
-	jl .Lxts_enc_cts1
+	jl .Lxts_cts1\@
+.endif
 
 	movdqu STATE, (OUTP)
 	add $16, OUTP
-	jmp .Lxts_enc_loop1
+	jmp .Lxts_loop1\@
 
-.Lxts_enc_out:
+.Lxts_out\@:
 	movdqu STATE, (OUTP)
-	jmp .Lxts_enc_ret_iv
+	jmp .Lxts_ret_iv\@
 
-.Lxts_enc_cts4:
+.if \enc
+.Lxts_cts4\@:
 	movdqa STATE4, STATE
 	sub $16, OUTP
+.Lxts_cts1\@:
+.else
+.Lxts_cts1\@:
+	movdqa IV, STATE4
+	_aesni_gf128mul_x_ble
 
-.Lxts_enc_cts1:
+	pxor IV, STATE
+	call _aesni_dec1
+	pxor IV, STATE
+.endif
 #ifndef __x86_64__
 	lea .Lcts_permute_table, T1
 #else
 	lea .Lcts_permute_table(%rip), T1
 #endif
@@ -2987,174 +3015,34 @@ SYM_FUNC_START(aesni_xts_enc)
 	movups (IVP), %xmm0
 	pshufb %xmm0, IN1
 	pblendvb IN2, IN1
 	movaps IN1, STATE
 
+.if \enc
 	pxor IV, STATE
 	call _aesni_enc1
 	pxor IV, STATE
+.else
+	pxor STATE4, STATE
+	call _aesni_dec1
+	pxor STATE4, STATE
+.endif
 
 	movups STATE, (OUTP)
-	jmp .Lxts_enc_ret
+	jmp .Lxts_ret\@
+.endm
+
+/*
+ * void aesni_xts_enc(const struct crypto_aes_ctx *ctx, u8 *dst,
+ *		      const u8 *src, unsigned int len, le128 *iv)
+ */
+SYM_FUNC_START(aesni_xts_enc)
+	_aesni_xts_crypt	1
 SYM_FUNC_END(aesni_xts_enc)
 
 /*
  * void aesni_xts_dec(const struct crypto_aes_ctx *ctx, u8 *dst,
  *		      const u8 *src, unsigned int len, le128 *iv)
  */
 SYM_FUNC_START(aesni_xts_dec)
-	FRAME_BEGIN
-#ifndef __x86_64__
-	pushl IVP
-	pushl LEN
-	pushl KEYP
-	pushl KLEN
-	movl (FRAME_OFFSET+20)(%esp), KEYP	# ctx
-	movl (FRAME_OFFSET+24)(%esp), OUTP	# dst
-	movl (FRAME_OFFSET+28)(%esp), INP	# src
-	movl (FRAME_OFFSET+32)(%esp), LEN	# len
-	movl (FRAME_OFFSET+36)(%esp), IVP	# iv
-	movdqa .Lgf128mul_x_ble_mask, GF128MUL_MASK
-#else
-	movdqa .Lgf128mul_x_ble_mask(%rip), GF128MUL_MASK
-#endif
-	movups (IVP), IV
-
-	mov 480(KEYP), KLEN
-	add $240, KEYP
-
-	test $15, LEN
-	jz .Lxts_dec_loop4
-	sub $16, LEN
-
-.Lxts_dec_loop4:
-	sub $64, LEN
-	jl .Lxts_dec_1x
-
-	movdqa IV, STATE1
-	movdqu 0x00(INP), IN
-	pxor IN, STATE1
-	movdqu IV, 0x00(OUTP)
-
-	_aesni_gf128mul_x_ble()
-	movdqa IV, STATE2
-	movdqu 0x10(INP), IN
-	pxor IN, STATE2
-	movdqu IV, 0x10(OUTP)
-
-	_aesni_gf128mul_x_ble()
-	movdqa IV, STATE3
-	movdqu 0x20(INP), IN
-	pxor IN, STATE3
-	movdqu IV, 0x20(OUTP)
-
-	_aesni_gf128mul_x_ble()
-	movdqa IV, STATE4
-	movdqu 0x30(INP), IN
-	pxor IN, STATE4
-	movdqu IV, 0x30(OUTP)
-
-	call _aesni_dec4
-
-	movdqu 0x00(OUTP), IN
-	pxor IN, STATE1
-	movdqu STATE1, 0x00(OUTP)
-
-	movdqu 0x10(OUTP), IN
-	pxor IN, STATE2
-	movdqu STATE2, 0x10(OUTP)
-
-	movdqu 0x20(OUTP), IN
-	pxor IN, STATE3
-	movdqu STATE3, 0x20(OUTP)
-
-	movdqu 0x30(OUTP), IN
-	pxor IN, STATE4
-	movdqu STATE4, 0x30(OUTP)
-
-	_aesni_gf128mul_x_ble()
-
-	add $64, INP
-	add $64, OUTP
-	test LEN, LEN
-	jnz .Lxts_dec_loop4
-
-.Lxts_dec_ret_iv:
-	movups IV, (IVP)
-
-.Lxts_dec_ret:
-#ifndef __x86_64__
-	popl KLEN
-	popl KEYP
-	popl LEN
-	popl IVP
-#endif
-	FRAME_END
-	RET
-
-.Lxts_dec_1x:
-	add $64, LEN
-	jz .Lxts_dec_ret_iv
-
-.Lxts_dec_loop1:
-	movdqu (INP), STATE
-
-	add $16, INP
-	sub $16, LEN
-	jl .Lxts_dec_cts1
-
-	pxor IV, STATE
-	call _aesni_dec1
-	pxor IV, STATE
-	_aesni_gf128mul_x_ble()
-
-	test LEN, LEN
-	jz .Lxts_dec_out
-
-	movdqu STATE, (OUTP)
-	add $16, OUTP
-	jmp .Lxts_dec_loop1
-
-.Lxts_dec_out:
-	movdqu STATE, (OUTP)
-	jmp .Lxts_dec_ret_iv
-
-.Lxts_dec_cts1:
-	movdqa IV, STATE4
-	_aesni_gf128mul_x_ble()
-
-	pxor IV, STATE
-	call _aesni_dec1
-	pxor IV, STATE
-
-#ifndef __x86_64__
-	lea .Lcts_permute_table, T1
-#else
-	lea .Lcts_permute_table(%rip), T1
-#endif
-	add LEN, INP		/* rewind input pointer */
-	add $16, LEN		/* # bytes in final block */
-	movups (INP), IN1
-
-	mov T1, IVP
-	add $32, IVP
-	add LEN, T1
-	sub LEN, IVP
-	add OUTP, LEN
-
-	movups (T1), %xmm4
-	movaps STATE, IN2
-	pshufb %xmm4, STATE
-	movups STATE, (LEN)
-
-	movups (IVP), %xmm0
-	pshufb %xmm0, IN1
-	pblendvb IN2, IN1
-	movaps IN1, STATE
-
-	pxor STATE4, STATE
-	call _aesni_dec1
-	pxor STATE4, STATE
-
-	movups STATE, (OUTP)
-	jmp .Lxts_dec_ret
+	_aesni_xts_crypt	0
 SYM_FUNC_END(aesni_xts_dec)

base-commit: 751fb2528c12ef64d1e863efb196cdc968b384f6
-- 
2.44.0


