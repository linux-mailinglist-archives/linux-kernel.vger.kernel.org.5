Return-Path: <linux-kernel+bounces-29409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC024830DE2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A63B2832D2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561A824B31;
	Wed, 17 Jan 2024 20:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VTi+4PnX"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF5D22EEC
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 20:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705522882; cv=none; b=kpPbmWv3axxkTi6ZqytE2TYeYPEK1vQcpYQ5saIieTwXr5ItIv+JjlpjxcGKbCx1svDjhhURnzkJgupLUdrSCJ0J+IBGaqSwG4L57Hjy/iRhcwMxIP3z1VF65Vwajl0ve8lVVONWtT3XHH6AfBFj/dCbHJNNLptzjRblvPDNIiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705522882; c=relaxed/simple;
	bh=JivwyaF97QtjAsr/iFAizwqA1z7RQVn8gvQMg18rZqI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:Message-ID:Subject:To:Cc:Content-Type;
	b=pJuvMRX1SOdhHqi274K/wgYV+DnUHBreiBoL2O1blAqOC6vgwiRFxfwPyDfEx5onNQ1kqBkxB+lUztxpG6vFzvSRSGTHsgcsSokmyph5CpyEsFuYPjW+H/IMz344caRx8H8U6RYSX+xgcvLBRPvNU2HBgdMwq7FPKj24UayfED8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VTi+4PnX; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so1380422666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 12:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705522879; x=1706127679; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VANeRlQcKNuS02RIKSNSaBerKvZvwIN+PjhVd8nh4E4=;
        b=VTi+4PnXwqbiOfJjg9uWDX7QayEQl5FqXbKU/7gTKBSdDcgD4pQa3tRr6NrXuMS3/H
         yhytECYYnfYl4snMP/ZYsrypWYhiFNVruXvofuAQiJUAQnw0tQyF0qY+hS0w8GoQ9ChJ
         /r8WXFTanaS/V1nTGRurM5W06ETPhQQOrHx9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705522879; x=1706127679;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VANeRlQcKNuS02RIKSNSaBerKvZvwIN+PjhVd8nh4E4=;
        b=NvZuab79es8iMLBjc4voNL6rnGq4GnoaPtot2Ny0+dtwrNoQiktUVYU78Owp71WS6W
         5Bx2hD/+uHXbQKK3Hxlbaw/+bBv0yGbHfztMCTPutDU+KHKUsW1n0XcrilL7U5xHtkzu
         vVN/vBLHNYsqcFzgJGciRl5ehK/ja4RfJw6ZhMQGERu/eaUS2qdtoamkcXZxrwO5pna6
         H9O58PlE9cSNkMw931eqC2VHfWvbGvIWLCuzTu+8AYLXtfhaK1UVyJho9/+5XMEes6/5
         mak2BbLWWeVcnzlPGeniNITjE35G3n+U4hYZooxOWnpVSrn1abzE5WvY3Su3d6GDsbcN
         3EoQ==
X-Gm-Message-State: AOJu0Yz1+RhzkvGVHWEOio4ZbfNNkJ1GIVB+QcETJGhdiDnDcYaVZOI3
	1irtAoBBp9H5vktQLOv9QqLqV9anZ4jOHz4Cn9YXVuBCsW3drSiF
X-Google-Smtp-Source: AGHT+IGZqfDPIDvCQj+8dhCXmBsMKpMha9qpFuvXoVLKY90cu53P3/GCU9r7nuF6c9DE6t+r189wYA==
X-Received: by 2002:a17:906:144e:b0:a2c:535a:7c00 with SMTP id q14-20020a170906144e00b00a2c535a7c00mr3153898ejc.195.1705522878796;
        Wed, 17 Jan 2024 12:21:18 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id tk11-20020a170907c28b00b00a2cd84c659csm6799981ejc.70.2024.01.17.12.21.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 12:21:18 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40d6b4e2945so127938435e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 12:21:18 -0800 (PST)
X-Received: by 2002:a05:600c:1552:b0:40d:5502:5834 with SMTP id
 f18-20020a05600c155200b0040d55025834mr3233229wmg.14.1705522877914; Wed, 17
 Jan 2024 12:21:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705507931.git.jpoimboe@kernel.org> <ac84a832feba5418e1b58d1c7f3fe6cc7bc1de58.1705507931.git.jpoimboe@kernel.org>
 <6667b799702e1815bd4e4f7744eddbc0bd042bb7.camel@kernel.org> <20240117193915.urwueineol7p4hg7@treble>
In-Reply-To: <20240117193915.urwueineol7p4hg7@treble>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Jan 2024 12:20:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg_CoTOfkREgaQQA6oJ5nM9ZKYrTn=E1r-JnvmQcgWpSg@mail.gmail.com>
Message-ID: <CAHk-=wg_CoTOfkREgaQQA6oJ5nM9ZKYrTn=E1r-JnvmQcgWpSg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] fs/locks: Fix file lock cache accounting, again
To: Josh Poimboeuf <jpoimboe@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Shakeel Butt <shakeelb@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Vasily Averin <vasily.averin@linux.dev>, 
	Michal Koutny <mkoutny@suse.com>, Waiman Long <longman@redhat.com>, 
	Muchun Song <muchun.song@linux.dev>, Jiri Kosina <jikos@kernel.org>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jan 2024 at 11:39, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> That's a good point.  If the microbenchmark isn't likely to be even
> remotely realistic, maybe we should just revert the revert until if/when
> somebody shows a real world impact.
>
> Linus, any objections to that?

We use SLAB_ACCOUNT for much more common allocations like queued
signals, so I would tend to agree with Jeff that it's probably just
some not very interesting microbenchmark that shows any file locking
effects from SLAB_ALLOC, not any real use.

That said, those benchmarks do matter. It's very easy to say "not
relevant in the big picture" and then the end result is that
everything is a bit of a pig.

And the regression was absolutely *ENORMOUS*. We're not talking "a few
percent". We're talking a 33% regression that caused the revert:

   https://lore.kernel.org/lkml/20210907150757.GE17617@xsang-OptiPlex-9020/

I wish our SLAB_ACCOUNT wasn't such a pig. Rather than account every
single allocation, it would be much nicer to account at a bigger
granularity, possibly by having per-thread counters first before
falling back to the obj_cgroup_charge. Whatever.

It's kind of stupid to have a benchmark that just allocates and
deallocates a file lock in quick succession spend lots of time
incrementing and decrementing cgroup charges for that repeated
alloc/free.

However, that problem with SLAB_ACCOUNT is not the fault of file
locking, but more of a slab issue.

End result: I think we should bring in Vlastimil and whoever else is
doing SLAB_ACCOUNT things, and have them look at that side.

And then just enable SLAB_ACCOUNT for file locks. But very much look
at silly costs in SLAB_ACCOUNT first, at least for trivial
"alloc/free" patterns..

Vlastimil? Who would be the best person to look at that SLAB_ACCOUNT
thing? See commit 3754707bcc3e (Revert "memcg: enable accounting for
file lock caches") for the history here.

                 Linus

