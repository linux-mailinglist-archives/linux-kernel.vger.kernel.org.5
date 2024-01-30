Return-Path: <linux-kernel+bounces-44444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 903F284221C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05A1C1F2D9E0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF1767759;
	Tue, 30 Jan 2024 11:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ksOA9VxR"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC4A6773D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706612407; cv=none; b=MQX9ha0fQpfqvpCwaNnCUEHGTVkbsGv6RaG00aE3bRZRyapEa12PQ1PYF9QtJ3IJTqSC06FdtpsyQvz548SKZRJGH80jHFwXa+74yAhQoFAobrZ3MSQSp91yMWytcwLrxEipEx1JrW5vAoieMwdGeqWJ0DVP85l9WhpkScSxoZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706612407; c=relaxed/simple;
	bh=VyFkxB0j+nOgvuEaixpEautusuHm3UDgi6it7/uVzp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUbk67UdOpkpZvBT8J8tnjBmYVTM358fglgnnLZ+j2gsVYInmullfxHz95PhlIncIrhyRe+8hLtRkAYh400WwNbT2k59f3IjUSlKUiCttrMBMuwSKF4CNbhRLW+LXYn5jue3xUe5oOszuJg856yZMygGF5Ze88cFQBioAgyIDe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ksOA9VxR reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 27EA540E0205;
	Tue, 30 Jan 2024 11:00:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VsO5Brlea4Hx; Tue, 30 Jan 2024 11:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706612401; bh=TdE1TyLPhJyinJAuaEh9u5E7I9lI8ReROFpNtz5Ue0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ksOA9VxRXoKxCcXqpVFvEHWsqjugfsl2cCY3Yp2zuFJdL7MvL8RKYmnNKwj525F6d
	 en2M0W7UMbYBfJuTLQQjL9k1G05EVNPa9nfGgMdgE5tZf4+aakZ4E65fJFLWd4bH9b
	 IcBiWgGJs+6cFjvm+5HX3ccbBfTXwar2HiB4WGLIhRqA547I9gxsfH9+n5ol3M4l0d
	 NMLjzY7UvPwdlg4qpNDERdgAowtmDcbOzkLwlu3TQl7xTxvqwBdth0i6M7jMTfbw0K
	 GUBBk/F0yk+a1uL4XiKN2QGwkHiPeeu9VjZ5MXD7wCKwsp4S8LwKAXaRkVl0Gx0Zvx
	 1wZzI3osDmr1aiIjag4ANDfIzoF8/9ccHYCe3oyd2ZAYnrh1zSSbqQkC5IsI0B7ykd
	 t/ft3zDkGBAQ0SYEhbctQiP8GKemKBweltiLvd7PW3ewKbBpEmc995dgZasCE0eNTL
	 7hWlsHkHlXbn7UAnncetj2nft/Df+CkIEZU83fdJU7KbtUAWYuUDI5JukOnBZUxEbQ
	 yF+sRwwNtX1OBxnU3CrN/XisSh39KsBUqVz7mRkovuN64Ge0Dzvur0K56sUE47Gn4a
	 EB+CDQ7wEASszHfNDvpMNTvvtBAj5Py1G8IpzGYZNkgCzGmgWmH1q2BjVDu2/FVkfh
	 /JmZT1onOxRj9LqQs/TYCICI=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C786040E00C5;
	Tue, 30 Jan 2024 10:59:58 +0000 (UTC)
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] x86/alternatives: Get rid of __optimize_nops()
Date: Tue, 30 Jan 2024 11:59:39 +0100
Message-ID: <20240130105941.19707-3-bp@alien8.de>
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

There's no need to carve out bits of the NOP optimization functionality
and look at JMP opcodes - simply do one more NOPs optimization pass
at the end of the patching.

A lot simpler code.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/alternative.c | 52 +++++++----------------------------
 1 file changed, 10 insertions(+), 42 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.=
c
index d633eb59f2b6..2dd1c7fe0949 100644
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
-static bool __init_or_module
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
 static void __init_or_module noinline optimize_nops(const u8 * const ins=
tr, u8 *buf, size_t len)
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
@@ -342,8 +314,6 @@ bool need_reloc(unsigned long offset, u8 *src, size_t=
 src_len)
 static void __init_or_module noinline
 apply_relocation(const u8 * const instr, u8 *buf, size_t len, u8 *src, s=
ize_t src_len)
 {
-	int prev, target =3D 0;
-
 	for (int next, i =3D 0; i < len; i =3D next) {
 		struct insn insn;
=20
@@ -352,9 +322,6 @@ apply_relocation(const u8 * const instr, u8 *buf, siz=
e_t len, u8 *src, size_t sr
=20
 		next =3D i + insn.length;
=20
-		if (__optimize_nops(instr, buf, len, &insn, &next, &prev, &target))
-			continue;
-
 		switch (insn.opcode.bytes[0]) {
 		case 0x0f:
 			if (insn.opcode.bytes[1] < 0x80 ||
@@ -533,7 +500,8 @@ void __init_or_module noinline apply_alternatives(str=
uct alt_instr *start,
 		for (; insn_buff_sz < a->instrlen; insn_buff_sz++)
 			insn_buff[insn_buff_sz] =3D 0x90;
=20
-		apply_relocation(instr, insn_buff, a->instrlen, replacement, a->replac=
ementlen);
+		apply_relocation(instr, insn_buff, a->instrlen, replacement, insn_buff=
_sz);
+		optimize_nops(instr, insn_buff, insn_buff_sz);
=20
 		DUMP_BYTES(ALT, instr, a->instrlen, "%px:   old_insn: ", instr);
 		DUMP_BYTES(ALT, replacement, a->replacementlen, "%px:   rpl_insn: ", r=
eplacement);
--=20
2.43.0


