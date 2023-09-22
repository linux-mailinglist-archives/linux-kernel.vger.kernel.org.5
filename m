Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FC27AAF5D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 12:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbjIVKXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 06:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbjIVKXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 06:23:03 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C65A9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 03:22:57 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38M9AJ80029275;
        Fri, 22 Sep 2023 10:22:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : cc : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=SM+FJHOAvc9X1k5lXSldfO6KxCV+8nOx/9yDPCvrn/s=;
 b=GOImxqVGrUzKdVKNSDIMyLkrDtmiRA68/JGvkmb7RwPS59GTzHbSo1hTg7Q8/Pv2muR6
 3Mj91i1q9aqPWfPMi9N7WsHo98oCx48TF7/kCfP3hFL1sMKva8G93cBnOoQyrZB4QhLJ
 SFySzeZCpdNQNVJBlA10BnMkFyQM0oQTIlnXYC1DQqnXkAMQMwS6yGyvc5IjRgg++SbZ
 l+HWBgpm1ctm/i8CN5lAbIyhZUVpovu0JpWhdYhB7p4ZcCDt62M84iY9+ruGW/6T6zFK
 K7vKEe5IvTYUy7ogyvNZ9HoS99U2YF+ykfNEkiR98B8A39GAoIGt4FT3lYmFp1hzwwb0 FQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t8u6rsj0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 10:22:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38MAMHVv004095
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 10:22:17 GMT
Received: from [10.214.227.50] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 22 Sep
 2023 03:20:09 -0700
Message-ID: <a01e7e60-6ead-4a9e-ba90-22a8a6bbd03f@quicinc.com>
Date:   Fri, 22 Sep 2023 15:50:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] iommu/arm-smmu: Introduction of ACTLR for custom
 prefetch setting
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, <will@kernel.org>,
        <joro@8bytes.org>, <jgg@ziepe.ca>, <baolu.lu@linux.intel.com>,
        <jsnitsel@redhat.com>, <u.kleine-koenig@pengutronix.de>,
        <vladimir.oltean@nxp.com>, <robh@kernel.org>
References: <20230915195221.25735-1-quic_bibekkum@quicinc.com>
 <a682b20a-c87b-65c9-dcf0-abd40fbc4cdd@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        <quic_guptap@quicinc.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>,
        <quic_vjitta@quicinc.com>, <quic_pbrahma@quicinc.com>
From:   Bibek Kumar Patro <quic_bibekkum@quicinc.com>
In-Reply-To: <a682b20a-c87b-65c9-dcf0-abd40fbc4cdd@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XOIio_pfaiR1yTi_e8_3WyurMqV7ED27
X-Proofpoint-ORIG-GUID: XOIio_pfaiR1yTi_e8_3WyurMqV7ED27
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_07,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 mlxlogscore=986 impostorscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2309220087
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/18/2023 4:49 PM, Robin Murphy wrote:
> On 2023-09-15 20:52, Bibek Kumar Patro wrote:
>> Hi community,
>>
>> I have a requirement which I'm looking for inputs from the community.
>> Currently in QCOM SOCs ACTLR register is used to store the custom
>> prefetcher setting by each client opting to use this feature.
>> This helps to store the next set of instructions to be prefetched
>> as per the value stored.This could help in a significant performance 
>> bump.
>> Requirement is to create an universal and flexible interface to store
>> and set this prefetch value which is unique for each SID.
>>
>> Currently this ACTLR property is stored for each client as
>> DT property of smmu has following fields as mentioned:
>>
>>     actlr-cells = <no of fields>
>>     actlrs = <SID MASK ACTLR_value>
>>
>> These entries are parsed in arm-smmu layer and is stored in a table
>> containing actrl values corresponding to each SID and MASK. This ACTLR
>> value is then used during contextbank initialisation. Hence this entire
>> DT entry process is being carried out by arm-smmu layer.
>>
>> I'm trying to envise a design where client can set this property in
>> their own DT entry as per their required value in case they have this
>> use-case. Here ACTLR value can be populated as 3rd optional field
>> in iommu-cells property which is already being used by clients to store
>> SID and MASK(optional) as mentioned:
>>
>>     iommu-cells = <SID MASK(optional) ACTLR value(optional)>
>>
>> This would help to avoid additional property in client DT as
>> exisiting DT property can be extrapolated to store the same. And this
>> prefetcher value can be set into the ARM_SMMU_CB_ACTLR register
>> during context bank inititalisation.
>> This patch is still WIP, so would like to get inputs and advise
>> from community on this design implementation or any alternate approach
>> to this requirement.
> 
> At the very least this would need to be in a implementation-specific 
> backend, since everything about ACTLR is implementation-defined; there 
> could be bits in there that the driver needs to manage itself and 
> clients have absolutely no business overriding (e.g. the MMU-500 errata 
> workarounds). The generic driver can't know what's valid, nor what the 
> consequences are of not being able to satisfy a particular setting. Then 
> there's still the question of what if two clients ask for different 
> settings but want to attach to the same context?
> 

Thanks Robin for you inputs. We had some rounds of discussions
internally after going through your concerns mentioned above.

> It's also questionable whether this would belong in DT at all, since it 
> has a bit of a smell of software policv about it.

ACTLR data which we feed into this register is client specific but at
the same time client won't have the provision to set a value as per
their choice.Similar to what SID and MASK value currently is which
is specific for each client but at the same time client don't have
the liberty to choose these values as per their choice.Hence this
was the initial motivation to move it to client specific DT property.
Also this would have helped us to match and set each ACTLR value with
corresponding SID and MASK for each client during the device attachment
to SMMU.

For many years we have been supporting ACTLR settings on all of our
SoCs with a device tree table. Iur downstream implementation is at [1].
This has worked us very well and did not see any need for client
specific customization as such. Since passing register content via
device tree is highly discouraged and also since ACTLR is
implementation-defined as rightly mentioned for which client doesn't
have the liberty to choose the value to be set here, we are moving the
configuration data to driver and apply these settings as per SoC needs.

We will host these data now in implementation specific backend driver
as suggested in Lookup table kind of format. Table will contain the SID
MASK and ACTLR value which can be used to populate the prefetch value
for each context bank during SMMU configuration probe.
This implementation should also prevent clients having liberty to go
and modify the actlr entry.

I'll send in the next RFC patch for review of the driver based design.

[1]
https://git.codelinaro.org/clo/la/kernel/msm-5.10/-/blob/kernel.lnx.5.10.r3-rel/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c#L2198


> If it could be 
> sufficiently justified then it would need a proper binding proposal, and 
> "write this opaque value into this register" type properties are 
> generally not approved of.
> 
> Thanks,
> Robin.
> 

Thanks,
Bibek

>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
>> ---
>>   drivers/iommu/arm/arm-smmu/arm-smmu.c | 14 ++++++++++++++
>>   drivers/iommu/arm/arm-smmu/arm-smmu.h |  6 ++++++
>>   2 files changed, 20 insertions(+)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c 
>> b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> index a86acd76c1df..2dd3796e30ea 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> @@ -917,11 +917,20 @@ static void arm_smmu_write_s2cr(struct 
>> arm_smmu_device *smmu, int idx)
>>       arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_S2CR(idx), reg);
>>   }
>>
>> +static void arm_smmu_write_actlr(struct arm_smmu_device *smmu, int idx)
>> +{
>> +    struct arm_smmu_actlr *actlr = smmu->actlrs + idx;
>> +
>> +    u32 reg = FIELD_PREP(ARM_SMMU_CB_ACTLR, actlrs->actlr);
>> +}
>> +
>>   static void arm_smmu_write_sme(struct arm_smmu_device *smmu, int idx)
>>   {
>>       arm_smmu_write_s2cr(smmu, idx);
>>       if (smmu->smrs)
>>           arm_smmu_write_smr(smmu, idx);
>> +    if (smmu->actlrs)
>> +        arm_smmu_write_actlr(smmu, idx);
>>   }
>>
>>   /*
>> @@ -1031,6 +1040,7 @@ static int arm_smmu_master_alloc_smes(struct 
>> device *dev)
>>       for_each_cfg_sme(cfg, fwspec, i, idx) {
>>           u16 sid = FIELD_GET(ARM_SMMU_SMR_ID, fwspec->ids[i]);
>>           u16 mask = FIELD_GET(ARM_SMMU_SMR_MASK, fwspec->ids[i]);
>> +        u32 actlr = FIELD_GET(ARM_SMMU_CB_ACTLR, fwspec->ids[i]);
>>
>>           if (idx != INVALID_SMENDX) {
>>               ret = -EEXIST;
>> @@ -1524,6 +1534,10 @@ static int arm_smmu_of_xlate(struct device 
>> *dev, struct of_phandle_args *args)
>>
>>       if (args->args_count > 1)
>>           fwid |= FIELD_PREP(ARM_SMMU_SMR_MASK, args->args[1]);
>> +
>> +    if (args->args_count > 2)
>> +        fwid |= FIELD_PREP(ARM_SMMU_CB_ACTLR, args->args[2]);
>> +
>>       else if (!of_property_read_u32(args->np, "stream-match-mask", 
>> &mask))
>>           fwid |= FIELD_PREP(ARM_SMMU_SMR_MASK, mask);
>>
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h 
>> b/drivers/iommu/arm/arm-smmu/arm-smmu.h
>> index 703fd5817ec1..7d402ab58dc8 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
>> @@ -274,6 +274,11 @@ struct arm_smmu_smr {
>>       bool                pinned;
>>   };
>>
>> +struct arm_smmu_actlr {
>> +    struct arm_smmu_smr smr;
>> +    u32 actlr;
>> +};
>> +
>>   struct arm_smmu_device {
>>       struct device            *dev;
>>
>> @@ -312,6 +317,7 @@ struct arm_smmu_device {
>>       u16                smr_mask_mask;
>>       struct arm_smmu_smr        *smrs;
>>       struct arm_smmu_s2cr        *s2crs;
>> +    struct arm_smmu_actlr        *actlrs;
>>       struct mutex            stream_map_mutex;
>>
>>       unsigned long            va_size;
>> -- 
>> 2.17.1
>>
