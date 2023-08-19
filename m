Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129F8781903
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 12:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjHSKnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 06:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjHSKmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 06:42:44 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F7246734;
        Sat, 19 Aug 2023 03:22:25 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0Vq53wpY_1692440537;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vq53wpY_1692440537)
          by smtp.aliyun-inc.com;
          Sat, 19 Aug 2023 18:22:19 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     catalin.marinas@arm.com, will@kernel.org,
        James.Bottomley@HansenPartnership.com, deller@gmx.de,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-parisc@vger.kernel.org
Subject: [PATCH] HWPOISON: add a pr_err message when forcibly send a sigbus
Date:   Sat, 19 Aug 2023 18:22:12 +0800
Message-Id: <20230819102212.21103-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a process tries to access a page that is already offline, the
kernel will send a sigbus signal with the BUS_MCEERR_AR code. This
signal is typically handled by a registered sigbus handler in the
process. However, if the process does not have a registered sigbus
handler, it is important for end users to be informed about what
happened.

To address this, add an error message similar to those implemented on
the x86, powerpc, and parisc platforms.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 arch/arm64/mm/fault.c  | 2 ++
 arch/parisc/mm/fault.c | 5 ++---
 arch/x86/mm/fault.c    | 3 +--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 3fe516b32577..38e2186882bd 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -679,6 +679,8 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 	} else if (fault & (VM_FAULT_HWPOISON_LARGE | VM_FAULT_HWPOISON)) {
 		unsigned int lsb;
 
+		pr_err("MCE: Killing %s:%d due to hardware memory corruption fault at %lx\n",
+		       current->comm, current->pid, far);
 		lsb = PAGE_SHIFT;
 		if (fault & VM_FAULT_HWPOISON_LARGE)
 			lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
index a4c7c7630f48..6b096b47e149 100644
--- a/arch/parisc/mm/fault.c
+++ b/arch/parisc/mm/fault.c
@@ -395,9 +395,8 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
 #ifdef CONFIG_MEMORY_FAILURE
 		if (fault & (VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE)) {
 			unsigned int lsb = 0;
-			printk(KERN_ERR
-	"MCE: Killing %s:%d due to hardware memory corruption fault at %08lx\n",
-			tsk->comm, tsk->pid, address);
+			pr_err("MCE: Killing %s:%d due to hardware memory corruption fault at %08lx\n",
+				tsk->comm, tsk->pid, address);
 			/*
 			 * Either small page or large page may be poisoned.
 			 * In other words, VM_FAULT_HWPOISON_LARGE and
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index e8711b2cafaf..7266509cca54 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -962,8 +962,7 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 		struct task_struct *tsk = current;
 		unsigned lsb = 0;
 
-		pr_err(
-	"MCE: Killing %s:%d due to hardware memory corruption fault at %lx\n",
+		pr_err("MCE: Killing %s:%d due to hardware memory corruption fault at %lx\n",
 			tsk->comm, tsk->pid, address);
 		if (fault & VM_FAULT_HWPOISON_LARGE)
 			lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
-- 
2.39.3

