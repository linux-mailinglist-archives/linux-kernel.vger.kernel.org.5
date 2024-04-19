Return-Path: <linux-kernel+bounces-151164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 545408AAA26
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 091961F21D5E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EE85FB95;
	Fri, 19 Apr 2024 08:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L7Qc9X8A"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5299565BA8
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713515247; cv=none; b=W7+Z7QfKc9EREjfLMWRgLdyfOBC9Ehhg5h9u15rvRcSrV1vsmWFEgvlCLfItvlASMZnQBskxeTNxdLWqxeb408aQS/wBIcY+lOQ8VDOF2yssUCpK1TOW3jVoLSMWJch5/zZ2k/QdJylpyLr1mHEyHJpOEOINgn2HqQdN7FCK8SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713515247; c=relaxed/simple;
	bh=aP8T+L34lw2c4CnWLlQ0WQsB+pBClVN9MOPNilVm71Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z4NNeSGkPX9hymjyQOTGAHw1oiQDrX+HZRfof92+997Eka+GONPhJQAqKzxnu75iV+NIY08VLfInXBMd/ZqUWwj7uvPW8rgY0qH7JXBpp+gVNF5lHrXsHknPF21ymx3CBsUYT31+4Y7F+oE79QCg4T+eVIBM32WPMI0oxQZ7Um0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L7Qc9X8A; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43J8RCkn001727;
	Fri, 19 Apr 2024 08:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=mUz7G2I31WWjnfIm90UXXiHcAE5I6dJUYddf94VWWLk=;
 b=L7Qc9X8AaG34HRMO88C4PXIzIaUK1HzIh2LaB0OvyuLI2rHX3dbRPwdXXT9XwZj+5a6a
 D7+LAxU0cg7Mte9Hj2AOYEscDAMgdO/aseF6y/KpPFL6D7RZWq4gOzPDsigPO05CIoNU
 eSBo8r59fx+aK69vnt/eeL1nhwsT8I9jG3bzoT+d96Ti2fmyBJlu/nrz4vh9u8YQMiRf
 s3eCwQ/sW0lU+6Yx5OgN6pNev63Qo2gcg4upwOmanH0qexhwXqcVp5QHmXz53h5SR/1o
 HImvqnF1DPkaUOUDE1dAj4s0xxoBxc7LvcqAphDgfzeMmTdtvL4cL5bG3x1EnXhOL/qS 3g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xkn40g014-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 08:27:12 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43J8RBNJ001717;
	Fri, 19 Apr 2024 08:27:11 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xkn40g011-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 08:27:11 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43J5FbYx020834;
	Fri, 19 Apr 2024 08:27:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xkbm9jh1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 08:27:10 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43J8R6Xi36831546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Apr 2024 08:27:08 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6187D2004D;
	Fri, 19 Apr 2024 08:27:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C4BD2004B;
	Fri, 19 Apr 2024 08:27:06 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 19 Apr 2024 08:27:06 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] workqueue: fix selection of wake_cpu in kick_pool()
In-Reply-To: <ZiB9rYBu-0qjsCbF@slm.duckdns.org> (Tejun Heo's message of "Wed,
	17 Apr 2024 15:55:57 -1000")
References: <20240415053550.538722-1-svens@linux.ibm.com>
	<Zh8EfxdVdiIj_27H@slm.duckdns.org> <yt9dpluogfw9.fsf@linux.ibm.com>
	<ZiB9rYBu-0qjsCbF@slm.duckdns.org>
Date: Fri, 19 Apr 2024 10:27:05 +0200
Message-ID: <yt9dzftp3gh2.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Y4SsCU9Q2x3du1ED6odiU_SQestHSyPM
X-Proofpoint-GUID: L9Jn3h-Az_dddY7AlmM7LgwALECaXbq1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_05,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=472 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 clxscore=1011 bulkscore=0 spamscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404190062

Hi Tejun,

Tejun Heo <tj@kernel.org> writes:

> On Wed, Apr 17, 2024 at 05:36:38PM +0200, Sven Schnelle wrote:
>> > This generally seems like a good idea but isn't this still racy? The CPU may
>> > go down between setting p->wake_cpu and wake_up_process().
>> 
>> Don't know without reading the source, but how does this code normally
>> protect against that?
>
> Probably by wrapping determining the wake_cpu and the wake_up inside
> cpu_read_lock() section.

Do you mean rcu_read_lock()? cpus_read_lock() takes a mutex, and the
crash happens in softirq context - so cpus_read_lock() can't be the
correct lock.

If i read the code correctly, cpu hotplug uses stop_machine_cpuslocked()
- so rcu_read_lock() should be sufficient for non-atomic context.

Looking at the backtrace the crash is actually happening in
arch_vpu_is_preempted(). I don't know the semantics of that function,
whether it is ok to call it for offline CPUs, or whether the calling
code should make sure that the cpu is online (which would be my guess).

Following the backtrace from my initial mail, I can't find a place where
a check is done whether p->wake_cpu is actually online. Eventually
available_idle_cpu() is calling vcpu_is_preempted(). I wonder whether
available_idle_cpu() should do a cpu_online() check right at the
beginning?

Adding Peter to CC, he probably knows.

Thanks,
Sven

