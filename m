Return-Path: <linux-kernel+bounces-127591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0218C894E14
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EF431F23687
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E7153815;
	Tue,  2 Apr 2024 08:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Yb1g7Sly"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5823D544
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 08:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712048306; cv=none; b=AWR9MQsaCA0rgGLhaLc2sAMQhVadwMMK1CGDMWFpjH+Gc58tkGP9z1bP8DtXzMiy7g61zkPmcOtgiJkoQCuPP6lJRWeIzDFQrsZijCFkXMNkAbH0bElcqrHUY76W8im4tOEwluahJvMmv0UHqUbabXcxgxNCqhHfu+WAWoCVHkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712048306; c=relaxed/simple;
	bh=o1gq+NXOPOISE9vCvWrjHc8SwRXA4CCcrp26JlijL8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cRkKZdSzArSaJo8cz+Bn8kFfVioD0eDPA83pGzORC2ImNTTF+HyjbhFEyCHzlr4QK6YzregUW0j1ag5noqKVVkt1Qg1WhZXvYSdiLfGnvcisl3VsVBbnl38dehWmyx59k4zsYlvKC+VfbQKSZhTGZAWONWnxNPNIgFflb4F+TUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Yb1g7Sly; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4328vnw5010477;
	Tue, 2 Apr 2024 08:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=vjeLiKB25shTPfBbKnNL5XlTVHkDE3ktnIcrN/G3DQc=;
 b=Yb1g7SlyVxG9WmSOXEYHfKwh/e/jHhoLJbK6RVhMAC/GqJQWvH7kK/HDYI3j3hGbcYZI
 GsgAYw/O7A7AxI3QMmwHthr9A17lsPPgN+tbztD4QTOuL4y7o6Ltadnlw4AbpKvkFSiO
 uVR/p+VkYcVs51EZUkU+6vEkk06hchNIebAIz5ufzcwa+nEdkrP5BrIuFLBn1/wPlgM2
 3p5VkK34jqAawDlsdr3LBGiFkosP2LIwRt1xiW5P1a7dhL9FjWWbqja6cv89xX1uy4Xe
 icoNFiO/2mndE6TQTws/+3mmpiTO2gxEcK3sp9AoaF7hWxuxcvkFmmh9jhLEYfel0l9y eA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x8eyag01n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 08:58:07 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4328w6e5010629;
	Tue, 2 Apr 2024 08:58:06 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x8eyag01g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 08:58:06 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43275IAv027165;
	Tue, 2 Apr 2024 08:58:05 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x6wf05mfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 08:58:05 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4328w3Di23855838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Apr 2024 08:58:05 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE6A258066;
	Tue,  2 Apr 2024 08:58:02 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDC5758060;
	Tue,  2 Apr 2024 08:57:58 +0000 (GMT)
Received: from [9.171.24.250] (unknown [9.171.24.250])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Apr 2024 08:57:58 +0000 (GMT)
Message-ID: <3b411431-1a04-4ac4-a6ae-56dd188da0f9@linux.ibm.com>
Date: Tue, 2 Apr 2024 14:27:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/fair: fix initial util_avg calculation
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dawei Li <daweilics@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira
 <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
References: <20240315015916.21545-1-daweilics@gmail.com>
 <ZgqOEJ5sCANkkk5N@linux.ibm.com>
 <CAG5MgCq3GT=CVj7Hz8rUMfNG1c9ypVsTSDKNESHV9tY_qWSt2g@mail.gmail.com>
 <e7d5bec3-be2a-4eea-b946-7f1739b0b4d0@linux.ibm.com>
 <CAKfTPtCVQ7ooRuN-OroK90GGa2T7=HyK3kovmvJcgojvJhbwPQ@mail.gmail.com>
Content-Language: en-US
From: Vishal Chourasia <vishalc@linux.ibm.com>
In-Reply-To: <CAKfTPtCVQ7ooRuN-OroK90GGa2T7=HyK3kovmvJcgojvJhbwPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KjqsdLRmrjnB0M2yj2TmkkQvMvNceNHS
X-Proofpoint-ORIG-GUID: 9-5bqLNX5hz24agdTNLHmju4I-nBm1BH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_03,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 impostorscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404020063

On 02/04/24 2:19 pm, Vincent Guittot wrote:
> On Tue, 2 Apr 2024 at 10:44, Vishal Chourasia <vishalc@linux.ibm.com> wrote:
>>
>> On 02/04/24 11:17 am, Dawei Li wrote:
>>> Hi Vishal
>>>
>>> Thanks for the comment!
>>> Do you suggest using scale_load_down() in place of se_weight()?
>> scale_load_down should be better.
> 
> se_weight is used for computing sched_entity's pelt signal so keep
> using it looks better but all this clearly just nitpick because that
> doesn't make any difference
Alright. Thank you for the clarification.
> 
>>> It's a soft bug we should fix one way or another before what the
>>> comment mentions really happens.
>> IIUC, We should be moving towards using full load resolution
>> for all the calculations. In that case, we need not worry about scaling load at
>> all. Maybe someone could provide context here.
>>
>>> I am actually confused that we have both se_weight() and
>>> scale_load_down(), and they do the same thing.
>>>
>>> Best regards,
>>> Dawei
>>>
>>> On Mon, Apr 1, 2024 at 3:36 AM Vishal Chourasia <vishalc@linux.ibm.com> wrote:
>>>>
>>>> On Thu, Mar 14, 2024 at 06:59:16PM -0700, Dawei Li wrote:
>>>>> Change se->load.weight to se_weight(se) in the calculation for the
>>>>> initial util_avg to avoid unnecessarily inflating the util_avg by 1024
>>>>> times.
>>>>>
>>>>> The reason is that se->load.weight has the unit/scale as the scaled-up
>>>>> load, while cfs_rg->avg.load_avg has the unit/scale as the true task
>>>>> weight (as mapped directly from the task's nice/priority value). With
>>>>> CONFIG_32BIT, the scaled-up load is equal to the true task weight. With
>>>>> CONFIG_64BIT, the scaled-up load is 1024 times the true task weight.
>>>>> Thus, the current code may inflate the util_avg by 1024 times. The
>>>>> follow-up capping will not allow the util_avg value to go wild. But the
>>>>> calculation should have the correct logic.
>>>>>
>>>>> Signed-off-by: Dawei Li <daweilics@gmail.com>
>>>>> ---
>>>>> Changes in v2:
>>>>> - update the commit message
>>>>> ---
>>>>>  kernel/sched/fair.c | 5 +++--
>>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>>> index a19ea290b790..5f98f639bdb9 100644
>>>>> --- a/kernel/sched/fair.c
>>>>> +++ b/kernel/sched/fair.c
>>>>> @@ -1031,7 +1031,8 @@ void init_entity_runnable_average(struct sched_entity *se)
>>>>>   * With new tasks being created, their initial util_avgs are extrapolated
>>>>>   * based on the cfs_rq's current util_avg:
>>>>>   *
>>>>> - *   util_avg = cfs_rq->util_avg / (cfs_rq->load_avg + 1) * se.load.weight
>>>>> + *   util_avg = cfs_rq->avg.util_avg / (cfs_rq->avg.load_avg + 1)
>>>>> + *           * se_weight(se)
>>>>>   *
>>>>>   * However, in many cases, the above util_avg does not give a desired
>>>>>   * value. Moreover, the sum of the util_avgs may be divergent, such
>>>>> @@ -1078,7 +1079,7 @@ void post_init_entity_util_avg(struct task_struct *p)
>>>>>
>>>>>       if (cap > 0) {
>>>>>               if (cfs_rq->avg.util_avg != 0) {
>>>>> -                     sa->util_avg  = cfs_rq->avg.util_avg * se->load.weight;
>>>>> +                     sa->util_avg  = cfs_rq->avg.util_avg * se_weight(se);
>>>> Hi,
>>>>
>>>> The comment above the declaration of se_weight function says we should be
>>>> using full load resolution and get rid of this helper.
>>>>
>>>> Should we be adding new user of the helper?
>>>>
>>>> /*
>>>>  * XXX we want to get rid of these helpers and use the full load resolution.
>>>>  */
>>>> static inline long se_weight(struct sched_entity *se)
>>>> {
>>>>         return scale_load_down(se->load.weight);
>>>> }
>>>>
>>>>
>>>>>                       sa->util_avg /= (cfs_rq->avg.load_avg + 1);
>>>>>
>>>>>                       if (sa->util_avg > cap)
>>>>> --
>>>>> 2.40.1
>>>>>
>>


