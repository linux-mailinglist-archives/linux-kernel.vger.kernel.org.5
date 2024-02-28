Return-Path: <linux-kernel+bounces-84527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E2A86A7DA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F32821F2357C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 05:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F15720DFF;
	Wed, 28 Feb 2024 05:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bECaupkN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB351CFB9;
	Wed, 28 Feb 2024 05:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709097399; cv=none; b=JVWkW0tOIyS58zyGctCeWs0ioo+ryD3p07gUrN3FjDlJlwilAGifsi9XT92SAHRAV17mIuQnJqVUOyrGAZVgwsi11k7CQY5gIS48KAX7H2gltSVrftzubs7jqLYJVop+EiCzSn8FZXcs0xtoeGio7Mrdf2qmcM8NAukQCZRyS4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709097399; c=relaxed/simple;
	bh=qVPI7MS8YA9gXSchO0CmniNyttnD4M8hU6is0NV2gVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VVeJJHb/0mxy8XxFVC6iV37uEwhsTznN79TwGb4E49xPcSWsoohc0TmRy2x56KavgIEX7zGQ8Q1cP6GeAKBRGEdcnSLLUAFIFrBuwDfw8boRUu3GpCnRP+A7nAdJ4MIcRd1S/6I8OqwOxuLdYWEcmIMJcBC2WY1jCx00LU0PVAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bECaupkN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41S5Frmw026872;
	Wed, 28 Feb 2024 05:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=/9RHLZnaI5kQOKkS+s/I6Cq7yy4FExCSWCAd3lilZeU=; b=bE
	CaupkNR9ToiS2pNuTdpPvnTi7g2eBcGAoqATCDNKj1eXq6QWCLyVCxP400ma+Uvs
	aAJRZJy9AlLWMnmXDoAUuArVzg5tSR0WhOtDCUW2opipiZGKdgVxZLL9Xtq21N4P
	M62jmrffuZmsQatQ1wypZZkGIughep3M3kHLmfT3u/X2qOnaM5kcNBaDAr/vgPZD
	WlYZb6NDJtzURTsnlzOPcYXIsLpU207dZjXiEINfLb5oSmGiLVLVgabd9FXUCjPE
	ZjSgeqC/E66yzoUUwjWNZLUYdHt/p+NErFSnqRXc/Bvajt5SttEVnWUgGwcFt+m4
	Ev3VryajnpvpV+0GOZDg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3whkd5hd7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 05:16:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41S5GQDN015500
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 05:16:26 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 27 Feb
 2024 21:16:22 -0800
Message-ID: <377c1b4f-9357-112c-009c-fd6a757665b9@quicinc.com>
Date: Wed, 28 Feb 2024 10:46:19 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V3 1/2] cpufreq: Export cpufreq_update_pressure
Content-Language: en-US
To: Trilok Soni <quic_tsoni@quicinc.com>, <sudeep.holla@arm.com>,
        <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <morten.rasmussen@arm.com>,
        <dietmar.eggemann@arm.com>, <lukasz.luba@arm.com>,
        <pierre.gondois@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>
References: <20240227181632.659133-1-quic_sibis@quicinc.com>
 <20240227181632.659133-2-quic_sibis@quicinc.com>
 <2b68e15b-71ce-cf3b-a42d-e3e18aeb5ef2@quicinc.com>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <2b68e15b-71ce-cf3b-a42d-e3e18aeb5ef2@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SxTHXxlkderglM5sa5Nx4xDX2AyDh07j
X-Proofpoint-ORIG-GUID: SxTHXxlkderglM5sa5Nx4xDX2AyDh07j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_04,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280038



On 2/28/24 01:02, Trilok Soni wrote:
> On 2/27/2024 10:16 AM, Sibi Sankar wrote:
>> The SCMI cpufreq driver doesn't require any additional signal
>> smoothing provided by arch_update_hw_pressure interface, export
>> cpufreq_update_pressure so that it can be called upon directly
>> instead.
>>
>> Suggested-by: Lukasz Luba <lukasz.luba@arm.com>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
>>   drivers/cpufreq/cpufreq.c | 3 ++-
>>   include/linux/cpufreq.h   | 2 ++
>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 76002aa3d12d..bdec2dfd77eb 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -2573,7 +2573,7 @@ DEFINE_PER_CPU(unsigned long, cpufreq_pressure);
>>    *
>>    * Update the value of cpufreq pressure for all @cpus in the policy.
>>    */
>> -static void cpufreq_update_pressure(struct cpufreq_policy *policy)
>> +void cpufreq_update_pressure(struct cpufreq_policy *policy)
>>   {
>>   	unsigned long max_capacity, capped_freq, pressure;
>>   	u32 max_freq;
>> @@ -2598,6 +2598,7 @@ static void cpufreq_update_pressure(struct cpufreq_policy *policy)
>>   	for_each_cpu(cpu, policy->related_cpus)
>>   		WRITE_ONCE(per_cpu(cpufreq_pressure, cpu), pressure);
>>   }
>> +EXPORT_SYMBOL(cpufreq_update_pressure);
> 
> EXPORT_SYMBOL_GPL please. Other symbols in this file are _GPL as well.

Hey Trilok,

Thanks for catching this. Will fix it in the re-spin.

-Sibi

> 
>>   
>>   /**
>>    * cpufreq_set_policy - Modify cpufreq policy parameters.
>> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
>> index 414bfc976b30..957bf8e4ca0d 100644
>> --- a/include/linux/cpufreq.h
>> +++ b/include/linux/cpufreq.h
>> @@ -241,6 +241,7 @@ struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
>>   void cpufreq_enable_fast_switch(struct cpufreq_policy *policy);
>>   void cpufreq_disable_fast_switch(struct cpufreq_policy *policy);
>>   bool has_target_index(void);
>> +void cpufreq_update_pressure(struct cpufreq_policy *policy);
>>   
>>   DECLARE_PER_CPU(unsigned long, cpufreq_pressure);
>>   static inline unsigned long cpufreq_get_pressure(int cpu)
>> @@ -270,6 +271,7 @@ static inline bool cpufreq_supports_freq_invariance(void)
>>   }
>>   static inline void disable_cpufreq(void) { }
>>   static inline void cpufreq_update_limits(unsigned int cpu) { }
>> +static inline void cpufreq_update_pressure(struct cpufreq_policy *policy) { }
>>   static inline unsigned long cpufreq_get_pressure(int cpu)
>>   {
>>   	return 0;

