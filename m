Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574917FE5FC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 02:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343945AbjK3B0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 20:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjK3B0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 20:26:41 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D4010C3;
        Wed, 29 Nov 2023 17:26:47 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-35c617c9e73so930935ab.1;
        Wed, 29 Nov 2023 17:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701307606; x=1701912406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAYD5IjaIlcnamI/OXacp/VY9pjlnxPbgUDraWeIFVQ=;
        b=l1xiFnKqcPrRbQrAar0/jISBsvpfi8Tl39rcpJv8drEMpKI3BLXB33i6Bcw68ESZUC
         S3B69l7PUXaF8NTZX+OpZ7J/pu00Q5kL2/pUOi60CLa/mTQrNMq7x0/VOhm78NjtKP04
         qifDHUKX4A6i/rEOx124HeXAXmBCxl03S3vpPqnD7eTA6K9iMrTgGArqw05VLJfTy8wT
         M294b/jxs5gAWLuaeG83iagLZUO50VQojADYkdfp1YSjB8grIyPp7UZpIPBEpJg0Rn/T
         S11/PGC714K2rKmIEsgT9Gv4xgAQySUosxRASOueBeCCcwezLhLQ48gxeFIFz4atIemd
         dsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701307606; x=1701912406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAYD5IjaIlcnamI/OXacp/VY9pjlnxPbgUDraWeIFVQ=;
        b=h0+QqMn/m643twAfY6TfwEKfEAPAbG3PK+OVlI27T+UdOlgYWd2EaW7v/Ga3gMGIAe
         UyLRes8aQ3q/BnpWVW9cheFld7uQmAh0X+ccuiGldfjWjnky/gV/Iy4zAF8mKXdw+ToT
         6Vb3dC/X3/XEdSj1ORwQTqTWLWEtViRwXBp+f0V9lsbUCaOfVzO0fEXthWYR9AHLqPph
         Fko7L4FnnysPaoRKp88yeP+XjYm6kv+F/NjOBKlV6cqc65n1cuuUSqFIgqhM57r8IKtv
         V/hoFa5ESuFH8IhYSAV6Ym+oAti8cVLyaOJZUSXgE7Y/Dg4UXey4IswLW8zj282eg67n
         8Svw==
X-Gm-Message-State: AOJu0Yyhg3nOABOLTqHu9DHxvlCqOvxxwk4pwEn2DPtqZxggf4WbzNXO
        b933+pn51Hkbn25KB5VeLG8qJ7Lm0EElZquLEbw=
X-Google-Smtp-Source: AGHT+IE3W3NFenEBkj10iaZduYHiFsqZTptTCu9CtFVqwR0QFWqwuHcKqWUaQLTkNatWIljPNg5415UZJNAoj8G8tTk=
X-Received: by 2002:a92:4b02:0:b0:35c:d630:8c9a with SMTP id
 m2-20020a924b02000000b0035cd6308c9amr13585997ilg.28.1701307606540; Wed, 29
 Nov 2023 17:26:46 -0800 (PST)
MIME-Version: 1.0
References: <20231127234600.2971029-1-nphamcs@gmail.com> <20231127234600.2971029-5-nphamcs@gmail.com>
 <20231129152509.GD135852@cmpxchg.org>
In-Reply-To: <20231129152509.GD135852@cmpxchg.org>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Wed, 29 Nov 2023 17:26:35 -0800
Message-ID: <CAKEwX=P48OwcKMyeFXDuXmUOcpx3stGfV_DwunBuXjL7EuqF1w@mail.gmail.com>
Subject: Re: [PATCH v7 4/6] mm: memcg: add per-memcg zswap writeback stat
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     akpm@linux-foundation.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
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

On Wed, Nov 29, 2023 at 7:25=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Mon, Nov 27, 2023 at 03:45:58PM -0800, Nhat Pham wrote:
> > From: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> >
> > Since zswap now writes back pages from memcg-specific LRUs, we now need=
 a
> > new stat to show writebacks count for each memcg.
> >
> > Suggested-by: Nhat Pham <nphamcs@gmail.com>
> > Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > ---
> >  include/linux/vm_event_item.h | 1 +
> >  mm/memcontrol.c               | 1 +
> >  mm/vmstat.c                   | 1 +
> >  mm/zswap.c                    | 3 +++
> >  4 files changed, 6 insertions(+)
> >
> > diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_ite=
m.h
> > index d1b847502f09..f4569ad98edf 100644
> > --- a/include/linux/vm_event_item.h
> > +++ b/include/linux/vm_event_item.h
> > @@ -142,6 +142,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPO=
UT,
> >  #ifdef CONFIG_ZSWAP
> >               ZSWPIN,
> >               ZSWPOUT,
> > +             ZSWP_WB,
> >  #endif
> >  #ifdef CONFIG_X86
> >               DIRECT_MAP_LEVEL2_SPLIT,
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 8c0f3f971179..f88c8fd03689 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -703,6 +703,7 @@ static const unsigned int memcg_vm_event_stat[] =3D=
 {
> >  #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
> >       ZSWPIN,
> >       ZSWPOUT,
> > +     ZSWP_WB,
> >  #endif
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >       THP_FAULT_ALLOC,
> > diff --git a/mm/vmstat.c b/mm/vmstat.c
> > index afa5a38fcc9c..2249f85e4a87 100644
> > --- a/mm/vmstat.c
> > +++ b/mm/vmstat.c
> > @@ -1401,6 +1401,7 @@ const char * const vmstat_text[] =3D {
> >  #ifdef CONFIG_ZSWAP
> >       "zswpin",
> >       "zswpout",
> > +     "zswp_wb",
>
> ZSWPWB and "zswpwb" would match the existing naming scheme a bit
> better.
>
> >  #endif
> >  #ifdef CONFIG_X86
> >       "direct_map_level2_splits",
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 5e397fc1f375..6a761753f979 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -754,6 +754,9 @@ static enum lru_status shrink_memcg_cb(struct list_=
head *item, struct list_lru_o
> >       }
> >       zswap_written_back_pages++;
> >
> > +     if (entry->objcg)
> > +             count_objcg_event(entry->objcg, ZSWP_WB);
> > +
>
> You need to call count_vm_event() as well, otherwise the /proc/vmstat
> counter will stay zero.

Ahh I didn't check that. I only looked at the cgroup's memory.stat
counter. I'll fix this for v8!
