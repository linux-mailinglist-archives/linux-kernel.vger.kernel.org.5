Return-Path: <linux-kernel+bounces-101799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9DC87ABB4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57078287790
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF9267C5A;
	Wed, 13 Mar 2024 16:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udLwGm1H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B41267C49;
	Wed, 13 Mar 2024 16:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347656; cv=none; b=kHbLLcxr9umVFWQdJ/2zaWAyFnGlIveKJalSuxvwOeMQtuh9uEGEhjxibKA57vjJh0RPCrj/uF/WdlrbE+34KlP713NyKUKDoaOZewdSkt7X9zGu5WJXaUNTnyQQpUr6yf9KUHRf5MOqy3bP1cJyz4eb+H5mWn4XRWSEBSPM5cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347656; c=relaxed/simple;
	bh=Qaj5IwduPnsQ07HAtin4ZncLH0Y0BKw4SqhUzih49pY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=egoLtJnmghHWe+bF1AniE4q3cMwogLs9JCYLYsaNg4eEt90J0fbQaO3XOYBHRzK+SUV3ZjuZ1qpFO3Ff/ajgMC1Q4X2JXtOOm/meV2MIgjLZ1DzDcqbqv0eli3u1lvFa+CbvKyx65Iits+ZlWNt8P1WTQFTj9tRNCJZQG7MIG08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udLwGm1H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF1CC43394;
	Wed, 13 Mar 2024 16:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347655;
	bh=Qaj5IwduPnsQ07HAtin4ZncLH0Y0BKw4SqhUzih49pY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=udLwGm1H6AZwHSY3vKZ1sppmOXcRVDQNYuTXvxYMBKsgh3Q/zHWTVQWVD5wMpA3dq
	 ukbkDWMoGjkWWpK2rqpUCJ3TBE5vMjMvo+af/UZv3jAGbfRocuuMFmj1Bo0Hdb/33j
	 fGi8Cf+Yk6sdqzGQcEAaCCYyg+QwmqOlON6bQ/jVNwMobsn0RrjmRPAP/iGvXE9o42
	 HcMvA8r5Pb1t6WWwAwZ26jQKFs6WokbqWLcMHWlG262IL41cTMdubnrgyd+HfaxF6E
	 UOH9U8OTEdpHEeLlzeE+C8WsTTajW3PJxSuaiKael4D69MWTNMwB91EURBFBdVj/oI
	 hcYaaj/zZlhBQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Suren Baghdasaryan <surenb@google.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andy Lutomirski <luto@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 60/61] arch/arm/mm: fix major fault accounting when retrying under per-VMA lock
Date: Wed, 13 Mar 2024 12:32:35 -0400
Message-ID: <20240313163236.613880-61-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163236.613880-1-sashal@kernel.org>
References: <20240313163236.613880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.7.10-rc1
X-KernelTest-Deadline: 2024-03-15T16:32+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Suren Baghdasaryan <surenb@google.com>

[ Upstream commit e870920bbe68e52335a4c31a059e6af6a9a59dbb ]

The change [1] missed ARM architecture when fixing major fault accounting
for page fault retry under per-VMA lock.

The user-visible effects is that it restores correct major fault
accounting that was broken after [2] was merged in 6.7 kernel. The
more detailed description is in [3] and this patch simply adds the
same fix to ARM architecture which I missed in [3].

Add missing code to fix ARM architecture fault accounting.

[1] 46e714c729c8 ("arch/mm/fault: fix major fault accounting when retrying under per-VMA lock")
[2] https://lore.kernel.org/all/20231006195318.4087158-6-willy@infradead.org/
[3] https://lore.kernel.org/all/20231226214610.109282-1-surenb@google.com/

Link: https://lkml.kernel.org/r/20240123064305.2829244-1-surenb@google.com
Fixes: 12214eba1992 ("mm: handle read faults under the VMA lock")
Reported-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mm/fault.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index e96fb40b9cc32..07565b593ed68 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -298,6 +298,8 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 		goto done;
 	}
 	count_vm_vma_lock_event(VMA_LOCK_RETRY);
+	if (fault & VM_FAULT_MAJOR)
+		flags |= FAULT_FLAG_TRIED;
 
 	/* Quick path to respond to signals */
 	if (fault_signal_pending(fault, regs)) {
-- 
2.43.0


