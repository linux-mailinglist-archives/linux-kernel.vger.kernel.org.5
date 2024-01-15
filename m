Return-Path: <linux-kernel+bounces-26599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 142CA82E3FA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1CD3283EC1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 23:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23F025568;
	Mon, 15 Jan 2024 23:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yt8A4zze"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4864D250F9;
	Mon, 15 Jan 2024 23:29:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921C7C43390;
	Mon, 15 Jan 2024 23:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705361368;
	bh=AAh+uGmipW3RHoV1EKrPOcOTvATX2HK9C4c49hQ5eWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yt8A4zzearpd6WaeWuT60IlMlZbazcKSdtdA+mHLtSNBOB/BRGDhcNvsUL6UfwbbY
	 9aZ0Bq/LJV8gwtjU2N0m4Ipom41BiZ3dWAdV/0ZBhbPg9BbxjLYDy5dXLF0mdfOHlI
	 U1t+THz6NrEH3Um4w9RCzcPi4Gv+jBdaxSvJesVLj6X/K2AugAKq6inrJ1/1TEiDka
	 m0JfgTbkwFlAWxyamXGN0K+DNiER+EuULkJzLIHusYrMPnLe8pcNWudXLdXDkZQwQ5
	 wfczHJnHQR13QR+6sdrfo1bHjgKkjWs4aYNt7QgMtw+AFtGir2ZcI83nvBsiu9LGlU
	 Cd3v7cgzGihZg==
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
Subject: [PATCH AUTOSEL 5.4 7/7] x86/mce: Mark fatal MCE's page as poison to avoid panic in the kdump kernel
Date: Mon, 15 Jan 2024 18:28:52 -0500
Message-ID: <20240115232905.210324-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115232905.210324-1-sashal@kernel.org>
References: <20240115232905.210324-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
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
index 9b98a7d8ac60..84c0e5c2518c 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -42,6 +42,7 @@
 #include <linux/export.h>
 #include <linux/jump_label.h>
 #include <linux/set_memory.h>
+#include <linux/kexec.h>
 
 #include <asm/intel-family.h>
 #include <asm/processor.h>
@@ -315,6 +316,7 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
 	struct llist_node *pending;
 	struct mce_evt_llist *l;
 	int apei_err = 0;
+	struct page *p;
 
 	/*
 	 * Allow instrumentation around external facilities usage. Not that it
@@ -370,6 +372,20 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
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


