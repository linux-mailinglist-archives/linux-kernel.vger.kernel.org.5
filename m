Return-Path: <linux-kernel+bounces-108241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6429F88084A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 884A71C21CE8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3B05FBAC;
	Tue, 19 Mar 2024 23:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="HVOlNR6G"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2059.outbound.protection.outlook.com [40.92.107.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4254E3FBAF;
	Tue, 19 Mar 2024 23:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710892157; cv=fail; b=CqJS/gXcNmwb7odKl9j2HXAOm9cB8TW8qeSR4ywjfVbl5DZqlHeBEBQnFly0OEZwGmg/oCcQyCXbuxsAQ78xBZoEISS4h2sktw02W7yEAnrdnSL3XWLGlhRMQ8Y/wlUXXhOkoXY4GmmEqkorQwBK76UQioWLWi418nt+jtDbGyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710892157; c=relaxed/simple;
	bh=Kk6/kzQ3XyA9fjm8b5URo03X9Ocyo4l+FFANaXDWhtA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M49DeVYj91VRTi1jOLyVJdnqY65Pt/XzJSu1Ks6h/bsMkHCfOT4JPK0utba9Jr6KkWLCfW/x8gEK6KXC+BHYDlFD3hr8Dnp0VoH5tKmX9POi3JpqKe+x3JMRTjzaOket/4Rpx9qzUE+heujq1+y+qwi99KsmlCMXesNS4evY/Hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=HVOlNR6G; arc=fail smtp.client-ip=40.92.107.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVmhRgyLB3ukKNu6W/IvbLeUJsFxGrjwMQi1oZCyHU+2vIYO8BWTqfa3vfYPp7a2au9/snT5aQc4NiM1ZTA/PODfLV4GuJvS18O5SwfmGswsbJUYFLdI5PzjCaZ7+G7PQSrJ3+PlWUEWTAKp6MGX78yiHLCEcW6QOsiSzrJhFnZV6rB4xEHhrxHOtvYt+igw43XFNq+z5jOPG53ZJZ7TsxC0uWwJDmQgdT8+KRjcxmbbdjzg47gD3ncGBc+5cAgAdWe9fQM6hO8esCwXgCAUmr4p/EAqUhQfEUKEiCiEgM3vp2bh3v4m8ixnaTB7yTNohb4WT1aH9qCBe6vdJD2xAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3e8VZjoM6W6wORFLtPAocsfw028OqotTX3uA3Cv6/c=;
 b=WFh5IIpezchhLkdOo17Lgz9DNEjEag1LTTztTTs0kC/QAm8rgaQDLqN3hHFon096qNuiOaDuccYU3zetuUsIPq6t9y9gOl7KceK6ObM0g+QmiP045rQfsclzhiIhavGGKLZ1QAVzL1iI4ytmxTErR+F+5Mnaq7jx637NgzVkSoZJWXc0bXy4iZs6mSjfqSCHbbap9JHno6Vo4PhLyENL4XEGxG08ptQB4GGVbD3DRISrxzCVVXzIFHaUmmYhh+7BQ4TUuBUgzoGeD9xEDRdacvf2rrVT2Orvenc+LNnYwr4EM026hvtnm5/wkhir2jhm4yk8m5059xki0go6eUGcew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3e8VZjoM6W6wORFLtPAocsfw028OqotTX3uA3Cv6/c=;
 b=HVOlNR6G7hQuBWZFvrl2AVdPA9N8VEdXLHeEJyUgZ84hi2OPdgCVPAmgoceGJ9zN3+sKcRCEhvKUMqRjvK8YRhsZwb73a9iZpLju/BDF5+pdu1vxfN9aib7hPa5M0Zm4cnhdYpb2yjLowS2N/lckMS8gVtqlZkrH5aEjFdhC7yo5fjayni00pEBqiyE1dP1ut6Etoqru0MBOnQRfbCI7Y5JNMEunwaDpRcHotNBU/94yQ/1Ss6s836sRVaHqv2YQLD80L0d+pjKY4+adIBgrbbMvfTXU3XNIH+RwRk5JmPKvN5ARPWgzryJCpbRGo4ZmHiBD9FlhY0PkCUZxSPao+Q==
Received: from JH0PR01MB5780.apcprd01.prod.exchangelabs.com
 (2603:1096:990:48::9) by SEZPR01MB4502.apcprd01.prod.exchangelabs.com
 (2603:1096:101:75::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Tue, 19 Mar
 2024 23:49:11 +0000
Received: from JH0PR01MB5780.apcprd01.prod.exchangelabs.com
 ([fe80::e6c1:7caf:7cac:ef9c]) by JH0PR01MB5780.apcprd01.prod.exchangelabs.com
 ([fe80::e6c1:7caf:7cac:ef9c%5]) with mapi id 15.20.7386.022; Tue, 19 Mar 2024
 23:49:11 +0000
Message-ID:
 <JH0PR01MB57807C10CBF09DC49C8A7CF6CB2C2@JH0PR01MB5780.apcprd01.prod.exchangelabs.com>
Date: Wed, 20 Mar 2024 07:49:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] workqueue: add function in event of
 workqueue_activate_work
To: tj@kernel.org
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Kassey Li <quic_yingangl@quicinc.com>, Steven Rostedt <rostedt@goodmis.org>
References: <20240308021818.2306176-1-quic_yingangl@quicinc.com>
 <20240307212356.2e4d77d7@gandalf.local.home>
From: kassey li <kassey_li_1216@outlook.com>
In-Reply-To: <20240307212356.2e4d77d7@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [fn4hVnKXa+cmR445mF9BUCJ3ZQlz9DfZ]
X-ClientProxiedBy: TY2PR06CA0019.apcprd06.prod.outlook.com
 (2603:1096:404:42::31) To JH0PR01MB5780.apcprd01.prod.exchangelabs.com
 (2603:1096:990:48::9)
X-Microsoft-Original-Message-ID:
 <dbd0b030-d2d2-451f-827f-53866707fd55@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR01MB5780:EE_|SEZPR01MB4502:EE_
X-MS-Office365-Filtering-Correlation-Id: dd53d1f9-0d21-49fd-b97f-08dc486f2cd3
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrMKDiLrK7zKqACv4bCVGfEVW2f7IPkEkDpUbM+78X4Bm0PtQJHguRiNvanljUXJBf9HEwydgSanPjiWzjf2M5eaUYnNtKDb5H3AHVrVXG5m5yf8FfrJGjyb9EUS29NhxtnUAAsQX2DSkX38u+FL5SBGDIVBDKv8cl1wyvBSGz4NSAZTzGAD34XkYH5VYWRBsdX0LGk/d2BTllg0P50W7sFHgSf65zbsl2n64lYTs0lQC0qBIFqakMqhF8xmd7c4s7tyRWDhAHmnOe2XNYkT3+dNBdLh98nR88seneQWq/D1K8wER/y0ct6J2ujln20wCG8j49KbtHh9gJH5qx1brVZHxbWGx9Yx5y20wHLp6G0eGe3J+HQbnjXhEB4gsOpkoNUdJp/VlB6RuZMb7A/bwvhw4EmBsoBD/k+FpJr/WJU4g5jR/RYPY5WahZ9GfCVYEkJfQ5O7uAUpTFS1UywCY8m0cN1XVhy9mc90lDS4vUFMe45Jd57AdF9WHcx8F3kzIiBog1fXxuBWBDnluQUsdNIwIQtGkNbCZGWpOxMaHv/2rhXI/easCo0CMRjsgXDgWaRdsZufZEp0pVEJFUeR6Yy8+XoinU4zUpbDoxXfapcHoijQBsq49JyJt+rIYVw5w4uIweOdYlyN4sGGdgJMkW9ZUcNNnojd3uX/I1g0dGKPQAgF3RqdFAVhzcDW5zq54Snw04m1FIcZavqy5USZYLXKZTZuT2n9K4ci8SctBbBpXxJyhfWMAc5v2VKwBRa+wys=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+wDZzc5GEvMj55ssCZdttxtuXKUVpnS+3i63lfeWcAmOXUAL7fub9i8Q2ZeAegJD6Ki/Ujo2XuwZTegza/HARRmdTFcnaPVPhlXlYnAXqdgL2fZuLx7Ip6QxlMNVYKg1W/T/nq7AVPRSo3l7vDZ9EL/BCq1TsjqryEg2MdSs+6kHFO2LqIZ2bOL9EfV4lFnaGRgR3qnDCh63YwXvlinao8ALqmugm2lWTADJMBNqqUWEhWPWyQYFsOo81srtld4Por/2bckIpEz2edFiVZi9p37THp03C7gl60+SWrfrwjlodMyh8dNiGB8tCLClhY8pI+lKeahg3Vq568K/41h0oNgGxjx0ujTwHXT4lPM7ZDJSpBdK1uNOChWejYcYGcKwPXbDiOlhHrMgd3b8CT/SOMXDPZf7RXlwzVlJIcuFm+r5HmRGwhj0AhDWBQ+bb2Vk/UNPr65uKRg4sWQcuasjEv3fsbQ9pFRZ88Q/zpwRuXiIaWoycfOQFn5Ghukpf2oZ46rsQWd1G9ZX/8p9pc/GLxhVKOjF3Qrb3dDwlcStLbqbKqtpFZh+jCCu0muzzHkZFIt1/t6ELcrJZAcv6ZeLcEsJOasI+QIZFKzbQTrYpejx9QaF1CpEwXxi1RBIVLUo3HXRoXsERC//fm/6HdotI6wey/dsugAVraVyyIqCnfk=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OU1LVjVlYk9Ydkl0c0krMDdaaUpVQmRuTEJ6a1dpbStDdXdGeGFHd0IxUXRz?=
 =?utf-8?B?UExnZWdKZHNvYTdsUXpkLzMrUUVEWEFhWmJ0ZHBydThDc0pQWUZ5RkFaZG9G?=
 =?utf-8?B?RUcvK25NL0oxNXYvQXU5dzdmeUpFODBSZWVOemo4Q1NHR04zZjl6S081Ti93?=
 =?utf-8?B?dldLdkR1Y205NU91MzVZTEVKN2p4MWNNU2lTai9ZTjlWd0IwNzlveUcvbDhN?=
 =?utf-8?B?b3NseEJkRTZETjJ1TlllRVNwUjBEamx4aEN4Z0xCSjlUOHJ6QnJIVlhsc2hB?=
 =?utf-8?B?TnhMUm1yNkt0MVFxMGpMdWI3TmZsNTR0L1FFcEhnS1NnN2tTeXkxN0RiZGNz?=
 =?utf-8?B?Q2pseFRXTkVMam9ubnJxbVZxOHNadCt2UFVNcmhQQU9UOTdIRWdqREFGVm82?=
 =?utf-8?B?azc5N0MwQXlKVk1ZQUxuV3Fyd0lkcExYY3hoN2RndmNwZitOSUhVZkJjRnB5?=
 =?utf-8?B?UW1lTjR5SUhKRTVYNlZNUjRpejFYTXJnWG03NURkR0ozbkxrT3lJVmpHZnlw?=
 =?utf-8?B?cXM0TzdRZllKY1ZVMDZMeDNPZGxsSFAweHAvdXQyTG51Q3NnUkdLY09Ja25z?=
 =?utf-8?B?bndTMGNYbkVlU1dWV1haeElOK3pzdk0yMGQ2cDhuWEJ5aW16YzkwZ2dHY3pL?=
 =?utf-8?B?MDQ5ZFVUeEtIWU9uWGhzMGxmbFZtTktmbnVzdHNXTSt2cjhzTk9DU3hsTkRZ?=
 =?utf-8?B?QmFIL2JYZWFuTFNBMFNTVVJhNDFWcGxTMEdIZW5mcUo0azZzZDBRVVF0a2xU?=
 =?utf-8?B?WWJqSHB4WmlEem9lbUZmZWpLWm5rSzM4QnBudEVITGZuWmRITnh3ZjBiTEhv?=
 =?utf-8?B?N2o5VkhYa0NEamRkRmxCRHlNL3FCY1dVcmhDNHFtK3pzVmYyV3JVQ0ZBNTF1?=
 =?utf-8?B?RDJCYUlBemlQbVgvTm5LU3l1YlhCaE1FTG90b3JkbXRaazh4RzdFWGl4UVla?=
 =?utf-8?B?Y2ZsQmk2RTFpbXpRa2svNXdBNjV0cGF1R3Z0OG15NlJjVVVPeEhKeUFzQWtC?=
 =?utf-8?B?VlZ3WDRBNFdnNnQ3eW80bFNQUG01dXBYVlVoVERpUVVUNzBycWRiVHJTQTNW?=
 =?utf-8?B?enlNai9WUUtSVFA2Wkg0R3dBVnRSYWx2czBYVzQ5V0Zqenc5QUxlbWdEZUI0?=
 =?utf-8?B?bFpVR1FvN3RFbEFmYmNlS3ZRdm4zZWdIcXFxdTlWU0graVp4Wkt4NmhBM1Uw?=
 =?utf-8?B?Z04xSUMxeWx4Z2VtbllwcnpEZVlSaS9sTnVQbDlsV1p5SlVjM3E1djRJTGlq?=
 =?utf-8?B?dkptUEZqWThTdFZPdFIrZnhlREhDa1F5L0p5d05nUVBaYWRZalppYi9za3lu?=
 =?utf-8?B?YnNEN28xMHVZZFBRY2xJVlFhZUROM1VIWUtTN1lsUkE0OXNHeXZBREVsaWRs?=
 =?utf-8?B?U0Q2K2cvSk9HTXk1UXZWTGNkbU9wTHNIV0UrMWY4VnVodWlGR1J2OUpOSWFp?=
 =?utf-8?B?VndiYnFPUmxZcHEyTmxtQ1F3enFzWkFJcXRzV3hiT1VlcTdZVnNsRDd5NGRm?=
 =?utf-8?B?M1huRjNib1RpMytSNHp3NlNMNm1KNFgxanJFTHc2WkM1bWhEQnl0WkpPaGE1?=
 =?utf-8?B?N0xkWUE1UUVIdVJmaVR1QTcxMElhR0NUZ0loY0dGc3AwUnRhMmpoSmYrNmN6?=
 =?utf-8?B?M3U5alNzQkhMYVI2R2NRYXdmdUVuTzFEeU1hT1pJTzZzVzkzTUNzV3RwRzRE?=
 =?utf-8?Q?WX+fCWAHVK43EgIWDZ8S?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd53d1f9-0d21-49fd-b97f-08dc486f2cd3
X-MS-Exchange-CrossTenant-AuthSource: JH0PR01MB5780.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 23:49:11.4959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4502



on 2024/3/8 10:23, Steven Rostedt wrote:
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

hello, Tejun, may you have a chance to review this change ?

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
> 

