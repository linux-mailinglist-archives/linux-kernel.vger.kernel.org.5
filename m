Return-Path: <linux-kernel+bounces-101435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F72587A70F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2013C1F227DC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9193F8EA;
	Wed, 13 Mar 2024 11:26:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B0C3DBBA;
	Wed, 13 Mar 2024 11:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710329175; cv=none; b=rcBVXmjRVJF1IcbHNrOqTJwDo0QgiIVdJ3gFrAkFmz4OS79HwhxDfwQT3z5UW0n7lk+UQJ2GXotgd5jyaPmSmCPfJlwgXkMNsLb4KBDrqa+2CBXGp3v4UHN8cX1ld0nsftKJlVldzZMfP3TVhNqrltjlkioHc+sgMq9zNZZfEcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710329175; c=relaxed/simple;
	bh=y3OqGf9cZrU1G2FvP2a7Qj2ptdbA5j3NjnjuWrWjlwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kpxVKQsSfa2x4F9wLhPS1Taakz3yhFMPvDP6yFl3sETrcEKvalN2xc/xr747NY9WoujWrQqlEej+UxTPytG9GIXP+WbZpOklTjgrDIwMYAZ0ubj4lv59Q/Z9685Ff817fDYwX2bKUKt5AzBZQbNDOU4gwYbxYjyXjHNkZpFO+1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A67731007;
	Wed, 13 Mar 2024 04:26:49 -0700 (PDT)
Received: from [192.168.1.100] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B59A3F73F;
	Wed, 13 Mar 2024 04:26:09 -0700 (PDT)
Message-ID: <b24137db-62e8-2b60-7a8d-2a7f8ac7ba93@arm.com>
Date: Wed, 13 Mar 2024 11:26:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 00/10] perf: Clean up common uncore boilerplate
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linux-perf-users@vger.kernel.org, jialong.yang@shingroup.cn,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Will Deacon <will@kernel.org>
References: <cover.1710257512.git.robin.murphy@arm.com>
From: James Clark <james.clark@arm.com>
In-Reply-To: <cover.1710257512.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/03/2024 17:34, Robin Murphy wrote:
> Hi all,
> 
> Since this came up yet again recently, and it's an idea which has been
> nagging me for years, I decided it was time to see how hard it really
> would be to start shaving this yak. And it turns out to be refreshingly
> simple - the core code has quietly become capable of doing most of what
> we want, the one new functional addition is trivial (patch #2), and the
> resulting largely-mechanical cleanup seems a pretty nice win.
> 
> This series is focused on drivers/perf/ as that's where most mess is
> concentrated, but figured I'd include the arch/ patches as well since
> they might be reasonable to land with the core changes, at least for x86
> (FWIW I did also look at the powerpc drivers but they scared me and I
> ran away; sorry). The remaining stragglers elsewhere around the tree I'd
> come back to as a follow-up.
> 
> (And yes, I appreciate it's mid-merge-window already, but since I do
> have a tree-wide rename proposed here, may as well give the discussion
> a chance for a head start before -rc1...)
> 
> Thanks,
> Robin.
> 
> 
Reviewed-by: James Clark <james.clark@arm.com>

> Robin Murphy (10):
>   perf/alibaba_uncore_drw: Use correct CPU affinity
>   perf: Add capability for common event support
>   drivers/perf: Use PERF_PMU_CAP_NO_COMMON_EVENTS
>   perf: Rename PERF_PMU_CAP_NO_INTERRUPT
>   drivers/perf: Use PERF_PMU_CAP_NO_SAMPLING consistently
>   drivers/perf: Clean up redundant per-task checks
>   perf: Define common uncore capabilities
>   drivers/perf: Use common uncore capabilities
>   x86: Use common uncore PMU capabilities
>   ARM: Use common uncore PMU capabilities
> 
>  arch/arc/kernel/perf_event.c              |  2 +-
>  arch/arm/mach-imx/mmdc.c                  | 16 +-------------
>  arch/arm/mm/cache-l2x0-pmu.c              | 12 +---------
>  arch/csky/kernel/perf_event.c             |  2 +-
>  arch/powerpc/perf/8xx-pmu.c               |  2 +-
>  arch/powerpc/perf/hv-24x7.c               |  2 +-
>  arch/powerpc/perf/hv-gpci.c               |  2 +-
>  arch/powerpc/platforms/pseries/papr_scm.c |  2 +-
>  arch/s390/kernel/perf_cpum_cf.c           |  2 +-
>  arch/sh/kernel/perf_event.c               |  2 +-
>  arch/x86/events/amd/iommu.c               | 17 +-------------
>  arch/x86/events/amd/power.c               | 10 +--------
>  arch/x86/events/amd/uncore.c              | 12 +++-------
>  arch/x86/events/core.c                    |  2 +-
>  arch/x86/events/intel/cstate.c            | 16 +++-----------
>  arch/x86/events/intel/uncore.c            | 11 +--------
>  arch/x86/events/intel/uncore_snb.c        | 20 +++--------------
>  arch/x86/events/msr.c                     |  9 +-------
>  arch/x86/events/rapl.c                    |  9 +-------
>  drivers/fpga/dfl-fme-perf.c               |  2 +-
>  drivers/perf/alibaba_uncore_drw_pmu.c     | 27 +++--------------------
>  drivers/perf/amlogic/meson_ddr_pmu_core.c | 11 +--------
>  drivers/perf/arm-cci.c                    | 15 +------------
>  drivers/perf/arm-ccn.c                    | 20 +----------------
>  drivers/perf/arm-cmn.c                    | 10 +--------
>  drivers/perf/arm_cspmu/arm_cspmu.c        | 27 ++---------------------
>  drivers/perf/arm_dmc620_pmu.c             | 18 +--------------
>  drivers/perf/arm_dsu_pmu.c                | 22 +-----------------
>  drivers/perf/arm_pmu_platform.c           |  2 +-
>  drivers/perf/arm_smmuv3_pmu.c             | 15 +------------
>  drivers/perf/arm_spe_pmu.c                |  7 ++----
>  drivers/perf/cxl_pmu.c                    |  8 +------
>  drivers/perf/dwc_pcie_pmu.c               | 13 +----------
>  drivers/perf/fsl_imx8_ddr_perf.c          | 13 +----------
>  drivers/perf/fsl_imx9_ddr_perf.c          | 13 +----------
>  drivers/perf/hisilicon/hisi_pcie_pmu.c    | 10 +--------
>  drivers/perf/hisilicon/hisi_uncore_pmu.c  | 20 +----------------
>  drivers/perf/hisilicon/hns3_pmu.c         |  9 +-------
>  drivers/perf/marvell_cn10k_ddr_pmu.c      | 15 +------------
>  drivers/perf/marvell_cn10k_tad_pmu.c      |  6 +----
>  drivers/perf/qcom_l2_pmu.c                | 21 ++----------------
>  drivers/perf/qcom_l3_pmu.c                | 21 +-----------------
>  drivers/perf/riscv_pmu_sbi.c              |  2 +-
>  drivers/perf/thunderx2_pmu.c              | 17 +-------------
>  drivers/perf/xgene_pmu.c                  | 16 +-------------
>  include/linux/perf_event.h                |  6 ++++-
>  kernel/events/core.c                      |  7 +++++-
>  47 files changed, 67 insertions(+), 456 deletions(-)
> 

