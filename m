Return-Path: <linux-kernel+bounces-63523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA738530BA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A276B2219F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E6951C4E;
	Tue, 13 Feb 2024 12:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ulj1QaRz"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D037C50A7F
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707828131; cv=none; b=QfqKn314PJzzYHflP51gR2wEnOopq0vT7jlNgM9SF+84vD5IRVV0m6sdeMP10oezSxj/8VFZKEpyamw49mGZSVoLJV+98DgSSZZtZhbPz3T3Krwlw2j5IzNJP0/DG8fgRLZAmw5mvgzcxjgVvBSoodwkbtQoJzqrbOVSidQ1CXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707828131; c=relaxed/simple;
	bh=jPHNmEDl0ryiAggUWuXvb8LuTJ6Z4Zpf6+3+QYXDVB4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XjFo8aYcn5T+HQHmqUSxeBQ1ciQ7n08ZxExpQO9ZWHqDRYytQpLQL2Hxkd2v9IwCV7ctEBLpHllh7bNHhq+KijreSjVuMAkNd9zqCQ4OAKqCZOTQCkX8BCf/SpnaBQlS0t7hfySNN4PLjHWFLHIZNcQ13bXH5RiylygyZVzWl2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ulj1QaRz; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc0bcf9256so1704171276.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 04:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707828129; x=1708432929; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R8PzBwStBQmNo4IaP5da+Ydr5S+nPOaVv6NiNBRmMEI=;
        b=Ulj1QaRzhF/2z0kHbIl0qORR2B/5JZX1j9bvKaguuYs0KnvmnLFoA5G8B8vyRMTTX2
         aNjqRPen6MrgyFLbYrFpnK7PbEmvI3OpkyKmxG8AoBL7zY2RYzYyYCL9LzZK2QbT6qi/
         D+2KAkUtuW4eCR9a4dbHSylD7EH5GgkG9LFnSIEF4oCu/f63FQSzqfIJJlzSMDeeirTN
         KsF9Q0gmZeftSDy0VgUbZ2BKIJzr4B+EGoNEwlARhLEpbX1oG0sbW5RC/LAMCEY098j6
         65DEqwagXx65SCaCFhL9Bjupvc+EXJgFdpDS/HoZdqQHhC8nk0oqJdX/4GyscKuYAAZM
         gm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707828129; x=1708432929;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R8PzBwStBQmNo4IaP5da+Ydr5S+nPOaVv6NiNBRmMEI=;
        b=evbW2X0QK/9P6gUvtIQMzemR5M9B7bGsvkSVrshYXUk1FfAISa4KPxmMtkPk1nVYtZ
         CbQnuO+P4Z1dDJUneEEWXbnmiir3fTcMeYGKGhwQd12q8cnk6zGL9LhbKlcOq1vPGFg9
         MG8mBfEDDWveOc5wKHCoUNx941zHGS+erY9ODzW93uCYRLchOZ6yOnpBXJSmlYMh+5U2
         c7gLJKIYDF5UX4g9Y6T7mnd32EJyLCiIydwkZaxYq2pTdav9MGlRXyn/u3t7GCgndFtg
         xkWJxCQN+IMvBGSl1K3EW8Oc4W7MdviD7G1Nnx1jkjKdkj0nJc6YZDd6DAG5DhkYYR+G
         UoYg==
X-Gm-Message-State: AOJu0Yx7vbLIwLyRuidhhtxZNxesRtf8GqILc61eAFfzHdr0/j5NHCyj
	1zig+r7r7LW/K8yA+1LspN8MXEmxlKL6Pbd3C0sl8WcyONigUc+6NdTW0wgt7/WKPLWGu/oyXf1
	NBVONBSEAM+BNboPo1TxZDlnY8+9Gf0IUIkJwOouSGmTnLj5Pgf+QRh4bQQ4IrgIiseShl0UG40
	DAW651YxacwQCMP7oYgqwi9QQvkyRDwQ==
X-Google-Smtp-Source: AGHT+IE2GwsN+Io2TI0Jc+pJmObJfT7mpoQTvQA7e/S3KN2gLrOZ5Lcs6oS1JTCskApKEpvhehhyckO2
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:1028:b0:dc7:3189:4e75 with SMTP id
 x8-20020a056902102800b00dc731894e75mr346289ybt.3.1707828128483; Tue, 13 Feb
 2024 04:42:08 -0800 (PST)
Date: Tue, 13 Feb 2024 13:41:47 +0100
In-Reply-To: <20240213124143.1484862-13-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213124143.1484862-13-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2373; i=ardb@kernel.org;
 h=from:subject; bh=4k+FBUPb8cUOIJZ1D8SGO5j46VqaiuS2qc/hfQO7nqA=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfV0cnf5JtewZYpJvdc2m4UXi63ZycLU4s3Y8/T5sZxrm
 bOVH1h1lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgImsYWX4K/p4j/cbl04206aX
 nas2ySWs8X9we3KI9D3lOXJvToscymJkmOA068FH/ZhrTr+kemP/3SvaKS3atlwuVc9F9fTLNa6 7+AA=
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213124143.1484862-16-ardb+git@google.com>
Subject: [PATCH v4 03/11] x86/startup_64: Simplify CR4 handling in startup code
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

When paging is enabled, the CR4.PAE and CR4.LA57 control bits cannot be
changed, and so they can simply be preserved rather than reason about
whether or not they need to be set. CR4.MCE should be preserved unless
the kernel was built without CONFIG_X86_MCE, in which case it must be
cleared.

CR4.PSE should be set explicitly, regardless of whether or not it was
set before.

CR4.PGE is set explicitly, and then cleared and set again after
programming CR3 in order to flush TLB entries based on global
translations. This makes the first assignment redundant, and can
therefore be omitted.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/head_64.S | 24 ++++++--------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 3cac98c61066..7e76cc0b442a 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -185,6 +185,8 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	addq	$(init_top_pgt - __START_KERNEL_map), %rax
 1:
 
+	/* Create a mask of CR4 bits to preserve */
+	movl	$(X86_CR4_PAE | X86_CR4_LA57), %edx
 #ifdef CONFIG_X86_MCE
 	/*
 	 * Preserve CR4.MCE if the kernel will enable #MC support.
@@ -193,20 +195,11 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	 * configured will crash the system regardless of the CR4.MCE value set
 	 * here.
 	 */
-	movq	%cr4, %rcx
-	andl	$X86_CR4_MCE, %ecx
-#else
-	movl	$0, %ecx
-#endif
-
-	/* Enable PAE mode, PSE, PGE and LA57 */
-	orl	$(X86_CR4_PAE | X86_CR4_PSE | X86_CR4_PGE), %ecx
-#ifdef CONFIG_X86_5LEVEL
-	testb	$1, __pgtable_l5_enabled(%rip)
-	jz	1f
-	orl	$X86_CR4_LA57, %ecx
-1:
+	orl	$X86_CR4_MCE, %edx
 #endif
+	movq	%cr4, %rcx
+	andl	%edx, %ecx
+	btsl	$X86_CR4_PSE_BIT, %ecx
 	movq	%rcx, %cr4
 
 	/* Setup early boot stage 4-/5-level pagetables. */
@@ -226,11 +219,8 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	 * Do a global TLB flush after the CR3 switch to make sure the TLB
 	 * entries from the identity mapping are flushed.
 	 */
-	movq	%cr4, %rcx
-	movq	%rcx, %rax
-	xorq	$X86_CR4_PGE, %rcx
+	btsl	$X86_CR4_PGE_BIT, %ecx
 	movq	%rcx, %cr4
-	movq	%rax, %cr4
 
 	/* Ensure I am executing from virtual addresses */
 	movq	$1f, %rax
-- 
2.43.0.687.g38aa6559b0-goog


