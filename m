Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC09375CD6F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjGUQLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjGUQKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:10:52 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA4830E3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:10:47 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-57712d00cc1so23278667b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689955845; x=1690560645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxkycSrtZLZVeXZKUZ3rCjnmJ8chLKLmrvSzsZapgiI=;
        b=GvLsqNkhErKyb8uFLMrn4qKmg1ICEZ9/esxS4P/Py0iIeSW7WkpRr9VqGIFl1e/jub
         cCNuzBKaVinBIfXZSILW32IohpfiEFdpWj3N28TdvwLcngvqZE4jKAVy5XqNqqhiXztG
         IY2ODWi93TUF9+a+StZ8k+Xkz+m+aoqMkqe3tn1kIDXvVkDANKEmfhdo+1hdd95lBA7j
         7xyIEZEaN2OnoFsbC77KPwu+dWRv+Qi1Qvj9dEVBBlyklIxaSCGmRtS/AX5HBfyu0ueN
         bkLLOEKuCIk4hrB+xKsu2cmBPFAiGFtNI9TrEiWpLRC2dr67X/3g8jxswsyYh93sti4g
         NiLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689955845; x=1690560645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxkycSrtZLZVeXZKUZ3rCjnmJ8chLKLmrvSzsZapgiI=;
        b=YNXI/guidzRkV2dvwgkiz4g7OE0FMH2niXz4DuKBZbjmbpsFxa7YbRQ3D4Dg9E6ls/
         njWVdfqBNeFphFk958ODQ1XtlSiN0AoU5ZjKU7lEZQ4+QUTKVfAoW1O235v/cxPA7O2B
         tTQhyUvM3XyhRqDD4QR1sdTYFbVbVxCOh2OVdY2V8EzynMfi6lGK05rn/4dDFKkm2dJf
         NBZQ1KsP+ctTYSz07mjT9qKDZTbkhlFjmUzu3Wt1OX1w4sjl+C9nH+4vNgaAgy4v96Tt
         uSHRrVAFHzeSe/+GBOIDOVb6d8zHZ0yWsG81AiAYx3kHhImEDCsAsHxBvzyTAzpu90IS
         G3VQ==
X-Gm-Message-State: ABy/qLbCJQRD834cDcheu5F2j9rwMmRh222XQW4QJ1uA0pE0I0sD3xEn
        Yg1anyKLgjq1YLlHdpd/8WUG55TwnQ==
X-Google-Smtp-Source: APBJJlHEt7lS54ZpbMhVafN7d6SHseBebzRLgVo4bmzbHBmUa/9KBujZgXW1iRUZ+F5swNWxzb+pIQ==
X-Received: by 2002:a25:2f8e:0:b0:ce8:cd8d:f0db with SMTP id v136-20020a252f8e000000b00ce8cd8df0dbmr1940050ybv.28.1689955845563;
        Fri, 21 Jul 2023 09:10:45 -0700 (PDT)
Received: from citadel.. (047-026-243-217.res.spectrum.com. [47.26.243.217])
        by smtp.gmail.com with ESMTPSA id c16-20020ac87d90000000b004054fbf9273sm311286qtd.80.2023.07.21.09.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 09:10:44 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 4/6] x86/entry/32: Convert do_fast_syscall_32() to bool return type
Date:   Fri, 21 Jul 2023 12:10:15 -0400
Message-ID: <20230721161018.50214-5-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721161018.50214-1-brgerst@gmail.com>
References: <20230721161018.50214-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/entry/common.c          | 10 +++++-----
 arch/x86/entry/entry_32.S        |  2 +-
 arch/x86/entry/entry_64_compat.S |  2 +-
 arch/x86/include/asm/syscall.h   |  4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index cccdd18c8304..5b3594457af3 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -220,8 +220,8 @@ static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
 	return true;
 }
 
-/* Returns 0 to return using IRET or 1 to return using SYSEXIT/SYSRETL. */
-__visible noinstr long do_fast_syscall_32(struct pt_regs *regs)
+/* Returns true to return using SYSEXIT/SYSRETL, or false to use IRET */
+__visible noinstr bool do_fast_syscall_32(struct pt_regs *regs)
 {
 	/*
 	 * Called using the internal vDSO SYSENTER/SYSCALL32 calling
@@ -239,7 +239,7 @@ __visible noinstr long do_fast_syscall_32(struct pt_regs *regs)
 
 	/* Invoke the syscall. If it failed, keep it simple: use IRET. */
 	if (!__do_fast_syscall_32(regs))
-		return 0;
+		return false;
 
 #ifdef CONFIG_X86_64
 	/*
@@ -272,8 +272,8 @@ __visible noinstr long do_fast_syscall_32(struct pt_regs *regs)
 #endif
 }
 
-/* Returns 0 to return using IRET or 1 to return using SYSEXIT/SYSRETL. */
-__visible noinstr long do_SYSENTER_32(struct pt_regs *regs)
+/* Returns true to return using SYSEXIT/SYSRETL, or false to use IRET */
+__visible noinstr bool do_SYSENTER_32(struct pt_regs *regs)
 {
 	/* SYSENTER loses RSP, but the vDSO saved it in RBP. */
 	regs->sp = regs->bp;
diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 6e6af42e044a..c73047bf9f4b 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -837,7 +837,7 @@ SYM_FUNC_START(entry_SYSENTER_32)
 
 	movl	%esp, %eax
 	call	do_SYSENTER_32
-	testl	%eax, %eax
+	testb	%al, %al
 	jz	.Lsyscall_32_done
 
 	STACKLEAK_ERASE
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index b16272395f1a..27c05d08558a 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -212,7 +212,7 @@ SYM_INNER_LABEL(entry_SYSCALL_compat_after_hwframe, SYM_L_GLOBAL)
 
 sysret32_from_system_call:
 	/* XEN PV guests always use IRET path */
-	ALTERNATIVE "testl %eax, %eax; jz swapgs_restore_regs_and_return_to_usermode", \
+	ALTERNATIVE "testb %al, %al; jz swapgs_restore_regs_and_return_to_usermode", \
 		    "jmp swapgs_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
 
 	/*
diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index be6c5515e0b9..f44e2f9ab65d 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -131,7 +131,7 @@ bool do_syscall_64(struct pt_regs *regs, int nr);
 #endif	/* CONFIG_X86_32 */
 
 void do_int80_syscall_32(struct pt_regs *regs);
-long do_fast_syscall_32(struct pt_regs *regs);
-long do_SYSENTER_32(struct pt_regs *regs);
+bool do_fast_syscall_32(struct pt_regs *regs);
+bool do_SYSENTER_32(struct pt_regs *regs);
 
 #endif	/* _ASM_X86_SYSCALL_H */
-- 
2.41.0

