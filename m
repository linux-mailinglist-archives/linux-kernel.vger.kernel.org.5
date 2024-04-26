Return-Path: <linux-kernel+bounces-159658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D1B8B31AA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5F6D1C21A46
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE94413AD25;
	Fri, 26 Apr 2024 07:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sNokGwb/"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F015442A9B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 07:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714117685; cv=none; b=bn3vyZ8hsikJJ3ZVS+4Ow+5pHq8wRiaXMvZ0zguJDyEFOSLHWMD184dMSrmLsH3WMr0ivdKAMgGnsRccMwpc4TBhk7QyKJ/IC0FvUARC/M++VwdepaXq7gr6rTLhVvnnHWBs2Y1wGpCm5X5uRZIo2pyFvo2enmeArLDbWkmW0OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714117685; c=relaxed/simple;
	bh=vWc3A7yvrRDk+m5KpbGlLqvd8KZeLmzQsfI32eivgoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sB4mFQUVOyI2UQZAhVsi2pE+x1nftL7WZe+sS64DplZ78FrKRaXgT4uXSTBrBn/J+dSUjU/mscAfGyUpw342kF9yjeKKL1emybAuH/OrzCkpk81ea3sdPAPPwLO2U0q0ordGmdh+JwzvHAqfV5UCdc/VEfmjPhfnqNvfjMqPBGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sNokGwb/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43Q7WlOp020965;
	Fri, 26 Apr 2024 07:46:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=wPBGMK4ohn/v33cIElNw/qjHxfG8P3bI5NhnosbFDww=;
 b=sNokGwb/+kg2+Q325tK5xJ5rk7pLYqJeGeZPvUjLzYCWyn4ppYHkYMEGTbK81L74lekC
 3CIHrUewRFWdEStk8lC3YjjhcZLm9uj+cPw5WIoLvfsS0GlAvrb41k9Bwp1FWf4kcOUj
 KCOkcUikgMlRh/+5AXDyDT3YaJf2RR1lIUlLneBdX1qdppwiilH5KO/X69Ktep/hOKA8
 ZcIJFSKmx3ry7luufoCaWHRBycX57qe1zZDaimpdby6uB1ucLZTgYOIxeiiKT8p+DN01
 0KlW7OFRXuXQzczigiKVMCtpvXVORB7MlVMAkfPdpNuX1VcwLkhIYTESw2/47f7NItCi Hw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xr7y80136-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 07:46:26 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43Q7j7Cu009271;
	Fri, 26 Apr 2024 07:46:26 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xr7y80133-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 07:46:26 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43Q7jvWH028356;
	Fri, 26 Apr 2024 07:46:24 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmtr2x20m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 07:46:24 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43Q7kMIu61342078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 07:46:24 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C10C58059;
	Fri, 26 Apr 2024 07:46:22 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B21D258068;
	Fri, 26 Apr 2024 07:46:11 +0000 (GMT)
Received: from [9.195.36.19] (unknown [9.195.36.19])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Apr 2024 07:46:11 +0000 (GMT)
Message-ID: <63314d92-9226-4005-a166-37c8648c5351@linux.ibm.com>
Date: Fri, 26 Apr 2024 13:16:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/30] PREEMPT_AUTO: support lazy rescheduling
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Ankur Arora <ankur.a.arora@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org,
        paulmck@kernel.org, akpm@linux-foundation.org, luto@kernel.org,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jpoimboe@kernel.org,
        mark.rutland@arm.com, jgross@suse.com, andrew.cooper3@citrix.com,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <74ffd154-5d92-4303-9977-6ddc9accdf01@linux.ibm.com>
 <CAHk-=whrTE30xzuq4mcXidT4M0z_HRYJW9i8M9gD9VG7d29Qpg@mail.gmail.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <CAHk-=whrTE30xzuq4mcXidT4M0z_HRYJW9i8M9gD9VG7d29Qpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nWFWbJqsO-Fjjm_oudoflrRyTLICP7cB
X-Proofpoint-ORIG-GUID: Hx5mW6tmjG3ulb5NO5FRU3TgwmUOa5cD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_07,2024-04-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=734 bulkscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404260048



On 4/23/24 9:43 PM, Linus Torvalds wrote:
> On Tue, 23 Apr 2024 at 08:23, Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
>>
>>
>> Are these the only arch bits that need to be defined? am I missing something very
>> basic here? will try to debug this further. Any inputs?
> 
> I don't think powerpc uses the generic *_exit_to_user_mode() helper
> functions, so you'll need to also add that logic to the low-level
> powerpc code.
> 
> IOW, on x86, with this patch series, patch 06/30 did this:
> 
> -               if (ti_work & _TIF_NEED_RESCHED)
> +               if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
>                         schedule();
> 
> in kernel/entry/common.c exit_to_user_mode_loop().
> 
> But that works on x86 because it uses the irqentry_exit_to_user_mode().
> 
> On PowerPC, I think you need to at least fix up
> 
>     interrupt_exit_user_prepare_main()
> 
> similarly (and any other paths like that - I used to know the powerpc
> code, but that was long long LOOONG ago).
> 
>                 Linus

Thank you Linus for the pointers. That indeed did the trick. 

diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index eca293794a1e..f0f38bf5cea9 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -185,7 +185,7 @@ interrupt_exit_user_prepare_main(unsigned long ret, struct pt_regs *regs)
        ti_flags = read_thread_flags();
        while (unlikely(ti_flags & (_TIF_USER_WORK_MASK & ~_TIF_RESTORE_TM))) {
                local_irq_enable();
-               if (ti_flags & _TIF_NEED_RESCHED) {
+               if (ti_flags & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY) ) {
                        schedule();
                } else {


By adding LAZY checks in interrupt_exit_user_prepare_main, softlockup is no longer seen and 
hackbench results are more or less same on smaller system(96CPUS). However, I still see 20-50% 
regression on the larger system(320 CPUS). I will continue to debug why. 


