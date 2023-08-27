Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C158178A374
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 01:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjH0Xc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 19:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjH0XcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 19:32:19 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3417FBC
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 16:32:16 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fef34c33d6so25439705e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 16:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1693179134; x=1693783934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KRYwxDumU1QUQr20FutMYu1vvOKJwyv4NHJKf4lFQRE=;
        b=fooMgSie2o/NcQc2lCWcEjp8kS/x8vpzcdL5op7w1qpPUsx1FqGIWhIf78Dp0jBS5O
         8wgyBxnbZRh40iZoQQB6Lmb0lodJqtBlSrs9caxpzvQ7IVNkVFlteTc7WVes3UwWwzpi
         jpTOyXpwDXikO0pv5FCYEGnMbcIezlv/jlJ3IP0hiMO5anv6PbJtSP1s06bnExZQwa2w
         CBxFRrruSeFZgZPKYmJYjkqyV9sxEHmdl5kddGkinVGH8/xsyhiFKYVVFyfgfbxVTMnI
         Tl+FuiDqbkCrA3h4ZNWfsSnhlj+sm6EWTSROAoILctHQVhWnz5/4hBltw+PqoXEmaxIq
         wVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693179134; x=1693783934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KRYwxDumU1QUQr20FutMYu1vvOKJwyv4NHJKf4lFQRE=;
        b=eDPK2zwQLHrkMf2m6WV2MFZBXsf5L7QZjUncKtzRdJfYlS677jBvu2L5TGQovwZCKt
         AVI5Lg0VAPfGDlYfCK/i6jDY33WrTp2GwTbVHnlOnRyDTNTvpESz3yKgUUstfqbNfOKj
         uUnbAl5dt+uKOHhnDyegY3HbGCapyeYGUZxMN8L7rFbNyIr8086uGjKxw+rRYhWSyVWH
         PV0/C1XsSrGfVtN8YxZocB0jfA7TfUn9OgLpqHx8xGlCr7raOZjZw2SjlLtWEt+UHPDY
         iEgI4XBylfnvlYvfenSs4EKHPueas6D1q9HzpOdvgHYxVjwXA8v9nBhvbh7cWEn+W0/D
         Xj8Q==
X-Gm-Message-State: AOJu0YwVdTbqs/E3H9udWSNnvFJPOhwEzHfstNJnilM8cIk5VoEKm+Iv
        9WU0EgjtGQ2la0OigBecF6x4Og==
X-Google-Smtp-Source: AGHT+IGvcODlaqJPGhRmv2KWxGGl28pU8Edid/cjZkM1Y9+neGvtBrIFUQL2E9o4zVMcnjLyV6ohNQ==
X-Received: by 2002:a7b:c381:0:b0:3fe:d852:7ff9 with SMTP id s1-20020a7bc381000000b003fed8527ff9mr18021942wmj.5.1693179134372;
        Sun, 27 Aug 2023 16:32:14 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c029500b003fe1a96845bsm12220395wmk.2.2023.08.27.16.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 16:32:13 -0700 (PDT)
From:   Qais Yousef <qyousef@layalina.io>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>,
        Qais Yousef <qyousef@layalina.io>
Subject: [RFC PATCH 0/7] sched: cpufreq: Remove magic margins
Date:   Mon, 28 Aug 2023 00:31:56 +0100
Message-Id: <20230827233203.1315953-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the introduction of EAS and schedutil, we had two magic 0.8 and 1.25
margins applied in fits_capacity() and apply_dvfs_headroom().

As reported two years ago in

	https://lore.kernel.org/lkml/1623855954-6970-1-git-send-email-yt.chang@mediatek.com/

these values are not good fit for all systems and people do feel the need to
modify them regularly out of tree.

Equally recent discussion in PELT HALFLIFE thread highlighted the need for
a way to tune system response time to achieve better perf, power and thermal
characteristic for a given system

	https://lore.kernel.org/lkml/20220829055450.1703092-1-dietmar.eggemann@arm.com/

fits_capacity() and apply_dvfs_headroom() are not a suitable tunables. Attempt
to use PELF HALFLIFE highlighted that there's room to do better, which I hope
my proposal helps to achieve that.

This series attempts to address these issues by first removing the magic
'margins' from those two areas that has proved to be problematic in practice;
and, at least in Android world, they're being modified out of tree on regular
basis.

I attempted to tackle the problem by trying to find the answer to the question
what would really go wrong if we don't have these margins or headrooms?

The simplest answers I found is that for fits_capacity() if we do a bad
decision, then the task will become misfit and will have to wait for the next
load balance to move it to the correct CPU. Hence I thought a reasonable
definition is that fits_capacity() should be a function of tick and the
headroom should cater for the fact that if a task continues to run without
sleep, then as long as by the time we hit the tick (load balance) and it still
fits, then it should not be considered a misfit and should be acceptable to run
on this CPU.

For the dvfs headroom, the worst can happen is that util grows above
capacity@OPP before we get a chance to send a request to hardware to modify the
freq. Which means we should make sure the frequency selection provides
enough headroom to cater for the fact that if the task continues to run without
sleep, then the current frequency should provide a capacity@OPP higher than
util after rate_limit_us of cpufeq transition delay.

To achieve this, we need a new function to help us with predicting, or
approximate, the util given a delta of runtime. Which is what introduced in
patches 1 and 2.

Removing these margins doesn't actually fix the problem of being able to tune
the system response. To do that we introduce a new tunable to schedutil called
response_time_ms which dictates how long it takes the policy to go from minimum
to maximum performance point. This value reflects the time it takes PELT to
grow to the capacity of the CPUs in that policy (which can be different in case
of HMP). It should be a direct presentation of PELT ramp-up time, hence more
meaningful from tuning perspective as an absolute value of how long it takes to
saturate the policy.  It should be much easier for userspace to reason about an
appropriate number given this absolute value. It can be expanded or shrunk to
slow or speed up the response time. Ultimately leading to appropriate perf,
power and thermal trade-off for the system.

In case of slowing the response time, there's inherit limitation that util_avg
saturates at 1024. Which means the impact of slowing down after a certain
degree would be to lose the top freqs. I think this limitation can be overcome
but not sure how yet. Suggestions would be appreciated meanwhile.

To further help tune the system, we introduce PELT HALFLIFE multiplier as
a boot time parameter. This parameter has an impact on how fast we migrate, so
should compensate for whoever needed to tune fits_capacity(); and it has great
impact on default response_time_ms. Particularly it gives a natural faster rise
time when the system gets busy, AND fall time when the system goes back to
idle. It is coarse grain response control that can be coupled with finer grain
control via schedutil's response_time_ms.

I believe (hope) by making the behavior of fits_capacity() and
apply_dvfs_headroom() more deterministic, and scalable across systems, to be
a true function of their natural limitations and combined with the new, and
hopefully sensible, tunable to allow managing the reactiveness of the system to
achieve what the user/sysadmin perceives as the best perf, power and thermal
trade-off should address the class of problems at hand hopefully in
deterministic and sensible/user friendly manner.

I'm not a pelt guru, so help in making sure that approximate_util_avg() and
approximate_runtime() are reasonable and correct would be appreciated.

The remainder of the patches should hopefully be straightforward. There are
some pending question that you'll find in various TODOs/XXX that I'd appreciate
feedback on.

Not tested comprehensively. But booted on Pixel 6 running mainline-ish kernel.

I could see the following as default output for response_time_ms:

	# grep . /sys/devices/system/cpu/cpufreq/policy*/schedutil/*
	/sys/devices/system/cpu/cpufreq/policy0/schedutil/rate_limit_us:2000
	/sys/devices/system/cpu/cpufreq/policy0/schedutil/response_time_ms:13
	/sys/devices/system/cpu/cpufreq/policy4/schedutil/rate_limit_us:2000
	/sys/devices/system/cpu/cpufreq/policy4/schedutil/response_time_ms:42
	/sys/devices/system/cpu/cpufreq/policy6/schedutil/rate_limit_us:2000
	/sys/devices/system/cpu/cpufreq/policy6/schedutil/response_time_ms:176

Note how the little core has a very short saturation time given its small
capacity in practice. fits_capacity() being defined as a function of TICK_US
means that 1/3rd of its top performance would be ignored (when EAS is active
- !overutilized) - which is desirable since a lot of workloads suffer in terms
of perf by staying for too long on the littles and given our relatively high
TICK_US values, the earlier move is good.

The biggest policy though has a saturation of 176 which I didn't expect. My
measurement in the past where that we need at least 200ms with 32ms PELF HF.
Maybe I have a bug or my old measurements are now invalid for some reason.

When I set PELT HALFLIFE to 16ms I get:

	# grep . /sys/devices/system/cpu/cpufreq/policy*/schedutil/*
	/sys/devices/system/cpu/cpufreq/policy0/schedutil/rate_limit_us:2000
	/sys/devices/system/cpu/cpufreq/policy0/schedutil/response_time_ms:7
	/sys/devices/system/cpu/cpufreq/policy4/schedutil/rate_limit_us:2000
	/sys/devices/system/cpu/cpufreq/policy4/schedutil/response_time_ms:21
	/sys/devices/system/cpu/cpufreq/policy6/schedutil/rate_limit_us:2000
	/sys/devices/system/cpu/cpufreq/policy6/schedutil/response_time_ms:79

and for 8ms:

	# grep . /sys/devices/system/cpu/cpufreq/policy*/schedutil/*
	/sys/devices/system/cpu/cpufreq/policy0/schedutil/rate_limit_us:2000
	/sys/devices/system/cpu/cpufreq/policy0/schedutil/response_time_ms:4
	/sys/devices/system/cpu/cpufreq/policy4/schedutil/rate_limit_us:2000
	/sys/devices/system/cpu/cpufreq/policy4/schedutil/response_time_ms:10
	/sys/devices/system/cpu/cpufreq/policy6/schedutil/rate_limit_us:2000
	/sys/devices/system/cpu/cpufreq/policy6/schedutil/response_time_ms:34

policy6 (big core) numbers aren't halving properly. Something to investigate.

I ran speedometer tests too and I could see the score changes as I make
response_time_ms faster/slower or modify PELT HF. I could see the freq
residency also shifts according to my changes where top frequencies get higher
residencies as I speed it up, or they are never reached/reduced residency when
I slow it down.

Finally at the end of the series I modify the default cpufreq transition delay
to be 2ms. I found on several on my Arm based systems I end up with this
default value, and 10ms is too high nowadays even for a low end system.
I haven't done a full surveillance to be honest, but 10ms I think is way too
high for the majority of the systems out there - even 2ms can be a bit high
for a large class of systems. Suggestions for other values are welcome!

This series is based on the tip/sched/core with the below series applied

	https://lore.kernel.org/lkml/20230820210640.585311-1-qyousef@layalina.io/

Many thanks

--
Qais Yousef

Qais Yousef (6):
  sched/pelt: Add a new function to approximate the future util_avg
    value
  sched/pelt: Add a new function to approximate runtime to reach given
    util
  sched/fair: Remove magic margin in fits_capacity()
  sched: cpufreq: Remove magic 1.25 headroom from apply_dvfs_headroom()
  sched/schedutil: Add a new tunable to dictate response time
  cpufreq: Change default transition delay to 2ms

Vincent Donnefort (1):
  sched/pelt: Introduce PELT multiplier

 Documentation/admin-guide/pm/cpufreq.rst | 19 ++++-
 drivers/cpufreq/cpufreq.c                |  4 +-
 kernel/sched/core.c                      |  5 +-
 kernel/sched/cpufreq_schedutil.c         | 80 ++++++++++++++++++++-
 kernel/sched/fair.c                      | 21 +++++-
 kernel/sched/pelt.c                      | 89 ++++++++++++++++++++++++
 kernel/sched/pelt.h                      | 42 +++++++++--
 kernel/sched/sched.h                     | 30 +++++---
 8 files changed, 265 insertions(+), 25 deletions(-)

-- 
2.34.1

