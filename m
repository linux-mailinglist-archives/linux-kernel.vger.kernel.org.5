Return-Path: <linux-kernel+bounces-21625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAFE82920C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 02:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBA81B2505A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13CC17E4;
	Wed, 10 Jan 2024 01:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aK/Ml+5q"
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F4E1373
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 01:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-7bee30dea21so125749039f.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 17:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704850012; x=1705454812; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k5v8oUBjXEAVbu4/vqslVZCTCJ0ygzsKmcB0GfrIu20=;
        b=aK/Ml+5qs+I/P7gpDjm67YtaK5K+pO5Y2PVDUzP0QcpHDeuK1reVt+hoCUOGIxs/jh
         1aYDk1KlzqzMsV7cLot3cNJv8knvYSyx2rWarBTVbWX37FVdkpLGexKAY5r6G8qiWAFq
         iYp8TopyJLjQYey7bapO5F+dZ2GcfE+euDgVRoFdEir1NuIkYRJ6MuhSVavUk/03RIso
         9d5nSrS7rajEWtdaLAb0A+S1pIJqCvhfHE9IUtKQ5wl22fvlKPJll+QnD9li+ti6U5SY
         Vr+mGwieVMMUJ9lgxmcwPEWSwJYMLpI73JD1lq17T2qYoEXvU4alSUvokKFWDmEsfBxU
         cULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704850012; x=1705454812;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k5v8oUBjXEAVbu4/vqslVZCTCJ0ygzsKmcB0GfrIu20=;
        b=qvS5v6+CXBpYtPVD8V7sIPR3k0eybig4NQhTVAhqPpF2t8q2bmbe2PXLMaO0InMuVk
         VcUJd+EL8NLlswEnw7zmjn2Uj6OSe8Y9tIgC8lnE/EycXS1yyfMaTsVDxeRuvp6647uK
         hQHaOv34lA6LjjX3LIuyK15xAi316e4VTOa75ayYcjRC+s5rlw8gS99RnHVXYgQnWxej
         OWYJDDOWOw64RnXjFBN6RcHzWpjPrHhKkdd2H37pnUIg8jPnz2DzuES8H4P+9sDa6fK4
         q6lYrpBKFx9Jgr/qqcjM4Wp+iQaF28WEzzYiJ9JTAAgSdfb+/JU9QCiHBhLDoyXOSphM
         wHjA==
X-Gm-Message-State: AOJu0YyHS75K+F8HexcjoEuxXThyO2B0/bAQZpp0cgH/3u+WXmt9F7Is
	Wn63QmMFl3bmfkUXz+5n+ZVz8IA14ARCRGHsB6YCfv8mlv4=
X-Google-Smtp-Source: AGHT+IFw+G2FQxRDkksoxjc8deUmz4WU+ECeujMhwOD2760Mzm4ZYaoCgZNF2Ucn1CHML3j5eZGJdt5/7obNiAMBn9Jp
X-Received: from loughlin00.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:1b6f])
 (user=kevinloughlin job=sendgmr) by 2002:a05:6638:2645:b0:46e:308a:832 with
 SMTP id n5-20020a056638264500b0046e308a0832mr15553jat.3.1704850012536; Tue,
 09 Jan 2024 17:26:52 -0800 (PST)
Date: Wed, 10 Jan 2024 01:26:39 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240110012640.1335694-1-kevinloughlin@google.com>
Subject: [RFC PATCH] x86/sev: x86/sev: enforce PC-relative addressing in clang
From: Kevin Loughlin <kevinloughlin@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	"GitAuthor: Kevin Loughlin" <kevinloughlin@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Kees Cook <keescook@chromium.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Ze Gao <zegao2021@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Pengfei Xu <pengfei.xu@intel.com>, Brijesh Singh <brijesh.singh@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-coco@lists.linux.dev
Cc: Adam Dunlap <acdunlap@google.com>, Peter Gonda <pgonda@google.com>, 
	Jacob Xu <jacobhxu@google.com>, Sidharth Telang <sidtelang@google.com>
Content-Type: text/plain; charset="UTF-8"

SEV/SME code can execute prior to page table fixups for kernel
relocation. However, as with global variables accessed in
__startup_64(), clang does not currently generate PC-relative accesses
for SEV/SME global variables, causing certain flavors of SEV hosts and
guests to crash.

While an attempt was made to force PC-relative addressing for certain
global SEV/SME variables via inline assembly (see snp_cpuid_get_table()
for example), PC-relative addressing must be pervasively-enforced for
SEV/SME global variables that can be accessed prior to page table
fixups.

To avoid the error-prone approach of manually referencing each SEV/SME
global variable via a general form of snp_cpuid_get_table(), it is
preferable to use compiler flags for position-independent code (ex:
`-fPIE`) that result in PC-relative accesses. While architecture-
specific code for Linux can be pervasively compiled as position-
independent on select architectures (ex: RISC-V), this is not currently
the case for x86-64 and would require extensive changes (see "[PATCH
RFC 00/43] x86/pie: Make kernel image's virtual address flexible" for
example).

Fortunately, the relevant files for SEV/SME code do indeed support
position-independent clang compilation, so we can use this technique to
ensure all global variables in these files are accessed via PC-relative
addressing.

Unlike clang, gcc does not currently allow `-fPIE` in conjunction with
`mcmodel=kernel`. Thus, to preserve existing gcc behavior, this patch
does not remove the (otherwise unnecessary) inline assembly that
already enforces PC-relative addressing for select SEV/SME globals
(mentioned above). If gcc supports these joint options in the future,
we can remove such inline assembly and also apply this patch to gcc
builds.

Tested by successful boot of SEV-SNP guest built with clang, alongside
Adam Dunlap's necessary "[PATCH v2] x86/asm: Force native_apic_mem_read
to use mov".

Fixes: 95d33bfaa3e1 ("x86/sev: Register GHCB memory when SEV-SNP is active")
Fixes: ee0bfa08a345 ("x86/compressed/64: Add support for SEV-SNP CPUID table in #VC handlers")
Fixes: 1cd9c22fee3a ("x86/mm/encrypt: Move page table helpers into separate translation unit")
Fixes: c9f09539e16e ("x86/head/64: Check SEV encryption before switching to kernel page-table")
Fixes: b577f542f93c ("x86/coco: Add API to handle encryption mask")
Tested-by: Kevin Loughlin <kevinloughlin@google.com>
Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
---
 arch/x86/coco/Makefile   | 10 ++++++++++
 arch/x86/kernel/Makefile | 10 ++++++++++
 arch/x86/mm/Makefile     | 13 +++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/arch/x86/coco/Makefile b/arch/x86/coco/Makefile
index c816acf78b6a..286950596ee9 100644
--- a/arch/x86/coco/Makefile
+++ b/arch/x86/coco/Makefile
@@ -5,4 +5,14 @@ CFLAGS_core.o		+= -fno-stack-protector
 
 obj-y += core.o
 
+# clang allows -fPIE with mcmodel=kernel; gcc currently does not.
+ifdef CONFIG_CC_IS_CLANG
+# Enforce PC-relative addressing for SEV/SME global variables.
+CFLAGS_core.o		+= -fPIE
+# Disable relocation relaxation in case the link is not PIE.
+CFLAGS_core.o 		+= $(call cc-option,-Wa$(comma)-mrelax-relocations=no)
+# Avoid unnecessary GOT overhead in PC-relative addressing.
+CFLAGS_core.o 		+= -include $(srctree)/include/linux/hidden.h
+endif
+
 obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx/
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 0000325ab98f..bf85f9de89e9 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -7,6 +7,16 @@ extra-y	+= vmlinux.lds
 
 CPPFLAGS_vmlinux.lds += -U$(UTS_MACHINE)
 
+# clang allows -fPIE with mcmodel=kernel; gcc currently does not.
+ifdef CONFIG_CC_IS_CLANG
+# Enforce PC-relative addressing for SEV/SME global variables.
+CFLAGS_sev.o += -fPIE
+# Disable relocation relaxation in case the link is not PIE.
+CFLAGS_sev.o += $(call cc-option,-Wa$(comma)-mrelax-relocations=no)
+# Avoid unnecessary GOT overhead in PC-relative addressing.
+CFLAGS_sev.o += -include $(srctree)/include/linux/hidden.h
+endif
+
 ifdef CONFIG_FUNCTION_TRACER
 # Do not profile debug and lowlevel utilities
 CFLAGS_REMOVE_tsc.o = -pg
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index c80febc44cd2..7abf20a94451 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -17,6 +17,19 @@ KCSAN_SANITIZE := n
 # Avoid recursion by not calling KMSAN hooks for CEA code.
 KMSAN_SANITIZE_cpu_entry_area.o := n
 
+# clang allows -fPIE with mcmodel=kernel; gcc currently does not.
+ifdef CONFIG_CC_IS_CLANG
+# Enforce PC-relative addressing for SEV/SME global variables.
+CFLAGS_mem_encrypt_amd.o 	+= -fPIE
+CFLAGS_mem_encrypt_identity.o 	+= -fPIE
+# Disable relocation relaxation in case the link is not PIE.
+CFLAGS_mem_encrypt_amd.o 	+= $(call cc-option,-Wa$(comma)-mrelax-relocations=no)
+CFLAGS_mem_encrypt_identity.o 	+= $(call cc-option,-Wa$(comma)-mrelax-relocations=no)
+# Avoid unnecessary GOT overhead in PC-relative addressing.
+CFLAGS_mem_encrypt_amd.o 	+= -include $(srctree)/include/linux/hidden.h
+CFLAGS_mem_encrypt_identity.o 	+= -include $(srctree)/include/linux/hidden.h
+endif
+
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_mem_encrypt.o		= -pg
 CFLAGS_REMOVE_mem_encrypt_amd.o		= -pg
-- 
2.43.0.275.g3460e3d667-goog


