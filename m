Return-Path: <linux-kernel+bounces-10783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2916481DBC2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 19:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4D7CB21388
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 18:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283F2D267;
	Sun, 24 Dec 2023 18:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ce4HsjkX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4792F43
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 18:15:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5670C433B7
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 18:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703441732;
	bh=eqOb3iB/FSfPM+WPp3VGjSZeorAH0Qt9bX0VFZDl2AU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ce4HsjkX7JIGhzwaHr6JlIK4nz4aPJNLB5r6sTbh/lAWOKkaoGy+/Wj5e3wpGpiuw
	 Hq1XxUAXqBft9Z54xPzKoqkfhaEUuA+jY2HyvRQZ7F7YGXgY2JalbTzJ+RuxOdqdi2
	 dCcA2ZbDB764iiYOyyy/O7pnVBezMGdruAz4mSANczrCKctpoIUei/4MVcBz9HSi5n
	 /egYgiGZLzqrJK8OgxgLDadOvok95sd6lknh+BYxj9Mnq27kIgE2qJcNvfS5y7SCeO
	 C7Kfq10UClHJsJ85rTETzXIU/XgEDkgfw4MjLsHAN/exPZz5vl8yfnujWJfPAfac/m
	 kB0T1A/f9Xt5Q==
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6d9a795cffbso493755b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 10:15:32 -0800 (PST)
X-Gm-Message-State: AOJu0YwSYGZJr8kQnHVMK28XfHwSiihzmbIY1rZx5pX+1M5y6iRhOT7D
	gdmyPSQFpxpIdEqSRnDpwLWDlXUUQOHAS8w4QKSkDaC+cW2j
X-Google-Smtp-Source: AGHT+IHJ6UydbFRiuIig5ov2qQT2o6s3FOHf75u/hCNiHZkXTKwzNnmb1qI7vsTxZ6KFn5Nz2oLXEBNRhgC7bPwK5Ec=
X-Received: by 2002:aa7:8c16:0:b0:6d9:8ddc:37e0 with SMTP id
 c22-20020aa78c16000000b006d98ddc37e0mr3796818pfd.28.1703441731988; Sun, 24
 Dec 2023 10:15:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221-async-free-v1-1-94b277992cb0@kernel.org>
 <20231222115208.ab4d2aeacdafa4158b14e532@linux-foundation.org>
 <ZYYY1VBKdLHH-Kl3@google.com> <f6bf2c8d-c37a-dab7-8ef8-38a35240edb6@google.com>
 <CAF8kJuOafpWhKSR96Lsdig_HqtLA79eeHUx9MxBzFGi95XyzuA@mail.gmail.com> <0a052cb1-a5c5-4bee-5bd5-fd5569765012@google.com>
In-Reply-To: <0a052cb1-a5c5-4bee-5bd5-fd5569765012@google.com>
From: Chris Li <chrisl@kernel.org>
Date: Sun, 24 Dec 2023 10:15:20 -0800
X-Gmail-Original-Message-ID: <CAF8kJuM59_12VNZ9d4oXZiLbAQC4LGLXODHqZw+7jiCJYva6YQ@mail.gmail.com>
Message-ID: <CAF8kJuM59_12VNZ9d4oXZiLbAQC4LGLXODHqZw+7jiCJYva6YQ@mail.gmail.com>
Subject: Re: [PATCH] mm: swap: async free swap slot cache entries
To: David Rientjes <rientjes@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Wei Xu <weixugc@google.com>, Yu Zhao <yuzhao@google.com>, 
	Greg Thelen <gthelen@google.com>, Chun-Tse Shao <ctshao@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Brain Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mel Gorman <mgorman@techsingularity.net>, Huang Ying <ying.huang@intel.com>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <kasong@tencent.com>, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Barry Song <v-songbaohua@oppo.com>, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 7:01=E2=80=AFPM David Rientjes <rientjes@google.com=
> wrote:
>
> On Sat, 23 Dec 2023, Chris Li wrote:
>
> > > How do you quantify the impact of the delayed swap_entry_free()?
> > >
> > > Since the free and memcg uncharge are now delayed, is there not the
> > > possibility that we stay under memory pressure for longer?  (Assuming=
 at
> > > least some users are swapping because of memory pressure.)
> > >
> > > I would assume that since the free and uncharge itself is delayed tha=
t in
> > > the pathological case we'd actually be swapping *more* until the asyn=
c
> > > worker can run.
> >
> > Thanks for raising this interesting question.
> >
> > First of all, the swap_entry_free() does not impact "memory.current".
> > It reduces "memory.swap.current". Technically it is the swap pressure
> > not memory pressure that suffers the extra delay.
> >
> > Secondly, we are talking about delaying up to 64 swap entries for a
> > few microseconds.
>
> What guarantees that the async freeing happens within a few microseconds?

Linux kernel typically doesn't provide RT scheduling guarantees. You
can change microseconds to milliseconds, my following reasoning still
holds.

>
> > Where the swap slot cache itself delays the freeing
> > of the entries for an arbitrary amount of time. It is not freed until
> > the cache is full of 64 entries. This delay can be seconds or even
> > minutes. Adding a few microseconds of  extra delay to existing seconds
> > delay really makes no difference from the swap pressure point of view.

Let me rephrase it. The swap slots cache itself has arbiturely delayed
on freeing the swap slots, the slot is not free until 64 entries are
reached. Adding a few milliseconds to the current swap slot freeing
delay does not significantly change current behavior from swap
pressure point of view.

Chris

