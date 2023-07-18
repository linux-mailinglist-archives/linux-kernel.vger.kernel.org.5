Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32A7757E08
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjGRNpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjGRNpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:45:13 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B407D1B3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:45:07 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-563531a3ad2so3168610eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689687906; x=1692279906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Huw48BaOQUuOLcXfmSLnMJM9tEVQhPgOu4wW/uM09EY=;
        b=pz5VyQbX0Pn/sjxkqXPRPR+fJjc/hXtGXYqbhu/GnJxcdHOYiKW5a2/1i8xJzIdBWj
         FY1tj3QCP2xktCaF41/siSUNadHKS50Im92sw1+nvschQohxrE4ecQCZEI/cChSKuaDE
         1VOiYeQDaaXoaaELCuMG94lC4rA/NEj7yzShpt78DqWdy0nas9GtpHYLa+Bic3pQbQtY
         TchA1E37tU0v9PdzcSYqfqeVV+HMbJ0ucFxb8dBSNgsn8I53GeRYtPv/7d94wKjlkaP3
         aXL/pMWTfKf/fF7ICMgI9JAsdsKpK/P2LO21W5hAgwU+RbPuA62V5zjEIEwqVuAti1GB
         oY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689687906; x=1692279906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Huw48BaOQUuOLcXfmSLnMJM9tEVQhPgOu4wW/uM09EY=;
        b=Mnm841vq1AhsGsDm58JCHCXBRiBVCLaOWxDMV3Iert50z3bPjbvNZec9+Qy2+Q+Ebn
         CDSrv00SyvrpsgFr4sFiL39DOrvuECIiKC4KxR0ctniH/+Au0wBaLbyVW4FhVI/R1a4a
         RI/1xSYbaB42M/Qw2/z6MiA4bLplDzu5BpN77UNo1IP8E8iAy5+9XEid9R13CEnE4jF9
         NItK500AqO94M0JFBm4AM+YadspFsx6lL7yuVJsOG8sGYKf9PbuU21GMgh2thAIchEgw
         IbVAOU8Nxyd6kVxamtodgprp2G7M1SBOxee4e6BMSiZcV/3KeEZXdpRw/XM4jrg3YHSp
         bAfg==
X-Gm-Message-State: ABy/qLbJsnWVGhr/HHkvs9Q1AiQay+mFZVjZPvXS2ATTPCJyYr1HKRsi
        1+wA7vcuGdST+qAbT2DO4Q0AL5piFw==
X-Google-Smtp-Source: APBJJlGVrd/EJYF5gN97/ix9d+P+TjNduq2U3jpLMSbokCnwaO+rtwGl4fL7APi7V3Vsfeg94/zQjg==
X-Received: by 2002:a4a:7309:0:b0:566:c876:e85b with SMTP id s9-20020a4a7309000000b00566c876e85bmr5917320ooc.9.1689687906211;
        Tue, 18 Jul 2023 06:45:06 -0700 (PDT)
Received: from citadel.. (047-026-243-217.res.spectrum.com. [47.26.243.217])
        by smtp.gmail.com with ESMTPSA id q7-20020a4aac47000000b005660ed0becesm726778oon.39.2023.07.18.06.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 06:45:05 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 6/6] x86/entry/32: Clean up syscall fast exit tests
Date:   Tue, 18 Jul 2023 09:44:46 -0400
Message-ID: <20230718134446.168654-7-brgerst@gmail.com>
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

Merge compat and native code and clarify comments.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/entry/common.c          | 48 +++++++++++++++-----------------
 arch/x86/entry/entry_64_compat.S |  5 ++--
 2 files changed, 24 insertions(+), 29 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index fca6f2b7daf3..b975dc1d0812 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -251,34 +251,30 @@ __visible noinstr bool do_fast_syscall_32(struct pt_regs *regs)
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

