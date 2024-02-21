Return-Path: <linux-kernel+bounces-74798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB14E85DA7D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F2D6B25BF0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AB97EF1E;
	Wed, 21 Feb 2024 13:28:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73C6762C1;
	Wed, 21 Feb 2024 13:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708522121; cv=none; b=ChVxc5FeQ9+JBq+vkiFwuKvrUoOP0s1cmiJcqyKNCpKQXOnebi/VWh9GkP4vgbdS9/IlPSbGMYz3zH+O4oQ3ge92Ja5OchtcxqvEaevaOhf7KfHPQPOBSsLpqT4ZKlT6sTgqXq3tbCJUH9JskbWxUPJGbIzb0ehrYaQFobILGWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708522121; c=relaxed/simple;
	bh=jcM7Y8plT+9yKZcGSc7nmPeNy9idDPzXx63Ses56ZJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Lw9eWAaP8elQO9gCGBmpqE4E6QhHoCF9Q7LsllObyimR0lXMtInELo3jsRN4oi4J1rMBEbgE4FZi9d8MectE0CTfCaA4/Jtcs7ujglBB7Obf1BGmDQdqsMe942/ilosSrIl14Z0bv6EM+V60NcXxrVDEeuWqvx76joDF1/OZ2hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AA85FEC;
	Wed, 21 Feb 2024 05:29:16 -0800 (PST)
Received: from [10.57.11.178] (unknown [10.57.11.178])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95FE63F762;
	Wed, 21 Feb 2024 05:28:32 -0800 (PST)
Message-ID: <4e9603e9-4127-43f1-92be-6c2b59ff2fe0@arm.com>
Date: Wed, 21 Feb 2024 13:28:48 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] Rework system pressure interface to the scheduler
Content-Language: en-US
To: Vincent Guittot <vincent.guittot@linaro.org>
References: <20240220145947.1107937-1-vincent.guittot@linaro.org>
Cc: konrad.dybcio@linaro.org, mhiramat@kernel.org, agross@kernel.org,
 rafael@kernel.org, sudeep.holla@arm.com, will@kernel.org,
 linux@armlinux.org.uk, bristot@redhat.com, mgorman@suse.de,
 bsegall@google.com, rostedt@goodmis.org, andersson@kernel.org,
 dietmar.eggemann@arm.com, juri.lelli@redhat.com, mingo@redhat.com,
 linux-pm@vger.kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 corbet@lwn.net, amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
 peterz@infradead.org, linux-arm-msm@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 gregkh@linuxfoundation.org, vschneid@redhat.com, rui.zhang@intel.com,
 viresh.kumar@linaro.org
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20240220145947.1107937-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vincent,

On 2/20/24 14:59, Vincent Guittot wrote:
> Following the consolidation and cleanup of CPU capacity in [1], this serie
> reworks how the scheduler gets the pressures on CPUs. We need to take into
> account all pressures applied by cpufreq on the compute capacity of a CPU
> for dozens of ms or more and not only cpufreq cooling device or HW
> mitigiations. We split the pressure applied on CPU's capacity in 2 parts:
> - one from cpufreq and freq_qos
> - one from HW high freq mitigiation.
> 
> The next step will be to add a dedicated interface for long standing
> capping of the CPU capacity (i.e. for seconds or more) like the
> scaling_max_freq of cpufreq sysfs. The latter is already taken into
> account by this serie but as a temporary pressure which is not always the
> best choice when we know that it will happen for seconds or more.
> 
> [1] https://lore.kernel.org/lkml/20231211104855.558096-1-vincent.guittot@linaro.org/
> 
> Change since v4:
> - Add READ_ONCE() in cpufreq_get_pressure()
> - Add ack and reviewed tags
> 
> Change since v3:
> - Fix uninitialized variables in cpufreq_update_pressure()
> 
> Change since v2:
> - Rework cpufreq_update_pressure()
> 
> Change since v1:
> - Use struct cpufreq_policy as parameter of cpufreq_update_pressure()
> - Fix typos and comments
> - Make sched_thermal_decay_shift boot param as deprecated
> 
> Vincent Guittot (5):
>    cpufreq: Add a cpufreq pressure feedback for the scheduler
>    sched: Take cpufreq feedback into account
>    thermal/cpufreq: Remove arch_update_thermal_pressure()
>    sched: Rename arch_update_thermal_pressure into
>      arch_update_hw_pressure
>    sched/pelt: Remove shift of thermal clock
> 
>   .../admin-guide/kernel-parameters.txt         |  1 +
>   arch/arm/include/asm/topology.h               |  6 +-
>   arch/arm64/include/asm/topology.h             |  6 +-
>   drivers/base/arch_topology.c                  | 26 ++++----
>   drivers/cpufreq/cpufreq.c                     | 36 +++++++++++
>   drivers/cpufreq/qcom-cpufreq-hw.c             |  4 +-
>   drivers/thermal/cpufreq_cooling.c             |  3 -
>   include/linux/arch_topology.h                 |  8 +--
>   include/linux/cpufreq.h                       | 10 +++
>   include/linux/sched/topology.h                |  8 +--
>   .../{thermal_pressure.h => hw_pressure.h}     | 14 ++---
>   include/trace/events/sched.h                  |  2 +-
>   init/Kconfig                                  | 12 ++--
>   kernel/sched/core.c                           |  8 +--
>   kernel/sched/fair.c                           | 63 +++++++++----------
>   kernel/sched/pelt.c                           | 18 +++---
>   kernel/sched/pelt.h                           | 16 ++---
>   kernel/sched/sched.h                          | 22 +------
>   18 files changed, 144 insertions(+), 119 deletions(-)
>   rename include/trace/events/{thermal_pressure.h => hw_pressure.h} (55%)
> 


The code looks good and works as expected. The time delays in those
old mechanisms that were important to me are good now. The boost is
handled, cpufreq capping from sysfs - all good. Also the last patch
which removes the shift and makes it obsolete. Thanks!

Feel free to add to all patches:

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz

