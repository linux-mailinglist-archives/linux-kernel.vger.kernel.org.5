Return-Path: <linux-kernel+bounces-101455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDF787A75F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 091DDB23897
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A228E3FB1E;
	Wed, 13 Mar 2024 12:03:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2F4405FB;
	Wed, 13 Mar 2024 12:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710331381; cv=none; b=MwordXPZY/pcYmrRuD7Ay4DhCywDMXjhZsLZIOCXSpTQ8M3AuGDummHBh95vOc8fZQrkG17lzr2Wq9TojHtoWXYtqoZxwx+vX/wS4+ALJzMpqGMaLHqRYaAy2ZJo5aSAjXBUiZRfiTw5KT7p41wuobOkK4M8aOBO1xMlhr/p/lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710331381; c=relaxed/simple;
	bh=ejg+XL+wXUEIUGaX+YNuKkT2bE9I+6ueqE+pHgEI/4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S8XcZXTc/nY2k4e7UI7kNgoCU7Iq8sUd9Fz7v1RkcJ4K5ArV9rsnLlj/mr81ZXbyK4w5BUsTr5KLtKj0nZLlMiJl0h0HKAizxmtULfH8DO9qE9G90p0W1gKTxRJQBtqcSXHj5H/0Xri9dLZGMlsAPz0cSsl2Ciw8lL4ViBn/cyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79E5F1007;
	Wed, 13 Mar 2024 05:03:35 -0700 (PDT)
Received: from [10.57.52.245] (unknown [10.57.52.245])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0472D3F762;
	Wed, 13 Mar 2024 05:02:52 -0700 (PDT)
Message-ID: <44587738-ad0f-4c7e-b1ca-230a62605724@arm.com>
Date: Wed, 13 Mar 2024 12:02:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] drivers/perf: Use PERF_PMU_CAP_NO_SAMPLING
 consistently
Content-Language: en-GB
To: James Clark <james.clark@arm.com>
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
 <2ce4838e-7b5e-45ff-a78a-6363c57de5d9@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <2ce4838e-7b5e-45ff-a78a-6363c57de5d9@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-13 11:11 am, James Clark wrote:
> 
> 
> On 12/03/2024 17:34, Robin Murphy wrote:
>> Our system PMUs fundamentally cannot support the current notion of
>> sampling events, so now that the core capability has been clarified,
>> apply it consistently and purge yet more boilerplate.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/perf/alibaba_uncore_drw_pmu.c     |  6 +-----
>>   drivers/perf/amlogic/meson_ddr_pmu_core.c |  3 ++-
>>   drivers/perf/arm-cci.c                    |  3 ++-
>>   drivers/perf/arm-ccn.c                    | 12 +-----------
>>   drivers/perf/arm-cmn.c                    |  3 ++-
>>   drivers/perf/arm_cspmu/arm_cspmu.c        | 17 ++++-------------
>>   drivers/perf/arm_dmc620_pmu.c             |  4 ++--
>>   drivers/perf/arm_dsu_pmu.c                | 12 +-----------
>>   drivers/perf/arm_smmuv3_pmu.c             |  6 +-----
>>   drivers/perf/cxl_pmu.c                    |  3 ++-
>>   drivers/perf/dwc_pcie_pmu.c               |  5 +----
>>   drivers/perf/fsl_imx8_ddr_perf.c          |  3 ++-
>>   drivers/perf/fsl_imx9_ddr_perf.c          |  3 ++-
>>   drivers/perf/hisilicon/hisi_pcie_pmu.c    |  4 ++--
>>   drivers/perf/hisilicon/hisi_uncore_pmu.c  |  3 ++-
>>   drivers/perf/hisilicon/hns3_pmu.c         |  4 ++--
>>   drivers/perf/marvell_cn10k_ddr_pmu.c      |  6 +-----
>>   drivers/perf/qcom_l2_pmu.c                |  7 +------
>>   drivers/perf/qcom_l3_pmu.c                |  7 +------
>>   drivers/perf/thunderx2_pmu.c              |  4 ++--
>>   drivers/perf/xgene_pmu.c                  |  4 ++--
>>   21 files changed, 36 insertions(+), 83 deletions(-)
>>
> [...]
>>   
>> diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
>> index ce26bb773a56..4114349e62dd 100644
>> --- a/drivers/perf/arm-ccn.c
>> +++ b/drivers/perf/arm-ccn.c
>> @@ -713,7 +713,6 @@ static void arm_ccn_pmu_event_release(struct perf_event *event)
>>   static int arm_ccn_pmu_event_init(struct perf_event *event)
>>   {
>>   	struct arm_ccn *ccn;
>> -	struct hw_perf_event *hw = &event->hw;
>>   	u32 node_xp, type, event_id;
>>   	int valid;
>>   	int i;
>> @@ -721,16 +720,6 @@ static int arm_ccn_pmu_event_init(struct perf_event *event)
>>   
>>   	ccn = pmu_to_arm_ccn(event->pmu);
>>   
>> -	if (hw->sample_period) {
>> -		dev_dbg(ccn->dev, "Sampling not supported!\n");
>> -		return -EOPNOTSUPP;
>> -	}
>> -
>> -	if (has_branch_stack(event)) {
>> -		dev_dbg(ccn->dev, "Can't exclude execution levels!\n");
>> -		return -EINVAL;
>> -	}
>> -
> 
> [...]
> 
>> diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
>> index f5ea5acaf2f3..3424d165795c 100644
>> --- a/drivers/perf/arm_dsu_pmu.c
>> +++ b/drivers/perf/arm_dsu_pmu.c
>> @@ -544,23 +544,12 @@ static int dsu_pmu_event_init(struct perf_event *event)
>>   {
>>   	struct dsu_pmu *dsu_pmu = to_dsu_pmu(event->pmu);
>>   
>> -	/* We don't support sampling */
>> -	if (is_sampling_event(event)) {
>> -		dev_dbg(dsu_pmu->pmu.dev, "Can't support sampling events\n");
>> -		return -EOPNOTSUPP;
>> -	}
>> -
>>   	/* We cannot support task bound events */
>>   	if (event->cpu < 0 || event->attach_state & PERF_ATTACH_TASK) {
>>   		dev_dbg(dsu_pmu->pmu.dev, "Can't support per-task counters\n");
>>   		return -EINVAL;
>>   	}
>>   
>> -	if (has_branch_stack(event)) {
>> -		dev_dbg(dsu_pmu->pmu.dev, "Can't support filtering\n");
>> -		return -EINVAL;
>> -	}
>> -
> 
> I'm assuming that this and the other has_branch_stack() check were
> removed because branch stacks don't actually do anything unless sampling
> is enabled?
> 
> It's a small difference that there is now no error message if you ask
> for branch stacks, but it wouldn't have done anything anyway? I suppose
> this error message was also not applied very consistently across the
> different devices.

Right - the rarity of these checks, plus the fact that in both cases 
here they give a nonsensical debug message that has nothing whatsoever 
to do with the actual failing condition, seems to make it clear that 
they aren't realistically useful.

In general I don't see any good reason for a non-sampling event to be 
picky about the exact type of samples it isn't collecting.

Thanks,
Robin.

