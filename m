Return-Path: <linux-kernel+bounces-31123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F217D832951
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33640B2132A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55FC4F1F1;
	Fri, 19 Jan 2024 11:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZzl1VTL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EAA4F1E8
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 11:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705665560; cv=none; b=l5LK4ix7M932j3Xb83VBisl/TZpWxF1QK9N+Tvbd60x9w0EJy2+sLO1bXMwIO6/IKn07i1oJI0b29PgsbqRc8sD23uqPk0tpevP5aUCoBn7H172SmtzK3ACmYWsrxzIUfmcEZ87YiZ+Fh+258GrFr3++jgfU/sHTEP83xNVYlYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705665560; c=relaxed/simple;
	bh=bAHJx0yhKKnHDIkSyj/+7VryXHJi2XP5zcuoP570mEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RxD6zHQM9T/IjM5P3EmmK5gcgoncRGa7vMoIEoiS8LskntRVJwfq1Ob0de8tP+4SaHh+w7w6+Xhv3YlH5bq9ZoZWezIW3+wP0jGWT3Gkx9MzVcEAFYsTMaHBN9UqA95jpK/YwtGBwaw1h93PtLY0gAON7AYU6E42uOHesJIVPgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZzl1VTL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C5FC43330
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 11:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705665559;
	bh=bAHJx0yhKKnHDIkSyj/+7VryXHJi2XP5zcuoP570mEY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CZzl1VTLUCN9HS8jI9iqNBiYprEBRawsVnx/4AwG/RmrD3jCa1ZFtbEbu6RjLtJpu
	 +h2590qAnFM/u7S00mh6ErcEjpR72sNqKtMh/CIuBgC0Wvc6FE1egjztbt8UCNTtUn
	 bWZdK7xxwXX/pGUImXbuDayuYGR4yn1WUedv+GIwtvEFRJ5We19mSZ2YS8aok0vj7F
	 Ebd8Lx0zivRSsdSGeIq5pmsokkWt8I+lWsNSGvU7ssekTY08sp8EGi0yAG8NZ5Yn93
	 g9Hwnei9dDjkh+86jL+l648GKxh6Igxrr1OHf7Z7JqyLtDS573YYcSF5CvHRo2SjFO
	 WnOj8tkXo9yLQ==
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5cdfbd4e8caso622244a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 03:59:19 -0800 (PST)
X-Gm-Message-State: AOJu0YyQ1NG+A2Zk8WeqPJba0i5+n7Pra0vZlhU9dz1Ld9G3z3IleOvj
	x28hr73GfKszK+9WSfF5eTfOYHO6NeWFJxAdFPGiqe+JbqPWZLLb/JPeCYNw49JgF3tjun2aBMy
	Lj0aNwMuANlgERsIqKwtZWvzzTht1ic4tQal/
X-Google-Smtp-Source: AGHT+IG7NvN6OZLP/OU1SyMLwKuBCHH9lQsNNtMIExy1C2cP6UjvhwHkcMYz/IAyChNd0xRlcqbqPThF9Dlkj/h0rdI=
X-Received: by 2002:a05:6a21:150b:b0:199:afd6:2338 with SMTP id
 nq11-20020a056a21150b00b00199afd62338mr3022933pzb.43.1705665558914; Fri, 19
 Jan 2024 03:59:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org>
 <CAJD7tkbQb5nAQdhHXELQsUWs8KhwnoOZ7C8Eu2o7tCYSKeY9Ug@mail.gmail.com>
 <CAJD7tkb7GmMARE9ueyOCZz9wBbANhofUOHnen+b28sxE9tDy1A@mail.gmail.com>
 <7f52ad78-e10b-438a-b380-49451bf6f64f@bytedance.com> <CAJD7tkaeBTforGTQ8ia_6-1fd5hf-zwkBcd_kW8Bk=zdO+Qnvw@mail.gmail.com>
 <CAF8kJuNPPruLDOEqH-f-w1zw-TSuWkUZsQ43Qe_EtycapXgkbQ@mail.gmail.com>
 <3a1b124d-4a97-4400-9714-0cceac53bd34@bytedance.com> <CAF8kJuN_3eaJjwLx_hpwN_ahfHa3qT1kN+NQdYd7vokZj458mA@mail.gmail.com>
 <9b2f8385-735b-4341-b521-a42c9a9cb04c@bytedance.com> <CAF8kJuNvxZgMvW+7gN1anpASKXdaPfYi=0pSfmJftHkzXnV-ag@mail.gmail.com>
 <ad007bf8-ab06-4414-8675-e689c5c84fc9@bytedance.com>
In-Reply-To: <ad007bf8-ab06-4414-8675-e689c5c84fc9@bytedance.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 19 Jan 2024 03:59:07 -0800
X-Gmail-Original-Message-ID: <CAF8kJuM4ybP+4_3zssCfV3-Vf9_gE2P7jiOcD9OGgT4JjFC0bg@mail.gmail.com>
Message-ID: <CAF8kJuM4ybP+4_3zssCfV3-Vf9_gE2P7jiOcD9OGgT4JjFC0bg@mail.gmail.com>
Subject: Re: [PATCH 0/2] RFC: zswap tree use xarray instead of RB tree
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	=?UTF-8?B?V2VpIFh177+8?= <weixugc@google.com>, Yu Zhao <yuzhao@google.com>, 
	Greg Thelen <gthelen@google.com>, Chun-Tse Shao <ctshao@google.com>, 
	=?UTF-8?Q?Suren_Baghdasaryan=EF=BF=BC?= <surenb@google.com>, 
	Brain Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mel Gorman <mgorman@techsingularity.net>, Huang Ying <ying.huang@intel.com>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <kasong@tencent.com>, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Barry Song <v-songbaohua@oppo.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 3:12=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> On 2024/1/19 18:26, Chris Li wrote:
> > On Thu, Jan 18, 2024 at 10:19=E2=80=AFPM Chengming Zhou
> > <zhouchengming@bytedance.com> wrote:
> >>
> >> On 2024/1/19 12:59, Chris Li wrote:
> >>> On Wed, Jan 17, 2024 at 11:35=E2=80=AFPM Chengming Zhou
> >>> <zhouchengming@bytedance.com> wrote:
> >>>
> >>>>>>>                     mm-stable           zswap-split-tree    zswap=
-xarray
> >>>>>>> real                1m10.442s           1m4.157s            1m9.9=
62s
> >>>>>>> user                17m48.232s          17m41.477s          17m45=
887s
> >>>>>>> sys                 8m13.517s           5m2.226s            7m59.=
305s
> >>>>>>>
> >>>>>>> Looks like the contention of concurrency is still there, I haven'=
t
> >>>>>>> look into the code yet, will review it later.
> >>>>>
> >>>>> Thanks for the quick test. Interesting to see the sys usage drop fo=
r
> >>>>> the xarray case even with the spin lock.
> >>>>> Not sure if the 13 second saving is statistically significant or no=
t.
> >>>>>
> >>>>> We might need to have both xarray and split trees for the zswap. It=
 is
> >>>>> likely removing the spin lock wouldn't be able to make up the 35%
> >>>>> difference. That is just my guess. There is only one way to find ou=
t.
> >>>>
> >>>> Yes, I totally agree with this! IMHO, concurrent zswap_store paths s=
till
> >>>> have to contend for the xarray spinlock even though we would have co=
nverted
> >>>> the rb-tree to the xarray structure at last. So I think we should ha=
ve both.
> >>>>
> >>>>>
> >>>>> BTW, do you have a script I can run to replicate your results?
> >>>
> >>> Hi Chengming,
> >>>
> >>> Thanks for your script.
> >>>
> >>>>
> >>>> ```
> >>>> #!/bin/bash
> >>>>
> >>>> testname=3D"build-kernel-tmpfs"
> >>>> cgroup=3D"/sys/fs/cgroup/$testname"
> >>>>
> >>>> tmpdir=3D"/tmp/vm-scalability-tmp"
> >>>> workdir=3D"$tmpdir/$testname"
> >>>>
> >>>> memory_max=3D"$((2 * 1024 * 1024 * 1024))"
> >>>>
> >>>> linux_src=3D"/root/zcm/linux-6.6.tar.xz"
> >>>> NR_TASK=3D32
> >>>>
> >>>> swapon ~/zcm/swapfile
> >>>
> >>> How big is your swapfile here?
> >>
> >> The swapfile is big enough here, I use a 50GB swapfile.
> >
> > Thanks,
> >
> >>
> >>>
> >>> It seems you have only one swapfile there. That can explain the conte=
ntion.
> >>> Have you tried multiple swapfiles for the same test?
> >>> That should reduce the contention without using your patch.
> >> Do you mean to have many 64MB swapfiles to swapon at the same time?
> >
> > 64MB is too small. There are limits to MAX_SWAPFILES. It is less than
> > (32 - n) swap files.
> > If you want to use 50G swap space, you can have MAX_SWAPFILES, each
> > swapfile 50GB / MAX_SWAPFILES.
>
> Right.
>
> >
> >> Maybe it's feasible to test,
> >
> > Of course it is testable, I am curious to see the test results.
> >
> >> I'm not sure how swapout will choose.
> >
> > It will rotate through the same priority swap files first.
> > swapfile.c: get_swap_pages().
> >
> >> But in our usecase, we normally have only one swapfile.
> >
> > Is there a good reason why you can't use more than one swapfile?
>
> I think no, but it seems an unneeded change/burden to our admin.
> So I just tested and optimized for the normal case.

I understand. Just saying it is not really a kernel limitation per say.
I blame the user space :-)

>
> > One swapfile will not take the full advantage of the existing code.
> > Even if you split the zswap trees within a swapfile. With only one
> > swapfile, you will still be having lock contention on "(struct
> > swap_info_struct).lock".
> > It is one lock per swapfile.
> > Using more than one swap file should get you better results.
>
> IIUC, we already have the per-cpu swap entry cache to not contend for
> this lock? And I don't see much hot of this lock in the testing.

Yes. The swap entry cache helps. The cache batching also causes other
problems, e.g. the long tail in swap faults handling.
Shameless plug, I have a patch posted earlier to address the swap
fault long tail latencies.

https://lore.kernel.org/linux-mm/20231221-async-free-v1-1-94b277992cb0@kern=
el.org/T/

Chris

