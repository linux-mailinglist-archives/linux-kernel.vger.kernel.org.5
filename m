Return-Path: <linux-kernel+bounces-135805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D29A889CB94
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 117921C21874
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6367C1448CD;
	Mon,  8 Apr 2024 18:17:57 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABF71E532;
	Mon,  8 Apr 2024 18:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712600276; cv=none; b=IpYvMwErpTLDkIQziL42BPX4aUFOmeXAuBPOf/dzqQkXq2vZoNOybXa/yepImAt4tz8PJQcKefJkiug2Wm/WkbS/pZWa/4gCO/vX3n37tiEOKdhes4B7aLgnPeWBXRFraFb2lwsEg7DZb8e3D5jr1EZPySINhZ6zFs3dN3JY288=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712600276; c=relaxed/simple;
	bh=4e12wlkUU8uMJAum9MdZzs7k9xEejPaPoeShEZnr8bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjbFHxbvC6jr6q+H+/SKWe0SnotkwHtZE3eWF+lSUZD8X+sn+64NBLOPeA5SL7IUIp7KnZGj/qRVstzfYVMv7G7vAZgTzqEres7KkAI9qefueOifSK9ZdrGo3wz9oSSMQi+gqi3d/12nBnzet04KCm9VqY2PKEPTWZh4L/09QUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 02A0140E00B2;
	Mon,  8 Apr 2024 18:17:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id c1EzLK9bHGIi; Mon,  8 Apr 2024 18:17:46 +0000 (UTC)
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9BE4D40E0187;
	Mon,  8 Apr 2024 18:17:38 +0000 (UTC)
Date: Mon, 8 Apr 2024 20:17:32 +0200
From: Borislav Petkov <bp@alien8.de>
To: x86-ml <x86@kernel.org>
Cc: linux-tip-commits@vger.kernel.org,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Ingo Molnar <mingo@kernel.org>, Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [tip: x86/boot] x86/boot: Move kernel cmdline setup earlier in
 the boot process (again)
Message-ID: <20240408181732.GCZhQ0vGSfP3Gf8tDW@fat_crate.local>
References: <171169867308.10875.15117897441999380027.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <171169867308.10875.15117897441999380027.tip-bot2@tip-bot2>

On Fri, Mar 29, 2024 at 07:51:13AM -0000, tip-bot2 for Julian Stecklina wrote:
> The following commit has been merged into the x86/boot branch of tip:
> 
> Commit-ID:     4faa0e5d6d79fc4c6e1943e8b62a65744d8439a0
> Gitweb:        https://git.kernel.org/tip/4faa0e5d6d79fc4c6e1943e8b62a65744d8439a0
> Author:        Julian Stecklina <julian.stecklina@cyberus-technology.de>
> AuthorDate:    Thu, 28 Mar 2024 16:42:12 +01:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Fri, 29 Mar 2024 08:19:12 +01:00
> 
> x86/boot: Move kernel cmdline setup earlier in the boot process (again)

..

> The order is now:
> 
> 	setup_arch():
> 	  -> Assemble final command line:
> 	     boot_command_line = builtin_cmdline + boot_cmdline
> 
> 	  -> early_cpu_init()
> 	    -> early_identify_cpu()
> 	      -> sld_setup()
> 		-> sld_state_setup()
> 		  -> Looks for split_lock_detect in boot_command_line
> 
> 	  -> e820__memory_setup()
> 
> 	  -> parse_early_param()

So that thing. Should we do something like the silly thing below so that
it catches potential issues with parsing builtin cmdline stuff too
early?

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index e61e68d71cba..2e1d19e103e6 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -7,6 +7,7 @@
 #define COMMAND_LINE_SIZE 2048
 
 #include <linux/linkage.h>
+
 #include <asm/page_types.h>
 #include <asm/ibt.h>
 
@@ -28,6 +29,8 @@
 #define NEW_CL_POINTER		0x228	/* Relative to real mode data */
 
 #ifndef __ASSEMBLY__
+#include <linux/cache.h>
+
 #include <asm/bootparam.h>
 #include <asm/x86_init.h>
 
@@ -133,6 +136,12 @@ asmlinkage void __init __noreturn x86_64_start_reservations(char *real_mode_data
 #endif /* __i386__ */
 #endif /* _SETUP */
 
+#ifdef CONFIG_CMDLINE_BOOL
+extern bool builtin_cmdline_added __ro_after_init;
+#else
+#define builtin_cmdline_added 0
+#endif
+
 #else  /* __ASSEMBLY */
 
 .macro __RESERVE_BRK name, size
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 55a1fc332e20..a35ca100f57c 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -165,6 +165,7 @@ unsigned long saved_video_mode;
 static char __initdata command_line[COMMAND_LINE_SIZE];
 #ifdef CONFIG_CMDLINE_BOOL
 static char __initdata builtin_cmdline[COMMAND_LINE_SIZE] = CONFIG_CMDLINE;
+bool builtin_cmdline_added __ro_after_init;
 #endif
 
 #if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
@@ -765,6 +766,7 @@ void __init setup_arch(char **cmdline_p)
 		strscpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
 	}
 #endif
+	builtin_cmdline_added = true;
 #endif
 
 	strscpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
diff --git a/arch/x86/lib/cmdline.c b/arch/x86/lib/cmdline.c
index 80570eb3c89b..6307cd62acd7 100644
--- a/arch/x86/lib/cmdline.c
+++ b/arch/x86/lib/cmdline.c
@@ -6,9 +6,12 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/ctype.h>
+
 #include <asm/setup.h>
 #include <asm/cmdline.h>
 
+#include <asm/bug.h>
+
 static inline int myisspace(u8 c)
 {
 	return c <= ' ';	/* Close enough approximation */
@@ -205,12 +208,16 @@ __cmdline_find_option(const char *cmdline, int max_cmdline_size,
 
 int cmdline_find_option_bool(const char *cmdline, const char *option)
 {
+	WARN_ON_ONCE(!builtin_cmdline_added);
+
 	return __cmdline_find_option_bool(cmdline, COMMAND_LINE_SIZE, option);
 }
 
 int cmdline_find_option(const char *cmdline, const char *option, char *buffer,
 			int bufsize)
 {
+	WARN_ON_ONCE(!builtin_cmdline_added);
+
 	return __cmdline_find_option(cmdline, COMMAND_LINE_SIZE, option,
 				     buffer, bufsize);
 }

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

