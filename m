Return-Path: <linux-kernel+bounces-98283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C47738777D9
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 19:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27E94281AEE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 18:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB1E39AC7;
	Sun, 10 Mar 2024 18:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lv6dAmwQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7D621115
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 18:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710093683; cv=none; b=QwyKm8+A+BQC1pJCx40NUzaDzGRiRr1E5U0dOs9HfpTKdYuRcVELvGosLUiPQf7rw6lpcYpKwfS6LPje4NGeMVDAsUUtGM8lZIE5gcwBONKWCqEbO3GvDfOV/6yNny/w/AV3fApczHQUSwbhhMSj1qjOHVV7Kfwy5PYONDyIixc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710093683; c=relaxed/simple;
	bh=1xvw7/qydc2EwjTNZthGu+QQS/Oq6RNHp0V4PWtVLrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eT4amUSWpIYEUgcQIBWfHOwqlT/WtShnj8uhMeA9c7TcetIaFtnaKO5CJRhRRJI3ee/pfcof5jvDDV3LEFVi0DDvsnYsm61CiJQC8HnNdSHcZrlPLAHTW9EbtbUKbKTjBY62lHIbfJK8qZaUjGUhkuOiCqOw5Ax+HwE5UlDztnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lv6dAmwQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42AHAmh5020105;
	Sun, 10 Mar 2024 17:30:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=9bQuV0086rWA9FniicQT1Mk0pnODcZNniX4vLVWE8cE=; b=lv
	6dAmwQRJJ+hvNZv4J9EYNXwgXG0M/yGKTK5CNPcr2hO7UvySkvihwrGvZu2nz54Z
	yP2woP8sH9Z5iyPMT+sefm/O/2EgNfnUJ69xRX9xqUBP1mvCwTDiJNtF4fdas8qC
	T130vGG/1FUsHP0Scy/laTxcaH8J/v5gmk+/ozGqTNqGz3pkHa9Ke07Azi0z+FpW
	hm4UWtuWiyMPen0W2JCBMGpVa+lZrwr6yasbXVl3k5o2lly6fCyt1wAbrO0lcJm6
	gaYwldLN+AO5OAxWizfzQyefU6Y+kEHCiKjKUlo7y6Z1Q9c7/0/jQY4WJVkVYYsf
	4L5Mw2gVQ+T/cj1NE2LQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wrg5b20sq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Mar 2024 17:30:01 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42AHU0Eb015354
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Mar 2024 17:30:00 GMT
Received: from [10.216.43.112] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 10 Mar
 2024 10:29:58 -0700
Message-ID: <b61f5f4a-7931-411d-9519-bbff1b7fd6f9@quicinc.com>
Date: Sun, 10 Mar 2024 22:59:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] i3c: master: Enable runtime PM for master controller
Content-Language: en-US
To: <alexandre.belloni@bootlin.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC: <andersson@kernel.org>, <vkoul@kernel.org>,
        <manivannan.sadhasivam@linaro.org>
References: <20240228093407.4038399-1-quic_msavaliy@quicinc.com>
From: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
In-Reply-To: <20240228093407.4038399-1-quic_msavaliy@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OiANyFU4EYU4vSyFG7NRVzCPdKteTxgz
X-Proofpoint-ORIG-GUID: OiANyFU4EYU4vSyFG7NRVzCPdKteTxgz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-10_10,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 mlxscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403100141

A Gentle reminder ! As i was not part of the linux-i3c group before 
raising this gerrit, might not went into right folder.

On 2/28/2024 3:04 PM, Mukesh Kumar Savaliya wrote:
> Enable runtime PM for i3c master node during master registration time.
> 
> Sometimes i3c client device driver may want to control the PM of the
> parent (master) to perform the transactions and save the power in an
> efficient way by controlling the session. Hence device can call PM
> APIs by passing the parent node.
> 
> Here, I3C target device when calls pm_runtime_get_sync(dev->parent)
> couldn't invoke master drivers runtime PM callback registered by
> the master driver because parent's PM status was disabled in the
> Master node.
> 
> Also call pm_runtime_no_callbacks() and pm_suspend_ignore_children()
> for the master node to not have any callback addition and ignore the
> children to have runtime PM work just locally in the driver. This
> should be generic and common change for all i3c devices and should
> not have any other impact.
> 
> With these changes, I3C client device works and able to invoke
> master driver registered runtime PM callbacks.
> 
> Signed-off-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> ---
>   drivers/i3c/master.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 3afa530c5e32..a3dc88974f92 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -13,6 +13,7 @@
>   #include <linux/kernel.h>
>   #include <linux/list.h>
>   #include <linux/of.h>
> +#include <linux/pm_runtime.h>
>   #include <linux/slab.h>
>   #include <linux/spinlock.h>
>   #include <linux/workqueue.h>
> @@ -2812,6 +2813,10 @@ int i3c_master_register(struct i3c_master_controller *master,
>   
>   	i3c_bus_notify(i3cbus, I3C_NOTIFY_BUS_ADD);
>   
> +	pm_runtime_no_callbacks(&master->dev);
> +	pm_suspend_ignore_children(&master->dev, true);
> +	pm_runtime_enable(&master->dev);
> +
>   	/*
>   	 * We're done initializing the bus and the controller, we can now
>   	 * register I3C devices discovered during the initial DAA.
> @@ -2849,6 +2854,7 @@ void i3c_master_unregister(struct i3c_master_controller *master)
>   	i3c_master_i2c_adapter_cleanup(master);
>   	i3c_master_unregister_i3c_devs(master);
>   	i3c_master_bus_cleanup(master);
> +	pm_runtime_disable(&master->dev);
>   	device_unregister(&master->dev);
>   }
>   EXPORT_SYMBOL_GPL(i3c_master_unregister);

