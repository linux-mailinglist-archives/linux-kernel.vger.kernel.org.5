Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4337EBFAE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 10:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbjKOJpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 04:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbjKOJpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:45:49 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A884B11C;
        Wed, 15 Nov 2023 01:45:46 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AF9FON0030235;
        Wed, 15 Nov 2023 09:45:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=SnhYnfHeB3cxrsWYIELnF5pFN+u2BcbzLXaHgsjZAVg=;
 b=i5uzYkpWAVYtbefX5KuS3d1pLqLBqVDZpTmf+FkbZQqa4B0sIaMYkFd0gzWXqyZKhcFs
 lZkaoKu1PsiVeJ0ZgdYjYSrrkeu2aXAeYbZyVENiK5Cki11ClHJpBSRCKhPLnKVcFu4e
 g3cuEu8QYI+/toMUySvwrcbRvsPYh6oh+AokIKFhYSyCJT7ktdfZHJlKQJVciqLWTA54
 AruNsu0teBm5DSMlAn3JKVKUSMLEYG0zyfBOtEwmnaX9QtO1UsurjB6uny3thPCgt8W/
 bykdoez1SODzzp56TFazA+HILQTU20FcM/e+ZQAZgGzlwUfXE7voKsZ9scuNRyoG2BS7 Ig== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ucfka9gmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 09:45:25 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AF9jPF3007067
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 09:45:25 GMT
Received: from [10.214.66.253] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 15 Nov
 2023 01:45:20 -0800
Message-ID: <72b30354-0497-45cf-8b71-e4f265eb0005@quicinc.com>
Date:   Wed, 15 Nov 2023 15:15:17 +0530
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
From:   Bibek Kumar Patro <quic_bibekkum@quicinc.com>
In-Reply-To: <CAA8EJpoRmm42aAvyX61o3tMWXszUZmfFvJEtnNDEfYdDqy4Y0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gMeGl_0zgcZ19JZc4iL69MEDlzAKvabo
X-Proofpoint-GUID: gMeGl_0zgcZ19JZc4iL69MEDlzAKvabo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_07,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/14/2023 7:45 PM, Dmitry Baryshkov wrote:
> On Tue, 14 Nov 2023 at 15:57, Bibek Kumar Patro
> <quic_bibekkum@quicinc.com> wrote:
>>
>> Context caching is re-enabled in the prefetch buffer for Qualcomm SoCs
>> through SoC specific reset ops, which is disabled in the default MMU-500
>> reset ops, but is expected for context banks using ACTLR register to
>> retain the prefetch value during reset and runtime suspend.
> 
> Please refer to Documentation/process/submitting-patches.rst and
> rephrase this following the rules there.
> 

Noted, will go through the description once and rephrase it
in next version complying with rules.

>>
>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
>> ---
>>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 25 ++++++++++++++++++----
>>   1 file changed, 21 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> index 0eaf6f2a2e49..fa867b1d9d16 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> @@ -478,11 +478,28 @@ static int qcom_smmu_def_domain_type(struct device *dev)
>>          return match ? IOMMU_DOMAIN_IDENTITY : 0;
>>   }
>>
>> +static int qcom_smmu500_reset(struct arm_smmu_device *smmu)
>> +{
>> +       int i;
>> +       u32 reg;
>> +
>> +       arm_mmu500_reset(smmu);
>> +
>> +       /* Re-enable context caching after reset */
>> +       for (i = 0; i < smmu->num_context_banks; ++i) {
>> +               reg = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
>> +               reg |= CPRE;
>> +               arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_ACTLR, reg);
>> +       }
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
> 
> Is this applicable for sdm845? For all other platforms supported by
> qcom_smmu_500 implementation?
> 

In arm_mmu500_reset operation drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
CPRE bit is reset for all SoC based on mmu500 platform, hence for all 
Qualcomm SoCs including sm845 we are setting back the CPRE bit.

>>
>>          /*
>>           * To address performance degradation in non-real time clients,
>> @@ -509,7 +526,7 @@ static const struct arm_smmu_impl qcom_smmu_500_impl = {
>>          .init_context = qcom_smmu_init_context,
>>          .cfg_probe = qcom_smmu_cfg_probe,
>>          .def_domain_type = qcom_smmu_def_domain_type,
>> -       .reset = arm_mmu500_reset,
>> +       .reset = qcom_smmu500_reset,
>>          .write_s2cr = qcom_smmu_write_s2cr,
>>          .tlb_sync = qcom_smmu_tlb_sync,
>>   };
>> @@ -528,7 +545,7 @@ static const struct arm_smmu_impl sm8550_smmu_500_impl = {
>>          .init_context = qcom_smmu_init_context,
>>          .cfg_probe = qcom_smmu_cfg_probe,
>>          .def_domain_type = qcom_smmu_def_domain_type,
>> -       .reset = arm_mmu500_reset,
>> +       .reset = qcom_smmu500_reset,
>>          .write_s2cr = qcom_smmu_write_s2cr,
>>          .tlb_sync = qcom_smmu_tlb_sync,
>>   };
>> @@ -544,7 +561,7 @@ static const struct arm_smmu_impl qcom_adreno_smmu_v2_impl = {
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
