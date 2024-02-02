Return-Path: <linux-kernel+bounces-50596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F5D847B63
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E73671F284C4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F6B8173B;
	Fri,  2 Feb 2024 21:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="I75KgkAQ"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAC980603;
	Fri,  2 Feb 2024 21:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706908499; cv=none; b=Eb7kcbxymxoHV2pOtPESHQDWwtFz2BifnySYx5mwf1H4qRAcn/U/lxgB3wBzNMIH0y0FdFd0FVKlAuV2JTBjo9Np+Yk1q97bg91dzrVBudG6DFaY67W/dMylC2VLm77o3OhfKLaz5ohvq6Q/k4/h0Cz8w2HQksb1YZkOoZZFbcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706908499; c=relaxed/simple;
	bh=8JMAKuvDOPU+pRXPHNHPc0+MCc/C1gyNi0c8kqz5obM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aiOxkCJg9VmMTy4xmrRcPOzdIaOCeNNJQ3MmlfcAJzClern5Z0vIQQNUhvBKHbqzQi3Xq20oaKm0gZ0kfaqopvsLi2dw/QLUwYS/ummbYp6UX8HyT0TTulINU3ODRoMzl4y3CLv4uRZK4Fb/oLx6T1ZDcMhThfczQFVBU3FZTz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=I75KgkAQ; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 412LEMbZ085689;
	Fri, 2 Feb 2024 15:14:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706908462;
	bh=zgoKyKRzk2mlaXzGvR0gvmhQcCU8wlgUE8Q0I6gaFsc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=I75KgkAQUsaPlBf/YLEiOSkHkEW05KrTLoHvGTLcje0odsTFPACke5MknbOKoOZ8k
	 6qC5DXfTiykIYoJxQwDbXcw1XqOAavzFtMk3BLxNfKqhtXnUTiMt9ThO1ONqy1dFhm
	 fvzAWKy2F4Ysim5wFbsUNNS4jB3wGE/GlhOtrkt4=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 412LEMGe031234
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 2 Feb 2024 15:14:22 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 2
 Feb 2024 15:14:21 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 2 Feb 2024 15:14:22 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 412LELJI084221;
	Fri, 2 Feb 2024 15:14:21 -0600
Message-ID: <60d46d58-ad77-47e8-8ff6-bc05db7cf1be@ti.com>
Date: Fri, 2 Feb 2024 15:14:20 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] remoteproc: qcom_q6v5_wcss: Use devm_rproc_alloc()
 helper
Content-Language: en-US
To: Unnathi Chalicheemala <quic_uchalich@quicinc.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Shawn
 Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix
 Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP
 Linux Team <linux-imx@nxp.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <linux-remoteproc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20240123184632.725054-1-afd@ti.com>
 <20240123184632.725054-6-afd@ti.com>
 <256072b3-c1d0-4e11-9456-bbd50b84a310@quicinc.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <256072b3-c1d0-4e11-9456-bbd50b84a310@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 2/2/24 2:51 PM, Unnathi Chalicheemala wrote:
> 
> 
> On 1/23/2024 10:46 AM, Andrew Davis wrote:
>> Use the device lifecycle managed allocation function. This helps prevent
>> mistakes like freeing out of order in cleanup functions and forgetting to
>> free on error paths.
>>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>   drivers/remoteproc/qcom_q6v5_wcss.c | 24 +++++++++---------------
>>   1 file changed, 9 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/remoteproc/qcom_q6v5_wcss.c b/drivers/remoteproc/qcom_q6v5_wcss.c
>> index cff1fa07d1def..94f68c919ee62 100644
>> --- a/drivers/remoteproc/qcom_q6v5_wcss.c
>> +++ b/drivers/remoteproc/qcom_q6v5_wcss.c
>> @@ -1011,8 +1011,8 @@ static int q6v5_wcss_probe(struct platform_device *pdev)
>>   	if (!desc)
>>   		return -EINVAL;
>>   
>> -	rproc = rproc_alloc(&pdev->dev, pdev->name, desc->ops,
>> -			    desc->firmware_name, sizeof(*wcss));
>> +	rproc = devm_rproc_alloc(&pdev->dev, pdev->name, desc->ops,
>> +				 desc->firmware_name, sizeof(*wcss));
>>   	if (!rproc) {
>>   		dev_err(&pdev->dev, "failed to allocate rproc\n");
>>   		return -ENOMEM;
>> @@ -1027,29 +1027,29 @@ static int q6v5_wcss_probe(struct platform_device *pdev)
>>   
>>   	ret = q6v5_wcss_init_mmio(wcss, pdev);
>>   	if (ret)
>> -		goto free_rproc;
>> +		return ret;
>>   
>>   	ret = q6v5_alloc_memory_region(wcss);
>>   	if (ret)
>> -		goto free_rproc;
>> +		return ret;
>>   
>>   	if (wcss->version == WCSS_QCS404) {
>>   		ret = q6v5_wcss_init_clock(wcss);
>>   		if (ret)
>> -			goto free_rproc;
>> +			return ret;
>>   
>>   		ret = q6v5_wcss_init_regulator(wcss);
>>   		if (ret)
>> -			goto free_rproc;
>> +			return ret;
>>   	}
>>   
>>   	ret = q6v5_wcss_init_reset(wcss, desc);
>>   	if (ret)
>> -		goto free_rproc;
>> +		return ret;
>>   
>>   	ret = qcom_q6v5_init(&wcss->q6v5, pdev, rproc, desc->crash_reason_smem, NULL, NULL);
>>   	if (ret)
>> -		goto free_rproc;
>> +		return ret;
>>   
>>   	qcom_add_glink_subdev(rproc, &wcss->glink_subdev, "q6wcss");
>>   	qcom_add_ssr_subdev(rproc, &wcss->ssr_subdev, "q6wcss");
>> @@ -1061,16 +1061,11 @@ static int q6v5_wcss_probe(struct platform_device *pdev)
>>   
>>   	ret = rproc_add(rproc);
>>   	if (ret)
>> -		goto free_rproc;
>> +		return ret;
>>   
>>   	platform_set_drvdata(pdev, rproc);
>>   
>>   	return 0;
>> -
>> -free_rproc:
>> -	rproc_free(rproc);
>> -
>> -	return ret;
> 
> This return statement should stay, right?
> 

No path goes to "free_rproc" anymore, so we always do the "return 0;"
above on non-error paths.

Andrew

>>   }
>>   
>>   static void q6v5_wcss_remove(struct platform_device *pdev)
>> @@ -1080,7 +1075,6 @@ static void q6v5_wcss_remove(struct platform_device *pdev)
>>   
>>   	qcom_q6v5_deinit(&wcss->q6v5);
>>   	rproc_del(rproc);
>> -	rproc_free(rproc);
>>   }
>>   
>>   static const struct wcss_data wcss_ipq8074_res_init = {

