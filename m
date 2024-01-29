Return-Path: <linux-kernel+bounces-43277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D98808411AE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95C81286EE0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390FD159593;
	Mon, 29 Jan 2024 18:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="4GM0rg7A"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32EB159560
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 18:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551555; cv=none; b=lMgqJNSBGgRssKb99/4f5NSuuIMQhYH0cOBpmc1A29hU3D7OB5ZdtpaNxF1ER0RHBtNXCwaBp0LoXzT7GhTNqrizv1kWuVSOD95aR1rvqQF2uBv+ZiF7VY3f0UYuYZWAlgvH8/ejuTADj1vwIDXyVrn41dxA+87ma5crWcfIIVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551555; c=relaxed/simple;
	bh=UonHlMqjgEJH+56iHsla4J1Fp0ovIjuTCcCNqIOSjk0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qltc/y02OhKu3H9nKGjvMZo/UPVrj4+r7xnuow8XyGq5mWTKl0jLQjd23Z017LhqZ5xGGw9Fosj+rMQbDAjV2Y0WwDQq3NC4Oqq/owZjPOrAflyTgSCSKaz7p4ZzsXvmBCFVddZM9InWe3ZsbRhSqWNfi+opSThyETfDJypb17Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4GM0rg7A; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64e0fc7c8so4071021276.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706551553; x=1707156353; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ap19tN/uXJaW7OWqMmvQ4dnQyY/I7jMfOfg7BtI2vyw=;
        b=4GM0rg7AYbDNE5b5L8LZUCm/+mATnFwYmb2Xkjvp2c9whD1wMHMzU+vmAr5Bzjofcr
         iT1wBEwdmky7FvDrDhkWQ2iPjijLD6RlNS41sbIZuREqAmuGX+oPCconluCWvxlEfbt/
         Ti5Ughww7+m0YYmff6vRvOtlIKsUwXPtIaeqKASD0sP5OcQ5x63Mh6uNzu9vDltoD5DC
         4myoQEx64XVmkdjN22Smx1YfZJndmb+qt+N6p6vKH+wfYKYZjb7g3gP9sMPy8uyjjDPN
         UdYc5rDHSroKTGu9WgviNBbpR3CTNWXI+apI9zQ0R/IKuqt5stMuPtLodGpi8S0KZ0Av
         Decw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706551553; x=1707156353;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ap19tN/uXJaW7OWqMmvQ4dnQyY/I7jMfOfg7BtI2vyw=;
        b=Qff15sBM2m8OpA3IEL7JCEi72UNGzTXjl3jS3oI/s8B0Sbg6h5dMMqY+f30g+0EmPI
         SWprxY95wnWxAs1cPnOwxZ6WrgnGS/YME2S9ls6c00ueVsBgJabCIkTqG5ZPxiX+UCOs
         SoL5Ul9MHtnF2ovBTX7x+nxIXlC2V9YY4+KAn1pgC/MEiqH2fnSogW/9RqaoIY1sPeCE
         k5YJF/+0j8Y2zU9JrrWiLrGGYEoJfhcPVrP9JbUsEKhiRm5/5cB2k/U87RLm2el53Ur0
         u83rYIrpZuYTy2j2A8VSoH90QqRPVwXBLClnsUHLQhp2dKEb0ZQi9LUO8/MJsNw29Dam
         wtMQ==
X-Gm-Message-State: AOJu0YxfyCgg886uxsXGIOC0SpmEn44RjPiH3sC9otxLkf7t06AWvCuu
	RUb5c6+7rTq190p7f90nIAdX+wRg7rOBWErsYNlZbyK3LtHJD8wHIy3K8p4GosNYSPyFodoCO7v
	TcEsKJkVJ2VD26Qk2e29pVqP2h1h9hwPApmvttLvkQSX1MClhs/fgbLwGYwL1rDAZIT9d2c2HUz
	NabhZEP8DjF8khqR7LDHd3KAsLaEMcqA==
X-Google-Smtp-Source: AGHT+IFdlkgRmOLuPYQ4HYGJOcfOyvmrF8pJsjH+7Ju2xNGTWiYFEILGYxiFeCWVd7IhoWiApQSqZNZJ
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:1b01:b0:dc2:3619:e94e with SMTP id
 eh1-20020a0569021b0100b00dc23619e94emr414348ybb.6.1706551552670; Mon, 29 Jan
 2024 10:05:52 -0800 (PST)
Date: Mon, 29 Jan 2024 19:05:13 +0100
In-Reply-To: <20240129180502.4069817-21-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240129180502.4069817-21-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4822; i=ardb@kernel.org;
 h=from:subject; bh=Kb1Zn5CHQVUPzxgeHo6uRlzKgwc2NWlyfd+RzWsJs24=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXX7i1tSpVekMhqlzlrlfb/JMsl/O//tz/rfnvtxfTN9K
 xfxQaivo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEwkX5Lhv5OomU7pjraIyH/7
 ztt9/Of40YFDqmqzV+W3Fp85b/RspRj+yorzxqrcmK60VSHRPl6b5eeETAbXibMsFrfufP7hcKI IBwA=
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240129180502.4069817-31-ardb+git@google.com>
Subject: [PATCH v3 10/19] asm-generic: Add special .pi.text section for
 position independent code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Add a special .pi.text section that architectures will use to carry code
that can be called while the kernel is executing from a different
virtual address than its link time address. This is typically needed by
very early boot code that executes from a 1:1 mapping, and may need to
call into other code to perform preparatory tasks that must be completed
before switching to the kernel's ordinary virtual mapping.

Note that this implies that the code in question cannot generally be
instrumented safely, and so the contents are combined with the existing
noinstr.text section, making .pi.text a proper subset of the former.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/asm-generic/vmlinux.lds.h |  3 +++
 include/linux/init.h              | 12 +++++++++
 scripts/mod/modpost.c             |  5 +++-
 tools/objtool/check.c             | 26 ++++++++------------
 4 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 5dd3a61d673d..70c9767cac5a 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -553,6 +553,9 @@
 		__cpuidle_text_start = .;				\
 		*(.cpuidle.text)					\
 		__cpuidle_text_end = .;					\
+		__pi_text_start = .;					\
+		*(.pi.text)						\
+		__pi_text_end = .;					\
 		__noinstr_text_end = .;
 
 /*
diff --git a/include/linux/init.h b/include/linux/init.h
index 3fa3f6241350..85bb701b664c 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -55,6 +55,17 @@
 #define __exitdata	__section(".exit.data")
 #define __exit_call	__used __section(".exitcall.exit")
 
+/*
+ * __pitext should be used to mark code that can execute correctly from a
+ * different virtual offset than the kernel was linked at. This is used for
+ * code that is called extremely early during boot.
+ *
+ * Note that this is incompatible with KAsan, which applies an affine
+ * translation to the virtual address to obtain the shadow address which is
+ * strictly tied to the kernel's virtual address space.
+ */
+#define __pitext	__section(".pi.text") __no_sanitize_address notrace
+
 /*
  * modpost check for section mismatches during the kernel build.
  * A section mismatch happens when there are references from a
@@ -92,6 +103,7 @@
 
 /* For assembly routines */
 #define __HEAD		.section	".head.text","ax"
+#define __PITEXT	.section	".pi.text","ax"
 #define __INIT		.section	".init.text","ax"
 #define __FINIT		.previous
 
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 795b21154446..962d00df47ab 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -813,9 +813,12 @@ static void check_section(const char *modname, struct elf_info *elf,
 
 #define INIT_SECTIONS      ".init.*"
 
-#define ALL_TEXT_SECTIONS  ".init.text", ".meminit.text", ".exit.text", \
+#define ALL_PI_TEXT_SECTIONS  ".pi.text", ".pi.text.*"
+#define ALL_NON_PI_TEXT_SECTIONS  ".init.text", ".meminit.text", ".exit.text", \
 		TEXT_SECTIONS, OTHER_TEXT_SECTIONS
 
+#define ALL_TEXT_SECTIONS  ALL_NON_PI_TEXT_SECTIONS, ALL_PI_TEXT_SECTIONS
+
 enum mismatch {
 	TEXTDATA_TO_ANY_INIT_EXIT,
 	XXXINIT_TO_SOME_INIT,
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 548ec3cd7c00..af8f23a96037 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -389,6 +389,7 @@ static int decode_instructions(struct objtool_file *file)
 		if (!strcmp(sec->name, ".noinstr.text") ||
 		    !strcmp(sec->name, ".entry.text") ||
 		    !strcmp(sec->name, ".cpuidle.text") ||
+		    !strncmp(sec->name, ".pi.text", 8) ||
 		    !strncmp(sec->name, ".text..__x86.", 13))
 			sec->noinstr = true;
 
@@ -4234,23 +4235,16 @@ static int validate_noinstr_sections(struct objtool_file *file)
 {
 	struct section *sec;
 	int warnings = 0;
+	static char const *noinstr_sections[] = {
+		".noinstr.text", ".entry.text", ".cpuidle.text", ".pi.text",
+	};
 
-	sec = find_section_by_name(file->elf, ".noinstr.text");
-	if (sec) {
-		warnings += validate_section(file, sec);
-		warnings += validate_unwind_hints(file, sec);
-	}
-
-	sec = find_section_by_name(file->elf, ".entry.text");
-	if (sec) {
-		warnings += validate_section(file, sec);
-		warnings += validate_unwind_hints(file, sec);
-	}
-
-	sec = find_section_by_name(file->elf, ".cpuidle.text");
-	if (sec) {
-		warnings += validate_section(file, sec);
-		warnings += validate_unwind_hints(file, sec);
+	for (int i = 0; i < ARRAY_SIZE(noinstr_sections); i++) {
+		sec = find_section_by_name(file->elf, noinstr_sections[i]);
+		if (sec) {
+			warnings += validate_section(file, sec);
+			warnings += validate_unwind_hints(file, sec);
+		}
 	}
 
 	return warnings;
-- 
2.43.0.429.g432eaa2c6b-goog


