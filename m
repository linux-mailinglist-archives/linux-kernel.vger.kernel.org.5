Return-Path: <linux-kernel+bounces-29521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FDB830F91
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 574E21F261AD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1190224C2;
	Wed, 17 Jan 2024 22:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CZ9bAi6I"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E571E885
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 22:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705532188; cv=none; b=g90XIjFnQiB8k2S94GuLFT4FlFo+RFPpc6bIJS9bWAZVLwcJ2bsw4KnnQe3WV6pt53hybF3w8O+JK+2rNs5yeffKrIWlhwfnYXHa1gdauASY4L+Mau/xks2oqZ1nAXHMmtkvWCGuQqNXiVdD7dDlOrWB1QwomhDwNHiqj41fYZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705532188; c=relaxed/simple;
	bh=Da11o87IOuakB6YpOGtRihXwB6ybYLPyw0iqr8MnkDY=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=YNchPTgPO/Ry/voCrNsbJVEt4wQASCae/ZCmDWsybOZ/EMkEt5qVimgvPGwiOuwc+p3xvwNH0yLSMcOEzInP3fX5PyohDZIyNf/OOzuaYDufp+Esqt78Rnsrm3cshUoscxr3PWCSREcsLEXbsB5X5Ol+QZSeHJsfely4qL8493w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CZ9bAi6I; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-429bdb17616so406491cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705532185; x=1706136985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGcgRuVseEOV3oC1VpSFRFC5b02XYAyQRuzT8bO3Zzs=;
        b=CZ9bAi6IFm7q3PcdXGEDltOARPGPos+xATI1G8oimI5D+1fxv1j6SJfrlw5Rf0HmJO
         eMN7jxXhQCZp7AtVrRQ+0BxyuvDkotEF0itXMlPMV3jml2ZtUuKvueT08XVaVul8vGVX
         Jegvq/C4m8+MLf76ufoxI2F2dQ1XPxJKtK1mv491W2Fwo5W5Uc55Blu016rBFHDZGc9Q
         TFH/taHu5M/XXS7N2CVOzODU300URkDjAnz9ZOuKB9ULSkDwTLoK73jUr47hl+R7SM4g
         Zb7Nu/EUUww5waWwRKSDev5dY7X21ANgctowWT8AUwG8LaDjAzeZ3exlvCvrbNS0Yz9d
         PS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705532185; x=1706136985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bGcgRuVseEOV3oC1VpSFRFC5b02XYAyQRuzT8bO3Zzs=;
        b=pJvIscLk0m4JrFzSjcUxm0vuk51Gmji0jmH/v3SuDwvVOBB2FJZgETGlgtcaDKkxmq
         QC/Hg6I2669BI8e+CuD0/jD9rxZUVFPNqTdZq790OyVohP/VU3Tr3jviLLUFsBVaIMio
         mQT4Kr7gzwG6eYsNtQ707yaJFjjGb4pnlzvf3Bdz07xHCz8HPafNEbx6Q/zi0+HsU2Dc
         kXpJEZIqmLXHJAQ0799QJWuHCyLsWOMcZ2O5EhReWc0ifJkQRlr+FADizPHJ9bf9NprJ
         GSJnuk8rH2KpjRk4AuIVc7OyX7ydP1+JEcNLOpbId1QXvLJd9pZX1EXhxNmsUYevH0k4
         oQ7Q==
X-Gm-Message-State: AOJu0Yz7ak2i4H+cGOI34MEAsFvriD7vhORTqtwRHC2uCAzlW68yeMqu
	+/auKAOKYzSh+nuqAydIl17IFTZHUZsC1sR7jt1c3l1X3kZ51+pzIJ6AO1DAz/k6rAOQjaWLsI6
	kKgmfO7pbXuTa/NLtwC/dXjkklvZyJgVtOTq8
X-Google-Smtp-Source: AGHT+IF1P30PiLjC2CQWqrwirPzdBqiOUoNxTHpv9JcFeNcMRLyFct/qjqhKxCmRPW8qqdV7EHPEaNFhiWXXS9AKCwA=
X-Received: by 2002:a05:622a:5c99:b0:42a:101b:61b0 with SMTP id
 ge25-20020a05622a5c9900b0042a101b61b0mr418353qtb.2.1705532185394; Wed, 17 Jan
 2024 14:56:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705507931.git.jpoimboe@kernel.org> <ac84a832feba5418e1b58d1c7f3fe6cc7bc1de58.1705507931.git.jpoimboe@kernel.org>
 <6667b799702e1815bd4e4f7744eddbc0bd042bb7.camel@kernel.org>
 <20240117193915.urwueineol7p4hg7@treble> <CAHk-=wg_CoTOfkREgaQQA6oJ5nM9ZKYrTn=E1r-JnvmQcgWpSg@mail.gmail.com>
 <CALvZod6LgX-FQOGgNBmoRACMBK4GB+K=a+DYrtExcuGFH=J5zQ@mail.gmail.com> <ZahSlnqw9yRo3d1v@P9FQF9L96D.corp.robot.car>
In-Reply-To: <ZahSlnqw9yRo3d1v@P9FQF9L96D.corp.robot.car>
From: Shakeel Butt <shakeelb@google.com>
Date: Wed, 17 Jan 2024 14:56:11 -0800
Message-ID: <CALvZod4V3QTULTW5QxgqCbDpNtVO6fXzta33HR7GN=L2LUU26g@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] fs/locks: Fix file lock cache accounting, again
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Vasily Averin <vasily.averin@linux.dev>, 
	Michal Koutny <mkoutny@suse.com>, Waiman Long <longman@redhat.com>, 
	Muchun Song <muchun.song@linux.dev>, Jiri Kosina <jikos@kernel.org>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 2:20=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> On Wed, Jan 17, 2024 at 01:02:19PM -0800, Shakeel Butt wrote:
> > On Wed, Jan 17, 2024 at 12:21=E2=80=AFPM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > On Wed, 17 Jan 2024 at 11:39, Josh Poimboeuf <jpoimboe@kernel.org> wr=
ote:
> > > >
> > > > That's a good point.  If the microbenchmark isn't likely to be even
> > > > remotely realistic, maybe we should just revert the revert until if=
/when
> > > > somebody shows a real world impact.
> > > >
> > > > Linus, any objections to that?
> > >
> > > We use SLAB_ACCOUNT for much more common allocations like queued
> > > signals, so I would tend to agree with Jeff that it's probably just
> > > some not very interesting microbenchmark that shows any file locking
> > > effects from SLAB_ALLOC, not any real use.
> > >
> > > That said, those benchmarks do matter. It's very easy to say "not
> > > relevant in the big picture" and then the end result is that
> > > everything is a bit of a pig.
> > >
> > > And the regression was absolutely *ENORMOUS*. We're not talking "a fe=
w
> > > percent". We're talking a 33% regression that caused the revert:
> > >
> > >    https://lore.kernel.org/lkml/20210907150757.GE17617@xsang-OptiPlex=
-9020/
> > >
> > > I wish our SLAB_ACCOUNT wasn't such a pig. Rather than account every
> > > single allocation, it would be much nicer to account at a bigger
> > > granularity, possibly by having per-thread counters first before
> > > falling back to the obj_cgroup_charge. Whatever.
> > >
> > > It's kind of stupid to have a benchmark that just allocates and
> > > deallocates a file lock in quick succession spend lots of time
> > > incrementing and decrementing cgroup charges for that repeated
> > > alloc/free.
> > >
> > > However, that problem with SLAB_ACCOUNT is not the fault of file
> > > locking, but more of a slab issue.
> > >
> > > End result: I think we should bring in Vlastimil and whoever else is
> > > doing SLAB_ACCOUNT things, and have them look at that side.
> > >
> > > And then just enable SLAB_ACCOUNT for file locks. But very much look
> > > at silly costs in SLAB_ACCOUNT first, at least for trivial
> > > "alloc/free" patterns..
> > >
> > > Vlastimil? Who would be the best person to look at that SLAB_ACCOUNT
> > > thing? See commit 3754707bcc3e (Revert "memcg: enable accounting for
> > > file lock caches") for the history here.
> > >
> >
> > Roman last looked into optimizing this code path. I suspect
> > mod_objcg_state() to be more costly than obj_cgroup_charge(). I will
> > try to measure this path and see if I can improve it.
>
> It's roughly an equal split between mod_objcg_state() and obj_cgroup_char=
ge().
> And each is comparable (by order of magnitude) to the slab allocation cos=
t
> itself. On the free() path a significant cost comes simple from reading
> the objcg pointer (it's usually a cache miss).
>
> So I don't see how we can make it really cheap (say, less than 5% overhea=
d)
> without caching pre-accounted objects.

Maybe this is what we want. Now we are down to just SLUB, maybe such
caching of pre-accounted objects can be in SLUB layer and we can
decide to keep this caching per-kmem-cache opt-in or always on.

>
> I thought about merging of charge and stats handling paths, which _maybe_=
 can
> shave off another 20-30%, but there still will be a double-digit% account=
ing
> overhead.
>
> I'm curious to hear other ideas and suggestions.
>
> Thanks!

