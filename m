Return-Path: <linux-kernel+bounces-120145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 605E388D2EA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 00:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91F721C303B9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B593113E416;
	Tue, 26 Mar 2024 23:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1Te5PEg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17EE13D8AA;
	Tue, 26 Mar 2024 23:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711496585; cv=none; b=d/2VzD/JH9Wo0vXtMePaipQhUW16D6vTJA/uxdd/GU4tUe+oPhxYkWCbfwRq0BlNYcRsxN+7eAxO77orCav4YgaArN7iEm4L8/D5xroNy9HXtmWMT5yZyHDkkcXiGFHps93kko71ec9y2pDeY1/hiS/8yrqsF1lBJOT9otfZz3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711496585; c=relaxed/simple;
	bh=kI9/vVj/4BMdUHeYftmqEsqbJO5noMBQIfg14jMBKFM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EZVwqqsrgoRYJrlytw3e5Y0Rk7qoDDbIlh1I7gq7YkxKxMHTN2xjCY5Hk2e3n42YLl5jjrA1Fc/oy3uOl0di5JE4n0no4E1s0sR2zV50+ciq9f0tC0Gw/bkUOGBAY7wDs9fb63xBXVffZJk+Q6YheUPsvvc/8V93EUd1b6ZGp+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1Te5PEg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22F2C433F1;
	Tue, 26 Mar 2024 23:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711496584;
	bh=kI9/vVj/4BMdUHeYftmqEsqbJO5noMBQIfg14jMBKFM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e1Te5PEgkrCYKRBnHUyqYXAVy9x8vqXx2I7eSOMJxCbhzbY18/8jVt8W37zvxuW4d
	 wJT7SAsq0OhrnG7pvho+cqC2hsjw8cGh1rlmLXa7OyhvjOKqZ30UBMwkY7MC3WHOoU
	 9ko/ZLsxapUxeaMIy6iLbs3m9Ljyi21hpsAmm5kjdjyfF9+nU8Uvb0aUgjYe1K9ylm
	 WxElv8pjlNdXmihyI+//KM/HUXCLl/Is3yY8l3GC7nrffDskMdjnHGi/NMORU10wY7
	 XoWY2ibGVvgeLUNx65P6RQRTc8annaar9v/CODGB+sIdtLB26q2OgvwhAAHovdjzVD
	 tNVNt5neKavlQ==
Date: Wed, 27 Mar 2024 08:42:58 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jonthan Haslam <jonathan.haslam@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, andrii@kernel.org,
 bpf@vger.kernel.org, rostedt@goodmis.org, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes: reduce contention on uprobes_tree access
Message-Id: <20240327084258.c385e997782a97fef07ba084@kernel.org>
In-Reply-To: <dk3obkyavqgzr2xbpykbz3knwgyxl73acuunocoygbhtz5imhm@mdqdefp6kz3t>
References: <20240321145736.2373846-1-jonathan.haslam@gmail.com>
	<20240325120323.ec3248d330b2755e73a6571e@kernel.org>
	<dk3obkyavqgzr2xbpykbz3knwgyxl73acuunocoygbhtz5imhm@mdqdefp6kz3t>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Mar 2024 19:04:59 +0000
Jonthan Haslam <jonathan.haslam@gmail.com> wrote:

> Hi Masami,
> 
> > > This change has been tested against production workloads that exhibit
> > > significant contention on the spinlock and an almost order of magnitude
> > > reduction for mean uprobe execution time is observed (28 -> 3.5 microsecs).
> > 
> > Looks good to me.
> > 
> > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > BTW, how did you measure the overhead? I think spinlock overhead
> > will depend on how much lock contention happens.
> 
> Absolutely. I have the original production workload to test this with and
> a derived one that mimics this test case. The production case has ~24
> threads running on a 192 core system which access 14 USDTs around 1.5
> million times per second in total (across all USDTs). My test case is
> similar but can drive a higher rate of USDT access across more threads and
> therefore generate higher contention.

Thanks for the info. So this result is measured in enough large machine
with high parallelism. So lock contention is matter.
Can you also include this information with the number in next version?

Thank you,

> 
> All measurements are done using bpftrace scripts around relevant parts of
> code in uprobes.c and application code.
> 
> Jon.
> 
> > 
> > Thank you,
> > 
> > > 
> > > [0] https://docs.kernel.org/locking/spinlocks.html
> > > 
> > > Signed-off-by: Jonathan Haslam <jonathan.haslam@gmail.com>
> > > ---
> > >  kernel/events/uprobes.c | 22 +++++++++++-----------
> > >  1 file changed, 11 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > > index 929e98c62965..42bf9b6e8bc0 100644
> > > --- a/kernel/events/uprobes.c
> > > +++ b/kernel/events/uprobes.c
> > > @@ -39,7 +39,7 @@ static struct rb_root uprobes_tree = RB_ROOT;
> > >   */
> > >  #define no_uprobe_events()	RB_EMPTY_ROOT(&uprobes_tree)
> > >  
> > > -static DEFINE_SPINLOCK(uprobes_treelock);	/* serialize rbtree access */
> > > +static DEFINE_RWLOCK(uprobes_treelock);	/* serialize rbtree access */
> > >  
> > >  #define UPROBES_HASH_SZ	13
> > >  /* serialize uprobe->pending_list */
> > > @@ -669,9 +669,9 @@ static struct uprobe *find_uprobe(struct inode *inode, loff_t offset)
> > >  {
> > >  	struct uprobe *uprobe;
> > >  
> > > -	spin_lock(&uprobes_treelock);
> > > +	read_lock(&uprobes_treelock);
> > >  	uprobe = __find_uprobe(inode, offset);
> > > -	spin_unlock(&uprobes_treelock);
> > > +	read_unlock(&uprobes_treelock);
> > >  
> > >  	return uprobe;
> > >  }
> > > @@ -701,9 +701,9 @@ static struct uprobe *insert_uprobe(struct uprobe *uprobe)
> > >  {
> > >  	struct uprobe *u;
> > >  
> > > -	spin_lock(&uprobes_treelock);
> > > +	write_lock(&uprobes_treelock);
> > >  	u = __insert_uprobe(uprobe);
> > > -	spin_unlock(&uprobes_treelock);
> > > +	write_unlock(&uprobes_treelock);
> > >  
> > >  	return u;
> > >  }
> > > @@ -935,9 +935,9 @@ static void delete_uprobe(struct uprobe *uprobe)
> > >  	if (WARN_ON(!uprobe_is_active(uprobe)))
> > >  		return;
> > >  
> > > -	spin_lock(&uprobes_treelock);
> > > +	write_lock(&uprobes_treelock);
> > >  	rb_erase(&uprobe->rb_node, &uprobes_tree);
> > > -	spin_unlock(&uprobes_treelock);
> > > +	write_unlock(&uprobes_treelock);
> > >  	RB_CLEAR_NODE(&uprobe->rb_node); /* for uprobe_is_active() */
> > >  	put_uprobe(uprobe);
> > >  }
> > > @@ -1298,7 +1298,7 @@ static void build_probe_list(struct inode *inode,
> > >  	min = vaddr_to_offset(vma, start);
> > >  	max = min + (end - start) - 1;
> > >  
> > > -	spin_lock(&uprobes_treelock);
> > > +	read_lock(&uprobes_treelock);
> > >  	n = find_node_in_range(inode, min, max);
> > >  	if (n) {
> > >  		for (t = n; t; t = rb_prev(t)) {
> > > @@ -1316,7 +1316,7 @@ static void build_probe_list(struct inode *inode,
> > >  			get_uprobe(u);
> > >  		}
> > >  	}
> > > -	spin_unlock(&uprobes_treelock);
> > > +	read_unlock(&uprobes_treelock);
> > >  }
> > >  
> > >  /* @vma contains reference counter, not the probed instruction. */
> > > @@ -1407,9 +1407,9 @@ vma_has_uprobes(struct vm_area_struct *vma, unsigned long start, unsigned long e
> > >  	min = vaddr_to_offset(vma, start);
> > >  	max = min + (end - start) - 1;
> > >  
> > > -	spin_lock(&uprobes_treelock);
> > > +	read_lock(&uprobes_treelock);
> > >  	n = find_node_in_range(inode, min, max);
> > > -	spin_unlock(&uprobes_treelock);
> > > +	read_unlock(&uprobes_treelock);
> > >  
> > >  	return !!n;
> > >  }
> > > -- 
> > > 2.43.0
> > > 
> > 
> > 
> > -- 
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

