Return-Path: <linux-kernel+bounces-85654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CF286B8BD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52ED31C26279
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C7A74428;
	Wed, 28 Feb 2024 20:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="BhG4ktkK"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DB75E069;
	Wed, 28 Feb 2024 20:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709150529; cv=none; b=ttCRSAcg/e1U6aj7eiUkzZkEtcwvXm6dQRwFsvm3PdWzJj1He1lGJJ4/HInvkmtSDFtE6JX9ef9koejiXO6DKtIxoYwFfY4QvAp9gUkNwoTK9Wo008o6fGLW25bEbU5bD0v3XlARQPRLIucKjIF2zCPeIyUEzucve1qn276wIAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709150529; c=relaxed/simple;
	bh=a7wt5T9r3p0F8nV6C4P6T2FCExy9h+9MVE4E51ctieQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qJyy8xrfDnmgE2qVufmsYVnu4mqzPyKZtEtkev8FWdQecLih9yW+4/YNgDoT1EgTM5t4tttjfpHEItedOviyRAaKdP1WOiGIwEaWkaD8H53q0+tpiASGUT3Q1Aiv5OSlYr8cQeNGoSe6z9r23VugkK+6P4mY5Gc3WvE689b9pow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=BhG4ktkK; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1709150514;
	bh=a7wt5T9r3p0F8nV6C4P6T2FCExy9h+9MVE4E51ctieQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BhG4ktkK+dFyU0Vpkttoso7E7ukPa0PC3kakwX8a3qmwFHxf4YOYUs1Gt4uiqsx6K
	 gdPO9JZPXGUxTTPyysK6whAMrOldlCtmETSHyMbVuCacshEjJifVFNwSJ5mmoF4Nh1
	 beVmUYRUYtt8LcBr/alXmliExpyYjXHPEnD5rRFw3aBfPlu/nHDTn/fW6B8AmDFvyJ
	 glL6nDKshuVO9STTEmrvTQwzpBw7CV5KwRfh23p59h0E40L+5jV3JSuuskI2VtgKE0
	 fKhhQwQxZLIEp3NdODArCErrzGjMoFHlOubhfqdO8SjwSpe5vIx8eji4xehf0aW1Vu
	 V0JVVjnBtHuiw==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TlQH55WMDzdb6;
	Wed, 28 Feb 2024 15:01:53 -0500 (EST)
Message-ID: <ed828ce7-2046-4884-ab1f-d7bff3c0a714@efficios.com>
Date: Wed, 28 Feb 2024 15:01:55 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/30] RSEQ node id and mm concurrency id extensions
Content-Language: en-US
To: Marco Elver <elver@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, "Paul E . McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
 linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com,
 carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Chris Kennelly <ckennelly@google.com>, dvyukov@google.com
References: <20221122203932.231377-1-mathieu.desnoyers@efficios.com>
 <Zd-AfDcQ-r04CMXk@elver.google.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <Zd-AfDcQ-r04CMXk@elver.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-28 13:50, Marco Elver wrote:
> Hi Mathieu, all,
> 
> On Tue, Nov 22, 2022 at 03:39PM -0500, Mathieu Desnoyers wrote:
>> Extend the rseq ABI to expose NUMA node ID, mm_cid, and mm_numa_cid
>> fields.
>>
>> The NUMA node ID field allows implementing a faster getcpu(2) in libc.
>>
>> The per-memory-map concurrency id (mm_cid) [1] allows ideal scaling
>> (down or up) of user-space per-cpu data structures. The concurrency ids
>> allocated within a memory map are tracked by the scheduler, which takes
>> into account the number of concurrently running threads, thus implicitly
>> considering the number of threads, the cpu affinity, the cpusets
>> applying to those threads, and the number of logical cores on the
>> system.
>>
>> The NUMA-aware concurrency id (mm_numa_cid) is similar to the mm_cid,
>> except that it keeps track of the NUMA node ids with which each cid has
>> been associated. On NUMA systems, when a NUMA-aware concurrency ID is
>> observed by user-space to be associated with a NUMA node, it is
>> guaranteed to never change NUMA node unless a kernel-level NUMA
>> configuration change happens. This is useful for NUMA-aware per-cpu data
>> structures running in environments where a process or a set of processes
>> belonging to cpuset are pinned to a set of cores which belong to a
>> subset of the system's NUMA nodes.
> [...]
> 
> Just out of curiosity: is anyone aware of any libraries that have
> started using CIDs? It looks like the cost of CID assignment is always
> paid (even though it should be small), I'm trying to understand if after
> 1.5 years there are common libraries that have started using it and what
> their exact usecase is.

Hi Marco,

AFAIK the only project using the mm_cid concept I know of today is
tcmalloc. It's very useful to scale data structures such as memory
allocator arenas to the number of concurrently running threads
within a process without having to rely on heuristics on the
user-space side.

I have plans to migrate LTTng-UST to per-ipc-namespace NUMA-aware
mm_cid as well (after I get around to submit this extension into the
Linux kernel) for user-space ring buffers over shared memory, but my
current focus has been on pushing support for extensible RSEQ into
GNU libc for the past year or so.

We are getting there though:

https://sourceware.org/pipermail/libc-alpha/2024-February/154390.html

Once we have this key piece in place within GNU libc, it will become
easier to extend rseq further because the libc will adapt to the extended
feature set.

Note that the overhead of the mm_cid assignment within the scheduler
should be negligible after
commit 223baf9d17f2 ("sched: Fix performance regression introduced by mm_cid").

Another thing we've actively been working on is to get the "librseq"
project [1] in shape so a copy the librseq headers can be integrated
into the GNU libc project as internal header files. So basically
librseq will become a GNU libc upstream. This will facilitate
implementation of rseq critical section within GNU libc. One of
the possible use-cases will be to move the GNU libc malloc
implementation to per-mm_cid arenas.

> 
> I'm aware that TCMalloc was the inspiration for vCPUs [1], then renamed to
> CIDs, but am wondering if other users are out there.

I'd be curious to learn about those as well.

I suspect that the lack of official release of librseq critical section
helper headers may contribute to the fact that few applications use advanced
rseq features at this point.

Thanks,

Mathieu

[1] https://git.kernel.org/pub/scm/libs/librseq/librseq.git/

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


