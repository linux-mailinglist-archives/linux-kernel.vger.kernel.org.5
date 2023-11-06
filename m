Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935697E1A15
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 07:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjKFGMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 01:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjKFGMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 01:12:43 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96E4184
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 22:12:37 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A65nSjg011783;
        Mon, 6 Nov 2023 06:12:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=A2A2XF34aqzAmYIhdZR6gykz5TVfKIuFk54Jfnr/xX4=;
 b=kXhsvbBCTmi0P1F3tJdPaLSZYeSf/aiai4iqyrahhAI8ZxqDRhxYR5Yti+TtoCWdPMHM
 QZz4x/8vdh20FUYKFe3OoP4z0HLuQAgW7e7EISLkvBi7wOQVOjBgUNdb61f7zhPstLr2
 03632u152u9XJIdcKiX+tpoRIue4wa0KQYf1X+LMkbXUJ/Oldts1+O/YZetugy08a3VE
 2yGlQzyjxuK05eAKpLAaLUET5obpZnU3lZTyOgz3eb0RQqD51XGJUaetKqmw6cnXubLL
 D3hqmZtFSzIZq2MTQVUTL5iUbgXzPUs02Sy/GUx4nU95IczY0/axlEXT0RiiUBqvidf0 zg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u5euyu763-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 06:12:23 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A66CMdD008643
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Nov 2023 06:12:22 GMT
Received: from [10.214.227.50] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Sun, 5 Nov
 2023 22:12:16 -0800
Message-ID: <212c4f7f-4b22-4e21-9848-906bbfd69f0e@quicinc.com>
Date:   Mon, 6 Nov 2023 11:42:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] iommu/arm-smmu: introduction of ACTLR for custom
 prefetcher settings
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <a39.skl@gmail.com>, <konrad.dybcio@linaro.org>,
        <quic_saipraka@quicinc.com>, <quic_pkondeti@quicinc.com>,
        <quic_molvera@quicinc.com>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <qipl.kernel.upstream@quicinc.com>
References: <20231103215124.1095-1-quic_bibekkum@quicinc.com>
 <20231103215124.1095-2-quic_bibekkum@quicinc.com>
 <CAA8EJpozPAAaTLwD_0d1_zKh9oNN5tFdSshn2icGFBe7vuMqiA@mail.gmail.com>
From:   Bibek Kumar Patro <quic_bibekkum@quicinc.com>
In-Reply-To: <CAA8EJpozPAAaTLwD_0d1_zKh9oNN5tFdSshn2icGFBe7vuMqiA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _Y7M_aHjhShTifpTK4aiVd8MVZn7y6Lz
X-Proofpoint-ORIG-GUID: _Y7M_aHjhShTifpTK4aiVd8MVZn7y6Lz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_03,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060052
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/4/2023 3:33 AM, Dmitry Baryshkov wrote:
> On Fri, 3 Nov 2023 at 23:53, Bibek Kumar Patro
> <quic_bibekkum@quicinc.com> wrote:
>>
>> Currently in Qualcomm  SoCs the default prefetch is set to 1 which allows
>> the TLB to fetch just the next page table. MMU-500 features ACTLR
>> register which is implementation defined and is used for Qualcomm SoCs
>> to have a prefetch setting of 1/3/7/15 enabling TLB to prefetch
>> the next set of page tables accordingly allowing for faster translations.
>>
>> ACTLR value is unique for each SMR (Stream matching register) and stored
>> in a pre-populated table. This value is set to the register during
>> context bank initialisation.
>>
>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
>> ---
>>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 34 ++++++++++++++++++++++
>>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h |  2 ++
>>   drivers/iommu/arm/arm-smmu/arm-smmu.c      |  5 ++--
>>   drivers/iommu/arm/arm-smmu/arm-smmu.h      |  5 ++++
>>   4 files changed, 44 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> index ae7cae015193..68c1f4908473 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> @@ -14,6 +14,17 @@
>>
>>   #define QCOM_DUMMY_VAL -1
>>
>> +struct actlr_config {
>> +       const struct actlr_data *adata;
>> +       u32 size;
> 
> This should be size_t.
> 
> Also could you please drop the separate struct actlr_config and move
> these two fields into struct qcom_smmu_config.
> 

Ack, will address both these inputs in the next patch.

>> +};
>> +
>> +struct actlr_data {
>> +       u16 sid;
>> +       u16 mask;
>> +       u32 actlr;
>> +};
>> +
>>   static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
>>   {
>>          return container_of(smmu, struct qcom_smmu, smmu);
>> @@ -270,6 +281,26 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
>>   static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>>                  struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
>>   {
>> +       struct arm_smmu_device *smmu = smmu_domain->smmu;
>> +       struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
>> +       const struct actlr_config *actlrcfg;
>> +       struct arm_smmu_smr *smr = smmu->smrs;
>> +       int idx = smmu_domain->cfg.cbndx;
>> +       int i;
>> +       u16 id;
>> +       u16 mask;
>> +
>> +       if (qsmmu->actlrcfg) {
>> +               actlrcfg = qsmmu->actlrcfg;
>> +               for (i = 0; i < actlrcfg->size; ++i) {
>> +                       id = actlrcfg->adata[i].sid;
>> +                       mask = actlrcfg->adata[i].mask;
>> +                       if (!smr_is_subset(*smr, id, mask))
>> +                               arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_ACTLR,
>> +                                               actlrcfg->adata[i].actlr);
>> +               }
>> +       }
> 
> Consider extracting this to a separate function. This way you can
> reduce 4 indentation levels into a single loop.
> 

Ack, thanks for this sugestion. Will move this entire for loop into a 
separate function for simplicity reduced indent levels.

>> +
>>          smmu_domain->cfg.flush_walk_prefer_tlbiasid = true;
>>
>>          return 0;
>> @@ -459,6 +490,9 @@ static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
>>          qsmmu->smmu.impl = impl;
>>          qsmmu->cfg = data->cfg;
>>
>> +       if (data->actlrcfg && (data->actlrcfg->size))
>> +               qsmmu->actlrcfg = data->actlrcfg;
>> +
>>          return &qsmmu->smmu;
>>   }
>>
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
>> index 593910567b88..4b6862715070 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
>> @@ -9,6 +9,7 @@
>>   struct qcom_smmu {
>>          struct arm_smmu_device smmu;
>>          const struct qcom_smmu_config *cfg;
>> +       const struct actlr_config *actlrcfg;
>>          bool bypass_quirk;
>>          u8 bypass_cbndx;
>>          u32 stall_enabled;
>> @@ -25,6 +26,7 @@ struct qcom_smmu_config {
>>   };
>>
>>   struct qcom_smmu_match_data {
>> +       const struct actlr_config *actlrcfg;
>>          const struct qcom_smmu_config *cfg;
>>          const struct arm_smmu_impl *impl;
>>          const struct arm_smmu_impl *adreno_impl;
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> index 4c79ef6f4c75..38ac1cbc799b 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> @@ -992,9 +992,10 @@ static int arm_smmu_find_sme(struct arm_smmu_device *smmu, u16 id, u16 mask)
>>                   * expect simply identical entries for this case, but there's
>>                   * no harm in accommodating the generalisation.
>>                   */
>> -               if ((mask & smrs[i].mask) == mask &&
>> -                   !((id ^ smrs[i].id) & ~smrs[i].mask))
>> +
>> +               if (smr_is_subset(smrs[i], id, mask))
>>                          return i;
>> +
>>                  /*
>>                   * If the new entry has any other overlap with an existing one,
>>                   * though, then there always exists at least one stream ID
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
>> index 703fd5817ec1..b1638bbc41d4 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
>> @@ -501,6 +501,11 @@ static inline void arm_smmu_writeq(struct arm_smmu_device *smmu, int page,
>>                  writeq_relaxed(val, arm_smmu_page(smmu, page) + offset);
>>   }
>>
>> +static inline bool smr_is_subset(struct arm_smmu_smr smrs, u16 id, u16 mask)
>> +{
>> +       return (mask & smrs.mask) == mask && !((id ^ smrs.id) & ~smrs.mask);
>> +}
>> +
>>   #define ARM_SMMU_GR0           0
>>   #define ARM_SMMU_GR1           1
>>   #define ARM_SMMU_CB(s, n)      ((s)->numpage + (n))
>> --
>> 2.17.1
>>
> 
> 
