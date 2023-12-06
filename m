Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2484806BBD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377632AbjLFKSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377549AbjLFKSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:18:39 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DD98F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:18:45 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-46495e57cdeso578913137.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 02:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701857925; x=1702462725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PB5sZ5MSZmZsnlatsjzNG0ijjFc2lOy26kZJCTP898Q=;
        b=RZGcPZqXMA0agsSEY6/QfvG6mKWhOvS/+WAb0TiZJb8urUGJYVq8nnDRaDetc6kfBe
         iOWp26tO2gqJmZXBGFRwdMxmtEJTVLS/FgzyceOhuUYSx/C/EN4EufnwzQ85d0IQOt9H
         uvU4sch2u36DP8SxzZUuMIZwPqlowIkDFciWFQyRdeupUyh1CdAT3oJHy4s+J7YdE7/o
         8IIVclnUVFkV0yNFRhT4+8Q2Aje485zdVPXf5MNv4sG2gCK/HRTRgYtero3JyGnnrjTv
         98DQR9BpejKCVI4FlTvgNCNk1oQXPLeGQ80cKATZ5WDMEcdqAVWjRU/D0vvIFcYm2oMH
         tC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701857925; x=1702462725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PB5sZ5MSZmZsnlatsjzNG0ijjFc2lOy26kZJCTP898Q=;
        b=s8QDwFBuQ3Q1V0C3rKA6ws26dL9NkZueO1elg8judCqNYxJYaxYvb5/KNlB2sIQ+AE
         lH9JvH1T2XB2Q7g1bpPxvtdhfDneEUK7VbNpGreQrjGhgdATcQbivU4zyygOwQKss3A3
         Z7exspeIuxHDqnT6RzkQIFPWKswHoQ8sYcTbqzjxFFlDolmfOmM8f+8Wjyes9p2NKwyH
         N/5/IgAWXpgFQvHAy6duXLh076jNqQV5S8GoaCynThJNCpGFePXJNyfEVtKSFCbanW5l
         pPFfqaRPgnKRCqEswRs9LsHBKsOqa/T4MFZ7rtt4NCdMdisk+GEvaGGS/PyHAzsfT0o7
         cT+Q==
X-Gm-Message-State: AOJu0YxE/63sUga4Ga4lb8wB6MoqFm7T2GUFRUTWno7fTK4YSOlCw8Ua
        O5w4qOkIDBXpxcROxV661DnLOB3ga2Bq/yioNMM=
X-Google-Smtp-Source: AGHT+IFh+MMuiWe4LiMzv/KJTqc5ICpDaA5Y7AOzgAcrrvz+FZPl+kGnCbxOkUR4ACPrCPbILgIpjx0Mmm/ihmaWg+I=
X-Received: by 2002:a05:6102:7b8:b0:464:95d9:8d39 with SMTP id
 x24-20020a05610207b800b0046495d98d39mr170221vsg.27.1701857924667; Wed, 06 Dec
 2023 02:18:44 -0800 (PST)
MIME-Version: 1.0
References: <20231129104530.63787-1-v-songbaohua@oppo.com> <079610c2-04ed-4495-8eb7-518b04f911f7@linux.alibaba.com>
In-Reply-To: <079610c2-04ed-4495-8eb7-518b04f911f7@linux.alibaba.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 6 Dec 2023 23:18:32 +1300
Message-ID: <CAGsJ_4y4Me8=sgujeg6zSz2c_LmnSEg=Z+Q1C7_Wug=k0bGaug@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: compaction: avoid fast_isolate_freepages blindly
 choose improper pageblock
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org, david@redhat.com,
        shikemeng@huaweicloud.com, willy@infradead.org,
        mgorman@techsingularity.net, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
        Zhanyuan Hu <huzhanyuan@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 6, 2023 at 10:54=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 11/29/2023 6:45 PM, Barry Song wrote:
> > Testing shows fast_isolate_freepages can blindly choose an unsuitable
> > pageblock from time to time particularly while the min mark is used
> > from XXX path:
> >   if (!page) {
> >           cc->fast_search_fail++;
> >           if (scan_start) {
> >                   /*
> >                    * Use the highest PFN found above min. If one was
> >                    * not found, be pessimistic for direct compaction
> >                    * and use the min mark.
> >                    */
> >                   if (highest >=3D min_pfn) {
> >                           page =3D pfn_to_page(highest);
> >                           cc->free_pfn =3D highest;
> >                   } else {
> >                           if (cc->direct_compaction && pfn_valid(min_pf=
n)) { /* XXX */
> >                                   page =3D pageblock_pfn_to_page(min_pf=
n,
> >                                           min(pageblock_end_pfn(min_pfn=
),
> >                                               zone_end_pfn(cc->zone)),
> >                                           cc->zone);
> >                                   cc->free_pfn =3D min_pfn;
> >                           }
> >                   }
> >           }
> >   }
>
> Yes, the min_pfn can be an unsuitable migration target. But I think we
> can just add the suitable_migration_target() validation into 'min_pfn'
> case? Since other cases must be suitable target which found from
> MIGRATE_MOVABLE free list. Something like below:
>
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 01ba298739dd..4e8eb4571909 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1611,6 +1611,8 @@ static void fast_isolate_freepages(struct
> compact_control *cc)
>
> min(pageblock_end_pfn(min_pfn),
>
> zone_end_pfn(cc->zone)),
>                                                  cc->zone);
> +                                       if
> (!suitable_migration_target(cc, page))
> +                                               page =3D NULL;
>                                          cc->free_pfn =3D min_pfn;
>                                  }
>                          }
>

yes. this makes more senses.

> By the way, I wonder if this patch can improve the efficiency of
> compaction in your test case?

This happens not quite often. when running 25 machines for
one night, most of them can hit this unexpected code path.
but the frequency isn't  many times in one second. it might
be one time in a couple of hours.

so it is very difficult to measure the visible performance impact
in my machines though the affection of choosing the unsuitable
migration_target should be negative.

I feel like it's worth fixing this to at least make the code theoretically
self-explanatory? as it is quite odd unsuitable_migration_target can
be still migration_target?

>
> > In contrast, slow path is skipping unsuitable pageblocks in a decent wa=
y.
> >
> > I don't know if it is an intended design or just an oversight. But
> > it seems more sensible to skip unsuitable pageblock.
> >
> > Reported-by: Zhanyuan Hu <huzhanyuan@oppo.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >   mm/compaction.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/mm/compaction.c b/mm/compaction.c
> > index 01ba298739dd..98c485a25614 100644
> > --- a/mm/compaction.c
> > +++ b/mm/compaction.c
> > @@ -1625,6 +1625,12 @@ static void fast_isolate_freepages(struct compac=
t_control *cc)
> >       cc->total_free_scanned +=3D nr_scanned;
> >       if (!page)
> >               return;
> > +     /*
> > +      * Otherwise, we can blindly choose an improper pageblock especia=
lly
> > +      * while using the min mark
> > +      */
> > +     if (!suitable_migration_target(cc, page))
> > +             return;
> >
> >       low_pfn =3D page_to_pfn(page);
> >       fast_isolate_around(cc, low_pfn);

Thanks
Barry
