Return-Path: <linux-kernel+bounces-9471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8191281C623
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 374FD1F26084
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAADAF9D2;
	Fri, 22 Dec 2023 08:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qSCXkzVU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EF7DF42
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 08:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BM5r0sg006796;
	Fri, 22 Dec 2023 08:02:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=FV9B2b+HGXT7OKPmJl68SHf1c/HoXIpbqG4dQf9XRiI=;
 b=qSCXkzVUNrP8f1rgSSsNuxH8MlYpHL962W5ck+Kw1h9brWAqNyNxNvGsVD4MHa1kG1z4
 /xOw1lwFW3Jr1/Ury8gPeneJw/T1FCwpbis+be1rvNLIR65a4TfmlGhdN8fCYuZeguJi
 Wrt16qUMZPCGJez47OdUuG2jzGHiMADxu0RYPD/oUskrYr53tVL8mzFcrhWAVEmn9fDD
 3YOTRAK8rMeOSpvznAZT2DiazlVDBp6f947Y+d1HmDn2F/TciixEw9gjornJOf9vvwI9
 NQM6VtLzMWx46+Q0TtrSdXQbdTBL83dm7SV3yzZU/mB5N1qxbOVZsAqjRFFFO4KwTY0h 8A== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v54pmu353-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 08:02:32 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BM7oY8X029718;
	Fri, 22 Dec 2023 08:02:31 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3v1p7t2a39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 08:02:31 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BM82Umt31916682
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Dec 2023 08:02:30 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77A305806B;
	Fri, 22 Dec 2023 08:02:30 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 961A258052;
	Fri, 22 Dec 2023 08:02:27 +0000 (GMT)
Received: from [9.43.121.41] (unknown [9.43.121.41])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 Dec 2023 08:02:27 +0000 (GMT)
Message-ID: <e265378b-f81b-4c4c-9192-b383340c9be0@linux.vnet.ibm.com>
Date: Fri, 22 Dec 2023 13:32:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: move access of avg_rt and avg_dl into existing
 helper functions
Content-Language: en-US
To: Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>
Cc: peterz@infradead.org, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, srikar@linux.vnet.ibm.com,
        yu.c.chen@intel.com, tim.c.chen@linux.intel.com
References: <20231220065522.351915-1-sshegde@linux.vnet.ibm.com>
 <CAKfTPtCRoLULQkRTZcJfXvSSqZYV2oRN0a3_AFiuqD7k0LtL-Q@mail.gmail.com>
 <85230ed0-26a0-4f08-aab0-f0a6ce03abe8@linux.vnet.ibm.com>
 <CAKfTPtBYRT9oOoLwZ-Gg3KVdK+2iJnPaXaWfiuebnGEOOArH0Q@mail.gmail.com>
From: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <CAKfTPtBYRT9oOoLwZ-Gg3KVdK+2iJnPaXaWfiuebnGEOOArH0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jYyvHv4UnEQcTHd85w2znM3pR34fb_9C
X-Proofpoint-GUID: jYyvHv4UnEQcTHd85w2znM3pR34fb_9C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-22_04,2023-12-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312220056



On 12/21/23 9:46 PM, Vincent Guittot wrote:
> Hi Shrikanth,
> 
> On Wed, 20 Dec 2023 at 15:49, Shrikanth Hegde
> <sshegde@linux.vnet.ibm.com> wrote:
>>
>>
>>
>> On 12/20/23 7:29 PM, Vincent Guittot wrote:
>>
>> Hi Vincent, thanks for taking a look.
>>
>>> On Wed, 20 Dec 2023 at 07:55, Shrikanth Hegde
>>> <sshegde@linux.vnet.ibm.com> wrote:
>>>>
> 
> [...]
> 
>>>> -#ifdef CONFIG_HAVE_SCHED_AVG_IRQ
>>>> -       if (READ_ONCE(rq->avg_irq.util_avg))
>>>> +       if (cpu_util_irq(rq))
>>>
>>> cpu_util_irq doesn't call READ_ONCE()
>>>
>>
>>
>> I see. Actually it would be right if cpu_util_irq does call READ_ONCE no?
> 
> Yes, cpu_util_irq should call READ_ONCE()
> 

Ok. 

Sorry I forgot to mention about avg_irq. 
I will send out v2 with the above change of READ_ONCE added soon. 

>>
>> Sorry i havent yet understood the memory barriers in details. Please correct me
>> if i am wrong here,
>> since ___update_load_avg(&rq->avg_irq, 1) does use WRITE_ONCE and reading out this
>> value using cpu_util_irq on a different CPU should use READ_ONCE no?
> 
> Yes
> 
>>
>>>
>>>>                 return true;
>>>> -#endif
>>>>
>>>>         return false;
>>>>  }
>>>> @@ -9481,8 +9479,8 @@ static unsigned long scale_rt_capacity(int cpu)
>>>>          * avg_thermal.load_avg tracks thermal pressure and the weighted
>>>>          * average uses the actual delta max capacity(load).
>>>>          */
>>>> -       used = READ_ONCE(rq->avg_rt.util_avg);
>>>> -       used += READ_ONCE(rq->avg_dl.util_avg);
>>>> +       used = cpu_util_rt(rq);
>>>> +       used += cpu_util_dl(rq);
>>>>         used += thermal_load_avg(rq);
>>>>
>>>>         if (unlikely(used >= max))
>>>> --
>>>> 2.39.3
>>>>

