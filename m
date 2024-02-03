Return-Path: <linux-kernel+bounces-50898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB1E84800C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 05:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C07941C219C2
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 04:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD0CFBEE;
	Sat,  3 Feb 2024 04:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kr+VmuHs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C903D10A01;
	Sat,  3 Feb 2024 04:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933045; cv=none; b=X+gSTJsK2wI9EJnCjZeVIYfQIjs5ojQGiiofXRwUmwVWBoJBEUgG4STTfUxIUQw9Tvej/hgQ1+K+HbUngZ4gNL6WBBAp8rYEsRGT1FJbT8wXUG2f87xq05i0ju5U28lnv8X1x5qebn4/O66vepokCUPF8pdfd6U1Yqufn+Jze7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933045; c=relaxed/simple;
	bh=uBQ2nzIKHxijDsNSigFi3DaKfw8tyvU+BvqfqIwROi8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=skiSNRO/dS2kDZLs/zDr17IPWJ8ysJujt+oUnv/ldOtr663jsVVVnZH+WjHGOLxNx1SpY2vYcZqZJGSc3BUMt4e0qsWsl97Eic1YJXMwlaNpkmXg0xOwIkkljpI9oKwdBIzvWmDmLPy1NS52pNBYlYQqNqxmF4FHrxz7j7wl4oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kr+VmuHs; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706933044; x=1738469044;
  h=from:to:cc:subject:date:message-id;
  bh=uBQ2nzIKHxijDsNSigFi3DaKfw8tyvU+BvqfqIwROi8=;
  b=kr+VmuHsWNhobJKsfLDmS5w5i+cNcNSpLdLrLlZ0QL2qRAimikwVyEVw
   kr/cVARGy9KTs9MicceHeFqhStzyvK63A/wb8WAAa16fg0lxlDKixnQWI
   azbYbrzIj8yFlMRNdv2VlSYrlkrvGcX4OwX+60N8BbcuMUmvDEGErKAit
   xc9hw3DG15pz0+BybPuS4ga93A2Zr6X/1MP103vpj1trR9qy9fDxucXp6
   Qu+P3RNEOrW3WC9lAwwWD4RziqZHH/zQEoxewuxdIkZS9TqWAAt37A1en
   2OtfVd9W1+SOJ3MrCGRQbMo1zcUvScMgzclXhT2ayoh5zdgYTFzo4lU2V
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="4181411"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="4181411"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 20:04:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="823382498"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="823382498"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga001.jf.intel.com with ESMTP; 02 Feb 2024 20:04:02 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Len Brown <len.brown@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Zhuocheng Ding <zhuocheng.ding@intel.com>,
	x86@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH 0/9] thermal: intel: hfi: Prework for the virtualization of HFI
Date: Fri,  2 Feb 2024 20:05:06 -0800
Message-Id: <20240203040515.23947-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Zhao Liu will soon post a patchset to virtualize the Hardware Feedback
Interface (HFI) and Intel Thread Director (ITD) for the benefit of virtual
machines that make use of ITD for scheduling. His experiments show up to
14% improvement in performance in some workloads and configurations. This
series lays the foundation for his patchset. I will share Zhao's patchset
when available.

Patches 1-3 reorganize portions of the HFI driver to facilitate the
implementation of virtual HFI tables. In my opinion, this reorganization is
valuable on its own.

Patches 4-6 introduce the concept of ITD classes and enable ITD.

Patches 7-9 add support to reset the ITD classification history of the
current task to be used during context switch.

Several patches of the series were cherry-picked from my last submission
to support IPC classes of tasks for scheduling [1], but this series does
not touch the scheduler. I have kept the Reviewed-by and Acked-by tags of
the cherry-picked patches.

In this iteration, the virtualization of HFI requires that HFI and ITD are
unconditionally enabled in the bare-metal system. This conflicts with a
recent patchset from Stanislaw [2] that only enables HFI if there are
user space entities listening to thermal netlink events. I am not sure
how to resolve this conflict. Please see patch 6 for a discussion.

Patches apply cleanly on Rafael's master and testing branches at the time
of posting.

Thanks and BR,
Ricardo

[1] https://lore.kernel.org/all/20230613042422.5344-1-ricardo.neri-calderon@linux.intel.com/
[2] https://lore.kernel.org/all/20240131120535.933424-1-stanislaw.gruszka@linux.intel.com/
 

Ricardo Neri (6):
  thermal: intel: hfi: Introduce Intel Thread Director classes
  x86/cpufeatures: Add the Intel Thread Director feature definitions
  thermal: intel: hfi: Enable Intel Thread Director
  x86/cpufeatures: Add feature bit for HRESET
  x86/hreset: Configure history reset
  x86/cpu: Introduce interface to reset hardware history

Zhao Liu (2):
  thermal: intel: hfi: Relocate bit definitions of HFI registers
  thermal: intel: hfi: Introduce the hfi_table structure

Zhuocheng Ding (1):
  thermal: intel: hfi: Move selected data structures to a header file

 MAINTAINERS                        |   1 +
 arch/x86/include/asm/cpufeatures.h |   2 +
 arch/x86/include/asm/hfi.h         |  85 +++++++++++++++
 arch/x86/include/asm/hreset.h      |  30 ++++++
 arch/x86/include/asm/msr-index.h   |  13 +++
 arch/x86/kernel/cpu/common.c       |  31 +++++-
 arch/x86/kernel/cpu/cpuid-deps.c   |   1 +
 drivers/thermal/intel/intel_hfi.c  | 165 +++++++++++++++--------------
 8 files changed, 245 insertions(+), 83 deletions(-)
 create mode 100644 arch/x86/include/asm/hfi.h
 create mode 100644 arch/x86/include/asm/hreset.h

-- 
2.25.1


