Return-Path: <linux-kernel+bounces-29472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BCB830EC7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06B8D281814
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47C125629;
	Wed, 17 Jan 2024 21:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WKrTihVi"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7F822EEC
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 21:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705528244; cv=none; b=pOGwJqq5SKs9rXgDtkuklWggmx7F3+CD0FvbmbYy38qoyI3rdfimLoV4NZrJDKu8PTS08TPgBHzcGsuzBYOWAKxrK/vXELzF9vHgqkI5uj18z6kr/5Q71qIc+aRe8t25w/ixj7m00+9HEUjWl8R5Ie+h4o5Vju0KmIVqh6WhW8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705528244; c=relaxed/simple;
	bh=tw3Bffx+jXGQej1es+SNpEOHPunpSbyeYD8gKGLR3wk=;
	h=Date:DKIM-Signature:X-Report-Abuse:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Migadu-Flow; b=BNeGvWhtjsl9IpdyyM3Wybm2xuOAoB5T4qWxI82M9Q7gTmtKZOjJLeUy2v9L1mfgfCguGrsqJVfwStsdKbw4o07ET0yA3PW9c73uDTVH4ohX5exRJcPtMdkKGNHWjXaC97d17y5TgQjzt3jb3l1iQaorpG+9ql+Sw9Ase9Cd5uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WKrTihVi; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 17 Jan 2024 13:50:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705528240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hZH2X8i8fkwb6v6GNbjpSk8FwvFnf/kAGw1sC2lsz24=;
	b=WKrTihViJJAbzutckdH2ar3h3Vh3IGlt4SbVr506sVdORjgjf+0prxWLJBSSjS3+v1YPmF
	R2WrY51IN8wkCcapp5q8uSlxSIA8KusSSq3CU4pkkspKRlVKzpcSEhFnd/fh3N7qhfuN/a
	kh7pYOsSrqK2T/wLpvrJMMtdbr8Ciyc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Shakeel Butt <shakeelb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	Vasily Averin <vasily.averin@linux.dev>,
	Michal Koutny <mkoutny@suse.com>, Waiman Long <longman@redhat.com>,
	Muchun Song <muchun.song@linux.dev>, Jiri Kosina <jikos@kernel.org>,
	cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH RFC 1/4] fs/locks: Fix file lock cache accounting, again
Message-ID: <ZahLnurHPozlSleN@P9FQF9L96D.corp.robot.car>
References: <cover.1705507931.git.jpoimboe@kernel.org>
 <ac84a832feba5418e1b58d1c7f3fe6cc7bc1de58.1705507931.git.jpoimboe@kernel.org>
 <6667b799702e1815bd4e4f7744eddbc0bd042bb7.camel@kernel.org>
 <20240117193915.urwueineol7p4hg7@treble>
 <CAHk-=wg_CoTOfkREgaQQA6oJ5nM9ZKYrTn=E1r-JnvmQcgWpSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg_CoTOfkREgaQQA6oJ5nM9ZKYrTn=E1r-JnvmQcgWpSg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 17, 2024 at 12:20:59PM -0800, Linus Torvalds wrote:
> On Wed, 17 Jan 2024 at 11:39, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >
> > That's a good point.  If the microbenchmark isn't likely to be even
> > remotely realistic, maybe we should just revert the revert until if/when
> > somebody shows a real world impact.
> >
> > Linus, any objections to that?
> 
> We use SLAB_ACCOUNT for much more common allocations like queued
> signals, so I would tend to agree with Jeff that it's probably just
> some not very interesting microbenchmark that shows any file locking
> effects from SLAB_ALLOC, not any real use.
> 
> That said, those benchmarks do matter. It's very easy to say "not
> relevant in the big picture" and then the end result is that
> everything is a bit of a pig.
> 
> And the regression was absolutely *ENORMOUS*. We're not talking "a few
> percent". We're talking a 33% regression that caused the revert:
> 
>    https://lore.kernel.org/lkml/20210907150757.GE17617@xsang-OptiPlex-9020/
> 
> I wish our SLAB_ACCOUNT wasn't such a pig. Rather than account every
> single allocation, it would be much nicer to account at a bigger
> granularity, possibly by having per-thread counters first before
> falling back to the obj_cgroup_charge. Whatever.
> 
> It's kind of stupid to have a benchmark that just allocates and
> deallocates a file lock in quick succession spend lots of time
> incrementing and decrementing cgroup charges for that repeated
> alloc/free.
> 
> However, that problem with SLAB_ACCOUNT is not the fault of file
> locking, but more of a slab issue.
> 
> End result: I think we should bring in Vlastimil and whoever else is
> doing SLAB_ACCOUNT things, and have them look at that side.
> 
> And then just enable SLAB_ACCOUNT for file locks. But very much look
> at silly costs in SLAB_ACCOUNT first, at least for trivial
> "alloc/free" patterns..
> 
> Vlastimil? Who would be the best person to look at that SLAB_ACCOUNT
> thing?

Probably me.

I recently did some work on improving the kmem accounting performance,
which is mentioned in this thread and shaves off about 30%:
https://lore.kernel.org/lkml/20231019225346.1822282-1-roman.gushchin@linux.dev/

Overall the SLAB_ACCOUNT overhead looks big on micro-benchmarks simple because
SLAB allocation path is really fast, so even touching a per-cpu variable adds
a noticeable overhead. There is nothing particularly slow on the kmem allocation
and release paths, but saving a memcg/objcg pointer, bumping the charge
and stats adds up, even though we have batching in place.

I believe the only real way to make it significantly faster is to cache
pre-charged slab objects, but it adds to the complexity and increases the memory
footprint. So far it was all about micro-benchmarks, I haven't seen any
complaints on the performance of real workloads.

Thanks!

