Return-Path: <linux-kernel+bounces-56762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9F084CEC9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DDE8B24BD6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B023B80C00;
	Wed,  7 Feb 2024 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B6KY5AWq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373F67F7D9;
	Wed,  7 Feb 2024 16:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707322895; cv=none; b=sKgc6EazGWGAFwpi4L9GThYrE9oZCVhqlevKr/oX6kAalArWwAVqj1oCliJtEatQaMHlbwUMpLk4iOTltlxRBx762Jx8jBvLVQiB+GHpmfD/wtFXUk+54uBl5B9CAlf0MOYkj7q2Uj5X8z8qsTBLj0RHaVMrsd1RRAfI4DhHP0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707322895; c=relaxed/simple;
	bh=B5gBP6x0enaNCeeJRYkY6ghg0l8S5AEmEd5S0eLp0Mg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=Br8idnv4sgQtxkEH6clYdh9mYMm4O4tetsfgroO3Y25LDoeJA+hA5u5ECy4toj5A6PRaaAWtkdzKKI+VbLltMpnfoAGnAG3gBLwvO7t4wByFwSNdaG7vsYbFUtxqJXma7g8WdH4NzR5f3j55IySaZvJ2wiTKYbCe1ZvWOLbVb78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B6KY5AWq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4173kN0L031923;
	Wed, 7 Feb 2024 16:21:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=s1fFx4okONwAPqgvrtAAYHmQOYNk9SbYOu2KY6lFHhI=; b=B6
	KY5AWqg9qpIkyZy0H3BmCMvjKjHItgXcAKuoTQlgt04kNtjyxkwRHCAxurvAMMht
	qzUmmkI9ge8RayTwUoZlDPO+OUuA3hJPq/GRL0vgYH1LAmBzZTaLZAml0SzWHuXg
	ko9GtE9juQA7GkA9t3RhHs3I5EksWsN26KUdxyoH40NJXD0Xuvq8KzFPIAXnYv2b
	l0wginASVyPG7CZmeRsnYJN7E75tk3O+w/s9nRsUJNKD48eK00y4xc4TUBGIMqpK
	CPnQg6hx6Yb8/FwTMRyJlSbRsoLbL9QZreBBWLiZX08udhFLQXYSi5Vz48vQesCZ
	hRLVxqlHCBXwI11x5Gqg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w3v9124m8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 16:21:26 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 417GLPRA007792
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 7 Feb 2024 16:21:25 GMT
Received: from [10.50.40.120] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 7 Feb
 2024 08:21:21 -0800
Message-ID: <468b5a6d-53b7-4d75-8966-2fd48bb13d54@quicinc.com>
Date: Wed, 7 Feb 2024 21:51:18 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] remoteproc: qcom: Add NOTIFY_FATAL event type to SSR
 subdevice
Content-Language: en-US
From: Vignesh Viswanathan <quic_viswanat@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>
CC: <agross@kernel.org>, <konrad.dybcio@linaro.org>,
        <mathieu.poirier@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_devipriy@quicinc.com>,
        <quic_sjaganat@quicinc.com>
References: <20230503062146.3891-1-quic_viswanat@quicinc.com>
 <egnmb647g7x7e74j4g2jddwho23ulmbap2q4eimcyj7y4qvdlz@zmaydxodu2a6>
 <509406eb-8093-4bcf-820f-8e5210e1539d@quicinc.com>
 <d3c3320b-8cc1-4d13-ae87-f2f8f46826e6@quicinc.com>
In-Reply-To: <d3c3320b-8cc1-4d13-ae87-f2f8f46826e6@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VX-ZO5uVTwZJVmnJRfL-ARvni91ycUOZ
X-Proofpoint-GUID: VX-ZO5uVTwZJVmnJRfL-ARvni91ycUOZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_07,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 mlxlogscore=868 clxscore=1011 impostorscore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402070120



On 11/25/2023 12:24 AM, Vignesh Viswanathan wrote:
> 
> 
> On 9/4/2023 10:23 PM, Vignesh Viswanathan wrote:
>>
>>
>> On 7/16/2023 1:50 AM, Bjorn Andersson wrote:
>>> On Wed, May 03, 2023 at 11:51:46AM +0530, Vignesh Viswanathan wrote:
>>>> Currently the SSR subdevice notifies the client driver on crash of the
>>>> rproc from the recovery workqueue using the BEFORE_SHUTDOWN event.
>>>> However the client driver might be interested to know that the device
>>>> has crashed immediately to pause any further transactions with the
>>>> rproc. This calls for an event to be sent to the driver in the IRQ
>>>> context as soon as the rproc crashes.
>>>>
>>>
>>> Please make your argumentation more concrete, I can only guess what
>>> client driver you're referring to.
>>>
>>> You can do this either by spelling out which actual problem you're
>>> solving, or better yet, include some patches in the series that actually
>>> uses this interface.
>>>
>>
>> Hi Bjorn,
>>
>> Apologies for the delay in response.
>>
>> The client driver in my scenario is a Wi-Fi driver which is continuously
>> queuing data to the remoteproc and needs to know if remoteproc crashes
>> as soon as possible to stop queuing further data and also dump some debugstatistics on the driver side that could potentially help in debug
>> of why the remoteproc crashed.
>>
>> Also in the case with upcoming Wi-Fi 7 targets with multi-link operation, the driver might need to know that the remoteproc has crashed
>> instantly to handle some multi-link specific handling.
>>
>> The ath11k/ath12k WLAN drivers today partially have support for handling
>> such FATAL notification but it has not been upstreamed yet.
>>
>> Reference patch: https://git.codelinaro.org/clo/qsdk/oss/system/feeds/wlan-open/-/blob/win.wlan_host_opensource.1.0/mac80211/patches/031-ath11k-print-stats-on-crash.patch -- event SUBSYS_PREPARE_FOR_FATAL_SHUTDOWN.
>>
>> Also, Mukesh mentioned earlier that in some MSM targets with PCIe where latency cannot be tolerated, a similar downstream patch adds support for "early notifier". If this patch is accepted, the early notifier can also be replaced to use the same NOTIFY_FATAL event from SSR Subdevice
>>
>> https://git.codelinaro.org/clo/la/kernel/msm-5.15/-/commit/7583d24de337aa1bf7c375a7da706af9b995b9a1#a840754ebb0e24e88adbf48177e1abd0830b72d2
>> https://git.codelinaro.org/clo/la/kernel/msm-5.15/-/commit/257de41c63a5a51a081cc7887cdaa4a46e4d1744
> 
> Hi Bjorn,
> 
> Gentle reminder for this patch.
> 
> Thanks,
> Vignesh

Hi Bjorn,

Could you please help review this patch and let me know if any comments.

Thanks,
Vignesh
>>
>> Thanks,
>> Vignesh
>>
>>> Regards,
>>> Bjorn

