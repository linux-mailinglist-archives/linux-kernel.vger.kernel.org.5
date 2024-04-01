Return-Path: <linux-kernel+bounces-126434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EED8937F7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 06:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 269D41F21460
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 04:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BAA8BE7;
	Mon,  1 Apr 2024 04:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fVUKuJSV"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC53610E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 04:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711944399; cv=none; b=FOKC7UWN/7hsnevaZcPpkBGhc5UiPQM+ZzRKldyemvd6WuDCy9IO+3b4GnYvsX2tCgWS7N9sVrXw1tMeMPsPblhYPJriDuQIaaTEV99QoJ1y+siUvP9k+u5yQXX+MMcvPw1OeC71VHNh76/6gEZ6RCI4WPWkTu2eb4woLK+vdgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711944399; c=relaxed/simple;
	bh=ynbA2WEckT0vXSCyXDSdUH4q0NlFt2a/4Z2xqVkXpSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=LFdUORqSL1QQyDkk6xKMVmJHUBNlObgry4BfdS8d0xdAF16BHRqrlJqvam35K3K+GJJo/+w5ygDzQGvFFwv4yUUi6JZT0hmmVEbBetBYuclBW2yGpnNieDFWxyQELWHQc9EP/dCl5NNWMq2L//Qf845z1L45sxEUGXEvjK5Y+ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fVUKuJSV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4312h0b8027403;
	Mon, 1 Apr 2024 04:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : cc : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=JXSrEyPQgd3wA0GR1Y2eUGrmRkgOY09OwRKpE646EvE=;
 b=fVUKuJSVvVxINVTtoquYnZnqSAVzj1MMQzz981kCZwQrvlanOog7eZgOefx+m+kXTulu
 LleOatCz5R8BkU0fObEICVkDBEgkzWa1o/W4REwVnODdMNTQ41NjHe/eQ0w9XLu/7Zge
 uYZ3ZdcivjtnJ2u8HkCUV/uXfyMX4xSPjl1Yc2i4/Z1glc/KEAoNNWxCr6aItfzMIVc/
 SgM7JAt1U0q/pfksmtbaGkYbuYLQeqWCKL7zGE2om01qBvoD42/4HdJtyS0kOFpIgfs/
 /8ccUBHwrzzppbrVLgeh9u++EeNfn8YL7/avtfcZnhpBaPwWgc8OX9LL8NFoXYkX7SV4 2w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x7mcm83gh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 04:05:54 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43145rYW018618;
	Mon, 1 Apr 2024 04:05:53 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x7mcm83ge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 04:05:53 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4312v3gd008422;
	Mon, 1 Apr 2024 04:05:52 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x6w2tpdgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 04:05:52 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43145nng39125474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Apr 2024 04:05:52 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7E2E5803F;
	Mon,  1 Apr 2024 04:05:49 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 388B95807A;
	Mon,  1 Apr 2024 04:05:46 +0000 (GMT)
Received: from [9.109.201.126] (unknown [9.109.201.126])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Apr 2024 04:05:45 +0000 (GMT)
Message-ID: <3d85926d-378a-4d5e-8303-92461bd3b100@linux.ibm.com>
Date: Mon, 1 Apr 2024 09:35:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] docs: cgroup-v1: clarify that domain levels are
 system-specific
To: Vitalii Bursov <vitaly@bursov.com>
References: <cover.1711900396.git.vitaly@bursov.com>
 <af9562aac2e9208029aef1dd19c3b0e096dd42c7.1711900396.git.vitaly@bursov.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira
 <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <af9562aac2e9208029aef1dd19c3b0e096dd42c7.1711900396.git.vitaly@bursov.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: u4I2AvkUrlkLyWve1FQVoYBuSmoeVVJ4
X-Proofpoint-GUID: gzNTFiDtW38t2TA-l1S1YGuMGroXIeCr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_01,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 mlxscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2404010027



On 3/31/24 9:31 PM, Vitalii Bursov wrote:
> Add a clarification that domain levels are system-specific
> and where to check for system details.
> 
> Add CPU clusters to the scheduler domain levels table.
> 
> Signed-off-by: Vitalii Bursov <vitaly@bursov.com>
> ---
>  Documentation/admin-guide/cgroup-v1/cpusets.rst | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v1/cpusets.rst b/Documentation/admin-guide/cgroup-v1/cpusets.rst
> index 7d3415eea..d16a3967d 100644
> --- a/Documentation/admin-guide/cgroup-v1/cpusets.rst
> +++ b/Documentation/admin-guide/cgroup-v1/cpusets.rst
> @@ -568,19 +568,25 @@ on the next tick.  For some applications in special situation, waiting
>  
>  The 'cpuset.sched_relax_domain_level' file allows you to request changing
>  this searching range as you like.  This file takes int value which
> -indicates size of searching range in levels ideally as follows,
> +indicates size of searching range in levels approximately as follows,
>  otherwise initial value -1 that indicates the cpuset has no request.
>  
>  ====== ===========================================================
>    -1   no request. use system default or follow request of others.
>     0   no search.
>     1   search siblings (hyperthreads in a core).
> -   2   search cores in a package.
> -   3   search cpus in a node [= system wide on non-NUMA system]
> -   4   search nodes in a chunk of node [on NUMA system]
> -   5   search system wide [on NUMA system]
> +   2   search cpu clusters
> +   3   search cores in a package.
> +   4   search cpus in a node [= system wide on non-NUMA system]
> +   5   search nodes in a chunk of node [on NUMA system]
> +   6   search system wide [on NUMA system]

I think above block of documentation need not change. SD_CLUSTER is a software 
construct, not a sched domain per se. 

IMO the next paragraph that is added is good enough and the above change can be removed.

>  ====== ===========================================================
>  
> +Not all levels can be present and values can change depending on the
> +system architecture and kernel configuration. Check
> +/sys/kernel/debug/sched/domains/cpu*/domain*/ for system-specific
> +details.
> +
>  The system default is architecture dependent.  The system default
>  can be changed using the relax_domain_level= boot parameter.
>  

