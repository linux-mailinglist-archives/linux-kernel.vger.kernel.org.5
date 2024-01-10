Return-Path: <linux-kernel+bounces-21705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6780829307
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 05:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81DB7B25BE6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 04:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194306FB0;
	Wed, 10 Jan 2024 04:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="E104Hi3Q"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EDF28F9;
	Wed, 10 Jan 2024 04:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40A1HKmd023345;
	Wed, 10 Jan 2024 04:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=X63gzUmEEGsbVDOfkQ8Ne
	QKbQcNVWrhZyddVnKT5YCc=; b=E104Hi3Q2gLElgoPVQoObFxpXajBVWPPw3jfJ
	iyIrLDQqSgdnWheZiDAgHqFTQuaHabHXmCGqztsUbY98XQGpMOXVz+R2Bkw5O3HZ
	0cVSGLI6j4spWfRFuLpUM36gyK0fu+EnGVRVrlaHyc08qrmiQLUP35OfeuH1k/L5
	kY4B2dsPikzZyAeK88sATjfIkhpAb94kJekbfXqgI5V4ifbJ7a7P/BCt7QqIC/Mr
	LVOJq8pL225o+2A9JSpJr1VhnY8g/ID1WEgBu3F+C0LojhY3oqlHGD/B5cza1Au+
	X5EsYQSEEQCJQjgTazQ6C7P+P/5fXr7YTPPTXMI8AK8GS7Eig==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhg8g0f9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 04:35:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40A4ZWZb017075
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 04:35:32 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 20:35:25 -0800
Date: Wed, 10 Jan 2024 10:05:22 +0530
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
Subject: Re: [PATCH v7 4/5] iommu/arm-smmu: add ACTLR data and support for
 SM8550
Message-ID: <56742d27-e7ca-43b4-8e26-3391d2056ac2@quicinc.com>
References: <20240109114220.30243-1-quic_bibekkum@quicinc.com>
 <20240109114220.30243-5-quic_bibekkum@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240109114220.30243-5-quic_bibekkum@quicinc.com>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WJJohVTo47dAbAojGS8qNkzH0_ecVfZs
X-Proofpoint-GUID: WJJohVTo47dAbAojGS8qNkzH0_ecVfZs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=960
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100034

On Tue, Jan 09, 2024 at 05:12:19PM +0530, Bibek Kumar Patro wrote:
> +static const struct actlr_variant sm8550_actlr[] = {
> +	{ sm8550_apps_actlr_cfg, 0x15000000 },
> +	{ sm8550_gfx_actlr_cfg, 0x03da0000 },
> +	{},
> +};
> +
>  static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
>  {
>  	return container_of(smmu, struct qcom_smmu, smmu);
> @@ -597,6 +673,14 @@ static const struct qcom_smmu_match_data sdm845_smmu_500_data = {
>  	/* Also no debug configuration. */
>  };
> 
> +
> +static const struct qcom_smmu_match_data sm8550_smmu_500_impl0_data = {
> +	.impl = &qcom_smmu_500_impl,
> +	.adreno_impl = &qcom_adreno_smmu_500_impl,
> +	.cfg = &qcom_smmu_impl0_cfg,
> +	.actlrvar = sm8550_actlr,
> +};
> +

I wish there is Rust like struct update syntax possible here. All we need
here is to update qcom_smmu_match_data::actlrvar member here to the generic
qcom_smmu_500_impl0_data struct data.

>  static const struct qcom_smmu_match_data qcom_smmu_500_impl0_data = {
>  	.impl = &qcom_smmu_500_impl,
>  	.adreno_impl = &qcom_adreno_smmu_500_impl,
> @@ -631,6 +715,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
>  	{ .compatible = "qcom,sm8250-smmu-500", .data = &qcom_smmu_500_impl0_data },
>  	{ .compatible = "qcom,sm8350-smmu-500", .data = &qcom_smmu_500_impl0_data },
>  	{ .compatible = "qcom,sm8450-smmu-500", .data = &qcom_smmu_500_impl0_data },
> +	{ .compatible = "qcom,sm8550-smmu-500", .data = &sm8550_smmu_500_impl0_data },
>  	{ .compatible = "qcom,smmu-500", .data = &qcom_smmu_500_impl0_data },
>  	{ }
>  };

Given that ACTLR data is different across SoCs, would it be a good idea
to decouple it from the qcom_smmu_match_data struct and directly get it
via of_device_is_compatible() from context init functions.  The ACTLR
data will have a compatible string associated with it, we lookup for the
device compatible in this table and select the ACTLR accordingly. This
way, we don't need to add more entries to qcom_smmu_impl_of_match and
keep using the "qcom,smmu-500" for driver match data. 

I have made this suggestion to keep the rule introduced in commit
80b71080720e ("iommu/arm-smmu-qcom: Add generic qcom,smmu-500 match
entry") relavant. I will let Dmitry to provide the guidance here.

Thanks,
Pavan

