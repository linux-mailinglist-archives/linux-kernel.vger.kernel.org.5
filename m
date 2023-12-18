Return-Path: <linux-kernel+bounces-3124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B0C8167A7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 896C71F22C11
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4263211C8E;
	Mon, 18 Dec 2023 07:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SgZOgNJ1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FCB11CA0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BI6Dtdu004492;
	Mon, 18 Dec 2023 07:46:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=OBt1K0hL5jJcH/NjAWnY5492UJ0wnBJXT06vRSP5k2g=;
 b=SgZOgNJ1eXv545gdlcRF8qLXVIDlPbzYWEKSJgOe4hKlrTMQB5kYpfttf4H1OBIE+YDJ
 7Q1witDNWPTBu20jq8ieoO28yXuHt5JO2wL3xihoxhQIZaUuUCXN3Qd55QnR79DTRYff
 U4d130cZGhUSDjwzD2W1CZygX5yZ6q9gxHklZEx4PJEGWp9eWfJ09EK2oINAgXJWs2u7
 /S0BxDIRHcbyMLRoJ+3OY5CoUMvOJD13MI5vtvlGshx58xZZytHe8RwbgJC0JvOPx3MF
 GPAAJ6VGF1IzopumRMok/d80QUFFmEE897FLyNViP1JQQ0YwqeRgtlvEjRctypyt9kru AQ== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v2dkmxptj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 07:46:22 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BI69SDh010900;
	Mon, 18 Dec 2023 07:46:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3v1q7n7dcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 07:46:21 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BI7kJpg13370024
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 07:46:19 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 747042004B;
	Mon, 18 Dec 2023 07:46:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 475E520040;
	Mon, 18 Dec 2023 07:46:19 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 18 Dec 2023 07:46:19 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski
 <luto@kernel.org>,
        linux-kernel@vger.kernel.org, Heiko Carstens
 <hca@linux.ibm.com>
Subject: Re: [PATCH 1/3] entry: move exit to usermode functions to header file
In-Reply-To: <87r0jnmgew.ffs@tglx> (Thomas Gleixner's message of "Fri, 15 Dec
	2023 20:09:27 +0100")
References: <20231205133015.752543-1-svens@linux.ibm.com>
	<20231205133015.752543-2-svens@linux.ibm.com> <87r0jnmgew.ffs@tglx>
Date: Mon, 18 Dec 2023 08:46:18 +0100
Message-ID: <yt9dh6kgvtpx.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: A4LsraRmZgxVr8YGx8dmSRaGsoPwGM1m
X-Proofpoint-GUID: A4LsraRmZgxVr8YGx8dmSRaGsoPwGM1m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-18_04,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 phishscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 mlxlogscore=536 suspectscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312180055

Hi Thomas,

Thomas Gleixner <tglx@linutronix.de> writes:

> On Tue, Dec 05 2023 at 14:30, Sven Schnelle wrote:
>> +/**
>> + * exit_to_user_mode_loop - do any pending work before leaving to user space
>> + */
>> +static __always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
>> +							    unsigned long ti_work)
>> +{
>> +	/*
>> +	 * Before returning to user space ensure that all pending work
>> +	 * items have been completed.
>> +	 */
>> +	while (ti_work & EXIT_TO_USER_MODE_WORK) {
>> +
>> +		local_irq_enable_exit_to_user(ti_work);
>> +
>> +		if (ti_work & _TIF_NEED_RESCHED)
>> +			schedule();
>> +
>> +		if (ti_work & _TIF_UPROBE)
>> +			uprobe_notify_resume(regs);
>> +
>> +		if (ti_work & _TIF_PATCH_PENDING)
>> +			klp_update_patch_state(current);
>> +
>> +		if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
>> +			arch_do_signal_or_restart(regs);
>> +
>> +		if (ti_work & _TIF_NOTIFY_RESUME)
>> +			resume_user_mode_work(regs);
>> +
>> +		/* Architecture specific TIF work */
>> +		arch_exit_to_user_mode_work(regs, ti_work);
>> +
>> +		/*
>> +		 * Disable interrupts and reevaluate the work flags as they
>> +		 * might have changed while interrupts and preemption was
>> +		 * enabled above.
>> +		 */
>> +		local_irq_disable_exit_to_user();
>> +
>> +		/* Check if any of the above work has queued a deferred wakeup */
>> +		tick_nohz_user_enter_prepare();
>> +
>> +		ti_work = read_thread_flags();
>> +	}
>> +
>> +	/* Return the latest work state for arch_exit_to_user_mode() */
>> +	return ti_work;
>> +}
>
> I'm not really sure about this part. exit_to_user_mode_loop() is the
> slowpath when a TIF work flag is set. I can see the benefit on the
> fastpath functions which are way smaller.

Indeed, the main performance improvement comes from inlining the small
functions. As Peter mentioned the same, i sent out a v2 which doesn't
move exit_to_user_mode_loop().

Thanks!
Sven

