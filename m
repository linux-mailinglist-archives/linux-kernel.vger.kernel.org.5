Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E317E0AF2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 23:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbjKCWHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 18:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjKCWHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 18:07:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26B3CF
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 15:07:06 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3Igq87000619;
        Fri, 3 Nov 2023 22:06:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0gCDYWyMupjCSYdZi6Z0Pu/Ss7lkOQ3z5t61ayKmQQM=;
 b=SZ235DvO6m/uhUBZmDhXfDVSDmKk6e0bgzUxRIhpLpG2qgnFWRhIpdG5ms6xFjIDUCmf
 +AXhQSpWUrCdAHD+17CI8sUhDCeptI4kw2tUhGph1JpawFhBvb41jfjaWPQRowQUuXrB
 VJl7UDIsuP+ZmOrULLYWYrGs3TSSah8ZSJuDsXrdrITiFMdRNj3EfHHzjF5D/guhrozT
 dFEBKYWfuzDQb8EEDC6KrjWzRR0NlREhyiXX2XsrWN9G26dE+gNNk06HS3oRJGcSbrq9
 4OP8vqE1MSM1XCoS516HA3hWShCOM4zyhpL1Xd/drr0V2FSGAg2zNHuDPAXeKU3swUyf dg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u4sfta3nf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 22:06:52 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A3M6p6Q020439
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Nov 2023 22:06:51 GMT
Received: from [10.216.13.74] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 3 Nov
 2023 15:06:45 -0700
Message-ID: <981deaf3-c7e2-4bbc-86b8-2151bf0b6e00@quicinc.com>
Date:   Sat, 4 Nov 2023 03:36:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] iommu/arm-smmu: re-enable context caching in smmu
 reset operation
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <a39.skl@gmail.com>, <konrad.dybcio@linaro.org>,
        <quic_saipraka@quicinc.com>, <quic_pkondeti@quicinc.com>,
        <quic_molvera@quicinc.com>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <qipl.kernel.upstream@quicinc.com>
References: <20231103215124.1095-1-quic_bibekkum@quicinc.com>
 <20231103215124.1095-4-quic_bibekkum@quicinc.com>
 <CAA8EJpob0DoXd_UTEiJf8z3JncaWk_1rgit6c4dqQ0gB6JDFxQ@mail.gmail.com>
From:   Bibek Kumar Patro <quic_bibekkum@quicinc.com>
In-Reply-To: <CAA8EJpob0DoXd_UTEiJf8z3JncaWk_1rgit6c4dqQ0gB6JDFxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: W6tAzUGGkiD9vKqC9-s4dkoZMbCMREBP
X-Proofpoint-ORIG-GUID: W6tAzUGGkiD9vKqC9-s4dkoZMbCMREBP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_21,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 adultscore=0 spamscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311030187
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/4/2023 3:28 AM, Dmitry Baryshkov wrote:
> On Fri, 3 Nov 2023 at 23:53, Bibek Kumar Patro
> <quic_bibekkum@quicinc.com> wrote:
>>
>> Context caching is re-enabled in the prefetch buffer for Qualcomm SoCs
>> through SoC specific reset ops, which is disabled in the default MMU-500
>> reset ops, but is expected for context banks using ACTLR register to
>> retain the prefetch value during reset and runtime suspend.
>>
>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
>> ---
>>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 26 ++++++++++++++++++----
>>   1 file changed, 22 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> index 590b7c285299..f342b4778cf1 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> @@ -457,11 +457,29 @@ static int qcom_smmu_def_domain_type(struct device *dev)
>>          return match ? IOMMU_DOMAIN_IDENTITY : 0;
>>   }
>>
>> +#define ARM_MMU500_ACTLR_CPRE          BIT(1)
>> +
>> +static int qcom_smmu500_reset(struct arm_smmu_device *smmu)
>> +{
>> +       int i;
>> +       u32 reg;
>> +
>> +       arm_mmu500_reset(smmu);
>> +
>> +               for (i = 0; i < smmu->num_context_banks; ++i) {
>> +                       reg = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
>> +                       reg |= ARM_MMU500_ACTLR_CPRE;
>> +                       arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_ACTLR, reg);
>> +               }
> 
> Wrong indentation. Did you run your patches through checkpatch.pl?
> 

Yes Dmitry, I did run checkpatch.pl script on this patch as well as 
others, got 0 errors and 0 warnings. With -f option as well. Did not
get any related errors and warnings.

>> +
>> +       return 0;
>> +}
>> +
>>   static int qcom_sdm845_smmu500_reset(struct arm_smmu_device *smmu)
>>   {
>>          int ret;
>>
>> -       arm_mmu500_reset(smmu);
>> +       qcom_smmu500_reset(smmu);
>>
>>          /*
>>           * To address performance degradation in non-real time clients,
>> @@ -488,7 +506,7 @@ static const struct arm_smmu_impl qcom_smmu_500_impl = {
>>          .init_context = qcom_smmu_init_context,
>>          .cfg_probe = qcom_smmu_cfg_probe,
>>          .def_domain_type = qcom_smmu_def_domain_type,
>> -       .reset = arm_mmu500_reset,
>> +       .reset = qcom_smmu500_reset,
>>          .write_s2cr = qcom_smmu_write_s2cr,
>>          .tlb_sync = qcom_smmu_tlb_sync,
>>   };
>> @@ -507,7 +525,7 @@ static const struct arm_smmu_impl sm8550_smmu_500_impl = {
>>          .init_context = qcom_smmu_init_context,
>>          .cfg_probe = qcom_smmu_cfg_probe,
>>          .def_domain_type = qcom_smmu_def_domain_type,
>> -       .reset = arm_mmu500_reset,
>> +       .reset = qcom_smmu500_reset,
>>          .write_s2cr = qcom_smmu_write_s2cr,
>>          .tlb_sync = qcom_smmu_tlb_sync,
>>   };
>> @@ -523,7 +541,7 @@ static const struct arm_smmu_impl qcom_adreno_smmu_v2_impl = {
>>   static const struct arm_smmu_impl qcom_adreno_smmu_500_impl = {
>>          .init_context = qcom_adreno_smmu_init_context,
>>          .def_domain_type = qcom_smmu_def_domain_type,
>> -       .reset = arm_mmu500_reset,
>> +       .reset = qcom_smmu500_reset,
>>          .alloc_context_bank = qcom_adreno_smmu_alloc_context_bank,
>>          .write_sctlr = qcom_adreno_smmu_write_sctlr,
>>          .tlb_sync = qcom_smmu_tlb_sync,
>> --
>> 2.17.1
>>
> 
> 
