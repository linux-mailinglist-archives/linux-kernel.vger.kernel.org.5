Return-Path: <linux-kernel+bounces-88201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2A886DE8F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8277B283EF4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222406A8BA;
	Fri,  1 Mar 2024 09:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S2bHFfW+"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE141E4BD
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 09:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709286508; cv=none; b=DhtNqn95DL1AHAYaAZ1kCEQZYhj46rc6wx0I3KC84/nlC7FzPZHU0qpqpyn/VhoLGEefj4D5wAhJb7NJAtN8qMZ7IFoEn2I6Q0TkVjPxEO1vnPxxG9bkPCuJ2S66X7ucvm8fM4HL2HRoUaRF4CNa0Cm6ybU08WnN3qAmKx3HvB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709286508; c=relaxed/simple;
	bh=zfr2/Z4XDDvKRxaran7leIT1e/JMlRwrHfuX/mcUawE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Luopc2C3cWsqRxarbplMUKJkYbvlkwAidGYyXJJkuUI0KaUvWa+rDVWgl9dR75+71i5TlDq6kjz3kzRNYFzko/lJUnbLOj/zD4aLUwuwa32TVKzM+f89JPz06766OxplF+4ITrUJnYhadECeFWCTach2KZxrDDJCVHCMJyU+C2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S2bHFfW+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4219RbFl019260;
	Fri, 1 Mar 2024 09:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=bQHgKVrBps8F4ZTJ72KaBlIvOaPrhJSEKrvDGJ2dDIw=;
 b=S2bHFfW+pI6fncYQdpehLXKze7VXgbIEpQ6yc+DmcU7JwASz9+pHizpSCCVowDaV0GPN
 U9Fx9F7gv1JRFs7DCgponu9gmhfyBJVCJKkP6Vhetl3tHyY02V+SHgZAbjpbEry8zA3E
 YmkGsNa6NkNKt7H8bnzNMftZQWeRTi1IkFV1UMCDTJg6Ufb3qIcqdHIzLEgny63NxpxP
 kYJfMrxzxYFqQqvazFPV8f9QRUDhrq2+MO63U3eftw4+INBHlosGhom6uSaFXHywBlO6
 EW8BVvRSxOThSLxcDOK9aIoLCVnpL0EsfrCAFzr8mhc3qF8kBuy9a6ZhuzFDjYTiFki7 RQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wkcderj76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 09:48:10 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4219lGU8031973;
	Fri, 1 Mar 2024 09:48:10 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wkcderj57-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 09:48:10 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4216X6CJ008211;
	Fri, 1 Mar 2024 09:26:44 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfv9mu98s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 09:26:43 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4219QckC23921392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Mar 2024 09:26:40 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4122D20043;
	Fri,  1 Mar 2024 09:26:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4859820040;
	Fri,  1 Mar 2024 09:26:35 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri,  1 Mar 2024 09:26:35 +0000 (GMT)
Date: Fri, 1 Mar 2024 14:56:34 +0530
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        yu.c.chen@intel.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, nysal@linux.ibm.com,
        aboorvad@linux.ibm.com, vschneid@redhat.com, pierre.gondois@arm.com,
        morten.rasmussen@arm.com, qyousef@layalina.io
Subject: Re: [PATCH v3 1/2] sched/fair: Add EAS checks before updating
 overutilized
Message-ID: <20240301092634.GA826313@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.ibm.com>
References: <20240229104010.747411-1-sshegde@linux.ibm.com>
 <20240229104010.747411-2-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240229104010.747411-2-sshegde@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0pi7lsYlI7UA7qBOqIvqvCNlVBwcCxqx
X-Proofpoint-ORIG-GUID: 6-7toBEoOt6Ge1I9Jekxg8_jUXVlY332
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_05,2024-03-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403010082

* Shrikanth Hegde <sshegde@linux.ibm.com> [2024-02-29 16:10:09]:

> Overutilized field of root domain is only used for EAS(energy aware scheduler)
> to decide whether to do load balance or not. It is not used if EAS
> not possible.
> 
> Currently enqueue_task_fair and task_tick_fair accesses, sometime updates
> this field. In update_sd_lb_stats it is updated often. This causes cache
> contention due to true sharing and burns a lot of cycles. overload and
> overutilized are part of the same cacheline. Updating it often invalidates
> the cacheline. That causes access  to overload to slow down due to
> false sharing. Hence add EAS check before accessing/updating this field.
> EAS check is optimized at compile time or it is a static branch.
> Hence it shouldn't cost much.
> 
> With the patch, both enqueue_task_fair and newidle_balance don't show
> up as hot routines in perf profile.
> 
> 6.8-rc4:
> 7.18%  swapper          [kernel.vmlinux]              [k] enqueue_task_fair
> 6.78%  s                [kernel.vmlinux]              [k] newidle_balance
> +patch:
> 0.14%  swapper          [kernel.vmlinux]              [k] enqueue_task_fair
> 0.00%  swapper          [kernel.vmlinux]              [k] newidle_balance
> 
> Minor change: trace_sched_overutilized_tp expect that second argument to
> be bool. So do a int to bool conversion for that.
> 
> Fixes: 2802bf3cd936 ("sched/fair: Add over-utilization/tipping point indicator")
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Looks good to me.

Reviewed-by: Srikar Dronamraju <srikar@linux.ibm.com>
-- 
Thanks and Regards
Srikar Dronamraju

