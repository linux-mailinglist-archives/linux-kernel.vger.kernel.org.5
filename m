Return-Path: <linux-kernel+bounces-97563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F71876BF3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80CDA1F225AC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E445E077;
	Fri,  8 Mar 2024 20:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="JSH/W1I/"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DB21D52D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 20:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709930519; cv=none; b=Jx3lenXslD820Vo+LtXloSEAwnx/+N/ffiMyLnJ1T6TXFme9R0nBC2tqPMFcBsIkw6TOBxCGLorvIqiFdd+EogzZIr/LMC/WB4CTnpBp1g1hjC3/lDdOmTBs9qLA83mUic3Is50123tliKoYNqiFcZ/GJeNZYGvCZ5CYHlVFKlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709930519; c=relaxed/simple;
	bh=3+0YQ5H/0CT2c1fbY3AvJ5uyLvp7tO82Em1GQy7Dqto=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WEyyuGIGvKkfBU2hAYFpK5Dtu+hgKloL+Z9rRTOCNYSBf7uaXOnh3XOX5E8vmeQeqr+0fBEjY4myJTfVG5gGFBHQFp2glgYR2Gyzo6O4Fbqpt/yQrb5Tg75oi1iiQyWANLZaEI1PQJ8hlEUjbHG8kcKPrhG4YrKJXuDR11rZwFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=JSH/W1I/; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 4D2C8240029
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 21:41:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1709930509; bh=3+0YQ5H/0CT2c1fbY3AvJ5uyLvp7tO82Em1GQy7Dqto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=JSH/W1I/aP6g/uooIYMdqfrLXFDif2iwLBiW/XaEOQHk1zMqWCkApxr7ORHVfG5Bo
	 61k6X9hGDUnEZ4VP7xC4aGzmYLcHPTV57nglqBJ0nEVHMPzvZvQJQBYwoY+aKmRM4r
	 V4nJaGclv+J/xFOUJKem+LNsjJ9mS0eSYLNGHMbjwlEyBX9ha29t/dKRUJBJH1/eML
	 pd/8wlxqMYDrMHkx7R6f3T9jivlfjmRUrmLMgCnk/lUX2MKJicwwXpc/oQw6FP7uxH
	 PCaVDJq3Atnq1cwdzW6Xz0gsEIYVjZkosclm9uyDBWw5nQswyBYlNo3pi/ga85yrQS
	 gPWGgJ4bQH8ew==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Trykv5HL5z6trs;
	Fri,  8 Mar 2024 21:41:43 +0100 (CET)
From: Anne Macedo <retpolanne@posteo.net>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>,  Peter Zijlstra
 <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>,  Mark Rutland
 <mark.rutland@arm.com>,  Alexander Shishkin
 <alexander.shishkin@linux.intel.com>,  Jiri Olsa <jolsa@kernel.org>,  Ian
 Rogers <irogers@google.com>,  Adrian Hunter <adrian.hunter@intel.com>,
  linux-perf-users@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v0] perf lock contention: skip traceiter functions
In-Reply-To: <Zeto8ShG406K6cnD@x1> (Arnaldo Carvalho de Melo's message of
	"Fri, 8 Mar 2024 16:37:21 -0300")
References: <20240308120332.372810-1-retpolanne@posteo.net>
	<Zeto8ShG406K6cnD@x1>
Date: Fri, 08 Mar 2024 20:41:40 +0000
Message-ID: <m2jzmc318b.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Arnaldo Carvalho de Melo <acme@kernel.org> writes:

> On Fri, Mar 08, 2024 at 12:03:31PM +0000, Anne Macedo wrote:
>> The perf lock contention program currently shows the caller of the locks
>> as __traceiter_contention_begin+0x??. This caller can be ignored, as it is
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
>>          8      2.33 s       2.28 s     291.18 ms     rwlock:W   __traceiter_contention_begin+0x44
>>          4      2.33 s       2.28 s     582.35 ms     rwlock:W   __traceiter_contention_begin+0x44
>>          7    140.30 ms     46.77 ms     20.04 ms     rwlock:W   __traceiter_contention_begin+0x44
>>          2     63.35 ms     33.76 ms     31.68 ms        mutex   trace_contention_begin+0x84
>>          2     46.74 ms     46.73 ms     23.37 ms     rwlock:W   __traceiter_contention_begin+0x44
>>          1     13.54 us     13.54 us     13.54 us        mutex   trace_contention_begin+0x84
>>          1      3.67 us      3.67 us      3.67 us      rwsem:R   __traceiter_contention_begin+0x44
>>
>> Before this patch is applied - using --stack-skip 5
>>
>> sudo perf lock con --stack-skip 5 -a -b -- sleep 3
>>  contended   total wait     max wait     avg wait         type   caller
>>
>>          2      2.24 s       2.24 s       1.12 s      rwlock:W   do_epoll_wait+0x5a0
>>          4      1.65 s     824.21 ms    412.08 ms     rwlock:W   do_exit+0x338
>>          2    824.35 ms    824.29 ms    412.17 ms     spinlock   get_signal+0x108
>>          2    824.14 ms    824.14 ms    412.07 ms     rwlock:W   release_task+0x68
>>          1     25.22 ms     25.22 ms     25.22 ms        mutex   cgroup_kn_lock_live+0x58
>>          1     24.71 us     24.71 us     24.71 us     spinlock   do_exit+0x44
>>          1     22.04 us     22.04 us     22.04 us      rwsem:R   lock_mm_and_find_vma+0xb0
>>
>> After this patch is applied:
>>
>> sudo ./perf lock con -a -b -- sleep 3
>>  contended   total wait     max wait     avg wait         type   caller
>>
>>          6      5.27 s       1.76 s     878.55 ms     rwlock:W   release_task+0x68
>>          2      2.99 s       2.99 s       1.50 s      spinlock   do_send_sig_info+0x3c
>>          2      1.77 s       1.77 s     884.39 ms     spinlock   sigprocmask+0x98
>>          2      1.76 s       1.76 s     878.56 ms     rwlock:W   do_exit+0x338
>>          2      1.76 s       1.76 s     878.55 ms     rwlock:W   release_task+0x68
>>          5      1.76 s       1.76 s     351.41 ms     rwlock:W   do_exit+0x338
>>          1     48.10 ms     48.10 ms     48.10 ms        mutex   trace_contention_begin+0x84
>>          4    257.80 us    119.34 us     64.45 us     spinlock   get_signal+0x108
>>          1      9.33 us      9.33 us      9.33 us     rwlock:W   do_exit+0x338
>
> Testing it on the ARM64 board sometimes also show that
> trace_contention_begin+0x84, maybe we need to skip that one as well?
>
I can skip trace_contention_begin and trace_contention_end as well.

Question: I have 1409 __traceiter symbols on my kernel build, should we
ignore them all? Or is __traceiter_contention_begin and
__traceiter_contention_end the only ones that concern the lock contention?

cat /proc/kallsyms | grep -P '\b__traceiter*' | wc -l
1409

>
> root@roc-rk3399-pc:~# perf lock contention --use-bpf -a sleep 2
>  contended   total wait     max wait     avg wait         type   caller
>
> root@roc-rk3399-pc:~# perf lock contention -b -a find / > /dev/null
>  contended   total wait     max wait     avg wait         type   caller
>
>          4      4.07 s       2.47 s       1.02 s      spinlock   cpu_pm_enter+0x34
>          6      3.43 s       3.43 s     572.20 ms     spinlock   __tick_broadcast_oneshot_control+0xc0
>          3    313.19 ms    313.16 ms    104.40 ms     spinlock   tick_do_update_jiffies64+0x44
>          6      6.06 ms      1.97 ms      1.01 ms        mutex   trace_contention_begin+0x84
>          6     89.25 us     19.25 us     14.88 us     spinlock   rcu_core+0xec
>          1     16.04 us     16.04 us     16.04 us     spinlock   sugov_update_shared+0x44
> root@roc-rk3399-pc:~# perf lock contention -b -a find / > /dev/null
>  contended   total wait     max wait     avg wait         type   caller
>
>          4      2.78 ms      1.09 ms    695.76 us        mutex   trace_contention_begin+0x84
> root@roc-rk3399-pc:~# perf lock contention -b -a find / > /dev/null
>  contended   total wait     max wait     avg wait         type   caller
>
>          1    389.50 us    389.50 us    389.50 us        mutex   trace_contention_begin+0x84
> root@roc-rk3399-pc:~# perf lock contention -b -a find / > /dev/null
>  contended   total wait     max wait     avg wait         type   caller
>
>          2      3.82 ms      3.43 ms      1.91 ms        mutex   trace_contention_begin+0x84
> root@roc-rk3399-pc:~# perf lock contention -b -a find / > /dev/null
>  contended   total wait     max wait     avg wait         type   caller
>
>          3      6.82 ms      2.37 ms      2.27 ms        mutex   trace_contention_begin+0x84
>          2     63.29 us     45.50 us     31.65 us        mutex   trace_contention_begin+0x84
>          1     52.79 us     52.79 us     52.79 us        mutex   trace_contention_begin+0x84
> root@roc-rk3399-pc:~# perf lock contention -b -a find / > /dev/null
>  contended   total wait     max wait     avg wait         type   caller
>
> root@roc-rk3399-pc:~#
>
>> Signed-off-by: Anne Macedo <retpolanne@posteo.net>
>> ---
>>  tools/perf/util/machine.c | 10 ++++++++++
>>  tools/perf/util/machine.h |  2 +-
>>  2 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
>> index 527517db3182..8e729167c1aa 100644
>> --- a/tools/perf/util/machine.c
>> +++ b/tools/perf/util/machine.c
>> @@ -3266,6 +3266,12 @@ bool machine__is_lock_function(struct machine *machine, u64 addr)
>>
>>  		sym = machine__find_kernel_symbol_by_name(machine, "__lock_text_end", &kmap);
>>  		machine->lock.text_end = map__unmap_ip(kmap, sym->start);
>> +
>> +		sym = machine__find_kernel_symbol_by_name(machine, "__traceiter_contention_begin", &kmap);
>> +		machine->traceiter.text_start = map__unmap_ip(kmap, sym->start);
>> +
>> +		sym = machine__find_kernel_symbol_by_name(machine, "__traceiter_contention_end", &kmap);
>> +		machine->traceiter.text_end = map__unmap_ip(kmap, sym->start);
>>  	}
>>
>>  	/* failed to get kernel symbols */
>> @@ -3280,5 +3286,9 @@ bool machine__is_lock_function(struct machine *machine, u64 addr)
>>  	if (machine->lock.text_start <= addr && addr < machine->lock.text_end)
>>  		return true;
>>
>> +	/* traceiter functions are in traceiter text section  */
>> +	if (machine->traceiter.text_start <= addr && addr < machine->traceiter.text_end)
>> +		return true;
>> +
>>  	return false;
>>  }
>> diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
>> index e28c787616fe..ec51e9b080b9 100644
>> --- a/tools/perf/util/machine.h
>> +++ b/tools/perf/util/machine.h
>> @@ -49,7 +49,7 @@ struct machine {
>>  	struct {
>>  		u64	  text_start;
>>  		u64	  text_end;
>> -	} sched, lock;
>> +	} sched, lock, traceiter;
>>  	pid_t		  *current_tid;
>>  	size_t		  current_tid_sz;
>>  	union { /* Tool specific area */
>> --
>> 2.39.2

