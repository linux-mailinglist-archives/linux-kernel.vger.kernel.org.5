Return-Path: <linux-kernel+bounces-101422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C04587A6EA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08C7F286DA5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0F94502B;
	Wed, 13 Mar 2024 11:11:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC6645021;
	Wed, 13 Mar 2024 11:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710328309; cv=none; b=eZ0yP06FXiUGYH6tWGL84WnV5UsGKQKcSvGGw1CB8o2YMXNuJkAY3ze6cjRjOmUEpGU39QT+dJ41ttn1e8BRJtlt88Uu1pYtx0fzrybEHEXJCtfZXgFqxeWfxSNB5bnJLzHBYDPwdnlTQBlueLmRV8Pag6TCRXQD27oxkcc9j4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710328309; c=relaxed/simple;
	bh=LEyXAn/v2Hw3prnwl+wVgn/JXUC8HGQ1YBXsFPPZx6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bTExvI1qeP8VaF0JRGHz++H2/b2pn3xFppjDVD+P1QKY+Uv5Fi3lmBShUuxeOXKze0EOcqS4IaY9FJ6MmjnOgAivfe6GZd9dF8CcNP4+HtEj8XeDm5pZeNapwuDxbDOzw03vIFxG3/lkDzU9Q5YPT8y0bVArQKBZdQ9qvj9BruY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6B071007;
	Wed, 13 Mar 2024 04:12:23 -0700 (PDT)
Received: from [192.168.1.100] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE4913F73F;
	Wed, 13 Mar 2024 04:11:43 -0700 (PDT)
Message-ID: <2ce4838e-7b5e-45ff-a78a-6363c57de5d9@arm.com>
Date: Wed, 13 Mar 2024 11:11:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 05/10] drivers/perf: Use PERF_PMU_CAP_NO_SAMPLING
 consistently
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
 <5622df31e5f4874c2c085d1ce930f5bbad889181.1710257512.git.robin.murphy@arm.com>
From: James Clark <james.clark@arm.com>
In-Reply-To: <5622df31e5f4874c2c085d1ce930f5bbad889181.1710257512.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/03/2024 17:34, Robin Murphy wrote:
> Our system PMUs fundamentally cannot support the current notion of
> sampling events, so now that the core capability has been clarified,
> apply it consistently and purge yet more boilerplate.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/perf/alibaba_uncore_drw_pmu.c     |  6 +-----
>  drivers/perf/amlogic/meson_ddr_pmu_core.c |  3 ++-
>  drivers/perf/arm-cci.c                    |  3 ++-
>  drivers/perf/arm-ccn.c                    | 12 +-----------
>  drivers/perf/arm-cmn.c                    |  3 ++-
>  drivers/perf/arm_cspmu/arm_cspmu.c        | 17 ++++-------------
>  drivers/perf/arm_dmc620_pmu.c             |  4 ++--
>  drivers/perf/arm_dsu_pmu.c                | 12 +-----------
>  drivers/perf/arm_smmuv3_pmu.c             |  6 +-----
>  drivers/perf/cxl_pmu.c                    |  3 ++-
>  drivers/perf/dwc_pcie_pmu.c               |  5 +----
>  drivers/perf/fsl_imx8_ddr_perf.c          |  3 ++-
>  drivers/perf/fsl_imx9_ddr_perf.c          |  3 ++-
>  drivers/perf/hisilicon/hisi_pcie_pmu.c    |  4 ++--
>  drivers/perf/hisilicon/hisi_uncore_pmu.c  |  3 ++-
>  drivers/perf/hisilicon/hns3_pmu.c         |  4 ++--
>  drivers/perf/marvell_cn10k_ddr_pmu.c      |  6 +-----
>  drivers/perf/qcom_l2_pmu.c                |  7 +------
>  drivers/perf/qcom_l3_pmu.c                |  7 +------
>  drivers/perf/thunderx2_pmu.c              |  4 ++--
>  drivers/perf/xgene_pmu.c                  |  4 ++--
>  21 files changed, 36 insertions(+), 83 deletions(-)
> 
[...]
>  
> diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
> index ce26bb773a56..4114349e62dd 100644
> --- a/drivers/perf/arm-ccn.c
> +++ b/drivers/perf/arm-ccn.c
> @@ -713,7 +713,6 @@ static void arm_ccn_pmu_event_release(struct perf_event *event)
>  static int arm_ccn_pmu_event_init(struct perf_event *event)
>  {
>  	struct arm_ccn *ccn;
> -	struct hw_perf_event *hw = &event->hw;
>  	u32 node_xp, type, event_id;
>  	int valid;
>  	int i;
> @@ -721,16 +720,6 @@ static int arm_ccn_pmu_event_init(struct perf_event *event)
>  
>  	ccn = pmu_to_arm_ccn(event->pmu);
>  
> -	if (hw->sample_period) {
> -		dev_dbg(ccn->dev, "Sampling not supported!\n");
> -		return -EOPNOTSUPP;
> -	}
> -
> -	if (has_branch_stack(event)) {
> -		dev_dbg(ccn->dev, "Can't exclude execution levels!\n");
> -		return -EINVAL;
> -	}
> -

[...]

> diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
> index f5ea5acaf2f3..3424d165795c 100644
> --- a/drivers/perf/arm_dsu_pmu.c
> +++ b/drivers/perf/arm_dsu_pmu.c
> @@ -544,23 +544,12 @@ static int dsu_pmu_event_init(struct perf_event *event)
>  {
>  	struct dsu_pmu *dsu_pmu = to_dsu_pmu(event->pmu);
>  
> -	/* We don't support sampling */
> -	if (is_sampling_event(event)) {
> -		dev_dbg(dsu_pmu->pmu.dev, "Can't support sampling events\n");
> -		return -EOPNOTSUPP;
> -	}
> -
>  	/* We cannot support task bound events */
>  	if (event->cpu < 0 || event->attach_state & PERF_ATTACH_TASK) {
>  		dev_dbg(dsu_pmu->pmu.dev, "Can't support per-task counters\n");
>  		return -EINVAL;
>  	}
>  
> -	if (has_branch_stack(event)) {
> -		dev_dbg(dsu_pmu->pmu.dev, "Can't support filtering\n");
> -		return -EINVAL;
> -	}
> -

I'm assuming that this and the other has_branch_stack() check were
removed because branch stacks don't actually do anything unless sampling
is enabled?

It's a small difference that there is now no error message if you ask
for branch stacks, but it wouldn't have done anything anyway? I suppose
this error message was also not applied very consistently across the
different devices.

James


