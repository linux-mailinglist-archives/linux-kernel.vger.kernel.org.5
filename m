Return-Path: <linux-kernel+bounces-123660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 648B5890C50
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956EF1C22712
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BB11384A3;
	Thu, 28 Mar 2024 21:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AFbRNhmP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6387E110
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 21:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711660361; cv=none; b=YxBxbtoMboscr5G4MpgC46AUxQyf5EbllLM0XGYrkrj2XzZt2Pf2zZQY+r/Z/TnviTizNA1/Io9DZrECWQc0ewQDoEjp3UOdsZ3L8h9S/nCQMn+FfvU7sO42vUEHtUjP0faFA07Gpnweq8r/hnpu9bk7+OHTnWqqHdQh63vG15A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711660361; c=relaxed/simple;
	bh=z7VVmEPOHLzIbHYO1FWd+nTI8cZCOzNKAmnVJMjZBAA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NqScRpB780Aq3G/UmHC56wklI1TMk+mWVBQ66VoQG04BZz/sl44pxE9/6Y21GA14HBkVcylWyHFZQLi7rT+WQIK77KKkxlHwZgMZtgO0iKf+J0TAFrxfrHxhjIy1chy0nTmdYJqvqXYvUbuQ5Jf3TSulF5F2z4uvqH3mFzztsS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AFbRNhmP; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711660360; x=1743196360;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z7VVmEPOHLzIbHYO1FWd+nTI8cZCOzNKAmnVJMjZBAA=;
  b=AFbRNhmPY0LHNcLYLXqyEpsUr2UwrFjEC7vhABNkZP3Kf5IeixvPJ04v
   Rbcp4ik+n1q/HewtB54jjQ3624QSBmcaw+aSHZf2+SXZjHOKMAXm5kAWW
   z4AZMWe9dM+jDbsRdjs4IIzPGFoI4pPX9K88HFCFFU0Mo2dslk5oHp/Qh
   8ZBFaEwik9UEtqNdEiWDZYpVCDVgjthK10SXII2B+zUZpeu5mGz8U3E6G
   5x8ndEKrNcycr83QyI3gsusFaXmYPIslgsVZepkk4cCAdhRFh2oZEbmoP
   SbPZSU5rrq+ulG+NCyEzKv073GoUt5Dk8PabhEKYNSGV+6RoqWpshlaZy
   Q==;
X-CSE-ConnectionGUID: ZdCLZif7RlycqrJwLxCGdQ==
X-CSE-MsgGUID: BI7PdRBsTP2s2ykqgygz1A==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6956627"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="6956627"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 14:12:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="16825426"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 14:12:35 -0700
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
Subject: [PATCH] x86/resctrl: Fix uninitialized memory read when last CPU of domain goes offline
Date: Thu, 28 Mar 2024 14:12:29 -0700
Message-Id: <979cfd9522021aa6001f8995cd36fb56e1c9cd39.1711659804.git.reinette.chatre@intel.com>
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

Add a tick_nohz_full_enabled() check to ensure that tick_nohz_full_mask
has been initialized and can thus be accessed safely.

Fixes: a4846aaf3945 ("x86/resctrl: Add cpumask_any_housekeeping() for limbo/overflow")
Reported-by: Tony Luck <tony.luck@intel.com>
Closes: https://lore.kernel.org/lkml/ZgIFT5gZgIQ9A9G7@agluck-desk3/
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index c99f26ebe7a6..4f9ef35626a7 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -85,6 +85,10 @@ cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
 	if (cpu < nr_cpu_ids && !tick_nohz_full_cpu(cpu))
 		return cpu;
 
+	/* Only continue if tick_nohz_full_mask has been initialized. */
+	if (!tick_nohz_full_enabled())
+		return cpu;
+
 	/* Try to find a CPU that isn't nohz_full to use in preference */
 	hk_cpu = cpumask_nth_andnot(0, mask, tick_nohz_full_mask);
 	if (hk_cpu == exclude_cpu)
-- 
2.34.1


