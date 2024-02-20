Return-Path: <linux-kernel+bounces-72256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 258FC85B137
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 644A3B216AA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FBC4437C;
	Tue, 20 Feb 2024 03:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbchGi4q"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A63C2E630
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 03:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708399176; cv=none; b=q2T61ydigqIiVQxozvIbZXDyhqkl52wwsPzOUhvgq/HK2OgbF1vOyO8bUILBX2w3ZmSIfCn8VtUWStQ0XZ6XiDhDujf/rEL5Pk9qubKekxMVMqdSeSf0YWjm4kPz0BTrLKLMzL0FRdurns7K6q84WaSNToLilx3gqFAX+qxe0oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708399176; c=relaxed/simple;
	bh=odgDXzYHOJ10Sl6RI7v2yiXOF8GHB9PSeFuZOcQlX0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Plvgv+R2f5YMq7kdBydfGQiqo+rgXpKL1LVrl09BwKXWlUWObsneCZRuKHoamq8z66vUaY+zGM6PSFjjNZsJCphAIVsA1lOBb91DKmvSO2RH5XZA90XTj/WuaYaHczJlyovaGuXV89Sb4fjRynHChEzeHempFAUzbVimX5s9dtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbchGi4q; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4c90bdfc8b2so170501e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 19:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708399173; x=1709003973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcM+8HDHdAZyEBy8BdYaWppJFSVvUfQ4q1xGULaAmLg=;
        b=BbchGi4qkNeqjMpJgV0fcysYFW899PAQG2UDrRSer2PTHZSkWpWmNoZP0mxk+XpkO1
         BRmbYe0qPN59pbuTjCltGZY5Xb8/b34ohEnyOq8hIeBrm7XSdzlb0Sm1PH6IdOTIvdMb
         OX744pcAGM2lh3OM0EXSY7hhOFT7jbC3zVDQR9yklplsWlvZkDnn3kqpVa7PJns1lAOD
         waOBIgX4mwAIwe1Kp7owKmhDxbFkQ2JsrF0nqcRmy7eO319nJAEZM2XLa2K/H7+N5Hxm
         boFyuKi1fGBikbJIkTLpdOZ78sGe7YDzfIVYdlX9R6gWyfG88VuCIhHrW6h0FxGsvXPs
         iq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708399173; x=1709003973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CcM+8HDHdAZyEBy8BdYaWppJFSVvUfQ4q1xGULaAmLg=;
        b=LfiP0y9bR4zdwa7bHIuY7XfP9zwfMWsmneWpciHXxkEDLpSKXUqzHIpU8DvxYE7THs
         ejxu8O48uJfwqnnAeMr20kEQ30ZjrvnXVu3n6VVz0Upp90oed46Sceped6fBGf4IKs0o
         hkzzmc7S4GIwEhEIdRTw3eehSj7RbekQamtlvl2vorEYZ9qMDaNPqYhI9myR4rS3hcJY
         Kbx0q2JBSKkhDnjE2t5dx/f8RRW6ak8kHHXji9mg8uhPJ/Z1Nk5wYZeYnb78pEYjz7bo
         JbRnRIqWDTQbtEmYjJqgdZmkSLuccljXitZ1MlEaMPIxEDK2qhuMlLzLFwjDaVcqHwUy
         vVgw==
X-Forwarded-Encrypted: i=1; AJvYcCXqND7r5n1Miv557P24L+jB1fEWmdXhWEESJWXAwUxwpfKVB+W0MsuBYf3uLFzp28JNvBWoAeigubZeZybrNL4cKnmbvaCAY1ZnyOm5
X-Gm-Message-State: AOJu0Yz79KTihmrnl5NIodlyw5LFQ2nfG5N9tqSx6GuVgxdFg50K7lqJ
	eGrxxJQmAJLETfzjBN2QOhv55OVogfcDhw6Ob9LC5N7oOWJk8duKcTq+GaclobltwhabghA3Ajl
	4mDdyhZGBYABfUgWZ7EV6C7NO8Sc=
X-Google-Smtp-Source: AGHT+IHBLAKeCW9NaM35zuHaouHh+Q/iC4UePksbIWMndYJ8Hl7pyfuHg1WiLJD1qVO7tiLawShTpDIH/11WwCfQrMU=
X-Received: by 2002:a05:6122:2516:b0:4ce:7663:af1f with SMTP id
 cl22-20020a056122251600b004ce7663af1fmr2222883vkb.7.1708399172938; Mon, 19
 Feb 2024 19:19:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219141703.3851-1-lipeifeng@oppo.com> <20240219141703.3851-3-lipeifeng@oppo.com>
 <f0ad229d-0846-d60b-2508-88c5878e733a@oppo.com>
In-Reply-To: <f0ad229d-0846-d60b-2508-88c5878e733a@oppo.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 20 Feb 2024 16:19:21 +1300
Message-ID: <CAGsJ_4yxqXk3ZqShbov8Ta9m5USArZBhbD+EZmPsvcvbkGJF=g@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: support kshrinkd
To: =?UTF-8?B?5p2O5Z+56ZSL?= <lipeifeng@oppo.com>
Cc: akpm@linux-foundation.org, david@redhat.com, osalvador@suse.de, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	tkjos@google.com, gregkh@google.com, v-songbaohua@oppo.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peifeng,

On Tue, Feb 20, 2024 at 3:21=E2=80=AFPM =E6=9D=8E=E5=9F=B9=E9=94=8B <lipeif=
eng@oppo.com> wrote:
>
> add experts from Linux and Google.
>
>
> =E5=9C=A8 2024/2/19 22:17, lipeifeng@oppo.com =E5=86=99=E9=81=93:
> > From: lipeifeng <lipeifeng@oppo.com>
> >
> > 'commit 6d4675e60135 ("mm: don't be stuck to rmap lock on reclaim path"=
)'
> > The above patch would avoid reclaim path to stuck rmap lock.
> > But it would cause some folios in LRU not sorted by aging because
> > the contended-folio in rmap_walk would be putback to the head of LRU
> > when shrink_folio_list even if the folio is very cold.
> >
> > Monkey-test in phone for 300 hours shows that almost one-third of the
> > contended-pages can be freed successfully next time, putting back those
> > folios to LRU's head would break the rules of LRU.

the commit message seems hard to read.

how serious the LRU aging is broken? what is the percentage of folios
being contended?

what is the negative impact if the contented folios are aged improperly?

> > - pgsteal_kshrinkd 262577
> > - pgscan_kshrinkd 795503
> >
> > For the above reason, the patch setups new kthread:kshrinkd to reclaim
> > the contended-folio in rmap_walk when shrink_folio_list, to avoid to
> > break the rules of LRU.

what benefits the real users experiences have got from the "fixed" aging
by your approach putting contended folios in a separate list and having a
separate thread to reclaim them?

> >
> > Signed-off-by: lipeifeng <lipeifeng@oppo.com>
> > ---
> >   include/linux/mmzone.h        |   6 ++
> >   include/linux/swap.h          |   3 +
> >   include/linux/vm_event_item.h |   2 +
> >   mm/memory_hotplug.c           |   2 +
> >   mm/vmscan.c                   | 189 +++++++++++++++++++++++++++++++++=
++++++++-
> >   mm/vmstat.c                   |   2 +
> >   6 files changed, 201 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index a497f18..83d7202 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -1329,6 +1329,12 @@ typedef struct pglist_data {
> >
> >       int kswapd_failures;            /* Number of 'reclaimed =3D=3D 0'=
 runs */
> >
> > +     struct list_head kshrinkd_folios; /* rmap_walk contended folios l=
ist*/
> > +     spinlock_t kf_lock; /* Protect kshrinkd_folios list*/
> > +
> > +     struct task_struct *kshrinkd; /* reclaim kshrinkd_folios*/
> > +     wait_queue_head_t kshrinkd_wait;
> > +
> >   #ifdef CONFIG_COMPACTION
> >       int kcompactd_max_order;
> >       enum zone_type kcompactd_highest_zoneidx;
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index 4db00dd..155fcb6 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -435,6 +435,9 @@ void check_move_unevictable_folios(struct folio_bat=
ch *fbatch);
> >   extern void __meminit kswapd_run(int nid);
> >   extern void __meminit kswapd_stop(int nid);
> >
> > +extern void kshrinkd_run(int nid);
> > +extern void kshrinkd_stop(int nid);
> > +
> >   #ifdef CONFIG_SWAP
> >
> >   int add_swap_extent(struct swap_info_struct *sis, unsigned long start=
_page,
> > diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_ite=
m.h
> > index 747943b..ee95ab1 100644
> > --- a/include/linux/vm_event_item.h
> > +++ b/include/linux/vm_event_item.h
> > @@ -38,9 +38,11 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOU=
T,
> >               PGLAZYFREED,
> >               PGREFILL,
> >               PGREUSE,
> > +             PGSTEAL_KSHRINKD,
> >               PGSTEAL_KSWAPD,
> >               PGSTEAL_DIRECT,
> >               PGSTEAL_KHUGEPAGED,
> > +             PGSCAN_KSHRINKD,
> >               PGSCAN_KSWAPD,
> >               PGSCAN_DIRECT,
> >               PGSCAN_KHUGEPAGED,
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index 2189099..1b6c4c6 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -1209,6 +1209,7 @@ int __ref online_pages(unsigned long pfn, unsigne=
d long nr_pages,
> >
> >       kswapd_run(nid);
> >       kcompactd_run(nid);
> > +     kshrinkd_run(nid);
> >
> >       writeback_set_ratelimit();
> >
> > @@ -2092,6 +2093,7 @@ int __ref offline_pages(unsigned long start_pfn, =
unsigned long nr_pages,
> >       }
> >
> >       if (arg.status_change_nid >=3D 0) {
> > +             kshrinkd_stop(node);
> >               kcompactd_stop(node);
> >               kswapd_stop(node);
> >       }
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 0296d48..63e4fd4 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -139,6 +139,9 @@ struct scan_control {
> >       /* if try_lock in rmap_walk */
> >       unsigned int rw_try_lock:1;
> >
> > +     /* need kshrinkd to reclaim if rwc trylock contended*/
> > +     unsigned int need_kshrinkd:1;
> > +
> >       /* Allocation order */
> >       s8 order;
> >
> > @@ -190,6 +193,17 @@ struct scan_control {
> >    */
> >   int vm_swappiness =3D 60;
> >
> > +/*
> > + * Wakeup kshrinkd those folios which lock-contended in ramp_walk
> > + * during shrink_folio_list, instead of putting back to the head
> > + * of LRU, to avoid to break the rules of LRU.
> > + */
> > +static void wakeup_kshrinkd(struct pglist_data *pgdat)
> > +{
> > +     if (likely(pgdat->kshrinkd))
> > +             wake_up_interruptible(&pgdat->kshrinkd_wait);
> > +}
> > +
> >   #ifdef CONFIG_MEMCG
> >
> >   /* Returns true for reclaim through cgroup limits or cgroup interface=
s. */
> > @@ -821,6 +835,7 @@ enum folio_references {
> >       FOLIOREF_RECLAIM_CLEAN,
> >       FOLIOREF_KEEP,
> >       FOLIOREF_ACTIVATE,
> > +     FOLIOREF_LOCK_CONTENDED,
> >   };
> >
> >   static enum folio_references folio_check_references(struct folio *fol=
io,
> > @@ -841,8 +856,12 @@ static enum folio_references folio_check_reference=
s(struct folio *folio,
> >               return FOLIOREF_ACTIVATE;
> >
> >       /* rmap lock contention: rotate */
> > -     if (referenced_ptes =3D=3D -1)
> > -             return FOLIOREF_KEEP;
> > +     if (referenced_ptes =3D=3D -1) {
> > +             if (sc->need_kshrinkd && folio_pgdat(folio)->kshrinkd)
> > +                     return FOLIOREF_LOCK_CONTENDED;
> > +             else
> > +                     return FOLIOREF_KEEP;
> > +     }
> >
> >       if (referenced_ptes) {
> >               /*
> > @@ -1012,6 +1031,7 @@ static unsigned int shrink_folio_list(struct list=
_head *folio_list,
> >       LIST_HEAD(ret_folios);
> >       LIST_HEAD(free_folios);
> >       LIST_HEAD(demote_folios);
> > +     LIST_HEAD(contended_folios);
> >       unsigned int nr_reclaimed =3D 0;
> >       unsigned int pgactivate =3D 0;
> >       bool do_demote_pass;
> > @@ -1028,6 +1048,7 @@ static unsigned int shrink_folio_list(struct list=
_head *folio_list,
> >               enum folio_references references =3D FOLIOREF_RECLAIM;
> >               bool dirty, writeback;
> >               unsigned int nr_pages;
> > +             bool lock_contended =3D false;
> >
> >               cond_resched();
> >
> > @@ -1169,6 +1190,9 @@ static unsigned int shrink_folio_list(struct list=
_head *folio_list,
> >               case FOLIOREF_KEEP:
> >                       stat->nr_ref_keep +=3D nr_pages;
> >                       goto keep_locked;
> > +             case FOLIOREF_LOCK_CONTENDED:
> > +                     lock_contended =3D true;
> > +                     goto keep_locked;
> >               case FOLIOREF_RECLAIM:
> >               case FOLIOREF_RECLAIM_CLEAN:
> >                       ; /* try to reclaim the folio below */
> > @@ -1449,7 +1473,10 @@ static unsigned int shrink_folio_list(struct lis=
t_head *folio_list,
> >   keep_locked:
> >               folio_unlock(folio);
> >   keep:
> > -             list_add(&folio->lru, &ret_folios);
> > +             if (unlikely(lock_contended))
> > +                     list_add(&folio->lru, &contended_folios);
> > +             else
> > +                     list_add(&folio->lru, &ret_folios);
> >               VM_BUG_ON_FOLIO(folio_test_lru(folio) ||
> >                               folio_test_unevictable(folio), folio);
> >       }
> > @@ -1491,6 +1518,14 @@ static unsigned int shrink_folio_list(struct lis=
t_head *folio_list,
> >       free_unref_page_list(&free_folios);
> >
> >       list_splice(&ret_folios, folio_list);
> > +
> > +     if (!list_empty(&contended_folios)) {
> > +             spin_lock_irq(&pgdat->kf_lock);
> > +             list_splice(&contended_folios, &pgdat->kshrinkd_folios);
> > +             spin_unlock_irq(&pgdat->kf_lock);
> > +             wakeup_kshrinkd(pgdat);
> > +     }
> > +
> >       count_vm_events(PGACTIVATE, pgactivate);
> >
> >       if (plug)
> > @@ -1505,6 +1540,7 @@ unsigned int reclaim_clean_pages_from_list(struct=
 zone *zone,
> >               .gfp_mask =3D GFP_KERNEL,
> >               .may_unmap =3D 1,
> >               .rw_try_lock =3D 1,
> > +             .need_kshrinkd =3D 0,
> >       };
> >       struct reclaim_stat stat;
> >       unsigned int nr_reclaimed;
> > @@ -2101,6 +2137,7 @@ static unsigned int reclaim_folio_list(struct lis=
t_head *folio_list,
> >               .may_swap =3D 1,
> >               .no_demotion =3D 1,
> >               .rw_try_lock =3D 1,
> > +             .need_kshrinkd =3D 0,
> >       };
> >
> >       nr_reclaimed =3D shrink_folio_list(folio_list, pgdat, &sc, &dummy=
_stat, false);
> > @@ -5448,6 +5485,7 @@ static ssize_t lru_gen_seq_write(struct file *fil=
e, const char __user *src,
> >               .reclaim_idx =3D MAX_NR_ZONES - 1,
> >               .gfp_mask =3D GFP_KERNEL,
> >               .rw_try_lock =3D 1,
> > +             .need_kshrinkd =3D 0,
> >       };
> >
> >       buf =3D kvmalloc(len + 1, GFP_KERNEL);
> > @@ -6421,6 +6459,7 @@ unsigned long try_to_free_pages(struct zonelist *=
zonelist, int order,
> >               .may_unmap =3D 1,
> >               .may_swap =3D 1,
> >               .rw_try_lock =3D 1,
> > +             .need_kshrinkd =3D 1,
> >       };
> >
> >       /*
> > @@ -6467,6 +6506,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_c=
group *memcg,
> >               .reclaim_idx =3D MAX_NR_ZONES - 1,
> >               .may_swap =3D !noswap,
> >               .rw_try_lock =3D 1,
> > +             .need_kshrinkd =3D 0,
> >       };
> >
> >       WARN_ON_ONCE(!current->reclaim_state);
> > @@ -6512,6 +6552,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct=
 mem_cgroup *memcg,
> >               .may_swap =3D !!(reclaim_options & MEMCG_RECLAIM_MAY_SWAP=
),
> >               .proactive =3D !!(reclaim_options & MEMCG_RECLAIM_PROACTI=
VE),
> >               .rw_try_lock =3D 1,
> > +             .need_kshrinkd =3D 0,
> >       };
> >       /*
> >        * Traverse the ZONELIST_FALLBACK zonelist of the current node to=
 put
> > @@ -6774,6 +6815,7 @@ static int balance_pgdat(pg_data_t *pgdat, int or=
der, int highest_zoneidx)
> >               .order =3D order,
> >               .may_unmap =3D 1,
> >               .rw_try_lock =3D 1,
> > +             .need_kshrinkd =3D 1,
> >       };
> >
> >       set_task_reclaim_state(current, &sc.reclaim_state);
> > @@ -7234,6 +7276,7 @@ unsigned long shrink_all_memory(unsigned long nr_=
to_reclaim)
> >               .may_swap =3D 1,
> >               .hibernation_mode =3D 1,
> >               .rw_try_lock =3D 1,
> > +             .need_kshrinkd =3D 0,
> >       };
> >       struct zonelist *zonelist =3D node_zonelist(numa_node_id(), sc.gf=
p_mask);
> >       unsigned long nr_reclaimed;
> > @@ -7304,6 +7347,145 @@ static int __init kswapd_init(void)
> >
> >   module_init(kswapd_init)
> >
> > +static int kshrinkd_should_run(pg_data_t *pgdat)
> > +{
> > +     int should_run;
> > +
> > +     spin_lock_irq(&pgdat->kf_lock);
> > +     should_run =3D !list_empty(&pgdat->kshrinkd_folios);
> > +     spin_unlock_irq(&pgdat->kf_lock);
> > +
> > +     return should_run;
> > +}
> > +
> > +static unsigned long kshrinkd_reclaim_folios(struct list_head *folio_l=
ist,
> > +                             struct pglist_data *pgdat)
> > +{
> > +     struct reclaim_stat dummy_stat;
> > +     unsigned int nr_reclaimed =3D 0;
> > +     struct scan_control sc =3D {
> > +             .gfp_mask =3D GFP_KERNEL,
> > +             .may_writepage =3D 1,
> > +             .may_unmap =3D 1,
> > +             .may_swap =3D 1,
> > +             .no_demotion =3D 1,
> > +             .rw_try_lock =3D 0,
> > +             .need_kshrinkd =3D 0,
> > +     };
> > +
> > +     if (list_empty(folio_list))
> > +             return nr_reclaimed;
> > +
> > +     nr_reclaimed =3D shrink_folio_list(folio_list, pgdat, &sc, &dummy=
_stat, false);
> > +
> > +     return nr_reclaimed;
> > +}
> > +
> > +/*
> > + * The background kshrink daemon, started as a kernel thread
> > + * from the init process.
> > + *
> > + * Kshrinkd is to reclaim the contended-folio in rmap_walk when
> > + * shrink_folio_list instead of putting back into the head of LRU
> > + * directly, to avoid to break the rules of LRU.
> > + */
> > +
> > +static int kshrinkd(void *p)
> > +{
> > +     pg_data_t *pgdat;
> > +     LIST_HEAD(tmp_contended_folios);
> > +
> > +     pgdat =3D (pg_data_t *)p;
> > +
> > +     current->flags |=3D PF_MEMALLOC | PF_KSWAPD;
> > +     set_freezable();
> > +
> > +     while (!kthread_should_stop()) {
> > +             unsigned long nr_reclaimed =3D 0;
> > +             unsigned long nr_putback =3D 0;
> > +
> > +             wait_event_freezable(pgdat->kshrinkd_wait,
> > +                             kshrinkd_should_run(pgdat));
> > +
> > +             /* splice rmap_walk contended folios to tmp-list */
> > +             spin_lock_irq(&pgdat->kf_lock);
> > +             list_splice(&pgdat->kshrinkd_folios, &tmp_contended_folio=
s);
> > +             INIT_LIST_HEAD(&pgdat->kshrinkd_folios);
> > +             spin_unlock_irq(&pgdat->kf_lock);
> > +
> > +             /* reclaim rmap_walk contended folios */
> > +             nr_reclaimed =3D kshrinkd_reclaim_folios(&tmp_contended_f=
olios, pgdat);
> > +             __count_vm_events(PGSTEAL_KSHRINKD, nr_reclaimed);
> > +
> > +             /* putback the folios which failed to reclaim to lru */
> > +             while (!list_empty(&tmp_contended_folios)) {
> > +                     struct folio *folio =3D lru_to_folio(&tmp_contend=
ed_folios);
> > +
> > +                     nr_putback +=3D folio_nr_pages(folio);
> > +                     list_del(&folio->lru);
> > +                     folio_putback_lru(folio);
> > +             }
> > +
> > +             __count_vm_events(PGSCAN_KSHRINKD, nr_reclaimed + nr_putb=
ack);
> > +     }
> > +
> > +     current->flags &=3D ~(PF_MEMALLOC | PF_KSWAPD);
> > +
> > +     return 0;
> > +}
> > +
> > +/*
> > + * This kshrinkd start function will be called by init and node-hot-ad=
d.
> > + */
> > +void kshrinkd_run(int nid)
> > +{
> > +     pg_data_t *pgdat =3D NODE_DATA(nid);
> > +
> > +     if (pgdat->kshrinkd)
> > +             return;
> > +
> > +     pgdat->kshrinkd =3D kthread_run(kshrinkd, pgdat, "kshrinkd%d", ni=
d);
> > +     if (IS_ERR(pgdat->kshrinkd)) {
> > +             /* failure to start kshrinkd */
> > +             WARN_ON_ONCE(system_state < SYSTEM_RUNNING);
> > +             pr_err("Failed to start kshrinkd on node %d\n", nid);
> > +             pgdat->kshrinkd =3D NULL;
> > +     }
> > +}
> > +
> > +/*
> > + * Called by memory hotplug when all memory in a node is offlined.  Ca=
ller must
> > + * be holding mem_hotplug_begin/done().
> > + */
> > +void kshrinkd_stop(int nid)
> > +{
> > +     struct task_struct *kshrinkd =3D NODE_DATA(nid)->kshrinkd;
> > +
> > +     if (kshrinkd) {
> > +             kthread_stop(kshrinkd);
> > +             NODE_DATA(nid)->kshrinkd =3D NULL;
> > +     }
> > +}
> > +
> > +static int __init kshrinkd_init(void)
> > +{
> > +     int nid;
> > +
> > +     for_each_node_state(nid, N_MEMORY) {
> > +             pg_data_t *pgdat =3D NODE_DATA(nid);
> > +
> > +             spin_lock_init(&pgdat->kf_lock);
> > +             init_waitqueue_head(&pgdat->kshrinkd_wait);
> > +             INIT_LIST_HEAD(&pgdat->kshrinkd_folios);
> > +
> > +             kshrinkd_run(nid);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +module_init(kshrinkd_init)
> > +
> >   #ifdef CONFIG_NUMA
> >   /*
> >    * Node reclaim mode
> > @@ -7393,6 +7575,7 @@ static int __node_reclaim(struct pglist_data *pgd=
at, gfp_t gfp_mask, unsigned in
> >               .may_swap =3D 1,
> >               .reclaim_idx =3D gfp_zone(gfp_mask),
> >               .rw_try_lock =3D 1,
> > +             .need_kshrinkd =3D 1,
> >       };
> >       unsigned long pflags;
> >
> > diff --git a/mm/vmstat.c b/mm/vmstat.c
> > index db79935..76d8a3b 100644
> > --- a/mm/vmstat.c
> > +++ b/mm/vmstat.c
> > @@ -1279,9 +1279,11 @@ const char * const vmstat_text[] =3D {
> >
> >       "pgrefill",
> >       "pgreuse",
> > +     "pgsteal_kshrinkd",
> >       "pgsteal_kswapd",
> >       "pgsteal_direct",
> >       "pgsteal_khugepaged",
> > +     "pgscan_kshrinkd",
> >       "pgscan_kswapd",
> >       "pgscan_direct",
> >       "pgscan_khugepaged",
>

Thanks
Barry

