Return-Path: <linux-kernel+bounces-96548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8C1875DE9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B6681C2138C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 06:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3443612C;
	Fri,  8 Mar 2024 06:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iKmSszgG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3603631A83;
	Fri,  8 Mar 2024 06:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709878338; cv=none; b=emLhnrACurWZlN8Jt/7MO0omJXgqOgCIW7QFdcnWa84ZityrFeh7LGm4RiR/0ryEJqBhnxnxpMpaQe1FLxRpvzKiAItgyNdSM4xRX0vS5k5egjLVC1/qeCOUSP1xu97uXam0NuAUauRLk+DQHW1+GNUfPH0KYMXnDsqbtxrt+lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709878338; c=relaxed/simple;
	bh=vSwfvROycalTrWsfEvpuc/s08WPs5wOEZjtOQ8CR5wg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XAnPVaiqU+TwbeoMt8f1Vb+oj46CUfhwDQohazlGi0I5VXg1OMeKgN5R4NAcIr7Zty3N/85MPuddIoJkG8ymnnSZ5LLXRXgDGOFoIAGGD6VbtCoe9FF0ZvaoP+WWBy7MWRAoHDIU2PIPJt/cIiljGGQ+1wE3JABF3DZY37GqLKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iKmSszgG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4281BpuP020439;
	Fri, 8 Mar 2024 06:11:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=A2ExPmuonZNV/uJ3RLmu+8R8Ou4s0VcktqkyFiHukFU=; b=iK
	mSszgGcglD808sZg4SbrtZ3kKwEHHYQ43rT5RI+dU0zNs+uLTq52xF8jS73/vuu3
	bANyesno90jhJ1eFqU5xDBeZ7BDbuIbjMR5rylGam+xgaN5elIZOgczMkYV3QZOb
	uNo6qD+D8AIhaIshUQOALputVxrlC5VJ6wbBFyJcV2WQ19U6VTEw/J8ftjrrinNi
	dV1eYeKl15eHV5ewx/tu4bdbhm+rf88goy72smFWaITyk9HgoQh2vliVOw5g7YlD
	sHY0u8ho0SWqo1MOEXYdY5K1gRcDKArohqTvn8Kh47wUCVXN2PIn1B5ak9NEQPua
	IOe3gKbtqz83vt6f4Qfw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wqn8q8wb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 06:11:27 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4286BQme031252
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 8 Mar 2024 06:11:26 GMT
Received: from [10.232.65.248] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 7 Mar
 2024 22:11:24 -0800
Message-ID: <87fa307d-85cc-4fc0-bf66-234bd97ac377@quicinc.com>
Date: Fri, 8 Mar 2024 14:11:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] workqueue: add function in event of
 workqueue_activate_work
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>
CC: <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
        <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
References: <20240308021818.2306176-1-quic_yingangl@quicinc.com>
 <20240307212356.2e4d77d7@gandalf.local.home>
From: Kassey Li <quic_yingangl@quicinc.com>
In-Reply-To: <20240307212356.2e4d77d7@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SvURxEWDZ0MKI4dwFkRRyXat0m2wKHXZ
X-Proofpoint-ORIG-GUID: SvURxEWDZ0MKI4dwFkRRyXat0m2wKHXZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_04,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403080046



On 2024/3/8 10:23, Steven Rostedt wrote:
> On Fri, 8 Mar 2024 10:18:18 +0800
> Kassey Li <quic_yingangl@quicinc.com> wrote:
> 
>> The trace event "workqueue_activate_work" only print work struct.
>> However, function is the region of interest in a full sequence of work.
>> Current workqueue_activate_work trace event output:
>>
>>      workqueue_activate_work: work struct ffffff88b4a0f450
>>
>> With this change, workqueue_activate_work will print the function name,
>> align with workqueue_queue_work/execute_start/execute_end event.
>>
>>      workqueue_activate_work: work struct ffffff80413a78b8 function=vmstat_update
>>
>> Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
>> ---
>> Changelog:
>> v1: https://lore.kernel.org/all/20240308010929.1955339-1-quic_yingangl@quicinc.com/
>> v1->v2:
>> - do not follow checkpatch in TRACE_EVENT() macros
>> - add sample "workqueue_activate_work: work struct ffffff80413a78b8 function=vmstat_update"
> 
>  From a tracing POV,
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> -- Steve

thank you Steve.

add Tejun to review this change.

> 
>> ---
>>   include/trace/events/workqueue.h | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/trace/events/workqueue.h b/include/trace/events/workqueue.h
>> index 262d52021c23..6ef5b7254070 100644
>> --- a/include/trace/events/workqueue.h
>> +++ b/include/trace/events/workqueue.h
>> @@ -64,13 +64,15 @@ TRACE_EVENT(workqueue_activate_work,
>>   
>>   	TP_STRUCT__entry(
>>   		__field( void *,	work	)
>> +		__field( void *,	function)
>>   	),
>>   
>>   	TP_fast_assign(
>>   		__entry->work		= work;
>> +		__entry->function	= work->func;
>>   	),
>>   
>> -	TP_printk("work struct %p", __entry->work)
>> +	TP_printk("work struct %p function=%ps ", __entry->work, __entry->function)
>>   );
>>   
>>   /**
> 

