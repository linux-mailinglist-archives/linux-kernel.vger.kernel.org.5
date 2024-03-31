Return-Path: <linux-kernel+bounces-126336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A349589354D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 20:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22D8AB2344E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180B9146002;
	Sun, 31 Mar 2024 18:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fYWTb4OR"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3C41DDCE
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 18:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711908071; cv=none; b=eh6E2aUccOJX3OnrO9aARnhStkeyzEqk/Tpa+PBwtKORnyNp9DpqsyZMm3fv1B7c94EeEoob10mtjd8TncaR7WwfsKqeroi9R59FcjeFx6AZ3tlwf5VrIETrbrBnA7yRdtMI9EK1dcl2TxJgdBk2B5q7LzkCQ0U+qomBdoR30ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711908071; c=relaxed/simple;
	bh=u6yw/6pNiS6XlXi0fw+StuO0q4IRQWyeHy0X63Dcn34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CFpHosd2XqJJTpyYg47+vL89gmOezQoPyu9h0DKKJuPr3Sx4GjCO1c1rERMQyqpuEyRAVDD2QH/Q/FDX7DQM8jpzBnSDA4J3hIB8+04uEqTPxaLpEgrI7/2B0nikGDaOtje43mcdJcvutaP1Ne7Yl0c7rGKXH+Rf2vKUwCC4pQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fYWTb4OR reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 87C0C40E02A7;
	Sun, 31 Mar 2024 18:01:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id baCB6NFuj8Nw; Sun, 31 Mar 2024 18:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711908063; bh=/m+xg3eCZn7BMsmZutP2oDLl0SFWMQPzolR2d5YsX+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fYWTb4ORgog9/JdWoCnaMBIKEb3AgBwPy9jmp/TKyjiC9NyBfs9nCGFhXzvB6ZK8g
	 hbBXE8JFqxS/CkbjF/4YFwcOP7eGOpNxx5mmZV6Q2fKgyJbg6w2aOkqUW/U7qrRab/
	 46X1byWJRAGvlRK0y2rrdq0crfR3H/JDj6OU7jwt+o0QBIl6HvgFEEwGGCNo6EO2Nr
	 pqBJYPEu0YNJdLFgCvxmQXUVyen65HWMxx1ba6xIUzZgbLCzy/hqMddlZoFx9jS+/T
	 +XUXWc5j70PFrBNG/lrBDD3etOGcvR2CuU7fer5oP3G+kR5W6/++WVOlMxtB1Qe+I1
	 asxk2gMTW81Ya0D+cMv1ZQb7VBPsnXwSt1C5IA1FblqXuIOapZ954sbrnVJ5V3utuX
	 DbTZy88tm2J14/6SsxBRy8ACDNGPr0JXdYYWh/SZYUFTNpeeb35VmR3+s+syWpaaTp
	 oUy5cSwTSo0JjR9dLvbTPLwCQgsaGzjS2BjB9OHV/Eck90+FPXUQnkvm94xa5qzAIy
	 g1ckci0ZevmbjhQyDwQqN4NIVOezIHIjGk14RGO9o96we098WVHylygI+LXP8FUFgv
	 kKPVbtiiJJrg0mU50PWn9VPWVfITnPll85kt/w7laTmc3CyWVbg3KjbgGvaTp354QV
	 NKZ2OkMhCdQzmPs7O/hQej8E=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6E76340E0028;
	Sun, 31 Mar 2024 18:01:01 +0000 (UTC)
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/4] x86/alternatives: Get rid of __optimize_nops()
Date: Sun, 31 Mar 2024 20:00:40 +0200
Message-ID: <20240331180042.13933-3-bp@alien8.de>
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

There's no need to carve out bits of the NOP optimization functionality
and look at JMP opcodes - simply do one more NOPs optimization pass
at the end of patching.

A lot simpler code.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/alternative.c | 59 ++++++++++-------------------------
 1 file changed, 16 insertions(+), 43 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.=
c
index ec94f1359c00..4b3378c71518 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -216,47 +216,12 @@ static int skip_nops(u8 *buf, int offset, int len)
 	return offset;
 }
=20
-/*
- * Optimize a sequence of NOPs, possibly preceded by an unconditional ju=
mp
- * to the end of the NOP sequence into a single NOP.
- */
-static bool
-__optimize_nops(const u8 * const instr, u8 *buf, size_t len, struct insn=
 *insn, int *next, int *prev, int *target)
-{
-	int i =3D *next - insn->length;
-
-	switch (insn->opcode.bytes[0]) {
-	case JMP8_INSN_OPCODE:
-	case JMP32_INSN_OPCODE:
-		*prev =3D i;
-		*target =3D *next + insn->immediate.value;
-		return false;
-	}
-
-	if (insn_is_nop(insn)) {
-		int nop =3D i;
-
-		*next =3D skip_nops(buf, *next, len);
-		if (*target && *next =3D=3D *target)
-			nop =3D *prev;
-
-		add_nop(buf + nop, *next - nop);
-		DUMP_BYTES(ALT, buf, len, "%px: [%d:%d) optimized NOPs: ", instr, nop,=
 *next);
-		return true;
-	}
-
-	*target =3D 0;
-	return false;
-}
-
 /*
  * "noinline" to cause control flow change and thus invalidate I$ and
  * cause refetch after modification.
  */
-static void __init_or_module noinline optimize_nops(const u8 * const ins=
tr, u8 *buf, size_t len)
+static void noinline optimize_nops(const u8 * const instr, u8 *buf, size=
_t len)
 {
-	int prev, target =3D 0;
-
 	for (int next, i =3D 0; i < len; i =3D next) {
 		struct insn insn;
=20
@@ -265,7 +230,14 @@ static void __init_or_module noinline optimize_nops(=
const u8 * const instr, u8 *
=20
 		next =3D i + insn.length;
=20
-		__optimize_nops(instr, buf, len, &insn, &next, &prev, &target);
+		if (insn_is_nop(&insn)) {
+			int nop =3D i;
+
+			next =3D skip_nops(buf, next, len);
+
+			add_nop(buf + nop, next - nop);
+			DUMP_BYTES(ALT, buf, len, "%px: [%d:%d) optimized NOPs: ", instr, nop=
, next);
+		}
 	}
 }
=20
@@ -339,10 +311,8 @@ bool need_reloc(unsigned long offset, u8 *src, size_=
t src_len)
 	return (target < src || target > src + src_len);
 }
=20
-void apply_relocation(u8 *buf, const u8 * const instr, size_t instrlen, =
u8 *repl, size_t repl_len)
+static void __apply_relocation(u8 *buf, const u8 * const instr, size_t i=
nstrlen, u8 *repl, size_t repl_len)
 {
-	int prev, target =3D 0;
-
 	for (int next, i =3D 0; i < instrlen; i =3D next) {
 		struct insn insn;
=20
@@ -351,9 +321,6 @@ void apply_relocation(u8 *buf, const u8 * const instr=
, size_t instrlen, u8 *repl
=20
 		next =3D i + insn.length;
=20
-		if (__optimize_nops(instr, buf, instrlen, &insn, &next, &prev, &target=
))
-			continue;
-
 		switch (insn.opcode.bytes[0]) {
 		case 0x0f:
 			if (insn.opcode.bytes[1] < 0x80 ||
@@ -398,6 +365,12 @@ void apply_relocation(u8 *buf, const u8 * const inst=
r, size_t instrlen, u8 *repl
 	}
 }
=20
+void apply_relocation(u8 *buf, const u8 * const instr, size_t instrlen, =
u8 *repl, size_t repl_len)
+{
+	__apply_relocation(buf, instr, instrlen, repl, repl_len);
+	optimize_nops(instr, buf, repl_len);
+}
+
 /* Low-level backend functions usable from alternative code replacements=
 */
 DEFINE_ASM_FUNC(nop_func, "", .entry.text);
 EXPORT_SYMBOL_GPL(nop_func);
--=20
2.43.0


