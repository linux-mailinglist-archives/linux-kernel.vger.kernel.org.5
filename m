Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D835757E06
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjGRNpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbjGRNpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:45:08 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1EFFB
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:45:04 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-56598263d1dso3697303eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689687903; x=1692279903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NsmzW3+TOJWaHVqRnCHb10JWPn8aclhCfGzeZRzD6io=;
        b=ZpTniNHZZhXCH/EIwNBiZB4HUT2XWQ0y1u+qYMbmTahrbxi3rBoPmOnkei+n6l55tx
         IO7WTM4lL3ME2Ck/EJEGhRA43553gt8vuaoK9WTOZjfmQe32ymNO1UKkGV9lda4ag1tu
         bp6cQWTNz1at5F09GoY/X/0b018sUpWDg7q7EGHEtDKZ44qPjyXeFc+mtgKjR7wtAG7v
         ItROc8J8kLLinbWWbefZfk5gBfCB5/wfonr1+yqNfpQqXhza/NzX0TgZvH6RKpPzf/PE
         DjY/Yd1ac7zCYw3INJ2aIxuSA6Kdl7znXvSidHPmYhxWgIYLcVN8mtWPLi5DRGbPfBR4
         fJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689687903; x=1692279903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NsmzW3+TOJWaHVqRnCHb10JWPn8aclhCfGzeZRzD6io=;
        b=cMZuSiCbEcdzK5cd52DHM0PW853NMUbsohz2QoOA6ufWQSKHh8zLvKrmIMUEeapz+n
         VSe+OuRAAiykDWP+WZBlxQpcTlGxbNDU37uuFkmyNb6U2PYDYOlhTUkSwfNxOkjWE+p9
         D0ol2YZ5YFvngocJuab7gj2ez8LvXS9U2ZI83ouIkzvnUJZ1rsdUL1HZ14o08TW8daZV
         4AhHuRE9QmL+rw9gJgPBKat2o+BNiRmBuuKm5zijRKeP76sBHEZv4haO6VEb7vZdCcYs
         tSXr3q5oHf4FNO+EQK2gV2k2f7eLA1f2GQpo7pzOKOylnJJ74LN98IFvRxlb6POa+9/n
         uc3w==
X-Gm-Message-State: ABy/qLbNbIFz/MkFXfQsUR+9EsjBG10Qzg516xoBMwVRWqmxAmGuAyvG
        GZ0sGimna2xTfW03fUZgQRLtg9YxLA==
X-Google-Smtp-Source: APBJJlEtNly/PjYwGGz4q4Cr/lc3ONuP/hDLEspZvOsn6iVYNDQlFoqxnKEgvLV2N8wM1OgaqTaCFQ==
X-Received: by 2002:a4a:838a:0:b0:566:f614:20ba with SMTP id h10-20020a4a838a000000b00566f61420bamr5301121oog.4.1689687902889;
        Tue, 18 Jul 2023 06:45:02 -0700 (PDT)
Received: from citadel.. (047-026-243-217.res.spectrum.com. [47.26.243.217])
        by smtp.gmail.com with ESMTPSA id q7-20020a4aac47000000b005660ed0becesm726778oon.39.2023.07.18.06.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 06:45:02 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 4/6] x86/entry/32: Convert do_fast_syscall_32() to bool return type
Date:   Tue, 18 Jul 2023 09:44:44 -0400
Message-ID: <20230718134446.168654-5-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718134446.168654-1-brgerst@gmail.com>
References: <20230718134446.168654-1-brgerst@gmail.com>
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
index afe79c3f1c5b..15660f936ede 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -230,8 +230,8 @@ static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
 	return true;
 }
 
-/* Returns 0 to return using IRET or 1 to return using SYSEXIT/SYSRETL. */
-__visible noinstr long do_fast_syscall_32(struct pt_regs *regs)
+/* Returns true to return using SYSEXIT/SYSRETL, or false to use IRET */
+__visible noinstr bool do_fast_syscall_32(struct pt_regs *regs)
 {
 	/*
 	 * Called using the internal vDSO SYSENTER/SYSCALL32 calling
@@ -249,7 +249,7 @@ __visible noinstr long do_fast_syscall_32(struct pt_regs *regs)
 
 	/* Invoke the syscall. If it failed, keep it simple: use IRET. */
 	if (!__do_fast_syscall_32(regs))
-		return 0;
+		return false;
 
 #ifdef CONFIG_X86_64
 	/*
@@ -282,8 +282,8 @@ __visible noinstr long do_fast_syscall_32(struct pt_regs *regs)
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

