Return-Path: <linux-kernel+bounces-92549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D004872209
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F71A1C21691
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7221272A3;
	Tue,  5 Mar 2024 14:54:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC4D6127;
	Tue,  5 Mar 2024 14:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709650442; cv=none; b=e2BuvSi8DpyEdrUgsPyNzYRRmQAStvYFLCJuAmOiGDx2pJJSkgzCnWBuX9Nk14Qher3X242wMOf20a1UC6psVC1foQ6sCZNHTNiJnvAxPzOnOPSPOf/6m8IrRUYRJujlA293B5lnB82hViXdIoOHIKFUXrUDkuFrC91O3OoBvkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709650442; c=relaxed/simple;
	bh=RIA85WUsvoaR0l2yajYG2tSdVf08/i/yUJ9xFRgITs8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rFSh7Ut1DzGGyauojKimplDnkvHTwSHRNuuzpVQJk508AzNwyfKt5gFsjcS0XBR5in8N9rlnehHaCj2bEG5oBEOXXDtyFh4gNbmMSIvpsO2XlEElN9if/V4vBsRjyN4nr22APU2e/1pUsht6JzoI00gKe2GTrkLjP4rwk55IM6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F3541FB;
	Tue,  5 Mar 2024 06:54:37 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C47693F762;
	Tue,  5 Mar 2024 06:53:58 -0800 (PST)
From: "levi.yun" <yeoreum.yun@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	peterz@infradead.org,
	mathieu.desnoyers@efficios.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	nd@arm.com,
	"levi.yun" <yeoreum.yun@arm.com>,
	stable@vger.kernel.org,
	Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH] arm64/mm: Add memory barrier for mm_cid
Date: Tue,  5 Mar 2024 14:53:35 +0000
Message-Id: <20240305145335.2696125-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently arm64's switch_mm() doesn't always have an smp_mb()
which the core scheduler code has depended upon since commit:

    commit 223baf9d17f25 ("sched: Fix performance regression introduced by mm_cid")

If switch_mm() doesn't call smp_mb(), sched_mm_cid_remote_clear()
can unset the activly used cid when it fails to observe active task after it
sets lazy_put.

By adding an smp_mb() in arm64's check_and_switch_context(),
Guarantee to observe active task after sched_mm_cid_remote_clear()
success to set lazy_put.

Signed-off-by: levi.yun <yeoreum.yun@arm.com>
Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by mm_cid")
Cc: <stable@vger.kernel.org> # 6.4.x
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Aaron Lu <aaron.lu@intel.com>
---
 I'm really sorry if you got this multiple times.
 I had some problems with the SMTP server...

 arch/arm64/mm/context.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 188197590fc9..7a9e8e6647a0 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -268,6 +268,11 @@ void check_and_switch_context(struct mm_struct *mm)
 	 */
 	if (!system_uses_ttbr0_pan())
 		cpu_switch_mm(mm->pgd, mm);
+
+	/*
+	 * See the comments on switch_mm_cid describing user -> user transition.
+	 */
+	smp_mb();
 }

 unsigned long arm64_mm_context_get(struct mm_struct *mm)
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


