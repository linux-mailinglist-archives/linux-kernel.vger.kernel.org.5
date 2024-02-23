Return-Path: <linux-kernel+bounces-79133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B0F861DF7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820001F24910
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF13158D84;
	Fri, 23 Feb 2024 20:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t8oFKth8"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC4D1493BC
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 20:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708720970; cv=none; b=IRG0lPultgyol/frkQCiYcK+ZNcobAEVY3WOMns/w1GPTMJQTaKpty/NaNs357/H1FcpWZ5uu1ZV1njGXhT+qwVh6WH80pVs+dMlwC/vSJsssli0DpmYU+MGFeEIaGMNVPPxo08Jqqd7CmaqLImtx6GNw6CGD1JSY+Y6MLtpxrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708720970; c=relaxed/simple;
	bh=l0zkmGZQWE9+kQETtRT0ImK1JoiFu1GlHAy5QX+NL98=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qlKnnQ+e6/rL1yQ3VUhhVwdg8ianvg+m2LUn+Yl7oMXat6gOmbZRfEIfhtr2O5WX24O7DHLL+sAD2+bedytZushCTJo13nVcmQrkjxr5wwQD/Mhb//CO+S1d5lGmSt9koOgfbpQRGuBx2W7rUmE0RYYTZ1MFbBX+nRss3h2sk8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t8oFKth8; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5dc91de351fso925413a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 12:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708720968; x=1709325768; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=eMiAiix9phUQ/h1sG+JlRQvWAIP+ZL2r3XfvgJSywGA=;
        b=t8oFKth8zniXokoLiWVauCK3SM+RLdkOE9fVqUWEuIkoEUL9qn7AZUEdrkbEtoxVxu
         ElmJoa+oPiHmrhRDZGYWcAnqDl8HFYb5OVT7HPyFfBD/lyCG2xZsIgumUdFzOdkjVkjT
         069/y+FMsRy+mzxdw6kk8fxheM3Mhzith3Wh/xURXW8t/5MwRHvEJSO/2uDVCdoTznBx
         +HOLEH1J+H/Kt69LCOiVgSETRLMZ0qGlbq6+bBvVpIUmexSiOUsKP8ze1HA0H13VBlF3
         Dk+fa9yN5MwBvIZPVSdVnwbuFkAsC20Fe1iq427x6wh86BtIkKvzHLVPgUCxq/sJhg7g
         mwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708720968; x=1709325768;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eMiAiix9phUQ/h1sG+JlRQvWAIP+ZL2r3XfvgJSywGA=;
        b=TSgQkth+bYPOIQARYEuRGDQgdnZCEmXTKemIGfPZQ5u6ZFvp/oJJwRsd1FoHx7fWVo
         jSbLy2X+MaISl9xkoDLcdr+4KYVSGeP7anSv0SUsBmNdZJaqa2Yh1EiD3WmIuRmsM8kg
         T0HWqwvKYLhzvIRLc9Nq5YdomeJ41infQ26n+yTGtx0lu7y8xFadtlzCODnLsKiPl2mu
         J6ROzW3dJF1amHgzbp0l8+Dy1oWaAOvL60O/XAymdOuK3ptBSKKUvcvVFBBNv6+Z/AVy
         6qpaohMNWrTPcVa4CfHZobIW7vAac5JqPUZNcs8R4GIy4zsnWjyYMArL77+zoOWQZG5O
         rqoQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/xGZ29Uq6AIPVnwPKSiT7POZdQlOyrcdUCsoMG2FRKNKW3QvZA9psRmGxqaMUCcylMD/l1TviJ9EpZ7Ya/SI5AtgK5EGlMxG0fv6P
X-Gm-Message-State: AOJu0YyxIeVqUpmEmjBJe9VDjMKCNScjGDW1DTrOzKPHRGqeH8O/ql73
	nwkPIzK/ZvJBz2SPKZFf57uS1RCTdcihlEc8/88dFLGj9YsOB567jwEVnFzooC+apHrOzdVkdGO
	KNw==
X-Google-Smtp-Source: AGHT+IGwnheLLt11GCgq5bE9Gg3yzwQwcKlYIU9oJNz7WYe1wgIud5ZyeG1jDhmi6OGPwB1nWqKwpU0ePoM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:201b:0:b0:5e4:2b26:960a with SMTP id
 g27-20020a63201b000000b005e42b26960amr2263pgg.4.1708720967712; Fri, 23 Feb
 2024 12:42:47 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 23 Feb 2024 12:42:31 -0800
In-Reply-To: <20240223204233.3337324-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240223204233.3337324-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240223204233.3337324-7-seanjc@google.com>
Subject: [PATCH 6/8] KVM: SVM: Save/restore args across SEV-ES VMRUN via host
 save area
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Alexey Kardashevskiy <aik@amd.com>
Content-Type: text/plain; charset="UTF-8"

Use the host save area to preserve volatile registers that are used in
__svm_sev_es_vcpu_run() to access function parameters after #VMEXIT.
Like saving/restoring non-volatile registers, there's no reason not to
take advantage of hardware restoring registers on #VMEXIT, as doing so
shaves a few instructions and the save area is going to be accessed no
matter what.

Converting all register save/restore code to use the host save area also
make it easier to follow the SEV-ES VMRUN flow in its entirety, as
opposed to having a mix of stack-based versus host save area save/restore.

Add a parameter to RESTORE_HOST_SPEC_CTRL_BODY so that the SEV-ES path
doesn't need to write @spec_ctrl_intercepted to memory just to play nice
with the common macro.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/vmenter.S | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
index e92953427100..48cdba47622c 100644
--- a/arch/x86/kvm/svm/vmenter.S
+++ b/arch/x86/kvm/svm/vmenter.S
@@ -67,7 +67,7 @@
 		"", X86_FEATURE_V_SPEC_CTRL
 901:
 .endm
-.macro RESTORE_HOST_SPEC_CTRL_BODY
+.macro RESTORE_HOST_SPEC_CTRL_BODY spec_ctrl_intercepted:req
 900:
 	/* Same for after vmexit.  */
 	mov $MSR_IA32_SPEC_CTRL, %ecx
@@ -76,7 +76,7 @@
 	 * Load the value that the guest had written into MSR_IA32_SPEC_CTRL,
 	 * if it was not intercepted during guest execution.
 	 */
-	cmpb $0, (%_ASM_SP)
+	cmpb $0, \spec_ctrl_intercepted
 	jnz 998f
 	rdmsr
 	movl %eax, SVM_spec_ctrl(%_ASM_DI)
@@ -269,7 +269,7 @@ SYM_FUNC_START(__svm_vcpu_run)
 	RET
 
 	RESTORE_GUEST_SPEC_CTRL_BODY
-	RESTORE_HOST_SPEC_CTRL_BODY
+	RESTORE_HOST_SPEC_CTRL_BODY (%_ASM_SP)
 
 10:	cmpb $0, _ASM_RIP(kvm_rebooting)
 	jne 2b
@@ -298,6 +298,8 @@ SYM_FUNC_END(__svm_vcpu_run)
 #define SEV_ES_GPRS_BASE 0x300
 #define SEV_ES_RBX	(SEV_ES_GPRS_BASE + __VCPU_REGS_RBX * WORD_SIZE)
 #define SEV_ES_RBP	(SEV_ES_GPRS_BASE + __VCPU_REGS_RBP * WORD_SIZE)
+#define SEV_ES_RSI	(SEV_ES_GPRS_BASE + __VCPU_REGS_RSI * WORD_SIZE)
+#define SEV_ES_RDI	(SEV_ES_GPRS_BASE + __VCPU_REGS_RDI * WORD_SIZE)
 #define SEV_ES_R12	(SEV_ES_GPRS_BASE + __VCPU_REGS_R12 * WORD_SIZE)
 #define SEV_ES_R13	(SEV_ES_GPRS_BASE + __VCPU_REGS_R13 * WORD_SIZE)
 #define SEV_ES_R14	(SEV_ES_GPRS_BASE + __VCPU_REGS_R14 * WORD_SIZE)
@@ -322,11 +324,12 @@ SYM_FUNC_START(__svm_sev_es_vcpu_run)
 	mov %r12, SEV_ES_R12 (%rdx)
 	mov %rbx, SEV_ES_RBX (%rdx)
 
-	/* Accessed directly from the stack in RESTORE_HOST_SPEC_CTRL.  */
-	push %rsi
-
-	/* Save @svm. */
-	push %rdi
+	/*
+	 * Save volatile registers that hold arguments that are needed after
+	 * #VMEXIT (RDI=@svm and RSI=@spec_ctrl_intercepted).
+	 */
+	mov %rdi, SEV_ES_RDI (%rdx)
+	mov %rsi, SEV_ES_RSI (%rdx)
 
 	/* Clobbers RAX, RCX, RDX (@hostsa). */
 	RESTORE_GUEST_SPEC_CTRL
@@ -342,15 +345,12 @@ SYM_FUNC_START(__svm_sev_es_vcpu_run)
 
 2:	cli
 
-	/* Pop @svm to RDI, guest registers have been saved already. */
-	pop %rdi
-
 #ifdef CONFIG_RETPOLINE
 	/* IMPORTANT: Stuff the RSB immediately after VM-Exit, before RET! */
 	FILL_RETURN_BUFFER %rax, RSB_CLEAR_LOOPS, X86_FEATURE_RETPOLINE
 #endif
 
-	/* Clobbers RAX, RCX, RDX, consumes RDI (@svm). */
+	/* Clobbers RAX, RCX, RDX, consumes RDI (@svm) and RSI (@spec_ctrl_intercepted). */
 	RESTORE_HOST_SPEC_CTRL
 
 	/*
@@ -362,13 +362,10 @@ SYM_FUNC_START(__svm_sev_es_vcpu_run)
 	 */
 	UNTRAIN_RET_VM
 
-	/* "Pop" and discard @spec_ctrl_intercepted. */
-	pop %rax
-
 	RET
 
 	RESTORE_GUEST_SPEC_CTRL_BODY
-	RESTORE_HOST_SPEC_CTRL_BODY
+	RESTORE_HOST_SPEC_CTRL_BODY %sil
 
 3:	cmpb $0, kvm_rebooting(%rip)
 	jne 2b
-- 
2.44.0.rc0.258.g7320e95886-goog


