Return-Path: <linux-kernel+bounces-93302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E14F9872DBB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9675A288F4D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2AE15E89;
	Wed,  6 Mar 2024 03:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lKwxgEeS"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F9217BBB
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 03:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709697321; cv=none; b=GjL8klc4hhUVo0Ywbd9bxxoEmSeybTDGehoFvmnRWAo8H5FEVhR8p6rHCr8AQj6t1X79ZNGXeOokCGeADt24Zum1PZldYrQWy+ppERVN2GgbAsfAe4w/s6lqRSxngAfP6/N/ONcFIQtj3jko9wrKmZOi6EM8FZpZjawAJ4kfxug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709697321; c=relaxed/simple;
	bh=BTrWqCpBt6xXl4RCVtxCODrw2kvt0Gq5B9RSeQeMwHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EWtO0WgY2gLQV2O/Ks+IFA3nGAaZGEaOGcnotPOjEx9HI3YCC6mg2HxO/DySnTkEnV5J5ezfZbBe2oSNPkfQq/4XozEGK5HRPsw2SPwx5OX5QIP7BUF2cGCC8DXcT/0ZfOSy5ttvVCnEmg3A30aMBSkVjYw3iqMUA68fz/EqmKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lKwxgEeS; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7da763255b7so2417616241.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 19:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709697318; x=1710302118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uztHPh5m6/k/YQgSozU3xl+sBK6noaMrM17GF/+3NFs=;
        b=lKwxgEeSa2FST2EAdGinq2OfKrbLoBlKSkfOfIk0Q5GSWstbKFfauxkJIncPirG32F
         ROhUbvP9wCCiLdljP1wkFaKIOQ0TjSMNkRaHOkbEvRQxcyUZaF3vaOmcMO75vnhX4fn5
         tO1cAQAYUj60U58i6yvCo/McV0Xojmam6/za7C9GZGJGRr3jL6+Y5+XoLVOMkO5O7I0g
         99hkgI8ymGgGbbPQUhh36Lm1Rwr2QdaE75qMNW/AK2IxOcHkJCBu4N45uewoda1FrkHW
         RsyXkmBAVMOMGSd2A8uuOG/ze4Rwy0lsCUXKCWaB5ecvxb2tE2id/R9lnkjkWof0FrhJ
         HoCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709697318; x=1710302118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uztHPh5m6/k/YQgSozU3xl+sBK6noaMrM17GF/+3NFs=;
        b=v1IOAOicwgmvCZmWKStEJbvzPIGl6vq7hzyr6PCugbmuVCgHev9I5yozZrNgDlOhJP
         0m2QDizfPU7W7pHqQbhwSZUYaPdI4KYakHZ/qkT5TYbi+FOsAiSl1tJeSpik3tbXb0FO
         KUlVhaPbYdk66fPfBzCG8mqdsEQU5pyq/is/nG66pYkAClk4Rc/8w+y4DVx+Epau97Nd
         TRDA2fFsEWe+ir5lyw26EUDA1zwYeW5tnLfu1xp+TXcd95wAnNN8kaFVXir41GHCC0hk
         QyXr2fOcD5TjKZwjyWRJQ2rUf+sxh5QeWruNaFxAaekcZHQTRvGPm3kVUZi/a7j8DfCK
         Gh1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVVHYT6X+wZDD7135rG/Bl6qx71d/I3PXUC2ADRPDzfZ+GQmyFkDjztdYNjM7aeIzuZmmLG7WkDTXFlX3WLIDR6THbInOv9owSHtbg6
X-Gm-Message-State: AOJu0YzgRe/GZGGu5J5CzSvJQJyHIioErArQGe6jczco6S8QvEW/wpqQ
	VhKp4XyX1bFcRIcmST+sktxmtypzUVUu2OdUG0NDTC6+l6ZDJbUHf1MylmKQzPwByoY5VrhIwxC
	LMXdfPyXcKs1ZI1nCx/wIcTT18TwqgkCT/egHvA==
X-Google-Smtp-Source: AGHT+IFL4Fnwe2jyRS6YBPBmNcPht468oprH/h2dgRAKYEKhGBH97gw91noZEOItrRp8dylLlQ8oLiX9iDiaYDigGIw=
X-Received: by 2002:a05:6102:3bcf:b0:472:eca1:46c with SMTP id
 a15-20020a0561023bcf00b00472eca1046cmr721701vsv.30.1709697318414; Tue, 05 Mar
 2024 19:55:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301082248.3456086-1-horenchuang@bytedance.com>
 <20240301082248.3456086-2-horenchuang@bytedance.com> <87jzmibtyh.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAKPbEqrti2x05n5QhXtefhu+C=xmMUaH8mMwDy83LVN3Fj6nDw@mail.gmail.com> <87edco85b4.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87edco85b4.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Date: Tue, 5 Mar 2024 19:55:07 -0800
Message-ID: <CAKPbEqoz8eqH30f_q9v2CiR+3D2xN9K+=NEZ1DcQ0OaR1KMTXA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v1 1/1] memory tier: acpi/hmat: create
 CPUless memory tiers after obtaining HMAT info
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, aneesh.kumar@linux.ibm.com, mhocko@suse.com, 
	tj@kernel.org, john@jagalactic.com, Eishan Mirakhur <emirakhur@micron.com>, 
	Vinicius Tavares Petrucci <vtavarespetr@micron.com>, Ravis OpenSrc <Ravis.OpenSrc@micron.com>, 
	Alistair Popple <apopple@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Dave Jiang <dave.jiang@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	"Ho-Ren (Jack) Chuang" <horenc@vt.edu>, "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, linux-cxl@vger.kernel.org, 
	qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 6:27=E2=80=AFPM Huang, Ying <ying.huang@intel.com> w=
rote:
>
> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:
>
> > On Sun, Mar 3, 2024 at 6:42=E2=80=AFPM Huang, Ying <ying.huang@intel.co=
m> wrote:
> >>
> >> Hi, Jack,
> >>
> >> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:
> >>
> >> > * Introduce `mt_init_with_hmat()`
> >> > We defer memory tier initialization for those CPUless NUMA nodes
> >> > until acquiring HMAT info. `mt_init_with_hmat()` is introduced to
> >> > post-create CPUless memory tiers after obtaining HMAT info.
> >> > It iterates through each CPUless memory node, creating memory tiers =
if
> >> > necessary. Finally, it calculates demotion tables again at the end.
> >> >
> >> > * Introduce `hmat_find_alloc_memory_type()`
> >> > Find or allocate a memory type in the `hmat_memory_types` list.
> >> >
> >> > * Make `set_node_memory_tier()` more generic
> >> > This function can also be used for setting other memory types for a =
node.
> >> > To do so, a new argument is added to specify a memory type.
> >> >
> >> > * Handle cases where there is no HMAT when creating memory tiers
> >> > If no HMAT is specified, it falls back to using `default_dram_type`.
> >> >
> >> > * Change adist calculation code to use another new lock, mt_perf_loc=
k.
> >> > Iterating through CPUlist nodes requires holding the `memory_tier_lo=
ck`.
> >> > However, `mt_calc_adistance()` will end up trying to acquire the sam=
e lock,
> >> > leading to a potential deadlock. Therefore, we propose introducing a
> >> > standalone `mt_perf_lock` to protect `default_dram_perf`. This appro=
ach not
> >> > only avoids deadlock but also prevents holding a large lock simultan=
eously.
> >>
> >> The patch description is used to described why we need the change, and
> >> how we do that, but not what we do.  People can tell what is done from
> >> the code itself.
> >>
> >
> > Got it. Thanks. Will rewrite it after the code is finalized.
> >
> >> > Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> >> > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> >> > ---
> >> >  drivers/acpi/numa/hmat.c     |  3 ++
> >> >  include/linux/memory-tiers.h |  6 +++
> >> >  mm/memory-tiers.c            | 76 ++++++++++++++++++++++++++++++++-=
---
> >> >  3 files changed, 77 insertions(+), 8 deletions(-)
> >> >
> >> > diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> >> > index d6b85f0f6082..9f57338b3cb5 100644
> >> > --- a/drivers/acpi/numa/hmat.c
> >> > +++ b/drivers/acpi/numa/hmat.c
> >> > @@ -1038,6 +1038,9 @@ static __init int hmat_init(void)
> >> >       if (!hmat_set_default_dram_perf())
> >> >               register_mt_adistance_algorithm(&hmat_adist_nb);
> >> >
> >> > +     /* Post-create CPUless memory tiers after getting HMAT info */
> >> > +     mt_init_with_hmat();
> >> > +
> >> >       return 0;
> >> >  out_put:
> >> >       hmat_free_structures();
> >> > diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tie=
rs.h
> >> > index 69e781900082..2f845e90c033 100644
> >> > --- a/include/linux/memory-tiers.h
> >> > +++ b/include/linux/memory-tiers.h
> >> > @@ -48,6 +48,7 @@ int mt_calc_adistance(int node, int *adist);
> >> >  int mt_set_default_dram_perf(int nid, struct access_coordinate *per=
f,
> >> >                            const char *source);
> >> >  int mt_perf_to_adistance(struct access_coordinate *perf, int *adist=
);
> >> > +void mt_init_with_hmat(void);
> >>
> >> HMAT isn't universally available.  It's a driver in fact.  So, don't p=
ut
> >> driver specific code in general code.
> >>
> >
> > Please see below regarding "move code to hmat.c"
> >
> >> >  #ifdef CONFIG_MIGRATION
> >> >  int next_demotion_node(int node);
> >> >  void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets=
);
> >> > @@ -136,5 +137,10 @@ static inline int mt_perf_to_adistance(struct a=
ccess_coordinate *perf, int *adis
> >> >  {
> >> >       return -EIO;
> >> >  }
> >> > +
> >> > +static inline void mt_init_with_hmat(void)
> >> > +{
> >> > +
> >> > +}
> >> >  #endif       /* CONFIG_NUMA */
> >> >  #endif  /* _LINUX_MEMORY_TIERS_H */
> >> > diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> >> > index 0537664620e5..7a0a579b3deb 100644
> >> > --- a/mm/memory-tiers.c
> >> > +++ b/mm/memory-tiers.c
> >> > @@ -35,7 +35,9 @@ struct node_memory_type_map {
> >> >  };
> >> >
> >> >  static DEFINE_MUTEX(memory_tier_lock);
> >> > +static DEFINE_MUTEX(mt_perf_lock);
> >> >  static LIST_HEAD(memory_tiers);
> >> > +static LIST_HEAD(hmat_memory_types);
> >> >  static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
> >> >  struct memory_dev_type *default_dram_type;
> >> >
> >> > @@ -502,7 +504,7 @@ static inline void __init_node_memory_type(int n=
ode, struct memory_dev_type *mem
> >> >       }
> >> >  }
> >> >
> >> > -static struct memory_tier *set_node_memory_tier(int node)
> >> > +static struct memory_tier *set_node_memory_tier(int node, struct me=
mory_dev_type *new_memtype)
> >>
> >> No. memory_dev_type are passed to the function via node_memory_types[n=
ode].memtype.
> >>
> >
> > Got it. Will mimic the way kmem.c does. Thanks.
> >
> >> >  {
> >> >       struct memory_tier *memtier;
> >> >       struct memory_dev_type *memtype;
> >> > @@ -514,7 +516,7 @@ static struct memory_tier *set_node_memory_tier(=
int node)
> >> >       if (!node_state(node, N_MEMORY))
> >> >               return ERR_PTR(-EINVAL);
> >> >
> >> > -     __init_node_memory_type(node, default_dram_type);
> >> > +     __init_node_memory_type(node, new_memtype);
> >> >
> >> >       memtype =3D node_memory_types[node].memtype;
> >> >       node_set(node, memtype->nodes);
> >> > @@ -623,6 +625,56 @@ void clear_node_memory_type(int node, struct me=
mory_dev_type *memtype)
> >> >  }
> >> >  EXPORT_SYMBOL_GPL(clear_node_memory_type);
> >> >
> >> > +static struct memory_dev_type *hmat_find_alloc_memory_type(int adis=
t)
> >>
> >> Similar function existed in drivers/dax/kmem.c.  Please abstract them
> >> and move them here.
> >>
> >
> > Got it. Will try. Thanks.
> >
> >> > +{
> >> > +     bool found =3D false;
> >> > +     struct memory_dev_type *mtype;
> >> > +
> >> > +     list_for_each_entry(mtype, &hmat_memory_types, list) {
> >> > +             if (mtype->adistance =3D=3D adist) {
> >> > +                     found =3D true;
> >> > +                     break;
> >> > +             }
> >> > +     }
> >> > +     if (!found) {
> >> > +             mtype =3D alloc_memory_type(adist);
> >> > +             if (!IS_ERR(mtype))
> >> > +                     list_add(&mtype->list, &hmat_memory_types);
> >> > +     }
> >> > +     return mtype;
> >> > +}
> >> > +
> >> > +static void mt_create_with_hmat(int node)
> >> > +{
> >> > +     struct memory_dev_type *mtype =3D NULL;
> >> > +     int adist =3D MEMTIER_ADISTANCE_DRAM;
> >> > +
> >> > +     mt_calc_adistance(node, &adist);
> >> > +     if (adist !=3D MEMTIER_ADISTANCE_DRAM) {
> >> > +             mtype =3D hmat_find_alloc_memory_type(adist);
> >> > +             if (IS_ERR(mtype))
> >> > +                     pr_err("%s() failed to allocate a tier\n", __f=
unc__);
> >> > +     } else {
> >> > +             mtype =3D default_dram_type;
> >> > +     }
> >> > +
> >> > +     set_node_memory_tier(node, mtype);
> >> > +}
> >> > +
> >> > +void mt_init_with_hmat(void)
> >> > +{
> >> > +     int nid;
> >> > +
> >> > +     mutex_lock(&memory_tier_lock);
> >> > +     for_each_node_state(nid, N_MEMORY)
> >> > +             if (!node_state(nid, N_CPU))
> >> > +                     mt_create_with_hmat(nid);
> >> > +
> >> > +     establish_demotion_targets();
> >> > +     mutex_unlock(&memory_tier_lock);
> >> > +}
> >> > +EXPORT_SYMBOL_GPL(mt_init_with_hmat);
> >> > +
> >>
> >> I guess that we can put most hmat related code above in hmat.c.
> >>
> >
> > To put the heat-related code to hmat.c I will need to export some
> > static functions in memory-tiers.c, like set_node_memory_tier() and
> > establish_demotion_targets(). Is that ok?
>
> Think about this again.  In fact, although there are "_hmat" in the name
> of the above functions, the code has nothing to do with hmat.  So, we
> should rename these functions, but don't need to move them to hmat.c.
> And, to set memory_tier for CPUless node on system without HMAT.  We
> should call mt_init_with_hmat() with late_initcall().  Where HMAT
> information is expected to be available on system with HMAT.  On system
> without HMAT, default_dram_type will be used.
>

Sounds good and thank you! I'm working on v2 according to the feedback.

> >> >  static void dump_hmem_attrs(struct access_coordinate *coord, const =
char *prefix)
> >> >  {
> >> >       pr_info(
> >> > @@ -636,7 +688,7 @@ int mt_set_default_dram_perf(int nid, struct acc=
ess_coordinate *perf,
> >> >  {
> >> >       int rc =3D 0;
> >> >
> >> > -     mutex_lock(&memory_tier_lock);
> >> > +     mutex_lock(&mt_perf_lock);
> >> >       if (default_dram_perf_error) {
> >> >               rc =3D -EIO;
> >> >               goto out;
> >> > @@ -684,7 +736,7 @@ int mt_set_default_dram_perf(int nid, struct acc=
ess_coordinate *perf,
> >> >       }
> >> >
> >> >  out:
> >> > -     mutex_unlock(&memory_tier_lock);
> >> > +     mutex_unlock(&mt_perf_lock);
> >> >       return rc;
> >> >  }
> >> >
> >> > @@ -700,7 +752,7 @@ int mt_perf_to_adistance(struct access_coordinat=
e *perf, int *adist)
> >> >           perf->read_bandwidth + perf->write_bandwidth =3D=3D 0)
> >> >               return -EINVAL;
> >> >
> >> > -     mutex_lock(&memory_tier_lock);
> >> > +     mutex_lock(&mt_perf_lock);
> >> >       /*
> >> >        * The abstract distance of a memory node is in direct proport=
ion to
> >> >        * its memory latency (read + write) and inversely proportiona=
l to its
> >> > @@ -713,7 +765,7 @@ int mt_perf_to_adistance(struct access_coordinat=
e *perf, int *adist)
> >> >               (default_dram_perf.read_latency + default_dram_perf.wr=
ite_latency) *
> >> >               (default_dram_perf.read_bandwidth + default_dram_perf.=
write_bandwidth) /
> >> >               (perf->read_bandwidth + perf->write_bandwidth);
> >> > -     mutex_unlock(&memory_tier_lock);
> >> > +     mutex_unlock(&mt_perf_lock);
> >> >
> >> >       return 0;
> >> >  }
> >> > @@ -797,7 +849,7 @@ static int __meminit memtier_hotplug_callback(st=
ruct notifier_block *self,
> >> >               break;
> >> >       case MEM_ONLINE:
> >> >               mutex_lock(&memory_tier_lock);
> >> > -             memtier =3D set_node_memory_tier(arg->status_change_ni=
d);
> >> > +             memtier =3D set_node_memory_tier(arg->status_change_ni=
d, default_dram_type);
> >> >               if (!IS_ERR(memtier))
> >> >                       establish_demotion_targets();
> >> >               mutex_unlock(&memory_tier_lock);
> >> > @@ -836,7 +888,15 @@ static int __init memory_tier_init(void)
> >> >        * types assigned.
> >> >        */
> >> >       for_each_node_state(node, N_MEMORY) {
> >> > -             memtier =3D set_node_memory_tier(node);
> >> > +             if (!node_state(node, N_CPU))
> >> > +                     /*
> >> > +                      * Defer memory tier initialization on CPUless=
 numa nodes.
> >> > +                      * These will be initialized when HMAT informa=
tion is
> >> > +                      * available.
> >> > +                      */
> >> > +                     continue;
> >> > +
> >> > +             memtier =3D set_node_memory_tier(node, default_dram_ty=
pe);
> >>
> >> On system with HMAT, how to fall back CPU-less node to
> >> default_dram_type?  I found your description, but I don't find it in c=
ode.
> >>
> > I assume you meant without HMAT, if so,
> > because if no HMAT, adist will not be updated in mt_calc_adistance():
>
> Sorry, typo.  On system with HMAT, mt_init_with_hmat() will not be
> called.  I have a solution in above comment.
>
> --
> Best Regards,
> Huang, Ying
>
> > + int adist =3D MEMTIER_ADISTANCE_DRAM;
> > +
> > + mt_calc_adistance(node, &adist);
> > + if (adist !=3D MEMTIER_ADISTANCE_DRAM) {
> > =E2=80=A6
> > + } else {
> > + mtype =3D default_dram_type;
> > + }
> > +
> > + set_node_memory_tier(node, mtype);
> >
> >> >               if (IS_ERR(memtier))
> >> >                       /*
> >> >                        * Continue with memtiers we are able to setup
> >>
> >> --
> >> Best Regards,
> >> Huang, Ying



--=20
Best regards,
Ho-Ren (Jack) Chuang
=E8=8E=8A=E8=B3=80=E4=BB=BB

