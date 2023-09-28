Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DFF7B25B0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 21:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjI1TLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 15:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI1TLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 15:11:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0357A194;
        Thu, 28 Sep 2023 12:11:39 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SJ6JhT010121;
        Thu, 28 Sep 2023 19:11:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=AIHOG+NaEr5BXL8kOCa74F7iEhcke3skrXCjdH4WVB4=;
 b=MvZfvXvcf8XsVgzMKHANJbIZ6I8W0YRjm5Be1I/KyCx3yM62NQrTb1prWrhI0F3gmDd9
 rb1CJdeTUGwMD5IvQDI0bwvPulFVtklSjaJxzw7IJIehc/a9GD0Otr6XMk49QrqYFB1s
 591A7iHYvwbsbqMR9FP8Nsb/R8KxETUG3+01y10gyXD5ij0n+vvma+2j5ViInIL5TcjY
 IjKyPe7qjvvqRbwMOKY7ZaI3FmFvKrPnjSBj8KQqai4rmPH8i4EKAABgiSOa8wH0AOtj
 8hFSTdv0AWv4Cb0VQomcQWJ418K/liyiHgK/KfUrQ7LFTV4bgeiy7+BD04iqEIIDNBDu rQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tdfbrr09f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 19:11:25 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38SJBPbq031225
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 19:11:25 GMT
Received: from [10.110.102.158] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 28 Sep
 2023 12:11:22 -0700
Message-ID: <6e61ea23-ee52-471a-abab-cf930a969a9e@quicinc.com>
Date:   Thu, 28 Sep 2023 12:11:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] firmware: qcom: scm: switch to using the SCM
 allocator
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <kernel@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230928092040.9420-1-brgl@bgdev.pl>
 <20230928092040.9420-4-brgl@bgdev.pl>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20230928092040.9420-4-brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Nodb_byAa3hBUZ5Z4tu735DhPdM48Pnq
X-Proofpoint-GUID: Nodb_byAa3hBUZ5Z4tu735DhPdM48Pnq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_18,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=989 adultscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309280165
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/28/2023 2:20 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> We need to allocate, map and pass a buffer to the trustzone if we have
> more than 4 arguments for a given SCM calls. Let's use the new SCM
> allocator for that memory and shrink the code in process.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>

> ---
>  drivers/firmware/qcom/qcom_scm-smc.c | 21 ++++-----------------
>  1 file changed, 4 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm-smc.c b/drivers/firmware/qcom/qcom_scm-smc.c
> index 16cf88acfa8e..0d5554df1321 100644
> --- a/drivers/firmware/qcom/qcom_scm-smc.c
> +++ b/drivers/firmware/qcom/qcom_scm-smc.c
> @@ -2,6 +2,7 @@
>  /* Copyright (c) 2015,2019 The Linux Foundation. All rights reserved.
>   */
>  
> +#include <linux/cleanup.h>
>  #include <linux/io.h>
>  #include <linux/errno.h>
>  #include <linux/delay.h>
> @@ -152,8 +153,7 @@ int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
>  {
>  	int arglen = desc->arginfo & 0xf;
>  	int i, ret;
> -	dma_addr_t args_phys = 0;
> -	void *args_virt = NULL;
> +	void *args_virt __free(qcom_scm_mem) = NULL;
>  	size_t alloc_len;
>  	gfp_t flag = atomic ? GFP_ATOMIC : GFP_KERNEL;
>  	u32 smccc_call_type = atomic ? ARM_SMCCC_FAST_CALL : ARM_SMCCC_STD_CALL;
> @@ -173,7 +173,7 @@ int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
>  
>  	if (unlikely(arglen > SCM_SMC_N_REG_ARGS)) {
>  		alloc_len = SCM_SMC_N_EXT_ARGS * sizeof(u64);
> -		args_virt = kzalloc(PAGE_ALIGN(alloc_len), flag);
> +		args_virt = qcom_scm_mem_alloc(PAGE_ALIGN(alloc_len), flag);
>  
>  		if (!args_virt)
>  			return -ENOMEM;
> @@ -192,25 +192,12 @@ int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
>  						      SCM_SMC_FIRST_EXT_IDX]);
>  		}
>  
> -		args_phys = dma_map_single(dev, args_virt, alloc_len,
> -					   DMA_TO_DEVICE);
> -
> -		if (dma_mapping_error(dev, args_phys)) {
> -			kfree(args_virt);
> -			return -ENOMEM;
> -		}
> -
> -		smc.args[SCM_SMC_LAST_REG_IDX] = args_phys;
> +		smc.args[SCM_SMC_LAST_REG_IDX] = qcom_scm_mem_to_phys(args_virt);
>  	}
>  
>  	/* ret error check follows after args_virt cleanup*/
>  	ret = __scm_smc_do(dev, &smc, &smc_res, atomic);
>  
> -	if (args_virt) {
> -		dma_unmap_single(dev, args_phys, alloc_len, DMA_TO_DEVICE);
> -		kfree(args_virt);
> -	}
> -
>  	if (ret)
>  		return ret;
>  
