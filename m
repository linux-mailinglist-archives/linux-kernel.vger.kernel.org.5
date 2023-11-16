Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12CE7EE0D5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 13:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345145AbjKPMpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 07:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjKPMpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 07:45:19 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5F2A1;
        Thu, 16 Nov 2023 04:45:16 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGBQsIr006773;
        Thu, 16 Nov 2023 12:44:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=baCBSVsMNXeO3j944GmUxKKioxYuIjPJVtEqyP3mlSk=;
 b=gWUaPg6dzigG6bZlVwJCa+fRHDtAmn2nyQnL9UpWJsOG9HCryvqmh/PrWHC+xzBUFGja
 6FX/hZWFAz3Gf6BpCig6WqmgtcBjGH+1nr37oiKsLI8JkqJxNaMd/Czqd/0B35JFfBwZ
 6/wpcNu842357WI4LrSMulKbQQdTVqS5xWQN7Pz22KN4WRrtm2z43DEuxCx/xh9I9Cqd
 7axd82N91S8NacF51ft8X0edBqMM5VQ/fysO+xMmmCjevdQGzyGv6WeZeAaJaZ4wu1uB
 Jz7+7PJfefXc6SE6GrUgm3HbxwihPPjY944KeFQsPgj2FgZ37vMcttUaqr8lW6olg9sY /Q== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ucubsb6ys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 12:44:44 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AGCii2P009080
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 12:44:44 GMT
Received: from [10.214.66.253] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 16 Nov
 2023 04:44:39 -0800
Message-ID: <0d290a5c-081f-4dfa-af9a-b061e6134662@quicinc.com>
Date:   Thu, 16 Nov 2023 18:14:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] iommu/arm-smmu: re-enable context caching in smmu
 reset operation
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <a39.skl@gmail.com>, <konrad.dybcio@linaro.org>,
        <quic_pkondeti@quicinc.com>, <quic_molvera@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <qipl.kernel.upstream@quicinc.com>
References: <20231114135654.30475-1-quic_bibekkum@quicinc.com>
 <20231114135654.30475-4-quic_bibekkum@quicinc.com>
 <CAA8EJpoRmm42aAvyX61o3tMWXszUZmfFvJEtnNDEfYdDqy4Y0g@mail.gmail.com>
 <72b30354-0497-45cf-8b71-e4f265eb0005@quicinc.com>
 <CAA8EJprPE=z2VN5LkaUyLyvYpx6i1eF9dyxOzN_L86pi5tmU-Q@mail.gmail.com>
From:   Bibek Kumar Patro <quic_bibekkum@quicinc.com>
In-Reply-To: <CAA8EJprPE=z2VN5LkaUyLyvYpx6i1eF9dyxOzN_L86pi5tmU-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: P5V2Nb4N9uO5XZt2vGlyYumM-eKoyeDx
X-Proofpoint-GUID: P5V2Nb4N9uO5XZt2vGlyYumM-eKoyeDx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_12,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 mlxscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/2023 4:33 PM, Dmitry Baryshkov wrote:
> On Wed, 15 Nov 2023 at 11:45, Bibek Kumar Patro
> <quic_bibekkum@quicinc.com> wrote:
>>
>> On 11/14/2023 7:45 PM, Dmitry Baryshkov wrote:
>>> On Tue, 14 Nov 2023 at 15:57, Bibek Kumar Patro
>>> <quic_bibekkum@quicinc.com> wrote:
>>>>
>>>> Context caching is re-enabled in the prefetch buffer for Qualcomm SoCs
>>>> through SoC specific reset ops, which is disabled in the default MMU-500
>>>> reset ops, but is expected for context banks using ACTLR register to
>>>> retain the prefetch value during reset and runtime suspend.
>>>
>>> Please refer to Documentation/process/submitting-patches.rst and
>>> rephrase this following the rules there.
>>>
>>
>> Noted, will go through the description once and rephrase it
>> in next version complying with rules.
>>
>>>>
>>>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
>>>> ---
>>>>    drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 25 ++++++++++++++++++----
>>>>    1 file changed, 21 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>> index 0eaf6f2a2e49..fa867b1d9d16 100644
>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>> @@ -478,11 +478,28 @@ static int qcom_smmu_def_domain_type(struct device *dev)
>>>>           return match ? IOMMU_DOMAIN_IDENTITY : 0;
>>>>    }
>>>>
>>>> +static int qcom_smmu500_reset(struct arm_smmu_device *smmu)
>>>> +{
>>>> +       int i;
>>>> +       u32 reg;
>>>> +
>>>> +       arm_mmu500_reset(smmu);
>>>> +
>>>> +       /* Re-enable context caching after reset */
>>>> +       for (i = 0; i < smmu->num_context_banks; ++i) {
>>>> +               reg = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
>>>> +               reg |= CPRE;
>>>> +               arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_ACTLR, reg);
>>>> +       }
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>>    static int qcom_sdm845_smmu500_reset(struct arm_smmu_device *smmu)
>>>>    {
>>>>           int ret;
>>>>
>>>> -       arm_mmu500_reset(smmu);
>>>> +       qcom_smmu500_reset(smmu);
>>>
>>> Is this applicable for sdm845? For all other platforms supported by
>>> qcom_smmu_500 implementation?
>>>
>>
>> In arm_mmu500_reset operation drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
>> CPRE bit is reset for all SoC based on mmu500 platform, hence for all
>> Qualcomm SoCs including sm845 we are setting back the CPRE bit.
> 
> The errata for the CoreLink MMU-500 requires CPRE to be disabled for
> all revisions before r2p2. Do we know whether these SoC used CoreLink
> MMU-500 and which version of it?
> 

Just checked all these SoCs are using r2p4 revision.
So CPRE needs to be enabled back here then?

>>
>>>>
>>>>           /*
>>>>            * To address performance degradation in non-real time clients,
>>>> @@ -509,7 +526,7 @@ static const struct arm_smmu_impl qcom_smmu_500_impl = {
>>>>           .init_context = qcom_smmu_init_context,
>>>>           .cfg_probe = qcom_smmu_cfg_probe,
>>>>           .def_domain_type = qcom_smmu_def_domain_type,
>>>> -       .reset = arm_mmu500_reset,
>>>> +       .reset = qcom_smmu500_reset,
>>>>           .write_s2cr = qcom_smmu_write_s2cr,
>>>>           .tlb_sync = qcom_smmu_tlb_sync,
>>>>    };
>>>> @@ -528,7 +545,7 @@ static const struct arm_smmu_impl sm8550_smmu_500_impl = {
>>>>           .init_context = qcom_smmu_init_context,
>>>>           .cfg_probe = qcom_smmu_cfg_probe,
>>>>           .def_domain_type = qcom_smmu_def_domain_type,
>>>> -       .reset = arm_mmu500_reset,
>>>> +       .reset = qcom_smmu500_reset,
>>>>           .write_s2cr = qcom_smmu_write_s2cr,
>>>>           .tlb_sync = qcom_smmu_tlb_sync,
>>>>    };
>>>> @@ -544,7 +561,7 @@ static const struct arm_smmu_impl qcom_adreno_smmu_v2_impl = {
>>>>    static const struct arm_smmu_impl qcom_adreno_smmu_500_impl = {
>>>>           .init_context = qcom_adreno_smmu_init_context,
>>>>           .def_domain_type = qcom_smmu_def_domain_type,
>>>> -       .reset = arm_mmu500_reset,
>>>> +       .reset = qcom_smmu500_reset,
>>>>           .alloc_context_bank = qcom_adreno_smmu_alloc_context_bank,
>>>>           .write_sctlr = qcom_adreno_smmu_write_sctlr,
>>>>           .tlb_sync = qcom_smmu_tlb_sync,
>>>> --
>>>> 2.17.1
>>>>
>>>
>>>
> 
> 
> 
> --
> With best wishes
> Dmitry
