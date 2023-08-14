Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D5F77B4B8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbjHNIyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbjHNIxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:53:40 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03F491;
        Mon, 14 Aug 2023 01:53:38 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RPSlK4xqpzNnVf;
        Mon, 14 Aug 2023 16:50:05 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 14 Aug 2023 16:53:36 +0800
CC:     <yangyicong@hisilicon.com>, <catalin.marinas@arm.com>,
        <lpieralisi@kernel.org>, <mark.rutland@arm.com>,
        <robin.murphy@arm.com>, <guohanjun@huawei.com>, <corbet@lwn.net>,
        <rafael@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jonathan.cameron@huawei.com>,
        <shameerali.kolothum.thodi@huawei.com>, <hejunhao3@huawei.com>,
        <linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
        <zhurui3@huawei.com>
Subject: Re: [PATCH] perf/smmuv3: Enable HiSilicon Erratum 162001900 quirk for
 HIP08/09
To:     Will Deacon <will@kernel.org>
References: <20230809100654.32036-1-yangyicong@huawei.com>
 <20230811111739.GD6993@willie-the-truck>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <56309be3-cf3b-821d-b6d8-7f407b160fbb@huawei.com>
Date:   Mon, 14 Aug 2023 16:53:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20230811111739.GD6993@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/11 19:17, Will Deacon wrote:
> On Wed, Aug 09, 2023 at 06:06:54PM +0800, Yicong Yang wrote:
>> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
>> index 25a269d431e4..b854b67b81fc 100644
>> --- a/drivers/perf/arm_smmuv3_pmu.c
>> +++ b/drivers/perf/arm_smmuv3_pmu.c
>> @@ -115,6 +115,7 @@
>>  #define SMMU_PMCG_PA_SHIFT              12
>>  
>>  #define SMMU_PMCG_EVCNTR_RDONLY         BIT(0)
>> +#define SMMU_PMCG_HARDEN_DISABLE        BIT(1)
>>  
>>  static int cpuhp_state_num;
>>  
>> @@ -150,6 +151,22 @@ SMMU_PMU_EVENT_ATTR_EXTRACTOR(filter_stream_id, config1, 0, 31);
>>  SMMU_PMU_EVENT_ATTR_EXTRACTOR(filter_span, config1, 32, 32);
>>  SMMU_PMU_EVENT_ATTR_EXTRACTOR(filter_enable, config1, 33, 33);
>>  
>> +static int smmu_pmu_apply_event_filter(struct smmu_pmu *smmu_pmu,
>> +				       struct perf_event *event, int idx);
>> +
>> +static inline void smmu_pmu_enable_quirk_hip08_09(struct pmu *pmu)
>> +{
>> +	struct smmu_pmu *smmu_pmu = to_smmu_pmu(pmu);
>> +	unsigned int idx;
>> +
>> +	for_each_set_bit(idx, smmu_pmu->used_counters, smmu_pmu->num_counters)
>> +		smmu_pmu_apply_event_filter(smmu_pmu, smmu_pmu->events[idx], idx);
>> +
>> +	writel(SMMU_PMCG_IRQ_CTRL_IRQEN,
>> +	       smmu_pmu->reg_base + SMMU_PMCG_IRQ_CTRL);
>> +	writel(SMMU_PMCG_CR_ENABLE, smmu_pmu->reg_base + SMMU_PMCG_CR);
> 
> Can you tail-call smmu_pmu_enable() instead of duplicating it here?
> 
>> +static inline void smmu_pmu_disable_quirk_hip08_09(struct pmu *pmu)
>> +{
>> +	struct smmu_pmu *smmu_pmu = to_smmu_pmu(pmu);
>> +	unsigned int idx;
>> +
>> +	/*
>> +	 * The global disable of PMU sometimes fail to stop the counting.
>> +	 * Harden this by writing an invalid event type to each used counter
>> +	 * to forcibly stop counting.
>> +	 */
>> +	for_each_set_bit(idx, smmu_pmu->used_counters, smmu_pmu->num_counters)
>> +		writel(0xffff, smmu_pmu->reg_base + SMMU_PMCG_EVTYPER(idx));
>> +
>> +	writel(0, smmu_pmu->reg_base + SMMU_PMCG_CR);
>> +	writel(0, smmu_pmu->reg_base + SMMU_PMCG_IRQ_CTRL);
> 
> Same things here, but with smmu_pmu_disable()
> 

Sure. Will tail call smmu_pmu_{enable, disable} in both case to avoid duplication.
Thanks for the comments.

Thanks.

