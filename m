Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EAB7FD4ED
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjK2LH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjK2LH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:07:56 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FF0095;
        Wed, 29 Nov 2023 03:08:02 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F231A2F4;
        Wed, 29 Nov 2023 03:08:48 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.4.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6171A3F5A1;
        Wed, 29 Nov 2023 03:07:59 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
Subject: [PATCH v5 00/23] Introduce runtime modifiable Energy Model
Date:   Wed, 29 Nov 2023 11:08:30 +0000
Message-Id: <20231129110853.94344-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch set adds a new feature which allows to modify Energy Model (EM)
power values at runtime. It will allow to better reflect power model of
a recent SoCs and silicon. Different characteristics of the power usage
can be leveraged and thus better decisions made during task placement in EAS.

It's part of feature set know as Dynamic Energy Model. It has been presented
and discussed recently at OSPM2023 [3]. This patch set implements the 1st
improvement for the EM.

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

More detailed explanation and background can be found in presentations
during LPC2022 [1][2] or in the documentation patches.

Some test results.
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

Changelog:
v5:
- removed 2 tables design
- have only one table (runtime_table) used also in thermal (Wei, Rafael)
- refactored update function and removed callback call for each opp
- added faster EM table swap, using only the RCU pointer update
- added memory allocation API and tracking with kref
- avoid overhead for computing 'cost' for each OPP in update, it can be
  pre-computed in device drivers EM earlier
- add support for device drivers providing EM table
- added API for computing 'cost' values in EM for EAS
- added API for thermal/powercap to use EM (using RCU wrappers) 
- switched to single allocation and 'state[]' array (Rafael)
- changed documentation to align with current design
- added helper API for computing cost values
- simplified EM free in unregister path (thanks to kref)
- split patch updating EM clients and changed them separetly
- added seperate patch removing old static EM table
- added EM debugfs change patch to dump the runtime_table
- addressed comments in v4 for spelling/comments/headers
- added review tags
v4 changes are here [4]

Regards,
Lukasz Luba

[1] https://lpc.events/event/16/contributions/1341/attachments/955/1873/Dynamic_Energy_Model_to_handle_leakage_power.pdf
[2] https://lpc.events/event/16/contributions/1194/attachments/1114/2139/LPC2022_Energy_model_accuracy.pdf
[3] https://www.youtube.com/watch?v=2C-5uikSbtM&list=PL0fKordpLTjKsBOUcZqnzlHShri4YBL1H
[4] https://lore.kernel.org/lkml/20230925081139.1305766-1-lukasz.luba@arm.com/


Lukasz Luba (23):
  PM: EM: Add missing newline for the message log
  PM: EM: Refactor em_cpufreq_update_efficiencies() arguments
  PM: EM: Find first CPU active while updating OPP efficiency
  PM: EM: Refactor em_pd_get_efficient_state() to be more flexible
  PM: EM: Refactor a new function em_compute_costs()
  PM: EM: Check if the get_cost() callback is present in
    em_compute_costs()
  PM: EM: Refactor how the EM table is allocated and populated
  PM: EM: Introduce runtime modifiable table
  PM: EM: Use runtime modified EM for CPUs energy estimation in EAS
  PM: EM: Add API for memory allocations for new tables
  PM: EM: Add API for updating the runtime modifiable EM
  PM: EM: Add helpers to read under RCU lock the EM table
  PM: EM: Add performance field to struct em_perf_state
  PM: EM: Support late CPUs booting and capacity adjustment
  PM: EM: Optimize em_cpu_energy() and remove division
  powercap/dtpm_cpu: Use new Energy Model interface to get table
  powercap/dtpm_devfreq: Use new Energy Model interface to get table
  drivers/thermal/cpufreq_cooling: Use new Energy Model interface
  drivers/thermal/devfreq_cooling: Use new Energy Model interface
  PM: EM: Change debugfs configuration to use runtime EM table data
  PM: EM: Remove old table
  PM: EM: Add em_dev_compute_costs() as API for device drivers
  Documentation: EM: Update with runtime modification design

 Documentation/power/energy-model.rst | 206 +++++++++++-
 drivers/powercap/dtpm_cpu.c          |  35 +-
 drivers/powercap/dtpm_devfreq.c      |  31 +-
 drivers/thermal/cpufreq_cooling.c    |  40 ++-
 drivers/thermal/devfreq_cooling.c    |  43 ++-
 include/linux/energy_model.h         | 163 +++++----
 kernel/power/energy_model.c          | 479 +++++++++++++++++++++++----
 7 files changed, 813 insertions(+), 184 deletions(-)

-- 
2.25.1

