Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC77F809718
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 01:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444130AbjLHAYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 19:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHAX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 19:23:57 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1707C6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 16:24:02 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40c039e9719so17529315e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 16:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1701995041; x=1702599841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=duxYzGzhMectY5+QA9WTprEVFNHw7KBYa84Rdxtr+8M=;
        b=v4IJLWux7CDSSeHrJjn+U8hO4OGga5e/g1h641KjEyDpvAs4gbe+/npSaPBZ1IbM5o
         WGwO78VYPYXRxyAnIFmyFH9KjQEwnjCXvDqn1QDl/cfkqoBBTu/zn6gWm8saC8wjgarQ
         hYLhSruBL7OjXmqJTx3ygQrfjDlO3w47feWafVI78e8OkS8s+42HBW64qhOucbAW4tNb
         Oa4NMjHwVX5NWX9HDRs/7TfFUq58JDjbth/5yTuJDOPdYm/XMd7eCXXxdrqXz2P87CYb
         W/YL6rCXDoqo+pNeUz3Rjtaa3p5do1uwCl6dTFunNAXJ9CAP1foTUyoeKPN9RoH0f0+0
         OCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701995041; x=1702599841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=duxYzGzhMectY5+QA9WTprEVFNHw7KBYa84Rdxtr+8M=;
        b=qRfHxHHllaJslAg9vOgOvRxQE9+sC0My6SDdAK0WC5x4a8LAFWmExdvz9qdjILY03p
         fkjDkCy4xALKxni6dFm8f7LZrXvbYNeIBJlDmbRFA1pacs4yn/P4HAGO3ZDfY965hVn1
         tDy3tdHwMy3f+AqO4UM/thGyNUah33hwhGtvjraJ5Fho1c61E64oKfmcWCogCQHo7Ymz
         +0d+8a+E1haOKjmOdtNbAOQ/UmPvKlshOn5pEEV+MRG9EKpAxA3fC9vWte7Gt95sdqqA
         Moc4OQppUd9hmf+O3NvjIAeU6Jl95LI8ZrZmOR9G9nt1GEX2Xe3V12PzwSDpJGANhJxq
         u/8g==
X-Gm-Message-State: AOJu0YxuCLr0aeTw4Bkule4YduaIH7ZAcKD5OxXMjbFnx8l6YES+so5L
        ufLXGggIbKDu/7p7l6e68p3zVw==
X-Google-Smtp-Source: AGHT+IGgHnbFPSoFP8vmgSSWUgsg6EueLDPmKgC9CGTu9MllE4h1XQsl8GyRfKNwPm7JIF8664Bu5w==
X-Received: by 2002:a05:600c:5489:b0:40c:2c26:4d3f with SMTP id iv9-20020a05600c548900b0040c2c264d3fmr800936wmb.57.1701995040393;
        Thu, 07 Dec 2023 16:24:00 -0800 (PST)
Received: from airbuntu.. (host109-153-232-45.range109-153.btcentralplus.com. [109.153.232.45])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b0040c1c269264sm3339653wmq.40.2023.12.07.16.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 16:23:59 -0800 (PST)
From:   Qais Yousef <qyousef@layalina.io>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Rick Yiu <rickyiu@google.com>,
        Chung-Kai Mei <chungkai@google.com>,
        Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v2 0/8] sched: cpufreq: Remove magic hardcoded numbers from  margins
Date:   Fri,  8 Dec 2023 00:23:34 +0000
Message-Id: <20231208002342.367117-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And replace it with more dynamic logic based on hardware/software limitations.

Margins referred to are the ones in:

	* 80% in fits_capacity()
	* 125% in map_util_perf()

The current values seem to have worked well in the past but on modern hardware
they pose the following probelms:

	* fits_capacity() is not big enough for little cores
	* fits_capacity() is too big for mid cores
	* Leaves questions whether the big core can trigger overutilized
	  prematurely on powerful systems where the top 20% is still a lot of
	  perf headroom to be consumed

The 1st causes tasks to get stuck for too long underperforming on little cores.
The 2nd prevents from better utilizing the mid core when the workload at
a steady state above the 80%. Ideally we need to spread to mids and bigs in
this case but we end up pushing to bigs only. The 3rd I didn't get a chance to
quantify its effect in practice yet. But I do think our current definition of
overutilized being tied to misfit has gotten stale too and needs rethinking.

	* 125% map_util_perf() ends up causing power/thermal issue on powerful
	  systems by forcing unnecessary high headroom of idle time.

We could run slower with no perf impact on many cases.

To address these issues we define the limitation of each as follows:

	* fits_capacity() should return true as long as the util will not rise
	  above the capacity of the CPU before the next load balance.

Load balance is the point of correction for misplacing a task. And we can
afford to keep the task running on a CPU when

	task->util_avg < capacity_of(cpu)

as long as the task->util_avg won't become higher shortly after leaving the
task stuck underperforming until a load balancing event comes to save the day.

	* map_util_perf() should provide extra headroom to cater for the fact
	  we have to wait for N us before requesting another update.

So we need to give cpu->util_avg enough headroom to grow comfortably given the
fact there will be N us delay before we can update DVFS again due to hardware
limitation. So for faster DVFS h/w, we need small headroom knowing that we can
request another update shortly after if we don't go back to idle.

To cater for the need to be able to tweak these values, we introduce a new
schedutil knob, response_time_ms, to allow userspace to control how fast they
want DVFS to ramp-up for a given policy. It can also be slowed down if
power/thermal are larger concern.

I opted to remove the 1.25 default speed up as it somehow constituted a policy
that is good for some, but not necessary best for all systems out there. With
the availability of the knob it is better for userspace to learn to tune for
best perf/power/thermal trade-off.

With uclamp being available, this system tuning should not be necessary if
userspace is smart and conveys task perf requirement directly.

At the end I opted to keep the patch to control PELT HALFLIFE at boot time.
I know this wasn't popular before and I don't want to conjure the wrath of the
titans; but speaking with Vincent about per-task util_est_faster he seemed to
think that a boot time control might be better. So the matter seemed debatable
still. Generaly like above, with a smarter userspace that uses uclamp, this
won't be necessary. But the need I see for it is that we have a constant model
for all systems in the scheduler, and this gives an easy way to help under
powered ones to be more reactive. I am happy to drop this and explore other
alternatives (whatever they might be), but felt it is necessary for a complete
story on how to allow tweaking ability to migrate faster on underpowered HMP
systems. Remember, today's high end are tomorrow low end :). For SMP, the
dvfs_response_time is equivalent to a great extent and I don't see this knob
should offer any additional benefit for them. So maybe make it conditional on
HMP.

Testing on Pixel 6 running mainlin(ish) kernel, I see the following in
schedutil as default response times

	# grep . /sys/devices/system/cpu/cpufreq/policy*/schedutil/*
	/sys/devices/system/cpu/cpufreq/policy0/schedutil/rate_limit_us:2000
	/sys/devices/system/cpu/cpufreq/policy0/schedutil/response_time_ms:8
	/sys/devices/system/cpu/cpufreq/policy4/schedutil/rate_limit_us:2000
	/sys/devices/system/cpu/cpufreq/policy4/schedutil/response_time_ms:29
	/sys/devices/system/cpu/cpufreq/policy6/schedutil/rate_limit_us:2000
	/sys/devices/system/cpu/cpufreq/policy6/schedutil/response_time_ms:155

Changing response time to replicate the 1.25 dvfs headroom (multiply by 0.8)

	# grep . /sys/devices/system/cpu/cpufreq/policy*/schedutil/*
	/sys/devices/system/cpu/cpufreq/policy0/schedutil/rate_limit_us:2000
	/sys/devices/system/cpu/cpufreq/policy0/schedutil/response_time_ms:6
	/sys/devices/system/cpu/cpufreq/policy4/schedutil/rate_limit_us:2000
	/sys/devices/system/cpu/cpufreq/policy4/schedutil/response_time_ms:23
	/sys/devices/system/cpu/cpufreq/policy6/schedutil/rate_limit_us:2000
	/sys/devices/system/cpu/cpufreq/policy6/schedutil/response_time_ms:124

When I set PELT HALFLIFE to 16ms I get:

	# grep . /sys/devices/system/cpu/cpufreq/policy*/schedutil/*
	/sys/devices/system/cpu/cpufreq/policy0/schedutil/rate_limit_us:2000
	/sys/devices/system/cpu/cpufreq/policy0/schedutil/response_time_ms:4
	/sys/devices/system/cpu/cpufreq/policy4/schedutil/rate_limit_us:2000
	/sys/devices/system/cpu/cpufreq/policy4/schedutil/response_time_ms:15
	/sys/devices/system/cpu/cpufreq/policy6/schedutil/rate_limit_us:2000
	/sys/devices/system/cpu/cpufreq/policy6/schedutil/response_time_ms:78

Changing response time to replicate the 1.25 dvfs headroom

	# grep . /sys/devices/system/cpu/cpufreq/policy*/schedutil/*
	/sys/devices/system/cpu/cpufreq/policy0/schedutil/rate_limit_us:2000
	/sys/devices/system/cpu/cpufreq/policy0/schedutil/response_time_ms:3
	/sys/devices/system/cpu/cpufreq/policy4/schedutil/rate_limit_us:2000
	/sys/devices/system/cpu/cpufreq/policy4/schedutil/response_time_ms:12
	/sys/devices/system/cpu/cpufreq/policy6/schedutil/rate_limit_us:2000
	/sys/devices/system/cpu/cpufreq/policy6/schedutil/response_time_ms:62

I didn't try 8ms. As you can see from the values for the little, 16ms PELT
HALFLIFE is not suitable with TICK being 4ms. With the new definition of
fits_capacity(), we'd skip the littles and only use them in overutilized state.

Note that I changed the way I calculate the response time. 1024 takes 324
(IIRC). But the new calculations takes into account that max_freq will be
reached as soon as util crosses the util for cap@2nd_highest_freq. Which is
around ~988 (IIRC) for this system. Hence the 155ms at default for biggest
cluster.

===

Running speedometer browser benchmark I get for an average of 10 runs and power
numbers are not super accurate here due to some limitation in test setup

       | baseline |   patch   | 1.25 headroom | 16ms PELT | 16ms + 1.25 headroom
-------+----------+-----------+---------------+-----------+---------------------
score  |  135.14  |  108.03   |     135.72    |   137.48  |    143.96
-------+----------+-----------+---------------+-----------+---------------------
power  | 1455.49  |  1204.75  |    1451.79    |  1690.38  |    1644.69

Removing the hardcoded values from margins loses a lot of perf with large
power save. Re-applying the 1.25 headroom policy regains same perf and power.

Increasing pelt has a high power cost on this system. With 1.25 DVFS headroom
there's a decent boost in perf.

===

For UiBench average of 3 runs (each iteration will already repeat subtests
several times) and power numbers are more accurate though the benchmark does
have sometimes higher than desired variance from run to run

       | baseline |   patch   | 1.25 headroom | 16ms PELT | 16ms + 1.25 headroom
-------+----------+-----------+---------------+-----------+---------------------
jank   |   110.3  |    68.0   |      56.0     |    58.6   |    50.3
-------+----------+-----------+---------------+-----------+---------------------
power  |  147.76  |   146.54  |     164.49    |   174.97  |    209.92

Removing the hardcoded values from the margins produces a great improvement in
score without any power loss. I haven't done *any* detailed analysis, but
I think it's due to fits_capacity() will return false early on littles and
we're less likely to end up with UI tasks getting stuck there waiting for load
balance to save the day and migrate the misfit task.

Re-applying the 1.25 DVFS headroom policy gains more perf at a power cost that
is justifiable compared to 'patch'. It's a massive win against baseline which
has the 1.25 headroom.

16ms PELT HALFLIFE numbers look better compared to patch. But at higher power
cost.

---

Take away: There are perf and power trade-offs associated with these margins
that are hard to abstract completely. Give the power to sysadmins to find their
sweet spot meaningfully and make scheduler behavior constrained by actual h/w
and software limitations.

---

Changes since v1:

	* Rebase on top of tip/sched/core with Vincent rework patch for schedutil
	* Fix bugs in approximate_util_avg()/approximate_runtime() (Dietmar)
	* Remove usage of aligned per cpu variable (Peter)
	* Calculate the response_time_mult once (Peter)
	* Tweaked response_time_ms calculation to cater for max freq will be
	  reached well before we hit 1024.

v1 discussion link: https://lore.kernel.org/lkml/20230827233203.1315953-1-qyousef@layalina.io/

Patch 1 changes the default rate_limit_us when cpufreq_transition is not
provided. The default 10ms is too high for modern hardware. the patch can be
picked up readily.

Patch 2 renames map_util_perf() into apply_dvfs_headroom() which I believe
better reflect the actual functionality it performs. And it gives it a doc and
moves back to sched.h. Patch can be picked up readily too.

Patches 3 and 4 add helper functions to help convert between util_avg and time.

Patches 5 and 6 uses these new function to implement the logic to make
fits_capacity() and apply_dvfs_headroom() better approximate the limitation of
the system based on TICK and rate_limit_us as explained earlier.

Patch 7 adds the new response_time_ms to schedutil. The slow down functionality
has a limitation that is documented.

Patch 8 adds ability to modify PELT HALFLIFE via boot time parameter. Happy to
drop this one if it is still hated and the need to cater for low end under
powered systems didn't make sense.

Thanks!

--
Qais Yousef

Qais Yousef (7):
  cpufreq: Change default transition delay to 2ms
  sched: cpufreq: Rename map_util_perf to apply_dvfs_headroom
  sched/pelt: Add a new function to approximate the future util_avg
    value
  sched/pelt: Add a new function to approximate runtime to reach given
    util
  sched/fair: Remove magic hardcoded margin in fits_capacity()
  sched: cpufreq: Remove magic 1.25 headroom from apply_dvfs_headroom()
  sched/schedutil: Add a new tunable to dictate response time

Vincent Donnefort (1):
  sched/pelt: Introduce PELT multiplier

 Documentation/admin-guide/pm/cpufreq.rst |  17 ++-
 drivers/cpufreq/cpufreq.c                |   8 +-
 include/linux/cpufreq.h                  |   3 +
 include/linux/sched/cpufreq.h            |   5 -
 kernel/sched/core.c                      |   3 +-
 kernel/sched/cpufreq_schedutil.c         | 128 +++++++++++++++++++++--
 kernel/sched/fair.c                      |  21 +++-
 kernel/sched/pelt.c                      |  89 ++++++++++++++++
 kernel/sched/pelt.h                      |  42 +++++++-
 kernel/sched/sched.h                     |  31 ++++++
 10 files changed, 323 insertions(+), 24 deletions(-)

-- 
2.34.1

