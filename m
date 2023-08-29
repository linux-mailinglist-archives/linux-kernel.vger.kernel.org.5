Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CB578CEFD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 23:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236902AbjH2VyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 17:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238667AbjH2VyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:54:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6924EFF
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 14:54:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 894642F4;
        Tue, 29 Aug 2023 14:54:45 -0700 (PDT)
Received: from [10.57.2.162] (unknown [10.57.2.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BAA5A3F64C;
        Tue, 29 Aug 2023 14:54:04 -0700 (PDT)
Message-ID: <d1bf37be-6ce5-a446-2f5b-db94fa6a0776@arm.com>
Date:   Tue, 29 Aug 2023 22:54:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/3] iommu/arm-smmu-v3: Add an arm_smmu_tlb_inv_domain
 helper
Content-Language: en-GB
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     will@kernel.org, jgg@nvidia.com, joro@8bytes.org,
        jean-philippe@linaro.org, apopple@nvidia.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev
References: <cover.1692693557.git.nicolinc@nvidia.com>
 <854e2b3f2d4f1b76f916fcfc288b34526d4d4162.1692693557.git.nicolinc@nvidia.com>
 <7e97b5a5-6be0-87a8-aaf7-89980b0a35d1@arm.com>
 <ZOTqXmzs/wqgI1s6@Asurada-Nvidia>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZOTqXmzs/wqgI1s6@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-22 18:03, Nicolin Chen wrote:
> On Tue, Aug 22, 2023 at 10:40:18AM +0100, Robin Murphy wrote:
>   
>> On 2023-08-22 09:45, Nicolin Chen wrote:
>>> Move the part of per-asid or per-vmid invalidation command issuing into a
>>> new helper function, which will be used in the following change.
>>
>> Why? This achieves nothing except make the code harder to follow and
>> disconnect the rather important comment even further from the code it is
> 
> We need the same if-else routine to issue a per-asid or per-vmid
> TLBI command. If making a copy of this same routine feels better
> to you, yea, I can change that.
> 
>> significant to. It's not like we need a specific prototype to take a
>> function pointer from, it's just another internal call - see
>> arm_smmu_flush_iotlb_all() for instance. We know the cookie is an
>> arm_smmu_domain pointer because we put it there, and converting it back
>> from a void pointer is exactly the same *at* the function call boundary
>> as immediately afterwards.
> 
> Hmm, I am not quite following this. What do you suggest here?

Oh, this is becoming quite the lesson in not reviewing patches in a hurry :(

Apparently I managed to misread the diff and the horribly subtle 
difference between "arm_smmu_tlb_inv_domain" and 
"arm_smmu_atc_inv_domain", and think that arm_smmu_tlb_inv_context() was 
already just dealing with the TLBI command and you were moving the 
entire body into the new helper. Sorry about that.

Still, the part about the comment remains true, and I think it goes to 
show what a thoroughly horrible naming scheme it is to have "tlb_inv" 
denote a function responsible for TLBI commands and "atc_inv" denote a 
function responsible for ATC commands and "tlb_inv" denote a function 
responsible for both TLBI and ATC commands...

Thanks,
Robin.

> 
> Thanks
> Nic
> 
>>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>>> ---
>>>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 24 +++++++++++++--------
>>>    1 file changed, 15 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> index 9b0dc3505601..d6c647e1eb01 100644
>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> @@ -1854,12 +1854,24 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
>>>        return arm_smmu_cmdq_batch_submit(smmu_domain->smmu, &cmds);
>>>    }
>>>
>>> +static void arm_smmu_tlb_inv_domain(struct arm_smmu_domain *smmu_domain)
>>> +{
>>> +     struct arm_smmu_device *smmu = smmu_domain->smmu;
>>> +     struct arm_smmu_cmdq_ent cmd;
>>> +
>>> +     if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
>>> +             arm_smmu_tlb_inv_asid(smmu, smmu_domain->s1_cfg.cd.asid);
>>> +     } else {
>>> +             cmd.opcode      = CMDQ_OP_TLBI_S12_VMALL;
>>> +             cmd.tlbi.vmid   = smmu_domain->s2_cfg.vmid;
>>> +             arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
>>> +     }
>>> +}
>>> +
>>>    /* IO_PGTABLE API */
>>>    static void arm_smmu_tlb_inv_context(void *cookie)
>>>    {
>>>        struct arm_smmu_domain *smmu_domain = cookie;
>>> -     struct arm_smmu_device *smmu = smmu_domain->smmu;
>>> -     struct arm_smmu_cmdq_ent cmd;
>>>
>>>        /*
>>>         * NOTE: when io-pgtable is in non-strict mode, we may get here with
>>> @@ -1868,13 +1880,7 @@ static void arm_smmu_tlb_inv_context(void *cookie)
>>>         * insertion to guarantee those are observed before the TLBI. Do be
>>>         * careful, 007.
>>>         */
>>> -     if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
>>> -             arm_smmu_tlb_inv_asid(smmu, smmu_domain->s1_cfg.cd.asid);
>>> -     } else {
>>> -             cmd.opcode      = CMDQ_OP_TLBI_S12_VMALL;
>>> -             cmd.tlbi.vmid   = smmu_domain->s2_cfg.vmid;
>>> -             arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
>>> -     }
>>> +     arm_smmu_tlb_inv_domain(smmu_domain);
>>>        arm_smmu_atc_inv_domain(smmu_domain, 0, 0, 0);
>>>    }
>>>
