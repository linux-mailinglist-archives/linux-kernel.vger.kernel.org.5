Return-Path: <linux-kernel+bounces-137964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C64F89EA74
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CA00B218E0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315F520309;
	Wed, 10 Apr 2024 06:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KuZl1xAr"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2208328F0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712729542; cv=none; b=HYs/EiGdOuc6sbJBKRWty5YqP8KC8sGA+yixiJ8oVjCQEKqYwEkHdACS1HNPxG8HvPqAwLxJ62WPKUooHzZBZ8O+8ReewLGi4Zui1RbeM0uYj7CILzNcbFt95dXFe55WaNzXsRj3JStUuzFIJWGIL2X9I6AYAGc8D3LTiX666m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712729542; c=relaxed/simple;
	bh=6DzcXghpOT1CgxVZsWSMV4MdzZRWezc64ybxx8fbQUQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Imp/NfeLdVssZP9daxiHmuXxmaFuqjTcnJG4T3mRQT68Td852QFOYIkulq1Osh4DzQkKpgpcqdFQUCYIAuxJZnLXWwOAV0b8VtHeDGXrbQm92KwQ9M0K+4IYSBsGtqRHPD9/SdvzWQeJFLF7BGpHKBm7qs6+PVKnz7/lHZSsec0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KuZl1xAr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43A63wAp022292;
	Wed, 10 Apr 2024 06:11:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=86JQGcKfPyk3bAo37Zl1qcrEbjr+9YC7gKvGNkwSj6c=;
 b=KuZl1xAr0HplG3I1PjHuaxpDIHaw7Dz5dfZkTuDYw55PfTbDKYpYHV/ro9TbswA+y6w4
 4rLIPGiEAkrHAtZ4MTdvZl1HLrm26oR0Yavuv/QxqRLAO4ijq4lICbvbi1+rKH7uwA4H
 zcpORThSYOL74Pj3ho7vA9UDpvbN5wVvwDgbLt/bBYCtOXsHnZ96N2RlSTPzo5YAKO2Z
 YY5nCaRgI7MSIm3ujG6T3FSgUb3Fj1718lgpIrrZByCnHTEYPEOGxbCTs8kFbRJBPb5H
 BmAOINOHK+ag4RLI2MAAhLNRnhys2vS9K34QfE+yPy2kshoGZF5GOXBPQ1UEYD1Jda3c 4w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xdn5700j4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 06:11:38 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43A6AVxL031231;
	Wed, 10 Apr 2024 06:11:38 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xdn5700j0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 06:11:38 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43A5ur4j016971;
	Wed, 10 Apr 2024 06:11:37 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xbke2jjd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 06:11:37 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43A6BY6Z8979090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2024 06:11:36 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C16F58066;
	Wed, 10 Apr 2024 06:11:34 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AABEC58055;
	Wed, 10 Apr 2024 06:11:30 +0000 (GMT)
Received: from [9.109.201.126] (unknown [9.109.201.126])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Apr 2024 06:11:30 +0000 (GMT)
Message-ID: <4370fce5-323e-4f03-87e1-89632e724e2c@linux.ibm.com>
Date: Wed, 10 Apr 2024 11:41:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Fix wrong flag passed to
 set_rd_overutilized()
To: Hongyan Xia <hongyan.xia2@arm.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira
 <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
References: <0afb160788a297f8cda63b70385de5f6bddec11e.1712693356.git.hongyan.xia2@arm.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <0afb160788a297f8cda63b70385de5f6bddec11e.1712693356.git.hongyan.xia2@arm.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: un4r9Lr_rt2kTnGUGEQoyeGuTIQG8jnr
X-Proofpoint-ORIG-GUID: qB4C7_wiEUz-Y4iZBSkppMAtj4Aa8Er8
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_12,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404100043



On 4/10/24 1:43 AM, Hongyan Xia wrote:
> In update_sd_lb_stats(), sg_overloaded is passed to
> set_rd_overutilized(). This seems to be a typo during refactoring, which
> breaks many of my local EAS tests because overutilization is mistakenly
> triggered.
> 
> This fix makes those EAS tests work again.
> 

Yes. This is a needed fix. 

> Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>
 

FYI, Same patch has been posted by Vincent a week ago. 
https://lore.kernel.org/all/20240404155738.2866102-1-vincent.guittot@linaro.org/


> ---
> Hi Ingo,
> 
> Could you double check if this is the correct fix? Thank you.
> 
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1dd37168da50..bb1ae4ed0d91 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10661,7 +10661,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  		set_rd_overloaded(env->dst_rq->rd, sg_overloaded);
>  
>  		/* Update over-utilization (tipping point, U >= 0) indicator */
> -		set_rd_overutilized(env->dst_rq->rd, sg_overloaded);
> +		set_rd_overutilized(env->dst_rq->rd, sg_overutilized);
>  	} else if (sg_overutilized) {
>  		set_rd_overutilized(env->dst_rq->rd, sg_overutilized);
>  	}

