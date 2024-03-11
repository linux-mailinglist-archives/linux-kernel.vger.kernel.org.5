Return-Path: <linux-kernel+bounces-99467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BBE8788E5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50FF31F23D88
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0524E54FA3;
	Mon, 11 Mar 2024 19:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="cmAYwwHu"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B2052F82
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 19:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710185134; cv=none; b=fiz/fXnShITCEvq3ZKIRGT9zgb1zrtRZHk7DBoxd1mk/tzq4tdvsySwbROpvSG1lQxnzjMPuu0uZfWoIgmYKXtAxdr0OgvrgJzlsiPF+z+Ur4KHuuFbtBfDhaU+vuc6pYHxfHGlZpYzLsmrgpiG4XsjJH8Yal6UMwg9pit7mpiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710185134; c=relaxed/simple;
	bh=BUb6mWms1cF3tzi6Wb0eoN6mk/QC4nbageqFaV8EQo8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QW23YqzdJptpy8HB9ZHGshnKC05vqtBJGFlKYYJTRA+hwCLzRjOgBIdmUrMKp5MjTCMqOK2R1hfeYLKLEmdP1L8KUQk8nlKQvrAkcXqMB7kyaXOBc4nZUGRVYH79KAK7WGVd7Z0bihQMlTJA50lI1An+0siEgbTTjM4dVj1fB3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=cmAYwwHu; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id DFBA3240104
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 20:25:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1710185123; bh=BUb6mWms1cF3tzi6Wb0eoN6mk/QC4nbageqFaV8EQo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=cmAYwwHuHFjkA6tT8jRTXHe7anaIK6NSItoJ7XtaNznJ6L9e4d2Rn5L2Dh/fRB9IK
	 TrqltPCipVjSiRIn7IMD6GDwiA19tEFqalrPo8Ud9R5D+dzlFUr5wjaJ26ccwRV0gx
	 vW15Qc0chbNMcKJpyftUVIquLuClay9K7QAYxfMtUYU7dlqjmHUKB64XbkOJeLEtGs
	 mP+W//Jmkv+gAJY9vmpayMtAxQ1e9nG6KGUz1WLf693btv0+YhZ2iwmDKMPJig8ZlY
	 HJWK4dre0T2ZpUaHTA9PPg51y3q/R0UH9EkZtTkybPYIHdx0XbFKu2jUbVRikwA/xV
	 kc/qFlfWgx9/g==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4TtmvL64Dvz6trs;
	Mon, 11 Mar 2024 20:25:18 +0100 (CET)
From: Anne Macedo <retpolanne@posteo.net>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,  Peter Zijlstra
 <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>,  Mark Rutland
 <mark.rutland@arm.com>,  Alexander Shishkin
 <alexander.shishkin@linux.intel.com>,  Jiri Olsa <jolsa@kernel.org>,  Ian
 Rogers <irogers@google.com>,  Adrian Hunter <adrian.hunter@intel.com>,
  linux-perf-users@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf lock contention: skip traceiter functions
In-Reply-To: <m2il1sbocg.fsf@posteo.net> (Anne Macedo's message of "Mon, 11
	Mar 2024 15:44:15 -0300")
References: <20240309132710.1055941-1-retpolanne@posteo.net>
	<CAM9d7cjhiua5rBj=CTDJJC-XJN6PzKxQ5DsooJGEz0QcQAry7w@mail.gmail.com>
	<m2il1sbocg.fsf@posteo.net>
Date: Mon, 11 Mar 2024 19:25:16 +0000
Message-ID: <m24jdcbmg3.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Anne Macedo <retpolanne@posteo.net> writes:

> Namhyung Kim <namhyung@kernel.org> writes:
>
>> Hello Anne,
>>
>> On Sat, Mar 9, 2024 at 5:27=E2=80=AFAM Anne Macedo <retpolanne@posteo.ne=
t> wrote:
>>>
>>> The perf lock contention program currently shows the caller of the locks
>>> as __traceiter_contention_begin+0x??. This caller can be ignored, as it=
 is
>>> from the traceiter itself. Instead, it should show the real callers for
>>> the locks.
>>>
>>> When fiddling with the --stack-skip parameter, the actual callers for
>>> the locks start to show up. However, just ignore the
>>> __traceiter_contention_begin and the __traceiter_contention_end symbols
>>> so the actual callers will show up.
>>>
>>> Before this patch is applied:
>>>
>>> sudo perf lock con -a -b -- sleep 3
>>>  contended   total wait     max wait     avg wait         type   caller
>>>
>>>          8      2.33 s       2.28 s     291.18 ms     rwlock:W   __trac=
eiter_contention_begin+0x44
>>>          4      2.33 s       2.28 s     582.35 ms     rwlock:W   __trac=
eiter_contention_begin+0x44
>>>          7    140.30 ms     46.77 ms     20.04 ms     rwlock:W   __trac=
eiter_contention_begin+0x44
>>>          2     63.35 ms     33.76 ms     31.68 ms        mutex   trace_=
contention_begin+0x84
>>>          2     46.74 ms     46.73 ms     23.37 ms     rwlock:W   __trac=
eiter_contention_begin+0x44
>>>          1     13.54 us     13.54 us     13.54 us        mutex   trace_=
contention_begin+0x84
>>>          1      3.67 us      3.67 us      3.67 us      rwsem:R   __trac=
eiter_contention_begin+0x44
>>>
>>> Before this patch is applied - using --stack-skip 5
>>>
>>> sudo perf lock con --stack-skip 5 -a -b -- sleep 3
>>>  contended   total wait     max wait     avg wait         type   caller
>>>
>>>          2      2.24 s       2.24 s       1.12 s      rwlock:W   do_epo=
ll_wait+0x5a0
>>>          4      1.65 s     824.21 ms    412.08 ms     rwlock:W   do_exi=
t+0x338
>>>          2    824.35 ms    824.29 ms    412.17 ms     spinlock   get_si=
gnal+0x108
>>>          2    824.14 ms    824.14 ms    412.07 ms     rwlock:W   releas=
e_task+0x68
>>>          1     25.22 ms     25.22 ms     25.22 ms        mutex   cgroup=
_kn_lock_live+0x58
>>>          1     24.71 us     24.71 us     24.71 us     spinlock   do_exi=
t+0x44
>>>          1     22.04 us     22.04 us     22.04 us      rwsem:R   lock_m=
m_and_find_vma+0xb0
>>>
>>> After this patch is applied:
>>>
>>> sudo ./perf lock con -a -b -- sleep 3
>>>  contended   total wait     max wait     avg wait         type   caller
>>>
>>>          4      4.13 s       2.07 s       1.03 s      rwlock:W   releas=
e_task+0x68
>>>          2      2.07 s       2.07 s       1.03 s      rwlock:R   mm_upd=
ate_next_owner+0x50
>>>          2      2.07 s       2.07 s       1.03 s      rwlock:W   do_exi=
t+0x338
>>>          1     41.56 ms     41.56 ms     41.56 ms        mutex   cgroup=
_kn_lock_live+0x58
>>>          2     36.12 us     18.83 us     18.06 us     rwlock:W   do_exi=
t+0x338
>>>
>>> changes since v0:
>>>
>>> - skip trace_contention functions
>>> - use sym->end instead of __traceiter_contention_end for text_end
>>>
>>> Signed-off-by: Anne Macedo <retpolanne@posteo.net>
>>> ---
>>>  tools/perf/util/machine.c | 17 +++++++++++++++++
>>>  tools/perf/util/machine.h |  2 +-
>>>  2 files changed, 18 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
>>> index 527517db3182..db443947ccd1 100644
>>> --- a/tools/perf/util/machine.c
>>> +++ b/tools/perf/util/machine.c
>>> @@ -3266,6 +3266,14 @@ bool machine__is_lock_function(struct machine *m=
achine, u64 addr)
>>>
>>>                 sym =3D machine__find_kernel_symbol_by_name(machine, "_=
_lock_text_end", &kmap);
>>>                 machine->lock.text_end =3D map__unmap_ip(kmap, sym->sta=
rt);
>>> +
>>> +               sym =3D machine__find_kernel_symbol_by_name(machine, "_=
_traceiter_contention_begin", &kmap);
>>
>> Unlike __sched_text_{start,end} and __lock_text_{start,end} I guess
>> this traceiter thing is optional so it might not be there.  You need to
>> handle if it's NULL.
>>
>
> Let me test with CONFIG_TRACEPOINTS=3Dn then.
>
Thanks for pointing out, with CONFIG_TRACEPOINTS=3Dn perf lock contention
won't work, but I tried with a faux symbol and got a segfault. v2 will
handle that.
>
>> I think it depends on the kernel version and configuration.  I remember
>> I saw a different symbol on old kernels.  But it'd be hard to handle all
>> the cases.  Let's have a single trace text section in the struct machine
>> and use __traceiter_contention_begin only.  If it's not found you can
>> fallback to trace_contention_begin.

However, if we fallback to trace_contention_begin, we won't be able to
filter out both __traceiter_contention_begin and trace_contention_begin
at the same time.

>>
> ACK :)
>>
>> Thanks,
>> Namhyung
>>
>>
>>> +               machine->traceiter.text_start =3D map__unmap_ip(kmap, s=
ym->start);
>>> +               machine->traceiter.text_end =3D map__unmap_ip(kmap, sym=
->end);
>>> +
>>> +               sym =3D machine__find_kernel_symbol_by_name(machine, "t=
race_contention_begin", &kmap);
>>> +               machine->trace.text_start =3D map__unmap_ip(kmap, sym->=
start);
>>> +               machine->trace.text_end =3D map__unmap_ip(kmap, sym->en=
d);
>>>         }
>>>
>>>         /* failed to get kernel symbols */
>>> @@ -3280,5 +3288,14 @@ bool machine__is_lock_function(struct machine *m=
achine, u64 addr)
>>>         if (machine->lock.text_start <=3D addr && addr < machine->lock.=
text_end)
>>>                 return true;
>>>
>>> +       /* traceiter functions currently don't have their own section
>>> +        * but we consider them lock functions
>>> +        */
>>> +       if (machine->traceiter.text_start <=3D addr && addr < machine->=
traceiter.text_end)
>>> +               return true;
>>> +
>>> +       if (machine->trace.text_start <=3D addr && addr < machine->trac=
e.text_end)
>>> +               return true;
>>> +
>>>         return false;
>>>  }
>>> diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
>>> index e28c787616fe..4312f6db6de0 100644
>>> --- a/tools/perf/util/machine.h
>>> +++ b/tools/perf/util/machine.h
>>> @@ -49,7 +49,7 @@ struct machine {
>>>         struct {
>>>                 u64       text_start;
>>>                 u64       text_end;
>>> -       } sched, lock;
>>> +       } sched, lock, traceiter, trace;
>>>         pid_t             *current_tid;
>>>         size_t            current_tid_sz;
>>>         union { /* Tool specific area */
>>> --
>>> 2.39.2
>>>
Thanks, Anne

