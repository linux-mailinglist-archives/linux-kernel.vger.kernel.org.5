Return-Path: <linux-kernel+bounces-44443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0909842226
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EDA2B2E20D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF1067738;
	Tue, 30 Jan 2024 11:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NtM6XUdy"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD2766B5E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706612404; cv=none; b=eRSyzhNK0SRUqeGCjJK2P/gK0Mo7ZiZ2KztTKAtcGMNcRr/1MvUdX2ZMLSXxG5hMfmOV+FsegtZ4qeZaEUrY3z7C4QHQZpHKDxJKeXHgx/evO+1gCg8bfnkbEOhp+/Z3/Uqp6NycS0qclZHbC0zaYBtAFSarU8lIir3fh+Evulg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706612404; c=relaxed/simple;
	bh=S6v5NG3zkWzybZS+L6ZCuQTTnUlx2jbdtvaXdKu2GAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UNxEYpxy0RTX+RMshQSbTazZIw9Hyx7OF0l4dUbOLp3OjTckIDjGg3u+J2baanKQQTtzvG1Q/rYc1JyDyPYSzHu2vcnJYC84fDCyvVN5WxlVDXTqiOQS4A6O05Xw3GdUs6qobuEGPw7J6PKhKcvQ74OWDIsS4rIAntb+lXaM0tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NtM6XUdy reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E168B40E01BB;
	Tue, 30 Jan 2024 10:59:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Zr7zz19iKXhN; Tue, 30 Jan 2024 10:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706612397; bh=Nzb7MQEnsKeU91bcnGcqQoyDmQJKUpafnfMpQ9uplZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NtM6XUdyOGaMTSux6J2dRXVlZM6So+Ty9wR4Cxs3uMIsJ41WIrgJ6mXk05DiWCOIy
	 sU9uu7SjzzkQjQJBj9Vh2jod9hREa+F5/oeShrHg3Hf/0E8ijkx1i1Ywuhrx7hW8Bg
	 FwqGzixLJ5lDtcyA1UaZOMM6chzyCuahkBa+ASOgTZhSL82W5IWGH/FJ68YteybMo+
	 I2TBm2KnRp7yAzuPQGo2lRg11jc9NgawaeoLe+ogd+BqVlxEHU439Pqdx/dEl7lIwi
	 YSarGScGDRAgnDX7kYZtHkHLL5Qmh/8GFESOfyHN4TbpCPJ4c6atvbh7vC9JMf+Wnr
	 alwGLPA2cHXtJqLxzHC8t83hkfuEp01IWY8V3Sf+iYOI84nN0OmCVSnxru5g1MmH5d
	 s4OGbs1dfyU2oTrqBcEpQFPi8ikviXEbb2xEMiLxl6iDlVElGgPqF+zZEXCRp7flvV
	 if4hkmHeO9KQHd+j1MZZLSg9tvfcQBIbTkYQWaKyedPCq/3rp9Lx6aCIKuHQSe3LT/
	 vFkUQ7yu0RPwVS3gPyr5UlTIGdkjPXwX5OtFWAndSJ5xZ0YDf1LCERff0rb/RAuuJO
	 ZDL6iHvI1pF+h7mPgRiM1UCRr3lspm6CwDXlrK5sqTYAVdZ2RVKo/zq4gs1FHA1SLu
	 LP/fvJzkcfQKv6YRjo8lCy0Y=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 331CC40E0177;
	Tue, 30 Jan 2024 10:59:53 +0000 (UTC)
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 1/4] x86/alternatives: Use a temporary buffer when optimizing NOPs
Date: Tue, 30 Jan 2024 11:59:38 +0100
Message-ID: <20240130105941.19707-2-bp@alien8.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130105941.19707-1-bp@alien8.de>
References: <20240130105941.19707-1-bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Instead of optimizing NOPs inplace, use a temporary buffer like the
usual alternatives patching flow does. This obviates the need to grab
locks when patching, see

  6778977590da ("x86/alternatives: Disable interrupts and sync when optim=
izing NOPs in place")

While at it, add nomenclature definitions clarifying and simplifying the
naming of function-local variables in the alternatives code.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/alternative.c | 78 +++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 36 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.=
c
index cc130b57542a..d633eb59f2b6 100644
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
+ * @replacement: pointer to the opcodes which are replacing @instr, loca=
ted in
+ * the .altinstr_replacement section.
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
-static void __init_or_module add_nop(u8 *instr, unsigned int len)
+static void __init_or_module add_nop(u8 *buf, unsigned int len)
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
 static bool __init_or_module
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
@@ -336,7 +340,7 @@ bool need_reloc(unsigned long offset, u8 *src, size_t=
 src_len)
 }
=20
 static void __init_or_module noinline
-apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *src, size_t src_len)
+apply_relocation(const u8 * const instr, u8 *buf, size_t len, u8 *src, s=
ize_t src_len)
 {
 	int prev, target =3D 0;
=20
@@ -348,7 +352,7 @@ apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *s=
rc, size_t src_len)
=20
 		next =3D i + insn.length;
=20
-		if (__optimize_nops(buf, len, &insn, &next, &prev, &target))
+		if (__optimize_nops(instr, buf, len, &insn, &next, &prev, &target))
 			continue;
=20
 		switch (insn.opcode.bytes[0]) {
@@ -365,7 +369,7 @@ apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *s=
rc, size_t src_len)
 			if (need_reloc(next + insn.immediate.value, src, src_len)) {
 				apply_reloc(insn.immediate.nbytes,
 					    buf + i + insn_offset_immediate(&insn),
-					    src - dest);
+					    src - instr);
 			}
=20
 			/*
@@ -373,7 +377,7 @@ apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *s=
rc, size_t src_len)
 			 */
 			if (insn.opcode.bytes[0] =3D=3D JMP32_INSN_OPCODE) {
 				s32 imm =3D insn.immediate.value;
-				imm +=3D src - dest;
+				imm +=3D src - instr;
 				imm +=3D JMP32_INSN_SIZE - JMP8_INSN_SIZE;
 				if ((imm >> 31) =3D=3D (imm >> 7)) {
 					buf[i+0] =3D JMP8_INSN_OPCODE;
@@ -389,7 +393,7 @@ apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *s=
rc, size_t src_len)
 			if (need_reloc(next + insn.displacement.value, src, src_len)) {
 				apply_reloc(insn.displacement.nbytes,
 					    buf + i + insn_offset_displacement(&insn),
-					    src - dest);
+					    src - instr);
 			}
 		}
 	}
@@ -505,7 +509,9 @@ void __init_or_module noinline apply_alternatives(str=
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
@@ -527,7 +533,7 @@ void __init_or_module noinline apply_alternatives(str=
uct alt_instr *start,
 		for (; insn_buff_sz < a->instrlen; insn_buff_sz++)
 			insn_buff[insn_buff_sz] =3D 0x90;
=20
-		apply_relocation(insn_buff, a->instrlen, instr, replacement, a->replac=
ementlen);
+		apply_relocation(instr, insn_buff, a->instrlen, replacement, a->replac=
ementlen);
=20
 		DUMP_BYTES(ALT, instr, a->instrlen, "%px:   old_insn: ", instr);
 		DUMP_BYTES(ALT, replacement, a->replacementlen, "%px:   rpl_insn: ", r=
eplacement);
@@ -762,7 +768,7 @@ void __init_or_module noinline apply_retpolines(s32 *=
start, s32 *end)
=20
 		len =3D patch_retpoline(addr, &insn, bytes);
 		if (len =3D=3D insn.length) {
-			optimize_nops(bytes, len);
+			optimize_nops(addr, bytes, len);
 			DUMP_BYTES(RETPOLINE, ((u8*)addr),  len, "%px: orig: ", addr);
 			DUMP_BYTES(RETPOLINE, ((u8*)bytes), len, "%px: repl: ", addr);
 			text_poke_early(addr, bytes, len);
--=20
2.43.0


