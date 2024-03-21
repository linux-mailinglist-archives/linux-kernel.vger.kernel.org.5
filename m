Return-Path: <linux-kernel+bounces-110493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1461A885FB4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378801C239FC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4803456B76;
	Thu, 21 Mar 2024 17:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dhDoeoDd"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7028C79E0
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 17:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711041933; cv=none; b=GEbarcR3eb3xDxeYNxpOTt6NZS6TvDBuaVBzK+LfpuHv3VYQRcNOsyJSqGX4HU40WwQ01Wjzoesg4nAQNZ+wursc/F3AdkV7+wlTilSPFxqWWH+eytKWixd6ZVoZyedd7muNklHhiieqcZjrua2jb6Qyn6WlmgSwgzOBYKvHYho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711041933; c=relaxed/simple;
	bh=hkLPwTMMFdiiz0ywMQWoV1nqWL8v5pnhugmlgNrrXj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iYhXY/nbxkoZ0BoQoz2ZHr+Z+WfDKs12HbPHvHnR3nXBZlXTrRkD8nqVvSxl9oAc8wWDOsLPJumzvP1atcN5XwNrfovGpMfGFV8jxO7afiLJ4pZtMhRfqWa0cS6cz3CuvA894kdXwlgkqZ13t9ySpIc/KmX91fuDWGbq/ptDlrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dhDoeoDd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42LGxQFR029400;
	Thu, 21 Mar 2024 17:25:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=dakpi6GEZNYaA8Q32rcvx519IBjv3W2P5eLAKQKq9Kc=;
 b=dhDoeoDd0hnC9gH/NfqwFSuUmXnUNhnLVcXpF2QY3OF/jXjgxFzOlTFLTyTPhn5lTzEL
 P5cxkLFLBsDMTuXRMSYPC4JZqgLv5QaSBwESvnGnRh2ea4gf61ANva2ruaBPjKaQq4g4
 ZX82P+ACdDTU8sjfBibdLSxnUOBkQBbHwfwNn/wK0zSY8Lt+mXxxSkIaYOyE4REUvGss
 CSnTrOTlky28/LnpOiCQTpaWp3HwYedTxO741xWUPoUwkloSgxIwD/o937rXNy+Ad+3f
 v4Ngb5cfZRKPXiQOFvWVtVC5DTKCed+FGLte30BN4VQZSZ3k/qxi5RvmWiztY8XgzkcP Wg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0ne0rnu5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 17:25:08 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42LHP8ro010456;
	Thu, 21 Mar 2024 17:25:08 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0ne0rns1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 17:25:08 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42LGZnhN010067;
	Thu, 21 Mar 2024 17:21:27 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wxvavbp9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 17:21:27 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42LHLOKj30408978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 17:21:26 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBD9F58060;
	Thu, 21 Mar 2024 17:21:23 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 926585805C;
	Thu, 21 Mar 2024 17:21:20 +0000 (GMT)
Received: from [9.195.40.222] (unknown [9.195.40.222])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Mar 2024 17:21:20 +0000 (GMT)
Message-ID: <7080aa6d-34e4-4d25-9f1b-95ba07f0e6bb@linux.ibm.com>
Date: Thu, 21 Mar 2024 22:51:14 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched/fair: Check rd->overload value before update
Content-Language: en-US
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@kernel.org, peterz@infradead.org, dietmar.eggemann@arm.com,
        qyousef@layalina.io, linux-kernel@vger.kernel.org, vschneid@redhat.com,
        qperret@google.com, yu.c.chen@intel.com, srikar@linux.ibm.com,
        pierre.gondois@arm.com
References: <20240313150133.1182298-1-sshegde@linux.ibm.com>
 <20240313150133.1182298-2-sshegde@linux.ibm.com>
 <CAKfTPtBYAibCdsPumTAPDKBwNfLP9nr5577MSNKffV_VDmHDgA@mail.gmail.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <CAKfTPtBYAibCdsPumTAPDKBwNfLP9nr5577MSNKffV_VDmHDgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Rh_QWxJeDi_jTQ8EMFUi-bpsE4NcICLv
X-Proofpoint-ORIG-GUID: e5OSyYjDv6KF8sNpS4Ewz-UQJtLe5xCd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_10,2024-03-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 mlxscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403210126



On 3/21/24 1:14 PM, Vincent Guittot wrote:
> On Wed, 13 Mar 2024 at 16:02, Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
>>

Hi Vincent. Thanks for taking a look and review it. 

>>
>> Perf probes prove that actual change in value is less often. So it would
>> be better to check the value before updating it. Detailed perf probes
>> and annotation can be found in the cover letter. CPU bus traffic reduces
> 
> the cover letter will not be merged. It's better to put the figures
> here if you want to mention them

ok. yes, since it was long i didnt put here. maybe i can put hackbench results 
here in the changelog. rest can be found in cover-letter if one is interested. 

> 
>> with the patch.
>>
>> Fixes: 630246a06ae2 ("sched/fair: Clean-up update_sg_lb_stats parameters")
> 
> I don't think it's worth a Fixes tag. This is an improvement more than
> a fix as the current code works fine but generates more bus traffic
> 

got it. will remove it. I wasn't sure if I have to put it.

> With these minor changes in the commit message:
> 
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> 

Thank you!  I will send out v2 with these minor edits. 

>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>> ---
>>  kernel/sched/fair.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 02d4d224b436..eeebadd7d9ae 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -10621,7 +10621,8 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>>
>>         if (!env->sd->parent) {
>>                 /* update overload indicator if we are at root domain */
>> -               WRITE_ONCE(env->dst_rq->rd->overload, sg_status & SG_OVERLOAD);
>> +               if (READ_ONCE(env->dst_rq->rd->overload) != (sg_status & SG_OVERLOAD))
>> +                       WRITE_ONCE(env->dst_rq->rd->overload, sg_status & SG_OVERLOAD);
>>
>>                 /* Update over-utilization (tipping point, U >= 0) indicator */
>>                 set_rd_overutilized_status(env->dst_rq->rd,
>> --
>> 2.39.3
>>

