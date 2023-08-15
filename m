Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6439777CB72
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236638AbjHOLDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236573AbjHOLCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:02:50 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51089198E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 04:02:48 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RQ7Yt6YG2zNmsj;
        Tue, 15 Aug 2023 18:59:14 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 15 Aug 2023 19:02:45 +0800
Subject: Re: [PATCH] drivers/perf: hisi: Schedule perf session according to
 locality
To:     Will Deacon <will@kernel.org>
CC:     <jonathan.cameron@huawei.com>, <mark.rutland@arm.com>,
        <hejunhao3@huawei.com>, <prime.zeng@hisilicon.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <yangyicong@hisilicon.com>
References: <20230808125147.2080-1-yangyicong@huawei.com>
 <20230811111414.GC6993@willie-the-truck>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <8b3ea6aa-2751-9612-4b91-82640e8dde0f@huawei.com>
Date:   Tue, 15 Aug 2023 19:02:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20230811111414.GC6993@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/11 19:14, Will Deacon wrote:
> On Tue, Aug 08, 2023 at 08:51:47PM +0800, Yicong Yang wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> The PCIe PMUs locate on different NUMA node but currently we don't
>> consider it and likely stack all the sessions on the same CPU:
>>
>> [root@localhost tmp]# cat /sys/devices/hisi_pcie*/cpumask
>> 0
>> 0
>> 0
>> 0
>> 0
>> 0
>>
>> This can be optimize a bit to use a local CPU for the PMU.
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>  drivers/perf/hisilicon/hisi_pcie_pmu.c | 15 ++++++++++++---
>>  1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
>> index e10fc7cb9493..60ecf469782b 100644
>> --- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
>> +++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
>> @@ -665,7 +665,7 @@ static int hisi_pcie_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
>>  	struct hisi_pcie_pmu *pcie_pmu = hlist_entry_safe(node, struct hisi_pcie_pmu, node);
>>  
>>  	if (pcie_pmu->on_cpu == -1) {
>> -		pcie_pmu->on_cpu = cpu;
>> +		pcie_pmu->on_cpu = cpumask_local_spread(0, dev_to_node(&pcie_pmu->pdev->dev));
>>  		WARN_ON(irq_set_affinity(pcie_pmu->irq, cpumask_of(cpu)));
> 
> Hmm, this is a bit weird now, because the interrupt is affine to a different
> CPU from the one you've chosen. Are you sure that's ok? When the offline
> notifier picks a new target, it moves the irq as well.
> 

Thanks for pointing it out. This is indeed a problem. Will fix this.

Thanks.

