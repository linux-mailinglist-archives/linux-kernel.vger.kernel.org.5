Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4CE7FD63E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 13:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjK2MEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 07:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbjK2MEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 07:04:38 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A24BD7E;
        Wed, 29 Nov 2023 04:04:42 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT87Ecd014702;
        Wed, 29 Nov 2023 12:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Uwm9mjt4TPl0GXRCZXs3iqmTDh9JZ4oA+QQf74ndj8k=;
 b=pZlZgZnXdwZQuB2mVaWhNfqrYg03Ev/v9m5ZrxIiKgg89dlZsDDYJiDOsuaoi5W0+d2/
 ew/OULDYZOrwzsPMXxmGeSFTPviSq38DbL9lrIl12pv17Wf4tx3czNwEdJ0S6MycNU03
 bX2i18ZGOPDHz+9hbaELpb8k6yPF1gg4F4k/KAbmtoCfKqRB5FecTXElUI4HI23O0KMG
 uOpiZbxb4g77sHqLP1gHCp9cHlrIvAG4mkEH9Y2AWGTp/lLTZxegDEF5Ie7TbDnXQShA
 TdcvNajmrwiUd+mVy38CzVKVaXZuaM8SwLS6UABQNbJSjqZlMt8tABl67eWyV8jWyGiX SQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3up1gt8gp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 12:04:15 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ATC4EA4019878
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 12:04:14 GMT
Received: from [10.214.66.253] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 29 Nov
 2023 04:04:09 -0800
Message-ID: <14d82eb4-79de-4f26-8b8e-c60a28e3fb7d@quicinc.com>
Date:   Wed, 29 Nov 2023 17:34:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] iommu/arm-smmu: introduction of ACTLR for custom
 prefetcher settings
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <a39.skl@gmail.com>, <konrad.dybcio@linaro.org>,
        <quic_bjorande@quicinc.com>, <mani@kernel.org>,
        <quic_eberman@quicinc.com>, <robdclark@chromium.org>,
        <u.kleine-koenig@pengutronix.de>, <robh@kernel.org>,
        <vladimir.oltean@nxp.com>, <quic_pkondeti@quicinc.com>,
        <quic_molvera@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <qipl.kernel.upstream@quicinc.com>
References: <20231127145412.3981-1-quic_bibekkum@quicinc.com>
 <20231127145412.3981-2-quic_bibekkum@quicinc.com>
 <CAA8EJppKp0nVX-w4OmPKq0BSb_eWs6XpeuFbMobWT3tC2RNG7A@mail.gmail.com>
From:   Bibek Kumar Patro <quic_bibekkum@quicinc.com>
In-Reply-To: <CAA8EJppKp0nVX-w4OmPKq0BSb_eWs6XpeuFbMobWT3tC2RNG7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9B_ARn7VxG6IUYvHxgUd19BPZURnrGFc
X-Proofpoint-ORIG-GUID: 9B_ARn7VxG6IUYvHxgUd19BPZURnrGFc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_09,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311290090
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/27/2023 9:37 PM, Dmitry Baryshkov wrote:
> On Mon, 27 Nov 2023 at 16:54, Bibek Kumar Patro
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
>>
>> ---
>>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 56 +++++++++++++++++++++-
>>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h |  6 ++-
>>   drivers/iommu/arm/arm-smmu/arm-smmu.c      |  5 +-
>>   drivers/iommu/arm/arm-smmu/arm-smmu.h      |  5 ++
>>   4 files changed, 68 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> index 7f52ac67495f..4a38cae29be2 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> @@ -14,6 +14,12 @@
>>
>>   #define QCOM_DUMMY_VAL -1
>>
>> +struct actlr_config {
>> +       u16 sid;
>> +       u16 mask;
>> +       u32 actlr;
>> +};
>> +
>>   static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
>>   {
>>          return container_of(smmu, struct qcom_smmu, smmu);
>> @@ -205,10 +211,40 @@ static bool qcom_adreno_can_do_ttbr1(struct arm_smmu_device *smmu)
>>          return true;
>>   }
>>
>> +static void arm_smmu_set_actlr(struct device *dev, struct arm_smmu_device *smmu, int cbndx,
>> +               const struct actlr_config *actlrcfg, size_t actlrcfg_size)
>> +{
>> +       struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>> +       struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
>> +       struct arm_smmu_smr *smr;
>> +       int i;
>> +       int j;
>> +       u16 id;
>> +       u16 mask;
>> +       int idx;
>> +
>> +       for (i = 0; i < actlrcfg_size; ++i) {
>> +               id = (actlrcfg + i)->sid;
>> +               mask = (actlrcfg + i)->mask;
>> +
>> +               for_each_cfg_sme(cfg, fwspec, j, idx) {
>> +                       smr = &smmu->smrs[idx];
>> +                       if (smr_is_subset(*smr, id, mask))
>> +                               arm_smmu_cb_write(smmu, cbndx, ARM_SMMU_CB_ACTLR,
>> +                                               (actlrcfg + i)->actlr);
>> +               }
>> +       }
>> +}
>> +
>>   static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>>                  struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
>>   {
>>          struct adreno_smmu_priv *priv;
>> +       struct arm_smmu_device *smmu = smmu_domain->smmu;
>> +       struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
>> +       const struct actlr_config *actlrcfg;
>> +       size_t actlrcfg_size;
>> +       int cbndx = smmu_domain->cfg.cbndx;
>>
>>          smmu_domain->cfg.flush_walk_prefer_tlbiasid = true;
>>
>> @@ -238,6 +274,12 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>>          priv->set_stall = qcom_adreno_smmu_set_stall;
>>          priv->resume_translation = qcom_adreno_smmu_resume_translation;
>>
>> +       if (qsmmu->data->actlrcfg_gfx) {
>> +               actlrcfg = qsmmu->data->actlrcfg_gfx;
>> +               actlrcfg_size = qsmmu->data->actlrcfg_gfx_size;
>> +               arm_smmu_set_actlr(dev, smmu, cbndx, actlrcfg, actlrcfg_size);
>> +       }
>> +
>>          return 0;
>>   }
>>
>> @@ -263,6 +305,18 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
>>   static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>>                  struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
>>   {
>> +       struct arm_smmu_device *smmu = smmu_domain->smmu;
>> +       struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
>> +       const struct actlr_config *actlrcfg;
>> +       size_t actlrcfg_size;
>> +       int cbndx = smmu_domain->cfg.cbndx;
>> +
>> +       if (qsmmu->data->actlrcfg) {
>> +               actlrcfg = qsmmu->data->actlrcfg;
>> +               actlrcfg_size = qsmmu->data->actlrcfg_size;
>> +               arm_smmu_set_actlr(dev, smmu, cbndx, actlrcfg, actlrcfg_size);
>> +       }
>> +
>>          smmu_domain->cfg.flush_walk_prefer_tlbiasid = true;
>>
>>          return 0;
>> @@ -464,7 +518,7 @@ static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
>>                  return ERR_PTR(-ENOMEM);
>>
>>          qsmmu->smmu.impl = impl;
>> -       qsmmu->cfg = data->cfg;
>> +       qsmmu->data = data;
> 
> This should go to a separate commit. It is not related to ACTLR support

qsmmu->data has the actlrcfg/actlrcfg_gfx as well hence clubbed this 
change here as rightly suggested by Robin[1] on v2 revision.
Initially planned[2] for separate patch, but later clubbing it with 
actlr patch looked like a cleaner approach.
Would it be okay to keep it here? Or separate patch would be better?

[1]:https://lore.kernel.org/all/c75d107a-44cb-4df3-b583-13719df1f8be@arm.com/
[2]:https://lore.kernel.org/all/9b406a7c-57b8-4b5f-8fbc-714560cce8cf@quicinc.com/
> 
>>
>>          return &qsmmu->smmu;
>>   }
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
>> index 593910567b88..138fc57f7b0d 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
>> @@ -8,7 +8,7 @@
>>
>>   struct qcom_smmu {
>>          struct arm_smmu_device smmu;
>> -       const struct qcom_smmu_config *cfg;
>> +       const struct qcom_smmu_match_data *data;
>>          bool bypass_quirk;
>>          u8 bypass_cbndx;
>>          u32 stall_enabled;
>> @@ -25,6 +25,10 @@ struct qcom_smmu_config {
>>   };
>>
>>   struct qcom_smmu_match_data {
>> +       const struct actlr_config *actlrcfg;
>> +       size_t actlrcfg_size;
>> +       const struct actlr_config *actlrcfg_gfx;
>> +       size_t actlrcfg_gfx_size;
>>          const struct qcom_smmu_config *cfg;
>>          const struct arm_smmu_impl *impl;
>>          const struct arm_smmu_impl *adreno_impl;
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> index d6d1a2a55cc0..8e4faf015286 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> @@ -990,9 +990,10 @@ static int arm_smmu_find_sme(struct arm_smmu_device *smmu, u16 id, u16 mask)
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
> 
> A pointer to the struct, please
> 
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
