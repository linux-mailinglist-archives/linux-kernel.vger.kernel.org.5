Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F977E9899
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 10:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbjKMJL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 04:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjKMJL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 04:11:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6390810D2;
        Mon, 13 Nov 2023 01:11:53 -0800 (PST)
Date:   Mon, 13 Nov 2023 09:11:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699866711;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XcsUChw2M9jrnCNychnCntai6zNpE2L9dML49RwHU9Q=;
        b=Jl8wvDG8oJBWAwKxQWyuiL0R9FVlHXmDEE2Yfb7SOGUDZC0/3EmJg5GkEIKJGs2iIh5wXl
        rFKpEbVf5cTp+CQhOJ/SPPIK5tG6uqnvQd1E5jiDmQ9HSGLbu0NcvB9vae034sA/g1ojHU
        UTs8CKBg643BAs7pdB7DV1vLAMLE1RVvskvFqo/eBbQ6KtW2S/z5Zw+k6XHh0Ie/nC+Uua
        vH0xHNvrtGexTnZgpr2lgj1vCSzQBa1fxgpAES14N0M1IAscZ1YF6qEMDHkXQaDGFGCL5L
        v6TtH/NtMBddBQ7EdJRmW6H6bYkM/QiAhsf4fDfrVzf+hbl6lsZgEcKGacfwuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699866711;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XcsUChw2M9jrnCNychnCntai6zNpE2L9dML49RwHU9Q=;
        b=FJcgaGE4nC5aTaBApdl6fzm4HfwPJ6SDQ+glUXmr4ejMX6jpUwK3ZnMf9VS/vHVh769xCF
        qiU2osDmeaMNYuCw==
From:   "tip-bot2 for Zhiquan Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Mark fatal MCE's page as poison to avoid
 panic in the kdump kernel
Cc:     Youquan Song <youquan.song@intel.com>,
        Zhiquan Li <zhiquan1.li@intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231014051754.3759099-1-zhiquan1.li@intel.com>
References: <20231014051754.3759099-1-zhiquan1.li@intel.com>
MIME-Version: 1.0
Message-ID: <169986671058.3135.14638395012955463403.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     9f3b130048bfa2e44a8cfb1b616f826d9d5d8188
Gitweb:        https://git.kernel.org/tip/9f3b130048bfa2e44a8cfb1b616f826d9d5d8188
Author:        Zhiquan Li <zhiquan1.li@intel.com>
AuthorDate:    Thu, 26 Oct 2023 08:39:03 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 13 Nov 2023 09:53:15 +01:00

x86/mce: Mark fatal MCE's page as poison to avoid panic in the kdump kernel

Memory errors don't happen very often, especially fatal ones. However,
in large-scale scenarios such as data centers, that probability
increases with the amount of machines present.

When a fatal machine check happens, mce_panic() is called based on the
severity grading of that error. The page containing the error is not
marked as poison.

However, when kexec is enabled, tools like makedumpfile understand when
pages are marked as poison and do not touch them so as not to cause
a fatal machine check exception again while dumping the previous
kernel's memory.

Therefore, mark the page containing the error as poisoned so that the
kexec'ed kernel can avoid accessing the page.

  [ bp: Rewrite commit message and comment. ]

Co-developed-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Zhiquan Li <zhiquan1.li@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Link: https://lore.kernel.org/r/20231014051754.3759099-1-zhiquan1.li@intel.com
---
 arch/x86/kernel/cpu/mce/core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 7b39737..df8d25e 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -44,6 +44,7 @@
 #include <linux/sync_core.h>
 #include <linux/task_work.h>
 #include <linux/hardirq.h>
+#include <linux/kexec.h>
 
 #include <asm/intel-family.h>
 #include <asm/processor.h>
@@ -233,6 +234,7 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
 	struct llist_node *pending;
 	struct mce_evt_llist *l;
 	int apei_err = 0;
+	struct page *p;
 
 	/*
 	 * Allow instrumentation around external facilities usage. Not that it
@@ -286,6 +288,20 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
 	if (!fake_panic) {
 		if (panic_timeout == 0)
 			panic_timeout = mca_cfg.panic_timeout;
+
+		/*
+		 * Kdump skips the poisoned page in order to avoid
+		 * touching the error bits again. Poison the page even
+		 * if the error is fatal and the machine is about to
+		 * panic.
+		 */
+		if (kexec_crash_loaded()) {
+			if (final && (final->status & MCI_STATUS_ADDRV)) {
+				p = pfn_to_online_page(final->addr >> PAGE_SHIFT);
+				if (p)
+					SetPageHWPoison(p);
+			}
+		}
 		panic(msg);
 	} else
 		pr_emerg(HW_ERR "Fake kernel panic: %s\n", msg);
