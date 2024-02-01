Return-Path: <linux-kernel+bounces-47817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3875C845345
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E743F2909CE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C62E15AAC5;
	Thu,  1 Feb 2024 08:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q9JoECAO"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE32D15AAC2
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 08:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706777953; cv=none; b=uDavaI67FpuCQvBaxCT2fBMzGHFYCNV0FBqJayETXNtcXvUUd2QY9AqQofhLblUEV/g9osgAgw5sTNGG4ccBl18dHc3dY6BhXzkyqtZyEgsN+PkWlEAj9tY0PYVKLEcZ8RshPheWA0impw8SO141HmvNxglPT51SK2A4MHsAkas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706777953; c=relaxed/simple;
	bh=ARWu7y4ysy7GV0e+4boG6515rAZYla4stSrODLczKBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=MPNuMX8zZ/jmsDDBSWPsDSAMXbDcyaImv3AvypEr2uNt0MXW3u+CYm0DF6aME9n0C0Mco6iJJiC3OH10RDpPr+4wsxqyPyT3APDVAtbbt6DscDHm/KzvOpfi5N8Elg7RByyVsFtKR7kHauK/iW4H3URLL5FIDm1lpRaMZZSQ7Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q9JoECAO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4117oas8014360;
	Thu, 1 Feb 2024 08:58:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : cc : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=6nFwU4fZcedSfhsfmBzR/q47yxY0htjwdWSweDb6mZY=;
 b=q9JoECAOVKWzuGNNfAmCF/i8Yro7569Bc26CMT85+om3Uo2plQ1qCNW+tzwaSQdyIsIQ
 8N1x/TIM74aqZtO2TQ5LdQkhYy1xG634cZ3BCl7b6AgHv+1ODt/mxUohwRk5EZtJkKME
 IKUIb3ns2TYAgk8xriR5on97v4YPdiwHycTLEMHrlxUEol60ZXIdzRcelz7U4poY0oGF
 kGmo+JYrd3VQBuYLVesn+WXMwDY1H3HT7ocrDlVty/GYLikuW4eLgJYKVW2nlaxGk3Ju
 XoXea4GIcrMng3pU2nb04CI0VO+jmuViWzMsrwAOu2fF0qN+RcISE8zS7Do4cRE2bBES TA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w05re3v3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 08:58:53 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4117ogg8014980;
	Thu, 1 Feb 2024 08:58:52 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w05re3v2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 08:58:52 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 411824br010858;
	Thu, 1 Feb 2024 08:58:51 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vweckts09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 08:58:51 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4118woTO33882460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Feb 2024 08:58:50 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5308358054;
	Thu,  1 Feb 2024 08:58:50 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6BC75805D;
	Thu,  1 Feb 2024 08:58:46 +0000 (GMT)
Received: from [9.109.201.126] (unknown [9.109.201.126])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Feb 2024 08:58:46 +0000 (GMT)
Message-ID: <d8779d81-4757-43e0-bc4c-5a2b346142dd@linux.ibm.com>
Date: Thu, 1 Feb 2024 14:28:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] sched/fair: add SD_CLUSTER in comments
To: alexs@kernel.org
References: <20240130131708.429425-1-alexs@kernel.org>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org,
        ricardo.neri-calderon@linux.intel.com
In-Reply-To: <20240130131708.429425-1-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 68Dt0aVDpO8mPDDqt2mQQQGN0A230kOU
X-Proofpoint-ORIG-GUID: KCDpqQVra0r-wvLJ7pU_rpFX8Z48iEbh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0
 mlxlogscore=953 bulkscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402010072



On 1/30/24 6:47 PM, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
> 
> The SD_CLUSTER omitted in following TOPOLOGY_SD_FLAGS explaination, add
> it to fill the absent.
> 
> Signed-off-by: Alex Shi <alexs@kernel.org>
> To: linux-kernel@vger.kernel.org
> To: Daniel Bristot de Oliveira <bristot@redhat.com>
> To: Ben Segall <bsegall@google.com>
> To: Steven Rostedt <rostedt@goodmis.org>
> To: Dietmar Eggemann <dietmar.eggemann@arm.com>
> To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> To: Valentin Schneider <vschneid@redhat.com>
> To: Vincent Guittot <vincent.guittot@linaro.org>
> To: Juri Lelli <juri.lelli@redhat.com>
> To: Peter Zijlstra <peterz@infradead.org>
> To: Ingo Molnar <mingo@redhat.com>
> ---
>  kernel/sched/topology.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 10d1391e7416..c342c52b1f34 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1554,6 +1554,7 @@ static struct cpumask		***sched_domains_numa_masks;
>   * function:
>   *
>   *   SD_SHARE_CPUCAPACITY   - describes SMT topologies
> + *   SD_CLUSTER		    - describes Cluster topologies

nit: would be better if - aligns. Some additional text in between. 

>   *   SD_SHARE_PKG_RESOURCES - describes shared caches
>   *   SD_NUMA                - describes NUMA topologies
>   *


On Patch 3/6 and 6/6 agree with Ricardo. It is more difficult to understand 
when it is compressed. Some future change in this function would make it more 
difficult. 

