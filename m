Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CD0778763
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 08:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjHKGXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 02:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjHKGXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 02:23:49 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB862D4F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 23:23:47 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RMYdn02jjz4f3mJP
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 14:23:41 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgAHl6nu09VkK5fCAQ--.32129S3;
        Fri, 11 Aug 2023 14:23:43 +0800 (CST)
Subject: Re: [PATCH v2 1/2] iommu/arm-smmu-v3: Add support for ECMDQ register
 mode
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Tanmay Jagdale <tanmay@marvell.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
References: <20230809131303.1355-1-thunder.leizhen@huaweicloud.com>
 <20230809131303.1355-2-thunder.leizhen@huaweicloud.com>
 <ZNVBgCb5w0daExIL@Asurada-Nvidia>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <8be55ce1-ae59-e7f0-c774-f0371272fd2a@huaweicloud.com>
Date:   Fri, 11 Aug 2023 14:23:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ZNVBgCb5w0daExIL@Asurada-Nvidia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgAHl6nu09VkK5fCAQ--.32129S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1kKF43Jr4rXw4UWrWktFb_yoW8Zw4xpa
        y8KayqyF1kJrn7Aw10vr1vqr1Dtws8CFy2ya1YgFZ0ywn0yr97ZF1UKw1FkrW8Cr1S9FnI
        kw45XrZrC395WFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/11 3:58, Nicolin Chen wrote:
> Hi Zhen,
> 
> On Wed, Aug 09, 2023 at 06:13:02AM -0700, thunder.leizhen@huaweicloud.com wrote:
>> +static int arm_smmu_ecmdq_layout(struct arm_smmu_device *smmu)
>> +{
>> +       int cpu;
>> +       struct arm_smmu_ecmdq __percpu *ecmdq;
>> +
>> +       if (num_possible_cpus() <= smmu->nr_ecmdq) {
> 
> Does the nr_ecmdq always physically match with the number of CPUs?
> I saw the spec saying "up to 256 pages", but not sure if they are
> always physically present, even if CPU number is smaller i.e. some
> of them would be unassigned/wasted.

This is considered in v1, but now priority is to support the most
basic features. Another advantage is that if someone makes suggestions
for improvement, the workload can be smaller.

> 
>> +               ecmdq = devm_alloc_percpu(smmu->dev, *ecmdq);
>> +               if (!ecmdq)
>> +                       return -ENOMEM;
>> +
>> +               for_each_possible_cpu(cpu)
>> +                       *per_cpu_ptr(smmu->ecmdqs, cpu) = per_cpu_ptr(ecmdq, cpu);
>> +
>> +               /* A core requires at most one ECMDQ */
>> +               smmu->nr_ecmdq = num_possible_cpus();
>> +
>> +               return 0;
>> +       }
>> +
>> +       return -ENOSPC;
> 
> This ENOSPC is a software limitation, isn't it? How about using
> "smp_processor_id() % smmu->nr_ecmdq" to select a queue?
> 
>> +       shift_increment = order_base_2(num_possible_cpus() / smmu->nr_ecmdq);
>> +
>> +       offset = 0;
>> +       for_each_possible_cpu(cpu) {
>> +               struct arm_smmu_ecmdq *ecmdq;
>> +               struct arm_smmu_queue *q;
>> +
>> +               ecmdq = *per_cpu_ptr(smmu->ecmdqs, cpu);
>> +               ecmdq->base = cp_base + offset;
>> +
>> +               q = &ecmdq->cmdq.q;
>> +
>> +               q->llq.max_n_shift = ECMDQ_MAX_SZ_SHIFT + shift_increment;
>> +               ret = arm_smmu_init_one_queue(smmu, q, ecmdq->base, ARM_SMMU_ECMDQ_PROD,
>> +                               ARM_SMMU_ECMDQ_CONS, CMDQ_ENT_DWORDS, "ecmdq");
> 
> Not getting why max_n_shift increases by shift_increment. Mind
> elaborating?

For example:
If a CPU exclusively occupies an ECMDQ, the number of queue elements is 256.
If two cores share an ECMDQ, the number of queue elements increases to 512.

> 
> Thanks
> Nicolin
> .
> 

-- 
Regards,
  Zhen Lei

