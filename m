Return-Path: <linux-kernel+bounces-120401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C61D088D6DA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A3372A3C7B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4478323765;
	Wed, 27 Mar 2024 06:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fQsfYNcq"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9151CA87
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 06:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711522523; cv=none; b=tQNNNCwS4Df8Oib4r0digpPwsudH7YSsDLDM4BP+7wLdPzgvMulNe+UTEX/ZIgs1bv7TQvOzQGCjiEmvGw2psw9MYHaZnyq3jKPuzF13JvMal1upTpLpeImJyT59cKUEyi/dmbyTJ4F4r1pbDRk2ZCPavlZM7TA3kEeb+Fe3x5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711522523; c=relaxed/simple;
	bh=pou+ytS5UXL8DGmx9JFrYDp3iLEuHsSbSXo7hwooVB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qW4wR5d5lBB8hjFa+GSEBeb6OWz4sjLVGHCNyqSlS29AiUyGJXLUi/DW95EIeiKACX8kfR6cYoBAMtcnQtXhQjc58Wh4DkMGQOtEg2g2rPrzfGmYVf6SiLqWU4OOm6GApY5+dlef7tLV/3k4TiFGChzGSdjWTdk/geT8G7lAdHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fQsfYNcq; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60a15449303so63215677b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 23:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711522519; x=1712127319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gBdAxMvMnjsczXEA3QG1dVLh7HlPI7SpPCL+teq1rw=;
        b=fQsfYNcq2pxPFOAdU46VcMncJkKi75OueThhtAR4yD3stU6mzZVFWA/GpXo5U+clxm
         RB/go/N/6SFS7k8GFHAGQnjqjoJUgYzQskA+85hzeLybDiL4h0NhmF1v+/kh7sJp29mt
         yycEqBwkimNfie7RAxd4qHXvBNfBTC8ohaR2J+qv4TjoV7m41QG8acIfrRlBAz47yH79
         4b8hszV0mk7xf6d2+/dOMd2QVDiArcGXjOIfpUurDyD6qD7M7+44R5ej8XnTrvaR4Qmy
         MKPD61vZUb4eK2XBgKfr/ZPcpbNEPmdkYKn3J8+KCfyI9M51XBOyUvFBawi7dwY7/0QI
         +vBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711522519; x=1712127319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2gBdAxMvMnjsczXEA3QG1dVLh7HlPI7SpPCL+teq1rw=;
        b=dBa+tlvMtPcBwmeJeHyeUC+HDecGpmXrEVuGb1SC4tiZYPAtzeW4ZUmt+T6Wbhy5WG
         rZQyNw8DoaYYp3K/0D45KKW0wt5xIWjl1mzeUgwEGZ37Y5fh1l3p7pBCEEv29kwx0ggQ
         p/k95C6op0DCr7425Q4odlOVmpNBFVOJLq5XXSjimbvRwnRqi6Dj1xV7TJYYNQCzNNnx
         eTNLe7WjMzPz9gXf6GJSsurFDOvJGRlA1s05xWpYc6XYZeymDwuCuYephzSo0Clwg4u8
         UHWZJJ+WPf4ROrlIyfqIvdp5elSzStcy0UcTn6dh9v37Jj3kGAqmrtxEvEYqMVmzQtUp
         zaRg==
X-Forwarded-Encrypted: i=1; AJvYcCUR95VszUe+e8IXHRLPCBPjvbrC2hypO/m5IeN+wMHomblzUwKf1U1kI4BB9//y7OFj/d8gt6t2d542bbqRhUAM/XRHMAZFAYajS8/G
X-Gm-Message-State: AOJu0YyzgG0mPEJZ8qiBCd5y/WXaPtnHJs2rjJl0Ftw/3bjytEPm9zim
	IcVlqGTUzymPIeBAFETTJ14lPCCdwq7cg12jn3GL5ExIHk4948As9Vf1hkT9oyAQHPzt4lIaZme
	kA7lCRTt4QPcV6klFE2Dw4qW6v6681jSSccP7WQ==
X-Google-Smtp-Source: AGHT+IGneaW9WE/Y0nsKRo0D7anGiHOi7fBK7mx80rP9apScsfFYIjDTSuH8hoPcCeMmppqQ4avESF7WEPInBimAGLE=
X-Received: by 2002:a25:a009:0:b0:dcf:b5b7:c72 with SMTP id
 x9-20020a25a009000000b00dcfb5b70c72mr2835965ybh.0.1711522518886; Tue, 26 Mar
 2024 23:55:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327041646.3258110-1-horenchuang@bytedance.com>
 <20240327041646.3258110-3-horenchuang@bytedance.com> <874jcsnryv.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <874jcsnryv.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Date: Tue, 26 Mar 2024 23:55:07 -0700
Message-ID: <CAKPbEqpbtkbcH2XoV2g3AFm1HtzOPjkNMa3AyTqWdd5MyvY9pg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 2/2] memory tier: create CPUless memory
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

On Tue, Mar 26, 2024 at 10:52=E2=80=AFPM Huang, Ying <ying.huang@intel.com>=
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
> > but also prevents holding a large lock simultaneously. Besides, this pa=
tch
> > slightly shortens the time holding the lock by putting the lock closer =
to
> > what it protects as well.
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
> > * Fix a deadlock bug in `mt_perf_to_adistance`
> > Because an error path was not handled properly in `mt_perf_to_adistance=
`,
> > unlock before returning the error.
> >
> > Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> > ---
> >  mm/memory-tiers.c | 85 +++++++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 72 insertions(+), 13 deletions(-)
> >
> > diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> > index 974af10cfdd8..610db9581ba4 100644
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
> > @@ -108,6 +113,8 @@ static struct demotion_nodes *node_demotion __read_=
mostly;
> >
> >  static BLOCKING_NOTIFIER_HEAD(mt_adistance_algorithms);
> >
> > +/* The lock is used to protect `default_dram_perf*` info and nid. */
> > +static DEFINE_MUTEX(default_dram_perf_lock);
> >  static bool default_dram_perf_error;
> >  static struct access_coordinate default_dram_perf;
> >  static int default_dram_perf_ref_nid =3D NUMA_NO_NODE;
> > @@ -505,7 +512,8 @@ static inline void __init_node_memory_type(int node=
, struct memory_dev_type *mem
> >  static struct memory_tier *set_node_memory_tier(int node)
> >  {
> >       struct memory_tier *memtier;
> > -     struct memory_dev_type *memtype;
> > +     struct memory_dev_type *mtype =3D default_dram_type;
> > +     int adist =3D MEMTIER_ADISTANCE_DRAM;
> >       pg_data_t *pgdat =3D NODE_DATA(node);
> >
> >
> > @@ -514,11 +522,20 @@ static struct memory_tier *set_node_memory_tier(i=
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
> > +     memtier =3D find_create_memory_tier(mtype);
> >       if (!IS_ERR(memtier))
> >               rcu_assign_pointer(pgdat->memtier, memtier);
> >       return memtier;
> > @@ -655,6 +672,34 @@ void mt_put_memory_types(struct list_head *memory_=
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
> > @@ -668,7 +713,6 @@ int mt_set_default_dram_perf(int nid, struct access=
_coordinate *perf,
> >  {
> >       int rc =3D 0;
> >
> > -     mutex_lock(&memory_tier_lock);
> >       if (default_dram_perf_error) {
> >               rc =3D -EIO;
> >               goto out;
> > @@ -680,6 +724,7 @@ int mt_set_default_dram_perf(int nid, struct access=
_coordinate *perf,
> >               goto out;
> >       }
> >
> > +     mutex_lock(&default_dram_perf_lock);
>
> Why do you move the position of locking?  mutex_lock/unlock() will be
> unbalance for error path above.
>

Because you've mentioned below that moving the lock to the
beginning of the function will make the code easier to understand,
I will move the lock to the beginning of the function.

Perhaps the explanation may no longer be relevant; because reading
`default_dram_perf_error` and `perf->*` do not require
holding `default_dram_perf_lock`, but I forgot to replace
"rc =3D -EXXX ; goto out;" with return -EXXX.

> >       if (default_dram_perf_ref_nid =3D=3D NUMA_NO_NODE) {
> >               default_dram_perf =3D *perf;
> >               default_dram_perf_ref_nid =3D nid;
> > @@ -716,23 +761,26 @@ int mt_set_default_dram_perf(int nid, struct acce=
ss_coordinate *perf,
> >       }
> >
> >  out:
> > -     mutex_unlock(&memory_tier_lock);
> > +     mutex_unlock(&default_dram_perf_lock);
> >       return rc;
> >  }
> >
> >  int mt_perf_to_adistance(struct access_coordinate *perf, int *adist)
> >  {
> > +     int rc =3D 0;
> > +
> >       if (default_dram_perf_error)
> >               return -EIO;
> >
> > -     if (default_dram_perf_ref_nid =3D=3D NUMA_NO_NODE)
> > -             return -ENOENT;
> > -
> >       if (perf->read_latency + perf->write_latency =3D=3D 0 ||
> >           perf->read_bandwidth + perf->write_bandwidth =3D=3D 0)
> >               return -EINVAL;
> >
> > -     mutex_lock(&memory_tier_lock);
> > +     mutex_lock(&default_dram_perf_lock);
>
> It may be a little better to move lock position at the begin of the
> function.  This will not avoid race condition (not harmful in practice)
> but it will make code easier to be understood.
>

No problem. I will move the lock to the beginning of the function and
take care of all error paths.

> > +     if (default_dram_perf_ref_nid =3D=3D NUMA_NO_NODE) {
> > +             rc =3D -ENOENT;
> > +             goto out;
> > +     }
> >       /*
> >        * The abstract distance of a memory node is in direct proportion=
 to
> >        * its memory latency (read + write) and inversely proportional t=
o its
> > @@ -745,8 +793,10 @@ int mt_perf_to_adistance(struct access_coordinate =
*perf, int *adist)
> >               (default_dram_perf.read_latency + default_dram_perf.write=
_latency) *
> >               (default_dram_perf.read_bandwidth + default_dram_perf.wri=
te_bandwidth) /
> >               (perf->read_bandwidth + perf->write_bandwidth);
> > -     mutex_unlock(&memory_tier_lock);
> > +     mutex_unlock(&default_dram_perf_lock);
> >
> > +out:
> > +     mutex_unlock(&default_dram_perf_lock);
> >       return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(mt_perf_to_adistance);
> > @@ -858,7 +908,8 @@ static int __init memory_tier_init(void)
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
> > @@ -868,6 +919,14 @@ static int __init memory_tier_init(void)
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

