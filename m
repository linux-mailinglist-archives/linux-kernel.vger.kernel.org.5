Return-Path: <linux-kernel+bounces-147235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FE08A715C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9424284A40
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66BF132484;
	Tue, 16 Apr 2024 16:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KXmhhhYw"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5E143AA5
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713284951; cv=none; b=RpY3TR+Pjn2nZRdUe/fwIlH01gpKYADer64lw6M0+CdvlOsbY5OGSd9uXMWj1kKMXkbUg1Z9r3d66pIBu79HlG8HyhMXe8QS09BpKF2JM67TSFYu1y4WAqkihBwCZTQ+osGtw3vn1jP9MfXdPbtN8V+aEpSL81FEHuR8IlzLEfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713284951; c=relaxed/simple;
	bh=pWTN710K0GAoCxnDcr+MGkw5lhjx+xF+6D5iLDvKMfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ie55j7bL9CB0UVPykj78XFHqOSCz4592PpspxQmQzRv2dEfhx29TWMGZ9HA2Us8M08wNVpuJzrL6d2FqpDCExOki7CUMAE9XJfPRyqO37I/8DkQX3vhGzQE5/LM59Ma3cAo1Y8HoFGdvkFklmWXurp5zloRY6U4cSXqe6iinds8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KXmhhhYw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43GGM81G019629;
	Tue, 16 Apr 2024 16:28:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=M/Jg7JWqI6UX86/ybDV9RYMD3Fu8CKqmYeH83wB2YOY=;
 b=KXmhhhYw9IT7j0OcNt1+9kojQHvRL/NAB9Di4D8iWT0at9Sm+M2jKc1qW/07Gi/apGtf
 Uy0UaxPrs6nju+u0zcEXD1tBHde12cKv/5XJVHW4HiMmF3iLUn9hEH4c0xU6tCG51/x/
 f0xMpKdC5i/FzIHybfJ/2VLgR+dsCwI1YHstHU7qO81/kwkO7BkAXLG2Hd4139H+PFtk
 mRUepkaxzc7bzmxrwO4617QqP+b37pWvFc0xS0/F8JJhV0rxmoZ6lIkrxf45VBbDJKDy
 ZEuO/qIoo1t+poUHDXwGC3I7bcDGLr3DiAEaP7d66jf80xIPgbY8wOKphUCZTyBLUBeV JA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xhvsp80wt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 16:28:54 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43GGOIaB022939;
	Tue, 16 Apr 2024 16:28:54 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xhvsp80wm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 16:28:53 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43GDpBK2021351;
	Tue, 16 Apr 2024 16:28:52 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xg6kkeuag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 16:28:52 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43GGSntn43516240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 16:28:51 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B27720043;
	Tue, 16 Apr 2024 16:28:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A30A820040;
	Tue, 16 Apr 2024 16:28:46 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.179.12.58])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 16 Apr 2024 16:28:46 +0000 (GMT)
Date: Tue, 16 Apr 2024 21:58:44 +0530
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
Message-ID: <Zh6nPAwdAmGEEn7V@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: qZ4krOU15I-f0fmNW4EWriW9u_Js6T-8
X-Proofpoint-GUID: x9xewc0Bu1e-5NJjYMLMWJeXtKDhY8hZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_14,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404160101

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
Reviewed-by: Vishal Chourasia <vishalc@linux.ibm.com>

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
>  			sa->util_avg /= (cfs_rq->avg.load_avg + 1);
>  
>  			if (sa->util_avg > cap)
> -- 
> 2.40.1
> 

