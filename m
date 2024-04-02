Return-Path: <linux-kernel+bounces-127576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3515894DCF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5ECB1C22010
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5154A47A53;
	Tue,  2 Apr 2024 08:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CdtGYgcE"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F4E4501C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 08:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712047499; cv=none; b=k7qG8c6aAMvqIEumrvvIjWnAXwKhFmXV1db11Ji9g8wmBos2JQc3v4h1g42CM01/ryWOlY/R10IkHoyUJ+DrVXTR3CrhVE90AnfTstSu0tznBUyhBixc0PzjVk+o8XwREH/4IsM0cDssohIp67SgdC3VrAKROEp6ISpaHcAutPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712047499; c=relaxed/simple;
	bh=UPJFjRhrLx6xuVnzzr1LBNaG+sncLe5vQRUrXN6iQFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VsQqLUDWZtL06xnTO/FBgo9IS0UAjC3qvOc2FQwlG1QYxrDtbBkFS8AbBmC97Ih5BG3jjIjXpGz7ndfZ0uW9mOLvr1raZOBiIfBQum2lFChNG51gKHtaz5pyaNZVx7Ia/3z+oFPXolm/bmVPojNN7g9xw7amhhDfeVi3RV7MjKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CdtGYgcE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4328EUxe022447;
	Tue, 2 Apr 2024 08:44:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=T2zL8Y0GWuFkfIzMrk8rH4N2RawDCFmZokkUku3EQYA=;
 b=CdtGYgcEA7zVMomED6k909skV2nqT6rQNtnaGbk9q61KwOhLAa83/YLUVHAS6hl026vH
 glUstFx4sSidh/FIu046e6QR3JaoyZrFeN9+ji5zc+sWNlWpBnqu7dgqPuvte6C8XV1E
 7gHxTbH9pdsekx57PtQsZxNas73TR2d+kJGubpr0T2ir1AmvBvepUPRpo7twY4DhmoeY
 RL8PEQ2nRBGjnhQoHwhyp3jHSAJ44fE+VGsLyhzjqI3vF+QO3myMuZFZcwdznFG+RB8u
 yuSRjG34DmAVScQ3IJG7mBdhdcTMp6PFxHU9GSDFkzYfUPGixBsuJEov4gGirWtlIrtx 8Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x8ea40343-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 08:44:42 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4328igUt012610;
	Tue, 2 Apr 2024 08:44:42 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x8ea4033w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 08:44:42 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4325Utjt002194;
	Tue, 2 Apr 2024 08:44:40 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x6xjmd7af-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 08:44:40 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4328icEc29229628
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Apr 2024 08:44:40 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0011D5805E;
	Tue,  2 Apr 2024 08:44:37 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 271DC58051;
	Tue,  2 Apr 2024 08:44:34 +0000 (GMT)
Received: from [9.171.24.250] (unknown [9.171.24.250])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Apr 2024 08:44:33 +0000 (GMT)
Message-ID: <e7d5bec3-be2a-4eea-b946-7f1739b0b4d0@linux.ibm.com>
Date: Tue, 2 Apr 2024 14:14:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/fair: fix initial util_avg calculation
To: Dawei Li <daweilics@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira
 <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
References: <20240315015916.21545-1-daweilics@gmail.com>
 <ZgqOEJ5sCANkkk5N@linux.ibm.com>
 <CAG5MgCq3GT=CVj7Hz8rUMfNG1c9ypVsTSDKNESHV9tY_qWSt2g@mail.gmail.com>
Content-Language: en-US
From: Vishal Chourasia <vishalc@linux.ibm.com>
In-Reply-To: <CAG5MgCq3GT=CVj7Hz8rUMfNG1c9ypVsTSDKNESHV9tY_qWSt2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ynuwsyN2aW7spXZR0D0ysFIuzWOCUfEO
X-Proofpoint-ORIG-GUID: TUxFKjYrMOauX0CIA4ArSeUGQRh8kytR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_03,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404020061

On 02/04/24 11:17 am, Dawei Li wrote:
> Hi Vishal
> 
> Thanks for the comment!
> Do you suggest using scale_load_down() in place of se_weight()?
scale_load_down should be better.
> It's a soft bug we should fix one way or another before what the
> comment mentions really happens.
IIUC, We should be moving towards using full load resolution
for all the calculations. In that case, we need not worry about scaling load at
all. Maybe someone could provide context here.

> I am actually confused that we have both se_weight() and
> scale_load_down(), and they do the same thing.
> 
> Best regards,
> Dawei
> 
> On Mon, Apr 1, 2024 at 3:36 AM Vishal Chourasia <vishalc@linux.ibm.com> wrote:
>>
>> On Thu, Mar 14, 2024 at 06:59:16PM -0700, Dawei Li wrote:
>>> Change se->load.weight to se_weight(se) in the calculation for the
>>> initial util_avg to avoid unnecessarily inflating the util_avg by 1024
>>> times.
>>>
>>> The reason is that se->load.weight has the unit/scale as the scaled-up
>>> load, while cfs_rg->avg.load_avg has the unit/scale as the true task
>>> weight (as mapped directly from the task's nice/priority value). With
>>> CONFIG_32BIT, the scaled-up load is equal to the true task weight. With
>>> CONFIG_64BIT, the scaled-up load is 1024 times the true task weight.
>>> Thus, the current code may inflate the util_avg by 1024 times. The
>>> follow-up capping will not allow the util_avg value to go wild. But the
>>> calculation should have the correct logic.
>>>
>>> Signed-off-by: Dawei Li <daweilics@gmail.com>
>>> ---
>>> Changes in v2:
>>> - update the commit message
>>> ---
>>>  kernel/sched/fair.c | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index a19ea290b790..5f98f639bdb9 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -1031,7 +1031,8 @@ void init_entity_runnable_average(struct sched_entity *se)
>>>   * With new tasks being created, their initial util_avgs are extrapolated
>>>   * based on the cfs_rq's current util_avg:
>>>   *
>>> - *   util_avg = cfs_rq->util_avg / (cfs_rq->load_avg + 1) * se.load.weight
>>> + *   util_avg = cfs_rq->avg.util_avg / (cfs_rq->avg.load_avg + 1)
>>> + *           * se_weight(se)
>>>   *
>>>   * However, in many cases, the above util_avg does not give a desired
>>>   * value. Moreover, the sum of the util_avgs may be divergent, such
>>> @@ -1078,7 +1079,7 @@ void post_init_entity_util_avg(struct task_struct *p)
>>>
>>>       if (cap > 0) {
>>>               if (cfs_rq->avg.util_avg != 0) {
>>> -                     sa->util_avg  = cfs_rq->avg.util_avg * se->load.weight;
>>> +                     sa->util_avg  = cfs_rq->avg.util_avg * se_weight(se);
>> Hi,
>>
>> The comment above the declaration of se_weight function says we should be
>> using full load resolution and get rid of this helper.
>>
>> Should we be adding new user of the helper?
>>
>> /*
>>  * XXX we want to get rid of these helpers and use the full load resolution.
>>  */
>> static inline long se_weight(struct sched_entity *se)
>> {
>>         return scale_load_down(se->load.weight);
>> }
>>
>>
>>>                       sa->util_avg /= (cfs_rq->avg.load_avg + 1);
>>>
>>>                       if (sa->util_avg > cap)
>>> --
>>> 2.40.1
>>>


