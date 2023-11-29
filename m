Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904B67FD5F9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjK2Lrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjK2Lrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:47:35 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0918784;
        Wed, 29 Nov 2023 03:47:40 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT6TUGH029956;
        Wed, 29 Nov 2023 11:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PRkDXyYxUN+epgRlp9Gxs5pkKmtQ9d0GvJ3wxnx/ZcI=;
 b=M6yfliDnEbaENNsE5nVSNaoZeKk0QMAi0R4DQcYSeOSkP2niCxyD/wbIZ2NzAmoQiIan
 Oxf7qDSB8Oyk/FWQmCp3EfGJpTFFoq3t7YTDZcZaOL4s+bfZ6rxFTu88UE2h4PsJX4Nd
 rOw0dKWq/nl+1RlEzxCRerHhekxDkrK17OpKUa+9CmIs1COjA1JYNX3pHg93UdBcfUYN
 PIgxG4vMaz6gHkkUUzxMILLifC060lWqbul2pk35jm5i6kcEmOB0iozx0gCnmfOA/p1D
 /nZqeY7JKwP4cS8P/+Pprsdt0TssOfR5DRcIGZmD9Ta9HUcfHdrm2zrYEqG2SwABupFq IA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3up02xrs58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 11:47:20 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ATBlIO3030168
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 11:47:18 GMT
Received: from [10.214.66.253] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 29 Nov
 2023 03:47:12 -0800
Message-ID: <26227b9e-e604-43a4-b9ca-949842330009@quicinc.com>
Date:   Wed, 29 Nov 2023 17:17:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] iommu/arm-smmu: introduction of ACTLR for custom
 prefetcher settings
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <joro@8bytes.org>,
        <dmitry.baryshkov@linaro.org>, <a39.skl@gmail.com>,
        <quic_bjorande@quicinc.com>, <mani@kernel.org>,
        <quic_eberman@quicinc.com>, <robdclark@chromium.org>,
        <u.kleine-koenig@pengutronix.de>, <robh@kernel.org>,
        <vladimir.oltean@nxp.com>, <quic_pkondeti@quicinc.com>,
        <quic_molvera@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <qipl.kernel.upstream@quicinc.com>
References: <20231127145412.3981-1-quic_bibekkum@quicinc.com>
 <20231127145412.3981-2-quic_bibekkum@quicinc.com>
 <cfbf33cd-0faf-47c6-8e0f-b13c088670df@linaro.org>
From:   Bibek Kumar Patro <quic_bibekkum@quicinc.com>
In-Reply-To: <cfbf33cd-0faf-47c6-8e0f-b13c088670df@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: E-WKoFgOLDezuQBIbLehdFLAGP4lWBsX
X-Proofpoint-GUID: E-WKoFgOLDezuQBIbLehdFLAGP4lWBsX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_09,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311290088
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/27/2023 9:03 PM, Konrad Dybcio wrote:
> On 27.11.2023 15:54, Bibek Kumar Patro wrote:
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
>>   #define QCOM_DUMMY_VAL	-1
>>
>> +struct actlr_config {
>> +	u16 sid;
>> +	u16 mask;
>> +	u32 actlr;
>> +};
>> +
>>   static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
>>   {
>>   	return container_of(smmu, struct qcom_smmu, smmu);
>> @@ -205,10 +211,40 @@ static bool qcom_adreno_can_do_ttbr1(struct arm_smmu_device *smmu)
>>   	return true;
>>   }
>>
>> +static void arm_smmu_set_actlr(struct device *dev, struct arm_smmu_device *smmu, int cbndx,
>> +		const struct actlr_config *actlrcfg, size_t actlrcfg_size)
>> +{
>> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>> +	struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
>> +	struct arm_smmu_smr *smr;
>> +	int i;
>> +	int j;
>> +	u16 id;
>> +	u16 mask;
>> +	int idx;
>> +
>> +	for (i = 0; i < actlrcfg_size; ++i) {
>> +		id = (actlrcfg + i)->sid;
>> +		mask = (actlrcfg + i)->mask;
> actrlcfg[i].id?
> 

Noted, array indexing instead of incrementing the base address
should also work.

>> +
>> +		for_each_cfg_sme(cfg, fwspec, j, idx) {
>> +			smr = &smmu->smrs[idx];
>> +			if (smr_is_subset(*smr, id, mask))
> Any reason for this value to be a pointer?
> 
>> +				arm_smmu_cb_write(smmu, cbndx, ARM_SMMU_CB_ACTLR,
>> +						(actlrcfg + i)->actlr);
> ditto
> 

Noted

>> +		}
>> +	}
>> +}
>> +
>>   static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>>   		struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
>>   {
>>   	struct adreno_smmu_priv *priv;
>> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
>> +	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
>> +	const struct actlr_config *actlrcfg;
>> +	size_t actlrcfg_size;
>> +	int cbndx = smmu_domain->cfg.cbndx;
> Reverse-Christmas-tree sorting, please
> 

Noted, thanks for pointing this, I will
take care of this in next revision.

>>
>>   	smmu_domain->cfg.flush_walk_prefer_tlbiasid = true;
>>
>> @@ -238,6 +274,12 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>>   	priv->set_stall = qcom_adreno_smmu_set_stall;
>>   	priv->resume_translation = qcom_adreno_smmu_resume_translation;
>>
>> +	if (qsmmu->data->actlrcfg_gfx) {
>> +		actlrcfg = qsmmu->data->actlrcfg_gfx;
>> +		actlrcfg_size = qsmmu->data->actlrcfg_gfx_size;
> These can be passed directly s arm_smmu_set_actrl arguments
> 

Noted, will address in next revision. since there won't be any issue 
during time of access, I can pass these values directly.

>> +		arm_smmu_set_actlr(dev, smmu, cbndx, actlrcfg, actlrcfg_size);
>> +	}
>> +
>>   	return 0;
>>   }
>>
>> @@ -263,6 +305,18 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
>>   static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>>   		struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
>>   {
>> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
>> +	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
>> +	const struct actlr_config *actlrcfg;
>> +	size_t actlrcfg_size;
>> +	int cbndx = smmu_domain->cfg.cbndx;
>> +
>> +	if (qsmmu->data->actlrcfg) {
>> +		actlrcfg = qsmmu->data->actlrcfg;
>> +		actlrcfg_size = qsmmu->data->actlrcfg_size;
>> +		arm_smmu_set_actlr(dev, smmu, cbndx, actlrcfg, actlrcfg_size);
> ditto
>
Noted.

> Konrad
