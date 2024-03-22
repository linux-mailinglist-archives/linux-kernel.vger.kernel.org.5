Return-Path: <linux-kernel+bounces-111940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7CF887309
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C619A283F09
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FA4664B9;
	Fri, 22 Mar 2024 18:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WicWAtzt"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B044664B0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 18:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711132008; cv=none; b=ZwClWzFcsQAUr4YAAt3hNPVHwKdXB3faC86n/vf02Ql5uppGPl9qIJDJWdl36RpgPcHrgEIZdQL0vsYb4TKGloAAthurYTfVST54RvJS0aF2GUt/2gBeuNiNQwJTHNV0wbMGjTbLW0e6WEb4IZHT0Xl9QCX4vus328vgMbQ2Gn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711132008; c=relaxed/simple;
	bh=2UWRAO+qrTu/3BV0Nq41o8Nzm8B2jFhdWpIkD1h0YWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mLZm4x3TPIFD5gLwvZnw06N7J5w6ReOWPiVsm+maJvA4HPLUbj4X41LS/DW4sL39ErA7vp7lhLlD7KWsOpfGFxeaM+XVFk8xjLo37NU3IW3lZSsR4ZFuPL0cAJ6FJe3o/X0Ds/SiqnxE0FDpMKs7VwsZ7om1B3+21BQ6CWhaRxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WicWAtzt; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dcc7cdb3a98so2497490276.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 11:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711132004; x=1711736804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6AUICcSJg/mLbMOQlQg8ZPtye+1Y8JCvK5pGCwWXtOo=;
        b=WicWAtztFdOjZYxgaZgjZnxg8XVizOUJCANZ2/Kzm51S/RZGRjgj8b0VQe773+6CwL
         p6D84eRWyvvIddKBBgwSR6KyCUiMY/Pg4I2fTbTC5jKlJXKIGG7vHIFzeDSBksk8FCtb
         7f6UBATM1heek8+JSGIyXgSH9rig5DpLsmgIYP2XQ+XyO9uQZMO0FOaFF222PhkBiPPB
         U9ZdMmpKdZtspkC5iXs0Dur9rmEfZhkx7fk16bg239jcxEk025OUcJ67I4osqbvDD6KN
         i3qxV13RAfq3sWcM9GsCfRBTpI/HE+VlaWfejLaUeuqtn/6lvIY8/eJeBZSf9xlEVOHd
         0UVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711132004; x=1711736804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6AUICcSJg/mLbMOQlQg8ZPtye+1Y8JCvK5pGCwWXtOo=;
        b=I9sYkVBCE1hwEWyDJ4qBdbnuNuu0OVcxE4OFKdyXxqsov32oQyOiARY6gp3yhrtzSX
         Ao+dE74JEYEaC/0gfK0d6+UD4ZjnhUWHZXINqj5SLPFkhwA4hLLN2wVnn3E9K81cjMmP
         eJgp7fPwThawaCV0YpX7qqvhIa0TEXRHlEQculRJvZZgVbv/agNb5sCvafV7o0gxT0mx
         JPk+bUoyFN1K+swA5oERr6nc1Wnrm6UZ0cmYhMU2O0pPHCytaU5WqRp0agdMHALZAm2O
         +soHJdoSCMpP34rmUWVUQxt6kx/4K8xL0WzTlyz/46fHjniGegcB16PqqKH3mJ3mZRqq
         ybig==
X-Forwarded-Encrypted: i=1; AJvYcCWECQZ74iwaNpRsVXV9U08jUnNpFVHLHy1Rkj1q1wUCiXhf0aItmfxLmPE0O/a8IGvwYmLhzFpougTCAwePSOHAiPucwOl1fpszr/ia
X-Gm-Message-State: AOJu0YwqnJAPIckFs2I3c5rzqXeHSmn2zSI04SSJtj19iV5Vvf7KQtgb
	XG0UiXdYqUfmlCgHbm1aHjT+SX/3O6VSjaaYZwY5kBEyKzc4N++5jt4Yp6dZjt8hMUVO7IwzDQK
	6Ctith8mVB9+AQXNA6AStvdXaypviODiL9iUpWg==
X-Google-Smtp-Source: AGHT+IFq+Vld2u9CEv92mxcPdGGVK+HlqojAbAarhNNW8pq520kH61lUaodFCsAExfRXZuH3hgY+ToVYiDIEhie12xw=
X-Received: by 2002:a25:5303:0:b0:dda:a550:4e92 with SMTP id
 h3-20020a255303000000b00ddaa5504e92mr161782ybb.46.1711132004008; Fri, 22 Mar
 2024 11:26:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322070356.315922-1-horenchuang@bytedance.com>
 <20240322070356.315922-3-horenchuang@bytedance.com> <87cyrmr773.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87cyrmr773.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Date: Fri, 22 Mar 2024 11:26:33 -0700
Message-ID: <CAKPbEqptUKhDdH0ke7PuFShTBFm-Y=NWDtMOWCXBQBe-mac88w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v4 2/2] memory tier: create CPUless memory
 tiers after obtaining HMAT info
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, aneesh.kumar@linux.ibm.com, mhocko@suse.com, 
	tj@kernel.org, john@jagalactic.com, Eishan Mirakhur <emirakhur@micron.com>, 
	Vinicius Tavares Petrucci <vtavarespetr@micron.com>, Ravis OpenSrc <Ravis.OpenSrc@micron.com>, 
	Alistair Popple <apopple@nvidia.com>, Srinivasulu Thanneeru <sthanneeru@micron.com>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	"Ho-Ren (Jack) Chuang" <horenc@vt.edu>, "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, qemu-devel@nongnu.org, 
	Hao Xiang <hao.xiang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 1:41=E2=80=AFAM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:
>
> > The current implementation treats emulated memory devices, such as
> > CXL1.1 type3 memory, as normal DRAM when they are emulated as normal me=
mory
> > (E820_TYPE_RAM). However, these emulated devices have different
> > characteristics than traditional DRAM, making it important to
> > distinguish them. Thus, we modify the tiered memory initialization proc=
ess
> > to introduce a delay specifically for CPUless NUMA nodes. This delay
> > ensures that the memory tier initialization for these nodes is deferred
> > until HMAT information is obtained during the boot process. Finally,
> > demotion tables are recalculated at the end.
> >
> > * late_initcall(memory_tier_late_init);
> > Some device drivers may have initialized memory tiers between
> > `memory_tier_init()` and `memory_tier_late_init()`, potentially bringin=
g
> > online memory nodes and configuring memory tiers. They should be exclud=
ed
> > in the late init.
> >
> > * Handle cases where there is no HMAT when creating memory tiers
> > There is a scenario where a CPUless node does not provide HMAT informat=
ion.
> > If no HMAT is specified, it falls back to using the default DRAM tier.
> >
> > * Introduce another new lock `default_dram_perf_lock` for adist calcula=
tion
> > In the current implementation, iterating through CPUlist nodes requires
> > holding the `memory_tier_lock`. However, `mt_calc_adistance()` will end=
 up
> > trying to acquire the same lock, leading to a potential deadlock.
> > Therefore, we propose introducing a standalone `default_dram_perf_lock`=
 to
> > protect `default_dram_perf_*`. This approach not only avoids deadlock
> > but also prevents holding a large lock simultaneously.
> >
> > * Upgrade `set_node_memory_tier` to support additional cases, including
> >   default DRAM, late CPUless, and hot-plugged initializations.
> > To cover hot-plugged memory nodes, `mt_calc_adistance()` and
> > `mt_find_alloc_memory_type()` are moved into `set_node_memory_tier()` t=
o
> > handle cases where memtype is not initialized and where HMAT informatio=
n is
> > available.
> >
> > * Introduce `default_memory_types` for those memory types that are not
> >   initialized by device drivers.
> > Because late initialized memory and default DRAM memory need to be mana=
ged,
> > a default memory type is created for storing all memory types that are
> > not initialized by device drivers and as a fallback.
> >
> > Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> > ---
> >  mm/memory-tiers.c | 73 ++++++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 63 insertions(+), 10 deletions(-)
> >
> > diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> > index 974af10cfdd8..9396330fa162 100644
> > --- a/mm/memory-tiers.c
> > +++ b/mm/memory-tiers.c
> > @@ -36,6 +36,11 @@ struct node_memory_type_map {
> >
> >  static DEFINE_MUTEX(memory_tier_lock);
> >  static LIST_HEAD(memory_tiers);
> > +/*
> > + * The list is used to store all memory types that are not created
> > + * by a device driver.
> > + */
> > +static LIST_HEAD(default_memory_types);
> >  static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
> >  struct memory_dev_type *default_dram_type;
> >
> > @@ -108,6 +113,7 @@ static struct demotion_nodes *node_demotion __read_=
mostly;
> >
> >  static BLOCKING_NOTIFIER_HEAD(mt_adistance_algorithms);
> >
> > +static DEFINE_MUTEX(default_dram_perf_lock);
>
> Better to add comments about what is protected by this lock.
>

Thank you. I will add a comment like this:
+ /* The lock is used to protect `default_dram_perf*` info and nid. */
+static DEFINE_MUTEX(default_dram_perf_lock);

I also found an error path was not handled and
found the lock could be put closer to what it protects.
I will have them fixed in V5.

> >  static bool default_dram_perf_error;
> >  static struct access_coordinate default_dram_perf;
> >  static int default_dram_perf_ref_nid =3D NUMA_NO_NODE;
> > @@ -505,7 +511,8 @@ static inline void __init_node_memory_type(int node=
, struct memory_dev_type *mem
> >  static struct memory_tier *set_node_memory_tier(int node)
> >  {
> >       struct memory_tier *memtier;
> > -     struct memory_dev_type *memtype;
> > +     struct memory_dev_type *mtype;
>
> mtype may be referenced without initialization now below.
>

Good catch! Thank you.

Please check below.
I may found a potential NULL pointer dereference.

> > +     int adist =3D MEMTIER_ADISTANCE_DRAM;
> >       pg_data_t *pgdat =3D NODE_DATA(node);
> >
> >
> > @@ -514,11 +521,20 @@ static struct memory_tier *set_node_memory_tier(i=
nt node)
> >       if (!node_state(node, N_MEMORY))
> >               return ERR_PTR(-EINVAL);
> >
> > -     __init_node_memory_type(node, default_dram_type);
> > +     mt_calc_adistance(node, &adist);
> > +     if (node_memory_types[node].memtype =3D=3D NULL) {
> > +             mtype =3D mt_find_alloc_memory_type(adist, &default_memor=
y_types);
> > +             if (IS_ERR(mtype)) {
> > +                     mtype =3D default_dram_type;
> > +                     pr_info("Failed to allocate a memory type. Fall b=
ack.\n");
> > +             }
> > +     }
> >
> > -     memtype =3D node_memory_types[node].memtype;
> > -     node_set(node, memtype->nodes);
> > -     memtier =3D find_create_memory_tier(memtype);
> > +     __init_node_memory_type(node, mtype);
> > +
> > +     mtype =3D node_memory_types[node].memtype;
> > +     node_set(node, mtype->nodes);

If the `mtype` could be NULL, would there be a potential
NULL pointer dereference. Do you have a preferred idea
to fix this if needed?

> > +     memtier =3D find_create_memory_tier(mtype);
> >       if (!IS_ERR(memtier))
> >               rcu_assign_pointer(pgdat->memtier, memtier);
> >       return memtier;
> > @@ -655,6 +671,34 @@ void mt_put_memory_types(struct list_head *memory_=
types)
> >  }
> >  EXPORT_SYMBOL_GPL(mt_put_memory_types);
> >
> > +/*
> > + * This is invoked via `late_initcall()` to initialize memory tiers fo=
r
> > + * CPU-less memory nodes after driver initialization, which is
> > + * expected to provide `adistance` algorithms.
> > + */
> > +static int __init memory_tier_late_init(void)
> > +{
> > +     int nid;
> > +
> > +     mutex_lock(&memory_tier_lock);
> > +     for_each_node_state(nid, N_MEMORY)
> > +             if (!node_state(nid, N_CPU) &&
> > +                     node_memory_types[nid].memtype =3D=3D NULL)
> > +                     /*
> > +                      * Some device drivers may have initialized memor=
y tiers
> > +                      * between `memory_tier_init()` and `memory_tier_=
late_init()`,
> > +                      * potentially bringing online memory nodes and
> > +                      * configuring memory tiers. Exclude them here.
> > +                      */
> > +                     set_node_memory_tier(nid);
> > +
> > +     establish_demotion_targets();
> > +     mutex_unlock(&memory_tier_lock);
> > +
> > +     return 0;
> > +}
> > +late_initcall(memory_tier_late_init);
> > +
> >  static void dump_hmem_attrs(struct access_coordinate *coord, const cha=
r *prefix)
> >  {
> >       pr_info(
> > @@ -668,7 +712,7 @@ int mt_set_default_dram_perf(int nid, struct access=
_coordinate *perf,
> >  {
> >       int rc =3D 0;
> >
> > -     mutex_lock(&memory_tier_lock);
> > +     mutex_lock(&default_dram_perf_lock);
> >       if (default_dram_perf_error) {
> >               rc =3D -EIO;
> >               goto out;
> > @@ -716,7 +760,7 @@ int mt_set_default_dram_perf(int nid, struct access=
_coordinate *perf,
> >       }
> >
> >  out:
> > -     mutex_unlock(&memory_tier_lock);
> > +     mutex_unlock(&default_dram_perf_lock);
> >       return rc;
> >  }
> >
> > @@ -732,7 +776,7 @@ int mt_perf_to_adistance(struct access_coordinate *=
perf, int *adist)
> >           perf->read_bandwidth + perf->write_bandwidth =3D=3D 0)
> >               return -EINVAL;
> >
> > -     mutex_lock(&memory_tier_lock);
> > +     mutex_lock(&default_dram_perf_lock);
> >       /*
> >        * The abstract distance of a memory node is in direct proportion=
 to
> >        * its memory latency (read + write) and inversely proportional t=
o its
> > @@ -745,7 +789,7 @@ int mt_perf_to_adistance(struct access_coordinate *=
perf, int *adist)
> >               (default_dram_perf.read_latency + default_dram_perf.write=
_latency) *
> >               (default_dram_perf.read_bandwidth + default_dram_perf.wri=
te_bandwidth) /
> >               (perf->read_bandwidth + perf->write_bandwidth);
> > -     mutex_unlock(&memory_tier_lock);
> > +     mutex_unlock(&default_dram_perf_lock);
> >
> >       return 0;
> >  }
> > @@ -858,7 +902,8 @@ static int __init memory_tier_init(void)
> >        * For now we can have 4 faster memory tiers with smaller adistan=
ce
> >        * than default DRAM tier.
> >        */
> > -     default_dram_type =3D alloc_memory_type(MEMTIER_ADISTANCE_DRAM);
> > +     default_dram_type =3D mt_find_alloc_memory_type(MEMTIER_ADISTANCE=
_DRAM,
> > +                                                                     &=
default_memory_types);
> >       if (IS_ERR(default_dram_type))
> >               panic("%s() failed to allocate default DRAM tier\n", __fu=
nc__);
> >
> > @@ -868,6 +913,14 @@ static int __init memory_tier_init(void)
> >        * types assigned.
> >        */
> >       for_each_node_state(node, N_MEMORY) {
> > +             if (!node_state(node, N_CPU))
> > +                     /*
> > +                      * Defer memory tier initialization on CPUless nu=
ma nodes.
> > +                      * These will be initialized after firmware and d=
evices are
> > +                      * initialized.
> > +                      */
> > +                     continue;
> > +
> >               memtier =3D set_node_memory_tier(node);
> >               if (IS_ERR(memtier))
> >                       /*
>
> --
> Best Regards,
> Huang, Ying



--=20
Best regards,
Ho-Ren (Jack) Chuang
=E8=8E=8A=E8=B3=80=E4=BB=BB

