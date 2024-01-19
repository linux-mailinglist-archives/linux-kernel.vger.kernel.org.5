Return-Path: <linux-kernel+bounces-30767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDBE832425
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BBBE1C227DB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 05:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FC54A0A;
	Fri, 19 Jan 2024 05:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbV+3zun"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F184691
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 05:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705641203; cv=none; b=bVH2T0UahnHKpcnjBa/U4vsu5Jy+cVvQwEkUuMmsfhfekfcTlWoIjw+vPY1Mb3KKzkvUTq0/JCF09NU6GtcC0NrG/DM8UVjxh0ZEfqFUP0lTYN7FuG2EgEDK4fXDRKWmbe5EYQpfOlyORc72TyigKP5FzXGoai96gk/6BjARFx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705641203; c=relaxed/simple;
	bh=Ne6s30tyKXga+DbCWN5zpt/HH+395I1ynKLHxGT4RsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Sl7rtJuEgE7JBXTpYLHfr6hER3+758Hc4hjT0zZT+XLETqN8cxRrCK2ZJw52SZugWtBT2GRwTuzh/F2eGnoaS3nQqByD0KJu3pN4mrF+RvW+smq19gv8YRGsplYv4OlJfhhQGwQmtCgMaPjU8ZDIu/PDOLVczKxNnITfxGUPv6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbV+3zun; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F41C43609
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 05:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705641202;
	bh=Ne6s30tyKXga+DbCWN5zpt/HH+395I1ynKLHxGT4RsQ=;
	h=References:In-Reply-To:From:Date:Subject:To:From;
	b=lbV+3zunRyYYnwhJj5srk2lhNvfqikcWIHF4w1ZuWXbq+wqCBaFZVLEhYT/3sa2kr
	 6xw3jg60ateipQEDDLhsS2NT8Hs+mBIcWs7rbE8+YyUFrw+jhJgA/fy7mf9kUGjlQi
	 p3aCOc3tnSZuAmoObxXCEjzmlYJ8ZcsLWZ0KwSmiyw77Dbe6Qx9bOPW3xiJEdNp5xV
	 lNPtZkEprRA5O/pwqfsby5/+vHL8SJeSjcT6gmdRZxOnYWgZRNH/wUBlYAYOhrUxLH
	 q2/GFYzFN3Ub2KBbRQZtZM5D+MGvAVzr2jVDK2tCgPTW54eJVUK41JRwKm5TbZFyuo
	 lvf2I8FoVnLFQ==
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2902b142211so346023a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 21:13:22 -0800 (PST)
X-Gm-Message-State: AOJu0YxHXge2t/cwzcxsYWARx7j/tDvl1/qDLM+C399K+8A/aovG5aNv
	7U0+bR9XbPGxNrzmVo7lIYmwwi3tBNey+seiL8t0DLi4MhrjIC+A/6De5BAuL1z+HWIbnP6mH3P
	iZYO7hQEgazI3E2qoryAasUzU9Qyd97kpK1xU
X-Google-Smtp-Source: AGHT+IFbtKlJJd9U0YKEdyOEquQDg4knOOuf/VrFmAHmrTA0QnwX7UBqM7VSQmdcEeAO41fum+dshTVNbb7S+3SZTAs=
X-Received: by 2002:a17:90a:c305:b0:28f:fc44:f61e with SMTP id
 g5-20020a17090ac30500b0028ffc44f61emr1597466pjt.60.1705641202088; Thu, 18 Jan
 2024 21:13:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org>
 <CAJD7tkbQb5nAQdhHXELQsUWs8KhwnoOZ7C8Eu2o7tCYSKeY9Ug@mail.gmail.com>
 <CANeU7Q=mphnSfiZRwFhqFTy56d2ifa5Pz-aa1h3O1PXUo_cu=Q@mail.gmail.com> <20240118180959.gwqphdgmf7r5sdne@revolver>
In-Reply-To: <20240118180959.gwqphdgmf7r5sdne@revolver>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 18 Jan 2024 21:13:10 -0800
X-Gmail-Original-Message-ID: <CAF8kJuMZ7F8UT8xjGb7F0QjZjK5LvSx_fDj7NWinTjqwWiyDCw@mail.gmail.com>
Message-ID: <CAF8kJuMZ7F8UT8xjGb7F0QjZjK5LvSx_fDj7NWinTjqwWiyDCw@mail.gmail.com>
Subject: Re: [PATCH 0/2] RFC: zswap tree use xarray instead of RB tree
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christopher Li <chrisl@kernel.org>, 
	Yosry Ahmed <yosryahmed@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	=?UTF-8?B?V2VpIFh177+8?= <weixugc@google.com>, Yu Zhao <yuzhao@google.com>, 
	Greg Thelen <gthelen@google.com>, Chun-Tse Shao <ctshao@google.com>, 
	=?UTF-8?Q?Suren_Baghdasaryan=EF=BF=BC?= <surenb@google.com>, 
	Brain Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mel Gorman <mgorman@techsingularity.net>, Huang Ying <ying.huang@intel.com>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <kasong@tencent.com>, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Barry Song <v-songbaohua@oppo.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 11:00=E2=80=AFAM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
> > >
> > > >
> > > > The first patch adds the xarray alongside the RB tree.
> > > > There is some debug check asserting the xarray agrees with
> > > > the RB tree results.
> > > >
> > > > The second patch removes the zwap RB tree.
> > >
> > > The breakdown looks like something that would be a development step,
> > > but for patch submission I think it makes more sense to have a single
> > > patch replacing the rbtree with an xarray.
> >
> > I think it makes the review easier. The code adding and removing does
> > not have much overlap. Combining it to a single patch does not save
> > patch size. Having the assert check would be useful for some bisecting
> > to narrow down which step causing the problem. I am fine with squash
> > it to one patch as well.
>
> I had thought similar when I replaced the rbtree with the maple tree in
> the VMA space.  That conversion was more involved and I wanted to detect
> if there was ever any difference, and where I had made the error in the
> multiple patch conversion.
>
> This became rather painful once an issue was found, as then anyone
> bisecting other issues could hit this difference and either blamed the
> commit pointing at the BUG_ON() or gave up (I don't blame them for
> giving up, I would).  With only two commits, it may be easier for people
> to see a fixed tag pointing to the same commit that bisect found (if
> they check), but it proved an issue with my multiple patch conversion.

Thanks for sharing your experience. That debug assert did help me
catch issues on my own internal version after rebasing to the latest
mm tree. If the user can't do the bisect, then I agree we don't need
to assert in the official version. I can always bisect on my one
internal version.

>
> You may not experience this issue with the users of the zswap, but I
> plan to avoid doing this again in the future.  At least a WARN_ON_ONCE()
> and a comment might help?

Sure, I might just merge the two patches. Don't have the BUG_ON() any more.

Chris

