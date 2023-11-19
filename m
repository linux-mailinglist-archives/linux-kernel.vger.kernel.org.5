Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7885C7F04CB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 09:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjKSIYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 03:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKSIYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 03:24:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F54A12D
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 00:24:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F96DC43397
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 08:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700382242;
        bh=l6wzEvSiwERrHXBTWg1Y8xIWZNoPbKJW6k4RmsePHHc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gQrg63YffUTH3IPzixKPkxn1LijWTEsdL0kt3J+D1lRKHhGpI224qMp2MBcopLdnH
         18hVOiI3ySgwsiLnypTmMPjDE0q6JDoBYlW2qOtXM9lpsKy0VhoL4JlGbgl6xJlmpB
         wECVCTnl5Faziq269KLxq1rRh8ad6vVUqc4ytzEWkSzRxYK6W9HkEJBKV0l3g4DPP4
         LCbm2LX/4CLQD731kshiW4zaKF2dFqmiMg3R3mZ3jecmznCBmfzxnAfeiKy/qVLkBV
         hW/Ur1kRmX1tbrUuFgU2tuhrwrBB8cFRKNIBuQYYPX2H1UAklw5mo7t4X/IzWEKEyj
         rxCPD2TJlKyGA==
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso2660837a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 00:24:02 -0800 (PST)
X-Gm-Message-State: AOJu0YwRaQbp7BP+neEY6jEuxILOjCHKR9WNxMkJGr/VCYRdftNkK6Nt
        vgyBxKG8wZNGC1KhO7kQK0lYZ5ywin/QyLbHZDrS4w==
X-Google-Smtp-Source: AGHT+IGq5epHlKgVGzYBJFJhGgxXWkX5xrLPlsa/8skI5/7ci/sln4q/j6E4vw30ymyKePS5CNSm7iYOrnTMN1f6guc=
X-Received: by 2002:a17:90b:1e02:b0:27d:7887:ddc5 with SMTP id
 pg2-20020a17090b1e0200b0027d7887ddc5mr4927636pjb.32.1700382241288; Sun, 19
 Nov 2023 00:24:01 -0800 (PST)
MIME-Version: 1.0
References: <20231113130601.3350915-1-hezhongkun.hzk@bytedance.com>
 <CAJD7tkY8SwROmNEaBAhkS4OKj33g-6fHsKFeYKW3afT+yAbvxA@mail.gmail.com>
 <CAF8kJuPonfuOtipdifXwBny2H7cy6m6BL8mWFVXzfb9JSdYq3Q@mail.gmail.com>
 <CAJD7tkYMiJiXTTgAN34TP8QTr-ViAuEFddYes=ac+1ErenjCZw@mail.gmail.com>
 <CAF8kJuOC30feLGs0bNHOxMjSZ3uqF1y7eUdJ4p-w-myP8c1cFg@mail.gmail.com>
 <CACSyD1NJ4ycr74pXHNus3ZjA=LvZP+aMNyz=iWyHuDODpx7aww@mail.gmail.com>
 <CAF8kJuPymUX+DwouwgH6og0BO6ZYheGXsk=GYqYuMjKMz-Xqbw@mail.gmail.com> <CACSyD1P-6mQ7n+ghsZQ0Gp4AxyTTi6=UZHz2DnXWuCWke2fkPw@mail.gmail.com>
In-Reply-To: <CACSyD1P-6mQ7n+ghsZQ0Gp4AxyTTi6=UZHz2DnXWuCWke2fkPw@mail.gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Sun, 19 Nov 2023 00:23:49 -0800
X-Gmail-Original-Message-ID: <CAF8kJuOR+POJx4wT7jbZkoiwGjrjVH4uuJ5GgoWBOf20JUf9qw@mail.gmail.com>
Message-ID: <CAF8kJuOR+POJx4wT7jbZkoiwGjrjVH4uuJ5GgoWBOf20JUf9qw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm:zswap: fix zswap entry reclamation
 failure in two scenarios
To:     Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Ying <ying.huang@intel.com>
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

Hi Zhongkun,


On Fri, Nov 17, 2023 at 5:46=E2=80=AFPM Zhongkun He
<hezhongkun.hzk@bytedance.com> wrote:
> > Can you help me understand how much memory you can free from this
> > patch? For example, are we talking about a few pages or a few GB?
> >
> > Where does the freed memory come from?
> > If the memory comes from zswap entry struct. Due to the slab allocator
> > fragmentation. It would take a lot of zswap entries to have meaningful
> > memory reclaimed from the slab allocator.
> >
> > If the memory comes from the swap cached pages, that would be much
> > more meaningful. But that is not what this patch is doing, right?
> >
> > Chris
>
> It's my bad for putting two cases together. The memory released in both
> cases comes from zswap entry struct and zswap compressed page.

Thanks for the clarification. Keep in mind that memory freeing from
and zswap entry and zpool does not directly translate into page free.
If the page has other none freed zswap entry or zsmalloc usage, those
pages will not be free to the system. That is the fragmentation cost I
was talking about.

With this consideration, do you know many extra pages it can release
back to the system by this patch in your usage case? If the difference
is very small, it might not be worth the extra complexity to release
those.

> The original intention of this patch is to solve the problem that
> shrink_work() fails to reclaim memory in two situations.
>
> For case (1),  the zswap_writeback_entry() will failed for the
> __read_swap_cache_async return NULL because the swap has been
> freed but cached in swap_slots_cache, so the memory come from
> the zswap entry struct and compressed page.
In those cases, if we drop the swap_slots_cache, it will also free
those zswap entries and compressed pages (zpool), right?

> Count =3D SWAP_BATCH * ncpu.

That is the upper limit. Not all CPUs have swap batches fully loaded.

> Solution: move the zswap_invalidate() out of batches, free it once the sw=
ap
> count equal to 0.
Per previous discussion, this will have an impact on the
swap_slot_cache behavior.
We need some data points for cost benefit analysis.

> For case (2),  the zswap_writeback_entry() will failed for !page_was_allo=
cated
> because zswap_load will have two copies of the same page in memory
>   (compressed and uncompressed) after faulting in a page from zswap when
> zswap_exclusive_loads disabled. The amount of memory is greater but depen=
ds
> on the usage.

That is basically disable the future swap out page IO write
optimization that skip the write if the page hasn't changed. If the
system are low on memory, that is justifiable. Again, it seems we can
have a pass to drop the compressed memory if the swap count is zero
(and mark page dirty).

>
> Why do we need  to release them?
> Consider this scenario,there is a lot of data cached in memory and zswap,
> hit the limit=EF=BC=8Cand shrink_worker will fail. The new coming data wi=
ll be written

Yes, the shrink_worker will need to allocate a page to store
uncompressed data for write back.

> directly to swap due to zswap_store failure. Should we free the last one
> to store the latest one in zswap.

The "last one" you mean the most recent zswap entry written into zswap?
Well, you need to allocate a page to write it out, that is an async process=
.
Shrink the zpool now is kind of too late already.

> According to the previous discussion, the writeback is inevitable.
> So I want to make zswap_exclusive_loads_enabled the default behavior
> or make it the only way to do zswap loads. It only makes sense when

We need some data point for how often we swap it out to zswap again,
where the zswap out write can be saved by using the existing compressed dat=
a.

It is totally possible this page IO write out optimization is not
worthwhile for zswap.
We need some data to support that claim.

> the page is read and no longer dirty. If the page is read frequently, it
> should stay in cache rather than zswap. The benefit of doing this is
> very small, i.e. two copies of the same page in memory.

If the benefit of doing this is very small, that seems to be the
argument against this patch?
Again we need some data points for cost and benefit analysis.

Chris
