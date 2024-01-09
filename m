Return-Path: <linux-kernel+bounces-20782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E7F828527
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14C3BB24733
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A7837163;
	Tue,  9 Jan 2024 11:34:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135EE29CE3;
	Tue,  9 Jan 2024 11:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1A3BC15;
	Tue,  9 Jan 2024 03:34:50 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A59B3F73F;
	Tue,  9 Jan 2024 03:34:00 -0800 (PST)
Message-ID: <d37e3d06-d9fc-4fc3-ad92-e7031489660a@arm.com>
Date: Tue, 9 Jan 2024 12:33:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Rework system pressure interface to the scheduler
Content-Language: en-US
To: Vincent Guittot <vincent.guittot@linaro.org>, linux@armlinux.org.uk,
 catalin.marinas@arm.com, will@kernel.org, sudeep.holla@arm.com,
 rafael@kernel.org, viresh.kumar@linaro.org, agross@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
 vschneid@redhat.com, lukasz.luba@arm.com, rui.zhang@intel.com,
 mhiramat@kernel.org, daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
 corbet@lwn.net, gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: qyousef@layalina.io
References: <20240108134843.429769-1-vincent.guittot@linaro.org>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20240108134843.429769-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/01/2024 14:48, Vincent Guittot wrote:
> Following the consolidation and cleanup of CPU capacity in [1], this serie
> reworks how the scheduler gets the pressures on CPUs. We need to take into
> account all pressures applied by cpufreq on the compute capacity of a CPU
> for dozens of ms or more and not only cpufreq cooling device or HW
> mitigiations. we split the pressure applied on CPU's capacity in 2 parts:
> - one from cpufreq and freq_qos
> - one from HW high freq mitigiation.
> 
> The next step will be to add a dedicated interface for long standing
> capping of the CPU capacity (i.e. for seconds or more) like the
> scaling_max_freq of cpufreq sysfs. The latter is already taken into
> account by this serie but as a temporary pressure which is not always the
> best choice when we know that it will happen for seconds or more.

I guess this is related to the 'user space system pressure' (*) slide of
your OSPM '23 talk.

Where do you draw the line when it comes to time between (*) and the
'medium pace system pressure' (e.g. thermal and FREQ_QOS).

IIRC, with (*) you want to rebuild the sched domains etc.

> 
> [1] https://lore.kernel.org/lkml/20231211104855.558096-1-vincent.guittot@linaro.org/
> 
> Change since v1:
> - Rework cpufreq_update_pressure()
> 
> Change since v1:
> - Use struct cpufreq_policy as parameter of cpufreq_update_pressure()
> - Fix typos and comments
> - Make sched_thermal_decay_shift boot param as deprecated
> 
> Vincent Guittot (5):
>   cpufreq: Add a cpufreq pressure feedback for the scheduler
>   sched: Take cpufreq feedback into account
>   thermal/cpufreq: Remove arch_update_thermal_pressure()
>   sched: Rename arch_update_thermal_pressure into
>     arch_update_hw_pressure
>   sched/pelt: Remove shift of thermal clock
> 
>  .../admin-guide/kernel-parameters.txt         |  1 +
>  arch/arm/include/asm/topology.h               |  6 +-
>  arch/arm64/include/asm/topology.h             |  6 +-
>  drivers/base/arch_topology.c                  | 26 ++++----
>  drivers/cpufreq/cpufreq.c                     | 36 +++++++++++
>  drivers/cpufreq/qcom-cpufreq-hw.c             |  4 +-
>  drivers/thermal/cpufreq_cooling.c             |  3 -
>  include/linux/arch_topology.h                 |  8 +--
>  include/linux/cpufreq.h                       | 10 +++
>  include/linux/sched/topology.h                |  8 +--
>  .../{thermal_pressure.h => hw_pressure.h}     | 14 ++---
>  include/trace/events/sched.h                  |  2 +-
>  init/Kconfig                                  | 12 ++--
>  kernel/sched/core.c                           |  8 +--
>  kernel/sched/fair.c                           | 63 +++++++++----------
>  kernel/sched/pelt.c                           | 18 +++---
>  kernel/sched/pelt.h                           | 16 ++---
>  kernel/sched/sched.h                          | 22 +------
>  18 files changed, 144 insertions(+), 119 deletions(-)
>  rename include/trace/events/{thermal_pressure.h => hw_pressure.h} (55%)


