Return-Path: <linux-kernel+bounces-26582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A84F082E3D2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169C61F248A0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 23:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C7222EE3;
	Mon, 15 Jan 2024 23:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXc9z9Fh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D0A22609;
	Mon, 15 Jan 2024 23:27:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33FC0C43399;
	Mon, 15 Jan 2024 23:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705361279;
	bh=UpU17ojoS8IrY5pIuEgsVkLd7Sw166zEsS17uprCekk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TXc9z9Fhms3oPJ09mizs4FYmcpC6VaWzLmelU+WIFJg+dlMpGKve95Wqh2jE7lp7B
	 pHUJ8nyWwpzqvNsaCSvoqsY1iYTz2+5oEpAgwFgqAt1VnqGG+dyoGMWio+qc10W8f/
	 ZeKGH4M0oQSzTRVe/jCJGBbFtnqkt1wOF+qv+VYw8CXcB8z0WTy7c+6zkPunknJtK+
	 KyEyMgS3MS6tNL1zPnYRwHvoEq0RE/uJfTQIXbyPDTJj47bFQLrADtPRpCaz2keyp4
	 l79n0PmoiwEI2HnWsQ9t0r3ivAcegv5Ec64EhS9S70sGEKP1TcMrvW/JM8fUn7rqnq
	 UcQYB5Gxpv8/w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhiquan Li <zhiquan1.li@intel.com>,
	Youquan Song <youquan.song@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	linux-edac@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 12/12] x86/mce: Mark fatal MCE's page as poison to avoid panic in the kdump kernel
Date: Mon, 15 Jan 2024 18:26:57 -0500
Message-ID: <20240115232718.209642-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115232718.209642-1-sashal@kernel.org>
References: <20240115232718.209642-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
Content-Transfer-Encoding: 8bit

From: Zhiquan Li <zhiquan1.li@intel.com>

[ Upstream commit 9f3b130048bfa2e44a8cfb1b616f826d9d5d8188 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/mce/core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index a0727723676b..eb48729e220e 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -44,6 +44,7 @@
 #include <linux/sync_core.h>
 #include <linux/task_work.h>
 #include <linux/hardirq.h>
+#include <linux/kexec.h>
 
 #include <asm/intel-family.h>
 #include <asm/processor.h>
@@ -274,6 +275,7 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
 	struct llist_node *pending;
 	struct mce_evt_llist *l;
 	int apei_err = 0;
+	struct page *p;
 
 	/*
 	 * Allow instrumentation around external facilities usage. Not that it
@@ -329,6 +331,20 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
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
-- 
2.43.0


