Return-Path: <linux-kernel+bounces-30766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2B583241E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 05:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2079B21EBE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 04:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEEB6FD9;
	Fri, 19 Jan 2024 04:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0/KPej2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFE76FA9
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 04:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705640375; cv=none; b=jxcczuUXnoANa4v4Vb7PQ+YJoU0fNUh+IlJZyAKCPP8AjbKLSFtavUM3oASHbeZIBF2xTVvRacNMlWAZjz0key0iFwrDb6BQj4W5d3HwjmVYazOzQbhPy59nceuloPzwOS7gjCnyl8rx0b+zvnWoz/coctgRgQztsIEnVJbvIyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705640375; c=relaxed/simple;
	bh=QMRW/GDZ69Dk3tSFEFtbM6exZFBFbIOcPv+/SE7fRdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qL67pQAsho4xbbVdl1qWqL11LXod0zb+5PCf88YHph+b4dLpTUMiGvxE/MfAw5ZNgChPKx53nsH5BHbomHV0BRZYLTXLACA2X9mVduZ7ZOTtsFnFyCrahfC4bosecKF3L02oG00P/W/xIBPNS70Tb/SCFj0BsXrobNzVFu1lULE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0/KPej2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44158C4166D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 04:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705640375;
	bh=QMRW/GDZ69Dk3tSFEFtbM6exZFBFbIOcPv+/SE7fRdk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=m0/KPej2gciaTXnyHe8Y096EJFlqFcE7ooKyvT/DZFyvx3t3NWxYbCSbjOgnW633o
	 +ghozYnbM92YZ+RJakuBtKMVvypysHnxDTWhPI+04y89EH451VDTl8FRbW9Uf4iWwr
	 7hQruGZ5CyWgfQVGyhKDajg7B8lAmVh3n/9Zq2nmwuMr6duS4mXLACuNmRka4p1Pve
	 Dp22zhMzL9B/ovfi7w21iLKHGBl8CyuiyIvp7s/XSJHM0DxBFOvEhAyaI1i3CVTHzj
	 PN3YXb9oU0jBhYZ1cx+96QCxWODYiuCBgVjk41rGWektTfoNx8PUtUhJZcRCx00FTD
	 HCCDjGVOjaF9A==
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d71e24845aso2580415ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 20:59:35 -0800 (PST)
X-Gm-Message-State: AOJu0YwSLofLmXKBTS+0KzGUfuPGeT4FQCSj0AQN9COyvriiaNOMBoqo
	DQlLbTq2/VGvEgJgYrK7xFGSCRt/kUZR8osRcrAogXvsTNfODKVZ3rTFMys7lqq1DkYam7ht/Zv
	dnvDM2IOv2PjohdBfnpcu4vB1nKowZLeimKao
X-Google-Smtp-Source: AGHT+IE59Ehiwtv9w0F8WoyDTQJo/ajgCDvqMvRXA+anZ6Mbud/UxneuvzX7irwUTACaN8m7TefFhwmTAn84CgEusQE=
X-Received: by 2002:a17:90a:7848:b0:290:1130:6d05 with SMTP id
 y8-20020a17090a784800b0029011306d05mr1598270pjl.64.1705640374426; Thu, 18 Jan
 2024 20:59:34 -0800 (PST)
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
 <CAF8kJuNPPruLDOEqH-f-w1zw-TSuWkUZsQ43Qe_EtycapXgkbQ@mail.gmail.com> <3a1b124d-4a97-4400-9714-0cceac53bd34@bytedance.com>
In-Reply-To: <3a1b124d-4a97-4400-9714-0cceac53bd34@bytedance.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 18 Jan 2024 20:59:20 -0800
X-Gmail-Original-Message-ID: <CAF8kJuN_3eaJjwLx_hpwN_ahfHa3qT1kN+NQdYd7vokZj458mA@mail.gmail.com>
Message-ID: <CAF8kJuN_3eaJjwLx_hpwN_ahfHa3qT1kN+NQdYd7vokZj458mA@mail.gmail.com>
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

On Wed, Jan 17, 2024 at 11:35=E2=80=AFPM Chengming Zhou
<zhouchengming@bytedance.com> wrote:

> >>>                     mm-stable           zswap-split-tree    zswap-xar=
ray
> >>> real                1m10.442s           1m4.157s            1m9.962s
> >>> user                17m48.232s          17m41.477s          17m45.887=
s
> >>> sys                 8m13.517s           5m2.226s            7m59.305s
> >>>
> >>> Looks like the contention of concurrency is still there, I haven't
> >>> look into the code yet, will review it later.
> >
> > Thanks for the quick test. Interesting to see the sys usage drop for
> > the xarray case even with the spin lock.
> > Not sure if the 13 second saving is statistically significant or not.
> >
> > We might need to have both xarray and split trees for the zswap. It is
> > likely removing the spin lock wouldn't be able to make up the 35%
> > difference. That is just my guess. There is only one way to find out.
>
> Yes, I totally agree with this! IMHO, concurrent zswap_store paths still
> have to contend for the xarray spinlock even though we would have convert=
ed
> the rb-tree to the xarray structure at last. So I think we should have bo=
th.
>
> >
> > BTW, do you have a script I can run to replicate your results?

Hi Chengming,

Thanks for your script.

>
> ```
> #!/bin/bash
>
> testname=3D"build-kernel-tmpfs"
> cgroup=3D"/sys/fs/cgroup/$testname"
>
> tmpdir=3D"/tmp/vm-scalability-tmp"
> workdir=3D"$tmpdir/$testname"
>
> memory_max=3D"$((2 * 1024 * 1024 * 1024))"
>
> linux_src=3D"/root/zcm/linux-6.6.tar.xz"
> NR_TASK=3D32
>
> swapon ~/zcm/swapfile

How big is your swapfile here?

It seems you have only one swapfile there. That can explain the contention.
Have you tried multiple swapfiles for the same test?
That should reduce the contention without using your patch.

Chris

> echo 60 > /proc/sys/vm/swappiness
>
> echo zsmalloc > /sys/module/zswap/parameters/zpool
> echo lz4 > /sys/module/zswap/parameters/compressor
> echo 1 > /sys/module/zswap/parameters/shrinker_enabled
> echo 1 > /sys/module/zswap/parameters/enabled
>
> if ! [ -d $tmpdir ]; then
>         mkdir -p $tmpdir
>         mount -t tmpfs -o size=3D100% nodev $tmpdir
> fi
>
> mkdir -p $cgroup
> echo $memory_max > $cgroup/memory.max
> echo $$ > $cgroup/cgroup.procs
>
> rm -rf $workdir
> mkdir -p $workdir
> cd $workdir
>
> tar xvf $linux_src
> cd linux-6.6
> make -j$NR_TASK clean
> make defconfig
> time make -j$NR_TASK
> ```
>
>

