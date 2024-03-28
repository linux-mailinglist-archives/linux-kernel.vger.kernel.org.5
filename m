Return-Path: <linux-kernel+bounces-122208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4605588F378
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F6E71C278D2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3EABE58;
	Thu, 28 Mar 2024 00:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8E9L4JY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E68A46BF;
	Thu, 28 Mar 2024 00:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711585126; cv=none; b=e+Awu8mHtyFyWKju1cF7JIuJQJGPnvzY2YVuSpIXEH9mwdHOzljFyZfvCpxg5XjSZdKavjYxZWdqcf/BS8AONnGQF+AfT0ikQaxC8xfEvh9MpaTxZ+pPAR64KpNrSBBlU0sSg+w+0KI5lBdX9HAIsSS3e97Ky5mrQGf2WYI0uZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711585126; c=relaxed/simple;
	bh=zsWvlwMlsTmNhgbPPby4pHnVE3v+PWwV4d8Iew4UmEY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=U1MQXyyZenm37ZzQQ3MTsgV5GVqli7L/ZKUtmzOanL/3Tr4D3kPRSBswA/QaiT3gAiHuuFG40L58SYDOlMOrTcpaVwXf4KEEdkKHc9pxEvUIqDJQzPs27l/YdE2PAi6am2FfhMa8z2xl+0s85XLafxG+EbYXL5P5el3/wv6znk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8E9L4JY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6194C433F1;
	Thu, 28 Mar 2024 00:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711585125;
	bh=zsWvlwMlsTmNhgbPPby4pHnVE3v+PWwV4d8Iew4UmEY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q8E9L4JYgtRQazG941hY9iq9Ao7UCltmzgAzNf9H61D2wfNai/cDIjYj/WM2HJKGQ
	 WuKQzpUCcM595zNc3cjmizTX1CRLwtWvTszj5hcxhNFOkBlDhBg/E0jLF5DkwWD+vX
	 wtQbPoxnEFak7+9Vj9ne/6G2tYoY4dZoqLgU8/83pR9YU1XWU2e2o5uofQoIeXjLpu
	 SWEVg6aux2xrzhEkHD7qX4QteLy7LZ6Lu3pTndHd7Z89TFnXh7eTxzW9nmA+0O5/lr
	 CfGdwK/2Ennnq+xrmppDNd+vHwGtxBZwZ6hl3ssIM1kDlF/glf95DNV58ImhVIA0nh
	 IHa2dmAlfCblg==
Date: Thu, 28 Mar 2024 09:18:41 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jonthan Haslam <jonathan.haslam@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 linux-trace-kernel@vger.kernel.org, andrii@kernel.org, bpf@vger.kernel.org,
 rostedt@goodmis.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes: reduce contention on uprobes_tree access
Message-Id: <20240328091841.ce9cc613db375536de843cfb@kernel.org>
In-Reply-To: <54jakntmdyedadce7yrf6kljcjapbwyoqqt26dnllrqvs3pg7x@itra4a2ikgqw>
References: <20240321145736.2373846-1-jonathan.haslam@gmail.com>
	<20240325120323.ec3248d330b2755e73a6571e@kernel.org>
	<CAEf4BzZS_QCsSY0oGY_3pGveGfXKK_TkVURyNq=UQXVXSqi2Fw@mail.gmail.com>
	<20240327084245.a890ae12e579f0be1902ae4a@kernel.org>
	<54jakntmdyedadce7yrf6kljcjapbwyoqqt26dnllrqvs3pg7x@itra4a2ikgqw>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Mar 2024 17:06:01 +0000
Jonthan Haslam <jonathan.haslam@gmail.com> wrote:

> > > Masami,
> > > 
> > > Given the discussion around per-cpu rw semaphore and need for
> > > (internal) batched attachment API for uprobes, do you think you can
> > > apply this patch as is for now? We can then gain initial improvements
> > > in scalability that are also easy to backport, and Jonathan will work
> > > on a more complete solution based on per-cpu RW semaphore, as
> > > suggested by Ingo.
> > 
> > Yeah, it is interesting to use per-cpu rw semaphore on uprobe.
> > I would like to wait for the next version.
> 
> My initial tests show a nice improvement on the over RW spinlocks but
> significant regression in acquiring a write lock. I've got a few days
> vacation over Easter but I'll aim to get some more formalised results out
> to the thread toward the end of next week.

As far as the write lock is only on the cold path, I think you can choose
per-cpu RW semaphore. Since it does not do busy wait, the total system
performance impact will be small.
I look forward to your formalized results :)

Thank you,

> 
> Jon.
> 
> > 
> > Thank you,
> > 
> > > 
> > > >
> > > > BTW, how did you measure the overhead? I think spinlock overhead
> > > > will depend on how much lock contention happens.
> > > >
> > > > Thank you,
> > > >
> > > > >
> > > > > [0] https://docs.kernel.org/locking/spinlocks.html
> > > > >
> > > > > Signed-off-by: Jonathan Haslam <jonathan.haslam@gmail.com>
> > > > > ---
> > > > >  kernel/events/uprobes.c | 22 +++++++++++-----------
> > > > >  1 file changed, 11 insertions(+), 11 deletions(-)
> > > > >
> > > > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > > > > index 929e98c62965..42bf9b6e8bc0 100644
> > > > > --- a/kernel/events/uprobes.c
> > > > > +++ b/kernel/events/uprobes.c
> > > > > @@ -39,7 +39,7 @@ static struct rb_root uprobes_tree = RB_ROOT;
> > > > >   */
> > > > >  #define no_uprobe_events()   RB_EMPTY_ROOT(&uprobes_tree)
> > > > >
> > > > > -static DEFINE_SPINLOCK(uprobes_treelock);    /* serialize rbtree access */
> > > > > +static DEFINE_RWLOCK(uprobes_treelock);      /* serialize rbtree access */
> > > > >
> > > > >  #define UPROBES_HASH_SZ      13
> > > > >  /* serialize uprobe->pending_list */
> > > > > @@ -669,9 +669,9 @@ static struct uprobe *find_uprobe(struct inode *inode, loff_t offset)
> > > > >  {
> > > > >       struct uprobe *uprobe;
> > > > >
> > > > > -     spin_lock(&uprobes_treelock);
> > > > > +     read_lock(&uprobes_treelock);
> > > > >       uprobe = __find_uprobe(inode, offset);
> > > > > -     spin_unlock(&uprobes_treelock);
> > > > > +     read_unlock(&uprobes_treelock);
> > > > >
> > > > >       return uprobe;
> > > > >  }
> > > > > @@ -701,9 +701,9 @@ static struct uprobe *insert_uprobe(struct uprobe *uprobe)
> > > > >  {
> > > > >       struct uprobe *u;
> > > > >
> > > > > -     spin_lock(&uprobes_treelock);
> > > > > +     write_lock(&uprobes_treelock);
> > > > >       u = __insert_uprobe(uprobe);
> > > > > -     spin_unlock(&uprobes_treelock);
> > > > > +     write_unlock(&uprobes_treelock);
> > > > >
> > > > >       return u;
> > > > >  }
> > > > > @@ -935,9 +935,9 @@ static void delete_uprobe(struct uprobe *uprobe)
> > > > >       if (WARN_ON(!uprobe_is_active(uprobe)))
> > > > >               return;
> > > > >
> > > > > -     spin_lock(&uprobes_treelock);
> > > > > +     write_lock(&uprobes_treelock);
> > > > >       rb_erase(&uprobe->rb_node, &uprobes_tree);
> > > > > -     spin_unlock(&uprobes_treelock);
> > > > > +     write_unlock(&uprobes_treelock);
> > > > >       RB_CLEAR_NODE(&uprobe->rb_node); /* for uprobe_is_active() */
> > > > >       put_uprobe(uprobe);
> > > > >  }
> > > > > @@ -1298,7 +1298,7 @@ static void build_probe_list(struct inode *inode,
> > > > >       min = vaddr_to_offset(vma, start);
> > > > >       max = min + (end - start) - 1;
> > > > >
> > > > > -     spin_lock(&uprobes_treelock);
> > > > > +     read_lock(&uprobes_treelock);
> > > > >       n = find_node_in_range(inode, min, max);
> > > > >       if (n) {
> > > > >               for (t = n; t; t = rb_prev(t)) {
> > > > > @@ -1316,7 +1316,7 @@ static void build_probe_list(struct inode *inode,
> > > > >                       get_uprobe(u);
> > > > >               }
> > > > >       }
> > > > > -     spin_unlock(&uprobes_treelock);
> > > > > +     read_unlock(&uprobes_treelock);
> > > > >  }
> > > > >
> > > > >  /* @vma contains reference counter, not the probed instruction. */
> > > > > @@ -1407,9 +1407,9 @@ vma_has_uprobes(struct vm_area_struct *vma, unsigned long start, unsigned long e
> > > > >       min = vaddr_to_offset(vma, start);
> > > > >       max = min + (end - start) - 1;
> > > > >
> > > > > -     spin_lock(&uprobes_treelock);
> > > > > +     read_lock(&uprobes_treelock);
> > > > >       n = find_node_in_range(inode, min, max);
> > > > > -     spin_unlock(&uprobes_treelock);
> > > > > +     read_unlock(&uprobes_treelock);
> > > > >
> > > > >       return !!n;
> > > > >  }
> > > > > --
> > > > > 2.43.0
> > > > >
> > > >
> > > >
> > > > --
> > > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > 
> > -- 
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

