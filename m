Return-Path: <linux-kernel+bounces-93056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEF0872A32
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8EE9B284A8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BD812D201;
	Tue,  5 Mar 2024 22:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="blgRviWy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9E412D1E0;
	Tue,  5 Mar 2024 22:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709677725; cv=none; b=MH8vSHLGAnxY9JZQLAQPDUS4E8YGrTTi+lzykVpUo1xVKOz78kStxtQvBdwk75VEcGRIcWXd9znPS7dHGxLi++UuiLxE7uOVFMaa/e2jlGa+A854/fC9WLClSTcZYoE++MSIfkD5SF+tyPVrJjFYAoOd5NXtlXLJQzZom/vuQQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709677725; c=relaxed/simple;
	bh=xRZsnHmwF19OAZdz46mj1PSG/uOBGgEWr7XQffqODBc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEK9s5nO+CZh3mI3C4IWgh6QijyxWxOoPfv0Kbfskdj/L4JOkSohnJOKeqPjtv/YyocTZfrc28tgwgTgcGArPGksTz5wOr2mW56YoTYgyKFgSQN6ULkAudWT/1gnTuwswAOD0LCMo2L98wgBOdcVy386t7ZxuHegh3qKtGyHTac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=blgRviWy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 425LWSG0007899;
	Tue, 5 Mar 2024 22:28:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=7TaY6rEzcBsBqiPtzewFg
	K+5H1WtDxOW2kI8lClzoew=; b=blgRviWypcDuEzpi/JE3hcOUgx4vwRdBoZVRt
	lU7rq/1M4Ih9bjdgtteiUPnGAZ0iqC678THJ75dd2Drw2ITLcC9VrExzQaYPrGXf
	So5GQAmphf+VC5kgGThxBmQi6c3T/UKciA8xiG7lIV1CrboKXv+kVGMq1X9mQ8cC
	vUMfj7YolIyPLJjwZYw9ayiKFJgDR/E4VI60PxY9SfNrnOnx8PyfPIaqqkACxtYU
	oU5jQQyDBBmHc5ee8vfr9hgQOGofbv9PhSqKdNi7+YPbMXYFBiRe+O94eSoFVlXC
	x7CAzWEJvYMs86y8J3us2EjaPvpZCs5KPtl5ZOt0uVT953eoQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wpbav037y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 22:28:33 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 425MSKM6026646
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Mar 2024 22:28:20 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 5 Mar 2024 14:28:17 -0800
Date: Tue, 5 Mar 2024 14:28:16 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        Prasad Sodagudi <quic_psdoagud@quicinc.com>,
        "Murali
 Nalajala" <quic_mnalajal@quicinc.com>,
        Satya Durga Srinivasu Prabhala
	<quic_satyap@quicinc.com>
Subject: Re: [PATCH 2/3] firmware: qcom-scm: Support multiple waitq contexts
Message-ID: <20240305222816.GD3213752@hu-bjorande-lv.qualcomm.com>
References: <20240228-multi_waitq-v1-0-ccb096419af0@quicinc.com>
 <20240228-multi_waitq-v1-2-ccb096419af0@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240228-multi_waitq-v1-2-ccb096419af0@quicinc.com>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xt5Aws4Q8FvT_EuWUm3isff5X2dBrHaw
X-Proofpoint-ORIG-GUID: xt5Aws4Q8FvT_EuWUm3isff5X2dBrHaw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_18,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403050179

On Wed, Feb 28, 2024 at 10:50:00AM -0800, Unnathi Chalicheemala wrote:
> Currently, only a single waitqueue context is supported, with waitqueue
> id zero. SM8650 firmware now supports multiple waitqueue contexts, so
> add support to dynamically create and support as many unique waitqueue
> contexts as firmware returns to the driver.
> Unique waitqueue contexts are supported using xarray to create a
> hash table for associating a unique wq_ctx with a struct completion
> variable for easy lookup.
> The waitqueue ids can be >=0 as now we have more than one waitqueue
> context.
> 
> Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
> ---
>  drivers/firmware/qcom/qcom_scm-smc.c |  7 +++-
>  drivers/firmware/qcom/qcom_scm.c     | 77 ++++++++++++++++++++++++++----------
>  drivers/firmware/qcom/qcom_scm.h     |  3 +-
>  3 files changed, 64 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm-smc.c b/drivers/firmware/qcom/qcom_scm-smc.c
> index 16cf88acfa8e..80083e3615b1 100644
> --- a/drivers/firmware/qcom/qcom_scm-smc.c
> +++ b/drivers/firmware/qcom/qcom_scm-smc.c
> @@ -103,7 +103,12 @@ static int __scm_smc_do_quirk_handle_waitq(struct device *dev, struct arm_smccc_
>  			wq_ctx = res->a1;
>  			smc_call_ctx = res->a2;
>  
> -			ret = qcom_scm_wait_for_wq_completion(wq_ctx);
> +			if (!dev) {
> +				/* Protect the dev_get_drvdata() call that follows */
> +				return -EPROBE_DEFER;

No client driver will be prepared to handle an EPROBE_DEFER from here.

> +			}
> +
> +			ret = qcom_scm_wait_for_wq_completion(dev_get_drvdata(dev), wq_ctx);

I think it's fine to just continue to rely on __scm in the callee. If
you don't agree, please consider this a separate cleanup patch.

>  			if (ret)
>  				return ret;
>  
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index c1be8270ead1..4606c49ef155 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -21,6 +21,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/reset-controller.h>
>  #include <linux/types.h>
> +#include <linux/xarray.h>
>  
>  #include "qcom_scm.h"
>  
> @@ -33,7 +34,7 @@ struct qcom_scm {
>  	struct clk *iface_clk;
>  	struct clk *bus_clk;
>  	struct icc_path *path;
> -	struct completion waitq_comp;
> +	struct xarray waitq;
>  	struct reset_controller_dev reset;
>  
>  	/* control access to the interconnect path */
> @@ -1742,42 +1743,74 @@ bool qcom_scm_is_available(void)
>  }
>  EXPORT_SYMBOL_GPL(qcom_scm_is_available);
>  
> -static int qcom_scm_assert_valid_wq_ctx(u32 wq_ctx)
> +static struct completion *qcom_scm_get_completion(struct qcom_scm *scm, u32 wq_ctx)
>  {
> -	/* FW currently only supports a single wq_ctx (zero).
> -	 * TODO: Update this logic to include dynamic allocation and lookup of
> -	 * completion structs when FW supports more wq_ctx values.
> +	struct completion *wq;
> +	struct completion *old;
> +	int err;
> +
> +	wq = xa_load(&scm->waitq, wq_ctx);

What happens if qcom_scm_waitq_wakeup() is invoked concurrently with
qcom_scm_waitq_wakeup(), such that both find wq = NULL here?

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

I'm confused, when I reviewed this previously I expressed that unless "a
few" is more than 73, or that the value space is sparse, the use of an
xarray only complicates the implementation.

Either describe why this wouldn't work, or use a statically sized array.

> +	 * and then early-exit from idr_find() above subsequently.
>  	 */
> -	if (wq_ctx != 0) {
> -		dev_err(__scm->dev, "Firmware unexpectedly passed non-zero wq_ctx\n");
> -		return -EINVAL;
> +	wq = kzalloc(sizeof(*wq), GFP_ATOMIC);
> +	if (!wq) {
> +		wq = ERR_PTR(-ENOMEM);
> +		goto out;
>  	}
>  
> -	return 0;
> +	init_completion(wq);
> +
> +	old = xa_store(&scm->waitq, wq_ctx, wq, GFP_ATOMIC);
> +	err = xa_err(old);
> +	if (err) {
> +		kfree(wq);
> +		wq = ERR_PTR(err);
> +	}
> +
> +out:
> +	return wq;
>  }
>  
> -int qcom_scm_wait_for_wq_completion(u32 wq_ctx)
> +int qcom_scm_wait_for_wq_completion(struct qcom_scm *scm, u32 wq_ctx)
>  {
> -	int ret;
> +	struct completion *wq;
>  
> -	ret = qcom_scm_assert_valid_wq_ctx(wq_ctx);
> -	if (ret)
> -		return ret;
> +	wq = qcom_scm_get_completion(scm, wq_ctx);
> +	if (IS_ERR(wq)) {
> +		pr_err("Unable to wait on invalid waitqueue for wq_ctx %d: %ld\n",

You don't attempt to wait until a few lines further down, so this error
message doesn't seem to reflect the actual problem that occurred. Seems
like this will only ever be ENOMEM in practice, in which case we
shouldn't print an error, right?

dev_err() seems suitable if this remains though.

> +						wq_ctx, PTR_ERR(wq));
> +		return PTR_ERR(wq);
> +	}
>  
> -	wait_for_completion(&__scm->waitq_comp);
> +	wait_for_completion(wq);
>  
>  	return 0;
>  }
>  
>  static int qcom_scm_waitq_wakeup(struct qcom_scm *scm, unsigned int wq_ctx)
>  {
> -	int ret;
> +	struct completion *wq;
>  
> -	ret = qcom_scm_assert_valid_wq_ctx(wq_ctx);
> -	if (ret)
> -		return ret;
> +	wq = qcom_scm_get_completion(scm, wq_ctx);
> +	if (IS_ERR(wq)) {
> +		pr_err("Unable to wake up invalid waitqueue for wq_ctx %d: %ld\n",

As above.

Regards,
Bjorn

> +						wq_ctx, PTR_ERR(wq));
> +		return PTR_ERR(wq);
> +	}
>  
> -	complete(&__scm->waitq_comp);
> +	complete(wq);
>  
>  	return 0;
>  }
> @@ -1854,7 +1887,9 @@ static int qcom_scm_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	init_completion(&scm->waitq_comp);
> +	platform_set_drvdata(pdev, scm);
> +
> +	xa_init(&scm->waitq);
>  
>  	__scm = scm;
>  	__scm->dev = &pdev->dev;
> diff --git a/drivers/firmware/qcom/qcom_scm.h b/drivers/firmware/qcom/qcom_scm.h
> index 4532907e8489..d54df5a2b690 100644
> --- a/drivers/firmware/qcom/qcom_scm.h
> +++ b/drivers/firmware/qcom/qcom_scm.h
> @@ -62,7 +62,8 @@ struct qcom_scm_res {
>  	u64 result[MAX_QCOM_SCM_RETS];
>  };
>  
> -int qcom_scm_wait_for_wq_completion(u32 wq_ctx);
> +struct qcom_scm;
> +int qcom_scm_wait_for_wq_completion(struct qcom_scm *scm, u32 wq_ctx);
>  int scm_get_wq_ctx(u32 *wq_ctx, u32 *flags, u32 *more_pending);
>  
>  #define SCM_SMC_FNID(s, c)	((((s) & 0xFF) << 8) | ((c) & 0xFF))
> 
> -- 
> 2.25.1
> 

