Return-Path: <linux-kernel+bounces-132840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B107E899B03
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 506F61F22778
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BB115FCE7;
	Fri,  5 Apr 2024 10:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iOA/EM9F"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0C11CD03;
	Fri,  5 Apr 2024 10:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712313583; cv=none; b=kvkN7b7tf2dOZUBN77q86dEbE+TrtToR6N9I5Ij4tDMLASwlMXV5vSgepJ9j5HAkV/aDMJ4J63cDK7rhaWukvD75vM8+mCyiEc5ozU38eKAPL7O+3KHyj/FGdIG6SxAn9Z/LkPXhksFogknJ4sMX+VBSbQHDcTIr0uzJddDvCnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712313583; c=relaxed/simple;
	bh=2E17j7Ve7FOfk4tx0gvsLANCrYkPs6Skdo6dyBA9/zw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DbXr6Ln4yZdHYFpv1VufVb7bOxODnQ480A49WqDK9G6ihn5H3MCSaGdbxGRyGj2ljVomeD1b54BSo5PxXSsw6BcI6iHOL9a2lIufCIy7WBRGgs1/WaPVxmlb1beJlpUoZ8qsNb8ZIjMxgK58lHRzCzayF0DTVuWDgyijLNNtO98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iOA/EM9F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4359ptLe003900;
	Fri, 5 Apr 2024 10:39:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=vMAf/nBH0Lm+9CPcj0kvlu1Nzkm+iBU7ikLptAux34M=; b=iO
	A/EM9F31Bwst/NWC1EU3qsryTgFMIpsxJVIFknTAFgkI85aVQhfvTBf6U1XGXfuL
	+PfhWRbPAhQuC28HA6egyf/FB2J6KrgxdqnTp+lUkUnPMBFgqMXEd2sHWtdpWEq+
	dNvHmIhQrTjcFE1u82Mto1QPJFjBKJylDh0zH5ZarjhEOcDAO9jYQYn9V9tqAxiY
	GxLo6EQiLWQaH2xLawvl0hLrWvZRlOAerPXwbM1GwxM5EJ6YcSTSSiOTN7hnvE+K
	DQWWaYyCsOfZ4cDElIfMCdhlCA8dxraLsb/Z/iJr/rUXb3U/H7UhfMDHZGBvqI2C
	o0J+zEdB0UuT8BtaW/Jg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xa7m5gy5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 10:39:02 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 435Ad1hg012862
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 10:39:01 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Apr 2024
 03:38:58 -0700
Message-ID: <95bc8e95-3e52-9e50-9fe6-7ba1d4e07ca4@quicinc.com>
Date: Fri, 5 Apr 2024 16:08:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] cppc_cpufreq: Fix possible null pointer dereference
To: Aleksandr Mishin <amishin@t-argos.ru>,
        Ionela Voinescu
	<ionela.voinescu@arm.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar
	<viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
References: <20240405094005.18545-1-amishin@t-argos.ru>
Content-Language: en-US
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20240405094005.18545-1-amishin@t-argos.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4kWrjpNpQ5uudnOwQwrAhMPfSnV1neMA
X-Proofpoint-GUID: 4kWrjpNpQ5uudnOwQwrAhMPfSnV1neMA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_09,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1011
 mlxlogscore=999 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404050078



On 4/5/2024 3:10 PM, Aleksandr Mishin wrote:
> cppc_cpufreq_get_rate() and hisi_cppc_cpufreq_get_rate() can be called from
> different places with various parameters. So cpufreq_cpu_get() can return
> null as 'policy' in some circumstances.
> Fix this bug by adding null return check.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: a28b2bfc099c ("cppc_cpufreq: replace per-cpu data array with a list")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
>   drivers/cpufreq/cppc_cpufreq.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 64420d9cfd1e..5f7e04e8497b 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -741,6 +741,9 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>   {
>   	struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
>   	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> +	if (!policy)
> +		return -ENODEV;
> +

You should be doing this after all variable declaration, somewhere

..
..
struct cppc_cpudata *cpu_data;
u64 delivered_perf;
int ret;

if (!policy)
	return -ENODEV;

cpu_data = policy->driver_data;
.
.

>   	struct cppc_cpudata *cpu_data = policy->driver_data;
>   	u64 delivered_perf;
>   	int ret;
> @@ -822,6 +825,9 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
>   static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpu)
>   {
>   	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);

same here.

> +	if (!policy)
> +		return -ENODEV;
> +
>   	struct cppc_cpudata *cpu_data = policy->driver_data;
>   	u64 desired_perf;
>   	int ret;

-Mukesh

