Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD2E80B1A5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 03:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbjLICDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 21:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjLICDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 21:03:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54342EB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 18:03:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5860C433C9
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 02:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702087386;
        bh=9PeqE8G5f15es8vwnxb8aP1d/82nysKgB4+3G2tHBQ4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gZ52iDK98UPI9WIRd11hNYtRxqoVRQP3Q6k0Zb/cBsTaI8z73hhMOQrtsKMMtSN/k
         RqeXUJziyi3YHCwNXt4btwLGJEVUFNMi/ZVBlJA8oyv4NnChSl+MGEfZPALs+JsjWk
         zXrxNId+YGsAZvshNLlaVJ2PyF7aRVqPX6VjhI4fIf5893+oiOFCFNNDAaAGQIBS2u
         poRv+WnkksmPa1RnSu4RkRe34Cha/1kI3FK3wzK/7xfVVjCBIvPl8mFYWJIiMTC6fO
         xfNRZwVE0y8f6j1GhohvfIEF6JIGv1sgrnM8/3VjvPqpn4a3xm7ycg/VPNfuIVhwe8
         2qsd0eGnSlxhg==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3b9dbbaa9a9so1891997b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 18:03:06 -0800 (PST)
X-Gm-Message-State: AOJu0YzeNDsemtD7tKyID5GhxRhUKu4Z2hv5SnmT67O/btKcdVdeNMTg
        19nfp/XLmDcY+4q+KhssiYKqggLbWMyp8ZWf7qXjjg==
X-Google-Smtp-Source: AGHT+IE5TBF6KTUwljKLninX12nSY4+OBje1txDH4yiTTgQj6FDwsQm0zrIjBlJzGgZdO8gGjmg2Rg2ANRMnHPeGcRs=
X-Received: by 2002:a05:6358:2919:b0:170:982:5611 with SMTP id
 y25-20020a056358291900b0017009825611mr1292126rwb.32.1702087365627; Fri, 08
 Dec 2023 18:02:45 -0800 (PST)
MIME-Version: 1.0
References: <20231207192406.3809579-1-nphamcs@gmail.com> <CAF8kJuPEKWbr_1a-OzqrYKSPmuty==KhC2vbTPAmm9xcJHo4cg@mail.gmail.com>
 <CAKEwX=Oj0Rur8i9Oo7y2Py7svx-g11sEj3GKQfMVL62x=4hvdA@mail.gmail.com>
 <CAJD7tkaHaji=0sVobJKajc4hOmOui2U+bZK+1DQ6gbAsQgGLRw@mail.gmail.com> <20231208163451.GA880930@cmpxchg.org>
In-Reply-To: <20231208163451.GA880930@cmpxchg.org>
From:   Chris Li <chrisl@kernel.org>
Date:   Fri, 8 Dec 2023 18:02:33 -0800
X-Gmail-Original-Message-ID: <CAF8kJuMKJTb9Aqv8_GbNPuuBoHEuwJCZmYT6Zn8=_X4c58ADTw@mail.gmail.com>
Message-ID: <CAF8kJuMKJTb9Aqv8_GbNPuuBoHEuwJCZmYT6Zn8=_X4c58ADTw@mail.gmail.com>
Subject: Re: [PATCH v6] zswap: memcontrol: implement zswap writeback disabling
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
        akpm@linux-foundation.org, tj@kernel.org, lizefan.x@bytedance.com,
        cerasuolodomenico@gmail.com, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, hughd@google.com, corbet@lwn.net,
        konrad.wilk@oracle.com, senozhatsky@chromium.org, rppt@kernel.org,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        david@ixit.cz, Minchan Kim <minchan@google.com>,
        Kairui Song <kasong@tencent.com>,
        Zhongkun He <hezhongkun.hzk@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,

On Fri, Dec 8, 2023 at 8:35=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> On Thu, Dec 07, 2023 at 05:12:13PM -0800, Yosry Ahmed wrote:
> > On Thu, Dec 7, 2023 at 5:03=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wr=
ote:
> > > On Thu, Dec 7, 2023 at 4:19=E2=80=AFPM Chris Li <chrisl@kernel.org> w=
rote:
> > > > I am wondering about the status of "memory.swap.tiers" proof of con=
cept patch?
> > > > Are we still on board to have this two patch merge together somehow=
 so
> > > > we can have
> > > > "memory.swap.tiers" =3D=3D "all" and "memory.swap.tiers" =3D=3D "zs=
wap" cover the
> > > > memory.zswap.writeback =3D=3D 1 and memory.zswap.writeback =3D=3D 0=
 case?
> > > >
> > > > Thanks
> > > >
> > > > Chris
> > > >
> > >
> > > Hi Chris,
> > >
> > > I briefly summarized my recent discussion with Johannes here:
> > >
> > > https://lore.kernel.org/all/CAKEwX=3DNwGGRAtXoNPfq63YnNLBCF0ZDOdLVRsv=
zUmYhK4jxzHA@mail.gmail.com/
> > >
> > > TL;DR is we acknowledge the potential usefulness of swap.tiers
> > > interface, but the use case is not quite there yet, so it does not
> > > make too much sense to build up that heavy machinery now.
> > > zswap.writeback is a more urgent need, and does not prevent swap.tier=
s
> > > if we do decide to implement it.
> >
> > I am honestly not convinced by this. There is no heavy machinery here.
> > The interface is more generic and extensible, but the implementation
> > is roughly the same. Unless we have a reason to think a swap.tiers
> > interface may make it difficult to extend this later or will not
> > support some use cases, I think we should go ahead with it. If we are
> > worried that "tiers" may not accurately describe future use cases, we
> > can be more generic and call it swap.types or something.
>
> I have to disagree. The generic swap types or tiers ideas actually
> look pretty far-fetched to me, and there is a lack of convincing
> explanation for why this is even a probable direction for swap.

It boils down to there being more than just "zswap + SSD" usage cases
in other parts of the Linux communities.
The need is real and it is just a question of  how to get there.

>
> For example,
>
> 1. What are the other backends? Where you seem to see a multitude of
>    backends and arbitrary hierarchies of them, I see compression and
>    flash, and really not much else. And there is only one reasonable
>    direction in which to combine those two.

I list a few other usage cases here in an earlier email of the same thread.
https://lore.kernel.org/linux-mm/CAF8kJuNpnqTM5x1QmQ7h-FaRWVnHBdNGvGvB3txoh=
SOmZhYA-Q@mail.gmail.com/T/#t
TL;DR:
1) Google has had an internal memory.swapfile in production for almost 10 y=
ears.
2) Tencent uses hard drives as SSD swap overflow. +Kairui.
https://lore.kernel.org/linux-mm/20231119194740.94101-9-ryncsn@gmail.com/
3) Android has more fancy swap usage. +Kimchan
https://lore.kernel.org/linux-mm/20230710221659.2473460-1-minchan@kernel.or=
g/

You can't imagine such an usage is not the reason to block others for
such usage. Please respect other usage cases as well.

As for the other backends, the first minimal milestone we can
implement is "all" and "zswap", which is functional equivalent to the
memory.zswap.writeback.
Other common back ends there are SSD and hard drive. The exact
keywords and tiers are up for future discussion. I just want to
acknowledge the need is there.

>
>    The IOPs and latencies of HDDs and network compared to modern
>    memory sizes and compute speeds make them for the most part
>    impractical as paging backends.

I don't see that being a problem as lower tiers for very cold swaps.
Again, it might not be a usage case for Meta but please respect the
usage case for others.

>
>    So I don't see a common third swap backend, let alone a fourth or a
>    fifth, or a multitude of meaningful ways of combining them...

Does not stop others from wanting to use them.

>
> 2. Even if the usecases were there, enabling this would be a ton of
>    work and open interface questions:

If we can agree this interface is more flexible and covers more usage
cases than "zswap.writeback". We can start from the minimal
implementation of "zswap" and "all".
There is not a ton of work in the first minimal milestone. I send out
the minimal patch here:
https://lore.kernel.org/linux-mm/ZVrHXJLxvs4_CUxc@google.com/

>
>   1) There is no generic code to transfer pages between arbitrary
>      backends.

True, but it does not have to be there to make "swap.tiers" useful. It
can start without a transfer page between backends. It is just a more
flexible way to specify what swap the cgroup wants to opt in
initially, that is a solid need. Everything else can be done later.

>
>   2) There is no accepted indirection model where a swap pte can refer
>      to backends dynamically, in a way that makes migration feasible
>      at scale.

Same as above.

>
>   3) Arbitrary global strings are somewhat unlikely to be accepted as
>      a way to configure these hierarchies.

It does not need to be an arbitrary string. We have a string to config
cgroup.subtree_control for example. I am not saying just borrow the
subtree control syntax. But we can do some thing similar to that.

>
>   4) Backend file paths in a global sysfs file don't work well with
>      namespacing. The swapfile could be in a container
>      namespace. Containers are not guaranteed to see /sys.

Can you clarify what usage problem you are trying to solve? The
containers are typically managed by the container manager's service.
The service sees /sys for sure. Do you want a cgroup interface to
allow the container usage to self-service the swap file?

>
>   5) Fixed keywords like "zswap" might not be good enough - what about
>      compression and backend parameters?

I think those levels of detail are zswap/zpool specific, it belongs to
the /sys/kernel/mm/zswap/foo_bar for example.
We can discuss the detail usage, nothing is set in stone yet.

>
> None of these are insurmountable. My point is that this would be a
> huge amount of prerequisite code and effort for what seems would be a
> fringe usecase at best right now.

For the fringe usage a minimal patch exists. Not a huge amount of
requireste code.
What you describe are close to the end goal of the swap tiers. I

>
> And there could be a lot of curve balls in both the software design as
> well as the hardware development between now and then that could make
> your proposals moot. Is a per-cgroup string file really going to be
> the right way to configure arbitrary hierarchies if they materialize?
>
> This strikes me as premature and speculative, for what could be, some
> day.

"swap.tiers" in my mind is strictly better than "zswap.writeback"
because writeback has only 0 or 1 value. It is not able to describe
other swap selections. Setting zswap.writeback =3D 0 will disable SSD
swap as well, that is not very intuitive. If we want SSD only swap, we
need to set "zswap.writeback" =3D 1 and "zswap.max" =3D 0. All this makes
me feel that we are limiting ourselves too much from the cubical of
zswap to look at the rest of the world.

>
> We don't even do it for *internal API*. There is a review rule to
> introduce a function in the same patch as its first caller, to make
> sure it's the right abstraction and a good fit for the usecase. There
> is no way we can have a lower bar than that for permanent ABI.
>
> The patch here integrates with what zswap is NOW and always has been:
> a compressing writeback cache for swap.
>
> Should multiple swap tiers overcome all the above and actually become
> real, this knob here would be the least of our worries. It would be
> easy to just ignore, automatically override, or deprecate.
>
> So I don't think you made a reasonable proposal for an alternative, or
> gave convincing reasons to hold off this one.
>
Keep in mind that the minimal patch is just trying to avoid the detour
of introducing the zswap.writeback and obsolete it soon. There is a
solid need for swap backend other than zswap. Frankly speaking I don't
see writing "all" to "swap.tiers" is that big a deal different than
writing "1" to "zswap.writeback". From the API point of view, one is
more flexible and future proof.

I just don't want "zswap.writeback" to become something carved into
stone and we cant' remove it later, especially if we can have the
alternative API compatible with other usage cases.

Chris
