Return-Path: <linux-kernel+bounces-62951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A20C085284D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5698728593D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 05:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCC8125DE;
	Tue, 13 Feb 2024 05:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nYthr9Oz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438F013AC0;
	Tue, 13 Feb 2024 05:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707802980; cv=none; b=uNC008kF47aDJ196PIag4twU50THpPCNMtmCTxSktjSJfxl3JLDtSWo+ereMrTi75kqD1O3jUCUUOQ3D556+P44ZHTn4uML4euupuHkWC49TgltvwsUIBm0rU9Pcl6C6waqhixTBopo9uXLGgh+9IlAegP/D5bprEak46ynFVk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707802980; c=relaxed/simple;
	bh=xdUrAvPSexJuTx1UynIqwL1Mt2i20IVerZTF3+VgEAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IDxTUBlAWCy1gIEpar3HBV2Q36GqJCWMcc4sZGzhhlKy6owhF3ksHfMTDSfhIlvUiwvQOSaluqkDfTIKsiNL+GzWq3Z+k0Yt3eup0RL4ZiLhib4unoK/Y7I5kpt3KVwUStw02OjSC76DmHLGRfMXwZWZyqrfekHdM0vE+lYQFlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nYthr9Oz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41D2w0LA000471;
	Tue, 13 Feb 2024 05:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=UxaB0v9RqC5X0BLYMfvvz0kPdL+gG2m3gkqmUTSYjyk=; b=nY
	thr9OzhaBxhyRZmSczb2cW1/NloPQPg2FnEJhS3BnRYuXjK8+Z6s2ZBvaQ/NIJM7
	HtRbczJLk6W/xCDHaavC/dmQR9FsdScVcbuyTK1ueeQ1DC+pgtJ84f1/XpNoIOqc
	LoIu09iwPWTPCFZJLLoCwgZLsExYOLAFiD8DeeumKQPEZrMhxj2FMpJ8JJAgcpBX
	w9MnnDcehcPSC+cPk9Z7tLj1npHCtq5lTUvbEhFetUVLiyvL5Lt/Sqvq0uu4s8NH
	nVzpND/NrdSubbf+89i3OIT9riM8lBu1DiUJ0ylYG8owuwQJ36mHNrUkzGwp6N8W
	SFwvsW8807HxGGMcFVaA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7ww5rd5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 05:42:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41D5gOJ8031166
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 05:42:24 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 12 Feb
 2024 21:42:20 -0800
Message-ID: <849d8cd7-ca74-e9ed-851b-01addde05f1b@quicinc.com>
Date: Tue, 13 Feb 2024 11:12:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 4/4] cpufreq: scmi: Register for limit change
 notifications
Content-Language: en-US
To: Cristian Marussi <cristian.marussi@arm.com>
CC: <sudeep.holla@arm.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <morten.rasmussen@arm.com>, <dietmar.eggemann@arm.com>,
        <lukasz.luba@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_mdtipton@quicinc.com>, <linux-arm-msm@vger.kernel.org>
References: <20240117104116.2055349-1-quic_sibis@quicinc.com>
 <20240117104116.2055349-5-quic_sibis@quicinc.com> <ZbfLdvi_sePXiVmM@pluto>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <ZbfLdvi_sePXiVmM@pluto>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QNZ6ZlTmUcWvUVgaKp1CRNsPEnWEDAKx
X-Proofpoint-ORIG-GUID: QNZ6ZlTmUcWvUVgaKp1CRNsPEnWEDAKx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402130042



On 1/29/24 21:29, Cristian Marussi wrote:
> On Wed, Jan 17, 2024 at 04:11:16PM +0530, Sibi Sankar wrote:
>> Register for limit change notifications if supported with the help of
>> perf_notify_support interface and determine the throttled frequency
>> using the perf_freq_xlate to apply HW pressure.
>>

Christian,

Thanks for taking time to review the series.

>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
>>
>> v2:
>> * Export cpufreq_update_pressure and use it directly [Lukasz]
>>
>>   drivers/cpufreq/scmi-cpufreq.c | 42 +++++++++++++++++++++++++++++++++-
>>   1 file changed, 41 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
>> index 4ee23f4ebf4a..e0aa85764451 100644
>> --- a/drivers/cpufreq/scmi-cpufreq.c
>> +++ b/drivers/cpufreq/scmi-cpufreq.c
>> @@ -25,9 +25,13 @@ struct scmi_data {
>>   	int domain_id;
>>   	int nr_opp;
>>   	struct device *cpu_dev;
>> +	struct cpufreq_policy *policy;
>>   	cpumask_var_t opp_shared_cpus;
>> +	struct notifier_block limit_notify_nb;
>>   };
>>   
>> +const struct scmi_handle *handle;
>> +static struct scmi_device *scmi_dev;
>>   static struct scmi_protocol_handle *ph;
>>   static const struct scmi_perf_proto_ops *perf_ops;
>>   
>> @@ -144,6 +148,22 @@ scmi_get_cpu_power(struct device *cpu_dev, unsigned long *power,
>>   	return 0;
>>   }
>>   
>> +static int scmi_limit_notify_cb(struct notifier_block *nb, unsigned long event, void *data)
>> +{
>> +	unsigned long freq_hz;
>> +	struct scmi_perf_limits_report *limit_notify = data;
>> +	struct scmi_data *priv = container_of(nb, struct scmi_data, limit_notify_nb);
>> +	struct cpufreq_policy *policy = priv->policy;
>> +
>> +	if (perf_ops->perf_freq_xlate(ph, priv->domain_id, limit_notify->range_max, &freq_hz))
>> +		return NOTIFY_OK;
>> +
>> +	policy->max = freq_hz / HZ_PER_KHZ;
>> +	cpufreq_update_pressure(policy);
>> +
>> +	return NOTIFY_OK;
>> +}
>> +
>>   static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>>   {
>>   	int ret, nr_opp, domain;
>> @@ -151,6 +171,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>>   	struct device *cpu_dev;
>>   	struct scmi_data *priv;
>>   	struct cpufreq_frequency_table *freq_table;
>> +	struct scmi_perf_notify_info info = {};
>>   
>>   	cpu_dev = get_cpu_device(policy->cpu);
>>   	if (!cpu_dev) {
>> @@ -250,6 +271,25 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>>   	policy->fast_switch_possible =
>>   		perf_ops->fast_switch_possible(ph, domain);
>>   
>> +	ret = perf_ops->perf_notify_support(ph, domain, &info);
>> +	if (ret)
>> +		dev_warn(cpu_dev, "failed to get supported notifications: %d\n", ret);
>> +
>> +	if (info.perf_limit_notify) {
>> +		priv->limit_notify_nb.notifier_call = scmi_limit_notify_cb;
>> +		ret = handle->notify_ops->devm_event_notifier_register(scmi_dev, SCMI_PROTOCOL_PERF,
>> +							SCMI_EVENT_PERFORMANCE_LIMITS_CHANGED,
>> +							&domain,
>> +							&priv->limit_notify_nb);
>> +		if (ret) {
>> +			dev_err(cpu_dev, "Error in registering limit change notifier for domain %d\n",
>> +				domain);
>> +			return ret;
>> +		}
> 
> Is there a reason to fail completely here if it was not possible to register
> the notifier ? (even though expected to succeed given perf_limit_notify
> was true...)
> 
> Maybe a big fat warn that the system perf could be degraded, but
> carrying on ?
> 
> Or maybe you have in mind a good reason to fail like you did, so please
> explain in that case in a comment.

ack a warn should suffice here

-Sibi

> 
> Thanks,
> Cristian

