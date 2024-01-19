Return-Path: <linux-kernel+bounces-31020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F0D8327A3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E86E285376
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868433C697;
	Fri, 19 Jan 2024 10:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBcAWUgT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7A83C489
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 10:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705660029; cv=none; b=ZtpUVvaQHAf9/7Udo0BPeVLdEjSlFNf7E0G3FbhHl2a0tnW1z1/BDmmLuz5wCWuUv0VNJEq8OqtCVu9cd0GlVOmAixFrZGaMrPDGHooBbuRKKgoemdvqpZzavjMjz2aYt1w9nTIUasHxoagxXhd//h/Z1VtqeFq8+POLqhsU9o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705660029; c=relaxed/simple;
	bh=Ki7NeUXLMornTPcFG4xA3JXSwZzus70MOyielb1FkUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eDZwbWxBirAyMthTOwQGtJE5+PgrHtU8HOLLc+WuJKI9vLheZTw6LvWo2e8AztHHnAEzlEY6SYCGg28jl+K++pVHKD9LbnpJ7RLts7sTAZsxhtjVemVWbyulZcUkBxaxP7OVqdZlkSMgS7TtJdZVeWFF7Ky+/P3iwDRB95EyrvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBcAWUgT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C5CC433B2
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 10:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705660029;
	bh=Ki7NeUXLMornTPcFG4xA3JXSwZzus70MOyielb1FkUs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OBcAWUgT0d+lbwdUQsfuemvNJZs5vFYT1Ko+nzaNLIslrklEuLwV8yIYwcAN6Xivc
	 SaxDaR7IpR50ODD0uCrP6iTZ5SQjWf62C1/m6VpFLCszA3YeQnwqGCK/Ucbcbzq0Vp
	 FHqt7UbGehR6AArlIJmdr8zuifkachEnKYd/bj//4ocPCjB6AAnzJAk/wzXj/5WPBk
	 GpZCovDswvlowjyYNhIPaa1ubz15oKGla2OqC+MJ38S1Y7QtSCQc7222tTyvafNrQa
	 +Eoprj6Z8GCeHFuFEFrTzjoPyQVxyN1M418Rp9fw7wzYZKP7xg+Yc8toP3NzU+90ph
	 ilwZrOBPBX4Ig==
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d70696b6faso4283125ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 02:27:09 -0800 (PST)
X-Gm-Message-State: AOJu0YwVwhkL86hWOVSb/eYoqEdkb2exX3FZBPOLimkXVFHOp8AjHbYT
	hJCYt2U9rB6wrAQN/aDRVAPp/B6oYFGsG6pOVpLEu0QT3+hkY/wt51Wu8o97SmPDoW5MRr++SIs
	MWarAjC0EN+qp4hZf/5p2tCqfqCkQoRV2ASnH
X-Google-Smtp-Source: AGHT+IGJiZlI1L89mjAO4tevAnp18+BJd7l2XT6y67LMTciUEqihRK9O8jEq1SfQPviLhBihHqJSzuZpLzgWeb/M4fk=
X-Received: by 2002:a17:90a:728f:b0:290:19bc:2138 with SMTP id
 e15-20020a17090a728f00b0029019bc2138mr1903349pjg.89.1705660028694; Fri, 19
 Jan 2024 02:27:08 -0800 (PST)
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
 <9b2f8385-735b-4341-b521-a42c9a9cb04c@bytedance.com>
In-Reply-To: <9b2f8385-735b-4341-b521-a42c9a9cb04c@bytedance.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 19 Jan 2024 02:26:57 -0800
X-Gmail-Original-Message-ID: <CAF8kJuNvxZgMvW+7gN1anpASKXdaPfYi=0pSfmJftHkzXnV-ag@mail.gmail.com>
Message-ID: <CAF8kJuNvxZgMvW+7gN1anpASKXdaPfYi=0pSfmJftHkzXnV-ag@mail.gmail.com>
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

On Thu, Jan 18, 2024 at 10:19=E2=80=AFPM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> On 2024/1/19 12:59, Chris Li wrote:
> > On Wed, Jan 17, 2024 at 11:35=E2=80=AFPM Chengming Zhou
> > <zhouchengming@bytedance.com> wrote:
> >
> >>>>>                     mm-stable           zswap-split-tree    zswap-x=
array
> >>>>> real                1m10.442s           1m4.157s            1m9.962=
s
> >>>>> user                17m48.232s          17m41.477s          17m45.8=
87s
> >>>>> sys                 8m13.517s           5m2.226s            7m59.30=
5s
> >>>>>
> >>>>> Looks like the contention of concurrency is still there, I haven't
> >>>>> look into the code yet, will review it later.
> >>>
> >>> Thanks for the quick test. Interesting to see the sys usage drop for
> >>> the xarray case even with the spin lock.
> >>> Not sure if the 13 second saving is statistically significant or not.
> >>>
> >>> We might need to have both xarray and split trees for the zswap. It i=
s
> >>> likely removing the spin lock wouldn't be able to make up the 35%
> >>> difference. That is just my guess. There is only one way to find out.
> >>
> >> Yes, I totally agree with this! IMHO, concurrent zswap_store paths sti=
ll
> >> have to contend for the xarray spinlock even though we would have conv=
erted
> >> the rb-tree to the xarray structure at last. So I think we should have=
 both.
> >>
> >>>
> >>> BTW, do you have a script I can run to replicate your results?
> >
> > Hi Chengming,
> >
> > Thanks for your script.
> >
> >>
> >> ```
> >> #!/bin/bash
> >>
> >> testname=3D"build-kernel-tmpfs"
> >> cgroup=3D"/sys/fs/cgroup/$testname"
> >>
> >> tmpdir=3D"/tmp/vm-scalability-tmp"
> >> workdir=3D"$tmpdir/$testname"
> >>
> >> memory_max=3D"$((2 * 1024 * 1024 * 1024))"
> >>
> >> linux_src=3D"/root/zcm/linux-6.6.tar.xz"
> >> NR_TASK=3D32
> >>
> >> swapon ~/zcm/swapfile
> >
> > How big is your swapfile here?
>
> The swapfile is big enough here, I use a 50GB swapfile.

Thanks,

>
> >
> > It seems you have only one swapfile there. That can explain the content=
ion.
> > Have you tried multiple swapfiles for the same test?
> > That should reduce the contention without using your patch.
> Do you mean to have many 64MB swapfiles to swapon at the same time?

64MB is too small. There are limits to MAX_SWAPFILES. It is less than
(32 - n) swap files.
If you want to use 50G swap space, you can have MAX_SWAPFILES, each
swapfile 50GB / MAX_SWAPFILES.

> Maybe it's feasible to test,

Of course it is testable, I am curious to see the test results.

> I'm not sure how swapout will choose.

It will rotate through the same priority swap files first.
swapfile.c: get_swap_pages().

> But in our usecase, we normally have only one swapfile.

Is there a good reason why you can't use more than one swapfile?
One swapfile will not take the full advantage of the existing code.
Even if you split the zswap trees within a swapfile. With only one
swapfile, you will still be having lock contention on "(struct
swap_info_struct).lock".
It is one lock per swapfile.
Using more than one swap file should get you better results.

Chris

