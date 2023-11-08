Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24567E5C32
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 18:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjKHRRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 12:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbjKHRRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 12:17:22 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CBC1BC3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 09:17:20 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7c97d5d5aso95430617b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 09:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699463840; x=1700068640; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kCSj1UbyzOjbXH0R7m4jBj84lYAM/3W5HkH+znvBSNE=;
        b=FN79mwA+PlK/qRWM/hzURoAvQxVOESXTyJdLlVKOdyeR8tVTuvLFEC1P7YMNYZeSYk
         e0ViiAqHh/6vxBdUos5L0n+SwC+hk6v6OFh6eY3cb6xybDU7aOnw40DEfoI0PLxI7g5N
         iGT5qqbMt+koELziBN+Rvpy8puwvJ6pawyJox5LMnBXASrhpYP/Oi04AQQgp1XAYq9g1
         BedZegABFINDPUy+BCkcdVEqUyml2EFIGuQ+q3ECmBWMbWSSpSwihxYoz2gWi7lh6dOA
         /aFWfBOL4ekumO0c9FQrS1BFPVUunSR7kh5v0bneTCRBL8uejIDsqeB9GBSwBqUSwMfL
         5DYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699463840; x=1700068640;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kCSj1UbyzOjbXH0R7m4jBj84lYAM/3W5HkH+znvBSNE=;
        b=sGo5CmgIyd2jG2W6C5XJ6ztXlGeuEXKiycJ4oDFOCFs1pIeHw/gV1QlKd9tgcFq9ic
         aJyrbOLArXX2qU8rpvbyRPMOrq5svQ5TaS2FoGULVSBvegGAc5eppTUDU4vxHGzctJN7
         NjIxoKLjVNdGbfkwpNFvWE0gGJ650JZkrbdMkJ6kG4NPLxS5lXj921CJsV4wHdmflxuq
         jqFA7QJwnWqv8dKE2PocgoZ0rQZhIqVetPFTMnpFCiA90wxC/FeUVPa5ta6ZU+tfKgO9
         VHAFftaOkAL1q6HWt8NO5JnYNZzRT/2CIX8g1J8TvX9sn8otgKOAMpk3/YbRAjU1/SlS
         jcFQ==
X-Gm-Message-State: AOJu0YxB9kedZH4C9amSz5qNwQ4f2FcYjax0aQ4U1eT4nZRdIQg6GxyM
        SCYqw0KJdc+Zfhcn+HtHyZljD/4UhXX68g==
X-Google-Smtp-Source: AGHT+IHg8OnCalu393KWNHpQLi1XI+R5dXnCEz2PeSSEdLfES5yxGyVCjHtobXjcKh3wugUZ+PaIL84lnC65OA==
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a25:424f:0:b0:da0:cbe9:6bac with SMTP id
 p76-20020a25424f000000b00da0cbe96bacmr40310yba.11.1699463839917; Wed, 08 Nov
 2023 09:17:19 -0800 (PST)
Date:   Wed,  8 Nov 2023 17:16:56 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231108171656.3444702-1-jackmanb@google.com>
Subject: [PATCH v3] x86/entry: Avoid redundant CR3 write on paranoid returns
From:   Brendan Jackman <jackmanb@google.com>
To:     luto@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        dave.hansen@linux.intel.com
Cc:     mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, laijs@linux.alibaba.com,
        yosryahmed@google.com, reijiw@google.com, oweisse@google.com,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

This path gets used called from:

1. #NMI return.
2. paranoid_exit (i.e. #MCE, #VC, #DB and #DF return)

Contrary to the implication in commit 21e94459110252 ("x86/mm: Optimize
RESTORE_CR3"), the kernel never modifies CR3 in any of these exceptions,
except for switching from user to kernel pagetables under PTI. That
means that most of the time when returning from an exception that
interrupted the kernel no CR3 restore is necessary. Writing CR3 is
expensive on some machines, so this commit avoids redundant writes.

I said "most of the time" because the interrupt might have come during
kernel entry before the user->kernel CR3 switch or the during exit after
the kernel->user switch. In the former case skipping the restore might
actually be fine, but definitely not the latter. So we do still need to
check the saved CR3 and restore it if it's a user CR3.

Note this code is ONLY used for returning _to kernel code_. So the only
times where the CR3 write is necessary are in those rather special cases
mentioned above where we are in kernel _code_ but a userspace CR3.

While changing this logic the macro is given a new name to clarify its
usage, and a comment that was describing its behaviour at the call site
is removed.  We can also simplify the code around the SET_NOFLUSH_BIT
invocation as we no longer need to branch to it from above.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
[Rewrote commit message; responded to review comments]
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---

Notes:
    v1: https://lore.kernel.org/lkml/20230817121513.1382800-1-jackmanb@google.com/

    v1->v2: Rewrote some comments, added a proper commit message, cleaned up
        the code per tglx's suggestion.

        I've kept Lai as the Author. If you prefer for the blame to
        record the last person that touched it then that's also fine
        though, I can credit Lai as Co-developed-by.

    v2: https://lore.kernel.org/lkml/20230920150443.1789000-1-jackmanb@google.com/

    v2->v3: Clarified the commit message per Dave's suggestion and renamed the
        macro. I did not carry PeterZ's ack since I have made some changes.

Thanks for the reviews :)

 arch/x86/entry/calling.h  | 26 ++++++++++----------------
 arch/x86/entry/entry_64.S |  7 +++----
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index f6907627172b..25cbfba1fe46 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -233,17 +233,19 @@ For 32-bit we have the following conventions - kernel is built with
 .Ldone_\@:
 .endm
 
-.macro RESTORE_CR3 scratch_reg:req save_reg:req
+/* Restore CR3 from a kernel context. May restore a user CR3 value. */
+.macro PARANOID_RESTORE_CR3 scratch_reg:req save_reg:req
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
@@ -251,20 +253,12 @@ For 32-bit we have the following conventions - kernel is built with
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
@@ -279,7 +273,7 @@ For 32-bit we have the following conventions - kernel is built with
 .endm
 .macro SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg:req save_reg:req
 .endm
-.macro RESTORE_CR3 scratch_reg:req save_reg:req
+.macro PARANOID_RESTORE_CR3 scratch_reg:req save_reg:req
 .endm
 
 #endif
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index de6469dffe3a..d65182500bfe 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -957,14 +957,14 @@ SYM_CODE_START_LOCAL(paranoid_exit)
 	IBRS_EXIT save_reg=%r15
 
 	/*
-	 * The order of operations is important. RESTORE_CR3 requires
+	 * The order of operations is important. PARANOID_RESTORE_CR3 requires
 	 * kernel GSBASE.
 	 *
 	 * NB to anyone to try to optimize this code: this code does
 	 * not execute at all for exceptions from user mode. Those
 	 * exceptions go through error_return instead.
 	 */
-	RESTORE_CR3	scratch_reg=%rax save_reg=%r14
+	PARANOID_RESTORE_CR3 scratch_reg=%rax save_reg=%r14
 
 	/* Handle the three GSBASE cases */
 	ALTERNATIVE "jmp .Lparanoid_exit_checkgs", "", X86_FEATURE_FSGSBASE
@@ -1393,8 +1393,7 @@ end_repeat_nmi:
 	/* Always restore stashed SPEC_CTRL value (see paranoid_entry) */
 	IBRS_EXIT save_reg=%r15
 
-	/* Always restore stashed CR3 value (see paranoid_entry) */
-	RESTORE_CR3 scratch_reg=%r15 save_reg=%r14
+	PARANOID_RESTORE_CR3 scratch_reg=%r15 save_reg=%r14
 
 	/*
 	 * The above invocation of paranoid_entry stored the GSBASE
-- 
2.42.0.869.gea05f2083d-goog

