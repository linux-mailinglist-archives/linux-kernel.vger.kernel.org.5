Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA16C75CD72
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjGUQLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjGUQKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:10:55 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD343592
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:10:50 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-403b6b7c0f7so17586611cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689955848; x=1690560648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxxptOg3y4GSsc8OcZSRSIbMXIx5aZyvmAJXUScqpHM=;
        b=eDyvm+inWIILOlTsD+5fWsEfRgIfEX3/tUx4fy3nXvMAIsDo6tEUlD4KOZGfWETexq
         xUD+YzsZItSbIbwnSXVtXVybpI8cGXG917sr3HCo72PrOrk5YUzO/miWZe1kuktGq0DC
         Jrqm/Z942Q+EPnGGzEpg/AcApr7KDtzXR0/XNdLU9p71z6wa0i086ROrNfJ1tVgaFa4H
         wAdRZ2Zxa8VD1UiR60SoaJ8x+aEpPc62MIgSDbSnmyocg0k3lYyGIO7dpcvEyk990RSE
         jXgTgnwibPcx1ZdFThtgRs8B6u57zoIdOVZKaB+TniEPEzKS+8AL9f72im8HWS8xiPkI
         x9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689955848; x=1690560648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxxptOg3y4GSsc8OcZSRSIbMXIx5aZyvmAJXUScqpHM=;
        b=U1w1YeCB0alOR6rQLlCqdqsJzZAxn4Iu+jHlX4Iwxy9n2e+gpzN2maQ9DKzaqGYcuP
         7YOx5uBRJ84nQ2XJ2ad4l8oW/uXu9HNXvXvlRhap3hp2Lh//U0Rs5He4aqjfrz7gK7uo
         IeP9ME4Q6cOvvDDdyr6QHAesMYyEcSvBUm3B27P8FC91uguUWL/gf0AbrtvjkUW8gmo9
         Iy5UTSMZpgSMhU9GHqswbJ1FRep/774Hi3Y5Oq2bvDwgPG2PA6aEqhFzbEpEJmAvJH0c
         2xd84Xg028z0wa8zvlG23Tnxf2YO1DC/O+Na5x+nUL5QUjEgyiDHFZZX8i1xlR95muz9
         dHeg==
X-Gm-Message-State: ABy/qLYv8TDD98Pd5hR2KPpyYWPat1MajB34jcoM+EfyQkdi2DtAtTog
        BBTgtmUaQL2DBQ9d2YlOciDpj7R1Sg==
X-Google-Smtp-Source: APBJJlG/2jNEsOVOdjP5angk2jnAv8hvfGNGyxidtGh68Fc8gIMZs+oyLXhOJ9R4d05YsmJfTgriJQ==
X-Received: by 2002:a05:622a:1c8:b0:403:acd3:e90e with SMTP id t8-20020a05622a01c800b00403acd3e90emr732799qtw.48.1689955848593;
        Fri, 21 Jul 2023 09:10:48 -0700 (PDT)
Received: from citadel.. (047-026-243-217.res.spectrum.com. [47.26.243.217])
        by smtp.gmail.com with ESMTPSA id c16-20020ac87d90000000b004054fbf9273sm311286qtd.80.2023.07.21.09.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 09:10:47 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 6/6] x86/entry/32: Clean up syscall fast exit tests
Date:   Fri, 21 Jul 2023 12:10:17 -0400
Message-ID: <20230721161018.50214-7-brgerst@gmail.com>
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

Merge compat and native code and clarify comments.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/entry/common.c          | 48 +++++++++++++++-----------------
 arch/x86/entry/entry_64_compat.S |  5 ++--
 2 files changed, 24 insertions(+), 29 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 4d7d6d25dda9..800664325542 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -241,34 +241,30 @@ __visible noinstr bool do_fast_syscall_32(struct pt_regs *regs)
 	if (!__do_fast_syscall_32(regs))
 		return false;
 
-#ifdef CONFIG_X86_64
 	/*
-	 * Opportunistic SYSRETL: if possible, try to return using SYSRETL.
-	 * SYSRETL is available on all 64-bit CPUs, so we don't need to
-	 * bother with SYSEXIT.
-	 *
-	 * Unlike 64-bit opportunistic SYSRET, we can't check that CX == IP,
-	 * because the ECX fixup above will ensure that this is essentially
-	 * never the case.
+	 * Check that the register state is valid for using SYSRETL/SYSEXIT
+	 * to exit to userspace.  Otherwise use the slower but fully capable
+	 * IRET exit path.
 	 */
-	return regs->cs == __USER32_CS && regs->ss == __USER_DS &&
-		regs->ip == landing_pad &&
-		(regs->flags & (X86_EFLAGS_RF | X86_EFLAGS_TF)) == 0;
-#else
-	/*
-	 * Opportunistic SYSEXIT: if possible, try to return using SYSEXIT.
-	 *
-	 * Unlike 64-bit opportunistic SYSRET, we can't check that CX == IP,
-	 * because the ECX fixup above will ensure that this is essentially
-	 * never the case.
-	 *
-	 * We don't allow syscalls at all from VM86 mode, but we still
-	 * need to check VM, because we might be returning from sys_vm86.
-	 */
-	return regs->cs == __USER_CS && regs->ss == __USER_DS &&
-		regs->ip == landing_pad &&
-		(regs->flags & (X86_EFLAGS_RF | X86_EFLAGS_TF | X86_EFLAGS_VM)) == 0;
-#endif
+
+	/* XEN PV guests always use IRET path */
+	if (cpu_feature_enabled(X86_FEATURE_XENPV))
+		return false;
+
+	/* EIP must point to the VDSO landing pad */
+	if (unlikely(regs->ip != landing_pad))
+		return false;
+
+	/* CS and SS must match the values set in MSR_STAR */
+	if (unlikely(regs->cs != __USER32_CS || regs->ss != __USER_DS))
+		return false;
+
+	/* If the TF, RF, or VM flags are set, use IRET */
+	if (unlikely(regs->flags & (X86_EFLAGS_RF | X86_EFLAGS_TF | X86_EFLAGS_VM)))
+		return false;
+
+	/* Use SYSRETL/SYSEXIT to exit to userspace */
+	return true;
 }
 
 /* Returns true to return using SYSEXIT/SYSRETL, or false to use IRET */
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 27c05d08558a..84e21d1ebf10 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -211,9 +211,8 @@ SYM_INNER_LABEL(entry_SYSCALL_compat_after_hwframe, SYM_L_GLOBAL)
 	call	do_fast_syscall_32
 
 sysret32_from_system_call:
-	/* XEN PV guests always use IRET path */
-	ALTERNATIVE "testb %al, %al; jz swapgs_restore_regs_and_return_to_usermode", \
-		    "jmp swapgs_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
+	testb	%al, %al		/* Is SYSRET allowed? */
+	jz	swapgs_restore_regs_and_return_to_usermode
 
 	/*
 	 * Opportunistic SYSRET
-- 
2.41.0

