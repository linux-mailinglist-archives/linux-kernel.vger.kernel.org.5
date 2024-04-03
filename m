Return-Path: <linux-kernel+bounces-130390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2A8897773
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 913E81C209A3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F86154C09;
	Wed,  3 Apr 2024 17:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCdmwxJK"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76720152DE1;
	Wed,  3 Apr 2024 17:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712166619; cv=none; b=EBLvNmxcXwcNm4Uh1BBwCYLF0CZpjMAZOoSFwEamq9EaJrps6sd5EpzmKioNkQ3UuXOXDWAGRb4YxkMO/iTgqLB8gcO95jDka4V/NW5YE0GEjVgVUXNYFwRz5thNU0Pq4nR13JJhaJsjrN3yyAA9mAzTXs3SEkdCwOitVyIyJTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712166619; c=relaxed/simple;
	bh=0UndWnogXMzcyX7SuExNqnKF0lgD2BtEJNjooUVrjBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PzxnmhPQU88QOUwbjjuIc31quirBboR2I7vY3A0lGfQJqKzexDv41cfOawXSoKPRd8wMYrEEAQns0cBicnYPoJus3rp1dXqmIvIV8LZsWfpcI0dPoNORkXd2gSap22YIHwz0nhKTKFWFX9vzsnPUzb4YuqzOcvBRAlOLkNDOe2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCdmwxJK; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d4a1e66750so125411a12.0;
        Wed, 03 Apr 2024 10:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712166617; x=1712771417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9C6DFYe+czN6oSK5SZi6C94NfiSiV4dnkyqrdmVoVYA=;
        b=dCdmwxJKxumPxuLBNjtu/OUJ0I551T7DA8H79a1XR62ioWvYIud8LE3qBCGx5FpGLg
         0J/2Pxhjp1Tsi/jThxTiwrtwpSTcK9N8ZhHXNRwcWhyysHq8EAiz7KSA60CE9+4ecb6O
         ujEeNPem56F0oBvGUXhoL1/kaX9mNjJ22QPmDu2B2DtIIsAz/rDSIfCogSt+KXBYuTp5
         /CkgF4P5cahcbMRs0PPCdROVxjWgTRAtnO6OsUnlYLNXTL346umjTiqzmULWpYjxlaYc
         HpXvG+runc70bJzKb1XdYQ4+nRxQcxXdho6BKo1Cvb30Jv2x0BU77GDre7DTujHSDLv4
         cK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712166617; x=1712771417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9C6DFYe+czN6oSK5SZi6C94NfiSiV4dnkyqrdmVoVYA=;
        b=Xi5Na1N90BEOB604pBWKeqg9YjBnsKmYZHPp9JZ1sSJ0qKiXMmrLqyYqoM/Nv4vciP
         I3pi7qdiWkFQsyemHBWLyL80fQXi/OsF7zSieqSpHGfRvuvgbjhg/tVibnqRilMZ/LVI
         MdpBncs2qbjqGWAKdbPLFC+EFRKmFDxq1RggIBCBDtaC4U9UYHsNH5tk+yhGQz0gFGoF
         1A/r86fHDpHRFybZ2x5HpBTU/g3qtltXoSxlGHx23CREhGsDbsWwNrQraMv6vBpGZUKo
         0m6F381HrfIfB2dNvP4sUDIwdKgDpOrtoWQq/S2p6LCPFzRK4+AJlVLz/kP/crMQZfYs
         bvSg==
X-Forwarded-Encrypted: i=1; AJvYcCWjGhIwgCHdKugBUQ/YCShOlpfHM1xVInXgg+HVX3QjVFXSebzaAdFPieRSPZpgfA0Rr06DT1f+BtYd687XPV2WPXqpkyJwH3onY5XsKNg718Ojof5jGWnR6Ryeoma0z6h8bZrrJ/K1bjliGpmfuABnB83a5Y9mKr8SD+Hj/9fM9AT7PM8HGjzfuctoVdCC9cuziEt/MT+4EGdASAHAZl9eUg1PKf7Y3g==
X-Gm-Message-State: AOJu0YxRNnRdMTEeI3yXWZMGV3YZdlI1F9+pseaE0TxZ2vRyVMaURSp0
	vd8HcF/HEkBF3+QilmV0BODnQM8V7e/vDhLGyWjZAr9mi2CgJmMvfBirw9vWJiW58x6SJe8mhC9
	zgdR94IMkdQ26jFp8VDjwyXDvMMM=
X-Google-Smtp-Source: AGHT+IHx9gD0uWJyW5nUfrspzLnG2X9GyN3bBerb8gDbVzCNWDS3L9gLJBn+MR0VObdCITS5G33ZMfprSNBTrpjDwHk=
X-Received: by 2002:a05:6a20:e607:b0:1a7:1c26:f9ac with SMTP id
 my7-20020a056a20e60700b001a71c26f9acmr382547pzb.62.1712166616715; Wed, 03 Apr
 2024 10:50:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321145736.2373846-1-jonathan.haslam@gmail.com>
 <20240325120323.ec3248d330b2755e73a6571e@kernel.org> <CAEf4BzZS_QCsSY0oGY_3pGveGfXKK_TkVURyNq=UQXVXSqi2Fw@mail.gmail.com>
 <20240327084245.a890ae12e579f0be1902ae4a@kernel.org> <54jakntmdyedadce7yrf6kljcjapbwyoqqt26dnllrqvs3pg7x@itra4a2ikgqw>
 <20240328091841.ce9cc613db375536de843cfb@kernel.org> <5yvc6rdiovfjlfpayet57ocqpo3wft3onk6of5sqoh6wjngwhr@blky37q5cuk3>
In-Reply-To: <5yvc6rdiovfjlfpayet57ocqpo3wft3onk6of5sqoh6wjngwhr@blky37q5cuk3>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Apr 2024 10:50:04 -0700
Message-ID: <CAEf4BzbFR-EaQV7pyv4q-2o8q-b65rO6gYmrLBp82RomWwu7nA@mail.gmail.com>
Subject: Re: [PATCH] uprobes: reduce contention on uprobes_tree access
To: Jonthan Haslam <jonathan.haslam@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	andrii@kernel.org, bpf@vger.kernel.org, rostedt@goodmis.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 4:05=E2=80=AFAM Jonthan Haslam <jonathan.haslam@gmai=
l.com> wrote:
>
> > > > > Given the discussion around per-cpu rw semaphore and need for
> > > > > (internal) batched attachment API for uprobes, do you think you c=
an
> > > > > apply this patch as is for now? We can then gain initial improvem=
ents
> > > > > in scalability that are also easy to backport, and Jonathan will =
work
> > > > > on a more complete solution based on per-cpu RW semaphore, as
> > > > > suggested by Ingo.
> > > >
> > > > Yeah, it is interesting to use per-cpu rw semaphore on uprobe.
> > > > I would like to wait for the next version.
> > >
> > > My initial tests show a nice improvement on the over RW spinlocks but
> > > significant regression in acquiring a write lock. I've got a few days
> > > vacation over Easter but I'll aim to get some more formalised results=
 out
> > > to the thread toward the end of next week.
> >
> > As far as the write lock is only on the cold path, I think you can choo=
se
> > per-cpu RW semaphore. Since it does not do busy wait, the total system
> > performance impact will be small.
> > I look forward to your formalized results :)
>
> Sorry for the delay in getting back to you on this Masami.
>
> I have used one of the bpf selftest benchmarks to provide some form of
> comparison of the 3 different approaches (spinlock, RW spinlock and
> per-cpu RW semaphore). The benchmark used here is the 'trig-uprobe-nop'
> benchmark which just executes a single uprobe with a minimal bpf program
> attached. The tests were done on a 32 core qemu/kvm instance.
>

Thanks a lot for running benchmarks and providing results!

> Things to note about the results:
>
> - The results are slightly variable so don't get too caught up on
>   individual thread count - it's the trend that is important.
> - In terms of throughput with this specific benchmark a *very* macro view
>   is that the RW spinlock provides 40-60% more throughput than the
>   spinlock.  The per-CPU RW semaphore provides in the order of 50-100%
>   more throughput then the spinlock.
> - This doesn't fully reflect the large reduction in latency that we have
>   seen in application based measurements. However, it does demonstrate
>   that even the trivial change of going to a RW spinlock provides
>   significant benefits.

This is probably because trig-uprobe-nop creates a single uprobe that
is triggered on many CPUs. While in production we have also *many*
uprobes running on many CPUs. In this benchmark, besides contention on
uprobes_treelock, we are also hammering on other per-uprobe locks
(register_rwsem, also if you don't have [0] patch locally, there will
be another filter lock taken each time, filter->rwlock). There is also
atomic refcounting going on, which when you have the same uprobe
across all CPUs at the same time will cause a bunch of cache line
bouncing.

So yes, it's understandable that in practice in production you see an
even larger effect of optimizing uprobe_treelock than in this
micro-benchmark.

  [0] https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git=
/commit/?h=3Dprobes/for-next&id=3D366f7afd3de31d3ce2f4cbff97c6c23b6aa6bcdf

>
> I haven't included the measurements on per-CPU RW semaphore write
> performance as they are completely in line with those that Paul McKenney
> posted on his journal [0]. On a 32 core system I see semaphore writes to
> take in the order of 25-28 millisecs - the cost of the synchronize_rcu().
>
> Each block of results below show 1 line per execution of the benchmark (t=
he
> "Summary" line) and each line is a run with one more thread added - a
> thread is a "producer". The lines are edited to remove extraneous output
> that adds no value here.
>
> The tests were executed with this driver script:
>
> for num_threads in {1..20}
> do
>     sudo ./bench -p $num_threads trig-uprobe-nop | grep Summary

just want to mention -a (affinity) option that you can pass a bench
tool, it will pin each thread on its own CPU. It generally makes tests
more uniform, eliminating CPU migrations variability.

> done
>
>
> spinlock
>
> Summary: hits    1.453 =C2=B1 0.005M/s (  1.453M/prod)
> Summary: hits    2.087 =C2=B1 0.005M/s (  1.043M/prod)
> Summary: hits    2.701 =C2=B1 0.012M/s (  0.900M/prod)

I also wanted to point out that the first measurement (1.453M/s in
this row) is total throughput across all threads, while value in
parenthesis (0.900M/prod) is averaged throughput per each thread. So
this M/prod value is the most interesting in this benchmark where we
assess the effect of reducing contention.

> Summary: hits    1.917 =C2=B1 0.011M/s (  0.479M/prod)
> Summary: hits    2.105 =C2=B1 0.003M/s (  0.421M/prod)
> Summary: hits    1.615 =C2=B1 0.006M/s (  0.269M/prod)

[...]

