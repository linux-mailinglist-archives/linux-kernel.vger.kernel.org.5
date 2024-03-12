Return-Path: <linux-kernel+bounces-100627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E23B9879AF6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 200211C21DB4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEF7139566;
	Tue, 12 Mar 2024 18:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="U0lxIATC"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04E153BE;
	Tue, 12 Mar 2024 18:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710266833; cv=none; b=l3OeUakJt4KXXZKpDG48GGUFokaJBY3Yy580fsnpQwk6rtP9PskHai7HbLFU1jmuR56Vg/yCXSTuPGfNDuQJPa/Skfb1qw/l6k3+w/gS03OQfyIYB6hg1wvC27tw58s+tkWDKv24lhbofos8Peq4g+aewPxQdbssL01cRoR8i38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710266833; c=relaxed/simple;
	bh=xDMpf32XdN9mFoxvXmkOJMQv+yi7XgTifA78SnuM9qM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YR5cIhfsN5/WN5ynnirTW1VwwqL3hT10oKlJw8dssQiJH3n444r65eY7xoRI6AAfdZ3JnW8olNVZmbXmWwCGW9q2Ms3ZPtOrirY8clxPAK7onCKR7jEO/1LwcmV2vAGyVGgnoC9skEm5+qgu5PTT5RUlIAFUIIPKEBseqvGyQZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=U0lxIATC; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1710266824;
	bh=xDMpf32XdN9mFoxvXmkOJMQv+yi7XgTifA78SnuM9qM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U0lxIATCYVsgwa37ot09cJBoT6fXos59dZxsvraVILXcSpziqGDUrJF2sOgi6qEfT
	 noRRWsccNTmlqFZofSTwkl/kLdHrMZJQDq5gw3qab2l5v1zXrRV3GBjm7YuXXWeTNZ
	 xWRhnVaS7UiOkW6ADptv7GjTKPqKjqXLyP3Oz6Li1/r1bveGrjo4UWRqJtiQSB31CO
	 Wb8VcsTGo39E9Qwqq0bL95YMaEUj0VptN/3TOeAkw9Y3nzDdiJZksgklgXekOjz2dN
	 ihaY2eoFlTf0JJSsY1SEqnuszHIA07KoXNVMKhbxOyiyxOF+jD9E9X87T8eyiX4DB3
	 mTd3pJSJZa3MQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TvM6c1n4dzh0K;
	Tue, 12 Mar 2024 14:07:04 -0400 (EDT)
Message-ID: <b7660de7-03ad-4d6c-b135-998d2cc0c80e@efficios.com>
Date: Tue, 12 Mar 2024 14:07:18 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] sched: Add missing memory barrier in switch_mm_cid
Content-Language: en-US
To: Yeo Reum Yun <YeoReum.Yun@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Catalin Marinas <Catalin.Marinas@arm.com>,
 Mark Rutland <Mark.Rutland@arm.com>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Aaron Lu <aaron.lu@intel.com>
References: <20240306152443.6340-1-mathieu.desnoyers@efficios.com>
 <AM0PR08MB428936EACB47856176BFDD8CFB242@AM0PR08MB4289.eurprd08.prod.outlook.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <AM0PR08MB428936EACB47856176BFDD8CFB242@AM0PR08MB4289.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-11 04:45, Yeo Reum Yun wrote:
> Hi. Mathieu. Sorry to late answer.
> 
>> diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
>> index 35389b2af88e..0d5e54201eb2 100644
>> --- a/arch/x86/include/asm/barrier.h
>> +++ b/arch/x86/include/asm/barrier.h
>> @@ -79,6 +79,9 @@ do {                                                                  \
>>   #define __smp_mb__before_atomic()      do { } while (0)
>>   #define __smp_mb__after_atomic()       do { } while (0)
> 
>> +/* Writing to CR3 provides a full memory barrier in switch_mm(). */
>> +#define smp_mb__after_switch_mm()      do { } while (0)
>> +
>> #include <asm-generic/barrier.h>
> 
> IIUC, ppc already does smp_mb() in switch_mm.
> 
> Would it better to add the same macro which do nothing to pcc?\\

Does it ?

Based on arch/powerpc/include/asm/membarrier.h, it appears that
powerpc does _not_ have a guaranteed barrier in switch_mm():

static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
                                              struct mm_struct *next,
                                              struct task_struct *tsk)
{
         /*
          * Only need the full barrier when switching between processes.
          * Barrier when switching from kernel to userspace is not
          * required here, given that it is implied by mmdrop(). Barrier
          * when switching from userspace to kernel is not needed after
          * store to rq->curr.
          */
         if (IS_ENABLED(CONFIG_SMP) &&
             likely(!(atomic_read(&next->membarrier_state) &
                      (MEMBARRIER_STATE_PRIVATE_EXPEDITED |
                       MEMBARRIER_STATE_GLOBAL_EXPEDITED)) || !prev))
                 return;

         /*
          * The membarrier system call requires a full memory barrier
          * after storing to rq->curr, before going back to user-space.
          */
         smp_mb();
}

AFAIU the barrier provided in powerpc switch_mm_irqs_off() is only in the
"new_on_cpu" case. Am I missing something ?

Thanks,

Mathieu

> 
> Thanks!
> 
-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


