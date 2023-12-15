Return-Path: <linux-kernel+bounces-1439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3209814F14
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0920B22BF0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDED82EF1;
	Fri, 15 Dec 2023 17:44:03 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3900A82EE5
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 17:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA0DEC15;
	Fri, 15 Dec 2023 09:44:45 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE5243F5A1;
	Fri, 15 Dec 2023 09:43:57 -0800 (PST)
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
	amitsinght@marvell.com
Subject: [PATCH v8 00/24] x86/resctrl: monitored closid+rmid together, separate arch/fs locking
Date: Fri, 15 Dec 2023 17:43:19 +0000
Message-Id: <20231215174343.13872-1-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some of the changes this version are:
 * Fixed a bounds checking bug in cpumask_any_housekeeping(),
 * Moved the kfree() of rmid_ptrs[] later,

Changes are noted in each patch, I've not added 'no changes' notes
if these need double checking anyway. I'll try again next series.

~

This series does two things, it changes resctrl to call resctrl_arch_rmid_read()
in a way that works for MPAM, and it separates the locking so that the arch code
and filesystem code don't have to share a mutex. I tried to split this as two
series, but these touch similar call sites, so it would create more work.

(What's MPAM? See the cover letter of the first series. [1])

On x86 the RMID is an independent number. MPAMs equivalent is PMG, but this
isn't an independent number - it extends the PARTID (same as CLOSID) space
with bits that aren't used to select the configuration. The monitors can
then be told to match specific PMG values, allowing monitor-groups to be
created.

But, MPAM expects the monitors to always monitor by PARTID. The
Cache-storage-utilisation counters can only work this way.
(In the MPAM spec not setting the MATCH_PARTID bit is made CONSTRAINED
UNPREDICTABLE - which is Arm's term to mean portable software can't rely on
this)

It gets worse, as some SoCs may have very few PMG bits. I've seen the
datasheet for one that has a single bit of PMG space.

To be usable, MPAM's counters always need the PARTID and the PMG.
For resctrl, this means always making the CLOSID available when the RMID
is used.

To ensure RMID are always unique, this series combines the CLOSID and RMID
into an index, and manages RMID based on that. For x86, the index and RMID
would always be the same.


Currently the architecture specific code in the cpuhp callbacks takes the
rdtgroup_mutex. This means the filesystem code would have to export this
lock, resulting in an ill-defined interface between the two, and the possibility
of cross-architecture lock-ordering head aches.

The second part of this series adds a domain_list_lock to protect writes to the
domain list, and protects the domain list with RCU - or cpus_read_lock().

Use of RCU is to allow lockless readers of the domain list. To get MPAMs monitors
working, its very likely they'll need to be plumbed up to perf. An uncore PMU
driver would need to be a lockless reader of the domain list.



This series is based on v6.7-rc2, and can be retrieved from:
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/monitors_and_locking/v8

Bugs welcome,

Thanks,

James

[1] https://lore.kernel.org/lkml/20210728170637.25610-1-james.morse@arm.com/
[v1] https://lore.kernel.org/all/20221021131204.5581-1-james.morse@arm.com/
[v2] https://lore.kernel.org/lkml/20230113175459.14825-1-james.morse@arm.com/
[v3] https://lore.kernel.org/r/20230320172620.18254-1-james.morse@arm.com/
[v4] https://lore.kernel.org/r/20230525180209.19497-1-james.morse@arm.com/
[v5] https://lore.kernel.org/lkml/20230728164254.27562-1-james.morse@arm.com/
[v6] https://lore.kernel.org/all/20230914172138.11977-1-james.morse@arm.com/
[v7] https://lore.kernel.org/r/20231025180345.28061-1-james.morse@arm.com/

James Morse (24):
  tick/nohz: Move tick_nohz_full_mask declaration outside the #ifdef
  x86/resctrl: kfree() rmid_ptrs from resctrl_exit()
  x86/resctrl: Create helper for RMID allocation and mondata dir
    creation
  x86/resctrl: Move rmid allocation out of mkdir_rdt_prepare()
  x86/resctrl: Track the closid with the rmid
  x86/resctrl: Access per-rmid structures by index
  x86/resctrl: Allow RMID allocation to be scoped by CLOSID
  x86/resctrl: Track the number of dirty RMID a CLOSID has
  x86/resctrl: Use __set_bit()/__clear_bit() instead of open coding
  x86/resctrl: Allocate the cleanest CLOSID by searching
    closid_num_dirty_rmid
  x86/resctrl: Move CLOSID/RMID matching and setting to use helpers
  x86/resctrl: Add cpumask_any_housekeeping() for limbo/overflow
  x86/resctrl: Queue mon_event_read() instead of sending an IPI
  x86/resctrl: Allow resctrl_arch_rmid_read() to sleep
  x86/resctrl: Allow arch to allocate memory needed in
    resctrl_arch_rmid_read()
  x86/resctrl: Make resctrl_mounted checks explicit
  x86/resctrl: Move alloc/mon static keys into helpers
  x86/resctrl: Make rdt_enable_key the arch's decision to switch
  x86/resctrl: Add helpers for system wide mon/alloc capable
  x86/resctrl: Add CPU online callback for resctrl work
  x86/resctrl: Allow overflow/limbo handlers to be scheduled on any-but
    cpu
  x86/resctrl: Add CPU offline callback for resctrl work
  x86/resctrl: Move domain helper migration into resctrl_offline_cpu()
  x86/resctrl: Separate arch and fs resctrl locks

 arch/x86/include/asm/resctrl.h            |  90 +++++
 arch/x86/kernel/cpu/resctrl/core.c        | 102 ++---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  48 ++-
 arch/x86/kernel/cpu/resctrl/internal.h    |  67 +++-
 arch/x86/kernel/cpu/resctrl/monitor.c     | 449 +++++++++++++++++-----
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  15 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 359 ++++++++++++-----
 include/linux/resctrl.h                   |  48 ++-
 include/linux/tick.h                      |   9 +-
 9 files changed, 911 insertions(+), 276 deletions(-)

-- 
2.20.1


