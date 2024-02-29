Return-Path: <linux-kernel+bounces-86349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FE086C440
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E6201F23391
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0ED654FB3;
	Thu, 29 Feb 2024 08:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PmLKteDr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D0A53E30;
	Thu, 29 Feb 2024 08:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709196841; cv=none; b=PaKMVhjuqN8Hdi6SPe/A6bs1T6T+ri0EH3QqAWE4MyFtsf61WD/R0F/UTg3/1DgJzP4pCUjhfr16o5sweO74F063wFp+Giw08SNjxy1rZlYSjNE+UXUrmQf3ysey+EMp60np0s316BHnPLrNFQF6GgaLmRO0VCBPGhLrQid1TLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709196841; c=relaxed/simple;
	bh=JFVXTAAuvueZGJ1qbFCAT1FQwjUtEjK+lf3R2RaGBnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=C9d7BxCZwa8Nd95wCVsMDp8nvDRnZzIMDDWPRFTaGw9DOmLCgi6v8dL6zZfPUNQwHsy2XzRfNaHwsYpgPuNsus1uU6M0vqUePCeyQQq4dOeyYP6Zw9QYdQuAlsQTpn3bld7HH4qdb8H3Uoye6Zjxj24fCRRe342VPPD7XLTyeoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PmLKteDr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41T6iDHP004522;
	Thu, 29 Feb 2024 08:53:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=MBa7Nsq5ot2JW4JB8W984X8OIbqaIdGF/tU6QV5+1so=; b=Pm
	LKteDrBhWD5tVSrdZnW3aTCRA45QXMIY+s5xCvEDMJlsPYOWzPRDkR0NZ2ubBVV0
	yS7wtCl7NhyzgaM2gPHo8zuFQj1TCpk7ZQvkPW6A8bVY5Tm83p/vpoWDteFqsw1w
	U4cqpQHHMxv6OqJX6p530zPD8t1Hx7RjQmI/GnBAZu/gh1SqFWKdVmYUltCj7qKq
	cxGMcXdgQimAZa0F5P3hE6Wxu5VI1s175Un9BrvJQfTwN9WEH+WKGuOf+q9q25Wd
	YOMVCY+7f1mqqz7rKayTvq5rZpKlNAN4DEgN4wnwgrYyvJVxuE2hE2KZCIUB3yoi
	FGlj+g5PW74QkwaE/WPw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wjmwn8b7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 08:53:54 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41T8rrxB014238
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 08:53:54 GMT
Received: from [10.216.40.135] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 29 Feb
 2024 00:53:50 -0800
Message-ID: <8b7b34b8-8b92-4475-fe6a-8a7340590fb2@quicinc.com>
Date: Thu, 29 Feb 2024 14:23:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] cpufreq: Don't unregister cpufreq cooling on CPU hotplug
Content-Language: en-US
To: Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>
CC: <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Manaf Meethalavalappu Pallikunhi
	<quic_manafm@quicinc.com>,
        Roman Stratiienko <r.stratiienko@gmail.com>,
        <linux-kernel@vger.kernel.org>
References: <1333a397b93e0e15cb7cb358e21a289bc7d71a63.1709193295.git.viresh.kumar@linaro.org>
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <1333a397b93e0e15cb7cb358e21a289bc7d71a63.1709193295.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: H-3rVEc9b13FTWj-hwiPT42z-elOBFAP
X-Proofpoint-ORIG-GUID: H-3rVEc9b13FTWj-hwiPT42z-elOBFAP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_01,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 mlxlogscore=872 phishscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 clxscore=1011 bulkscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402290068



On 2/29/2024 1:42 PM, Viresh Kumar wrote:
> Offlining a CPU and bringing it back online is a common operation and it
> happens frequently during system suspend/resume, where the non-boot CPUs
> are hotplugged out during suspend and brought back at resume.
> 
> The cpufreq core already tries to make this path as fast as possible as
> the changes are only temporary in nature and full cleanup of resources
> isn't required in this case. For example the drivers can implement
> online()/offline() callbacks to avoid a lot of tear down of resources.
> 
> On similar lines, there is no need to unregister the cpufreq cooling
> device during suspend / resume, but only while the policy is getting
> removed.
> 
> Moreover, unregistering the cpufreq cooling device is resulting in an
> unwanted outcome, where the system suspend is eventually aborted in the
> process.  Currently, during system suspend the cpufreq core unregisters
> the cooling device, which in turn removes a kobject using device_del()
> and that generates a notification to the userspace via uevent broadcast.
> This causes system suspend to abort in some setups.
> 
> This was also earlier reported (indirectly) by Roman [1]. Maybe there is
> another way around to fixing that problem properly, but this change
> makes sense anyways.
> 
> Move the registering and unregistering of the cooling device to policy
> creation and removal times onlyy.
> 
> Reported-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
> Reported-by: Roman Stratiienko <r.stratiienko@gmail.com>
> Link: https://patchwork.kernel.org/project/linux-pm/patch/20220710164026.541466-1-r.stratiienko@gmail.com/ [1]
> Tested-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/cpufreq/cpufreq.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 44db4f59c4cc..4133c606dacb 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1571,7 +1571,8 @@ static int cpufreq_online(unsigned int cpu)
>   	if (cpufreq_driver->ready)
>   		cpufreq_driver->ready(policy);
>   
> -	if (cpufreq_thermal_control_enabled(cpufreq_driver))
> +	/* Register cpufreq cooling only for a new policy */
> +	if (new_policy && cpufreq_thermal_control_enabled(cpufreq_driver))
>   		policy->cdev = of_cpufreq_cooling_register(policy);
>   
>   	pr_debug("initialization complete\n");
> @@ -1655,11 +1656,6 @@ static void __cpufreq_offline(unsigned int cpu, struct cpufreq_policy *policy)
>   	else
>   		policy->last_policy = policy->policy;
>   
> -	if (cpufreq_thermal_control_enabled(cpufreq_driver)) {
> -		cpufreq_cooling_unregister(policy->cdev);
> -		policy->cdev = NULL;
> -	}
> -
>   	if (has_target())
>   		cpufreq_exit_governor(policy);
>   
> @@ -1720,6 +1716,15 @@ static void cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
>   		return;
>   	}
>   
> +	/*
> +	 * Unregister cpufreq cooling once all the CPUs of the policy are
> +	 * removed.
> +	 */
> +	if (cpufreq_thermal_control_enabled(cpufreq_driver)) {
> +		cpufreq_cooling_unregister(policy->cdev);
> +		policy->cdev = NULL;
> +	}
> +

Looks fine than other solution..

-Mukesh
>   	/* We did light-weight exit earlier, do full tear down now */
>   	if (cpufreq_driver->offline)
>   		cpufreq_driver->exit(policy);

