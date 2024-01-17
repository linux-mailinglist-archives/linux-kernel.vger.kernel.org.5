Return-Path: <linux-kernel+bounces-28770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 485C38302DD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0C551F231B8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDC714281;
	Wed, 17 Jan 2024 09:56:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D708714274;
	Wed, 17 Jan 2024 09:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705485360; cv=none; b=OJT/SdEzJqx33zRqUoxD0EaZfV0G46eS5gbv/rdjT3yPlA6tnTyRJ9q+K3D/TibNVT8XNjTueEdJ8B6dgAgXJ+1MjxhONpYg4z3NEyHfYQNcPXzsju1i23/aPT/If0p8tyrvvK4bSbJZkbpwsdgZQ89cyVGMYhW3tfDNa2G8Jco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705485360; c=relaxed/simple;
	bh=XnD9vMbRDV+0cylEZixzbK9w/8DnsQR86HU3BeWu4wA=;
	h=Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding; b=fNHrhJQf7EgBvMB0xTpi814SxE43LlFHu5tsJZjBGHw2sTKPie4cIecn93ayzLdtorqLro2MwYyqsGMyd6pQJz++Mld7vi+kSNDjMUrydL18J9suGNE5WrHm2uxTYye8Adu/zZk6mymJ0Cqv2jWmjvPIeQXc0aC9IJGspZ0libM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FD48DA7;
	Wed, 17 Jan 2024 01:56:43 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.90.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4B3E13F5A1;
	Wed, 17 Jan 2024 01:55:54 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael@kernel.org
Cc: lukasz.luba@arm.com,
	dietmar.eggemann@arm.com,
	rui.zhang@intel.com,
	amit.kucheria@verdurent.com,
	amit.kachhap@gmail.com,
	daniel.lezcano@linaro.org,
	viresh.kumar@linaro.org,
	len.brown@intel.com,
	pavel@ucw.cz,
	mhiramat@kernel.org,
	qyousef@layalina.io,
	wvw@google.com,
	xuewen.yan94@gmail.com
Subject: [PATCH v7 00/23] Introduce runtime modifiable Energy Model
Date: Wed, 17 Jan 2024 09:56:51 +0000
Message-Id: <20240117095714.1524808-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This patch set adds a new feature which allows to modify Energy Model (EM)
power values at runtime. It will allow to better reflect power model of
a recent SoCs and silicon. Different characteristics of the power usage
can be leveraged and thus better decisions made during task placement in EAS.

It also optimizes the EAS code hot path, by removing 2 division and 1
multiplication operations in the em_cpu_energy(). Speed-up results:
the em_cpu_energy() should run faster on the Big CPU by 1.43x and on the
Little CPU by 1.69x (mainline board RockPi 4B).

This patch set is part of feature set known as Dynamic Energy Model. It has been
presented and discussed recently at OSPM2023 [3].


The concepts:
1. The CPU power usage can vary due to the workload that it's running or due
to the temperature of the SoC. The same workload can use more power when the
temperature of the silicon has increased (e.g. due to hot GPU or ISP).
In such situation the EM can be adjusted and reflect the fact of increased
power usage. That power increase is due to static power
(sometimes called simply: leakage). The CPUs in recent SoCs are different.
We have heterogeneous SoCs with 3 (or even 4) different microarchitectures.
They are also built differently with High Performance (HP) cells or
Low Power (LP) cells. They are affected by the temperature increase
differently: HP cells have bigger leakage. The SW model can leverage that
knowledge.

2. It is also possible to change the EM to better reflect the currently
running workload. Usually the EM is derived from some average power values
taken from experiments with benchmark (e.g. Dhrystone). The model derived
from such scenario might not represent properly the workloads usually running
on the device. Therefore, runtime modification of the EM allows to switch to
a different model, when there is a need.

3. The EM can be adjusted after boot, when all the modules are loaded and
more information about the SoC is available e.g. chip binning. This would help
to better reflect the silicon characteristics. Thus, this EM modification
API allows it now. It wasn't possible in the past and the EM had to be
'set in stone'.

Example of such runtime modification after boot can be found in a follow-up
patch set. It adds the OPP API and usage in Exynos5 SoC driver after the
voltage values has been adjusted and power changes [5].

More detailed explanation and background can be found in presentations
during LPC2022 [1][2] or in the documentation patches.

Some test results:
The EM can be updated to fit better the workload type. In the case below the EM
has been updated for the Jankbench test on Pixel6 (running v5.18 w/ mainline backports
for the scheduler bits). The Jankbench was run 10 times for those two configurations,
to get more reliable data.

1. Janky frames percentage
+--------+-----------------+---------------------+-------+-----------+
| metric |    variable     |       kernel        | value | perc_diff |
+--------+-----------------+---------------------+-------+-----------+
| gmean  | jank_percentage | EM_default          |  2.0  |   0.0%    |
| gmean  | jank_percentage | EM_modified_runtime |  1.3  |  -35.33%  |
+--------+-----------------+---------------------+-------+-----------+

2. Avg frame render time duration
+--------+---------------------+---------------------+-------+-----------+
| metric |      variable       |       kernel        | value | perc_diff |
+--------+---------------------+---------------------+-------+-----------+
| gmean  | mean_frame_duration | EM_default          | 10.5  |   0.0%    |
| gmean  | mean_frame_duration | EM_modified_runtime |  9.6  |  -8.52%   |
+--------+---------------------+---------------------+-------+-----------+

3. Max frame render time duration
+--------+--------------------+---------------------+-------+-----------+
| metric |      variable      |       kernel        | value | perc_diff |
+--------+--------------------+---------------------+-------+-----------+
| gmean  | max_frame_duration | EM_default          | 251.6 |   0.0%    |
| gmean  | max_frame_duration | EM_modified_runtime | 115.5 |  -54.09%  |
+--------+--------------------+---------------------+-------+-----------+

4. OS overutilized state percentage (when EAS is not working)
+--------------+---------------------+------+------------+------------+
|    metric    |       wa_path       | time | total_time | percentage |
+--------------+---------------------+------+------------+------------+
| overutilized | EM_default          | 1.65 |   253.38   |    0.65    |
| overutilized | EM_modified_runtime | 1.4  |   277.5    |    0.51    |
+--------------+---------------------+------+------------+------------+

5. All CPUs (Little+Mid+Big) power values in mW
+------------+--------+---------------------+-------+-----------+
|  channel   | metric |       kernel        | value | perc_diff |
+------------+--------+---------------------+-------+-----------+
|    CPU     | gmean  | EM_default          | 142.1 |   0.0%    |
|    CPU     | gmean  | EM_modified_runtime | 131.8 |  -7.27%   |
+------------+--------+---------------------+-------+-----------+

The time cost to update the EM decreased in this v5 vs v4:
big: 5us vs 2us -> 2.6x faster
mid: 9us vs 3us -> 3x faster
little: 16us vs 16us -> no change

We still have to update the inefficiency in the cpufreq framework, thus
a bit of overhead will be there.

These series is based on linux next tree, tag 'next-20240112', since there
are changes and revert which touch em_cpu_energy().

Changelog:
v7:
- dropped em_table_get/put() (Rafael)
- renamed memory function to em_table_alloc/free() (Rafael)
- use explicit rcu_read_lock/unlock() instead of wrappers and aligned
  frameworks & drivers using EM (Rafael)
- adjusted documentation to the new functions
- fixed doxygen comments (Rafael)
- renamed 'refcount' to 'kref' (Rafael)
- changed patch headers according to comments (Rafael)
- rebased on 'next-20240112' to get Ingo's revert affecting energy_model.h
v6 [6]:
- renamed 'runtime_table' to 'em_table' (Dietmar, Rafael)
- dropped kref increment during allocation (Qais)
- renamed em_inc/dec_usage() to em_table_inc/dec() (Qais)
- fixed comment description and left old comment block with small
  adjustment in em_cpu_energy() patch 15/23 (Dietmar)
- added platform name which was used for speed-up testing (Dietmar)
- changed patch header description keep it small not repeating the in-code
  comment describing 'cost' in em_cpu_energy() patch 15/23 (Dietmar)
- added check and warning in em_cpu_energy() about RCU lock held (Qais, Xuewen)
- changed nr_perf_states usage in the patch 7/23 (Dietmar)
- changed documentation according to comments (Dietmar)
- changed in-code comment in patch 11/23 according to comments (Dietmar)
- changed example driver function 'ctx' argument in the documentation (Xuewen)
- changed the example driver in documentation, dropped module_exit and
  added em_free_table() explicit in the update function
- fixed comments in various patch headers (Dietmar)
- fixed Doxygen comment s/@state/@table patch 4/23 (Dietmar)
- added information in the cover letter about:
-- optimization in EAS hot code path
-- follow-up patch set which adds OPP support and modifies EM for Exynos5
- rebased on 'next-20240104' to avoid collision with other code touching
  em_cpu_energy()
v5 changes are here [4]

Regards,
Lukasz Luba

[1] https://lpc.events/event/16/contributions/1341/attachments/955/1873/Dynamic_Energy_Model_to_handle_leakage_power.pdf
[2] https://lpc.events/event/16/contributions/1194/attachments/1114/2139/LPC2022_Energy_model_accuracy.pdf
[3] https://www.youtube.com/watch?v=2C-5uikSbtM&list=PL0fKordpLTjKsBOUcZqnzlHShri4YBL1H
[4] https://lore.kernel.org/lkml/20231129110853.94344-1-lukasz.luba@arm.com/
[5] https://lore.kernel.org/lkml/20231220110339.1065505-1-lukasz.luba@arm.com/
[6] https://lore.kernel.org/lkml/20240104171553.2080674-1-lukasz.luba@arm.com/


Lukasz Luba (23):
  PM: EM: Add missing newline for the message log
  PM: EM: Extend em_cpufreq_update_efficiencies() argument list
  PM: EM: Find first CPU active while updating OPP efficiency
  PM: EM: Refactor em_pd_get_efficient_state() to be more flexible
  PM: EM: Introduce em_compute_costs()
  PM: EM: Check if the get_cost() callback is present in
    em_compute_costs()
  PM: EM: Split the allocation and initialization of the EM table
  PM: EM: Introduce runtime modifiable table
  PM: EM: Use runtime modified EM for CPUs energy estimation in EAS
  PM: EM: Add functions for memory allocations for new EM tables
  PM: EM: Introduce em_dev_update_perf_domain() for EM updates
  PM: EM: Add em_perf_state_from_pd() to get performance states table
  PM: EM: Add performance field to struct em_perf_state and optimize
  PM: EM: Support late CPUs booting and capacity adjustment
  PM: EM: Optimize em_cpu_energy() and remove division
  powercap/dtpm_cpu: Use new Energy Model interface to get table
  powercap/dtpm_devfreq: Use new Energy Model interface to get table
  drivers/thermal/cpufreq_cooling: Use new Energy Model interface
  drivers/thermal/devfreq_cooling: Use new Energy Model interface
  PM: EM: Change debugfs configuration to use runtime EM table data
  PM: EM: Remove old table
  PM: EM: Add em_dev_compute_costs()
  Documentation: EM: Update with runtime modification design

 Documentation/power/energy-model.rst | 183 ++++++++++-
 drivers/powercap/dtpm_cpu.c          |  39 ++-
 drivers/powercap/dtpm_devfreq.c      |  34 +-
 drivers/thermal/cpufreq_cooling.c    |  45 ++-
 drivers/thermal/devfreq_cooling.c    |  49 ++-
 include/linux/energy_model.h         | 165 ++++++----
 kernel/power/energy_model.c          | 472 +++++++++++++++++++++++----
 7 files changed, 819 insertions(+), 168 deletions(-)

-- 
2.25.1


