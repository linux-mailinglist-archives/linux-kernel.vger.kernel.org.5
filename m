Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0E380FB5D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 00:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjLLX1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 18:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjLLX1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 18:27:13 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442F19A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:27:19 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-550dd0e3304so5223988a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702423638; x=1703028438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKLkSlT6twZSU8NwNcfFicELi2XwtFQzSyMdx7RHtng=;
        b=XVvD4tYmRygs90Fc8wbizaMrsqvdeyNOOLqBvE59kzDxsnznBap+pg57RKOILrXjXx
         NFe675D74ZBD3EafUeZY92c9dufaK9BU/mwBovgIfnPIEueDTefW8OuaC47tN9kpFUbB
         cYatjDSSZ1Mca4mpGPEot1r9BRltjnD5YSRoMy301YJ54TvJFxSeaFbzGOuA3pRzegaK
         b8po0f8iQSAsoaBrwwUJ9H+ajRftDBvTD45DhRghUWOuVwgtVVNAh0NETScWEQi6SNA5
         46f/JWDdXLZf6sBwN+qgNhLF67ZHoybTqEVbwJTNNR70w7O7sml1mZE6PcSkvpR8CjH/
         0tvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702423638; x=1703028438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKLkSlT6twZSU8NwNcfFicELi2XwtFQzSyMdx7RHtng=;
        b=rBr3ff53JUgNZ1Yow+c2USKotxp9l8lREjQUiZT5slgK1JiZyC6ox4J6EjQA9kv5yJ
         qgUX1SlqfuxGVivscH/w5N92AzfL+dKwAlS7tfrKokqo/5UVbjuviKHOd1kwPWjJJO1L
         dgUV3iNN1D5779bJn5XvwmmyVcYI/qOTgMCRrYpRcyB3Vt6jyaoOVeLxPQhr+wA6cLuW
         AREfT9/X3t/3E4ohXFb+X5flEDG4ftczBBwJ6uVuZYu4TmOIUGEKxDy+89Ul/3J9ubDe
         ouyCHW7dC05a6v/Rqr55CGrVvpP05r6kVHB/B1V5Ewk2fuAdecisJqd3aXwnnphLGjn4
         PuTg==
X-Gm-Message-State: AOJu0YzarPEhFpGcR690tcaPCcUqgKQ9sSZNG+mdMYR44/OGOu0ubsY7
        bWag/QJDLW+wz0G8AV/i3N/i/TRmGQRhxBrSW39voA==
X-Google-Smtp-Source: AGHT+IEcLfbyN3sALFXpOV8inmfq4U78bPkK4T1KZHCYHRdFLvvsTNXJwOIypWMEDP7cNFZj1hDYFe6LyYq/hjCEulI=
X-Received: by 2002:a17:906:7c44:b0:a19:a19b:78cc with SMTP id
 g4-20020a1709067c4400b00a19a19b78ccmr3383860ejp.143.1702423637584; Tue, 12
 Dec 2023 15:27:17 -0800 (PST)
MIME-Version: 1.0
References: <20231206-zswap-lock-optimize-v1-0-e25b059f9c3a@bytedance.com>
 <CAKEwX=NXcY3_GuKbh0=Ceg9wj=7u4y0NgmfSVEG3-+deY0jiWQ@mail.gmail.com>
 <CAJD7tkbErWz7Rjn-JdY8LjSW=GzEyyrNeJ5P1ipChFSufmQmLQ@mail.gmail.com>
 <CAF8kJuMegmMD3+YZfvsW3h1y1z1-kH7SiyJHPVnrSc89OZASuA@mail.gmail.com> <77d628dc-ab8c-4d8c-bc63-7e4518ea92d7@bytedance.com>
In-Reply-To: <77d628dc-ab8c-4d8c-bc63-7e4518ea92d7@bytedance.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 12 Dec 2023 15:26:41 -0800
Message-ID: <CAJD7tkZCxwDpNm-jQv_ieDvYhrtvMTXXjRp9_dQW3_VqYgUUsw@mail.gmail.com>
Subject: Re: [PATCH 0/7] mm/zswap: optimize the scalability of zswap rb-tree
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     Chris Li <chriscli@google.com>, Nhat Pham <nphamcs@gmail.com>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 6, 2023 at 7:25=E2=80=AFPM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> On 2023/12/7 08:43, Chris Li wrote:
> > Hi Nhat and Yosry,
> >
> > On Wed, Dec 6, 2023 at 12:42=E2=80=AFPM Yosry Ahmed <yosryahmed@google.=
com> wrote:
> >>
> >> On Wed, Dec 6, 2023 at 9:24=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> w=
rote:
> >>>
> >>> + Chris Li
> >>>
> >>> Chris, I vaguely remember from our last conversation that you have
> >>> some concurrent efforts to use xarray here right?
> >
> > Yes, I do have the zswap xarray for older versions of the kernel. The
> > recent mm-unstable tree has  a lot of zswap related updates. Give me 2
> > days to refresh and post it. The zswap invalid entry and the reference
> > count change is causing a good portion of the code to be updated. That
> > is the price to pay keeping out of tree patches. My fault is not
> > getting to it sooner.
> >
> >>
> >> If I recall correctly, the xarray already reduces the lock contention
> >> as lookups are lockless, but Chris knows more here. As you mentioned
> >
> > Yes. To be exact, xarray can use spin lock (same as current RB tree)
> > or take RCU read lock on the lookup path (depending on how you call
> > the xarray API). Not completely lockless but the RCU read lock should
> > have less lock contention than normal spinlock. +Matthew
> >
>
> Great! Lockless lookup in zswap_load() should reduce spinlock contention.
> And multiple trees (multiple xarrays) can further reduce the contention
> on the concurrent zswap_store() side. So it's complementary IMHO.
>
> >> in a different email, it would be nice to get some data so that we can
> >> compare different solutions.
> >
> > Yes, it is certainly welcome to see more data points. If I recall
> > correctly, the zswap xarray array makes the lookup similar to the swap
> > cache lookup. It has a noticeable difference in the long tail end.
> >
>
> Right, I post some data from yesterday in another reply.
> Will test again and update the data since Nhat's zswap shrinker fix patch
> has been merged into mm-unstable today.
>
> Thanks!

Let's split the rbtree breakdown into a separate series. This series
has irrelevant (and very nice) cleanups and optimizations, let's get
them separately and defer the rbtree breakdown part until we get data
about the xarray implementation. Perhaps the tree breakdown is not
needed as much with an xarray, or at the very least the implementation
would look different on top of an xarray.
