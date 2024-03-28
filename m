Return-Path: <linux-kernel+bounces-122442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6FE88F790
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CADDB23B54
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 05:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B426C4C62E;
	Thu, 28 Mar 2024 05:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kJhtJxzi"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD1A3D55D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 05:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711605386; cv=none; b=JoCs+Nu5Fm3LWRwVCBQmCFP2G+TFIW2mJX/iIZwj8WyztlLl3OnDEX6ChhOWj/qRr1shTSjxoofezjiyzPZD5AfpkWrldqfX0a3p1YZm4E4a76s7zBmFBRSV/CU6beUnptZGvmLzBKt8jGLlPyVt4LffQelRpRdeMl9Wb0xYa70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711605386; c=relaxed/simple;
	bh=W9F6dKTx8apjtqWMs7sN48xTPDp7rEc9yPZmuSK5piU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=OTJTK7z33xCzQnY0Mcr0zn6beOTYprH650s6O6oJGxJgoMleTeV4QcyD6bL4wvxpODyhS85PRYJDxSaSeYUOBj783miBzxbWX0rxTacFc19hpAfaPc7v/Upj1G1hLffiqXhHoIr2p3qh5x19/tXZ6BI5Nw2LitB8sq5ZBLGbt7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kJhtJxzi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42S4s9Ge013568;
	Thu, 28 Mar 2024 05:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : cc : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=5iBy/ptrVfmV4CSoC8pTkTBKP/9KsD7p+66bZNrlyuA=;
 b=kJhtJxziow0+fJNENlWZE2GrrMt71yL9os067zOfqsiEGEzF5YWaEZLgWDf6E48g4grX
 j69cc814h5nCT/xDRnr4VN7JPrjKjtAgWVc8+FUEeELIZOVCBKwCvUhgFmnXfW/sLvv4
 YOmxG+mEzJNX6WJQ5R9NbLeMVsWRjkXiC5CsnBmgvzOgz4M9qqBIfGD0hqowX6sMRQ1C
 Cgy851xfFsJXJkbJu30mDXEtxyxSeoxXK6W/wEFeVpcqg/78uTewfuYS+JMK9dNAq43B
 YVcAaIgnqL+M0XPiuIl34QZstcPiCWc2hMTddVbiAcCU4d1EDube/AzZ8HrUULVzB8jC JA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x513r07e6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 05:55:55 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42S5tsA9010447;
	Thu, 28 Mar 2024 05:55:55 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x513r07dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 05:55:54 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42S3u7sn016410;
	Thu, 28 Mar 2024 05:51:40 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x29dubwth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 05:51:40 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42S5pbWo22151734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 05:51:39 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A4C958056;
	Thu, 28 Mar 2024 05:51:37 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C424F5803F;
	Thu, 28 Mar 2024 05:51:33 +0000 (GMT)
Received: from [9.109.201.126] (unknown [9.109.201.126])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 Mar 2024 05:51:33 +0000 (GMT)
Message-ID: <f6bd6617-b8fb-4760-a90b-ceeca6d4e415@linux.ibm.com>
Date: Thu, 28 Mar 2024 11:21:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] sched/fair: allow disabling newidle_balance with
 sched_relax_domain_level
To: Vitalii Bursov <vitaly@bursov.com>
References: <cover.1711584739.git.vitaly@bursov.com>
 <da4454bf368e51369c74e4574d22e8f0bfd9d368.1711584739.git.vitaly@bursov.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira
 <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <da4454bf368e51369c74e4574d22e8f0bfd9d368.1711584739.git.vitaly@bursov.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0dh4HQ8jmSb8Bkv3gcdyFXOIA2cbL5Gt
X-Proofpoint-GUID: L0huLa5-XIVqrPf0rZu6f2BFTRi5r8gd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_04,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403280035



On 3/28/24 6:00 AM, Vitalii Bursov wrote:
> Change relax_domain_level checks so that it would be possible
> to exclude all domains from newidle balancing.
> 
> This matches the behavior described in the documentation:
>   -1   no request. use system default or follow request of others.
>    0   no search.
>    1   search siblings (hyperthreads in a core).
> 
> "2" enables levels 0 and 1, level_max excludes the last (level_max)
> level, and level_max+1 includes all levels.
> 
> Signed-off-by: Vitalii Bursov <vitaly@bursov.com>
> ---
>  kernel/cgroup/cpuset.c  | 2 +-
>  kernel/sched/debug.c    | 1 +
>  kernel/sched/topology.c | 2 +-
>  3 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 4237c874871..da24187c4e0 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2948,7 +2948,7 @@ bool current_cpuset_is_being_rebound(void)
>  static int update_relax_domain_level(struct cpuset *cs, s64 val)
>  {
>  #ifdef CONFIG_SMP
> -	if (val < -1 || val >= sched_domain_level_max)
> +	if (val < -1 || val > sched_domain_level_max + 1)
>  		return -EINVAL;
>  #endif
>  
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 8d5d98a5834..8454cd4e5e1 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -423,6 +423,7 @@ static void register_sd(struct sched_domain *sd, struct dentry *parent)
>  
>  #undef SDM
>  
> +	debugfs_create_u32("level", 0444, parent, (u32 *)&sd->level);

It would be better if the level can be after group_flags since its a new addition?

>  	debugfs_create_file("flags", 0444, parent, &sd->flags, &sd_flags_fops);
>  	debugfs_create_file("groups_flags", 0444, parent, &sd->groups->flags, &sd_flags_fops);
>  }
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 99ea5986038..3127c9b30af 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1468,7 +1468,7 @@ static void set_domain_attribute(struct sched_domain *sd,
>  	} else
>  		request = attr->relax_domain_level;
>  
> -	if (sd->level > request) {
> +	if (sd->level >= request) {
>  		/* Turn off idle balance on this domain: */
>  		sd->flags &= ~(SD_BALANCE_WAKE|SD_BALANCE_NEWIDLE);
>  	}

Other than the above change looks good. 

