Return-Path: <linux-kernel+bounces-125552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3326E89283F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 01:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B46001F221FA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 00:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC7E15C9;
	Sat, 30 Mar 2024 00:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZXHiFll"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690C24C99;
	Sat, 30 Mar 2024 00:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711758997; cv=none; b=aJYnkLMP/hx8h5cXw1agNxu/TXM/A8GFGi2/Da6/0ow8ugVlA9NpvIlMKNAV++NydOfztyNwLnLATjITXsypoMHts7lgseKJ3Htj73pKRaDxN/iRGZ/SZ/yYBtjZVICRVMRkRIJ4dhTzcCldFWNRpJ7Gm5N8tCW1ZN9s6II3m4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711758997; c=relaxed/simple;
	bh=Ab+AY7ZyWjpeu6FnqcS57xd1DicB744MIAHuv5agtGA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NYteGYA59tTgIWKVD1/2AoveuwbTibp1YB2WlGNq0RS5l60/IpFr5b7uDpKb3WKWHH9Z4QUfy2NLMpRwoFyo90IN9xOOGDhgnptoes3FWzQJPDZU+sicPCK899eAtIrXf3Cobwdpi2tFPMT6DTLQVRWoSvOXpzvkXApkGO6pAE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZXHiFll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392F4C433C7;
	Sat, 30 Mar 2024 00:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711758996;
	bh=Ab+AY7ZyWjpeu6FnqcS57xd1DicB744MIAHuv5agtGA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AZXHiFllv8n5dEaSG9m4+IXHeGilu8MA8ZUo6p+KaOcte1zmtfBf+jY8/nBvOgW/I
	 ai1q2UJHlVf956ZvihVKGnslmGGvU3irYFpvNniaPIKZQsFffeIse4JwIsUUBMRETt
	 0P1IYSAQi0EHzxbRsTY5HrURviRvdA2Qa1TK2nNsGxcpB/gDvJMAmakNAX1WvtzdrN
	 2dEGvyeZTeNi2FwfB0tSqbmYKcexm69MPa9h9sl70npMH+TAvsctqxdmKkMIlSVkNz
	 1vdFb1WSJyFTEDdJSrkuQsPR0JimgzdoclZ9Mh5/uG1SQvXl/GKJFW+mxSv4G9LYX+
	 dtZkOsjeRbWnA==
Date: Sat, 30 Mar 2024 09:36:31 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jonthan Haslam <jonathan.haslam@gmail.com>,
 linux-trace-kernel@vger.kernel.org, andrii@kernel.org, bpf@vger.kernel.org,
 rostedt@goodmis.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes: reduce contention on uprobes_tree access
Message-Id: <20240330093631.72273967ba818cb16aeb58b6@kernel.org>
In-Reply-To: <CAEf4BzbSvMa2+hdTifMKTsNiOL6X=P7eor4LpPKfHM=Y9-71fw@mail.gmail.com>
References: <20240321145736.2373846-1-jonathan.haslam@gmail.com>
	<20240325120323.ec3248d330b2755e73a6571e@kernel.org>
	<CAEf4BzZS_QCsSY0oGY_3pGveGfXKK_TkVURyNq=UQXVXSqi2Fw@mail.gmail.com>
	<20240327084245.a890ae12e579f0be1902ae4a@kernel.org>
	<54jakntmdyedadce7yrf6kljcjapbwyoqqt26dnllrqvs3pg7x@itra4a2ikgqw>
	<20240328091841.ce9cc613db375536de843cfb@kernel.org>
	<CAEf4BzYCJWXAzdV3q5ex+8hj5ZFCnu5CT=w8eDbZCGqm+CGYOQ@mail.gmail.com>
	<CAEf4BzbSvMa2+hdTifMKTsNiOL6X=P7eor4LpPKfHM=Y9-71fw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 29 Mar 2024 10:33:57 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Wed, Mar 27, 2024 at 5:45 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Mar 27, 2024 at 5:18 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >
> > > On Wed, 27 Mar 2024 17:06:01 +0000
> > > Jonthan Haslam <jonathan.haslam@gmail.com> wrote:
> > >
> > > > > > Masami,
> > > > > >
> > > > > > Given the discussion around per-cpu rw semaphore and need for
> > > > > > (internal) batched attachment API for uprobes, do you think you can
> > > > > > apply this patch as is for now? We can then gain initial improvements
> > > > > > in scalability that are also easy to backport, and Jonathan will work
> > > > > > on a more complete solution based on per-cpu RW semaphore, as
> > > > > > suggested by Ingo.
> > > > >
> > > > > Yeah, it is interesting to use per-cpu rw semaphore on uprobe.
> > > > > I would like to wait for the next version.
> > > >
> > > > My initial tests show a nice improvement on the over RW spinlocks but
> > > > significant regression in acquiring a write lock. I've got a few days
> > > > vacation over Easter but I'll aim to get some more formalised results out
> > > > to the thread toward the end of next week.
> > >
> > > As far as the write lock is only on the cold path, I think you can choose
> > > per-cpu RW semaphore. Since it does not do busy wait, the total system
> > > performance impact will be small.
> >
> > No, Masami, unfortunately it's not as simple. In BPF we have BPF
> > multi-uprobe, which can be used to attach to thousands of user
> > functions. It currently creates one uprobe at a time, as we don't
> > really have a batched API. If each such uprobe registration will now
> > take a (relatively) long time, when multiplied by number of attach-to
> > user functions, it will be a horrible regression in terms of
> > attachment/detachment performance.

Ah, got it. So attachment/detachment performance should be counted.

> >
> > So when we switch to per-CPU rw semaphore, we'll need to provide an
> > internal batch uprobe attach/detach API to make sure that attaching to
> > multiple uprobes is still fast.

Yeah, we need such interface like register_uprobes(...).

> >
> > Which is why I was asking to land this patch as is, as it relieves the
> > scalability pains in production and is easy to backport to old
> > kernels. And then we can work on batched APIs and switch to per-CPU rw
> > semaphore.

OK, then I'll push this to for-next at this moment.
Please share if you have a good idea for the batch interface which can be
backported. I guess it should involve updating userspace changes too.

Thank you!

> >
> > So I hope you can reconsider and accept improvements in this patch,
> > while Jonathan will keep working on even better final solution.
> > Thanks!
> >
> > > I look forward to your formalized results :)
> > >
> 
> BTW, as part of BPF selftests, we have a multi-attach test for uprobes
> and USDTs, reporting attach/detach timings:
> $ sudo ./test_progs -v -t uprobe_multi_test/bench
> bpf_testmod.ko is already unloaded.
> Loading bpf_testmod.ko...
> Successfully loaded bpf_testmod.ko.
> test_bench_attach_uprobe:PASS:uprobe_multi_bench__open_and_load 0 nsec
> test_bench_attach_uprobe:PASS:uprobe_multi_bench__attach 0 nsec
> test_bench_attach_uprobe:PASS:uprobes_count 0 nsec
> test_bench_attach_uprobe: attached in   0.120s
> test_bench_attach_uprobe: detached in   0.092s
> #400/5   uprobe_multi_test/bench_uprobe:OK
> test_bench_attach_usdt:PASS:uprobe_multi__open 0 nsec
> test_bench_attach_usdt:PASS:bpf_program__attach_usdt 0 nsec
> test_bench_attach_usdt:PASS:usdt_count 0 nsec
> test_bench_attach_usdt: attached in   0.124s
> test_bench_attach_usdt: detached in   0.064s
> #400/6   uprobe_multi_test/bench_usdt:OK
> #400     uprobe_multi_test:OK
> Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
> Successfully unloaded bpf_testmod.ko.
> 
> So it should be easy for Jonathan to validate his changes with this.
> 
> > > Thank you,
> > >
> > > >
> > > > Jon.
> > > >
> > > > >
> > > > > Thank you,
> > > > >
> > > > > >
> > > > > > >
> > > > > > > BTW, how did you measure the overhead? I think spinlock overhead
> > > > > > > will depend on how much lock contention happens.
> > > > > > >
> > > > > > > Thank you,
> > > > > > >
> > > > > > > >
> > > > > > > > [0] https://docs.kernel.org/locking/spinlocks.html
> > > > > > > >
> > > > > > > > Signed-off-by: Jonathan Haslam <jonathan.haslam@gmail.com>
> > > > > > > > ---
> > > > > > > >  kernel/events/uprobes.c | 22 +++++++++++-----------
> > > > > > > >  1 file changed, 11 insertions(+), 11 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > > > > > > > index 929e98c62965..42bf9b6e8bc0 100644
> > > > > > > > --- a/kernel/events/uprobes.c
> > > > > > > > +++ b/kernel/events/uprobes.c
> > > > > > > > @@ -39,7 +39,7 @@ static struct rb_root uprobes_tree = RB_ROOT;
> > > > > > > >   */
> > > > > > > >  #define no_uprobe_events()   RB_EMPTY_ROOT(&uprobes_tree)
> > > > > > > >
> > > > > > > > -static DEFINE_SPINLOCK(uprobes_treelock);    /* serialize rbtree access */
> > > > > > > > +static DEFINE_RWLOCK(uprobes_treelock);      /* serialize rbtree access */
> > > > > > > >
> > > > > > > >  #define UPROBES_HASH_SZ      13
> > > > > > > >  /* serialize uprobe->pending_list */
> > > > > > > > @@ -669,9 +669,9 @@ static struct uprobe *find_uprobe(struct inode *inode, loff_t offset)
> > > > > > > >  {
> > > > > > > >       struct uprobe *uprobe;
> > > > > > > >
> > > > > > > > -     spin_lock(&uprobes_treelock);
> > > > > > > > +     read_lock(&uprobes_treelock);
> > > > > > > >       uprobe = __find_uprobe(inode, offset);
> > > > > > > > -     spin_unlock(&uprobes_treelock);
> > > > > > > > +     read_unlock(&uprobes_treelock);
> > > > > > > >
> > > > > > > >       return uprobe;
> > > > > > > >  }
> > > > > > > > @@ -701,9 +701,9 @@ static struct uprobe *insert_uprobe(struct uprobe *uprobe)
> > > > > > > >  {
> > > > > > > >       struct uprobe *u;
> > > > > > > >
> > > > > > > > -     spin_lock(&uprobes_treelock);
> > > > > > > > +     write_lock(&uprobes_treelock);
> > > > > > > >       u = __insert_uprobe(uprobe);
> > > > > > > > -     spin_unlock(&uprobes_treelock);
> > > > > > > > +     write_unlock(&uprobes_treelock);
> > > > > > > >
> > > > > > > >       return u;
> > > > > > > >  }
> > > > > > > > @@ -935,9 +935,9 @@ static void delete_uprobe(struct uprobe *uprobe)
> > > > > > > >       if (WARN_ON(!uprobe_is_active(uprobe)))
> > > > > > > >               return;
> > > > > > > >
> > > > > > > > -     spin_lock(&uprobes_treelock);
> > > > > > > > +     write_lock(&uprobes_treelock);
> > > > > > > >       rb_erase(&uprobe->rb_node, &uprobes_tree);
> > > > > > > > -     spin_unlock(&uprobes_treelock);
> > > > > > > > +     write_unlock(&uprobes_treelock);
> > > > > > > >       RB_CLEAR_NODE(&uprobe->rb_node); /* for uprobe_is_active() */
> > > > > > > >       put_uprobe(uprobe);
> > > > > > > >  }
> > > > > > > > @@ -1298,7 +1298,7 @@ static void build_probe_list(struct inode *inode,
> > > > > > > >       min = vaddr_to_offset(vma, start);
> > > > > > > >       max = min + (end - start) - 1;
> > > > > > > >
> > > > > > > > -     spin_lock(&uprobes_treelock);
> > > > > > > > +     read_lock(&uprobes_treelock);
> > > > > > > >       n = find_node_in_range(inode, min, max);
> > > > > > > >       if (n) {
> > > > > > > >               for (t = n; t; t = rb_prev(t)) {
> > > > > > > > @@ -1316,7 +1316,7 @@ static void build_probe_list(struct inode *inode,
> > > > > > > >                       get_uprobe(u);
> > > > > > > >               }
> > > > > > > >       }
> > > > > > > > -     spin_unlock(&uprobes_treelock);
> > > > > > > > +     read_unlock(&uprobes_treelock);
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  /* @vma contains reference counter, not the probed instruction. */
> > > > > > > > @@ -1407,9 +1407,9 @@ vma_has_uprobes(struct vm_area_struct *vma, unsigned long start, unsigned long e
> > > > > > > >       min = vaddr_to_offset(vma, start);
> > > > > > > >       max = min + (end - start) - 1;
> > > > > > > >
> > > > > > > > -     spin_lock(&uprobes_treelock);
> > > > > > > > +     read_lock(&uprobes_treelock);
> > > > > > > >       n = find_node_in_range(inode, min, max);
> > > > > > > > -     spin_unlock(&uprobes_treelock);
> > > > > > > > +     read_unlock(&uprobes_treelock);
> > > > > > > >
> > > > > > > >       return !!n;
> > > > > > > >  }
> > > > > > > > --
> > > > > > > > 2.43.0
> > > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > >
> > > > >
> > > > > --
> > > > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > >
> > >
> > > --
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

