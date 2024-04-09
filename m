Return-Path: <linux-kernel+bounces-137219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2899589DF0E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 584691C215E6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6C313D526;
	Tue,  9 Apr 2024 15:26:08 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96E91304BD;
	Tue,  9 Apr 2024 15:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676367; cv=none; b=FsxMj3UO/MsJ6zXhA2CGjMLbi+juNV9Yt2apQUIIC+sTYxN23Z45d1qG7gR2FACq3IbbWoCaIeXALYO1uok79yyBdxEuf9GLNHCWGsE49XYsY9X+4pzxouiA0lYmd4R+/mJMukb2f662uaMFPrYf7HmSPkkMmXpi8lLLSSYFN7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676367; c=relaxed/simple;
	bh=0fxbGGIiNUaC/dR/YHRBXb6QVrd16hg3xxCX4EJwZ+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFe98IxXLcPVt++BVInhx15l5LcffBCMXkOr3b5QWz/nz8WSS8jtrgCiBn/U9k2d5964gxMA5PWAsD1ZVx8MJwcCsSuLKNM64d372JjH9eadgxNPVCXei2na0WEleEN7KeCfr8k79PyStvjY6H0QcCj90GElh6s+EyuoYk3e/M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3FD3840E0187;
	Tue,  9 Apr 2024 15:26:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id EUXTHOs9geXO; Tue,  9 Apr 2024 15:25:55 +0000 (UTC)
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4F52640E00B2;
	Tue,  9 Apr 2024 15:25:48 +0000 (UTC)
Date: Tue, 9 Apr 2024 17:25:41 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: x86-ml <x86@kernel.org>, linux-tip-commits@vger.kernel.org,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/setup: Warn when option parsing is done too early
Message-ID: <20240409152541.GCZhVd9XIPXyTNd9vc@fat_crate.local>
References: <171169867308.10875.15117897441999380027.tip-bot2@tip-bot2>
 <20240408181732.GCZhQ0vGSfP3Gf8tDW@fat_crate.local>
 <ZhQ3JSXT05Kv/RpM@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZhQ3JSXT05Kv/RpM@gmail.com>

On Mon, Apr 08, 2024 at 08:27:49PM +0200, Ingo Molnar wrote:
> > So that thing. Should we do something like the silly thing below so that 
> > it catches potential issues with parsing builtin cmdline stuff too early?
> 
> Yep, that's a good idea.
> 
> Acked-by: Ingo Molnar <mingo@kernel.org>

---
From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Mon, 8 Apr 2024 19:46:03 +0200

Commit

  4faa0e5d6d79 ("x86/boot: Move kernel cmdline setup earlier in the boot process (again)")

fixed and issue where cmdline parsing would happen before the final
boot_command_line string has been built from the builtin and boot
cmdlines and thus cmdline arguments would get lost.

Add a check to catch any future wrong use ordering so that such issues
can be caught in time.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/setup.h | 8 ++++++++
 arch/x86/kernel/setup.c      | 2 ++
 arch/x86/lib/cmdline.c       | 6 ++++++
 3 files changed, 16 insertions(+)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index e61e68d71cba..0667b2a88614 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -28,6 +28,8 @@
 #define NEW_CL_POINTER		0x228	/* Relative to real mode data */
 
 #ifndef __ASSEMBLY__
+#include <linux/cache.h>
+
 #include <asm/bootparam.h>
 #include <asm/x86_init.h>
 
@@ -133,6 +135,12 @@ asmlinkage void __init __noreturn x86_64_start_reservations(char *real_mode_data
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
index e125e059e2c4..7260bf57fe46 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -164,6 +164,7 @@ unsigned long saved_video_mode;
 static char __initdata command_line[COMMAND_LINE_SIZE];
 #ifdef CONFIG_CMDLINE_BOOL
 static char __initdata builtin_cmdline[COMMAND_LINE_SIZE] = CONFIG_CMDLINE;
+bool builtin_cmdline_added __ro_after_init;
 #endif
 
 #if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
@@ -843,6 +844,7 @@ void __init setup_arch(char **cmdline_p)
 		strscpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
 	}
 #endif
+	builtin_cmdline_added = true;
 #endif
 
 	strscpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
diff --git a/arch/x86/lib/cmdline.c b/arch/x86/lib/cmdline.c
index 80570eb3c89b..e0a6dfc663b4 100644
--- a/arch/x86/lib/cmdline.c
+++ b/arch/x86/lib/cmdline.c
@@ -6,8 +6,10 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/ctype.h>
+
 #include <asm/setup.h>
 #include <asm/cmdline.h>
+#include <asm/bug.h>
 
 static inline int myisspace(u8 c)
 {
@@ -205,12 +207,16 @@ __cmdline_find_option(const char *cmdline, int max_cmdline_size,
 
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
2.43.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

