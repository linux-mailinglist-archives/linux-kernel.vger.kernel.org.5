Return-Path: <linux-kernel+bounces-126335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDB989354C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 20:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAD751F22672
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173DC1DFFC;
	Sun, 31 Mar 2024 18:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Hwgi/YAO"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE2A145B2A
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 18:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711908070; cv=none; b=cLBan2OISenbZPUrxEIxKNP4mRd2KUCUVPepHIZiFswxNMpw/YTPY94vgwX1A1qkLylfs3F8EERcSOHqszrZ5Jqa3PUhSdJua0m3bL3k1H4ureiGh+vloY/OQucEyhnmOAb3xbDsSbCUEOFjbLDBIFX25vdG+QEnCJLvM4AIhqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711908070; c=relaxed/simple;
	bh=p8woIZz9mSVPjyvCWDKt4OVUR1tVc5vbUSpsGV5vsKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fCtEPWAcwSnqeo2vUl93wjC3THWHq/q89PMbFDwjJd50WmAF50TVoh0K10FgP+eMvDgXkIhaIdS5Q1JRt6qfiik4pXyRSaZeuv8PkMir/sQKRFHZ//FGzy56G78Dr9pUAWrv1+pUAlB9aBfnNuMb/pUx0DRPhFz0qU4Hyjta+yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Hwgi/YAO reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 06A6D40E02A6;
	Sun, 31 Mar 2024 18:01:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id a0RXuXejAVCe; Sun, 31 Mar 2024 18:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711908059; bh=Q1D4BZ2EvneFNiscjl0Lfx51FaajqA/nealgBM4NuXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hwgi/YAOIRhlAvdzUObLQ3/WiB3cdgzUqcUYMpDNLgUtx01reFZA2hUhkk6WCGbC8
	 JxXeBQC+Ij4iWhZPMkxDwUAEUXu+xyNlEvwwwjr/wHuIqTdRvFE9mg+RuEVPs+20fn
	 I7gGF98XxWf4BPvi8bMRzN9NdmQ7Jun7V5ZNIt77f5LXAkiW5a+TDJJCaS5ifl1cnW
	 qEdPj8F+ipQ/4uMnziNOKIM/Wx2Xb3vVST/+ibSwv/OVj90vYT/6DDfojKvvnZ2NTA
	 8TYvUxwXqlIxRU44adj75dsK3bGmnRLPcqnjyO0zRh0P5VClKhIjfT59ob00yEIixr
	 PeABe/y9EpbBk66ZYPNVXa6Az0OWCCvSN4WMxBux7h1NFGg/t2KH4OI5G2D4Pe4jiE
	 StZdKWw2YFcBbX994sLL2prNXVi69dctrsuYBBdlS0Dk5cWPZwQpk0QE5ij97E83Do
	 OHXcZdouY3dRLb8c3vYAwvx1yRivgFpM/e11orrwsk758ISSiKgo1rMU4vhAXtOu7w
	 SS9X5P+6BMn4ZXMQWZpqp71D6udGi9ZIbLwFr/oP11KPT+vhJY5JIpL76zYH+sSLQO
	 xuZKASIyjvj5znImPbasCUYqC6Ne847vhy/74i4t0H/zcKV8zVLiB/3VU2XUT3XGQS
	 faiCoBqew8gcznli9URwTLMw=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 91E8640E0202;
	Sun, 31 Mar 2024 18:00:57 +0000 (UTC)
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/4] x86/alternatives: Use a temporary buffer when optimizing NOPs
Date: Sun, 31 Mar 2024 20:00:39 +0200
Message-ID: <20240331180042.13933-2-bp@alien8.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240331180042.13933-1-bp@alien8.de>
References: <20240331180042.13933-1-bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Instead of optimizing NOPs in-place, use a temporary buffer like the
usual alternatives patching flow does. This obviates the need to grab
locks when patching, see

  6778977590da ("x86/alternatives: Disable interrupts and sync when optim=
izing NOPs in place")

While at it, add nomenclature definitions clarifying and simplifying the
naming of function-local variables in the alternatives code.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/text-patching.h |  2 +-
 arch/x86/kernel/alternative.c        | 84 +++++++++++++++-------------
 arch/x86/kernel/callthunks.c         |  9 +--
 3 files changed, 49 insertions(+), 46 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/=
text-patching.h
index 345aafbc1964..6259f1937fe7 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -15,7 +15,7 @@
=20
 extern void text_poke_early(void *addr, const void *opcode, size_t len);
=20
-extern void apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *src, siz=
e_t src_len);
+extern void apply_relocation(u8 *buf, const u8 * const instr, size_t ins=
trlen, u8 *repl, size_t repl_len);
=20
 /*
  * Clear and restore the kernel write-protection flag on the local CPU.
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.=
c
index 45a280f2161c..ec94f1359c00 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -124,6 +124,20 @@ const unsigned char * const x86_nops[ASM_NOP_MAX+1] =
=3D
 #endif
 };
=20
+/*
+ * Nomenclature for variable names to simplify and clarify this code and=
 ease
+ * any potential staring at it:
+ *
+ * @instr: source address of the original instructions in the kernel tex=
t as
+ * generated by the compiler.
+ *
+ * @buf: temporary buffer on which the patching operates. This buffer is
+ * eventually text-poked into the kernel image.
+ *
+ * @replacement/@repl: pointer to the opcodes which are replacing @instr=
, located
+ * in the .altinstr_replacement section.
+ */
+
 /*
  * Fill the buffer with a single effective instruction of size @len.
  *
@@ -133,28 +147,28 @@ const unsigned char * const x86_nops[ASM_NOP_MAX+1]=
 =3D
  * each single-byte NOPs). If @len to fill out is > ASM_NOP_MAX, pad wit=
h INT3 and
  * *jump* over instead of executing long and daft NOPs.
  */
-static void add_nop(u8 *instr, unsigned int len)
+static void add_nop(u8 *buf, unsigned int len)
 {
-	u8 *target =3D instr + len;
+	u8 *target =3D buf + len;
=20
 	if (!len)
 		return;
=20
 	if (len <=3D ASM_NOP_MAX) {
-		memcpy(instr, x86_nops[len], len);
+		memcpy(buf, x86_nops[len], len);
 		return;
 	}
=20
 	if (len < 128) {
-		__text_gen_insn(instr, JMP8_INSN_OPCODE, instr, target, JMP8_INSN_SIZE=
);
-		instr +=3D JMP8_INSN_SIZE;
+		__text_gen_insn(buf, JMP8_INSN_OPCODE, buf, target, JMP8_INSN_SIZE);
+		buf +=3D JMP8_INSN_SIZE;
 	} else {
-		__text_gen_insn(instr, JMP32_INSN_OPCODE, instr, target, JMP32_INSN_SI=
ZE);
-		instr +=3D JMP32_INSN_SIZE;
+		__text_gen_insn(buf, JMP32_INSN_OPCODE, buf, target, JMP32_INSN_SIZE);
+		buf +=3D JMP32_INSN_SIZE;
 	}
=20
-	for (;instr < target; instr++)
-		*instr =3D INT3_INSN_OPCODE;
+	for (;buf < target; buf++)
+		*buf =3D INT3_INSN_OPCODE;
 }
=20
 extern s32 __retpoline_sites[], __retpoline_sites_end[];
@@ -187,12 +201,12 @@ static bool insn_is_nop(struct insn *insn)
  * Find the offset of the first non-NOP instruction starting at @offset
  * but no further than @len.
  */
-static int skip_nops(u8 *instr, int offset, int len)
+static int skip_nops(u8 *buf, int offset, int len)
 {
 	struct insn insn;
=20
 	for (; offset < len; offset +=3D insn.length) {
-		if (insn_decode_kernel(&insn, &instr[offset]))
+		if (insn_decode_kernel(&insn, &buf[offset]))
 			break;
=20
 		if (!insn_is_nop(&insn))
@@ -207,7 +221,7 @@ static int skip_nops(u8 *instr, int offset, int len)
  * to the end of the NOP sequence into a single NOP.
  */
 static bool
-__optimize_nops(u8 *instr, size_t len, struct insn *insn, int *next, int=
 *prev, int *target)
+__optimize_nops(const u8 * const instr, u8 *buf, size_t len, struct insn=
 *insn, int *next, int *prev, int *target)
 {
 	int i =3D *next - insn->length;
=20
@@ -222,12 +236,12 @@ __optimize_nops(u8 *instr, size_t len, struct insn =
*insn, int *next, int *prev,
 	if (insn_is_nop(insn)) {
 		int nop =3D i;
=20
-		*next =3D skip_nops(instr, *next, len);
+		*next =3D skip_nops(buf, *next, len);
 		if (*target && *next =3D=3D *target)
 			nop =3D *prev;
=20
-		add_nop(instr + nop, *next - nop);
-		DUMP_BYTES(ALT, instr, len, "%px: [%d:%d) optimized NOPs: ", instr, no=
p, *next);
+		add_nop(buf + nop, *next - nop);
+		DUMP_BYTES(ALT, buf, len, "%px: [%d:%d) optimized NOPs: ", instr, nop,=
 *next);
 		return true;
 	}
=20
@@ -239,32 +253,22 @@ __optimize_nops(u8 *instr, size_t len, struct insn =
*insn, int *next, int *prev,
  * "noinline" to cause control flow change and thus invalidate I$ and
  * cause refetch after modification.
  */
-static void __init_or_module noinline optimize_nops(u8 *instr, size_t le=
n)
+static void __init_or_module noinline optimize_nops(const u8 * const ins=
tr, u8 *buf, size_t len)
 {
 	int prev, target =3D 0;
=20
 	for (int next, i =3D 0; i < len; i =3D next) {
 		struct insn insn;
=20
-		if (insn_decode_kernel(&insn, &instr[i]))
+		if (insn_decode_kernel(&insn, &buf[i]))
 			return;
=20
 		next =3D i + insn.length;
=20
-		__optimize_nops(instr, len, &insn, &next, &prev, &target);
+		__optimize_nops(instr, buf, len, &insn, &next, &prev, &target);
 	}
 }
=20
-static void __init_or_module noinline optimize_nops_inplace(u8 *instr, s=
ize_t len)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	optimize_nops(instr, len);
-	sync_core();
-	local_irq_restore(flags);
-}
-
 /*
  * In this context, "source" is where the instructions are placed in the
  * section .altinstr_replacement, for example during kernel build by the
@@ -335,11 +339,11 @@ bool need_reloc(unsigned long offset, u8 *src, size=
_t src_len)
 	return (target < src || target > src + src_len);
 }
=20
-void apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *src, size_t src=
_len)
+void apply_relocation(u8 *buf, const u8 * const instr, size_t instrlen, =
u8 *repl, size_t repl_len)
 {
 	int prev, target =3D 0;
=20
-	for (int next, i =3D 0; i < len; i =3D next) {
+	for (int next, i =3D 0; i < instrlen; i =3D next) {
 		struct insn insn;
=20
 		if (WARN_ON_ONCE(insn_decode_kernel(&insn, &buf[i])))
@@ -347,7 +351,7 @@ void apply_relocation(u8 *buf, size_t len, u8 *dest, =
u8 *src, size_t src_len)
=20
 		next =3D i + insn.length;
=20
-		if (__optimize_nops(buf, len, &insn, &next, &prev, &target))
+		if (__optimize_nops(instr, buf, instrlen, &insn, &next, &prev, &target=
))
 			continue;
=20
 		switch (insn.opcode.bytes[0]) {
@@ -361,10 +365,10 @@ void apply_relocation(u8 *buf, size_t len, u8 *dest=
, u8 *src, size_t src_len)
 		case JMP8_INSN_OPCODE:
 		case JMP32_INSN_OPCODE:
 		case CALL_INSN_OPCODE:
-			if (need_reloc(next + insn.immediate.value, src, src_len)) {
+			if (need_reloc(next + insn.immediate.value, repl, repl_len)) {
 				apply_reloc(insn.immediate.nbytes,
 					    buf + i + insn_offset_immediate(&insn),
-					    src - dest);
+					    repl - instr);
 			}
=20
 			/*
@@ -372,7 +376,7 @@ void apply_relocation(u8 *buf, size_t len, u8 *dest, =
u8 *src, size_t src_len)
 			 */
 			if (insn.opcode.bytes[0] =3D=3D JMP32_INSN_OPCODE) {
 				s32 imm =3D insn.immediate.value;
-				imm +=3D src - dest;
+				imm +=3D repl - instr;
 				imm +=3D JMP32_INSN_SIZE - JMP8_INSN_SIZE;
 				if ((imm >> 31) =3D=3D (imm >> 7)) {
 					buf[i+0] =3D JMP8_INSN_OPCODE;
@@ -385,10 +389,10 @@ void apply_relocation(u8 *buf, size_t len, u8 *dest=
, u8 *src, size_t src_len)
 		}
=20
 		if (insn_rip_relative(&insn)) {
-			if (need_reloc(next + insn.displacement.value, src, src_len)) {
+			if (need_reloc(next + insn.displacement.value, repl, repl_len)) {
 				apply_reloc(insn.displacement.nbytes,
 					    buf + i + insn_offset_displacement(&insn),
-					    src - dest);
+					    repl - instr);
 			}
 		}
 	}
@@ -504,7 +508,9 @@ void __init_or_module noinline apply_alternatives(str=
uct alt_instr *start,
 		 *   patch if feature is *NOT* present.
 		 */
 		if (!boot_cpu_has(a->cpuid) =3D=3D !(a->flags & ALT_FLAG_NOT)) {
-			optimize_nops_inplace(instr, a->instrlen);
+			memcpy(insn_buff, instr, a->instrlen);
+			optimize_nops(instr, insn_buff, a->instrlen);
+			text_poke_early(instr, insn_buff, a->instrlen);
 			continue;
 		}
=20
@@ -526,7 +532,7 @@ void __init_or_module noinline apply_alternatives(str=
uct alt_instr *start,
 		for (; insn_buff_sz < a->instrlen; insn_buff_sz++)
 			insn_buff[insn_buff_sz] =3D 0x90;
=20
-		apply_relocation(insn_buff, a->instrlen, instr, replacement, a->replac=
ementlen);
+		apply_relocation(insn_buff, instr, a->instrlen, replacement, a->replac=
ementlen);
=20
 		DUMP_BYTES(ALT, instr, a->instrlen, "%px:   old_insn: ", instr);
 		DUMP_BYTES(ALT, replacement, a->replacementlen, "%px:   rpl_insn: ", r=
eplacement);
@@ -761,7 +767,7 @@ void __init_or_module noinline apply_retpolines(s32 *=
start, s32 *end)
=20
 		len =3D patch_retpoline(addr, &insn, bytes);
 		if (len =3D=3D insn.length) {
-			optimize_nops(bytes, len);
+			optimize_nops(addr, bytes, len);
 			DUMP_BYTES(RETPOLINE, ((u8*)addr),  len, "%px: orig: ", addr);
 			DUMP_BYTES(RETPOLINE, ((u8*)bytes), len, "%px: repl: ", addr);
 			text_poke_early(addr, bytes, len);
diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index 30335182b6b0..771d95484453 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -185,8 +185,7 @@ static void *patch_dest(void *dest, bool direct)
 	u8 *pad =3D dest - tsize;
=20
 	memcpy(insn_buff, skl_call_thunk_template, tsize);
-	apply_relocation(insn_buff, tsize, pad,
-			 skl_call_thunk_template, tsize);
+	apply_relocation(insn_buff, pad, tsize, skl_call_thunk_template, tsize)=
;
=20
 	/* Already patched? */
 	if (!bcmp(pad, insn_buff, tsize))
@@ -308,8 +307,7 @@ static bool is_callthunk(void *addr)
 	pad =3D (void *)(dest - tmpl_size);
=20
 	memcpy(insn_buff, skl_call_thunk_template, tmpl_size);
-	apply_relocation(insn_buff, tmpl_size, pad,
-			 skl_call_thunk_template, tmpl_size);
+	apply_relocation(insn_buff, pad, tmpl_size, skl_call_thunk_template, tm=
pl_size);
=20
 	return !bcmp(pad, insn_buff, tmpl_size);
 }
@@ -327,8 +325,7 @@ int x86_call_depth_emit_accounting(u8 **pprog, void *=
func)
 		return 0;
=20
 	memcpy(insn_buff, skl_call_thunk_template, tmpl_size);
-	apply_relocation(insn_buff, tmpl_size, *pprog,
-			 skl_call_thunk_template, tmpl_size);
+	apply_relocation(insn_buff, *pprog, tmpl_size, skl_call_thunk_template,=
 tmpl_size);
=20
 	memcpy(*pprog, insn_buff, tmpl_size);
 	*pprog +=3D tmpl_size;
--=20
2.43.0


