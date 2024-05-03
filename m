Return-Path: <linux-kernel+bounces-167582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 158898BAB90
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F5C2836E8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E2E152502;
	Fri,  3 May 2024 11:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AjiFk1SY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADB2848A;
	Fri,  3 May 2024 11:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714735716; cv=none; b=kBjU5/JMc2gIJZtmIn6MrRGebiy6tCLKTJEOtIgTjS7RN8nzLdNwTlMhYMTfH/qO210GxPtCMXJ/lYa8lcqJDLBV71faK43WEYtRb8FwpJ0Ju215i7g0CXvDRyeKzTImPs/93l+hOWQLToP5OLLfGuLV3ZBKSy7/t2emjDjXFMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714735716; c=relaxed/simple;
	bh=tM0jmzwo38thbmHTNw4u6psKHLW5pVQfuSnTwvXj3rc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Qbh/bhiqFe5jxSfe0/5QAlAK/jrtc3U9BSo1/KyqDNFiVeOnT+bkqQLmcA1mIyYDwxuv7LUxnNMhkzo5RrkclKIMJ9TAF11iGgZt2MB2tQA7dT9XwXQQgLQEonuxqEew+hpzOHOODOQgREavpyWyRVj3jju7c/vUaLi8nG3cslk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AjiFk1SY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 443ASsWF009794;
	Fri, 3 May 2024 11:28:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=AfRhpfoDMrbt3nulrxEHaJrsR2FKeBV9poRGvqDY/kY=; b=Aj
	iFk1SYkrpkA6AoLwc2gKlpTMfmsStZOzQqDLIadSgdVfsEQc5U1NTCxg9YZUtLLz
	y35W7I1KHDPmD2GoX7MDcSosRnEKu+y+CKLV3FAyqITLyWhgo5HLSlV87fNC7lfB
	mn8CZfWh2QnXC6sdurgt5mzQ26Ly8/nxZwQR3SuiHQQxdsDBmWUu6boyWplWJ2aw
	bOWUgjrQtOG1CmFn52l9NLM/UjpojzpQLvLWh+384ffUaucvj0cKQqNx8TnClzhF
	lib5vJxUnITqkPXVBXAA77WM567VLPYhsz8kAtcyhSHwhHHXMiTLNNphUlcvNHEF
	1BAjo0ZiFZiBUm1SyyZw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xvawbjddb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 May 2024 11:28:01 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 443BS0Bk015490
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 3 May 2024 11:28:00 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 3 May 2024
 04:27:56 -0700
Message-ID: <267391c1-948c-9f75-69e6-b5b49d34a7fe@quicinc.com>
Date: Fri, 3 May 2024 16:57:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] clocksource/drivers/arm_arch_timer: Mark
 validate_timer_rate() init
Content-Language: en-US
To: Stephen Boyd <swboyd@chromium.org>,
        Daniel Lezcano
	<daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC: <linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>
References: <20240502233017.419365-1-swboyd@chromium.org>
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20240502233017.419365-1-swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tF3M4S9Peb1R0sj7WLTMV7ZucV9D2F6E
X-Proofpoint-ORIG-GUID: tF3M4S9Peb1R0sj7WLTMV7ZucV9D2F6E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_07,2024-05-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011 adultscore=0
 mlxlogscore=741 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405030082



On 5/3/2024 5:00 AM, Stephen Boyd wrote:
> Add the __init marking to validate_timer_rate() so that it gets
> discarded after init.
> 
>    $ ./scripts/bloat-o-meter vmlinux.before vmlinux.after
>    add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-8 (-8)
>    Function                                     old     new   delta
>    arch_timer_register                         1724    1716      -8

Have not used this tool bloat-o-meter
Just a question, why is it showing arch_timer_register is shrunk ?

-Mukesh

