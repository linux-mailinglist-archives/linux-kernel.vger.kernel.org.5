Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59701779DE0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 09:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjHLHS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 03:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjHLHSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 03:18:55 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D419C
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 00:18:55 -0700 (PDT)
Received: from kwepemi500019.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RNBmj5PbPzTmNG;
        Sat, 12 Aug 2023 15:16:53 +0800 (CST)
Received: from [10.174.176.82] (10.174.176.82) by
 kwepemi500019.china.huawei.com (7.221.188.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 12 Aug 2023 15:18:51 +0800
Message-ID: <36924a4d-e62c-68d5-3cb0-375b7fe1d5c0@huawei.com>
Date:   Sat, 12 Aug 2023 15:18:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.1
Subject: Re: [RESEND PATCH 2/2] iommu/iova: allocate iova_rcache->depot
 dynamicly
To:     John Garry <john.g.garry@oracle.com>
CC:     <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <baolu.lu@linux.intel.com>, <robh@kernel.org>,
        <nicolinc@nvidia.com>, <kevin.tian@intel.com>,
        Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>,
        <will@kernel.org>
References: <20230811130246.42719-1-zhangzekun11@huawei.com>
 <20230811130246.42719-3-zhangzekun11@huawei.com>
 <a190ba95-79d1-e9e2-1f62-97aa94a4be7b@oracle.com>
From:   "zhangzekun (A)" <zhangzekun11@huawei.com>
In-Reply-To: <a190ba95-79d1-e9e2-1f62-97aa94a4be7b@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.82]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500019.china.huawei.com (7.221.188.117)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/11 22:14, John Garry 写道:
> On 11/08/2023 14:02, Zhang Zekun wrote:
>> In fio test with 4k,read,and allowed cpus to 0-255, we observe a 
>> performance
>> decrease of IOPS. The normal IOPS 
>
> What do you mean by normal IOPS? Describe this "normal" scenario.
>
Hi, John

The reason why I think 1980K is normal is that I have test the iova_rache
hit rate with all iova size, the average iova cache hit rate can reach up to
around 99% (varys from diffent work loads and iova size), and I think
iova_rcache behave well in our test work loads. Besides, the IOPS is
behaving as expect which is acked by our test group.

> ? can reach up to 1980k, but we can only
>> get about 1600k.
>>
>> abormal IOPS:
>> Jobs: 12 (f=12): [R(12)][99.3%][r=6220MiB/s][r=1592k IOPS][eta 00m:12s]
>> Jobs: 12 (f=12): [R(12)][99.4%][r=6215MiB/s][r=1591k IOPS][eta 00m:11s]
>> Jobs: 12 (f=12): [R(12)][99.4%][r=6335MiB/s][r=1622k IOPS][eta 00m:10s]
>> Jobs: 12 (f=12): [R(12)][99.5%][r=6194MiB/s][r=1586k IOPS][eta 00m:09s]
>> Jobs: 12 (f=12): [R(12)][99.6%][r=6173MiB/s][r=1580k IOPS][eta 00m:08s]
>> Jobs: 12 (f=12): [R(12)][99.6%][r=5984MiB/s][r=1532k IOPS][eta 00m:07s]
>> Jobs: 12 (f=12): [R(12)][99.7%][r=6374MiB/s][r=1632k IOPS][eta 00m:06s]
>> Jobs: 12 (f=12): [R(12)][99.7%][r=6343MiB/s][r=1624k IOPS][eta 00m:05s]
>>
>> normal IOPS:
>> Jobs: 12 (f=12): [R(12)][99.3%][r=7736MiB/s][r=1980k IOPS][eta 00m:12s]
>> Jobs: 12 (f=12): [R(12)][99.4%][r=7744MiB/s][r=1982k IOPS][eta 00m:11s]
>> Jobs: 12 (f=12): [R(12)][99.4%][r=7737MiB/s][r=1981k IOPS][eta 00m:10s]
>> Jobs: 12 (f=12): [R(12)][99.5%][r=7735MiB/s][r=1980k IOPS][eta 00m:09s]
>> Jobs: 12 (f=12): [R(12)][99.6%][r=7741MiB/s][r=1982k IOPS][eta 00m:08s]
>> Jobs: 12 (f=12): [R(12)][99.6%][r=7740MiB/s][r=1982k IOPS][eta 00m:07s]
>> Jobs: 12 (f=12): [R(12)][99.7%][r=7736MiB/s][r=1981k IOPS][eta 00m:06s]
>> Jobs: 12 (f=12): [R(12)][99.7%][r=7736MiB/s][r=1980k IOPS][eta 00m:05s]
>>
>> The current struct of iova_rcache will have iova_cpu_rcache for every
>> cpu, and these iova_cpu_rcaches use a common buffer 
>> iova_rcache->depot to
>> exchange iovas among iova_cpu_rcaches. A machine with 256 cpus will have
>> 256 iova_cpu_rcaches and 1 iova_rcache->depot per iova_domain. However,
>> the max size of iova_rcache->depot is fixed to MAX_GLOBAL_MAGS which 
>> equals
>> to 32, and can't grow with the number of cpus, and this can cause 
>> problem
>> in some condition.
>>
>> Some drivers will only free iovas in their irq call back function. For
>> the driver in this case it has 16 thread irqs to free iova, but these
>> irq call back function will only free iovas on 16 certain cpus(cpu{0,16,
>> 32...,240}). Thread irq which smp affinity is 0-15, will only free 
>> iova on
>> cpu 0. However, the driver will alloc iova on all cpus(cpu{0-255}), cpus
>> without free iova in local cpu_rcache need to get free iovas from
>> iova_rcache->depot. The current size of iova_rcache->depot max size 
>> is 32,
>> and it seems to be too small for 256 users (16 cpus will put iovas to
>> iova_rcache->depot and 240 cpus will try to get iova from it). Set
>> iova_rcache->depot grow with the num of possible cpus, and the decrease
>> of IOPS disappear.
>
> Doesn't it take a long time for all the depots to fill for you? From 
> the description, this sounds like the hisilicon SAS controller which 
> you are experimenting with and I found there that it took a long time 
> for the depots to fill for high throughput testing.
>
> Thanks,
> John

Yes, it will take more time to fill rcahe->depot, but we don't need to fill
all depots before using iova in them. We can use iova in rcache->depot
when local cpu_rcache is empty and there are iova magazines in
rcache->depot, which means "rcache->depot_size > 0". The larger depot
size will help caching more iova magazines freed in __iova_rcache_insert()
which means more potential memory cost for iova_rcache, and should not
introduce performance issues.
