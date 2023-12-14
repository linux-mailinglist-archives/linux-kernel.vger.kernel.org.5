Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56DE81395B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjLNSDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjLNSDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:03:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEC510E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702577027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KV6ZB3o2DsttdivkrpbVEQo8ahsA1p8sk0He110IETY=;
        b=F4/J1NV8Z88pVOp4Fnhk7GLtmwL2Isn2VIiPmao+bgxn0c7/QckUja9TLx++eNUTSPsuwc
        cqsOvM4+Sre7tucS/3y6qu4J7CxJQl6FbZyaHPoper+Okv/S1d4GOM6xVlk/XIToEjETmS
        lmRb74FCRjywaA0p0FXLKGe5qisCawI=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-psXwVSLfO7uzR_aE_zUGjw-1; Thu, 14 Dec 2023 13:03:46 -0500
X-MC-Unique: psXwVSLfO7uzR_aE_zUGjw-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-dbcd44cdca3so2021240276.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:03:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702577026; x=1703181826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KV6ZB3o2DsttdivkrpbVEQo8ahsA1p8sk0He110IETY=;
        b=Ga4Bl2ZYa4GozD3b2iWtq5t+NBm+PSXRqBF8RjwzPSJF3Hcm0lY1aoYrNom5a4u4qn
         yPgznu/p7oEvSxs63nedek/FMaLV72vRPowHyOimj0PD+84kUI1wpyzbeGycyPwzBEGE
         o0errYP1gDRTbEauKHWaV93y3zEZcpiZQ8Gx5eaGVxAdG8/d0CT+rx02hHupw2xhqMLo
         PNoc6P0Ns//jW5OY/LMw/jsc6anwVa/mvDbkt8BpqIVLMWEeE8i6WVpg3Y2sbkCIGSUJ
         PU622cyJEIYM4aTcy0OTOogBz+y+0LtETd7yOxkKKlAZ12d4kslpiVZZbIQtw27Uck71
         x0uQ==
X-Gm-Message-State: AOJu0YzreboQwBYJoktIhCJ04ENY+P1GY+3iIdQW1TUABg7MsVTgO6qf
        0ecZMCklyJCsmaw9ojpFdT4YR/V2oq0RWTVul4+CsjgdYnH0UCyFpiXI6OqnYEfbTHecQwAUiJy
        ykq7OEDP175arFQSw5KrjeNene39ssU6DjvgWCJiU
X-Received: by 2002:a25:8b82:0:b0:da0:7d1e:6e0 with SMTP id j2-20020a258b82000000b00da07d1e06e0mr6217157ybl.20.1702577025475;
        Thu, 14 Dec 2023 10:03:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOtTvkZAGQiIIv+g8QO+ItWnLPDGZBYRujSgmnUfQr/bqu7pkE9KVJpcDeQugMue98gzjpMs0GUsyYEi7yQ54=
X-Received: by 2002:a25:8b82:0:b0:da0:7d1e:6e0 with SMTP id
 j2-20020a258b82000000b00da07d1e06e0mr6217125ybl.20.1702577024965; Thu, 14 Dec
 2023 10:03:44 -0800 (PST)
MIME-Version: 1.0
References: <20231207192406.3809579-1-nphamcs@gmail.com> <CAF8kJuPEKWbr_1a-OzqrYKSPmuty==KhC2vbTPAmm9xcJHo4cg@mail.gmail.com>
 <CAKEwX=Oj0Rur8i9Oo7y2Py7svx-g11sEj3GKQfMVL62x=4hvdA@mail.gmail.com>
 <CAF8kJuNpnqTM5x1QmQ7h-FaRWVnHBdNGvGvB3txohSOmZhYA-Q@mail.gmail.com>
 <20231209034229.GA1001962@cmpxchg.org> <ZXeTb_ACou7TEVsa@google.com>
 <20231214171137.GA261942@cmpxchg.org> <CAOUHufbvafDiURT9qBjKPpRSNwc60S-bDg2yMH_m4bNSWQcV4g@mail.gmail.com>
In-Reply-To: <CAOUHufbvafDiURT9qBjKPpRSNwc60S-bDg2yMH_m4bNSWQcV4g@mail.gmail.com>
From:   Fabian Deutsch <fdeutsch@redhat.com>
Date:   Thu, 14 Dec 2023 19:03:28 +0100
Message-ID: <CA+PVUaRmTDbVE+CP3AQXEzcucRG3mgXSG5Yj-LbCBX=kkZM18g@mail.gmail.com>
Subject: Re: [PATCH v6] zswap: memcontrol: implement zswap writeback disabling
To:     Yu Zhao <yuzhao@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Minchan Kim <minchan@kernel.org>, Chris Li <chrisl@kernel.org>,
        Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        tj@kernel.org, lizefan.x@bytedance.com,
        cerasuolodomenico@gmail.com, yosryahmed@google.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, hughd@google.com, corbet@lwn.net,
        konrad.wilk@oracle.com, senozhatsky@chromium.org, rppt@kernel.org,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        david@ixit.cz, Kairui Song <kasong@tencent.com>,
        Zhongkun He <hezhongkun.hzk@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 6:24=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
>
> On Thu, Dec 14, 2023 at 10:11=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.=
org> wrote:
> >
> > On Mon, Dec 11, 2023 at 02:55:43PM -0800, Minchan Kim wrote:
> > > On Fri, Dec 08, 2023 at 10:42:29PM -0500, Johannes Weiner wrote:
> > > > On Fri, Dec 08, 2023 at 03:55:59PM -0800, Chris Li wrote:
> > > > > I can give you three usage cases right now:
> > > > > 1) Google producting kernel uses SSD only swap, it is currently o=
n
> > > > > pilot. This is not expressible by the memory.zswap.writeback. You=
 can
> > > > > set the memory.zswap.max =3D 0 and memory.zswap.writeback =3D 1, =
then SSD
> > > > > backed swapfile. But the whole thing feels very clunky, especiall=
y
> > > > > what you really want is SSD only swap, you need to do all this zs=
wap
> > > > > config dance. Google has an internal memory.swapfile feature
> > > > > implemented per cgroup swap file type by "zswap only", "real swap=
 file
> > > > > only", "both", "none" (the exact keyword might be different). run=
ning
> > > > > in the production for almost 10 years. The need for more than zsw=
ap
> > > > > type of per cgroup control is really there.
> > > >
> > > > We use regular swap on SSD without zswap just fine. Of course it's
> > > > expressible.
> > > >
> > > > On dedicated systems, zswap is disabled in sysfs. On shared hosts
> > > > where it's determined based on which workload is scheduled, zswap i=
s
> > > > generally enabled through sysfs, and individual cgroup access is
> > > > controlled via memory.zswap.max - which is what this knob is for.
> > > >
> > > > This is analogous to enabling swap globally, and then opting
> > > > individual cgroups in and out with memory.swap.max.
> > > >
> > > > So this usecase is very much already supported, and it's expressed =
in
> > > > a way that's pretty natural for how cgroups express access and lack=
 of
> > > > access to certain resources.
> > > >
> > > > I don't see how memory.swap.type or memory.swap.tiers would improve
> > > > this in any way. On the contrary, it would overlap and conflict wit=
h
> > > > existing controls to manage swap and zswap on a per-cgroup basis.
> > > >
> > > > > 2) As indicated by this discussion, Tencent has a usage case for =
SSD
> > > > > and hard disk swap as overflow.
> > > > > https://lore.kernel.org/linux-mm/20231119194740.94101-9-ryncsn@gm=
ail.com/
> > > > > +Kairui
> > > >
> > > > Multiple swap devices for round robin or with different priorities
> > > > aren't new, they have been supported for a very, very long time. So
> > > > far nobody has proposed to control the exact behavior on a per-cgro=
up
> > > > basis, and I didn't see anybody in this thread asking for it either=
.
> > > >
> > > > So I don't see how this counts as an obvious and automatic usecase =
for
> > > > memory.swap.tiers.
> > > >
> > > > > 3) Android has some fancy swap ideas led by those patches.
> > > > > https://lore.kernel.org/linux-mm/20230710221659.2473460-1-minchan=
@kernel.org/
> > > > > It got shot down due to removal of frontswap. But the usage case =
and
> > > > > product requirement is there.
> > > > > +Minchan
> > > >
> > > > This looks like an optimization for zram to bypass the block layer =
and
> > > > hook directly into the swap code. Correct me if I'm wrong, but this
> > > > doesn't appear to have anything to do with per-cgroup backend contr=
ol.
> > >
> > > Hi Johannes,
> > >
> > > I haven't been following the thread closely, but I noticed the discus=
sion
> > > about potential use cases for zram with memcg.
> > >
> > > One interesting idea I have is to implement a swap controller per cgr=
oup.
> > > This would allow us to tailor the zram swap behavior to the specific =
needs of
> > > different groups.
> > >
> > > For example, Group A, which is sensitive to swap latency, could use z=
ram swap
> > > with a fast compression setting, even if it sacrifices some compressi=
on ratio.
> > > This would prioritize quick access to swapped data, even if it takes =
up more space.
> > >
> > > On the other hand, Group B, which can tolerate higher swap latency, c=
ould benefit
> > > from a slower compression setting that achieves a higher compression =
ratio.
> > > This would maximize memory efficiency at the cost of slightly slower =
data access.
> > >
> > > This approach could provide a more nuanced and flexible way to manage=
 swap usage
> > > within different cgroups.
> >
> > That makes sense to me.
> >
> > It sounds to me like per-cgroup swapfiles would be the easiest
> > solution to this.
>
> Someone posted it about 10 years ago :)
> https://lwn.net/Articles/592923/
>
> +fdeutsch@redhat.com
> Fabian recently asked me about its status.


Thanks Yu!

Yes, I was interested due to container use-cases.

Now a few thoughts in this direction:
- With swap per cgroup you loose the big "statistical" benefit of
having swap on a node level. well, it depends on the size of the
cgroup (i.e. system.slice is quite large).
- With todays node level swap, and setting memory.swap.max=3D0 for all
cgroups allows you toachieve a similar behavior (only opt-in cgroups
will get swap).
- the above approach however will still have a shared swap backend for
all cgroups.

