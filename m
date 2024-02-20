Return-Path: <linux-kernel+bounces-72240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BBC85B111
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74DC31F23E2C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A69F535C6;
	Tue, 20 Feb 2024 03:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKfjy/HA"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EF65336A
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 03:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708398114; cv=none; b=rd9/1nHLJ+ZdIip933OQ8emgoosfJoEHJz7PfBQohSfa5ytT7Fj+thBYN35UA0jWvAx2Mys/LPV/5GCiz98CuOu7xRFP/K5c/tbAso3TZKgTz2kLKK+FKm/1OSi43pUIpF9/j8XhIM+7fhpJmKHSYQl+0wDesqPXqDqslqVB0/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708398114; c=relaxed/simple;
	bh=/fGoHl+wvbboJ6cKr1BSk0UzOuTPrznxXMBxZpI0V8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OVulK9EHYiYAThuLtuNH7oJu7IbGDDZpyEDE6UXUqMHu6fD+lfDQrLl/p+iCmSY5LHmicHzZUWBfy4oPWVITYFC/ub7z0DhjiWT3wD7nBtlCIJupLIKJr8inG553DAiNDZKGT0g9V6h8PP0Oz0yiBQvOjoDBhikKpwOaWPpoSfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKfjy/HA; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7d2e21181c1so2854743241.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 19:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708398111; x=1709002911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y66Uu0L9O2M583eyfIYziFcin5JisLal4BOoDFZYuwE=;
        b=aKfjy/HAMmSQ5LMxUS/4f8tPa3J8wbeg3qH14uDjchP2a71jgDmS/rBg+IE/sIzjvl
         uFJWcdE6kNgwfNCwkDy0AAa8kJIUKzcO2km36MU1nJkxSU2wTLdnqtlmvAdNzAK/0y//
         Qh2KSU+8nWwiYDM2BimEfmhK9gfLacpX/ZInKO28i8Ks1J4hj7iztSrG88BVJXMQGjIb
         GAE70UxAZHC6s5gw3rFPMn4y5EZ8G8DNXOsq/pJc2c3wfBwr5gafGXPkoZxDXZZvPe1F
         5VzU6yC3JI9UW7ckfvNnms3om/23w+gouifXGlC+b0ZadVIi811wsDb9XZb2Hghq3jaI
         Pl8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708398111; x=1709002911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y66Uu0L9O2M583eyfIYziFcin5JisLal4BOoDFZYuwE=;
        b=YMVjl/QqGKRcvY3/YTIu+qnoO0zhLcAMpIOars8Y8yvzdVuRjoj/IquSxH69KXgfmS
         QWvMH1K5rLNsnldZ9uDsRWlC/L1VaWbo4iZC5Sw5hYOzuxiMxGAeJ5jJWoT8Yx4FhQTu
         q+LWyJwYjn+MtfiaN1j4I2oLYKyb88JHDM2/ZUTaA7khj14E0i8yroMzaQebGVwukPTr
         i84bTE+1aHmuUvowVBFbfoOQUGkNn1jkIySY9h3CUzLwwVVjwit3eSp0GFEpi/11g2g3
         vOptw4PYxt3QwJVfB1UkJOaipD3bCTw/eM3teFtEtUQXeJGECMejOihCv5R9fPnfB5iW
         1bAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlmOsYlUMR/c8j3T+gOKq8flHBWHfTS3dWD8T6MPdt7RwpsD147B0NyzFRz0Q/S3IxApkqn2Rc+xJjfDKIAt3fRkH03yBFX5k+Ltuj
X-Gm-Message-State: AOJu0YxCSsykTteEYvOvSVXAw5958/GHCjSeiyd94Sq2xFSZIavLH+/h
	rJeehkUQCJ0hkkhSk33NFXlGNysB6wFa+nzBd6pnhM8qZVRaQgJl3Z5qkkoQQlX5S9/7/ZF+RU7
	A8AMtSJo+J4q54+5Fu0wCc++g8SY=
X-Google-Smtp-Source: AGHT+IG88cOzpPBAW8aqmCZS2AijUIQIphw7bSMYdGM9rtBuEiBeQlUNDJlOPGWsTl8cRz6C2wl7QifWCCZ3RH0jBSE=
X-Received: by 2002:a1f:d403:0:b0:4cb:56c5:5818 with SMTP id
 l3-20020a1fd403000000b004cb56c55818mr4486715vkg.3.1708398111548; Mon, 19 Feb
 2024 19:01:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219141703.3851-1-lipeifeng@oppo.com> <20240219141703.3851-2-lipeifeng@oppo.com>
 <7c648dac-3198-3dba-0a96-34798cfdbd99@oppo.com>
In-Reply-To: <7c648dac-3198-3dba-0a96-34798cfdbd99@oppo.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 20 Feb 2024 16:01:40 +1300
Message-ID: <CAGsJ_4xPDUgcYxNu230QC--ZiKV71nJJ+v0LVR7yF1io+TiLdA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/rmap: support folio_referenced to control if
 try_lock in rmap_walk
To: =?UTF-8?B?5p2O5Z+56ZSL?= <lipeifeng@oppo.com>
Cc: akpm@linux-foundation.org, david@redhat.com, osalvador@suse.de, 
	willy@infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	tkjos@google.com, surenb@google.com, gregkh@google.com, v-songbaohua@oppo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi peifeng,

On Tue, Feb 20, 2024 at 2:43=E2=80=AFPM =E6=9D=8E=E5=9F=B9=E9=94=8B <lipeif=
eng@oppo.com> wrote:
>
> add more experts from Linux and Google.
>
>
> =E5=9C=A8 2024/2/19 22:17, lipeifeng@oppo.com =E5=86=99=E9=81=93:
> > From: lipeifeng <lipeifeng@oppo.com>
> >
> > The patch to support folio_referenced to control the bevavior
> > of walk_rmap, which for some thread to hold the lock in rmap_walk
> > instead of try_lock when using folio_referenced.

please describe what problem the patch is trying to address,
and why this modification is needed in commit message.

btw, who is set rw_try_lock to 0, what is the benefit?

> >
> > Signed-off-by: lipeifeng <lipeifeng@oppo.com>
> > ---
> >   include/linux/rmap.h |  5 +++--
> >   mm/rmap.c            |  5 +++--
> >   mm/vmscan.c          | 16 ++++++++++++++--
> >   3 files changed, 20 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> > index b7944a8..846b261 100644
> > --- a/include/linux/rmap.h
> > +++ b/include/linux/rmap.h
> > @@ -623,7 +623,8 @@ static inline int folio_try_share_anon_rmap_pmd(str=
uct folio *folio,
> >    * Called from mm/vmscan.c to handle paging out
> >    */
> >   int folio_referenced(struct folio *, int is_locked,
> > -                     struct mem_cgroup *memcg, unsigned long *vm_flags=
);
> > +                     struct mem_cgroup *memcg, unsigned long *vm_flags=
,
> > +                     unsigned int rw_try_lock);
> >
> >   void try_to_migrate(struct folio *folio, enum ttu_flags flags);
> >   void try_to_unmap(struct folio *, enum ttu_flags flags);
> > @@ -739,7 +740,7 @@ struct anon_vma *folio_lock_anon_vma_read(struct fo=
lio *folio,
> >
> >   static inline int folio_referenced(struct folio *folio, int is_locked=
,
> >                                 struct mem_cgroup *memcg,
> > -                               unsigned long *vm_flags)
> > +                               unsigned long *vm_flags, unsigned int r=
w_try_lock)
> >   {
> >       *vm_flags =3D 0;
> >       return 0;
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index f5d43ed..15d1fba 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -952,6 +952,7 @@ static bool invalid_folio_referenced_vma(struct vm_=
area_struct *vma, void *arg)
> >    * @is_locked: Caller holds lock on the folio.
> >    * @memcg: target memory cgroup
> >    * @vm_flags: A combination of all the vma->vm_flags which referenced=
 the folio.
> > + * @rw_try_lock: if try_lock in rmap_walk
> >    *
> >    * Quick test_and_clear_referenced for all mappings of a folio,
> >    *
> > @@ -959,7 +960,7 @@ static bool invalid_folio_referenced_vma(struct vm_=
area_struct *vma, void *arg)
> >    * the function bailed out due to rmap lock contention.
> >    */
> >   int folio_referenced(struct folio *folio, int is_locked,
> > -                  struct mem_cgroup *memcg, unsigned long *vm_flags)
> > +                  struct mem_cgroup *memcg, unsigned long *vm_flags, u=
nsigned int rw_try_lock)
> >   {
> >       int we_locked =3D 0;
> >       struct folio_referenced_arg pra =3D {
> > @@ -970,7 +971,7 @@ int folio_referenced(struct folio *folio, int is_lo=
cked,
> >               .rmap_one =3D folio_referenced_one,
> >               .arg =3D (void *)&pra,
> >               .anon_lock =3D folio_lock_anon_vma_read,
> > -             .try_lock =3D true,
> > +             .try_lock =3D rw_try_lock ? true : false,
> >               .invalid_vma =3D invalid_folio_referenced_vma,
> >       };
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 4f9c854..0296d48 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -136,6 +136,9 @@ struct scan_control {
> >       /* Always discard instead of demoting to lower tier memory */
> >       unsigned int no_demotion:1;
> >
> > +     /* if try_lock in rmap_walk */
> > +     unsigned int rw_try_lock:1;
> > +
> >       /* Allocation order */
> >       s8 order;
> >
> > @@ -827,7 +830,7 @@ static enum folio_references folio_check_references=
(struct folio *folio,
> >       unsigned long vm_flags;
> >
> >       referenced_ptes =3D folio_referenced(folio, 1, sc->target_mem_cgr=
oup,
> > -                                        &vm_flags);
> > +                                        &vm_flags, sc->rw_try_lock);
> >       referenced_folio =3D folio_test_clear_referenced(folio);
> >
> >       /*
> > @@ -1501,6 +1504,7 @@ unsigned int reclaim_clean_pages_from_list(struct=
 zone *zone,
> >       struct scan_control sc =3D {
> >               .gfp_mask =3D GFP_KERNEL,
> >               .may_unmap =3D 1,
> > +             .rw_try_lock =3D 1,
> >       };
> >       struct reclaim_stat stat;
> >       unsigned int nr_reclaimed;
> > @@ -2038,7 +2042,7 @@ static void shrink_active_list(unsigned long nr_t=
o_scan,
> >
> >               /* Referenced or rmap lock contention: rotate */
> >               if (folio_referenced(folio, 0, sc->target_mem_cgroup,
> > -                                  &vm_flags) !=3D 0) {
> > +                                  &vm_flags, sc->rw_try_lock) !=3D 0) =
{
> >                       /*
> >                        * Identify referenced, file-backed active folios=
 and
> >                        * give them one more trip around the active list=
 So
> > @@ -2096,6 +2100,7 @@ static unsigned int reclaim_folio_list(struct lis=
t_head *folio_list,
> >               .may_unmap =3D 1,
> >               .may_swap =3D 1,
> >               .no_demotion =3D 1,
> > +             .rw_try_lock =3D 1,
> >       };
> >
> >       nr_reclaimed =3D shrink_folio_list(folio_list, pgdat, &sc, &dummy=
_stat, false);
> > @@ -5442,6 +5447,7 @@ static ssize_t lru_gen_seq_write(struct file *fil=
e, const char __user *src,
> >               .may_swap =3D true,
> >               .reclaim_idx =3D MAX_NR_ZONES - 1,
> >               .gfp_mask =3D GFP_KERNEL,
> > +             .rw_try_lock =3D 1,
> >       };
> >
> >       buf =3D kvmalloc(len + 1, GFP_KERNEL);
> > @@ -6414,6 +6420,7 @@ unsigned long try_to_free_pages(struct zonelist *=
zonelist, int order,
> >               .may_writepage =3D !laptop_mode,
> >               .may_unmap =3D 1,
> >               .may_swap =3D 1,
> > +             .rw_try_lock =3D 1,
> >       };
> >
> >       /*
> > @@ -6459,6 +6466,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_c=
group *memcg,
> >               .may_unmap =3D 1,
> >               .reclaim_idx =3D MAX_NR_ZONES - 1,
> >               .may_swap =3D !noswap,
> > +             .rw_try_lock =3D 1,
> >       };
> >
> >       WARN_ON_ONCE(!current->reclaim_state);
> > @@ -6503,6 +6511,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct=
 mem_cgroup *memcg,
> >               .may_unmap =3D 1,
> >               .may_swap =3D !!(reclaim_options & MEMCG_RECLAIM_MAY_SWAP=
),
> >               .proactive =3D !!(reclaim_options & MEMCG_RECLAIM_PROACTI=
VE),
> > +             .rw_try_lock =3D 1,
> >       };
> >       /*
> >        * Traverse the ZONELIST_FALLBACK zonelist of the current node to=
 put
> > @@ -6764,6 +6773,7 @@ static int balance_pgdat(pg_data_t *pgdat, int or=
der, int highest_zoneidx)
> >               .gfp_mask =3D GFP_KERNEL,
> >               .order =3D order,
> >               .may_unmap =3D 1,
> > +             .rw_try_lock =3D 1,
> >       };
> >
> >       set_task_reclaim_state(current, &sc.reclaim_state);
> > @@ -7223,6 +7233,7 @@ unsigned long shrink_all_memory(unsigned long nr_=
to_reclaim)
> >               .may_unmap =3D 1,
> >               .may_swap =3D 1,
> >               .hibernation_mode =3D 1,
> > +             .rw_try_lock =3D 1,
> >       };
> >       struct zonelist *zonelist =3D node_zonelist(numa_node_id(), sc.gf=
p_mask);
> >       unsigned long nr_reclaimed;
> > @@ -7381,6 +7392,7 @@ static int __node_reclaim(struct pglist_data *pgd=
at, gfp_t gfp_mask, unsigned in
> >               .may_unmap =3D !!(node_reclaim_mode & RECLAIM_UNMAP),
> >               .may_swap =3D 1,
> >               .reclaim_idx =3D gfp_zone(gfp_mask),
> > +             .rw_try_lock =3D 1,
> >       };
> >       unsigned long pflags;
> >
Thanks
Barry

