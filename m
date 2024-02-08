Return-Path: <linux-kernel+bounces-58593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F1584E8A0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 988BF29566F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A378A2421D;
	Thu,  8 Feb 2024 19:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkNYqr66"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363F54C7C;
	Thu,  8 Feb 2024 19:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707418902; cv=none; b=CpFAyelcAZGPOFgn2nn0OucC5wPLskG3cHC91EFqh5B7/n8s6JSdnMuohIO2PonuDkqRcSPL9WtGWVug+JM1ZS9Kfddj0mQSXzzE3WcyFVnOY/9rxWq0boEzl9lXThqG4hVJEemI9hksbetg0e16CeJmxRCnQRvYXW38kzngXjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707418902; c=relaxed/simple;
	bh=a8sPLE7pdODqfSJcbtUZGOPnrgiMMh49Z7XQoNEAkYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HFMrK0jeEGwqjSpmTJ5H/DHEaVq7skqHFsgpKZmCQzPqPT1emmp9qY+vzCa9aJI9jniQc8qaPU/sr0nvdh2qCLvXg67FYF3O2OLLXPXwAUm0fI43zzz3zTsrD8WRhogxZxn3qJibsO8GO/xHU4rJtVqMhq3B4OXDIPmDiGNGV2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkNYqr66; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d0c7e6b240so2634141fa.0;
        Thu, 08 Feb 2024 11:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707418899; x=1708023699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8sPLE7pdODqfSJcbtUZGOPnrgiMMh49Z7XQoNEAkYw=;
        b=CkNYqr66mlM5ITF3Jci5sJqDz+sAvUWamAB2GWhicO9QZBG0LDb0dLLMyF9rzv++B5
         6wEKCoxN4mbsO/Hq94+B3+H+fxUBbuuBw250MCFcvHtnxZakJ1z1KW4tI1CAsR+liWAr
         QPdR8jxsgiDoEqhr5XMxcmRosWO7lFT8WY1wGKVMo4aXH0AWDabAIAO71w2ooc30bIub
         4Jb6H1p3LOtn1/yB0PvaDccOp26VwpxgQ5wlACDkGw0VlQkTqrMuIfNpgtJ7U0/c08T5
         Jork8OhPP+NvbGBf31PQNU/4atrPAZRklFLHIY8x0Q3pubV61UmwUCcGj9+RLVPO2pcj
         FSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707418899; x=1708023699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8sPLE7pdODqfSJcbtUZGOPnrgiMMh49Z7XQoNEAkYw=;
        b=qRQ55A1kXNikNysZJR+gB922x9MEPHhxRdG0LSxiCyZ2RI1V+b/WaNODeNWSk56Jfi
         RFyvkE+8TYekFGbaSxpD0J6FJDhCcAeQSIY0aIe7wf3P02txgwpuQfuK/D4gnoNq1cMS
         fpv6hGmA/WraSmnA8nws9vKDmutLFSYzu3H9zs50pyLR85m79rFw/WDxny8H2WLAOJQz
         1UX+nNHKPoK1Rb1WvQOtevIvmyLQ+u/F2LCOw6/AZz9W5Q5RwCyXJrEQOvc5Je70Z/vS
         szL5lE39P5CdgIaVkFQz/uhkLN0DWWJS4/IJTw4MyPl6WyPG7xDYjLbzFE8oMLlCBLyL
         py1g==
X-Gm-Message-State: AOJu0YxWRw3Dib1ldK1vbIS5QPmnkf53UvWFb+iSO+MRpD9nWUKzH/gL
	5NakG1otaMh8hDDAb45owFDP5UrEhBHM59CafDom6OZeeUYkiFstCv+EQ8MXTWf8C7dhtwMq3LS
	GPgxMXjacvD8h2pA0Q482brQUEeM=
X-Google-Smtp-Source: AGHT+IGiCf1xJW70ovof+reQWmPl2n3Fs3lRMMDNhultrmK35DvsStw9uBA2U2cf4tCfU0543zggc7bJDTh6YzOtQtE=
X-Received: by 2002:a05:651c:1505:b0:2d0:9a29:f849 with SMTP id
 e5-20020a05651c150500b002d09a29f849mr185898ljf.29.1707418898907; Thu, 08 Feb
 2024 11:01:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206182559.32264-1-ryncsn@gmail.com> <CAF8kJuMe7MYsAhwX804jZfO4w6kt74YMZXuz+FqUbZEt70p7Rg@mail.gmail.com>
 <CAGsJ_4zF+U5JG8XYANe2x0VbjovokFCirf=YLHOfO3E-U8b4sg@mail.gmail.com>
 <CAF8kJuOBtT+n5CM2s1Mobk5fzpgetCSMTZ-nb8+0KUj1W5f+Mw@mail.gmail.com>
 <CAMgjq7CV-Cxar8cRj1SxB4ZtO8QPTUuA5mj9_vQro7sm+eFH=w@mail.gmail.com>
 <CAF8kJuOQqqqM6MvOvo4PyOhT9eyNFreQjWC+TybGYDgXRfpweA@mail.gmail.com>
 <CAMgjq7CBV4dVo7ETr0K1VbLE=M7T0Go5=7pHBUY6=o0cuXaZXg@mail.gmail.com>
 <ZcPMi6DX5PN4WwHr@google.com> <CAMgjq7AJo1SKzRc-w5UuK3Ojk5PaXxRV2_G2Ww9BGgiNRp_5Eg@mail.gmail.com>
 <87eddnxy47.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87eddnxy47.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 9 Feb 2024 03:01:20 +0800
Message-ID: <CAMgjq7Cg+8zy25Cif2DJ0Qey3bC=Ni0q7xHNO9ka+ezoK1rgxA@mail.gmail.com>
Subject: Re: [PATCH v2] mm/swap: fix race when skipping swapcache
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Minchan Kim <minchan@kernel.org>, Chris Li <chrisl@kernel.org>, 
	Barry Song <21cnbao@gmail.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Yu Zhao <yuzhao@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, SeongJae Park <sj@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 2:36=E2=80=AFPM Huang, Ying <ying.huang@intel.com> w=
rote:
>
> Kairui Song <ryncsn@gmail.com> writes:
>
> > On Thu, Feb 8, 2024 at 2:31=E2=80=AFAM Minchan Kim <minchan@kernel.org>=
 wrote:
> >>
> >> On Wed, Feb 07, 2024 at 12:06:15PM +0800, Kairui Song wrote:
>
> [snip]
>
> >> >
> >> > So I think the thing is, it's getting complex because this patch
> >> > wanted to make it simple and just reuse the swap cache flags.
> >>
> >> I agree that a simple fix would be the important at this point.
> >>
> >> Considering your description, here's my understanding of the other ide=
a:
> >> Other method, such as increasing the swap count, haven't proven effect=
ive
> >> in your tests. The approach risk forcing racers to rely on the swap ca=
che
> >> again and the potential performance loss in race scenario.
> >>
> >> While I understand that simplicity is important, and performance loss
> >> in this case may be infrequent, I believe swap_count approach could be=
 a
> >> suitable solution. What do you think?
> >
> > Hi Minchan
> >
> > Yes, my main concern was about simplicity and performance.
> >
> > Increasing swap_count here will also race with another process from
> > releasing swap_count to 0 (swapcache was able to sync callers in other
> > call paths but we skipped swapcache here).
>
> What is the consequence of the race condition?

Hi Ying,

It will increase the swap count of an already freed entry, this race
with multiple swap free/alloc logic that checks if count =3D=3D
SWAP_HAS_CACHE or sets count to zero, or repeated free of an entry,
all result in random corruption of the swap map. This happens a lot
during stress testing.

>
> > So the right step is: 1. Lock the cluster/swap lock; 2. Check if still
> > have swap_count =3D=3D 1, bail out if not; 3. Set it to 2;
> > __swap_duplicate can be modified to support this, it's similar to
> > existing logics for SWAP_HAS_CACHE.
> >
> > And swap freeing path will do more things, swapcache clean up needs to
> > be handled even in the bypassing path since the racer may add it to
> > swapcache.
> >
> > Reusing SWAP_HAS_CACHE seems to make it much simpler and avoided many
> > overhead, so I used that way in this patch, the only issue is
> > potentially repeated page faults now.
> >
> > I'm currently trying to add a SWAP_MAP_LOCK (or SWAP_MAP_SYNC, I'm bad
> > at naming it) special value, so any racer can just spin on it to avoid
> > all the problems, how do you think about this?
>
> Let's try some simpler method firstly.

Another simpler idea is, add a schedule() or
schedule_timeout_uninterruptible(1) in the swapcache_prepare failure
path before goto out (just like __read_swap_cache_async). I think this
should ensure in almost all cases, PTE is ready after it returns, also
yields more CPU.

