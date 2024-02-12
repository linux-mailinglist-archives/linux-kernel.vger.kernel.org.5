Return-Path: <linux-kernel+bounces-62068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E007B851AFE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E92101C22770
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9173E47B;
	Mon, 12 Feb 2024 17:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="tm8smcC1"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCFB47A5C
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 17:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757902; cv=none; b=WhSaq9B5DN5lwow7zEdnuqIvBbRLjBEhYcujmPsVSdcbcIigajpPZshGejQJo2KuU1lVrawIDk1RIHOxmBn960lhAdGVukqajKLiny+WFFyafFqf6tLsZxT4TQoWBKisZ7mX1Dvd7WxcKM1ISRqdPkHKarmC8EDp6liVKTFUH7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757902; c=relaxed/simple;
	bh=OfyOK/NBwcs3yDEWVKmDEV5j0ru28RjWTK9M1ebmO3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UPRZ4xwrpWn+ZB7Kmg+wss8Wc1hJ+VGw7bwZeTI9I0LrOXbwBEquIYmNpZ4gzSyXyvQJqU3FMEAIqdkGqyQyOmuNiRByMd9HcSlc425EXc++f1zTMa83nYM9w5l+9ND/tH6Xgl2NfcYtNcn9M1azzibttUS0MiokOoa15WnN7Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=tm8smcC1; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1707757888;
	bh=OfyOK/NBwcs3yDEWVKmDEV5j0ru28RjWTK9M1ebmO3s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tm8smcC1zm+kvihTyWvvrpU0sDOE4tLDCq6WAwqu0xOlNJKsAG/kJaD/vQFOwv+jm
	 Ea7p71aNLoQhPiejCXkhsbTdXScfiSMw3WRaKFI/cRrTj3yJPcVkDXL1/iXn0ziVp1
	 AgkAbU08rSggIVlnWTuYnF1EcH4GEynKGowtAygmAsU7Qs+qmMLWUZRkyXKhiwWyTE
	 G0IlUHcPjJSpnhpiYN34AbO6hDoNG97JuTL6Oo289+NbdRMMwzqG98vascMWbvBQY3
	 r5fYayi1wrAQQFg4Ko1Q2e1FuIYwVfA8z1MBKsILjU48RMFZPl7nS6o79c3jQsxkr7
	 n+bLkYrFSIgYw==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TYWFr5N87zXxj;
	Mon, 12 Feb 2024 12:11:28 -0500 (EST)
Message-ID: <33732f5a-8446-401e-b5ec-0f7b68439f6e@efficios.com>
Date: Mon, 12 Feb 2024 12:11:31 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Spurious SIGSEGV with rseq/membarrier
To: Dmitry Vyukov <dvyukov@google.com>, Peter Oskolkov <posk@google.com>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Chris Kennelly <ckennelly@google.com>
References: <CACT4Y+bXfekygoyhO7pCctjnL15=E=Zs31BUGXU0dk8d4rc1Cw@mail.gmail.com>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <CACT4Y+bXfekygoyhO7pCctjnL15=E=Zs31BUGXU0dk8d4rc1Cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-12 05:02, Dmitry Vyukov wrote:
> Hi rseq/membarrier maintainers,
> 
> I've spent a bit debugging some spurious SIGSEGVs and it turned out to
> be an interesting interaction between page faults, rseq and
> membarrier. The manifestation is that membarrier(EXPEDITED_RSEQ) is
> effectively not working for a thread (doesn't restart its rseq
> critical section).
> 
> The real code is inside of tcmalloc and relates to the "slabs resing" procedure:
> 
> https://github.com/google/tcmalloc/blob/39775a2d57969eda9497f3673421766bc1e886a0/tcmalloc/internal/percpu_tcmalloc.cc#L176
> 
> The essence is:
> Threads use a data structure inside of rseq critical section.
> The resize procedure replaces the old data structure with a new one,
> uses a membarrier to ensure that threads don't use the old one any
> more and unmaps/mprotects pages that back the old data structure. At
> this point no threads use the old data structure anymore and no
> threads should get SIGSEGV.
> 
> However, what happens is as follows:
> A thread gets a minor page fault on the old data structure inside of
> rseq critical section.
> The page fault handler re-enables preemption and allows other threads
> to be scheduled (I am tno sure this is actually important, but that's
> what I observed in all traces, and it makes the failure scenario much
> more likely).
> Now, the resize procedure is executed, replaces all pointers to the
> old data structure to the new one, executes the membarrier and unmaps
> the old data structure.
> Now the page fault handler resumes, verifies VMA protection and finds
> out that the VMA is indeed inaccessible and the page fault is not a
> minor one, but rather should result in SIGSEGV and sends SIGSEGV.
> Note: at this point the thread has rseq restart pending (from both
> preemption and membarrier), and the restart indeed happens as part of
> SIGSEGV delivery, but it's already too late.

Hi Dmitry,

Thanks for spending the time to analyze this issue and identify the
scenario causing it.

> 
> I think the page fault handling should give the rseq restart
> preference in this case, and realize the thread shouldn't be executing
> the faulting instruction in the first place. In such case the thread
> would be restarted, and access the new data structure after the
> restart.

The wanted behavior you describe here does make sense.

> Unmapping/mprotecting the old data in this case is useful for 2 reasons:
> 1. It allows to release memory (not possible to do reliably now).
> 2. It allows to ensure there are no logical bugs in the user-space
> code and thread don't access the old data when they shouldn't. I was
> actually tracking a potential bug in user-space code, but after
> mprotecting old data, started seeing more of more confusing crashes
> (this spurious SIGSEGV).

So I think we are in a situation where in the original rseq design
we've tried to eliminate "all" kernel-internal rseq restart kernel
corner cases by preventing system calls from being issued within rseq
critical sections (to keep things nice and simple), but missed the fact
that page faults are another mean of entering the kernel which can
indeed trigger preemption, and the restart should happen either before
the side-effect of the page fault is decided (e.g. segmentation fault or
SIGBUS), or before the actual signal is delivered to user-space.

In order to solve this here is what I think we need:

1) Add a proper stress-test reproducer to the rseq selftests:

    - In a loop, conditionally issue the first memory access to a newly
      mmap'd area from a rseq critical section using a pointer
      dereference.
    - In another thread, in a loop:
      - mmap a new memory area,
      - set pointer to point to that memory area
      - wait a tiny while (cpu_relax busy-loop)
      - set pointer to NULL
      - membarrier EXPEDITED_RSEQ
      - munmap the area (could also be mprotect)

   We should probably provide hints to mmap so the same address is not
   re-used loop after loop to increase the chances of hitting the
   race.

2) We need to figure out where to implement this behavior change. Either
    at the page fault handler level, or at signal delivery. It would need
    to check whether:
    - t->rseq_event_mask is nonzero _and_
    - in_rseq_cs() would return true (it's tricky because this needs to
      read userspace memory, which can trigger a page fault).
    We should be careful about not preventing signals emitted by other
    sources to happen.

3) This would be a new behavior. Even if it is something that would have
    been preferable from the beginning, all the pre-existing kernels
    implementing membarrier EXPEDITED_RSEQ do not have that behavior
    today. We would want to implement something that allows userspace to
    detect this "feature". Extending getauxval() to add a new "rseq
    feature" entry that would return feature flags would be an option.

Thoughts ?

Thanks,

Mathieu
-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


