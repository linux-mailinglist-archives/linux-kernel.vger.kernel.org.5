Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3947E2715
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjKFOhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 09:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFOhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:37:00 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCE5BD;
        Mon,  6 Nov 2023 06:36:57 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6CaF7f013641;
        Mon, 6 Nov 2023 14:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ajJTDZCvsoOi74TxOX25WWNiev+l7SDueitgKMP6bSg=;
 b=C7uzaGSYuNn1yRPm1EMBB5b8wazPo37XnscOUBQO7Zc78F9dUB1QrpowoNy3JwES4JrI
 dypQoSEo3zbt4Y9zxUhzZ53VcAIjOMJAa8QlOFwp9IFO+glyOnr8e1g5IxeEusjTO8zM
 e9FXVIxc2minUYSelm2HMOU83paQO2y05HH5RVO+YKx0ufx7mLbbodjU5sMHMy9EDWga
 Rgf21l+aofmLFiKzXcSRmSzmqM4giCGbm2rIDRe5aG48g9JBNRufU3sRMUp50VjTD5nt
 iDS3u3W3QX/N6aios5VDimao0Z3xkSKMSAS7E88/JiiF7gCpThabQv8KHYCMLo/63JWj Vg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u6wer0sud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 14:36:53 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A6EaqWj001210
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Nov 2023 14:36:52 GMT
Received: from [10.216.42.224] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 6 Nov
 2023 06:36:48 -0800
Message-ID: <1b1a81fa-5293-3de0-70c5-eacf7f368311@quicinc.com>
Date:   Mon, 6 Nov 2023 20:06:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/3] remoteproc: qcom: pas: make region assign more
 generic
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231106-topic-sm8650-upstream-remoteproc-v3-0-dbd4cabaeb47@linaro.org>
 <20231106-topic-sm8650-upstream-remoteproc-v3-2-dbd4cabaeb47@linaro.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20231106-topic-sm8650-upstream-remoteproc-v3-2-dbd4cabaeb47@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: p459LGhAuSptdrW6SoDFoVht-sK8syHz
X-Proofpoint-GUID: p459LGhAuSptdrW6SoDFoVht-sK8syHz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_12,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311060118
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/6/2023 1:58 PM, Neil Armstrong wrote:
> The current memory region assign only supports a single
> memory region.
> 
> But new platforms introduces more regions to make the
> memory requirements more flexible for various use cases.
> Those new platforms also shares the memory region between the
> DSP and HLOS.
> 
> To handle this, make the region assign more generic in order
> to support more than a single memory region and also permit
> setting the regions permissions as shared.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/remoteproc/qcom_q6v5_pas.c | 101 ++++++++++++++++++++++++-------------
>   1 file changed, 66 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index 913a5d2068e8..2ea364a04d4c 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -33,6 +33,8 @@
>   
>   #define ADSP_DECRYPT_SHUTDOWN_DELAY_MS	100
>   
> +#define MAX_ASSIGN_COUNT 2
> +
>   struct adsp_data {
>   	int crash_reason_smem;
>   	const char *firmware_name;
> @@ -51,6 +53,9 @@ struct adsp_data {
>   	int ssctl_id;
>   
>   	int region_assign_idx;
> +	int region_assign_count;
> +	bool region_assign_shared;
> +	int region_assign_vmid;
>   };
>   
>   struct qcom_adsp {
> @@ -87,15 +92,18 @@ struct qcom_adsp {
>   	phys_addr_t dtb_mem_phys;
>   	phys_addr_t mem_reloc;
>   	phys_addr_t dtb_mem_reloc;
> -	phys_addr_t region_assign_phys;
> +	phys_addr_t region_assign_phys[MAX_ASSIGN_COUNT];
>   	void *mem_region;
>   	void *dtb_mem_region;
>   	size_t mem_size;
>   	size_t dtb_mem_size;
> -	size_t region_assign_size;
> +	size_t region_assign_size[MAX_ASSIGN_COUNT];
>   
>   	int region_assign_idx;
> -	u64 region_assign_perms;
> +	int region_assign_count;
> +	bool region_assign_shared;
> +	int region_assign_vmid;
> +	u64 region_assign_perms[MAX_ASSIGN_COUNT];
>   
>   	struct qcom_rproc_glink glink_subdev;
>   	struct qcom_rproc_subdev smd_subdev;
> @@ -590,37 +598,53 @@ static int adsp_alloc_memory_region(struct qcom_adsp *adsp)
>   
>   static int adsp_assign_memory_region(struct qcom_adsp *adsp)
>   {
> -	struct reserved_mem *rmem = NULL;
> -	struct qcom_scm_vmperm perm;
> +	struct qcom_scm_vmperm perm[MAX_ASSIGN_COUNT];
>   	struct device_node *node;
> +	unsigned int perm_size;
> +	int offset;
>   	int ret;
>   
>   	if (!adsp->region_assign_idx)
>   		return 0;
>   
> -	node = of_parse_phandle(adsp->dev->of_node, "memory-region", adsp->region_assign_idx);
> -	if (node)
> -		rmem = of_reserved_mem_lookup(node);
> -	of_node_put(node);
> -	if (!rmem) {
> -		dev_err(adsp->dev, "unable to resolve shareable memory-region\n");
> -		return -EINVAL;
> -	}
> +	for (offset = 0; offset < adsp->region_assign_count; ++offset) {
> +		struct reserved_mem *rmem = NULL;
> +
> +		node = of_parse_phandle(adsp->dev->of_node, "memory-region",
> +					adsp->region_assign_idx + offset);
> +		if (node)
> +			rmem = of_reserved_mem_lookup(node);
> +		of_node_put(node);
> +		if (!rmem) {
> +			dev_err(adsp->dev, "unable to resolve shareable memory-region index %d\n",
> +				offset);
> +			return -EINVAL;
> +		}
>   
> -	perm.vmid = QCOM_SCM_VMID_MSS_MSA;
> -	perm.perm = QCOM_SCM_PERM_RW;
> +		if (adsp->region_assign_shared)  {
> +			perm[0].vmid = QCOM_SCM_VMID_HLOS;
> +			perm[0].perm = QCOM_SCM_PERM_RW;
> +			perm[1].vmid = adsp->region_assign_vmid;
> +			perm[1].perm = QCOM_SCM_PERM_RW;
> +			perm_size = 2;
> +		} else {
> +			perm[0].vmid = adsp->region_assign_vmid;
> +			perm[0].perm = QCOM_SCM_PERM_RW;
> +			perm_size = 1;
> +		}
>   
> -	adsp->region_assign_phys = rmem->base;
> -	adsp->region_assign_size = rmem->size;
> -	adsp->region_assign_perms = BIT(QCOM_SCM_VMID_HLOS);
> +		adsp->region_assign_phys[offset] = rmem->base;
> +		adsp->region_assign_size[offset] = rmem->size;
> +		adsp->region_assign_perms[offset] = BIT(QCOM_SCM_VMID_HLOS);
>   
> -	ret = qcom_scm_assign_mem(adsp->region_assign_phys,
> -				  adsp->region_assign_size,
> -				  &adsp->region_assign_perms,
> -				  &perm, 1);
> -	if (ret < 0) {
> -		dev_err(adsp->dev, "assign memory failed\n");
> -		return ret;
> +		ret = qcom_scm_assign_mem(adsp->region_assign_phys[offset],
> +					  adsp->region_assign_size[offset],
> +					  &adsp->region_assign_perms[offset],
> +					  perm, perm_size);
> +		if (ret < 0) {
> +			dev_err(adsp->dev, "assign memory %d failed\n", offset);
> +			return ret;
> +		}
>   	}
>   
>   	return 0;
> @@ -629,20 +653,22 @@ static int adsp_assign_memory_region(struct qcom_adsp *adsp)
>   static void adsp_unassign_memory_region(struct qcom_adsp *adsp)
>   {
>   	struct qcom_scm_vmperm perm;
> -	int ret;
> +	int offset, ret;

one variable per line..

>   
> -	if (!adsp->region_assign_idx)
> +	if (!adsp->region_assign_idx || adsp->region_assign_shared)
>   		return;
>   
> -	perm.vmid = QCOM_SCM_VMID_HLOS;
> -	perm.perm = QCOM_SCM_PERM_RW;
> +	for (offset = 0; offset < adsp->region_assign_count; ++offset) {
> +		perm.vmid = QCOM_SCM_VMID_HLOS;
> +		perm.perm = QCOM_SCM_PERM_RW;
>   
> -	ret = qcom_scm_assign_mem(adsp->region_assign_phys,
> -				  adsp->region_assign_size,
> -				  &adsp->region_assign_perms,
> -				  &perm, 1);
> -	if (ret < 0)
> -		dev_err(adsp->dev, "unassign memory failed\n");
> +		ret = qcom_scm_assign_mem(adsp->region_assign_phys[offset],
> +					  adsp->region_assign_size[offset],
> +					  &adsp->region_assign_perms[offset],
> +					  &perm, 1);
> +		if (ret < 0)
> +			dev_err(adsp->dev, "unassign memory failed\n");

In case you are going to send another version,
you can print offset similar to the assign call failure.,

Otherwise, LGTM.
Feel free to add.
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh

> +	}
>   }
>   
>   static int adsp_probe(struct platform_device *pdev)
> @@ -696,6 +722,9 @@ static int adsp_probe(struct platform_device *pdev)
>   	adsp->info_name = desc->sysmon_name;
>   	adsp->decrypt_shutdown = desc->decrypt_shutdown;
>   	adsp->region_assign_idx = desc->region_assign_idx;
> +	adsp->region_assign_count = min_t(int, MAX_ASSIGN_COUNT, desc->region_assign_count);
> +	adsp->region_assign_vmid = desc->region_assign_vmid;
> +	adsp->region_assign_shared = desc->region_assign_shared;
>   	if (dtb_fw_name) {
>   		adsp->dtb_firmware_name = dtb_fw_name;
>   		adsp->dtb_pas_id = desc->dtb_pas_id;
> @@ -1163,6 +1192,8 @@ static const struct adsp_data sm8550_mpss_resource = {
>   	.sysmon_name = "modem",
>   	.ssctl_id = 0x12,
>   	.region_assign_idx = 2,
> +	.region_assign_count = 1,
> +	.region_assign_vmid = QCOM_SCM_VMID_MSS_MSA,
>   };
>   
>   static const struct of_device_id adsp_of_match[] = {
> 
