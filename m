Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A381877D940
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 05:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241686AbjHPDsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 23:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241768AbjHPDsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 23:48:04 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EEE1FC3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 20:40:40 -0700 (PDT)
Received: from kwepemi500019.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RQYlm5rptzrSD7;
        Wed, 16 Aug 2023 11:39:16 +0800 (CST)
Received: from [10.174.176.82] (10.174.176.82) by
 kwepemi500019.china.huawei.com (7.221.188.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 16 Aug 2023 11:40:36 +0800
Message-ID: <80286146-578e-5814-5a2b-5535dc476782@huawei.com>
Date:   Wed, 16 Aug 2023 11:40:35 +0800
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
 <36924a4d-e62c-68d5-3cb0-375b7fe1d5c0@huawei.com>
 <99d905fb-0732-bb7b-f631-f08c897f1d8c@oracle.com>
From:   "zhangzekun (A)" <zhangzekun11@huawei.com>
In-Reply-To: <99d905fb-0732-bb7b-f631-f08c897f1d8c@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.82]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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



在 2023/8/15 23:15, John Garry 写道:
> On 12/08/2023 08:18, zhangzekun (A) wrote:
>>
>>
>> 在 2023/8/11 22:14, John Garry 写道:
>>> On 11/08/2023 14:02, Zhang Zekun wrote:
>>>> In fio test with 4k,read,and allowed cpus to 0-255, we observe a 
>>>> performance
>>>> decrease of IOPS.
>> The normal IOPS
>>>
>>> What do you mean by normal IOPS? Describe this "normal" scenario.
>>>
>> Hi, John
>>
>> The reason why I think 1980K is normal is that I have test the 
>> iova_rache
>> hit rate with all iova size, the average iova cache hit rate can 
>> reach up to
>
> Sorry to say, but I still don't know what you mean by the terms 
> "normal" and "abnormal" here. Is "normal" prior to the drop in IOPS 
> which you mention, above? If so, at what time do this occur?
Hi, John

The decrease is first observe in high concurrency fio test based on 
openeulr kernel-5.10, and the IOPS is about 300~400K , which is quite 
abnormal for some low fio concurrency test can have more than 1000K 
IOPS. The frame graph show that iovas alloc from slow path alloc_iova() 
takes a high percentage, and I find out that current struct of 
iova_rcache could  behave poor with machine have 256 cores and with 
device driver does not free and alloc iova evenly in a heavy work load. 
After optimizing the iova_rcache, the IOPS come to more than 1900K IOPS 
on openeuler kernel-5.10. The mainline of linux kernel have the same 
problem on openeuler kernel-5.10, but the IOPS does not improve such a 
large percentage. I use the term "normal" and "abnormal" here, maybe 
these pair of words should be replaced by "before optimization" and 
"after optimization".

Thanks,
Zekun
