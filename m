Return-Path: <linux-kernel+bounces-97313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A7A8768A8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9BD21C2237D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FA6CA7D;
	Fri,  8 Mar 2024 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H/Yec1qF"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB21291E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 16:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709916032; cv=none; b=dEMVIHax0S+dvgduJHVe3lotxtEpAV1jwRD1SoVFJnDcB2arwxekGjxu2Z6ANHF58vrEKlBZXUijNtVtCe0LSIVcS/DeZp7VgBJsC1wbpmhz3tyn5oAD9BZndvChoLQlV/mPoCt8lApCtcW9eOueSvr3dDfGuyIE59UC2vrOCMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709916032; c=relaxed/simple;
	bh=ZUg+0eyFf8SLa+7/psF6zUUJXHTZ5YicG+qyXXCAn+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZFg1dqIOJqIPr4FZyXek5MF3CRXQTP/w1VdSXUtaPniw19ffweeolGwpTGZgyhJrvKOOcjt50mE8D9/PAfYvBnxcH1wGakS2FPjLR1v9rTcnuh2SQPznIjQzXRNWmcHOT8DNx41qIs21zA3a7aPYu7oT3eBSLJpjOAZn+ovbps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H/Yec1qF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 428GM63c018947;
	Fri, 8 Mar 2024 16:40:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=EWCnq4p+1XmWnlfA383L83BWP0XbwgMcLrJy6nqjYcI=;
 b=H/Yec1qFBUBIue8rhgRVOovi+xE1xLSSjb8P+adM9Wn18aCUBfBvjHnzr4BkCE2ZTIyt
 YiNp7l/AsWyK82RknnsSlzs2NCa41qxClHvPqhYtK9CntwziK0qhutUQQSq/DHqMRkYn
 B0MGsSmCxTwkhH8I24rZSg5NKFyIpwRpq+dU03lkNi/wBw5dReelS+3e9dSSSpLlAGVn
 KTUQk2aLBK4HjV3x8Hmz34k1AU+EKufysfKM9uXxijY2GFLVU1uHdqITXNarcbwEaQy/
 gTD7BuVGVR+ptDS0tzU0yA3NQGYAF1bcNpk9C4yV9k2u5RPiETT5sNOFN+owLISPgCug nA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr64qgarx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 16:40:16 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 428GcIU6031791;
	Fri, 8 Mar 2024 16:40:15 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr64qgarf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 16:40:15 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 428DjPRw025399;
	Fri, 8 Mar 2024 16:40:14 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmeu05qed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 16:40:14 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 428GeBJm39190784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Mar 2024 16:40:14 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C19CC58066;
	Fri,  8 Mar 2024 16:40:11 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 187B558069;
	Fri,  8 Mar 2024 16:40:09 +0000 (GMT)
Received: from [9.43.68.167] (unknown [9.43.68.167])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 Mar 2024 16:40:08 +0000 (GMT)
Message-ID: <14d29fdf-ef10-48e6-a102-f1f0bb27c181@linux.ibm.com>
Date: Fri, 8 Mar 2024 22:10:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] sched/debug: Increase SCHEDSTAT_VERSION to 16
Content-Language: en-US
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>
References: <20240308105901.1096078-1-mingo@kernel.org>
 <20240308105901.1096078-5-mingo@kernel.org>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20240308105901.1096078-5-mingo@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: f38fy00-BC0dDZnjdEbZ4g4VI-GUQbwY
X-Proofpoint-ORIG-GUID: AkjUf_JYpsyfi5TErVzCCpO2qxKY8UA-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 adultscore=0 clxscore=1011 malwarescore=0 mlxlogscore=655 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080134



On 3/8/24 4:28 PM, Ingo Molnar wrote:
> We changed the order of definitions within 'enum cpu_idle_type',
> which changed the order of [CPU_MAX_IDLE_TYPES] columns in
> show_schedstat().
> 

> +++ b/kernel/sched/stats.c
> @@ -113,7 +113,7 @@ void __update_stats_enqueue_sleeper(struct rq *rq, struct task_struct *p,
>   * Bump this up when changing the output format or the meaning of an existing
>   * format, so that tools can adapt (or abort)
>   */
> -#define SCHEDSTAT_VERSION 15
> +#define SCHEDSTAT_VERSION 16

Please add the info about version, and change of the order 
briefly in Documentation/scheduler/sched-stats.rst as well.

One recent user that I recollect is sched scoreboard. Version number should 
be able to help the users when they it is breaking their scripts. 

+Gautham, Any thoughts?

>  
>  static int show_schedstat(struct seq_file *seq, void *v)
>  {

