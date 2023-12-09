Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4BF80B5AF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 18:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjLIRjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 12:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjLIRjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 12:39:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745EE10D9
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 09:39:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D189C433C8
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 17:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702143588;
        bh=xKzWwx8AEAI3xHb0oQk6tJFeNt9OEdWGkDXgMdD6/UQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Vj1zwv1MMe/wNFdh5eB83smfqpwBZ/b5tBCaw8gt/putIO+ftBZrPyeaKYG2JUnVJ
         vJrKJtQRO2ZVArMCueGbuogAdvvqp4lV376KTeY7x8a5Y+EYjY73oeZxesulfKJhXu
         ecylj4hbS/ALEEEQLtgp+tuLUU3j7pfIIBZD81aiMilZn3wBbnQwt5JplhF1pXNTuh
         Bgrza9AxojpgwDg/il/JIFqWk305ynnJWR0omFxpKClczwyF4k05XAKW1y10XGS0qx
         arC24CK2jhfsZzzhVp+qf+DOMlTul4QNlFARg2SpjCQUwOX+6nxwXvP5R4L0aflM/M
         KL84Ql0oYoWcQ==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-59064bca27dso1738379eaf.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 09:39:48 -0800 (PST)
X-Gm-Message-State: AOJu0Yzj4gAkBLNLoCWO16DY9NnY3Vv2hb43RBGqTAKlfxcrbtJjk4Ai
        FgYi+w5pYm8KgpXlG34aA2iu7UTeB7/6kdLAedrFbw==
X-Google-Smtp-Source: AGHT+IGzBwcsqjZG2OFoaatNrjMe2TS0HqjNPUkvBb9KPQ7VLDYVX6Ykag92K8l6Dqop9f9TA3sc1N9q3AjrLqGY+N8=
X-Received: by 2002:a17:902:704c:b0:1d0:b196:7193 with SMTP id
 h12-20020a170902704c00b001d0b1967193mr1834760plt.126.1702143566610; Sat, 09
 Dec 2023 09:39:26 -0800 (PST)
MIME-Version: 1.0
References: <20231207192406.3809579-1-nphamcs@gmail.com> <CAF8kJuPEKWbr_1a-OzqrYKSPmuty==KhC2vbTPAmm9xcJHo4cg@mail.gmail.com>
 <CAKEwX=Oj0Rur8i9Oo7y2Py7svx-g11sEj3GKQfMVL62x=4hvdA@mail.gmail.com>
 <CAF8kJuNpnqTM5x1QmQ7h-FaRWVnHBdNGvGvB3txohSOmZhYA-Q@mail.gmail.com> <20231209034229.GA1001962@cmpxchg.org>
In-Reply-To: <20231209034229.GA1001962@cmpxchg.org>
From:   Chris Li <chrisl@kernel.org>
Date:   Sat, 9 Dec 2023 09:39:14 -0800
X-Gmail-Original-Message-ID: <CAF8kJuMgbN58Dgkyz2vSNUxk_WKM=arcc0VtGM83ALgDaBXhag@mail.gmail.com>
Message-ID: <CAF8kJuMgbN58Dgkyz2vSNUxk_WKM=arcc0VtGM83ALgDaBXhag@mail.gmail.com>
Subject: Re: [PATCH v6] zswap: memcontrol: implement zswap writeback disabling
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        tj@kernel.org, lizefan.x@bytedance.com,
        cerasuolodomenico@gmail.com, yosryahmed@google.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, hughd@google.com, corbet@lwn.net,
        konrad.wilk@oracle.com, senozhatsky@chromium.org, rppt@kernel.org,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        david@ixit.cz, Kairui Song <kasong@tencent.com>,
        Minchan Kim <minchan@google.com>,
        Zhongkun He <hezhongkun.hzk@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 8, 2023 at 7:42=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> On Fri, Dec 08, 2023 at 03:55:59PM -0800, Chris Li wrote:
> > I can give you three usage cases right now:
> > 1) Google producting kernel uses SSD only swap, it is currently on
> > pilot. This is not expressible by the memory.zswap.writeback. You can
> > set the memory.zswap.max =3D 0 and memory.zswap.writeback =3D 1, then S=
SD
> > backed swapfile. But the whole thing feels very clunky, especially
> > what you really want is SSD only swap, you need to do all this zswap
> > config dance. Google has an internal memory.swapfile feature
> > implemented per cgroup swap file type by "zswap only", "real swap file
> > only", "both", "none" (the exact keyword might be different). running
> > in the production for almost 10 years. The need for more than zswap
> > type of per cgroup control is really there.
>
> We use regular swap on SSD without zswap just fine. Of course it's
> expressible.
>
> On dedicated systems, zswap is disabled in sysfs. On shared hosts
> where it's determined based on which workload is scheduled, zswap is
> generally enabled through sysfs, and individual cgroup access is
> controlled via memory.zswap.max - which is what this knob is for.

The sysfs API is not per cgroup, right?

>
> This is analogous to enabling swap globally, and then opting
> individual cgroups in and out with memory.swap.max.

That is good to know. Just comparing notes. Google is still using
cgroup V1. There is a seperate per cgroup zswap switch control
enabling zswap or not. As well as a swap file type switch to select
ghost swap file or real swap file.

> So this usecase is very much already supported, and it's expressed in
> a way that's pretty natural for how cgroups express access and lack of
> access to certain resources.
>
> I don't see how memory.swap.type or memory.swap.tiers would improve
> this in any way. On the contrary, it would overlap and conflict with
> existing controls to manage swap and zswap on a per-cgroup basis.

One minor point is that, if we have a per cgroup list of swap
tires/devices. It does not need to enter the zswap code to find out
zswap is disabled. But that is a very minor point.

>
> > 2) As indicated by this discussion, Tencent has a usage case for SSD
> > and hard disk swap as overflow.
> > https://lore.kernel.org/linux-mm/20231119194740.94101-9-ryncsn@gmail.co=
m/
> > +Kairui
>
> Multiple swap devices for round robin or with different priorities
> aren't new, they have been supported for a very, very long time. So
> far nobody has proposed to control the exact behavior on a per-cgroup
> basis, and I didn't see anybody in this thread asking for it either.
>
> So I don't see how this counts as an obvious and automatic usecase for
> memory.swap.tiers.

I assume Tencent would want to use per cgroup control but you have a
point it is not automatic. It would be best to have Kairui clarify
whether Tencent wants to use per cgroup SSD vs Hard Disk swap file
control.

>
> > 3) Android has some fancy swap ideas led by those patches.
> > https://lore.kernel.org/linux-mm/20230710221659.2473460-1-minchan@kerne=
l.org/
> > It got shot down due to removal of frontswap. But the usage case and
> > product requirement is there.
> > +Minchan
>
> This looks like an optimization for zram to bypass the block layer and
> hook directly into the swap code. Correct me if I'm wrong, but this
> doesn't appear to have anything to do with per-cgroup backend control.

No in that series. No.

>
> > > zswap.writeback is a more urgent need, and does not prevent swap.tier=
s
> > > if we do decide to implement it.
> >
> > I respect that urgent need, that is why I Ack on the V5 path, under
> > the understanding that this zswap.writeback is not carved into stones.
> > When a better interface comes alone, that interface can be obsolete.
> > Frankly speaking I would much prefer not introducing the cgroup API
> > which will be obsolete soon.
> >
> > If you think zswap.writeback is not removable when another better
> > alternative is available, please voice it now.
> >
> > If you squash my minimal memory.swap.tiers patch, it will also address
> > your urgent need for merging the "zswap.writeback", no?
>
> We can always deprecate ABI if something better comes along.

Thanks for the confirmation. That is what I want to hear from you:
memory.zswap.writeback is not set to stones if something better comes
along.

>
> However, it's quite bold to claim that memory.swap.tiers is the best
> way to implement backend control on a per-cgroup basis, and that it'll
> definitely be needed in the future. You might see this as a foregone
> conclusion, but I very much doubt this.

Ack.

>
> Even if such a file were to show up, I'm not convinced it should even
> include zswap as one of the tiers. Zswap isn't a regular swap backend,
> it doesn't show up in /proc/swaps, it can't be a second tier, the way
> it interacts with its backend file is very different than how two
> swapfiles of different priorities interact with each other, it's
> already controllable with memory.zswap.max, etc.

The rationale to separate out the swap tiers is not based on the
device, rather depends on the swapin latency distribution and access
pattern etc. In that regard, the memory based zswap has much lower
swap in latency, and should be considered a separate tier/class as
SSD. Even though current zswap allocates swap slots from SSD or ghost
swap file, I don't consider it an issue to list zswap as a separate
tier/class. The end of day this is tight to the SLO of the expected
swapping performance.

>
> I'm open to discussing usecases and proposals for more fine-grained
> per-cgroup backend control. We've had discussions about per-cgroup
> swapfiles in the past. Cgroup parameters for swapon are another
> thought. There are several options and many considerations. The
> memory.swap.tiers idea is the newest, has probably had the least
> amount of discussion among them, and looks the least convincing to me.
>
> Let's work out the requirements first.

I agree with that.  Let's lay out the requirements differently and
have open discussion to cover each other's usage case.

> The "conflict" with memory.zswap.writeback is a red herring - it's no
> more of a conflict than setting memory.swap.tiers to "zswap" or "all"
> and then setting memory.zswap.max or memory.swap.max to 0.

I am not sure I fully understand your point here. Can you elerate?
I am thinking memory.zswap.writeback and memory.swap.tiers both try to
describe the relationship of what set of swap tiers the cgroup can
select. "swap.teris" can specify what order.
The setting memory.zswap.max or memory.swap.max to 0 is just disable
zswap/swap. It does not specify the ordering. I am not sure what is
the "conflict" you are referring to.

>
> So the notion that we have to rush in a minimal version of a MUCH
> bigger concept, just to support zswap writeback disabling is
> misguided. And then hope that this format works as the concept evolves
> and real usecases materialize... There is no reason to take that risk.
>

I am convinced memory.swap.tiers is more general and more straight
forward to reason about.  You obviously need more convincing. Which is
fair that I haven't got much more than the minimal patch. As long as
it is not carved into stones and better things can be developed, I am
fine with that.

Chris
