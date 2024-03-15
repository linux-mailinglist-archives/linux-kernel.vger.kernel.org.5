Return-Path: <linux-kernel+bounces-104685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B39387D251
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C16311F21993
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752F253381;
	Fri, 15 Mar 2024 16:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OJJWG1i4"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A6B524DC
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 16:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521856; cv=none; b=XS068S+J09E5C0eIYMkUEAqKwRrobntpi9VwIL8FjfoRhAjbSElLza7vRa49WjFpFSdNXrfnDjYeTD68PTUIVg7MpevYm5ZfQ/weIu/TfCW/V7jZcZPp7vE08nw9MzeVKK/H4Is3z3WAV1/gStgD7br8lOE3SW+24zbURAwVOdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521856; c=relaxed/simple;
	bh=WimFR7ITQrmkFcoFGh2AHJsZ9wmaC+CJskD91gLKrVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ck3Yfx70fVdURgpu3nEKCwIQyAImGwgv2cFa0Wvv2vpOrBBuzayigUa6OfcXYDSIWUeb8ucgliClFnLp4/GBRIz8IgSUTHj5v2jmNEEHKDAmeZ6kEDCCFklcZreXu0PVl9efmfezIbqoJT19Gz4KqGg984isYw/orIkgO0zQ8TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OJJWG1i4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42FGruHa009940;
	Fri, 15 Mar 2024 16:57:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=NTDl56stJqPp+lYbN4nX8xK0uWErWe/2mnAm+XA8P+4=;
 b=OJJWG1i4iMf4PFTD7c2vJL2CtAxUginsfkrEJdS6op8hXjtA2dvrRERPGe4kI+zPerkY
 iqJbmEw3jDvpMnetuCeGMlai59Z+FC0rdJSQteyvudMY/2CVJP0ZhuWKRFrCOrwWu4ZK
 FWtY2hG9nM6qtPYZdaAzwh0XDlTIc8SvN80MW7ES2KPvy5WnBehulfKYsvxrw3FFLqdh
 NLM+84koM6SMx+bzN+s0T32/YijNscktjcEY+hzBpgXNVKbqGQeitWfJqD6YAuX3aApZ
 6U7k8ZJtzFY7GdKt6z4y5mKqhGCTrMPAINov+ATqDg5VPFoL68m9JysR6Y9TIeGyLgVR Aw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wvt06g7px-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 16:56:57 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42FGuuLF015276;
	Fri, 15 Mar 2024 16:56:56 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wvt06g7pr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 16:56:56 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42FGYBhd028496;
	Fri, 15 Mar 2024 16:56:55 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wvsyd03tm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 16:56:55 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42FGurjq23986866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Mar 2024 16:56:55 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F89D58058;
	Fri, 15 Mar 2024 16:56:53 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAC8F58060;
	Fri, 15 Mar 2024 16:56:48 +0000 (GMT)
Received: from [9.79.180.58] (unknown [9.79.180.58])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Mar 2024 16:56:48 +0000 (GMT)
Message-ID: <839ae17e-3818-463d-9a5c-3c1eac927ae8@linux.ibm.com>
Date: Fri, 15 Mar 2024 22:26:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] sched: Report the different kinds of imbalances in
 /proc/schedstat
Content-Language: en-US
To: Swapnil Sapkal <swapnil.sapkal@amd.com>
Cc: mingo@redhat.com, peterz@infradead.org, torvalds@linux-foundation.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        vincent.guittot@linaro.org, gautham.shenoy@amd.com,
        kprateek.nayak@amd.com, linux-kernel@vger.kernel.org
References: <20240315135501.1778620-1-swapnil.sapkal@amd.com>
 <20240315135501.1778620-2-swapnil.sapkal@amd.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20240315135501.1778620-2-swapnil.sapkal@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cwG0tGTw4ZS7kwTGrdkjwlECaNSjSr2m
X-Proofpoint-GUID: cWvzWzbDfWmpnQRyx8H8rrR-qYEd-VVj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-15_04,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403150138



On 3/15/24 7:25 PM, Swapnil Sapkal wrote:
> In /proc/schedstat, lb_imbalance reports the sum of imbalances
> discovered in sched domains with each call to sched_balance_rq(), which is
> not very useful because lb_imbalance does not mention whether the imbalance
> is due to load, utilization, nr_tasks or misfit_tasks. Remove this field
> from /proc/schedstat.
> 
> Currently there is no field in /proc/schedstat to report different types
> of imbalances. Introduce new fields in /proc/schedstat to report the
> total imbalances in load, utilization, nr_tasks or misfit_tasks.
> 
> Added fields to /proc/schedstat:
>  	- lb_imbalance_load: Total imbalance due to load.
> 	- lb_imbalance_util: Total imbalance due to utilization.
> 	- lb_imbalance_task: Total imbalance due to number of tasks.
> 	- lb_imbalance_misfit: Total imbalance due to misfit tasks.
> 
> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
> ---
>  Documentation/scheduler/sched-stats.rst | 119 ++++++++++++++----------
>  include/linux/sched/topology.h          |   5 +-
>  kernel/sched/fair.c                     |  21 ++++-
>  kernel/sched/stats.c                    |   7 +-
>  4 files changed, 98 insertions(+), 54 deletions(-)
> 
> diff --git a/Documentation/scheduler/sched-stats.rst b/Documentation/scheduler/sched-stats.rst
> index 7c2b16c4729d..e2a6b53a38ee 100644
> --- a/Documentation/scheduler/sched-stats.rst
> +++ b/Documentation/scheduler/sched-stats.rst
> @@ -6,10 +6,15 @@ Version 16 of schedstats changed the order of definitions within
>  'enum cpu_idle_type', which changed the order of [CPU_MAX_IDLE_TYPES]
>  columns in show_schedstat(). In particular the position of CPU_IDLE
>  and __CPU_NOT_IDLE changed places. The size of the array is unchanged.

Size of the array would change after this patch. So this line can be updated. 


> +Also stop reporting 'lb_imbalance' as it has no significance anymore
> +and instead add more relevant fields namely 'lb_imbalance_load',
> +'lb_imbalance_util', 'lb_imbalance_task' and 'lb_imbalance_misfit'.
>  

Rest of the changes look good to me. 
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

