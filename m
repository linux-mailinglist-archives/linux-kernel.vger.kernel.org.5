Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64827DA42D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 01:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346730AbjJ0XpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 19:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjJ0XpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 19:45:06 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDBD1A6;
        Fri, 27 Oct 2023 16:45:03 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RNfkUM028026;
        Fri, 27 Oct 2023 23:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=c9PIn6lHD+cLYe39pvFrFAEM2DgtAJIi5azUDnIU2VE=;
 b=oW15LuM/eqllPF9VQaLjxZmXgDWgG5FKyBPmb5bRcagoJJQukucwe5WhVrGaifZpzQDV
 ta4ZSgZ9eQJ7CHSKRK8PXkzx3aWqTWoKMS7m7vYxJ+512QmFMEdyFX4YGiMU+xNU8ZJ5
 3AmbAb4mnQS1WWalbVL97wkDCAmfk67BJKZVhEba2z5dQ9am8CqhndO9DV+4AwWSAQIr
 5jRrBMyq2DLBvqdpPADeqGjiKKPqD3k3cvAb2aY6Y7g/IWtkgWd9r3ie0Hbsr6uVoE10
 L/4OuqESb7/BEN+/qpYoyUOANWYRsy7naloOCVJOUwW4f3l92B+avyVTKO7Ka1Hdtn3I PQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tyxbvbbhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 23:44:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39RNivmo031545
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 23:44:57 GMT
Received: from [10.48.246.67] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 27 Oct
 2023 16:44:54 -0700
Message-ID: <3f5f42e5-265f-40f1-af38-7057622270d2@quicinc.com>
Date:   Fri, 27 Oct 2023 16:44:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: qcom-scm: Support multiple waitq contexts
Content-Language: en-US
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>
References: <20231027-multi-wqs-v1-1-d47cd7f3590f@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231027-multi-wqs-v1-1-d47cd7f3590f@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QFJ6un_DQNIvBlsL4SrXMP3XueBkq4Zj
X-Proofpoint-GUID: QFJ6un_DQNIvBlsL4SrXMP3XueBkq4Zj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_22,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 adultscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310270203
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/2023 3:37 PM, Guru Das Srinagesh wrote:
> Currently, only a single waitqueue context is supported (zero). Firmware

which firmware?

> now supports multiple waitqueue contexts, so add support to dynamically
> create and support as many unique waitqueue contexts as firmware returns
> to the driver.
> 
> This is done by using the idr framework to create a hash table for

why idr?
Per https://docs.kernel.org/core-api/idr.html
"The IDR interface is deprecated; please use the XArray instead."

> associating a unique wq_ctx with a struct completion variable for easy
> lookup.
> 
> Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
> ---
> This series is based on the tip of linux-next because a couple of SCM
> driver-related patches are still in-flight in Bjorn's tree.
> ---
>   drivers/firmware/qcom/qcom_scm-smc.c |  7 ++-
>   drivers/firmware/qcom/qcom_scm.c     | 90 +++++++++++++++++++++++++++---------
>   drivers/firmware/qcom/qcom_scm.h     |  3 +-
>   3 files changed, 77 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm-smc.c b/drivers/firmware/qcom/qcom_scm-smc.c
> index 16cf88acfa8e..80083e3615b1 100644
> --- a/drivers/firmware/qcom/qcom_scm-smc.c
> +++ b/drivers/firmware/qcom/qcom_scm-smc.c
> @@ -103,7 +103,12 @@ static int __scm_smc_do_quirk_handle_waitq(struct device *dev, struct arm_smccc_
>   			wq_ctx = res->a1;
>   			smc_call_ctx = res->a2;
>   
> -			ret = qcom_scm_wait_for_wq_completion(wq_ctx);
> +			if (!dev) {
> +				/* Protect the dev_get_drvdata() call that follows */
> +				return -EPROBE_DEFER;
> +			}
> +
> +			ret = qcom_scm_wait_for_wq_completion(dev_get_drvdata(dev), wq_ctx);
>   			if (ret)
>   				return ret;
>   
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 520de9b5633a..70f0c35beb16 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -10,6 +10,7 @@
>   #include <linux/dma-mapping.h>
>   #include <linux/export.h>
>   #include <linux/firmware/qcom/qcom_scm.h>
> +#include <linux/idr.h>
>   #include <linux/init.h>
>   #include <linux/interconnect.h>
>   #include <linux/interrupt.h>
> @@ -27,13 +28,18 @@
>   static bool download_mode = IS_ENABLED(CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT);
>   module_param(download_mode, bool, 0);
>   
> +struct qcom_scm_waitq {
> +	struct idr idr;
> +	spinlock_t idr_lock;
> +};
> +
>   struct qcom_scm {
>   	struct device *dev;
>   	struct clk *core_clk;
>   	struct clk *iface_clk;
>   	struct clk *bus_clk;
>   	struct icc_path *path;
> -	struct completion waitq_comp;
> +	struct qcom_scm_waitq waitq;
>   	struct reset_controller_dev reset;
>   
>   	/* control access to the interconnect path */
> @@ -1742,42 +1748,76 @@ bool qcom_scm_is_available(void)
>   }
>   EXPORT_SYMBOL_GPL(qcom_scm_is_available);
>   
> -static int qcom_scm_assert_valid_wq_ctx(u32 wq_ctx)
> +static struct completion *qcom_scm_get_completion(struct qcom_scm *scm, u32 wq_ctx)
>   {
> -	/* FW currently only supports a single wq_ctx (zero).
> -	 * TODO: Update this logic to include dynamic allocation and lookup of
> -	 * completion structs when FW supports more wq_ctx values.
> +	struct completion *wq;
> +	unsigned long flags;
> +	int err;
> +
> +	spin_lock_irqsave(&scm->waitq.idr_lock, flags);
> +	wq = idr_find(&scm->waitq.idr, wq_ctx);
> +	if (wq) {
> +		/*
> +		 * Valid struct completion *wq found corresponding to
> +		 * given wq_ctx. We're done here.
> +		 */
> +		goto out;
> +	}
> +
> +	/*
> +	 * If a struct completion *wq does not exist for wq_ctx, create it. FW
> +	 * only uses a finite number of wq_ctx values, so we will be reaching
> +	 * here only a few times right at the beginning of the device's uptime
> +	 * and then early-exit from idr_find() above subsequently.
>   	 */
> -	if (wq_ctx != 0) {
> -		dev_err(__scm->dev, "Firmware unexpectedly passed non-zero wq_ctx\n");
> -		return -EINVAL;
> +	wq = devm_kzalloc(scm->dev, sizeof(*wq), GFP_ATOMIC);
> +	if (!wq) {
> +		wq = ERR_PTR(-ENOMEM);
> +		goto out;
>   	}
>   
> -	return 0;
> +	init_completion(wq);
> +
> +	err = idr_alloc_u32(&scm->waitq.idr, wq, &wq_ctx, wq_ctx, GFP_ATOMIC);
> +	if (err < 0) {
> +		/* Don't wait for driver to be unloaded to free wq */
> +		devm_kfree(scm->dev, wq);
> +		wq = ERR_PTR(err);
> +	}
> +
> +out:
> +	spin_unlock_irqrestore(&scm->waitq.idr_lock, flags);
> +	return wq;
>   }
>   
> -int qcom_scm_wait_for_wq_completion(u32 wq_ctx)
> +int qcom_scm_wait_for_wq_completion(struct qcom_scm *scm, u32 wq_ctx)
>   {
> -	int ret;
> +	struct completion *wq;
>   
> -	ret = qcom_scm_assert_valid_wq_ctx(wq_ctx);
> -	if (ret)
> -		return ret;
> +	wq = qcom_scm_get_completion(scm, wq_ctx);
> +	if (IS_ERR(wq)) {
> +		pr_err("Unable to wait on invalid waitqueue for wq_ctx %d: %ld\n",
> +				wq_ctx, PTR_ERR(wq));
> +		return PTR_ERR(wq);
> +	}
>   
> -	wait_for_completion(&__scm->waitq_comp);
> +	wait_for_completion(wq);
>   
>   	return 0;
>   }
>   
>   static int qcom_scm_waitq_wakeup(struct qcom_scm *scm, unsigned int wq_ctx)
>   {
> -	int ret;
> +	struct completion *wq;
>   
> -	ret = qcom_scm_assert_valid_wq_ctx(wq_ctx);
> -	if (ret)
> -		return ret;
> +	wq = qcom_scm_get_completion(scm, wq_ctx);
> +	if (IS_ERR(wq)) {
> +		pr_err("Unable to wake up invalid waitqueue for wq_ctx %d: %ld\n",
> +				wq_ctx, PTR_ERR(wq));
> +		return PTR_ERR(wq);
> +	}
>   
> -	complete(&__scm->waitq_comp);
> +	complete(wq);
>   
>   	return 0;
>   }
> @@ -1854,10 +1894,13 @@ static int qcom_scm_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> +	platform_set_drvdata(pdev, scm);
> +
>   	__scm = scm;
>   	__scm->dev = &pdev->dev;
>   
> -	init_completion(&__scm->waitq_comp);
> +	spin_lock_init(&__scm->waitq.idr_lock);
> +	idr_init(&__scm->waitq.idr);
>   
>   	irq = platform_get_irq_optional(pdev, 0);
>   	if (irq < 0) {
> @@ -1905,8 +1948,13 @@ static int qcom_scm_probe(struct platform_device *pdev)
>   
>   static void qcom_scm_shutdown(struct platform_device *pdev)
>   {
> +	struct qcom_scm *scm;
> +
> +	scm = platform_get_drvdata(pdev);
> +
>   	/* Clean shutdown, disable download mode to allow normal restart */
>   	qcom_scm_set_download_mode(false);
> +	idr_destroy(&scm->waitq.idr);
>   }
>   
>   static const struct of_device_id qcom_scm_dt_match[] = {
> diff --git a/drivers/firmware/qcom/qcom_scm.h b/drivers/firmware/qcom/qcom_scm.h
> index 4532907e8489..d54df5a2b690 100644
> --- a/drivers/firmware/qcom/qcom_scm.h
> +++ b/drivers/firmware/qcom/qcom_scm.h
> @@ -62,7 +62,8 @@ struct qcom_scm_res {
>   	u64 result[MAX_QCOM_SCM_RETS];
>   };
>   
> -int qcom_scm_wait_for_wq_completion(u32 wq_ctx);
> +struct qcom_scm;
> +int qcom_scm_wait_for_wq_completion(struct qcom_scm *scm, u32 wq_ctx);
>   int scm_get_wq_ctx(u32 *wq_ctx, u32 *flags, u32 *more_pending);
>   
>   #define SCM_SMC_FNID(s, c)	((((s) & 0xFF) << 8) | ((c) & 0xFF))
> 
> ---
> base-commit: 2ef7141596eed0b4b45ef18b3626f428a6b0a822
> change-id: 20231027-multi-wqs-8b87fc0d3b53
> 
> Best regards,

