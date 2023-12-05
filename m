Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4242380436D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 01:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjLEAaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 19:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjLEAau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 19:30:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3151F101
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 16:30:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A5CC433C9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 00:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701736256;
        bh=HFxQO9kBLtbTfZYFGSzvwFymTrp7jyUtmcbLo8s+6e0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WJ+IzGK1aNml2oVdUfq8bvf0Kf81D+fxssPMqFr10MZ9QKPzNtifcM9UVCIvIa1Ma
         Uiv0HR57XrIqr4UTmrZZ/no94A8v8GK0tdyBOQ/dEDkqRQP8fvhsSsTp46U6glTV2X
         25GMvujB3TykTjCaVmm18tF/16hAqzYYhOKrqo9jjhNemvloG5K3JMjzlX7Nq7DD22
         D5aVlbiGmZ8Etc/7ryHsPdR+smmUtppbMsTeKpA9NdD3si4sKPWoib+jp4i8AxE3vq
         tqEFSi08wQS/6XwaiPcIZsL4sYLYWTDU5V9wv2LSRzGMr8sDBgHSb2EFrkQu564TDQ
         8g4kjsuMKO5hA==
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-286d6c95b8cso494604a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 16:30:56 -0800 (PST)
X-Gm-Message-State: AOJu0YwhA36a85CZKEIuvgR3XGQMt/awg759P37pwBXO4EyCyIi9iTsf
        n7Ac7Kr9L6e9GZe+mHUgtMgX9aktIb9T7gcC5I9quw==
X-Google-Smtp-Source: AGHT+IEWYlE+eX9ld2dW3geKjHnQOFvx/IzPfMBaF/e3/gmHwWd6Fy0ErIhUizK7vzYb5rbo3Xc/P8UdfcnvsXFiO0Y=
X-Received: by 2002:a17:90a:8597:b0:286:6f14:2870 with SMTP id
 m23-20020a17090a859700b002866f142870mr512560pjn.31.1701736255833; Mon, 04 Dec
 2023 16:30:55 -0800 (PST)
MIME-Version: 1.0
References: <20231130194023.4102148-1-nphamcs@gmail.com> <20231130194023.4102148-2-nphamcs@gmail.com>
 <ZWjpNr3ZzvU4TDC8@casper.infradead.org> <CAKEwX=MV-F50i_=sZ0unfbgjrdxSTio00c4xTM19113BAN3-wA@mail.gmail.com>
 <20231130203522.GC543908@cmpxchg.org>
In-Reply-To: <20231130203522.GC543908@cmpxchg.org>
From:   Chris Li <chrisl@kernel.org>
Date:   Mon, 4 Dec 2023 16:30:44 -0800
X-Gmail-Original-Message-ID: <CAF8kJuOvi6jrSPPKNeS1LFzEAPZwO77vEi5KQwW0c3eU13rcqQ@mail.gmail.com>
Message-ID: <CAF8kJuOvi6jrSPPKNeS1LFzEAPZwO77vEi5KQwW0c3eU13rcqQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/6] list_lru: allows explicit memcg and NUMA node selection
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Nhat Pham <nphamcs@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        akpm@linux-foundation.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
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

On Thu, Nov 30, 2023 at 12:35=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> On Thu, Nov 30, 2023 at 12:07:41PM -0800, Nhat Pham wrote:
> > On Thu, Nov 30, 2023 at 11:57=E2=80=AFAM Matthew Wilcox <willy@infradea=
d.org> wrote:
> > >
> > > On Thu, Nov 30, 2023 at 11:40:18AM -0800, Nhat Pham wrote:
> > > > This patch changes list_lru interface so that the caller must expli=
citly
> > > > specify numa node and memcg when adding and removing objects. The o=
ld
> > > > list_lru_add() and list_lru_del() are renamed to list_lru_add_obj()=
 and
> > > > list_lru_del_obj(), respectively.
> > >
> > > Wouldn't it be better to add list_lru_add_memcg() and
> > > list_lru_del_memcg() and have:

That is my first thought as well. If we are having two different
flavors of LRU add, one has memcg and one without. The list_lru_add()
vs list_lru_add_memcg() is the common way to do it.
> > >
> > > +bool list_lru_del(struct list_lru *lru, struct list_head *item)
> > > +{
> > > +       int nid =3D page_to_nid(virt_to_page(item));
> > > +       struct mem_cgroup *memcg =3D list_lru_memcg_aware(lru) ?
> > > +               mem_cgroup_from_slab_obj(item) : NULL;
> > > +
> > > +       return list_lru_del_memcg(lru, item, nid, memcg);
> > > +}
> > >
> > > Seems like _most_ callers will want the original versions and only
> > > a few will want the explicit memcg/nid versions.  No?
> > >
> >
> > I actually did something along that line in earlier iterations of this
> > patch series (albeit with poorer naming - __list_lru_add() instead of
> > list_lru_add_memcg()). The consensus after some back and forth was
> > that the original list_lru_add() was not a very good design (the
> > better one was this new version that allows for explicit numa/memcg
> > selection). So I agreed to fix it everywhere as a prep patch.
> >
> > I don't have strong opinions here to be completely honest, but I do
> > think this new API makes more sense (at the cost of quite a bit of
> > elbow grease to fix every callsites and extra reviewing).
>
> Maybe I can shed some light since I was pushing for doing it this way.
>
> The quiet assumption that 'struct list_head *item' is (embedded in) a
> slab object that is also charged to a cgroup is a bit much, given that
> nothing in the name or documentation of the function points to that.

We can add it to the document if that is desirable.

>
> It bit us in the THP shrinker where that list head is embedded in a
> tailpage (virt_to_page(page) is fun to debug). And it caused some
> confusion in this case as well, where the zswap entry is a slab object
> but not charged (the entry descriptor is not attractive for cgroup
> accounting, only the backing memory it points to.)
>
> Yes, for most users - at least right now - the current assumption is
> accurate. The thinking was just that if we do have to differentiate
> callers now anyway, we might as well make the interface a bit more
> self-documenting and harder to misuse going forward, even if it's a
> bit more churn now.

It comes down to whether we need to have the non memcg version of API
going forward. If we don't then change the meaning of list_lru_add()
to perform the deed of list_lru_add_memcg() makes sense. My assumption
is that the non memcg version of the API does have legit usage. In
that case, it seems having the original list_lru_add() and
list_lur_add_memcg() as Mattew suggested feels more natural. What you
really want is that every caller of list_lru_add() should seriously
consider switching to list_lru_add_memcg() unless it has a very good
reason to stay in the non memcg version. Renaming and changing the
meaning of list_lru_add() is a bit confusing and has a negative impact
on the outstanding patch that uses list_lru_add().  The end of the
day, some developers still need to evaluate the call site one by one,
renaming the function is not going to help that effort. Just make it
more obvious.

Just my 2 cents, others please chime in. Just to make it clear, that
is my preference, it is not a NACK.

Chris
