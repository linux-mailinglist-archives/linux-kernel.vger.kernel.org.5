Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4094877FC0C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 18:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352801AbjHQQ0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 12:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353721AbjHQQ0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:26:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CEA173AB4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:25:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68C2AD75;
        Thu, 17 Aug 2023 09:25:39 -0700 (PDT)
Received: from [10.57.90.41] (unknown [10.57.90.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10F523F64C;
        Thu, 17 Aug 2023 09:24:56 -0700 (PDT)
Message-ID: <9ba29982-ae96-bf53-f021-21cb1b22643a@arm.com>
Date:   Thu, 17 Aug 2023 17:24:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Allow default substream bypass with
 a pasid support
Content-Language: en-GB
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Nicolin Chen <nicolinc@nvidia.com>
Cc:     will@kernel.org, joro@8bytes.org, mshavit@google.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev
References: <20230817042135.32822-1-nicolinc@nvidia.com>
 <ZN46upjIBFcI4mL+@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZN46upjIBFcI4mL+@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-17 16:20, Jason Gunthorpe wrote:
> On Wed, Aug 16, 2023 at 09:21:35PM -0700, Nicolin Chen wrote:
>> When an iommu_domain is set to IOMMU_DOMAIN_IDENTITY, the driver sets the
>> arm_smmu_domain->stage to ARM_SMMU_DOMAIN_BYPASS and skips the allocation
>> of a CD table, and then sets STRTAB_STE_0_CFG_BYPASS to the CONFIG field
>> of the STE. This works well for devices that only have one substream, i.e.
>> pasid disabled.
>>
>> With a pasid-capable device, however, there could be a use case where it
>> allows an IDENTITY domain attachment without disabling its pasid feature.
>> This requires the driver to allocate a multi-entry CD table to attach the
>> IDENTITY domain to its default substream and to configure the S1DSS filed
>> of the STE to STRTAB_STE_1_S1DSS_BYPASS. So, there is a missing link here
>> between the STE setup and an IDENTITY domain attachment.
>>
>> Add a new stage ARM_SMMU_DOMAIN_BYPASS_S1DSS to tag this configuration by
>> overriding the ARM_SMMU_DOMAIN_BYPASS if the device has pasid capability.
>> This new tag will allow the driver allocating a CD table yet skipping an
>> CD insertion from the IDENTITY domain, and setting up the STE accordingly.
>>
>> In a use case of ARM_SMMU_DOMAIN_BYPASS_S1DSS, the SHCFG field of the STE
>> should be set to STRTAB_STE_1_SHCFG_INCOMING. In other cases of having a
>> CD table, the shareability comes from a CD, not the SHCFG field: according
>> to "13.5 Summary of attribute/permission configuration fields" in the spec
>> the SHCFG field value is irrelevant. So, always configure the SHCFG field
>> of the STE to STRTAB_STE_1_SHCFG_INCOMING when a CD table is present, for
>> simplification.
>>
>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>> ---
>>
>> Changelog
>> v2:
>>   * Rebased on top of Michael's series reworking CD table ownership:
>>     https://lore.kernel.org/all/20230816131925.2521220-1-mshavit@google.com/
>>   * Added a new ARM_SMMU_DOMAIN_BYPASS_S1DSS stage to tag the use case
>> v1: https://lore.kernel.org/all/20230627033326.5236-1-nicolinc@nvidia.com/
> 
> After rebasing there really shouldn't be a
> ARM_SMMU_DOMAIN_BYPASS_S1DSS. I want to get to a model where the
> identity domain is a global static, so it can't be changing depending
> on how it is attched.
> 
> I continue to think that the right way to think about this is to have
> the CD table code generate the STE it wants and when doing so it will
> inspect what SSID0 is. If it is the IDENTITY domain then it fills
> s1dss / etc

Indeed, that's what I was getting at with "generalisation of
ARM_SMMU_DOMAIN_BYPASS based on s1cdmax" - just one type all the way 
down to the bowels of arm_smmu_write_strtab_ent(), which then decides 
whether it means touching S1DSS or Config in the given STE.

>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index b27011b2bec9..860db4fbb995 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -1271,6 +1271,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>>   	 * 3. Update Config, sync
>>   	 */
>>   	u64 val = le64_to_cpu(dst[0]);
>> +	u8 s1dss = STRTAB_STE_1_S1DSS_SSID0;
>>   	bool ste_live = false;
>>   	struct arm_smmu_device *smmu = NULL;
>>   	struct arm_smmu_ctx_desc_cfg *cd_table = NULL;
>> @@ -1290,6 +1291,9 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>>   
>>   	if (smmu_domain) {
>>   		switch (smmu_domain->stage) {
>> +		case ARM_SMMU_DOMAIN_BYPASS_S1DSS:
>> +			s1dss = STRTAB_STE_1_S1DSS_BYPASS;
>> +			fallthrough;
>>   		case ARM_SMMU_DOMAIN_S1:
>>   			cd_table = &master->cd_table;
>>   			break;
> 
> Eg, I think the code looks much nicer if the logic here is more like:
> 
> if (master->cd_table.cdtab)
>     arm_smmu_cd_table_get_ste(master->cd_table, &ste)
> else if (master->domain)
>     arm_smmu_domain_get_ste(master->domain, &ste);
> else
>     ste = not attached
> 
> And you'd check in arm_smmu_cd_table_get_ste() to learn the CD
> parameters and also what SSID=0 is. If SSID=0 is IDENTITY then
> arm_smmu_cd_table_get_ste would return with S1DSS set.
> 
> arm_smmu_domain_get_ste() would multiplex based on the domain type.
> 
>> @@ -2435,6 +2440,16 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>>   	} else if (smmu_domain->smmu != smmu)
>>   		ret = -EINVAL;
>>   
>> +	/*
>> +	 * When attaching an IDENTITY domain to a master with pasid capability,
>> +	 * the master can still enable SVA feature by allocating a multi-entry
>> +	 * CD table and attaching the IDENTITY domain to its default substream
>> +	 * that alone can be byassed using the S1DSS field of the STE.
>> +	 */
>> +	if (smmu_domain->stage == ARM_SMMU_DOMAIN_BYPASS && master->ssid_bits &&
>> +	    smmu->features & ARM_SMMU_FEAT_TRANS_S1)
>> +		smmu_domain->stage = ARM_SMMU_DOMAIN_BYPASS_S1DSS;
> 
> Then you don't technically need to do this.
> 
> Though if we can't atomically change the STE from IDENTITY to IDENTIY
> with a CD then you still have to do something here,

Strictly I think we are safe to do that - fill in all the S1* fields 
while Config[0] is still 0 and they're ignored, sync, then set 
Config[0]. Adding a CD table under a translation domain should be 
achievable as well, since S1CDMax, S1ContextPtr and S1Fmt can all be 
updated together atomically (although it's still the kind of switcheroo 
where I'd be scared of a massive boulder suddenly rolling out of the 
ceiling...)

> but really what we
> want is to force a CD table for all cases if PASID is enabled, and
> force DMA domains to be S2 domains as well.

Wut? No, DMA domains really want to be stage 1, for many reasons. 
Implementing them with stage 2 when stage 1 isn't supported was always a 
bit of a bodge, but thankfully I'm not aware of anyone ever building a 
stage-2-only SMMUv3 anyway.

The most glaringly obvious one, though, is that I think people like 
PASID support and SVA to actually work ;)

Thanks,
Robin.

>>   	mutex_unlock(&smmu_domain->init_mutex);
>>   	if (ret)
>>   		return ret;
>> @@ -2456,7 +2471,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>>   	list_add(&master->domain_head, &smmu_domain->devices);
>>   	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
>>   
>> -	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
>> +	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 ||
>> +	    smmu_domain->stage == ARM_SMMU_DOMAIN_BYPASS_S1DSS) {
>>   		if (!master->cd_table.cdtab) {
>>   			ret = arm_smmu_alloc_cd_tables(master);
>>   			if (ret) {
> 
> So more like:
> 
>   if (smmu_domain == IDENTIY && arm_smmu_support_ssid(dev))
>       arm_smmu_alloc_cd_tables()
> 
> Jason
