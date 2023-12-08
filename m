Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47B580B0BB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 00:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbjLHX42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 18:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLHX40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 18:56:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84AE1723
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 15:56:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45101C433C7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 23:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702079792;
        bh=peCMXDo9eaMOOydZ/8L8pLC6/eRpJHpJZfXn1ST7dfg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hj3PU0v9aOgdl1M+5LrdlvjEIv0aHOALa5VsbLO2gpBPFsTBAkbjGBij+QuCNlyh6
         B1xrzSU1DT24SfGrcjFly7a4KIYhwfbOChnqZDDC5pdRmc9+4dJV06u39OHqmwL2cm
         5mqAbsRRXWKu1ThcfooNuYa/5GAHsrI4KApagQWgmnHbhHx+d0mriSM39KZBhuvdd/
         LebmirYNPbNLgtiSycbxc7Sgr42B6cENzERQ1rSgK1J1sbrl7nqiXe6CyyU7dnJ2Ac
         nrmM0vFhg6c85QFv0pliX7DYK8MPCEC0VBB4Uvn3YfII6vww7Xl8+bll3Z8AxzvY11
         87l5pAcVEV1LA==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3b9e6262fccso1116043b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 15:56:32 -0800 (PST)
X-Gm-Message-State: AOJu0YxJKk6nXgMUp3sM7gnhQlGnoXPqg5nrbJg5zoGna86fyjRYYvJq
        4Gh81snGz2x/oOIuGmk7UkHxCl/bHjCxHyQkTyJQlg==
X-Google-Smtp-Source: AGHT+IEdLUYuKILjBCDjMVvEgOABV9Uw5O0Cd4zdfhOQrwVlaEm7GUKQ5yvBboqDgaGFYG7tW1+n9bdx2pTjYygIYy8=
X-Received: by 2002:a05:6a21:2715:b0:18f:97c:9789 with SMTP id
 rm21-20020a056a21271500b0018f097c9789mr846669pzb.113.1702079771090; Fri, 08
 Dec 2023 15:56:11 -0800 (PST)
MIME-Version: 1.0
References: <20231207192406.3809579-1-nphamcs@gmail.com> <CAF8kJuPEKWbr_1a-OzqrYKSPmuty==KhC2vbTPAmm9xcJHo4cg@mail.gmail.com>
 <CAKEwX=Oj0Rur8i9Oo7y2Py7svx-g11sEj3GKQfMVL62x=4hvdA@mail.gmail.com>
In-Reply-To: <CAKEwX=Oj0Rur8i9Oo7y2Py7svx-g11sEj3GKQfMVL62x=4hvdA@mail.gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Fri, 8 Dec 2023 15:55:59 -0800
X-Gmail-Original-Message-ID: <CAF8kJuNpnqTM5x1QmQ7h-FaRWVnHBdNGvGvB3txohSOmZhYA-Q@mail.gmail.com>
Message-ID: <CAF8kJuNpnqTM5x1QmQ7h-FaRWVnHBdNGvGvB3txohSOmZhYA-Q@mail.gmail.com>
Subject: Re: [PATCH v6] zswap: memcontrol: implement zswap writeback disabling
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, tj@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, hughd@google.com, corbet@lwn.net,
        konrad.wilk@oracle.com, senozhatsky@chromium.org, rppt@kernel.org,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        david@ixit.cz, Kairui Song <kasong@tencent.com>,
        Minchan Kim <minchan@google.com>,
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

Hi Nhat,

On Thu, Dec 7, 2023 at 5:03=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
>
> On Thu, Dec 7, 2023 at 4:19=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote=
:
> >
> > Hi Nhat,
> >
> >
> > On Thu, Dec 7, 2023 at 11:24=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> w=
rote:
> > >
> > > During our experiment with zswap, we sometimes observe swap IOs due t=
o
> > > occasional zswap store failures and writebacks-to-swap. These swappin=
g
> > > IOs prevent many users who cannot tolerate swapping from adopting zsw=
ap
> > > to save memory and improve performance where possible.
> > >
> > > This patch adds the option to disable this behavior entirely: do not
> > > writeback to backing swapping device when a zswap store attempt fail,
> > > and do not write pages in the zswap pool back to the backing swap
> > > device (both when the pool is full, and when the new zswap shrinker i=
s
> > > called).
> > >
> > > This new behavior can be opted-in/out on a per-cgroup basis via a new
> > > cgroup file. By default, writebacks to swap device is enabled, which =
is
> > > the previous behavior. Initially, writeback is enabled for the root
> > > cgroup, and a newly created cgroup will inherit the current setting o=
f
> > > its parent.
> > >
> > > Note that this is subtly different from setting memory.swap.max to 0,=
 as
> > > it still allows for pages to be stored in the zswap pool (which itsel=
f
> > > consumes swap space in its current form).
> > >
> > > This patch should be applied on top of the zswap shrinker series:
> > >
> > > https://lore.kernel.org/linux-mm/20231130194023.4102148-1-nphamcs@gma=
il.com/
> > >
> > > as it also disables the zswap shrinker, a major source of zswap
> > > writebacks.
> >
> > I am wondering about the status of "memory.swap.tiers" proof of concept=
 patch?
> > Are we still on board to have this two patch merge together somehow so
> > we can have
> > "memory.swap.tiers" =3D=3D "all" and "memory.swap.tiers" =3D=3D "zswap"=
 cover the
> > memory.zswap.writeback =3D=3D 1 and memory.zswap.writeback =3D=3D 0 cas=
e?
> >
> > Thanks
> >
> > Chris
> >
>
> Hi Chris,
>
> I briefly summarized my recent discussion with Johannes here:
>
> https://lore.kernel.org/all/CAKEwX=3DNwGGRAtXoNPfq63YnNLBCF0ZDOdLVRsvzUmY=
hK4jxzHA@mail.gmail.com/

Sorry I am traveling in a different time zone so not able to get to
that email sooner. That email is only sent out less than one day
before the V6 patch right?

>
> TL;DR is we acknowledge the potential usefulness of swap.tiers
> interface, but the use case is not quite there yet, so it does not

I disagree about no use case. No use case for Meta !=3D no usage case
for the rest of the linux kernel community. That mindset really needs
to shift to do Linux kernel development. Respect other's usage cases.
It is not just Meta's Linux kernel. It is everybody's Linux kernel.

I can give you three usage cases right now:
1) Google producting kernel uses SSD only swap, it is currently on
pilot. This is not expressible by the memory.zswap.writeback. You can
set the memory.zswap.max =3D 0 and memory.zswap.writeback =3D 1, then SSD
backed swapfile. But the whole thing feels very clunky, especially
what you really want is SSD only swap, you need to do all this zswap
config dance. Google has an internal memory.swapfile feature
implemented per cgroup swap file type by "zswap only", "real swap file
only", "both", "none" (the exact keyword might be different). running
in the production for almost 10 years. The need for more than zswap
type of per cgroup control is really there.

2) As indicated by this discussion, Tencent has a usage case for SSD
and hard disk swap as overflow.
https://lore.kernel.org/linux-mm/20231119194740.94101-9-ryncsn@gmail.com/
+Kairui

3) Android has some fancy swap ideas led by those patches.
https://lore.kernel.org/linux-mm/20230710221659.2473460-1-minchan@kernel.or=
g/
It got shot down due to removal of frontswap. But the usage case and
product requirement is there.
+Minchan

> make too much sense to build up that heavy machinery now.

Does my minimal memory.swap.tiers patch to support "zswap" and "all"
sound heavy machinery to you?
It is the same implementation under the hood. I am only trying to
avoid introducing something that will be foreseeable obsolete.

> zswap.writeback is a more urgent need, and does not prevent swap.tiers
> if we do decide to implement it.

I respect that urgent need, that is why I Ack on the V5 path, under
the understanding that this zswap.writeback is not carved into stones.
When a better interface comes alone, that interface can be obsolete.
Frankly speaking I would much prefer not introducing the cgroup API
which will be obsolete soon.

If you think zswap.writeback is not removable when another better
alternative is available, please voice it now.

If you squash my minimal memory.swap.tiers patch, it will also address
your urgent need for merging the "zswap.writeback", no?


Chris
