Return-Path: <linux-kernel+bounces-154544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F5D8ADD6F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B2101C217E6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 06:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598DB22619;
	Tue, 23 Apr 2024 06:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q9VCzKRn"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11901F941
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 06:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713853248; cv=none; b=kTv4upQ3wmCgLE1PARh4go6iVhpf5UH3f0HtOcw6qBVzgwPr9zptJsNN//URxR98lsOk2gJLSxxFVaofzc6Dy9/rVCw593G1yIdH5mzUL1LflpSEC8Dtfs7rz2rnsCNwaRcT3i+pxfQN1+st1O6m62Lr+gCb5Ekx6QS/q2ynZSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713853248; c=relaxed/simple;
	bh=J6Fj1F3NpWgKsDIEg8NuZo1Or6yC7yCLCTvbT2l50q8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dxY7MPNUzAX25XtBjL/OgH0yRSjm/GjFjz/6EzXieCnYEs5GZ13omyGo6wUOfXF7QnWpoJcJ0DRsqadYOuEtI45IJiMECoa7FNov3acK2RwYk0himv6UqGgp3hyp0kLxzc7Ugxw/OMstrb/9bsI/iWRh9Wkh7+SYRryiPMxUiGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q9VCzKRn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43N5jjMt002786;
	Tue, 23 Apr 2024 06:20:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=9i+gI7GJTP6aOmWlB0wfD0+m11Dn+3jK6XAXlpAEIkw=;
 b=Q9VCzKRnSPDFCZz8x7uyuQJjfOLbG533yPUMHwj+8yRd2zK384iNViR/YNCUM2p9nVTf
 vkAGFG/Dj4wjBo0rsVGVDDmE27F/JIEGAfacKfyoqSay005nv+JZ/EDW8h3OJIhFelah
 xQdnoH9kVQAxQYw1FdyCr9MdKxZTtEArFEyIB3Y6Es1YHkVbZUL+eDqLu0t1gTMFXCmy
 v8k48cRnzRHNIbmZOcNb3DL9twkRD3cfW0sry8M3Fy92LqRlxQYrKlpDJvn6mbTVEm6x
 Q3Ob2fyGs39KrblHJKA4wZL9SBrkbYIza8HVz4fB04+nQ5hu3kPUiuPLODf7SDGrdhEe sw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xp5fmr445-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 06:20:42 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43N6KgqE029387;
	Tue, 23 Apr 2024 06:20:42 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xp5fmr443-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 06:20:42 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43N2lbFB029905;
	Tue, 23 Apr 2024 06:20:41 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmr1tc884-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 06:20:41 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43N6Kcbk41156920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 06:20:40 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B7B72004F;
	Tue, 23 Apr 2024 06:20:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 027532004E;
	Tue, 23 Apr 2024 06:20:38 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 23 Apr 2024 06:20:37 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: fix selection of wake_cpu in kick_pool()
In-Reply-To: <ZiboW5wm5M8Ee6ip@slm.duckdns.org> (Tejun Heo's message of "Mon,
	22 Apr 2024 12:44:43 -1000")
References: <20240415053550.538722-1-svens@linux.ibm.com>
	<ZiboW5wm5M8Ee6ip@slm.duckdns.org>
Date: Tue, 23 Apr 2024 08:20:37 +0200
Message-ID: <yt9dr0ew8uru.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nZP3TTNkkYjut-E6EjqciBvhivWWlalc
X-Proofpoint-ORIG-GUID: gbUNgFpjofqZqhhKhkzhMMD-wzQfN6dX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_04,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404230017

Tejun Heo <tj@kernel.org> writes:

> Hello,
>
> On Mon, Apr 15, 2024 at 07:35:49AM +0200, Sven Schnelle wrote:
>> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
>> index 0066c8f6c154..d02b0c02c9e2 100644
>> --- a/kernel/workqueue.c
>> +++ b/kernel/workqueue.c
>> @@ -1277,7 +1277,8 @@ static bool kick_pool(struct worker_pool *pool)
>>  	    !cpumask_test_cpu(p->wake_cpu, pool->attrs->__pod_cpumask)) {
>>  		struct work_struct *work = list_first_entry(&pool->worklist,
>>  						struct work_struct, entry);
>> -		p->wake_cpu = cpumask_any_distribute(pool->attrs->__pod_cpumask);
>> +		p->wake_cpu = cpumask_any_and_distribute(pool->attrs->__pod_cpumask,
>> +							 cpu_online_mask);
>
> So, this wouldn't necessarily fix the problem completely but regardless of
> how that's plugged, this is still something we want to do to avoid picking
> offline CPUs. Can you please update the patch description accordingly and
> resend?

I'll just sent v2. I didn't mention the arch_vcpu_is_preempted() issue
in the commit description, as i'm not yet sure whether that's a wrong
assumption the s390 code or in the common code. Still waiting whether
Peter has some insight.

