Return-Path: <linux-kernel+bounces-126938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 271A88944AF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49DB01C21823
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C22F4F207;
	Mon,  1 Apr 2024 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bSt9XgnM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB9B4E1D5
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 18:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711995410; cv=none; b=pTeKPrBCmfK2nExhKeTefXUtiFFXgcwuevJNYsKNVET/yqXrvhBxBJYCBHMYMaAEK7a+Q9saAOlZ3D+Wcsin+mUjems+4iLGxrvV/eS4hNOfm9LCxw2xIFiyBuT7Tnjph+/j4GZvzmLhi7kdfB7jTU0ozmdgA1oAGqgCxpw9lbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711995410; c=relaxed/simple;
	bh=zG3+7IPR524nem9b/7o5Jlb+DnYN4wgN1HAo+maBEpY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XtccPW6FhKlpO8qwBCUwvxgUpwoDs2mbaztKU323UV8cCFOiaURETmKIHg//2FmxGrI+titd9O6WyG2+jO9IMoxladWejJBXROo1NlhyUYCmx0ysKSorzu+ZrZTnzwxscX2M/sQSINOxrO2qqDErpswnpjh271JSd4ZOn2SigiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bSt9XgnM; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711995409; x=1743531409;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zG3+7IPR524nem9b/7o5Jlb+DnYN4wgN1HAo+maBEpY=;
  b=bSt9XgnM3yoZF7l0vZPnvqSOz3TQr/Ukn9W4AitZJLdizaLTxPvdy9tW
   1XGR4TT5NPCy4cGp0jPwN8qc+d6ILwx6XXUijPHZwZ2Kp0ddC7pOJFvEx
   MUNx1GI6fqEuJZj4yF2Kuj5uMEUlT8yazC0chbshwdSSCYo0LQ63YK4fE
   LGfzIJm5w9wo3Zk43KXvRa+1E9XNvGpDDf66iUXpbC/Bcn3sB20yPxEOl
   cDy5ueJKwYeg8DPm2lJFw9mue7Cpkaq+ZOBJ4bD+jaIZQ42PmlFb6plUk
   zv6IvPNc5oFhMUMnGouGWGSubdh0InJ3rvq8C05sDUrxZP44ikxvFtvkQ
   g==;
X-CSE-ConnectionGUID: nDnxtafqT7S20C6GsoGr2Q==
X-CSE-MsgGUID: DG9WpD9jRZqF7Caw5f+gLQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="18286478"
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="18286478"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 11:16:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="17613677"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 11:16:48 -0700
From: Reinette Chatre <reinette.chatre@intel.com>
To: fenghua.yu@intel.com,
	bp@alien8.de,
	james.morse@arm.com,
	tony.luck@intel.com,
	peternewman@google.com,
	babu.moger@amd.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org
Cc: reinette.chatre@intel.com,
	hpa@zytor.com,
	james.greenhalgh@arm.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2] x86/resctrl: Fix uninitialized memory read when last CPU of domain goes offline
Date: Mon,  1 Apr 2024 11:16:39 -0700
Message-Id: <ff8dfc8d3dcb04b236d523d1e0de13d2ef585223.1711993956.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tony encountered the OOPS below when the last CPU of a domain goes
offline while running a kernel built with CONFIG_NO_HZ_FULL:

    BUG: kernel NULL pointer dereference, address: 0000000000000000
    #PF: supervisor read access in kernel mode
    #PF: error_code(0x0000) - not-present page
    PGD 0
    Oops: 0000 [#1] PREEMPT SMP NOPTI
    ...
    RIP: 0010:__find_nth_andnot_bit+0x66/0x110
    ...
    Call Trace:
     <TASK>
     ? __die+0x1f/0x60
     ? page_fault_oops+0x176/0x5a0
     ? exc_page_fault+0x7f/0x260
     ? asm_exc_page_fault+0x22/0x30
     ? __pfx_resctrl_arch_offline_cpu+0x10/0x10
     ? __find_nth_andnot_bit+0x66/0x110
     ? __cancel_work+0x7d/0xc0
     cpumask_any_housekeeping+0x55/0x110
     mbm_setup_overflow_handler+0x40/0x70
     resctrl_offline_cpu+0x101/0x110
     resctrl_arch_offline_cpu+0x19/0x260
     cpuhp_invoke_callback+0x156/0x6b0
     ? cpuhp_thread_fun+0x5f/0x250
     cpuhp_thread_fun+0x1ca/0x250
     ? __pfx_smpboot_thread_fn+0x10/0x10
     smpboot_thread_fn+0x184/0x220
     kthread+0xe0/0x110
     ? __pfx_kthread+0x10/0x10
     ret_from_fork+0x2d/0x50
     ? __pfx_kthread+0x10/0x10
     ret_from_fork_asm+0x1a/0x30
     </TASK>

The NULL pointer dereference is encountered while searching for another
online CPU in the domain (of which there are none) that can be used to
run the MBM overflow handler.

Because the kernel is configured with CONFIG_NO_HZ_FULL the search for
another CPU (in its effort to prefer those CPUs that aren't marked
nohz_full) consults the mask representing the nohz_full CPUs,
tick_nohz_full_mask. On a kernel with CONFIG_CPUMASK_OFFSTACK=y
tick_nohz_full_mask is not allocated unless the kernel is booted with
the "nohz_full=" parameter and because of that any access to
tick_nohz_full_mask needs to be guarded with tick_nohz_full_enabled().

Replace the IS_ENABLED(CONFIG_NO_HZ_FULL) with tick_nohz_full_enabled().
The latter ensures tick_nohz_full_mask can be accessed safely and can be
used whether kernel is built with CONFIG_NO_HZ_FULL enabled or not.

Fixes: a4846aaf3945 ("x86/resctrl: Add cpumask_any_housekeeping() for limbo/overflow")
Reported-by: Tony Luck <tony.luck@intel.com>
Closes: https://lore.kernel.org/lkml/ZgIFT5gZgIQ9A9G7@agluck-desk3/
Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since v1:
- Use Ingo's suggestion that combines the two NO_HZ checks into one.
- Tony provided tags but since patch changed so much I did not apply
  tags to this version.

 arch/x86/kernel/cpu/resctrl/internal.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index c99f26ebe7a6..1a8687f8073a 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -78,7 +78,8 @@ cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
 	else
 		cpu = cpumask_any_but(mask, exclude_cpu);
 
-	if (!IS_ENABLED(CONFIG_NO_HZ_FULL))
+	/* Only continue if tick_nohz_full_mask has been initialized. */
+	if (!tick_nohz_full_enabled())
 		return cpu;
 
 	/* If the CPU picked isn't marked nohz_full nothing more needs doing. */
-- 
2.34.1


