Return-Path: <linux-kernel+bounces-99432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F73878835
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107D1282415
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC2054FA2;
	Mon, 11 Mar 2024 18:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="m8Hw4SnG"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71AA4DA10
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 18:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182676; cv=none; b=CzvMJhHtq9T5QYMV61cSqPJYlz2s8UXVeCl1gG/vwxQ8P2Akw8O6FwghgUgg1UfA2R0I70UvR1UXh5CfHa6RzALcuYAqSwfZfWERqnCBGn+eGtVlcD4KkEkl+JV5sIMGSe0ib3avvhnQh7pVFweSxRfW8Av4UhM2C6IJc+q4Bmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182676; c=relaxed/simple;
	bh=LZmCCWatL7zUeGzsKNkDzV6t886L3zaARgo6mZvV6cU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qhdIz+4Rde9nYCXh2wRXBHe4cYQ7fOwXOC0i4uteLC84ivCV+72d1Nix8xh9BHM/YZVbCzPfDqs8Xcrqa1+ZmofKB78/N/KXMSusH/+a/3wjuJ9HCyCxzVdnFkr3ZwOwQ7M8hea1ZyD2NasOHpYfhbwahT1QQ62ZYdVNSdom0/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=m8Hw4SnG; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 5815424002D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 19:44:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1710182665; bh=LZmCCWatL7zUeGzsKNkDzV6t886L3zaARgo6mZvV6cU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=m8Hw4SnG0/4NQM/htNE8ZC2irbxh2yjYbGeWnXKYlZNjlWsfgpfWqfSGDrZcd+oGy
	 y+soHTYAdX8QEsV3ZtE+bYPuTjuBGigvm14S/at+xf0Dgjtcg7i66txdAG81dNuqbK
	 K/y3B/5mFEv1Re4hsYAQdCaF4uDgo7C3SearYdEzuYrD2LWyFpWR4E4Z8wbyoU0/Rk
	 gy+RQCM/jZQZOUT2Hx57eA8z0YWKAYt21wKBXK8c1rTjunzw6x/CObyxxI5POwKxHC
	 prP5jhrv2fHzz1k7dCx6PNwOlMEjm3y36HSjYvO7V/6kcX6yAZ+s/PU9ffWANsyGts
	 khTOxAozeay8g==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Ttm033Nzlz6tvq;
	Mon, 11 Mar 2024 19:44:18 +0100 (CET)
From: Anne Macedo <retpolanne@posteo.net>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,  Peter Zijlstra
 <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>,  Mark Rutland
 <mark.rutland@arm.com>,  Alexander Shishkin
 <alexander.shishkin@linux.intel.com>,  Jiri Olsa <jolsa@kernel.org>,  Ian
 Rogers <irogers@google.com>,  Adrian Hunter <adrian.hunter@intel.com>,
  linux-perf-users@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf lock contention: skip traceiter functions
In-Reply-To: <CAM9d7cjhiua5rBj=CTDJJC-XJN6PzKxQ5DsooJGEz0QcQAry7w@mail.gmail.com>
	(Namhyung Kim's message of "Mon, 11 Mar 2024 11:17:01 -0700")
References: <20240309132710.1055941-1-retpolanne@posteo.net>
	<CAM9d7cjhiua5rBj=CTDJJC-XJN6PzKxQ5DsooJGEz0QcQAry7w@mail.gmail.com>
Date: Mon, 11 Mar 2024 18:44:15 +0000
Message-ID: <m2il1sbocg.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Namhyung Kim <namhyung@kernel.org> writes:

> Hello Anne,
>
> On Sat, Mar 9, 2024 at 5:27=E2=80=AFAM Anne Macedo <retpolanne@posteo.net=
> wrote:
>>
>> The perf lock contention program currently shows the caller of the locks
>> as __traceiter_contention_begin+0x??. This caller can be ignored, as it =
is
>> from the traceiter itself. Instead, it should show the real callers for
>> the locks.
>>
>> When fiddling with the --stack-skip parameter, the actual callers for
>> the locks start to show up. However, just ignore the
>> __traceiter_contention_begin and the __traceiter_contention_end symbols
>> so the actual callers will show up.
>>
>> Before this patch is applied:
>>
>> sudo perf lock con -a -b -- sleep 3
>>  contended   total wait     max wait     avg wait         type   caller
>>
>>          8      2.33 s       2.28 s     291.18 ms     rwlock:W   __trace=
iter_contention_begin+0x44
>>          4      2.33 s       2.28 s     582.35 ms     rwlock:W   __trace=
iter_contention_begin+0x44
>>          7    140.30 ms     46.77 ms     20.04 ms     rwlock:W   __trace=
iter_contention_begin+0x44
>>          2     63.35 ms     33.76 ms     31.68 ms        mutex   trace_c=
ontention_begin+0x84
>>          2     46.74 ms     46.73 ms     23.37 ms     rwlock:W   __trace=
iter_contention_begin+0x44
>>          1     13.54 us     13.54 us     13.54 us        mutex   trace_c=
ontention_begin+0x84
>>          1      3.67 us      3.67 us      3.67 us      rwsem:R   __trace=
iter_contention_begin+0x44
>>
>> Before this patch is applied - using --stack-skip 5
>>
>> sudo perf lock con --stack-skip 5 -a -b -- sleep 3
>>  contended   total wait     max wait     avg wait         type   caller
>>
>>          2      2.24 s       2.24 s       1.12 s      rwlock:W   do_epol=
l_wait+0x5a0
>>          4      1.65 s     824.21 ms    412.08 ms     rwlock:W   do_exit=
+0x338
>>          2    824.35 ms    824.29 ms    412.17 ms     spinlock   get_sig=
nal+0x108
>>          2    824.14 ms    824.14 ms    412.07 ms     rwlock:W   release=
_task+0x68
>>          1     25.22 ms     25.22 ms     25.22 ms        mutex   cgroup_=
kn_lock_live+0x58
>>          1     24.71 us     24.71 us     24.71 us     spinlock   do_exit=
+0x44
>>          1     22.04 us     22.04 us     22.04 us      rwsem:R   lock_mm=
_and_find_vma+0xb0
>>
>> After this patch is applied:
>>
>> sudo ./perf lock con -a -b -- sleep 3
>>  contended   total wait     max wait     avg wait         type   caller
>>
>>          4      4.13 s       2.07 s       1.03 s      rwlock:W   release=
_task+0x68
>>          2      2.07 s       2.07 s       1.03 s      rwlock:R   mm_upda=
te_next_owner+0x50
>>          2      2.07 s       2.07 s       1.03 s      rwlock:W   do_exit=
+0x338
>>          1     41.56 ms     41.56 ms     41.56 ms        mutex   cgroup_=
kn_lock_live+0x58
>>          2     36.12 us     18.83 us     18.06 us     rwlock:W   do_exit=
+0x338
>>
>> changes since v0:
>>
>> - skip trace_contention functions
>> - use sym->end instead of __traceiter_contention_end for text_end
>>
>> Signed-off-by: Anne Macedo <retpolanne@posteo.net>
>> ---
>>  tools/perf/util/machine.c | 17 +++++++++++++++++
>>  tools/perf/util/machine.h |  2 +-
>>  2 files changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
>> index 527517db3182..db443947ccd1 100644
>> --- a/tools/perf/util/machine.c
>> +++ b/tools/perf/util/machine.c
>> @@ -3266,6 +3266,14 @@ bool machine__is_lock_function(struct machine *ma=
chine, u64 addr)
>>
>>                 sym =3D machine__find_kernel_symbol_by_name(machine, "__=
lock_text_end", &kmap);
>>                 machine->lock.text_end =3D map__unmap_ip(kmap, sym->star=
t);
>> +
>> +               sym =3D machine__find_kernel_symbol_by_name(machine, "__=
traceiter_contention_begin", &kmap);
>
> Unlike __sched_text_{start,end} and __lock_text_{start,end} I guess
> this traceiter thing is optional so it might not be there.  You need to
> handle if it's NULL.
>

Let me test with CONFIG_TRACEPOINTS=3Dn then.

> I think it depends on the kernel version and configuration.  I remember
> I saw a different symbol on old kernels.  But it'd be hard to handle all
> the cases.  Let's have a single trace text section in the struct machine
> and use __traceiter_contention_begin only.  If it's not found you can
> fallback to trace_contention_begin.
>
ACK :)
>
> Thanks,
> Namhyung
>
>
>> +               machine->traceiter.text_start =3D map__unmap_ip(kmap, sy=
m->start);
>> +               machine->traceiter.text_end =3D map__unmap_ip(kmap, sym-=
>end);
>> +
>> +               sym =3D machine__find_kernel_symbol_by_name(machine, "tr=
ace_contention_begin", &kmap);
>> +               machine->trace.text_start =3D map__unmap_ip(kmap, sym->s=
tart);
>> +               machine->trace.text_end =3D map__unmap_ip(kmap, sym->end=
);
>>         }
>>
>>         /* failed to get kernel symbols */
>> @@ -3280,5 +3288,14 @@ bool machine__is_lock_function(struct machine *ma=
chine, u64 addr)
>>         if (machine->lock.text_start <=3D addr && addr < machine->lock.t=
ext_end)
>>                 return true;
>>
>> +       /* traceiter functions currently don't have their own section
>> +        * but we consider them lock functions
>> +        */
>> +       if (machine->traceiter.text_start <=3D addr && addr < machine->t=
raceiter.text_end)
>> +               return true;
>> +
>> +       if (machine->trace.text_start <=3D addr && addr < machine->trace=
text_end)
>> +               return true;
>> +
>>         return false;
>>  }
>> diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
>> index e28c787616fe..4312f6db6de0 100644
>> --- a/tools/perf/util/machine.h
>> +++ b/tools/perf/util/machine.h
>> @@ -49,7 +49,7 @@ struct machine {
>>         struct {
>>                 u64       text_start;
>>                 u64       text_end;
>> -       } sched, lock;
>> +       } sched, lock, traceiter, trace;
>>         pid_t             *current_tid;
>>         size_t            current_tid_sz;
>>         union { /* Tool specific area */
>> --
>> 2.39.2
>>

