Return-Path: <linux-kernel+bounces-110416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 171F3885EEA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 382E71C23732
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD37137C3A;
	Thu, 21 Mar 2024 16:51:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3558137C20
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039881; cv=none; b=Fx2eBIk2KAMvyAP+ZWlfnBYt/WX6pbtBlzZPe8Y04kYnonA64tezGiXDoXs+k0IqeFt9orvYLfd9gv14caV5rN5QnITuQvEMBj0K+Jf5EM4fTjdGIMI+Coy5A3ZrLHqQIi39TDFjyr912vPMMHTvNBq6dlT24QQcokStv7++nj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039881; c=relaxed/simple;
	bh=tVf8yAhrkX/TrWZEX/g7UP+QODGzySo0OkwWF2k2Ha0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kykJSRyqBwy5sAO0mYWJ2ZSgI13caA2yl6m2lLyfC2uscOszLDKFwYCMQzkXlYLgvhEGJBOpxPSym2MXT71fcINTvaLKYEG7dU9zZOzb1EB8APu+xdJ6eGSH/2Zri9IWh7PyR5m67LxcrEGTTarwJ3S/WUxJwL9uNUwFiqqybj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51FE81007;
	Thu, 21 Mar 2024 09:51:52 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1142D3F67D;
	Thu, 21 Mar 2024 09:51:14 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	James Morse <james.morse@arm.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	peternewman@google.com,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>
Subject: [PATCH v1 00/31] x86/resctrl: Move the resctrl filesystem code to /fs/resctrl
Date: Thu, 21 Mar 2024 16:50:35 +0000
Message-Id: <20240321165106.31602-1-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello!

This is the final series that allows other architectures to implement resctrl.
The last patch just moves the code, and its a bit of a monster. I don't expect
that to get merged as part of this series - we should wait for it to make
less impact on other series. It's included here to show what gets moved, and
that structures/function-prototypes have the right visibility.

Otherwise this series renames functions and moves code around. With the
exception of invalid configurations for the configurable-events, there should
be no changes in behaviour caused by this series.

The driving pattern is to make things like struct rdtgroup private to resctrl.
Features like pseudo-lock aren't going to work on arm64, the ability to disable
it at compile time is added.

After this, I can start posting the MPAM driver to make use of resctrl on arm64.
(What's MPAM? See the cover letter of the first series. [1])

This series is based on Linus' commit 23956900041d and can be retrieved from:
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
mpam/move_to_fs/v1

Sorry for the mid-merge window base, I'm away for a few weeks - this should
rebase trivially onto rc1.

As ever - bugs welcome,
Thanks,

James

[1] https://lore.kernel.org/lkml/20201030161120.227225-1-james.morse@arm.com/

James Morse (31):
  x86/resctrl: Fix allocation of cleanest CLOSID on platforms with no
    monitors
  x86/resctrl: Add a helper to avoid reaching into the arch code
    resource list
  x86/resctrl: Move ctrlval string parsing policy away from the arch
    code
  x86/resctrl: Add helper for setting CPU default properties
  x86/resctrl: Remove rdtgroup from update_cpu_closid_rmid()
  x86/resctrl: Export resctrl fs's init function
  x86/resctrl: Wrap resctrl_arch_find_domain() around rdt_find_domain()
  x86/resctrl: Move resctrl types to a separate header
  x86/resctrl: Add a resctrl helper to reset all the resources
  x86/resctrl: Move monitor init work to a resctrl init call
  x86/resctrl: Move monitor exit work to a restrl exit call
  x86/resctrl: Move max_{name,data}_width into resctrl code
  x86/resctrl: Stop using the for_each_*_rdt_resource() walkers
  x86/resctrl: Export the is_mbm_*_enabled() helpers to asm/resctrl.h
  x86/resctrl: Add resctrl_arch_is_evt_configurable() to abstract BMEC
  x86/resctrl: Change mon_event_config_{read,write}() to be arch helpers
  x86/resctrl: Move mbm_cfg_mask to struct rdt_resource
  x86/resctrl: Allow resctrl_arch_mon_event_config_write() to return an
    error
  x86/resctrl: Add resctrl_arch_ prefix to pseudo lock functions
  x86/resctrl: Allow an architecture to disable pseudo lock
  x86/resctrl: Make prefetch_disable_bits belong to the arch code
  x86/resctrl: Make resctrl_arch_pseudo_lock_fn() take a plr
  x86/resctrl: Move thread_throttle_mode_init() to be managed by resctrl
  x86/resctrl: Move get_config_index() to a header
  x86/resctrl: Claim get_domain_from_cpu() for resctrl
  x86/resctrl: Describe resctrl's bitmap size assumptions
  x86/resctrl: Rename resctrl_sched_in() to begin resctrl_arch_
  x86/resctrl: Drop __init/__exit on assorted symbols
  fs/resctrl: Add boiler plate for external resctrl code
  x86/resctrl: Move the filesystem bits to headers visible to fs/resctrl
  x86/resctrl: Move the resctrl filesystem code to /fs/resctrl

 MAINTAINERS                               |    2 +
 arch/Kconfig                              |    8 +
 arch/x86/Kconfig                          |    5 +-
 arch/x86/include/asm/resctrl.h            |   45 +-
 arch/x86/kernel/cpu/resctrl/Makefile      |    5 +-
 arch/x86/kernel/cpu/resctrl/core.c        |  119 +-
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  506 +--
 arch/x86/kernel/cpu/resctrl/internal.h    |  433 +--
 arch/x86/kernel/cpu/resctrl/monitor.c     |  813 +----
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 1126 +-----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 3929 +-------------------
 arch/x86/kernel/process_32.c              |    2 +-
 arch/x86/kernel/process_64.c              |    2 +-
 fs/Kconfig                                |    1 +
 fs/Makefile                               |    1 +
 fs/resctrl/Kconfig                        |   23 +
 fs/resctrl/Makefile                       |    3 +
 fs/resctrl/ctrlmondata.c                  |  527 +++
 fs/resctrl/internal.h                     |  340 ++
 fs/resctrl/monitor.c                      |  843 +++++
 fs/resctrl/psuedo_lock.c                  | 1122 ++++++
 fs/resctrl/rdtgroup.c                     | 4013 +++++++++++++++++++++
 include/linux/resctrl.h                   |  153 +-
 include/linux/resctrl_types.h             |   98 +
 24 files changed, 7244 insertions(+), 6875 deletions(-)
 create mode 100644 fs/resctrl/Kconfig
 create mode 100644 fs/resctrl/Makefile
 create mode 100644 fs/resctrl/ctrlmondata.c
 create mode 100644 fs/resctrl/internal.h
 create mode 100644 fs/resctrl/monitor.c
 create mode 100644 fs/resctrl/psuedo_lock.c
 create mode 100644 fs/resctrl/rdtgroup.c
 create mode 100644 include/linux/resctrl_types.h

-- 
2.39.2


