Return-Path: <linux-kernel+bounces-130031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5662897366
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AED41F22542
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A35114A090;
	Wed,  3 Apr 2024 15:05:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8096114A088
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 15:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156758; cv=none; b=H79XvuJDLlPJ+YT21m6ayUobekHn72U9SQktoEpboO142aQpPlVjW3M6RU9nMSgkK79qfCWmxs6qcWUlKtLhtiQAW3hKC+fZCyimIJrIK4deGANx+7UT8NrPmpUOMPVJHVXOxX4cl8P4JJ9mYPqOEQRH+a3ZMTZOpie674flpng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156758; c=relaxed/simple;
	bh=W/VsaHnLv+3GqcNp0lotH5qolwDsGkmWsY6JTpP9L98=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j+25QBMCvKYA7Fh0iMMVGQmspjsA07UF9cElAlxn2JHOsviqeF+DlouZtxvqrCn8689+L2GIOolkHOEfGqer0efgZJWEbMWMk2p7XX1/xMTzq219SpPwkaz2WKNro3ZsdbbLFaLNOFM2FiwClBOU7xn7p+OYmA91sCdrK/uv6ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA9311007;
	Wed,  3 Apr 2024 08:06:27 -0700 (PDT)
Received: from e126645.arm.com (unknown [10.57.74.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 768C83F7B4;
	Wed,  3 Apr 2024 08:05:52 -0700 (PDT)
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Aaron Lu <aaron.lu@intel.com>,
	Rui Zhang <rui.zhang@intel.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH 0/7] sched/fair|isolation: Correctly clear nohz.[nr_cpus|idle_cpus_mask] for isolated CPUs
Date: Wed,  3 Apr 2024 17:05:32 +0200
Message-Id: <20240403150543.2793354-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Zhang Rui reported that find_new_ilb() was iterating over CPUs in
isolated cgroup partitions. This triggered spurious wakeups for
theses CPUs. [1]
The initial approach was to ignore CPUs on NULL sched domains, as
isolated CPUs have a NULL sched domain. However a CPU:
- with its tick disabled, so taken into account in
  nohz.[idle_cpus_mask|nr_cpus]
- which is placed in an isolated cgroup partition
will never update nohz.[idle_cpus_mask|nr_cpus] again.

To avoid that, the following variables should be cleared
when a CPU is placed in an isolated cgroup partition:
- nohz.idle_cpus_mask
- nohz.nr_cpus
- rq->nohz_tick_stopped
This would allow to avoid considering wrong nohz.* values during
idle load balance.

As suggested in [2] and to avoid calling nohz_balance_[enter|exit]_idle()
from a remote CPU and create concurrency issues, leverage the existing
housekeeping HK_TYPE_SCHED mask to reflect isolated CPUs (i.e. on NULL
sched domains).
Indeed the HK_TYPE_SCHED mask is currently never set by the
isolcpus/nohz_full kernel parameters, so it defaults to cpu_online_mask.
Plus it's current usage fits CPUs that are isolated and should
not take part in load balancing.

Making use of HK_TYPE_SCHED for this purpose implies creating a
housekeeping mask which can be modified at runtime.

[1] https://lore.kernel.org/all/20230804090858.7605-1-rui.zhang@intel.com/
[2] https://lore.kernel.org/all/CAKfTPtAMd_KNKhXXGk5MEibzzQUX3BFkWgxtEW2o8FFTX99DKw@mail.gmail.com/

Pierre Gondois (7):
  sched/isolation: Introduce housekeeping_runtime isolation
  sched/isolation: Move HK_TYPE_SCHED to housekeeping runtime
  sched/isolation: Use HKR_TYPE_SCHED in find_new_ilb()
  sched/fair: Move/add on_null_domain()/housekeeping_cpu() checks
  sched/topology: Remove CPUs with NULL sd from HKR_TYPE_SCHED mask
  sched/fair: Remove on_null_domain() and redundant checks
  sched/fair: Clear idle_cpus_mask for CPUs with NULL sd

 include/linux/sched/isolation.h | 30 ++++++++++++++++++++-
 include/linux/sched/nohz.h      |  2 ++
 kernel/sched/fair.c             | 44 +++++++++++++++++-------------
 kernel/sched/isolation.c        | 48 ++++++++++++++++++++++++++++++++-
 kernel/sched/topology.c         |  7 +++++
 5 files changed, 110 insertions(+), 21 deletions(-)

-- 
2.25.1


