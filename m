Return-Path: <linux-kernel+bounces-29444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 281A4830E59
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C8101C22120
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D2E25561;
	Wed, 17 Jan 2024 21:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TjrrNFBf"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A7B24A18
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 21:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705525353; cv=none; b=UjzkBv8F3a/3MwSJLGdbJvAccHXipKqEBvHKNLYVSoaKAROHoQzNMLWYdb+dyvAs9TCCk2Cgtn+IiE20rlLVYRfFhIgIL2J3UXV0fZtPZ1GulccrzgoGGQNDIbdsZozGN1RZVQVOlKW7iUl4e1jWQt3VsXjTEvxkY6QS3+xH2kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705525353; c=relaxed/simple;
	bh=x2ltNTRVY40OZPPI4mwfRvVr6yiGl4dOpCTU/Sebxb8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=qX5VPmnGV2GkcrNcNhKRBJlQoPyYbOVaOIToZGKl9coPEELiMfs+pmjgs9ZhPt+eydmziqnyInTyelybQnDk1sHsTre1KDIBkGF0ckFttFU22jB3g0QRY/WVUp+WAdF7VPeTdpIZdLUF1PR/AodN9GwX3fRB0eo4k+drYlLaSZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TjrrNFBf; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d6f1df9355so151365ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 13:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705525352; x=1706130152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsaUVhsK+enKkBw1KIJtxzFPjcPyIBpdkEzOvagjDdM=;
        b=TjrrNFBfTNTDBlHsEIFwOR9AmuxRwYRzYW0Zg2PtHW6FqeOV8A2oh95y9/OotD7tLu
         n6po1eHC/V4H/2rfP4nDM61zILpMjSrRTHfoxdnFF0RTtVp/248GhZWi28E2/sUi4Kcx
         RQ3L20VF3JQrZ4tW28olUr++xCz9QPD3L8d2ZrlE4GKV7cFPbsQRcHc9xAxSflko7ctE
         cCnxuXhIw8jtk75Uzl6AR7LYoSJSpOu3K2j9AA6uHacOInofDMz004lriyb2u4z7SL9V
         XVFooG3L6LK6Wpk4/vskvNe1z9Y1FEUeZzLNT2NEjmj3wgVAQobIjx5vF8slzrp8XSVF
         rlfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705525352; x=1706130152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsaUVhsK+enKkBw1KIJtxzFPjcPyIBpdkEzOvagjDdM=;
        b=leYM0yujrFnHuAzooT1n/m9/7FldapFVdMSRD7hVz1n2+/wi7cquIZA/E2WYtT+dIs
         8Q3+t0R6YR4Ril2yLISaVWESiqS+wSaApj67n+VaJLvM+9GSjCFCxwrPTN4Ulzop1JCJ
         zQ8AJ+kwM19BFwBNHSqljJRpR+XXqiN3nYsOZ+7aenyjOSM0NjtmmppSwvEe8GrQXWRf
         aolkVkBmTbd0wWHYqwgAoEW7sku0Rxq0jq7Ikc6O1nnX+fOitlV1J2MSr6wlRse31ULt
         rAII8SLr43N/Ev675Ez49/w4sINLL+LAfS9Ft7+TVLtHnUxIBVwo5Kf6y9Dssnpq6b12
         ucMg==
X-Gm-Message-State: AOJu0YxElDX5xno2T1Xq+Y8kRGts5KyKak7f3Di0atChvRZp+N+R74ec
	qCcmHDeXruTfLbTR4noM4S8GOWn3zVKQ5OflIOtum49/+LZHChGT2IZyRq+Aoj3OxRIvFSGsrYF
	1aiFuIi3WJXbYYe5NCEnrlLogFQkH8h3Y9JDk
X-Google-Smtp-Source: AGHT+IGWIZhqLzcx2+bVk3ob7lrZPkCBExq2fGpUqcnbH0YOKIaCLZflhVKVys1PkHM7n5+U05d1eOq+VDzUvlTq/vI=
X-Received: by 2002:a17:902:aa98:b0:1d5:b931:911a with SMTP id
 d24-20020a170902aa9800b001d5b931911amr234007plr.27.1705525351695; Wed, 17 Jan
 2024 13:02:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705507931.git.jpoimboe@kernel.org> <ac84a832feba5418e1b58d1c7f3fe6cc7bc1de58.1705507931.git.jpoimboe@kernel.org>
 <6667b799702e1815bd4e4f7744eddbc0bd042bb7.camel@kernel.org>
 <20240117193915.urwueineol7p4hg7@treble> <CAHk-=wg_CoTOfkREgaQQA6oJ5nM9ZKYrTn=E1r-JnvmQcgWpSg@mail.gmail.com>
In-Reply-To: <CAHk-=wg_CoTOfkREgaQQA6oJ5nM9ZKYrTn=E1r-JnvmQcgWpSg@mail.gmail.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Wed, 17 Jan 2024 13:02:19 -0800
Message-ID: <CALvZod6LgX-FQOGgNBmoRACMBK4GB+K=a+DYrtExcuGFH=J5zQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] fs/locks: Fix file lock cache accounting, again
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Vasily Averin <vasily.averin@linux.dev>, 
	Michal Koutny <mkoutny@suse.com>, Waiman Long <longman@redhat.com>, 
	Muchun Song <muchun.song@linux.dev>, Jiri Kosina <jikos@kernel.org>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 12:21=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 17 Jan 2024 at 11:39, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >
> > That's a good point.  If the microbenchmark isn't likely to be even
> > remotely realistic, maybe we should just revert the revert until if/whe=
n
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
>    https://lore.kernel.org/lkml/20210907150757.GE17617@xsang-OptiPlex-902=
0/
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
> thing? See commit 3754707bcc3e (Revert "memcg: enable accounting for
> file lock caches") for the history here.
>

Roman last looked into optimizing this code path. I suspect
mod_objcg_state() to be more costly than obj_cgroup_charge(). I will
try to measure this path and see if I can improve it.

