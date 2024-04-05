Return-Path: <linux-kernel+bounces-132611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814F5899740
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C536BB230F3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128C3144D25;
	Fri,  5 Apr 2024 07:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Xva5yxkS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5AB1448D2;
	Fri,  5 Apr 2024 07:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712303882; cv=none; b=fAlVnNc7nuItVw+WfqzsIw8BgcnBIKZ5ZnLIRb7cepjbdlXC9dkwRtymJlPjQ6ZNKNBNFb6qVnl04VALu8/poFxMYw8B8b0jhWeF46JTPrTbfVUlQnwVpb7Oc2cP5f5HVa3daAa4Do2gaD/bclLOK3AVbHCIR/Zg+ocnl1vOWnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712303882; c=relaxed/simple;
	bh=QPeaqrXLrcoPzty4QKGNJ02/h1YxuWlKxNuyE7pI/NE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JsKqCINWMGfgBajytbraAXD6LwtRBXKJV5RQYhfKNaNK98FECEJFY2azGrwuxZ4SobVwZzjxqOtSnrp0HHusTadNL945M6bqjisoarG4iY7x3Kpb2BxMbfeIBZ220mGSbZb2MoL4AXiSRmfxQyp3XlMRUDJSGIfrPQD4NCAdj9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Xva5yxkS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4357lg0t010170;
	Fri, 5 Apr 2024 07:57:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=snMX5+Rngg16+FdyyLyC+UxDxRxj3blXtYJrMQOj3xY=; b=Xv
	a5yxkSXRuI2Z3Udgp5137oMvwxcm+FV5bYp/QsXG1khl7g6C38aiM+BIHwThN+5H
	uxC1bGVb2ymct64b4kcNhXzeEFRdvcut6qlOmhCrdnRDM1Rgka9TgBb2PW2FOFzn
	mwEhOn7hlUsuMd5roIiwlTQr8eb9E/FHbi2x0nJBhKMxcUBzou5ovK64sLUA5VDi
	yTflQETSjONcpAoNl5pdxT3GlnTF/NUFphLKIm7GiAHqI9lrkmy92YYWHvx/yP4x
	uA0n0YQB1b3hKlNJQjy+uklN5m7+V/KDJJRlZ4u+fTL5fCwyAbP0mgzLLUlPtcI+
	Cn0061LIUpwV+i0aZ1cw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xad7h00qt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 07:57:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4357vAwh023826
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 07:57:10 GMT
Received: from [10.216.11.24] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Apr 2024
 00:57:05 -0700
Message-ID: <45d33da0-0e78-8dfd-bb45-315380372e3e@quicinc.com>
Date: Fri, 5 Apr 2024 13:27:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 09/19] media: venus: core: Drop cache properties in
 resource struct
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov
	<stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross
	<agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Mauro Carvalho
 Chehab" <mchehab@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC: Marijn Suijten <marijn.suijten@somainline.org>,
        Stanimir Varbanov
	<stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab
	<mchehab+huawei@kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230911-topic-mars-v3-0-79f23b81c261@linaro.org>
 <20230911-topic-mars-v3-9-79f23b81c261@linaro.org>
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <20230911-topic-mars-v3-9-79f23b81c261@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: W_VLBR0lca8b3ZFBWUc-exjaOIuUb614
X-Proofpoint-ORIG-GUID: W_VLBR0lca8b3ZFBWUc-exjaOIuUb614
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_07,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050057



On 3/27/2024 11:38 PM, Konrad Dybcio wrote:
> Currently VMEM/OCMEM/LLCC is disabled on all platforms.
> 
> Make it unconditional to save on space.
> 
> These caches will not be enabled until the Venus driver can reference
> them as chunks of SRAM (they're modelled as separate devices) to avoid
> hardcoding magic addresses and rougely accessing the hardware,
> bypassing the normal accessors.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/core.c      | 24 ------------------------
>  drivers/media/platform/qcom/venus/core.h      |  3 ---
>  drivers/media/platform/qcom/venus/hfi_venus.c | 10 ++++------
>  3 files changed, 4 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 26a0c264685a..51ac9eff244c 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -562,9 +562,6 @@ static const struct venus_resources msm8916_res = {
>  	.clks_num = 3,
>  	.max_load = 352800, /* 720p@30 + 1080p@30 */
>  	.hfi_version = HFI_VERSION_1XX,
> -	.vmem_id = VIDC_RESOURCE_NONE,
> -	.vmem_size = 0,
> -	.vmem_addr = 0,
>  	.dma_mask = 0xddc00000 - 1,
>  	.fwname = "qcom/venus-1.8/venus.mbn",
>  };
> @@ -595,9 +592,6 @@ static const struct venus_resources msm8996_res = {
>  	.vcodec_clks_num = 1,
>  	.max_load = 2563200,
>  	.hfi_version = HFI_VERSION_3XX,
> -	.vmem_id = VIDC_RESOURCE_NONE,
> -	.vmem_size = 0,
> -	.vmem_addr = 0,
>  	.dma_mask = 0xddc00000 - 1,
>  	.fwname = "qcom/venus-4.2/venus.mbn",
>  };
> @@ -653,9 +647,6 @@ static const struct venus_resources sdm660_res = {
>  	.vcodec_clks_num = 1,
>  	.max_load = 1036800,
>  	.hfi_version = HFI_VERSION_3XX,
> -	.vmem_id = VIDC_RESOURCE_NONE,
> -	.vmem_size = 0,
> -	.vmem_addr = 0,
>  	.cp_start = 0,
>  	.cp_size = 0x79000000,
>  	.cp_nonpixel_start = 0x1000000,
> @@ -702,9 +693,6 @@ static const struct venus_resources sdm845_res = {
>  	.max_load = 3110400,	/* 4096x2160@90 */
>  	.hfi_version = HFI_VERSION_4XX,
>  	.vpu_version = VPU_VERSION_AR50,
> -	.vmem_id = VIDC_RESOURCE_NONE,
> -	.vmem_size = 0,
> -	.vmem_addr = 0,
>  	.dma_mask = 0xe0000000 - 1,
>  	.fwname = "qcom/venus-5.2/venus.mbn",
>  };
> @@ -727,9 +715,6 @@ static const struct venus_resources sdm845_res_v2 = {
>  	.max_load = 3110400,	/* 4096x2160@90 */
>  	.hfi_version = HFI_VERSION_4XX,
>  	.vpu_version = VPU_VERSION_AR50,
> -	.vmem_id = VIDC_RESOURCE_NONE,
> -	.vmem_size = 0,
> -	.vmem_addr = 0,
>  	.dma_mask = 0xe0000000 - 1,
>  	.cp_start = 0,
>  	.cp_size = 0x70800000,
> @@ -774,9 +759,6 @@ static const struct venus_resources sc7180_res = {
>  	.opp_pmdomain = pd_names_cx,
>  	.hfi_version = HFI_VERSION_4XX,
>  	.vpu_version = VPU_VERSION_AR50,
> -	.vmem_id = VIDC_RESOURCE_NONE,
> -	.vmem_size = 0,
> -	.vmem_addr = 0,
>  	.dma_mask = 0xe0000000 - 1,
>  	.cp_start = 0,
>  	.cp_size = 0x70800000,
> @@ -832,9 +814,6 @@ static const struct venus_resources sm8250_res = {
>  	.hfi_version = HFI_VERSION_6XX,
>  	.vpu_version = VPU_VERSION_IRIS2,
>  	.num_vpp_pipes = 4,
> -	.vmem_id = VIDC_RESOURCE_NONE,
> -	.vmem_size = 0,
> -	.vmem_addr = 0,
>  	.dma_mask = 0xe0000000 - 1,
>  	.fwname = "qcom/vpu-1.0/venus.mbn",
>  };
> @@ -889,9 +868,6 @@ static const struct venus_resources sc7280_res = {
>  	.hfi_version = HFI_VERSION_6XX,
>  	.vpu_version = VPU_VERSION_IRIS2_1,
>  	.num_vpp_pipes = 1,
> -	.vmem_id = VIDC_RESOURCE_NONE,
> -	.vmem_size = 0,
> -	.vmem_addr = 0,
>  	.dma_mask = 0xe0000000 - 1,
>  	.cp_start = 0,
>  	.cp_size = 0x25800000,
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> index 376de1161114..e083ebb3ab4b 100644
> --- a/drivers/media/platform/qcom/venus/core.h
> +++ b/drivers/media/platform/qcom/venus/core.h
> @@ -80,9 +80,6 @@ struct venus_resources {
>  	enum vpu_version vpu_version;
>  	u8 num_vpp_pipes;
>  	u32 max_load;
> -	unsigned int vmem_id;
> -	u32 vmem_size;
> -	u32 vmem_addr;
>  	u32 cp_start;
>  	u32 cp_size;
>  	u32 cp_nonpixel_start;
> diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
> index f9437b6412b9..42ff96f71235 100644
> --- a/drivers/media/platform/qcom/venus/hfi_venus.c
> +++ b/drivers/media/platform/qcom/venus/hfi_venus.c
> @@ -1067,17 +1067,14 @@ static void venus_process_msg_sys_error(struct venus_hfi_device *hdev,
>  static irqreturn_t venus_isr_thread(struct venus_core *core)
>  {
>  	struct venus_hfi_device *hdev = to_hfi_priv(core);
> -	const struct venus_resources *res;
>  	void *pkt;
>  	u32 msg_ret;
>  
>  	if (!hdev)
>  		return IRQ_NONE;
>  
> -	res = hdev->core->res;
>  	pkt = hdev->pkt_buf;
>  
> -
>  	while (!venus_iface_msgq_read(hdev, pkt)) {
>  		msg_ret = hfi_process_msg_packet(core, pkt);
>  		switch (msg_ret) {
> @@ -1085,9 +1082,10 @@ static irqreturn_t venus_isr_thread(struct venus_core *core)
>  			venus_process_msg_sys_error(hdev, pkt);
>  			break;
>  		case HFI_MSG_SYS_INIT:
> -			venus_hfi_core_set_resource(core, res->vmem_id,
> -						    res->vmem_size,
> -						    res->vmem_addr,
> +			/* Disable OCMEM/VMEM unconditionally until support is added */
> +			venus_hfi_core_set_resource(core, VIDC_RESOURCE_NONE,
> +						    0,
> +						    0,
>  						    hdev);
>  			break;
>  		case HFI_MSG_SYS_RELEASE_RESOURCE:
> 
If no issues reported by firmware on any SOC, then
Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>

