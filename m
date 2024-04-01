Return-Path: <linux-kernel+bounces-126598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD24A893A35
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 12:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71BD9281F1F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48471CAA9;
	Mon,  1 Apr 2024 10:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Gg+GPvYz"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD341BDC8
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 10:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711967803; cv=none; b=lCPL5E9bgpmfebmlWCAc3uK6rOQoICTNDONDE1qxkKb34o19BlM96zmszweCgC4wtuqSdwmVNJ8fRbXc3vmVT2g6GaXE11HPFmW2k6DuZeFcWxBWVao7j0oLfs5kcsGF7Pp5CShtGGpAKuu3oZg3Wh1V8BBfjDbLOBdetaC8YCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711967803; c=relaxed/simple;
	bh=afpxfrYCMNe6Vx+dzgzcDV9owz3AvEM25VaQsNBBB7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnfTDOtX5x/RT2Q/G0L4/k79xXM89c52eu1Ez3TEZN3h5urwgXBcFlMqwyDs+x6rqgnKXP7WNQnI1ZoFSsxpvU+X6r5Cyvft2JuWWjyLMWiH2s+QZA1Z8eStm5gKSlEhWfRx7Vh07H443KtBSr1D6Qwk6HkVYkHleimQoHPnniY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Gg+GPvYz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 431AWxSQ023017;
	Mon, 1 Apr 2024 10:36:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=VxWeLjasO9XYUjAJvIAQ3i3G+NVHlgWs48qMNHASJMM=;
 b=Gg+GPvYzNR4lZ0Gbb/pQG/IlUv/wjEQjGY+tdLdo31w1H+AM3mN0nNGoFsRwYuQD2LUy
 WeYwyjGHJVat1dk/bUJZ0AljFb/XrxGS/M3l0HO8ZlIZcB9CCMyQfLOHWZ6TBxlVKcnP
 Q+Klp8l5ZJ2xDACN9i12GqLAT46Rv+kx6r99b3jrLd34sTbqQ1DGsBtjOyaI8IW3rzNn
 SHbko485mTCCILNvOUgXqa8PoUwl5XYP/uQy9TCQr6PfSlA5ir9T5STSziPrDN8Z5Ade
 jft+KWN6gorp2fwo/cHv48kJ84mNvC5kqT72N5chesbM/coFbtlysqKE7GlcR33XPGtB YQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x7u8s804h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 10:36:26 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 431AaQwm028538;
	Mon, 1 Apr 2024 10:36:26 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x7u8s8042-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 10:36:26 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 431AC6JU008431;
	Mon, 1 Apr 2024 10:36:09 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x6w2tqwuf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 10:36:09 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 431Aa63311993388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Apr 2024 10:36:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 038F420040;
	Mon,  1 Apr 2024 10:36:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 621BC20043;
	Mon,  1 Apr 2024 10:36:03 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.204.201.194])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  1 Apr 2024 10:36:03 +0000 (GMT)
Date: Mon, 1 Apr 2024 16:06:00 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Dawei Li <daweilics@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/fair: fix initial util_avg calculation
Message-ID: <ZgqOEJ5sCANkkk5N@linux.ibm.com>
References: <20240315015916.21545-1-daweilics@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315015916.21545-1-daweilics@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9b4vFGhrgS7Juj57cXuQlNxk0tI6-AYZ
X-Proofpoint-GUID: mV8RCCkrMEnxbFdSyuDCwvZY-SGf-xDt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_07,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 priorityscore=1501 spamscore=0
 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404010075

On Thu, Mar 14, 2024 at 06:59:16PM -0700, Dawei Li wrote:
> Change se->load.weight to se_weight(se) in the calculation for the
> initial util_avg to avoid unnecessarily inflating the util_avg by 1024
> times.
> 
> The reason is that se->load.weight has the unit/scale as the scaled-up
> load, while cfs_rg->avg.load_avg has the unit/scale as the true task
> weight (as mapped directly from the task's nice/priority value). With
> CONFIG_32BIT, the scaled-up load is equal to the true task weight. With
> CONFIG_64BIT, the scaled-up load is 1024 times the true task weight.
> Thus, the current code may inflate the util_avg by 1024 times. The
> follow-up capping will not allow the util_avg value to go wild. But the
> calculation should have the correct logic.
> 
> Signed-off-by: Dawei Li <daweilics@gmail.com>
> ---
> Changes in v2:
> - update the commit message
> ---
>  kernel/sched/fair.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a19ea290b790..5f98f639bdb9 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1031,7 +1031,8 @@ void init_entity_runnable_average(struct sched_entity *se)
>   * With new tasks being created, their initial util_avgs are extrapolated
>   * based on the cfs_rq's current util_avg:
>   *
> - *   util_avg = cfs_rq->util_avg / (cfs_rq->load_avg + 1) * se.load.weight
> + *   util_avg = cfs_rq->avg.util_avg / (cfs_rq->avg.load_avg + 1)
> + *		* se_weight(se)
>   *
>   * However, in many cases, the above util_avg does not give a desired
>   * value. Moreover, the sum of the util_avgs may be divergent, such
> @@ -1078,7 +1079,7 @@ void post_init_entity_util_avg(struct task_struct *p)
>  
>  	if (cap > 0) {
>  		if (cfs_rq->avg.util_avg != 0) {
> -			sa->util_avg  = cfs_rq->avg.util_avg * se->load.weight;
> +			sa->util_avg  = cfs_rq->avg.util_avg * se_weight(se);
Hi,

The comment above the declaration of se_weight function says we should be
using full load resolution and get rid of this helper.

Should we be adding new user of the helper?

/*
 * XXX we want to get rid of these helpers and use the full load resolution.
 */
static inline long se_weight(struct sched_entity *se)
{
	return scale_load_down(se->load.weight);
}


>  			sa->util_avg /= (cfs_rq->avg.load_avg + 1);
>  
>  			if (sa->util_avg > cap)
> -- 
> 2.40.1
> 

