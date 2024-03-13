Return-Path: <linux-kernel+bounces-101208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D7487A401
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F46C1F21822
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B61C1946C;
	Wed, 13 Mar 2024 08:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Kzb0T1DV"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95FF1B7F1
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 08:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710317802; cv=none; b=XFD3n0+8+ic3XXoPL/uEB3DmEzSf+86KVjhik9Nk9PJuvrjlFRSHlW0wx4m2fwSNy4FF9xe6pnM+bqsrbgI8bOENcGustPdMPp5PIZTLT7TkYe+quwFTSYkwy0ja9zGObEHKfbbz7YbkJWo90yLR++Xw4aGTIfP9NssRGo7akU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710317802; c=relaxed/simple;
	bh=iIAVGptrxrpcKUcQe28ZGs6beH/58Jg/lYdsXdo6itw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rlwLAJH4BJvh0HKws48q6ps/ezSKPvSgJJfU2yJWmPBcTDdj27MHQzDcD6h82WgwNzunBWpLjj0XXuE+jjWB9+HLhWlRfXfTIsFTjqv4UTpaShjHGKrQK/8NNV54eMM2KnOjtIv40xMBaqnyzB5AOCOf1aiCpGZ+uQL3eWJeClg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Kzb0T1DV; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6099703e530so42445997b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 01:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710317798; x=1710922598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjonAc8oEn9nxPK0YY+VDWqHB4SeTT8yB1nbEWly4fA=;
        b=Kzb0T1DVU/lu2NvCvXqfYRIEAQgpgoP4tXGc/ZVDGhFHo5GgrfV4LN5cRfZc8ycGoc
         rfgvz5v4jF1m3cvXC7pTd47gLxej8yx7MnDwzxjIyGiyz+qY/5SG4l2eU5lfYTVvIsVq
         0Vdz8+6QTYIYjDPLpELHNUO1pGKKdaBggdDkLQZluUs9P0MaNcaE/6ayAmtWgPI66Skx
         klcDDgkUZg3sf43M6i3c8YUwPZRgjPX1HPRX74pD63PQQrDV4wDncuVfo8ZD25FMYXkU
         /dNdJsuPXfsLkLUWuhbDMuDAUwC0yi3bCerKLVGNeb77vCLalBwx85XAj0gw3Gd/INsL
         iRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710317798; x=1710922598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjonAc8oEn9nxPK0YY+VDWqHB4SeTT8yB1nbEWly4fA=;
        b=rhR92IMPQA7agDLv0nV/zO8ZD6gOyus1KIRoRLxg70ADBF0lIj6D0kmlRcFAhiOO5x
         gguaNAlkOYTU9Wj6WZdgBvWtRlfIcj9JtnuXnPoTUIbsD5KCZuRmFTnrgMx6+Yn3RZXY
         6HHgYmba92APBor7bo/X4UE5VSXy7fy63hdjLvg4C58YSq0Uv0dW4J3S+DPwLNW0I4qO
         Vw+sWSJCYlHIfn0XnEw/iHv2K27Gr4PtfUU+BrPUrbfuVctiQiH1KA19z2oA24QvKIZy
         xceM1XL+k+n/Tm93Fs7KcZWdodIG7lwYHC/24ZfGpHpkbEzUHZW0hLzeQnE98hswJwmZ
         Y33Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFYDpzve59A55BziMkO/AlCA+DaCzbSmOgggCXAb1xbHMk8TRNW+Ck1ZMw2raTCSrVt6HHSFXJDv/bjUj4x5Kje09kkvY0IpC7fbY2
X-Gm-Message-State: AOJu0YwMti5kiLvhcyIPRafy/Zx/dBxFMMDeWLebA8qHhmLd677IYiOa
	oWiHfyfNYklMNYlQUG+WFW4nZMtZR/xh4L3l+mYZwvgQFn5FlghAiYqjZI9t+LQxakl6fp8y7fA
	DidDVAY2/4PyKog68WPYHu1vdLUmjtKXgXGp4gQ==
X-Google-Smtp-Source: AGHT+IE65VHYxesx4YYzvTJxe72DdkmVzBXmOm+qIMlTDtZKqKJ9DrCZTYHxl9AkfjBGu0wP8S8LSx1yMLyXIXG/b8U=
X-Received: by 2002:a25:ace0:0:b0:dc7:45f4:44f7 with SMTP id
 x32-20020a25ace0000000b00dc745f444f7mr1559987ybd.14.1710317797661; Wed, 13
 Mar 2024 01:16:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312061729.1997111-1-horenchuang@bytedance.com>
 <20240312061729.1997111-2-horenchuang@bytedance.com> <874jdb4xk8.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <874jdb4xk8.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Date: Wed, 13 Mar 2024 01:16:27 -0700
Message-ID: <CAKPbEqpTNN5GKKCXmyTv0szpL-N1pdKFZYPHCJjyhgpKZGMiWw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 1/1] memory tier: acpi/hmat: create
 CPUless memory tiers after obtaining HMAT info
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, aneesh.kumar@linux.ibm.com, mhocko@suse.com, 
	tj@kernel.org, john@jagalactic.com, Eishan Mirakhur <emirakhur@micron.com>, 
	Vinicius Tavares Petrucci <vtavarespetr@micron.com>, Ravis OpenSrc <Ravis.OpenSrc@micron.com>, 
	Alistair Popple <apopple@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-mm@kvack.org, 
	"Ho-Ren (Jack) Chuang" <horenc@vt.edu>, "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, qemu-devel@nongnu.org, 
	Hao Xiang <hao.xiang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 2:21=E2=80=AFAM Huang, Ying <ying.huang@intel.com> =
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
> > * Abstract common functions into `find_alloc_memory_type()`
>
> We should move kmem_put_memory_types() (renamed to
> mt_put_memory_types()?) too.  This can be put in a separate patch.
>

Will do! Thanks,


>
> > Since different memory devices require finding or allocating a memory t=
ype,
> > these common steps are abstracted into a single function,
> > `find_alloc_memory_type()`, enhancing code scalability and conciseness.
> >
> > * Handle cases where there is no HMAT when creating memory tiers
> > There is a scenario where a CPUless node does not provide HMAT informat=
ion.
> > If no HMAT is specified, it falls back to using the default DRAM tier.
> >
> > * Change adist calculation code to use another new lock, mt_perf_lock.
> > In the current implementation, iterating through CPUlist nodes requires
> > holding the `memory_tier_lock`. However, `mt_calc_adistance()` will end=
 up
> > trying to acquire the same lock, leading to a potential deadlock.
> > Therefore, we propose introducing a standalone `mt_perf_lock` to protec=
t
> > `default_dram_perf`. This approach not only avoids deadlock but also
> > prevents holding a large lock simultaneously.
> >
> > Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> > ---
> >  drivers/acpi/numa/hmat.c     | 11 ++++++
> >  drivers/dax/kmem.c           | 13 +------
> >  include/linux/acpi.h         |  6 ++++
> >  include/linux/memory-tiers.h |  8 +++++
> >  mm/memory-tiers.c            | 70 +++++++++++++++++++++++++++++++++---
> >  5 files changed, 92 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> > index d6b85f0f6082..28812ec2c793 100644
> > --- a/drivers/acpi/numa/hmat.c
> > +++ b/drivers/acpi/numa/hmat.c
> > @@ -38,6 +38,8 @@ static LIST_HEAD(targets);
> >  static LIST_HEAD(initiators);
> >  static LIST_HEAD(localities);
> >
> > +static LIST_HEAD(hmat_memory_types);
> > +
>
> HMAT isn't a device driver for some memory devices.  So I don't think we
> should manage memory types in HMAT.

I can put it back in memory-tier.c. How about the list? Do we still
need to keep a separate list for storing late_inited memory nodes?
And how about the list name if we need to remove the prefix "hmat_"?


> Instead, if the memory_type of a
> node isn't set by the driver, we should manage it in memory-tier.c as
> fallback.
>

Do you mean some device drivers may init memory tiers between
memory_tier_init() and late_initcall(memory_tier_late_init);?
And this is the reason why you mention to exclude
"node_memory_types[nid].memtype !=3D NULL" in memory_tier_late_init().
Is my understanding correct?

> >  static DEFINE_MUTEX(target_lock);
> >
> >  /*
> > @@ -149,6 +151,12 @@ int acpi_get_genport_coordinates(u32 uid,
> >  }
> >  EXPORT_SYMBOL_NS_GPL(acpi_get_genport_coordinates, CXL);
> >
> > +struct memory_dev_type *hmat_find_alloc_memory_type(int adist)
> > +{
> > +     return find_alloc_memory_type(adist, &hmat_memory_types);
> > +}
> > +EXPORT_SYMBOL_GPL(hmat_find_alloc_memory_type);
> > +
> >  static __init void alloc_memory_initiator(unsigned int cpu_pxm)
> >  {
> >       struct memory_initiator *initiator;
> > @@ -1038,6 +1046,9 @@ static __init int hmat_init(void)
> >       if (!hmat_set_default_dram_perf())
> >               register_mt_adistance_algorithm(&hmat_adist_nb);
> >
> > +     /* Post-create CPUless memory tiers after getting HMAT info */
> > +     memory_tier_late_init();
> > +
>
> This should be called in memory-tier.c via
>
> late_initcall(memory_tier_late_init);
>
> Then, we don't need hmat to call it.
>

Thanks. Learned!


> >       return 0;
> >  out_put:
> >       hmat_free_structures();
> > diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> > index 42ee360cf4e3..aee17ab59f4f 100644
> > --- a/drivers/dax/kmem.c
> > +++ b/drivers/dax/kmem.c
> > @@ -55,21 +55,10 @@ static LIST_HEAD(kmem_memory_types);
> >
> >  static struct memory_dev_type *kmem_find_alloc_memory_type(int adist)
> >  {
> > -     bool found =3D false;
> >       struct memory_dev_type *mtype;
> >
> >       mutex_lock(&kmem_memory_type_lock);
> > -     list_for_each_entry(mtype, &kmem_memory_types, list) {
> > -             if (mtype->adistance =3D=3D adist) {
> > -                     found =3D true;
> > -                     break;
> > -             }
> > -     }
> > -     if (!found) {
> > -             mtype =3D alloc_memory_type(adist);
> > -             if (!IS_ERR(mtype))
> > -                     list_add(&mtype->list, &kmem_memory_types);
> > -     }
> > +     mtype =3D find_alloc_memory_type(adist, &kmem_memory_types);
> >       mutex_unlock(&kmem_memory_type_lock);
> >
> >       return mtype;
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > index b7165e52b3c6..3f927ff01f02 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -434,12 +434,18 @@ int thermal_acpi_critical_trip_temp(struct acpi_d=
evice *adev, int *ret_temp);
> >
> >  #ifdef CONFIG_ACPI_HMAT
> >  int acpi_get_genport_coordinates(u32 uid, struct access_coordinate *co=
ord);
> > +struct memory_dev_type *hmat_find_alloc_memory_type(int adist);
> >  #else
> >  static inline int acpi_get_genport_coordinates(u32 uid,
> >                                              struct access_coordinate *=
coord)
> >  {
> >       return -EOPNOTSUPP;
> >  }
> > +
> > +static inline struct memory_dev_type *hmat_find_alloc_memory_type(int =
adist)
> > +{
> > +     return NULL;
> > +}
> >  #endif
> >
> >  #ifdef CONFIG_ACPI_NUMA
> > diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.=
h
> > index 69e781900082..4bc2596c5774 100644
> > --- a/include/linux/memory-tiers.h
> > +++ b/include/linux/memory-tiers.h
> > @@ -48,6 +48,9 @@ int mt_calc_adistance(int node, int *adist);
> >  int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
> >                            const char *source);
> >  int mt_perf_to_adistance(struct access_coordinate *perf, int *adist);
> > +struct memory_dev_type *find_alloc_memory_type(int adist,
> > +                                                     struct list_head =
*memory_types);
> > +void memory_tier_late_init(void);
> >  #ifdef CONFIG_MIGRATION
> >  int next_demotion_node(int node);
> >  void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
> > @@ -136,5 +139,10 @@ static inline int mt_perf_to_adistance(struct acce=
ss_coordinate *perf, int *adis
> >  {
> >       return -EIO;
> >  }
> > +
> > +static inline void memory_tier_late_init(void)
> > +{
> > +
> > +}
> >  #endif       /* CONFIG_NUMA */
> >  #endif  /* _LINUX_MEMORY_TIERS_H */
> > diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> > index 0537664620e5..79f748d60e6f 100644
> > --- a/mm/memory-tiers.c
> > +++ b/mm/memory-tiers.c
> > @@ -6,6 +6,7 @@
> >  #include <linux/memory.h>
> >  #include <linux/memory-tiers.h>
> >  #include <linux/notifier.h>
> > +#include <linux/acpi.h>
> >
> >  #include "internal.h"
> >
> > @@ -35,6 +36,7 @@ struct node_memory_type_map {
> >  };
> >
> >  static DEFINE_MUTEX(memory_tier_lock);
> > +static DEFINE_MUTEX(mt_perf_lock);
>
> Please add comments about what it protects.  And put it near the data
> structure it protects.
>

Where is better for me to add comments for this? Code? Patch description?
Will put it closer to the protected data. Thanks.



> >  static LIST_HEAD(memory_tiers);
> >  static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
> >  struct memory_dev_type *default_dram_type;
> > @@ -623,6 +625,58 @@ void clear_node_memory_type(int node, struct memor=
y_dev_type *memtype)
> >  }
> >  EXPORT_SYMBOL_GPL(clear_node_memory_type);
> >
> > +struct memory_dev_type *find_alloc_memory_type(int adist, struct list_=
head *memory_types)
> > +{
> > +     bool found =3D false;
> > +     struct memory_dev_type *mtype;
> > +
> > +     list_for_each_entry(mtype, memory_types, list) {
> > +             if (mtype->adistance =3D=3D adist) {
> > +                     found =3D true;
> > +                     break;
> > +             }
> > +     }
> > +     if (!found) {
> > +             mtype =3D alloc_memory_type(adist);
> > +             if (!IS_ERR(mtype))
> > +                     list_add(&mtype->list, memory_types);
> > +     }
> > +
> > +     return mtype;
> > +}
> > +EXPORT_SYMBOL_GPL(find_alloc_memory_type);
> > +
> > +static void memory_tier_late_create(int node)
> > +{
> > +     struct memory_dev_type *mtype =3D NULL;
> > +     int adist =3D MEMTIER_ADISTANCE_DRAM;
> > +
> > +     mt_calc_adistance(node, &adist);
> > +     if (adist !=3D MEMTIER_ADISTANCE_DRAM) {
>
> We can manage default_dram_type() via find_alloc_memory_type()
> too.
>
> And, if "node_memory_types[node].memtype =3D=3D NULL", we can call
> mt_calc_adistance(node, &adist) and find_alloc_memory_type() in
> set_node_memory_tier().  Then, we can cover hotpluged memory node too.
>
> > +             mtype =3D hmat_find_alloc_memory_type(adist);
> > +             if (!IS_ERR(mtype))
> > +                     __init_node_memory_type(node, mtype);
> > +             else
> > +                     pr_err("Failed to allocate a memory type at %s()\=
n", __func__);
> > +     }
> > +
> > +     set_node_memory_tier(node);
> > +}
> > +
> > +void memory_tier_late_init(void)
> > +{
> > +     int nid;
> > +
> > +     mutex_lock(&memory_tier_lock);
> > +     for_each_node_state(nid, N_MEMORY)
> > +             if (!node_state(nid, N_CPU))
>
> We should exclude "node_memory_types[nid].memtype !=3D NULL".  Some memor=
y
> nodes may be onlined by some device drivers and setup memory tiers
> already.
>
> > +                     memory_tier_late_create(nid);
> > +
> > +     establish_demotion_targets();
> > +     mutex_unlock(&memory_tier_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(memory_tier_late_init);
> > +
> >  static void dump_hmem_attrs(struct access_coordinate *coord, const cha=
r *prefix)
> >  {
> >       pr_info(
> > @@ -636,7 +690,7 @@ int mt_set_default_dram_perf(int nid, struct access=
_coordinate *perf,
> >  {
> >       int rc =3D 0;
> >
> > -     mutex_lock(&memory_tier_lock);
> > +     mutex_lock(&mt_perf_lock);
> >       if (default_dram_perf_error) {
> >               rc =3D -EIO;
> >               goto out;
> > @@ -684,7 +738,7 @@ int mt_set_default_dram_perf(int nid, struct access=
_coordinate *perf,
> >       }
> >
> >  out:
> > -     mutex_unlock(&memory_tier_lock);
> > +     mutex_unlock(&mt_perf_lock);
> >       return rc;
> >  }
> >
> > @@ -700,7 +754,7 @@ int mt_perf_to_adistance(struct access_coordinate *=
perf, int *adist)
> >           perf->read_bandwidth + perf->write_bandwidth =3D=3D 0)
> >               return -EINVAL;
> >
> > -     mutex_lock(&memory_tier_lock);
> > +     mutex_lock(&mt_perf_lock);
> >       /*
> >        * The abstract distance of a memory node is in direct proportion=
 to
> >        * its memory latency (read + write) and inversely proportional t=
o its
> > @@ -713,7 +767,7 @@ int mt_perf_to_adistance(struct access_coordinate *=
perf, int *adist)
> >               (default_dram_perf.read_latency + default_dram_perf.write=
_latency) *
> >               (default_dram_perf.read_bandwidth + default_dram_perf.wri=
te_bandwidth) /
> >               (perf->read_bandwidth + perf->write_bandwidth);
> > -     mutex_unlock(&memory_tier_lock);
> > +     mutex_unlock(&mt_perf_lock);
> >
> >       return 0;
> >  }
> > @@ -836,6 +890,14 @@ static int __init memory_tier_init(void)
> >        * types assigned.
> >        */
> >       for_each_node_state(node, N_MEMORY) {
> > +             if (!node_state(node, N_CPU))
> > +                     /*
> > +                      * Defer memory tier initialization on CPUless nu=
ma nodes.
> > +                      * These will be initialized when HMAT informatio=
n is
>
> HMAT is platform specific, we should avoid to mention it in general code
> if possible.
>

Will fix! Thanks,


> > +                      * available.
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

