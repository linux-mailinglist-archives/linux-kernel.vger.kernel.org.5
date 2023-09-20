Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5787A87D8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbjITPE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbjITPEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:04:54 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFC79F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 08:04:48 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d81a76a11eeso6495624276.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 08:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695222287; x=1695827087; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FVknj5SviIXtWZwFEQq1ySMJBkaRNL9MG0K5kDDN86g=;
        b=XwKTAQ2CBj6YJRlnp5V8FAf+nPuqrZt8Gcu+37SYis8kJIfzFngC42T362jsDjlpGz
         +++q0tVHYjd0ZQv1/cO0Ta/vN5iNGPviuEmYVitViByj4g73cIakRuDDtZEXfL9F59SG
         P/LkVkZigELD1J6R3vhRUiV/szeAFrJFlqox9Nrok/Dvv7UAXe21A8US9EEwppwVgKVa
         RiRyN8oIT9u8b6jI/K/CCMoShtpc8xYQuM24VlhumR+RhSqy9kYTHRYRTnNSEi3YuFSm
         OqJ8HxpanTLtwVi2kX1aqyJ7XPFWrUnuldNA0NdrYHeOUF/ygc/jVyHU7a2156lxO0aB
         wRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695222287; x=1695827087;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FVknj5SviIXtWZwFEQq1ySMJBkaRNL9MG0K5kDDN86g=;
        b=D/4XOZZQBqlW1g/6F4xoDJEJm3iXnnFSemmFiPmGOgUYqa1exhOpP78xaT4Ruk5ke9
         FQCz6VDVc5Jxc786zKV7ZJgbiz8xi+DrNe3FLd8NwfXZD+srm8/4WiJTkJNM2dUd49Y7
         3+5o9TFfJAjacx7DJpEc8PnwEeR07dJwD70LynSOEnHkJTCUr35ROoZBqBaTlL5EMOra
         7BsqBFfA/6GzsxKsIL4So7USoAqk83uyMx1LUwm+MiplVzv5X+YdM25/z6YYQjN+P84w
         SeasOGXSGiKkQ0muc9x1ErGZUqqlwu/Mn9Kw8+323Iye3zQ7BcOdz5fnWLShfdbnPDIn
         Mmuw==
X-Gm-Message-State: AOJu0YxDE3S7PUBK3aKYMtijSBMqi5terInOp16doyi+cS11xCE2VUAT
        3JyYksKdZDqoQPlDe5sDcWl4ig3HFzji1g==
X-Google-Smtp-Source: AGHT+IFKJNFyHiYpLkhF4V4EZ7RKe8a5rOsmIGD7xOmmYjb47J/FXyCUu6qauDlO7+o2TplaG5hOvtVMdVYwVg==
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a25:d692:0:b0:d7e:add7:4de6 with SMTP id
 n140-20020a25d692000000b00d7eadd74de6mr42351ybg.4.1695222287531; Wed, 20 Sep
 2023 08:04:47 -0700 (PDT)
Date:   Wed, 20 Sep 2023 15:04:43 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230920150443.1789000-1-jackmanb@google.com>
Subject: [PATCH v2] x86/entry: Avoid redundant CR3 write on paranoid returns
From:   Brendan Jackman <jackmanb@google.com>
To:     luto@kernel.org, tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        laijs@linux.alibaba.com, yosryahmed@google.com, reijiw@google.com,
        oweisse@google.com, peterz@infradead.org,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

This path gets used called from:

1. #NMI return.
2. paranoid_exit (i.e. #MCE, #VC, #DB and #DF return)

Contrary to the implication in commit 21e94459110252 ("x86/mm: Optimize
RESTORE_CR3"), we never modify CR3 in any of these exceptions, except
for switching from user to kernel pagetables under PTI. That means that
most of the time when returning from an exception that interrupted the
kernel no CR3 restore is necessary. Writing CR3 is expensive on some
machines, so this commit avoids redundant writes.

I said "most of the time" because we might have interrupted the kernel
entry before the user->kernel CR3 switch or the exit after the
kernel->user switch. In the former case skipping the restore might
actually be be fine, but definitely not the latter. So we do still need
to check the saved CR3 and restore it if it's a user CR3.

To reflect the new behaviour RESTORE_CR3 is given a longer name, and a
comment that was describing its behaviour at the call site is removed.
We can also simplify the code around the SET_NOFLUSH_BIT invocation
as we no longer need to branch to it from above.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
[Rewrote commit message; responded to review comments]
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---

Notes:
    V1: https://lore.kernel.org/lkml/20230817121513.1382800-1-jackmanb@google.com/
    
    v1->v2: Rewrote some comments, added a proper commit message, cleaned up
    	the code per tglx's suggestion.
    
    	I've kept Lai as the Author. If you prefer for the blame to
    	record the last person that touched it then that's also fine
    	though, I can credit Lai as Co-developed-by.

 arch/x86/entry/calling.h  | 25 +++++++++----------------
 arch/x86/entry/entry_64.S |  7 +++----
 2 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index f6907627172b..84b1e32c27a1 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -233,17 +233,18 @@ For 32-bit we have the following conventions - kernel is built with
 .Ldone_\@:
 .endm
 
-.macro RESTORE_CR3 scratch_reg:req save_reg:req
+.macro RESTORE_CR3_IF_USER scratch_reg:req save_reg:req
 	ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
 
-	ALTERNATIVE "jmp .Lwrcr3_\@", "", X86_FEATURE_PCID
-
 	/*
-	 * KERNEL pages can always resume with NOFLUSH as we do
-	 * explicit flushes.
+	 * If CR3 contained the kernel page tables at the paranoid exception
+	 * entry, then there is nothing to restore as CR3 is not modified while
+	 * handling the exception.
 	 */
 	bt	$PTI_USER_PGTABLE_BIT, \save_reg
-	jnc	.Lnoflush_\@
+	jnc	.Lend_\@
+
+	ALTERNATIVE "jmp .Lwrcr3_\@", "", X86_FEATURE_PCID
 
 	/*
 	 * Check if there's a pending flush for the user ASID we're
@@ -251,20 +252,12 @@ For 32-bit we have the following conventions - kernel is built with
 	 */
 	movq	\save_reg, \scratch_reg
 	andq	$(0x7FF), \scratch_reg
-	bt	\scratch_reg, THIS_CPU_user_pcid_flush_mask
-	jnc	.Lnoflush_\@
-
 	btr	\scratch_reg, THIS_CPU_user_pcid_flush_mask
-	jmp	.Lwrcr3_\@
+	jc	.Lwrcr3_\@
 
-.Lnoflush_\@:
 	SET_NOFLUSH_BIT \save_reg
 
 .Lwrcr3_\@:
-	/*
-	 * The CR3 write could be avoided when not changing its value,
-	 * but would require a CR3 read *and* a scratch register.
-	 */
 	movq	\save_reg, %cr3
 .Lend_\@:
 .endm
@@ -279,7 +272,7 @@ For 32-bit we have the following conventions - kernel is built with
 .endm
 .macro SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg:req save_reg:req
 .endm
-.macro RESTORE_CR3 scratch_reg:req save_reg:req
+.macro RESTORE_CR3_IF_USER scratch_reg:req save_reg:req
 .endm
 
 #endif
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 43606de22511..ff73767b5d1f 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1019,14 +1019,14 @@ SYM_CODE_START_LOCAL(paranoid_exit)
 	IBRS_EXIT save_reg=%r15
 
 	/*
-	 * The order of operations is important. RESTORE_CR3 requires
+	 * The order of operations is important. RESTORE_CR3_IF_USER requires
 	 * kernel GSBASE.
 	 *
 	 * NB to anyone to try to optimize this code: this code does
 	 * not execute at all for exceptions from user mode. Those
 	 * exceptions go through error_return instead.
 	 */
-	RESTORE_CR3	scratch_reg=%rax save_reg=%r14
+	RESTORE_CR3_IF_USER scratch_reg=%rax save_reg=%r14
 
 	/* Handle the three GSBASE cases */
 	ALTERNATIVE "jmp .Lparanoid_exit_checkgs", "", X86_FEATURE_FSGSBASE
@@ -1457,8 +1457,7 @@ end_repeat_nmi:
 	/* Always restore stashed SPEC_CTRL value (see paranoid_entry) */
 	IBRS_EXIT save_reg=%r15
 
-	/* Always restore stashed CR3 value (see paranoid_entry) */
-	RESTORE_CR3 scratch_reg=%r15 save_reg=%r14
+	RESTORE_CR3_IF_USER scratch_reg=%r15 save_reg=%r14
 
 	/*
 	 * The above invocation of paranoid_entry stored the GSBASE
-- 
2.42.0.459.ge4e396fd5e-goog

