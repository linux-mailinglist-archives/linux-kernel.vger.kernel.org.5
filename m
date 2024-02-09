Return-Path: <linux-kernel+bounces-59186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD0084F2CE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BDA71C25748
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE6767E87;
	Fri,  9 Feb 2024 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VBQm3cIV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231B567E61;
	Fri,  9 Feb 2024 09:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707472580; cv=none; b=Vb6R/6PBXftZ9Ag+kccywI3/zDBtWOXYdTdlPxdpqJWD3cLV/1V52bM1SADrOZLIk6NAHNoijajK4z7/uhQVomQcq5JhJ9qbKJLq6JVLV14nq8uhCImz2Oq2P92+Ae3ztTxbBDdkm1tffHc4p14nV2rFL/X9sGicaUQ0wjSbF/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707472580; c=relaxed/simple;
	bh=Ab0aSbiPb2khyeqF9YW1Uju3/+zaoMUW5Nbhzd/nTQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=p5bnYrjkCpoVeDa7+qYg4iXWwvJZl4/kjg+FIiqpnsPFPPz1zdVBX1GzPlbijMT8WwXeh3L0xjg0BezijTvM1u07evDu6mlUGEWoamEuWni8p049i8GTvqj8vK/+z9ZKotnvDZyQ+oGMD4EjkK6W10cTLPk7C5fGBvfzoGs/ypY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VBQm3cIV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4199lbCs021745;
	Fri, 9 Feb 2024 09:55:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=a1t7rpfOsO9mP/Kmt4UFW+Uw3U2oSsxMrMCk0RwcIR8=; b=VB
	Qm3cIV27J2OG6XnAJ355I29lQ8OjTNE8IjvbQnOMcoJnK7584f8dHvFM9hhKxJd1
	boP4fUJyLqojkhVylv1JG6Mw5XGhjiJeTrzKu2c3IQ8s3XH3wg4EkOG1aYg6MDer
	plwvYHXZ0TVZqriDyuucQzszjIBh2zVhBNQ3jfqjnFhTkOTtv297BEwo5tz8HTPd
	UZbFKmaC2j2lsoqgO8YxFAT3wbXoGqGSrMoCItoTDE4uS3pw7u7Xy+FuiPoCv+xJ
	uZiFLomnwPgC485Tdh2fVc5/kF1Rp/DQuRFtcix4KzOXI8x+OrgJrnOtvIvm5EVO
	/k21GsHAHRgh5yVjKRLA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4stxkcpn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 09:55:45 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4199tiFs030318
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 9 Feb 2024 09:55:44 GMT
Received: from [10.214.227.50] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 9 Feb
 2024 01:55:37 -0800
Message-ID: <292d65e5-909a-4db6-996b-c2f9be9bcc24@quicinc.com>
Date: Fri, 9 Feb 2024 15:25:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/5] iommu/arm-smmu: introduction of ACTLR for custom
 prefetcher settings
Content-Language: en-US
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <dmitry.baryshkov@linaro.org>, <konrad.dybcio@linaro.org>,
        <jsnitsel@redhat.com>, <quic_bjorande@quicinc.com>, <mani@kernel.org>,
        <quic_eberman@quicinc.com>, <robdclark@chromium.org>,
        <u.kleine-koenig@pengutronix.de>, <robh@kernel.org>,
        <vladimir.oltean@nxp.com>, <quic_pkondeti@quicinc.com>,
        <quic_molvera@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20240123144543.9405-1-quic_bibekkum@quicinc.com>
 <20240123144543.9405-4-quic_bibekkum@quicinc.com>
From: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
In-Reply-To: <20240123144543.9405-4-quic_bibekkum@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FLXBrfEi_m75POgFeA9bHqKEJASaxaa7
X-Proofpoint-ORIG-GUID: FLXBrfEi_m75POgFeA9bHqKEJASaxaa7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_07,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402090071

Hi,

Are there any additional inputs or suggestions on this patch?
Could you let me know please, incase there are any further concerns.
will try to address them.

Thanks & regards,
Bibek

On 1/23/2024 8:15 PM, Bibek Kumar Patro wrote:
> Currently in Qualcomm  SoCs the default prefetch is set to 1 which allows
> the TLB to fetch just the next page table. MMU-500 features ACTLR
> register which is implementation defined and is used for Qualcomm SoCs
> to have a custom prefetch setting enabling TLB to prefetch the next set
> of page tables accordingly allowing for faster translations.
> 
> ACTLR value is unique for each SMR (Stream matching register) and stored
> in a pre-populated table. This value is set to the register during
> context bank initialisation.
> 
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 61 ++++++++++++++++++++++
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h | 16 +++++-
>   drivers/iommu/arm/arm-smmu/arm-smmu.c      |  5 +-
>   drivers/iommu/arm/arm-smmu/arm-smmu.h      |  5 ++
>   4 files changed, 84 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 333daeb18c1c..6004c6d9a7b2 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -215,10 +215,42 @@ static bool qcom_adreno_can_do_ttbr1(struct arm_smmu_device *smmu)
>   	return true;
>   }
> 
> +static void qcom_smmu_set_actlr(struct device *dev, struct arm_smmu_device *smmu, int cbndx,
> +		const struct actlr_config *actlrcfg, const size_t num_actlrcfg)
> +{
> +	struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +	struct arm_smmu_smr *smr;
> +	u16 mask;
> +	int idx;
> +	u16 id;
> +	int i;
> +	int j;
> +
> +	for (i = 0; i < num_actlrcfg; i++) {
> +		id = actlrcfg[i].sid;
> +		mask = actlrcfg[i].mask;
> +
> +		for_each_cfg_sme(cfg, fwspec, j, idx) {
> +			smr = &smmu->smrs[idx];
> +			if (smr_is_subset(smr, id, mask)) {
> +				arm_smmu_cb_write(smmu, cbndx, ARM_SMMU_CB_ACTLR,
> +						actlrcfg[i].actlr);
> +				break;
> +			}
> +		}
> +	}
> +}
> +
>   static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>   		struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
>   {
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
> +	const struct actlr_variant *actlrvar;
> +	int cbndx = smmu_domain->cfg.cbndx;
>   	struct adreno_smmu_priv *priv;
> +	int i;
> 
>   	smmu_domain->cfg.flush_walk_prefer_tlbiasid = true;
> 
> @@ -248,6 +280,18 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>   	priv->set_stall = qcom_adreno_smmu_set_stall;
>   	priv->resume_translation = qcom_adreno_smmu_resume_translation;
> 
> +	actlrvar = qsmmu->data->actlrvar;
> +	if (!actlrvar)
> +		return 0;
> +
> +	for (i = 0; i < qsmmu->data->num_smmu ; i++) {
> +		if (actlrvar[i].io_start == smmu->ioaddr) {
> +			qcom_smmu_set_actlr(dev, smmu, cbndx, actlrvar[i].actlrcfg,
> +				       actlrvar[i].num_actlrcfg);
> +			break;
> +		}
> +	}
> +
>   	return 0;
>   }
> 
> @@ -274,7 +318,24 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
>   static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>   		struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
>   {
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
> +	const struct actlr_variant *actlrvar;
> +	int cbndx = smmu_domain->cfg.cbndx;
> +	int i;
> +
>   	smmu_domain->cfg.flush_walk_prefer_tlbiasid = true;
> +	actlrvar = qsmmu->data->actlrvar;
> +	if (!actlrvar)
> +		return 0;
> +
> +	for (i = 0; i < qsmmu->data->num_smmu ; i++) {
> +		if (actlrvar[i].io_start == smmu->ioaddr) {
> +			qcom_smmu_set_actlr(dev, smmu, cbndx, actlrvar[i].actlrcfg,
> +				       actlrvar[i].num_actlrcfg);
> +			break;
> +		}
> +	}
> 
>   	return 0;
>   }
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
> index f3b91963e234..3f651242de7c 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
> @@ -1,6 +1,6 @@
>   /* SPDX-License-Identifier: GPL-2.0-only */
>   /*
> - * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2022-2023, Qualcomm Innovation Center, Inc. All rights reserved.
>    */
> 
>   #ifndef _ARM_SMMU_QCOM_H
> @@ -24,8 +24,22 @@ struct qcom_smmu_config {
>   	const u32 *reg_offset;
>   };
> 
> +struct actlr_config {
> +	u16 sid;
> +	u16 mask;
> +	u32 actlr;
> +};
> +
> +struct actlr_variant {
> +	const resource_size_t io_start;
> +	const struct actlr_config * const actlrcfg;
> +	const size_t num_actlrcfg;
> +};
> +
>   struct qcom_smmu_match_data {
> +	const struct actlr_variant * const actlrvar;
>   	const struct qcom_smmu_config *cfg;
> +	const size_t num_smmu;
>   	const struct arm_smmu_impl *impl;
>   	const struct arm_smmu_impl *adreno_impl;
>   };
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index d6d1a2a55cc0..0c7f700b27dd 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -990,9 +990,10 @@ static int arm_smmu_find_sme(struct arm_smmu_device *smmu, u16 id, u16 mask)
>   		 * expect simply identical entries for this case, but there's
>   		 * no harm in accommodating the generalisation.
>   		 */
> -		if ((mask & smrs[i].mask) == mask &&
> -		    !((id ^ smrs[i].id) & ~smrs[i].mask))
> +
> +		if (smr_is_subset(&smrs[i], id, mask))
>   			return i;
> +
>   		/*
>   		 * If the new entry has any other overlap with an existing one,
>   		 * though, then there always exists at least one stream ID
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> index 703fd5817ec1..2e4f65412c6b 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> @@ -501,6 +501,11 @@ static inline void arm_smmu_writeq(struct arm_smmu_device *smmu, int page,
>   		writeq_relaxed(val, arm_smmu_page(smmu, page) + offset);
>   }
> 
> +static inline bool smr_is_subset(struct arm_smmu_smr *smrs, u16 id, u16 mask)
> +{
> +	return (mask & smrs->mask) == mask && !((id ^ smrs->id) & ~smrs->mask);
> +}
> +
>   #define ARM_SMMU_GR0		0
>   #define ARM_SMMU_GR1		1
>   #define ARM_SMMU_CB(s, n)	((s)->numpage + (n))
> --
> 2.17.1
> 

