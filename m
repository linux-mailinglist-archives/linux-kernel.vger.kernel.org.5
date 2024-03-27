Return-Path: <linux-kernel+bounces-121849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD72788EE7C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6701C2DA45
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A686A15098B;
	Wed, 27 Mar 2024 18:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S4uRtJbN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356951514D1
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 18:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711565189; cv=none; b=r6Ld1JTRNX6AD5bjQlsZz20AcaH4oYidUXvyMCSBT1vqXkfr209Ax8SjLJAVVXGF1Q0Un/YMQH+jvGTgvymQCnhGo/dssebujzAkpEk8EvH0BE/qIGcy8fR61gbt+YRe3+RMxtvVndBTu2V7vGQvXI+xWXzfU+ADV1QiSy21F/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711565189; c=relaxed/simple;
	bh=6jTNNckr/iN2u9ouaEaChpJiwXaDXSK/sMLw6TtzJXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bfh1tMEk0IBz5UYrBzqtE3/7336uNUvpw79Ip4PZbnw0gmYVBxHJAraVQ7s47eQssd8uyacE7n3uTHaNVYBqOUPf2gJzhOscN/wTfw1CFMH8QIR9YGY8RnchELiLDCwQPsuK9NoDVYxuPKP8iuOxWddTgYKSCBVTpAIYtNrp/TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S4uRtJbN; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711565187; x=1743101187;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6jTNNckr/iN2u9ouaEaChpJiwXaDXSK/sMLw6TtzJXM=;
  b=S4uRtJbN+0ATa9+9rXGn5Cl9PYXjLvKOREzfGUkD3MffNvndgaZN4K3d
   gtgLbULQ8cZTsScO/igcEmGBhitW4VyyrO9MiHTPwJxLVp3CXqmF5ur7v
   oW+n+SJPc3n901NjiXY+p/oFJcHEu7yfKQmi1YPuKMvLYGmpxTBr8DzmB
   bPMxyWDtLjD3itM3pTMG1AWI/mf7xeqbbYnkE4rvvSq+WV7R1dEbRCe3h
   bBcOFD/W60L+Q69QlB+ysiglsDCkK0Tv25r5LVU2pr1NO9JbaDHOR0sXb
   pnE8JHtMDKm8/9jL0VgKSLvxoBy4y99sVJNkBYdVVar5jILnnZIDOom2v
   w==;
X-CSE-ConnectionGUID: P2zTJYRjTaSYlpn3xnhhKA==
X-CSE-MsgGUID: re14RLBfQeqYTs7u9heuTQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="24182914"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="24182914"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 11:46:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="53860548"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 11:46:26 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH] x86/resctrl: Fix mbm_setup_overflow_handler() when last CPU goes offline
Date: Wed, 27 Mar 2024 11:46:19 -0700
Message-ID: <20240327184619.236057-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't bother looking for another CPU to take over MBM overflow duties
when the last CPU in a domain goes offline. Doing so results in this
Oops:

[   97.166136] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   97.173118] #PF: supervisor read access in kernel mode
[   97.178263] #PF: error_code(0x0000) - not-present page
[   97.183410] PGD 0
[   97.185438] Oops: 0000 [#1] PREEMPT SMP NOPTI
[   97.189805] CPU: 36 PID: 235 Comm: cpuhp/36 Tainted: G                T  6.9.0-rc1 #356
[   97.208322] RIP: 0010:__find_nth_andnot_bit+0x66/0x110

Fixes: 978fcca954cb ("x86/resctrl: Allow overflow/limbo handlers to be scheduled on any-but CPU")
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 757d475158a3..4d9987acffd6 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -929,6 +929,10 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms,
 	unsigned long delay = msecs_to_jiffies(delay_ms);
 	int cpu;
 
+	/* Nothing to do if this is the last CPU in a domain going offline */
+	if (!delay_ms && bitmap_weight(cpumask_bits(&dom->cpu_mask), nr_cpu_ids) == 1)
+		return;
+
 	/*
 	 * When a domain comes online there is no guarantee the filesystem is
 	 * mounted. If not, there is no need to catch counter overflow.
-- 
2.44.0


