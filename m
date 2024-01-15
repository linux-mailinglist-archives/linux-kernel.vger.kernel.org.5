Return-Path: <linux-kernel+bounces-26551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2867782E37D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF111B22303
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 23:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F221BC48;
	Mon, 15 Jan 2024 23:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqTShLyf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E241D53F;
	Mon, 15 Jan 2024 23:25:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0273CC433F1;
	Mon, 15 Jan 2024 23:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705361128;
	bh=k37eJCY07AEZqLlFLPnDrGpBy8eoA2dcdOof7puS9wU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fqTShLyf6QkO16piSRW0xrV+6so9kD6ZmWaUZvRE0qj2jAhtUwjMWSXqouKCTHjQu
	 SOwpcUl2XT3vhCb0l+PD5SF6YT8b/uycpdJCXuHXiQtA9EH9u9N8DDOzmBJ9Q4z6dl
	 suB3qX4lNnPH5ATZ0tOFbDshx/HDZQGHwx8JN711jbpi9H1ka08EBEz7tc9J1PGnNf
	 29WXFHwCAoN0vA4/AoD1U5Nb9wYJwskC0NHfLtwS019IFfLiOv3FbGdswTxViSEYON
	 S9PZlulxKTQuZZfeqnj+NmHq4zGY57dC0urnUKz0Cdn6LLUORPEEokRjITghBu/haj
	 7ISNbJw6KLj9g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jun'ichi Nomura <junichi.nomura@nec.com>,
	Derek Barbosa <debarbos@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	kirill.shutemov@linux.intel.com,
	ardb@kernel.org,
	nikunj@amd.com,
	thomas.lendacky@amd.com
Subject: [PATCH AUTOSEL 6.6 09/14] x86/boot: Ignore NMIs during very early boot
Date: Mon, 15 Jan 2024 18:24:32 -0500
Message-ID: <20240115232501.208889-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115232501.208889-1-sashal@kernel.org>
References: <20240115232501.208889-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Jun'ichi Nomura <junichi.nomura@nec.com>

[ Upstream commit 78a509fba9c9b1fcb77f95b7c6be30da3d24823a ]

When there are two racing NMIs on x86, the first NMI invokes NMI handler and
the 2nd NMI is latched until IRET is executed.

If panic on NMI and panic kexec are enabled, the first NMI triggers
panic and starts booting the next kernel via kexec. Note that the 2nd
NMI is still latched. During the early boot of the next kernel, once
an IRET is executed as a result of a page fault, then the 2nd NMI is
unlatched and invokes the NMI handler.

However, NMI handler is not set up at the early stage of boot, which
results in a boot failure.

Avoid such problems by setting up a NOP handler for early NMIs.

[ mingo: Refined the changelog. ]

Signed-off-by: Jun'ichi Nomura <junichi.nomura@nec.com>
Signed-off-by: Derek Barbosa <debarbos@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/boot/compressed/ident_map_64.c    | 5 +++++
 arch/x86/boot/compressed/idt_64.c          | 1 +
 arch/x86/boot/compressed/idt_handlers_64.S | 1 +
 arch/x86/boot/compressed/misc.h            | 1 +
 4 files changed, 8 insertions(+)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index 08f93b0401bb..aead80ec70a0 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -385,3 +385,8 @@ void do_boot_page_fault(struct pt_regs *regs, unsigned long error_code)
 	 */
 	kernel_add_identity_map(address, end);
 }
+
+void do_boot_nmi_trap(struct pt_regs *regs, unsigned long error_code)
+{
+	/* Empty handler to ignore NMI during early boot */
+}
diff --git a/arch/x86/boot/compressed/idt_64.c b/arch/x86/boot/compressed/idt_64.c
index 3cdf94b41456..d100284bbef4 100644
--- a/arch/x86/boot/compressed/idt_64.c
+++ b/arch/x86/boot/compressed/idt_64.c
@@ -61,6 +61,7 @@ void load_stage2_idt(void)
 	boot_idt_desc.address = (unsigned long)boot_idt;
 
 	set_idt_entry(X86_TRAP_PF, boot_page_fault);
+	set_idt_entry(X86_TRAP_NMI, boot_nmi_trap);
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	/*
diff --git a/arch/x86/boot/compressed/idt_handlers_64.S b/arch/x86/boot/compressed/idt_handlers_64.S
index 22890e199f5b..4d03c8562f63 100644
--- a/arch/x86/boot/compressed/idt_handlers_64.S
+++ b/arch/x86/boot/compressed/idt_handlers_64.S
@@ -70,6 +70,7 @@ SYM_FUNC_END(\name)
 	.code64
 
 EXCEPTION_HANDLER	boot_page_fault do_boot_page_fault error_code=1
+EXCEPTION_HANDLER	boot_nmi_trap do_boot_nmi_trap error_code=0
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 EXCEPTION_HANDLER	boot_stage1_vc do_vc_no_ghcb		error_code=1
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index cc70d3fb9049..aae1a2db4251 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -197,6 +197,7 @@ static inline void cleanup_exception_handling(void) { }
 
 /* IDT Entry Points */
 void boot_page_fault(void);
+void boot_nmi_trap(void);
 void boot_stage1_vc(void);
 void boot_stage2_vc(void);
 
-- 
2.43.0


