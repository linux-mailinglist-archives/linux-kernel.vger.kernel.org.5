Return-Path: <linux-kernel+bounces-21699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF2E8292ED
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 05:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B4BD1F26CD2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 04:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2345381;
	Wed, 10 Jan 2024 04:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZltpDA36"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E10F4689;
	Wed, 10 Jan 2024 04:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40A2S8jq015649;
	Wed, 10 Jan 2024 04:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=5V6c1LzqqYZg8TMxdl30r
	TLW5Ff08OXxDu3yme8YK+0=; b=ZltpDA36jiTLkHsV4xikipJjp/scJIQjx8abb
	ZcMVrpMGwNXf66QpHKCNcDazJQb9b9ykcuzfEwrwEAZr1gHnWMswVgZqx+MuugIB
	VVp3IHH3fuRd4IxDx9JWkJSm5SPPOzDJ76+Lv7sBKDTkSthoiqBcecKlzrgytTfQ
	oNtKkzzd+UKmJ+QVdyfghNcRuOgr7Yxv3OyfGGUqQr6PNaV3BOVIY7183yN7+J9a
	BfrTwfvbf+KsW7KJQLJdM+MqP+CRhGlIYsiTWOWfXzLGinox0hv2qPOv3lXTbSIJ
	nfvMUX3JwFqSewMlRiLq0d4XstYyrv3QfrxupNOnXoHdatGFQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh9evsc0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 04:06:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40A46hFp026739
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 04:06:43 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 20:06:37 -0800
Date: Wed, 10 Jan 2024 09:36:34 +0530
From: Pavan Kondeti <quic_pkondeti@quicinc.com>
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <dmitry.baryshkov@linaro.org>, <konrad.dybcio@linaro.org>,
        <jsnitsel@redhat.com>, <quic_bjorande@quicinc.com>, <mani@kernel.org>,
        <quic_eberman@quicinc.com>, <robdclark@chromium.org>,
        <u.kleine-koenig@pengutronix.de>, <robh@kernel.org>,
        <vladimir.oltean@nxp.com>, <quic_pkondeti@quicinc.com>,
        <quic_molvera@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <qipl.kernel.upstream@quicinc.com>
Subject: Re: [PATCH v7 3/5] iommu/arm-smmu: introduction of ACTLR for custom
 prefetcher settings
Message-ID: <2ad70157-27d1-41df-8866-c226af690cf6@quicinc.com>
References: <20240109114220.30243-1-quic_bibekkum@quicinc.com>
 <20240109114220.30243-4-quic_bibekkum@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240109114220.30243-4-quic_bibekkum@quicinc.com>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Gn6vGfAZGqcs-xlk-Tqt3qmnR_DbkUtU
X-Proofpoint-ORIG-GUID: Gn6vGfAZGqcs-xlk-Tqt3qmnR_DbkUtU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 clxscore=1011 spamscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100031

On Tue, Jan 09, 2024 at 05:12:18PM +0530, Bibek Kumar Patro wrote:
>  static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>  		struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
>  {
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
> +	const struct actlr_variant *actlrvar;
> +	int cbndx = smmu_domain->cfg.cbndx;
>  	struct adreno_smmu_priv *priv;
> 
>  	smmu_domain->cfg.flush_walk_prefer_tlbiasid = true;
> @@ -248,6 +285,16 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>  	priv->set_stall = qcom_adreno_smmu_set_stall;
>  	priv->resume_translation = qcom_adreno_smmu_resume_translation;
> 
> +	if (qsmmu->data->actlrvar) {
> +		actlrvar = qsmmu->data->actlrvar;
> +		for (; actlrvar->io_start; actlrvar++) {
> +			if (actlrvar->io_start == smmu->ioaddr) {
> +				qcom_smmu_set_actlr(dev, smmu, cbndx, actlrvar->actlrcfg);
> +				break;
> +			}
> +		}
> +	}
> +
>  	return 0;
>  }
> 
> @@ -274,6 +321,21 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
>  static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>  		struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
>  {
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
> +	const struct actlr_variant *actlrvar;
> +	int cbndx = smmu_domain->cfg.cbndx;
> +
> +	if (qsmmu->data->actlrvar) {
> +		actlrvar = qsmmu->data->actlrvar;
> +		for (; actlrvar->io_start; actlrvar++) {
> +			if (actlrvar->io_start == smmu->ioaddr) {
> +				qcom_smmu_set_actlr(dev, smmu, cbndx, actlrvar->actlrcfg);
> +				break;
> +			}
> +		}
> +	}
> +

This block and the one in qcom_adreno_smmu_init_context() are exactly
the same. Possible to do some refactoring?

>  	smmu_domain->cfg.flush_walk_prefer_tlbiasid = true;
> 
>  	return 0;
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
> index f3b91963e234..29d26dfa2ed9 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
>  /*
> - * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>   */
> 

It should be 2022-2023 . 

>  #ifndef _ARM_SMMU_QCOM_H
> @@ -24,8 +24,17 @@ struct qcom_smmu_config {
>  	const u32 *reg_offset;
>  };
> 
> +struct actlr_config;
> +
> +struct actlr_variant {
> +	const struct actlr_config *actlrcfg;
> +	const resource_size_t io_start;
> +};
> +
>  struct qcom_smmu_match_data {
> +	const struct actlr_variant *actlrvar;
>  	const struct qcom_smmu_config *cfg;
> +	const int num_smmu;
>  	const struct arm_smmu_impl *impl;
>  	const struct arm_smmu_impl *adreno_impl;
>  };

qcom_smmu_match_data::num_smmu needs cleanup.

Thanks,
Pavan

