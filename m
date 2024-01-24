Return-Path: <linux-kernel+bounces-36807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6E383A716
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44AFCB294FB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328991A5BA;
	Wed, 24 Jan 2024 10:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZdJu8i9z"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AA6199B8;
	Wed, 24 Jan 2024 10:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706092984; cv=none; b=BNoiWS8hvTHLzdYAKBdFNRgXfH6jlM21vWmWQDNOahLPH0SsIpc9SXlWYt94K9IYAt6W0PcBd99opFzhj2U92ui5NISI4cnaLI+fg/9YEgQV9xddVGt8whFhb1N7+QeMHggLnVYYASDhTDGyFtbnW0ELLt3rKTpeIDqjyFB99Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706092984; c=relaxed/simple;
	bh=7kSJ0U2bWClpV/n7S8II5vylc0cHz5m7aSl9hci5/7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jRnEbEgknW+szSA8NgJmT2SvqsNHKjdV0nZh/GtGhGM1rbcPlowSTjKOhVVxBQCArzeXuEeeWyd9tHMos/qTU1zzFcTdxW5d81Ml8OhH3DBoLYCXpKbQMMIMEgFBhyLTZBUXGLJYvQjG1/2IiclFpDUpv0FvYJFzZdavtrzCbds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZdJu8i9z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40OALwj5015624;
	Wed, 24 Jan 2024 10:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=wEiM2j5nCvmikp4uX0I3tdM3maEln6y3gtRZhMBw3q8=; b=Zd
	Ju8i9zof3t04VpyXzL/YxFMHqj/OY0HLAlGLLJxgYZZOGUAe3gIUA+GVEw9aqIKC
	LQ9g+oCTA8XGEM02bca0bQxedRLJkXHqBM34viSTdc0DPwDYDIQE+1UB9jnoJ9sZ
	+G3UfaxxSa9ezr5A1g5VkdYfXJ1BHFiMaaD2BzFUX857CbV6zhnCSMUMjQ1M7i9B
	O2pi3xZuoGJvXYsh0KaRBNODov9XpyDD94GSDPcev3fXijTcG15+xeKBIJLaneRg
	82YmVjcdHEMKhSFJH0v1d24kgDhoe2OEgNbsur6lU6EJqXnsc5ZeI4QTv/F77w16
	lMuWEUqxvVMSi3+ElVbA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vtmhdsh9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 10:42:54 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40OAgrQg022999
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 10:42:53 GMT
Received: from [10.218.47.125] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 24 Jan
 2024 02:42:49 -0800
Message-ID: <f415a8cd-4cae-d7c3-60fc-674b3e660f6b@quicinc.com>
Date: Wed, 24 Jan 2024 16:12:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] thermal/drivers/tsens: Add suspend to RAM support for
 tsens
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria
	<amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <quic_manafm@quicinc.com>
References: <20240122100726.16993-1-quic_priyjain@quicinc.com>
 <548e2f24-a51e-4593-9463-09506488c70e@linaro.org>
From: Priyansh Jain <quic_priyjain@quicinc.com>
In-Reply-To: <548e2f24-a51e-4593-9463-09506488c70e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YWI7aNZZ2KpX4qIUkiJRaoycbkyH2U8b
X-Proofpoint-ORIG-GUID: YWI7aNZZ2KpX4qIUkiJRaoycbkyH2U8b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_04,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=680
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401240076



On 1/22/2024 8:02 PM, Konrad Dybcio wrote:
> On 22.01.2024 11:07, Priyansh Jain wrote:
>> Add suspend callback support for tsens which disables tsens interrupts
>> in suspend to RAM callback.
> 
> Would it not be preferrable to have the "critical overheat", wakeup-
> capable interrupts be enabled, even if the system is suspended?
> 


As part of suspend to RAM, tsens hardware will be turned off and it 
cannot generate any interrupt.Also system doesn't want to abort suspend 
to RAM due to tsens interrupts since system is already going into lowest
power state. Hence disabling tsens interrupt during suspend to RAM callback.

Regards,
Priyansh

>> Add resume callback support for tsens which reinitializes tsens hardware
>> and enables back tsens interrupts in resume callback.
>>
>> Signed-off-by: Priyansh Jain <quic_priyjain@quicinc.com>
>> ---
> 
> [...]
> 
> 
>> +
>> +int tsens_suspend_common(struct tsens_priv *priv)
>> +{
>> +	switch (pm_suspend_target_state) {
>> +	case PM_SUSPEND_MEM:
>> +		if (priv->combo_irq > 0) {
>> +			disable_irq_nosync(priv->combo_irq);
>> +			disable_irq_wake(priv->combo_irq);
>> +		}
>> +
>> +		if (priv->uplow_irq > 0) {
>> +			disable_irq_nosync(priv->uplow_irq);
>> +			disable_irq_wake(priv->uplow_irq);
>> +		}
>> +
>> +		if (priv->crit_irq > 0) {
>> +			disable_irq_nosync(priv->crit_irq);
>> +			disable_irq_wake(priv->crit_irq);
>> +		}
>> +		break;
>> +	default:
>> +		break;
>> +	}
> 
> if (pm_suspend_target_state != PM_SUSPEND_MEM)
> 	return 0;
> 
> <rest of the code>
> 
> [...]
> 
>>   
>> +	/* For saving irq number to re-use later */
> 
> This is rather self-explanatory
> 
> Konrad

