Return-Path: <linux-kernel+bounces-108444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB96880A9D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA7681F22CEC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 05:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9E81DFCF;
	Wed, 20 Mar 2024 05:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dqA7Mduw"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992531D69E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 05:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710912288; cv=none; b=qq45gO8uP9s/htdAFyNqzuNIbdED4gqJ5T4ImcM0Mgk6pfbrLeodglydkck3on/83bHtDu8L0ehax3X+RK/Cy5i/KKJveg8xBRYhLhGtwjN64Wq09pLbayIW2j+EQEoOUxm7MaKIPego3tSMfpK3f+hjSS2JmmhwdVIuWp75OV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710912288; c=relaxed/simple;
	bh=RP6Tt8rFld+sb/Jt8SMIqGIH7VRkdgv2Y6r8ppWt4VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwutCO+eZ3nhCQlmIY2Omh2KxHcUYupxXpyt9LHHKE8lR4zxvDw/zBkn9bcOjr0y1Fy75Pi/2Q7RNHLrVsAEoghUM03I3+BZ5CmGbrPv8oLHNzej+b5LeLEZWphv65B+gCy8wYnXhRsNwI7kbnHQvDrl2uwSlv2gAUUOEv2hoJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dqA7Mduw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42K5IEWU031667;
	Wed, 20 Mar 2024 05:24:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=0V2HzHysJ/ZtIszdlmyx1eLd+prfp++SjM6y+MVdtbQ=;
 b=dqA7Mduw6/bD2/92qH8f2HrkyqdJLKBzSVJzGeQLIf7pf35n9+rhCP3NbUTD7k7C9NSd
 0SU4jx/SgubVRQgCGiG7DXDrZ98WBMfw6BSgZTyK45dZdv4Y5CVLYVcFu4kWl+sqVqwC
 F9UqXr4Zfe65gdK5plDebSpgn3iwX6rUNNJLO6A4G3BEip//wF3GFErISSPkmijLgO6D
 A0CTYiFT/D4ybDMYhIRMlBG83mbF5x8Ee14hpkMycgX4rwYbzdOcAwhlaj8BgqjDtzjJ
 UOouzSSTu70Irm8xhYB4KF/dfBZJhWqxHb1WRMZJPd1g2Ercn9r8wUVK43NZTO6aiWEH GA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wysh1g0bt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 05:24:01 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42K5O0Pt007891;
	Wed, 20 Mar 2024 05:24:00 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wysh1g0bm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 05:24:00 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42K4C8sT015781;
	Wed, 20 Mar 2024 05:23:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wwp504fm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 05:23:59 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42K5NtFo45351380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 05:23:57 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4ADB720040;
	Wed, 20 Mar 2024 05:23:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9731B2004F;
	Wed, 20 Mar 2024 05:23:51 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.204.201.194])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 20 Mar 2024 05:23:51 +0000 (GMT)
Date: Wed, 20 Mar 2024 10:53:45 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Phil Auld <pauld@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
        kernel-team@android.com, Zimuzo Ezeozue <zezeozue@google.com>
Subject: Re: [RESEND][PATCH v2] sched: Add trace_sched_waking() tracepoint to
 sched_ttwu_pending()
Message-ID: <Zfpy4Z4MhErKrHBZ@linux.ibm.com>
References: <20240318192846.75299-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318192846.75299-1-jstultz@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oqj24DlpmhipQc_GzSKH6OOBWDBK-ayw
X-Proofpoint-GUID: R2Lta8Cr-s3yQoKJXQtVINYC5BLBArcl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_02,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 clxscore=1011 phishscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403200040

Hi,
On Mon, Mar 18, 2024 at 12:28:33PM -0700, John Stultz wrote:
> Zimuzo reported seeing occasional cases in perfetto traces where
> tasks went from sleeping directly to trace_sched_wakeup()
> without always seeing a trace_sched_waking().
> 
> Looking at the code, trace_sched_wakeup() is only called in
> ttwu_do_wakeup()
> 
> The call paths that get you to ttwu_do_wakeup() are:
> try_to_wake_up() -> ttwu_do_wakeup()
> try_to_wake_up() -> ttwu_runnable() -> ttwu_do_wakeup()
> try_to_wake_up() -> ttwu_queue() -> ttwu_do_activate() -> ttwu_do_wakeup()
> sched_ttwu_pending() -> ttwu_do_activate() -> ttwu_do_wakeup()
Notably, sched_ttwu_pending() is invoked for remote wakeups.

Given this, I anticipate a scenario similar to the following 
occurred: When a process (P) is to be awakened on a remote CPU, 
the scheduler adds P to the remote CPU's wakelist,a per-CPU queue,
and sends an IPI to the remote CPU. This action triggers 
sched_ttwu_pending() on the remote CPU, which then processes the
wakelist and wakes up the queued processes.

In this scenario, the "waking trace" of P, signifying the initiation
of the wake-up, is recorded on the CPU where try_to_wake_up was executed.
Meanwhile, the "wakeup trace," denoting the completion of the wake-up,
is observed on the remote CPU where sched_ttwu_pending() is executed.

Is there a possibility that something other than the above occurred
in your case?
>
> where trace_sched_waking() is currently called only in
> try_to_wake_up().
> 
> So add a trace_sched_waking() call to sched_ttwu_pending(), so
> we see the same state machine transitions.
> 
> With this change, the number of unexpected state transitions in
> perfetto was greatly reduced.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Phil Auld <pauld@redhat.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: kernel-team@android.com
> Reviewed-by: Phil Auld <pauld@redhat.com>
> Reported-by: Zimuzo Ezeozue <zezeozue@google.com>
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
> v2:
> * Minor commit message fix suggested by Phil Auld
> ---
>  kernel/sched/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9116bcc90346..233f06360d6a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3894,6 +3894,7 @@ void sched_ttwu_pending(void *arg)
>  		if (WARN_ON_ONCE(task_cpu(p) != cpu_of(rq)))
>  			set_task_cpu(p, cpu_of(rq));
>  
> +		trace_sched_waking(p);
>  		ttwu_do_activate(rq, p, p->sched_remote_wakeup ? WF_MIGRATED : 0, &rf);
>  	}
>  
> -- 
> 2.44.0.291.gc1ea87d7ee-goog
> 

