Return-Path: <linux-kernel+bounces-26542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 047DA82E364
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 940A61F219E4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 23:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5306C1C6B6;
	Mon, 15 Jan 2024 23:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7I+RrsG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF691B94D;
	Mon, 15 Jan 2024 23:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFDFAC43399;
	Mon, 15 Jan 2024 23:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705361077;
	bh=JcJIusOV0U5KmRM3cpINBjVl9X8oxoKjpK9CTbipBiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V7I+RrsGF8UGK1zo0Tyl0/7yL6sh6wRK7dkaTixOtBk77eiwFzo3iykbt7FZNVcah
	 3cDUbrdQ+j6qp9uVi1GvMProAbGBBZFcqTmQ//JJ+La8VWiJLmcIivfhe/4YMN9N7V
	 aoVRgQghq3q8d8HeWMWwsxJtsJehDtKE2RX9fKTJFN3YxiUsXsT5VxHZ6gaTl3Kdbr
	 2GoKDaE6kX0nEbmY1mwJiJPNjutqjWUZP0qe0OBC++wFbQA2uNaaWUVxR5m7VPzinZ
	 ietEmQPAzQ1P3ZVuCgmwptoRL50FhpJS0ahaCam1WqZWeDVBEPLgBvGiQAk8Fwi9zK
	 GZnpn0eUkSxcw==
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
Subject: [PATCH AUTOSEL 6.7 14/14] x86/mce: Mark fatal MCE's page as poison to avoid panic in the kdump kernel
Date: Mon, 15 Jan 2024 18:23:28 -0500
Message-ID: <20240115232351.208489-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115232351.208489-1-sashal@kernel.org>
References: <20240115232351.208489-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
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
index 7b397370b4d6..df8d25e744d1 100644
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
-- 
2.43.0


