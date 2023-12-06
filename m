Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000898079A7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 21:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379583AbjLFUme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 15:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjLFUma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 15:42:30 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4689D51
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 12:42:35 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40c236624edso2440895e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 12:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701895354; x=1702500154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DY1IC2rhyb/Bn5x0Ih7ThDloh0MTXdgqLcG6ncgKEKc=;
        b=2sgF3aww/XevSIvE4TcFXEpKxbtKjkbuKBD39DMVgRg/3hFj3rq8Dvl+0yYmtWn641
         uCHNISE0k1+kyuhHE8Qas6/kn8NJpAJr1WImxF1eWelKbL2RroYpQg64cZRUzEGVNtT6
         hXj+jBlBpyZSUVRcPUFD8hhTqYNeRHzs14MP7/mDAhA+JlpUnjVEYNMq4gMenG11QJVt
         XBdqID7ALFctyhj0RbruqdWCVqyEC1wzuabrWgOqayOQIfQggkvPJzcFojryNLHWajTR
         7utxyISilT8QB0bkcToP52YGbLZstLszFRIYf8r0rppKpOzoimjHkqd7hgCexKzxq9ba
         hdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701895354; x=1702500154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DY1IC2rhyb/Bn5x0Ih7ThDloh0MTXdgqLcG6ncgKEKc=;
        b=AfwbgbPC0eJtFXHKvj1N5Nw4MV5WHoJjiU0sC99rIdGnL1Nk5wX2SoMMLorD7MVxXD
         Ajpn+HdqIJ32bEGs3BGhv7qHvY7xu0+Tymaa1tMaPYCkRchE1A7CZcFSgkiR1Qm5G0Bm
         NTVARHfjZC3r8B1FaAg1YN9hGqDWb7l92bv8QamWk1DXJSKcGK90+6dAqJlpwef7Zas5
         YE73/+u2XDLe/1t8kFLzWdLSgUydr8OokjT9GtA3t4gDXN0D7OWaiq7BBEzSmguQTzTl
         6grRgLq751SbHXFAJbWd0ne/8T7ARKVcHG2l3H1I0o7DeuUGyxkEvptVTO9gm1C6eJgb
         fMWw==
X-Gm-Message-State: AOJu0YyKopSUkmQWW7GPVZAuevpBLqRWzB/cYWmjmzhNsQc0Q+kvP8kc
        iHeN3++a3j/UtA7dPOVs3vokYHkVscjihaLHUD8wmw==
X-Google-Smtp-Source: AGHT+IHxFajjYl5fbmWvZOaXd0l+GmbiWxkRPg0YrqfXoTyFy1Mdd4gYd2znDMOPPmqC7xLlqwEAjDz+tATZ+x4IvvE=
X-Received: by 2002:a05:600c:4f95:b0:40b:3e66:f5ff with SMTP id
 n21-20020a05600c4f9500b0040b3e66f5ffmr928503wmq.24.1701895354074; Wed, 06 Dec
 2023 12:42:34 -0800 (PST)
MIME-Version: 1.0
References: <20231206-zswap-lock-optimize-v1-0-e25b059f9c3a@bytedance.com> <CAKEwX=NXcY3_GuKbh0=Ceg9wj=7u4y0NgmfSVEG3-+deY0jiWQ@mail.gmail.com>
In-Reply-To: <CAKEwX=NXcY3_GuKbh0=Ceg9wj=7u4y0NgmfSVEG3-+deY0jiWQ@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 6 Dec 2023 12:41:54 -0800
Message-ID: <CAJD7tkbErWz7Rjn-JdY8LjSW=GzEyyrNeJ5P1ipChFSufmQmLQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] mm/zswap: optimize the scalability of zswap rb-tree
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Chris Li <chrisl@kernel.org>
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

On Wed, Dec 6, 2023 at 9:24=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote:
>
> + Chris Li
>
> Chris, I vaguely remember from our last conversation that you have
> some concurrent efforts to use xarray here right?

If I recall correctly, the xarray already reduces the lock contention
as lookups are lockless, but Chris knows more here. As you mentioned
in a different email, it would be nice to get some data so that we can
compare different solutions.

>
> On Wed, Dec 6, 2023 at 1:46=E2=80=AFAM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
> >
> > Hi everyone,
> >
> > This patch series is based on the linux-next 20231205, which depends on
> > the "workload-specific and memory pressure-driven zswap writeback" seri=
es
> > from Nhat Pham.
> >
> > When testing the zswap performance by using kernel build -j32 in a tmpf=
s
> > directory, I found the scalability of zswap rb-tree is not good, which
> > is protected by the only spinlock. That would cause heavy lock contenti=
on
> > if multiple tasks zswap_store/load concurrently.
> >
> > So a simple solution is to split the only one zswap rb-tree into multip=
le
> > rb-trees, each corresponds to SWAP_ADDRESS_SPACE_PAGES (64M). This idea=
 is
> > from the commit 4b3ef9daa4fc ("mm/swap: split swap cache into 64MB trun=
ks").
> >
> > Although this method can't solve the spinlock contention completely, it
> > can mitigate much of that contention.
> >
> > Another problem when testing the zswap using our default zsmalloc is th=
at
> > zswap_load() and zswap_writeback_entry() have to malloc a temporary mem=
ory
> > to support !zpool_can_sleep_mapped().
> >
> > Optimize it by reusing the percpu crypto_acomp_ctx->dstmem, which is al=
so
> > used by zswap_store() and protected by the same percpu crypto_acomp_ctx=
->mutex.
> >
> > Thanks for review and comment!
> >
> > To: Andrew Morton <akpm@linux-foundation.org>
> > To: Seth Jennings <sjenning@redhat.com>
> > To: Dan Streetman <ddstreet@ieee.org>
> > To: Vitaly Wool <vitaly.wool@konsulko.com>
> > To: Nhat Pham <nphamcs@gmail.com>
> > To: Johannes Weiner <hannes@cmpxchg.org>
> > To: Yosry Ahmed <yosryahmed@google.com>
> > To: Michal Hocko <mhocko@kernel.org>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-mm@kvack.org
> > Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> >
> > ---
> > Chengming Zhou (7):
> >       mm/zswap: make sure each swapfile always have zswap rb-tree
> >       mm/zswap: split zswap rb-tree
> >       mm/zswap: reuse dstmem when decompress
> >       mm/zswap: change dstmem size to one page
> >       mm/zswap: refactor out __zswap_load()
> >       mm/zswap: cleanup zswap_load()
> >       mm/zswap: cleanup zswap_reclaim_entry()
> >
> >  include/linux/zswap.h |   4 +-
> >  mm/swapfile.c         |  10 ++-
> >  mm/zswap.c            | 233 +++++++++++++++++++++---------------------=
--------
> >  3 files changed, 106 insertions(+), 141 deletions(-)
> > ---
> > base-commit: 0f5f12ac05f36f117e793656c3f560625e927f1b
> > change-id: 20231206-zswap-lock-optimize-06f45683b02b
> >
> > Best regards,
> > --
> > Chengming Zhou <zhouchengming@bytedance.com>
