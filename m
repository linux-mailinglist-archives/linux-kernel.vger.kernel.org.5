Return-Path: <linux-kernel+bounces-17727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 010C58251A4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D8182821D5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E632D04E;
	Fri,  5 Jan 2024 10:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="lTY2I2j2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C6A2D042
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7835040E01B2;
	Fri,  5 Jan 2024 10:14:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id POynESw41eVs; Fri,  5 Jan 2024 10:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1704449651; bh=SWeBkHNitZrfqaHr9k7hYa07PFXcTJYXmqkwTlWLOqU=;
	h=From:To:Cc:Subject:Date:From;
	b=lTY2I2j2tpiQsKMPaeXx3Z0CgKKjXu6lw8qMNLsPYiZHXTeAmfOmJmYmBL/+zdB6d
	 xpPuFpjYr+YjQThAQu9ptiFN8StHE6wZJKv6Fi//qfRfE0vDl7a+3vbKAAdKyq2jv9
	 duB8Fr6JqXkVvjA238/nskKSyW1r2FoC87cJwpJa4D3B+TXv3HPaMfui/gPGs07VCk
	 3QLEs51a0btzL3BBMqABOHqerpX0H17bvcHL6h7dcjMtal9YjhM+nCekR/ANOO2tgH
	 XUKiL0SbbaawPlLhVCBH/46PsH6AY2cM8wth8XMUb5fupNV+z7eOaWP31/NYpDC1RN
	 RK/8fdiPMyIcFyaFhuN9enD2vQTQa0RkW+1T2uUTSpy9loE8SGOS1uVoEQfV8GUK7/
	 k+qZIpAbLhTN+UtHP+C0lLq8F9CJRbIjmLSd048wlc/MM1cPINL8x9vI956cctiiwo
	 Vou1oDz9oFGOgYalZXduhPsS7NZLVX5isBGeETUMyY1xEYrfScyKzENAzKZpcU3MBj
	 ZJimpx7l0HV5pa/GrqbvPs0D3OP4EzxOmSX+JV22gC8x3MvLM3t1XxsLv4wewz/W+f
	 QlRPaoOG/4lmwOcKpo3oquTQihjGoPF24L3C36nh9vIsfCEosG69vYU/s/f6tttjmO
	 IOhCqSpvi0z5mxJu3Qa6Sdno=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B4D2940E00C5;
	Fri,  5 Jan 2024 10:14:08 +0000 (UTC)
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/sev: Harden #VC insn emulation somewhat
Date: Fri,  5 Jan 2024 11:14:07 +0100
Message-ID: <20240105101407.11694-1-bp@alien8.de>
X-Mailer: git-send-email 2.42.0.rc0.25.ga82fb66fed25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Compare the opcode bytes at rIP for each #VC exit reason to verify the
instruction which raised the #VC exception is actually the right one.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/boot/compressed/sev.c |   4 ++
 arch/x86/kernel/sev-shared.c   | 102 ++++++++++++++++++++++++++++++++-
 arch/x86/kernel/sev.c          |   9 ++-
 3 files changed, 108 insertions(+), 7 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/se=
v.c
index 454acd7a2daf..073291832f44 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -304,6 +304,10 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigne=
d long exit_code)
 	if (result !=3D ES_OK)
 		goto finish;
=20
+	result =3D vc_check_opcode_bytes(&ctxt, exit_code);
+	if (result !=3D ES_OK)
+		goto finish;
+
 	switch (exit_code) {
 	case SVM_EXIT_RDTSC:
 	case SVM_EXIT_RDTSCP:
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index ccb0915e84e1..ec17931bf3cd 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -10,11 +10,15 @@
  */
=20
 #ifndef __BOOT_COMPRESSED
-#define error(v)	pr_err(v)
-#define has_cpuflag(f)	boot_cpu_has(f)
+#define error(v)			pr_err(v)
+#define has_cpuflag(f)			boot_cpu_has(f)
+#define sev_printk(fmt, ...)		printk(fmt, ##__VA_ARGS__)
+#define sev_printk_rtl(fmt, ...)	printk_ratelimited(fmt, ##__VA_ARGS__)
 #else
 #undef WARN
 #define WARN(condition, format...) (!!(condition))
+#define sev_printk(fmt, ...)
+#define sev_printk_rtl(fmt, ...)
 #endif
=20
 /* I/O parameters for CPUID-related helpers */
@@ -574,6 +578,7 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsig=
ned long exit_code)
 {
 	unsigned int subfn =3D lower_bits(regs->cx, 32);
 	unsigned int fn =3D lower_bits(regs->ax, 32);
+	u16 opcode =3D *(unsigned short *)regs->ip;
 	struct cpuid_leaf leaf;
 	int ret;
=20
@@ -581,6 +586,10 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsi=
gned long exit_code)
 	if (exit_code !=3D SVM_EXIT_CPUID)
 		goto fail;
=20
+	/* Is it really a CPUID insn? */
+	if (opcode !=3D 0xa20f)
+		goto fail;
+
 	leaf.fn =3D fn;
 	leaf.subfn =3D subfn;
=20
@@ -1170,3 +1179,92 @@ static int vmgexit_psc(struct ghcb *ghcb, struct s=
np_psc_desc *desc)
 out:
 	return ret;
 }
+
+static enum es_result vc_check_opcode_bytes(struct es_em_ctxt *ctxt,
+					    unsigned long exit_code)
+{
+	unsigned int opcode =3D (unsigned int)ctxt->insn.opcode.value;
+	u8 modrm =3D ctxt->insn.modrm.value;
+
+	switch (exit_code) {
+
+	case SVM_EXIT_IOIO:
+	case SVM_EXIT_NPF:
+		/* handled separately */
+		return ES_OK;
+
+	case SVM_EXIT_CPUID:
+		if (opcode =3D=3D 0xa20f)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_INVD:
+		sev_printk_rtl(KERN_ERR "#VC exception for INVD??? Seriously???\n");
+		return ES_UNSUPPORTED;
+		break;
+
+	case SVM_EXIT_MONITOR:
+		if (opcode =3D=3D 0x010f && modrm =3D=3D 0xc8)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_MWAIT:
+		if (opcode =3D=3D 0x010f && modrm =3D=3D 0xc9)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_MSR:
+		/* RDMSR */
+		if (opcode =3D=3D 0x320f ||
+		/* WRMSR */
+		    opcode =3D=3D 0x300f)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_RDPMC:
+		if (opcode =3D=3D 0x330f)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_RDTSC:
+		if (opcode =3D=3D 0x310f)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_RDTSCP:
+		if (opcode =3D=3D 0x010f && modrm =3D=3D 0xf9)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_READ_DR7:
+		if (opcode =3D=3D 0x210f &&
+		    X86_MODRM_REG(ctxt->insn.modrm.value) =3D=3D 7)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_VMMCALL:
+		if (opcode =3D=3D 0x010f && modrm =3D=3D 0xd9)
+			return ES_OK;
+
+		break;
+
+	case SVM_EXIT_WRITE_DR7:
+		if (opcode =3D=3D 0x230f &&
+		    X86_MODRM_REG(ctxt->insn.modrm.value) =3D=3D 7)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_WBINVD:
+		if (opcode =3D=3D 0x90f)
+			return ES_OK;
+		break;
+
+	default:
+		break;
+	}
+
+	sev_printk(KERN_ERR "Wrong/unhandled opcode bytes: 0x%x, exit_code: 0x%=
lx, rIP: 0x%lx\n",
+		   opcode, exit_code, ctxt->regs->ip);
+
+	return ES_UNSUPPORTED;
+}
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index c67285824e82..541a1f87b4f1 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1752,7 +1752,10 @@ static enum es_result vc_handle_exitcode(struct es=
_em_ctxt *ctxt,
 					 struct ghcb *ghcb,
 					 unsigned long exit_code)
 {
-	enum es_result result;
+	enum es_result result =3D vc_check_opcode_bytes(ctxt, exit_code);
+
+	if (result !=3D ES_OK)
+		return result;
=20
 	switch (exit_code) {
 	case SVM_EXIT_READ_DR7:
@@ -1771,10 +1774,6 @@ static enum es_result vc_handle_exitcode(struct es=
_em_ctxt *ctxt,
 	case SVM_EXIT_RDPMC:
 		result =3D vc_handle_rdpmc(ghcb, ctxt);
 		break;
-	case SVM_EXIT_INVD:
-		pr_err_ratelimited("#VC exception for INVD??? Seriously???\n");
-		result =3D ES_UNSUPPORTED;
-		break;
 	case SVM_EXIT_CPUID:
 		result =3D vc_handle_cpuid(ghcb, ctxt);
 		break;
--=20
2.42.0.rc0.25.ga82fb66fed25


