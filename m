Return-Path: <linux-kernel+bounces-93242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7B8872CBB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 330CD1C21AC8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5ADD530;
	Wed,  6 Mar 2024 02:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BElsvnoG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78607ECF;
	Wed,  6 Mar 2024 02:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709692060; cv=none; b=Ps45n4eD3vgokxFGHUr8xQIs3VKuMROekPDzQ26vOij9PBmJZoxd90a14RP2fOnk7cCxhX0bIATwhDlkOHBxdkpHogRYoyK+qmkVHzq4d6GMJ+ncFmaK2GQ1gvWnIjartx2SanZQX2iMqmowCfUsBou68nHUzLWyOsuc4xGTPNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709692060; c=relaxed/simple;
	bh=XDNTXC9Xxd0YQ5QcW7RTouxzsRfUoLkVDKJefb4p6HY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YQ642NBf0m7Eop1NTynYbft/YW3f74I0eDIbim7YK4FU17TqcACVNfXquLRwMa8s9yJ3yZBMJV7y2iISwxS6rEYNDERoobZZF1ltqc08gjN1Bb+DdMf5HPiIQ01ZIwcPwmhUPC6Qi89KY+YO4HkywjTo+Y7qYPzR2lxbhhfPNDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BElsvnoG; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709692057; x=1741228057;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=XDNTXC9Xxd0YQ5QcW7RTouxzsRfUoLkVDKJefb4p6HY=;
  b=BElsvnoGZH19kU1iMpiZFIbbXEti1NV2ETkhWJRSlLb+YoqocCmRoEpd
   HOY8yo/tKiIvu8TIV/3YDL1XrZwiBY6C3h7QWvG7sJzVJ1cE43Mg+DX7d
   PIr4tmKtUGKxO3uxuMMeya4NyvaO1rU6Up8k56lbaBQhL92hRjgFnh3/P
   N4J23rEd5zWTPp0gsXo5s+rIee0uo1lHhoOZ9BW7GDfTtUjA2VINCcYkv
   GcIB5Xe3uJG1e/YfmU+AHYbk0Z4zPgDAujhvTi8AlGY4DIRDKewx+1Nd1
   aQAyNoC6eKHaNY0lfKZvhVBqWbsXFP2Sapo+tYlW5RJrXhlrzYGT1NJPT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4142091"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="4142091"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 18:27:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="9994256"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 18:27:30 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Cc: Gregory Price <gourry.memverge@gmail.com>,  aneesh.kumar@linux.ibm.com,
  mhocko@suse.com,  tj@kernel.org,  john@jagalactic.com,  Eishan Mirakhur
 <emirakhur@micron.com>,  Vinicius Tavares Petrucci
 <vtavarespetr@micron.com>,  Ravis OpenSrc <Ravis.OpenSrc@micron.com>,
  Alistair Popple <apopple@nvidia.com>,  "Rafael J. Wysocki"
 <rafael@kernel.org>,  Len Brown <lenb@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Dave Jiang <dave.jiang@intel.com>,  Dan
 Williams <dan.j.williams@intel.com>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  linux-acpi@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  "Ho-Ren (Jack)
 Chuang" <horenc@vt.edu>,  "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>,
  linux-cxl@vger.kernel.org,  qemu-devel@nongnu.org
Subject: Re: [External] Re: [PATCH v1 1/1] memory tier: acpi/hmat: create
 CPUless memory tiers after obtaining HMAT info
In-Reply-To: <CAKPbEqrti2x05n5QhXtefhu+C=xmMUaH8mMwDy83LVN3Fj6nDw@mail.gmail.com>
	(Ho-Ren Chuang's message of "Tue, 5 Mar 2024 01:28:55 -0800")
References: <20240301082248.3456086-1-horenchuang@bytedance.com>
	<20240301082248.3456086-2-horenchuang@bytedance.com>
	<87jzmibtyh.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAKPbEqrti2x05n5QhXtefhu+C=xmMUaH8mMwDy83LVN3Fj6nDw@mail.gmail.com>
Date: Wed, 06 Mar 2024 10:25:35 +0800
Message-ID: <87edco85b4.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:

> On Sun, Mar 3, 2024 at 6:42=E2=80=AFPM Huang, Ying <ying.huang@intel.com>=
 wrote:
>>
>> Hi, Jack,
>>
>> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:
>>
>> > * Introduce `mt_init_with_hmat()`
>> > We defer memory tier initialization for those CPUless NUMA nodes
>> > until acquiring HMAT info. `mt_init_with_hmat()` is introduced to
>> > post-create CPUless memory tiers after obtaining HMAT info.
>> > It iterates through each CPUless memory node, creating memory tiers if
>> > necessary. Finally, it calculates demotion tables again at the end.
>> >
>> > * Introduce `hmat_find_alloc_memory_type()`
>> > Find or allocate a memory type in the `hmat_memory_types` list.
>> >
>> > * Make `set_node_memory_tier()` more generic
>> > This function can also be used for setting other memory types for a no=
de.
>> > To do so, a new argument is added to specify a memory type.
>> >
>> > * Handle cases where there is no HMAT when creating memory tiers
>> > If no HMAT is specified, it falls back to using `default_dram_type`.
>> >
>> > * Change adist calculation code to use another new lock, mt_perf_lock.
>> > Iterating through CPUlist nodes requires holding the `memory_tier_lock=
`.
>> > However, `mt_calc_adistance()` will end up trying to acquire the same =
lock,
>> > leading to a potential deadlock. Therefore, we propose introducing a
>> > standalone `mt_perf_lock` to protect `default_dram_perf`. This approac=
h not
>> > only avoids deadlock but also prevents holding a large lock simultaneo=
usly.
>>
>> The patch description is used to described why we need the change, and
>> how we do that, but not what we do.  People can tell what is done from
>> the code itself.
>>
>
> Got it. Thanks. Will rewrite it after the code is finalized.
>
>> > Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
>> > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
>> > ---
>> >  drivers/acpi/numa/hmat.c     |  3 ++
>> >  include/linux/memory-tiers.h |  6 +++
>> >  mm/memory-tiers.c            | 76 ++++++++++++++++++++++++++++++++----
>> >  3 files changed, 77 insertions(+), 8 deletions(-)
>> >
>> > diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
>> > index d6b85f0f6082..9f57338b3cb5 100644
>> > --- a/drivers/acpi/numa/hmat.c
>> > +++ b/drivers/acpi/numa/hmat.c
>> > @@ -1038,6 +1038,9 @@ static __init int hmat_init(void)
>> >       if (!hmat_set_default_dram_perf())
>> >               register_mt_adistance_algorithm(&hmat_adist_nb);
>> >
>> > +     /* Post-create CPUless memory tiers after getting HMAT info */
>> > +     mt_init_with_hmat();
>> > +
>> >       return 0;
>> >  out_put:
>> >       hmat_free_structures();
>> > diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers=
h
>> > index 69e781900082..2f845e90c033 100644
>> > --- a/include/linux/memory-tiers.h
>> > +++ b/include/linux/memory-tiers.h
>> > @@ -48,6 +48,7 @@ int mt_calc_adistance(int node, int *adist);
>> >  int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
>> >                            const char *source);
>> >  int mt_perf_to_adistance(struct access_coordinate *perf, int *adist);
>> > +void mt_init_with_hmat(void);
>>
>> HMAT isn't universally available.  It's a driver in fact.  So, don't put
>> driver specific code in general code.
>>
>
> Please see below regarding "move code to hmat.c"
>
>> >  #ifdef CONFIG_MIGRATION
>> >  int next_demotion_node(int node);
>> >  void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
>> > @@ -136,5 +137,10 @@ static inline int mt_perf_to_adistance(struct acc=
ess_coordinate *perf, int *adis
>> >  {
>> >       return -EIO;
>> >  }
>> > +
>> > +static inline void mt_init_with_hmat(void)
>> > +{
>> > +
>> > +}
>> >  #endif       /* CONFIG_NUMA */
>> >  #endif  /* _LINUX_MEMORY_TIERS_H */
>> > diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
>> > index 0537664620e5..7a0a579b3deb 100644
>> > --- a/mm/memory-tiers.c
>> > +++ b/mm/memory-tiers.c
>> > @@ -35,7 +35,9 @@ struct node_memory_type_map {
>> >  };
>> >
>> >  static DEFINE_MUTEX(memory_tier_lock);
>> > +static DEFINE_MUTEX(mt_perf_lock);
>> >  static LIST_HEAD(memory_tiers);
>> > +static LIST_HEAD(hmat_memory_types);
>> >  static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
>> >  struct memory_dev_type *default_dram_type;
>> >
>> > @@ -502,7 +504,7 @@ static inline void __init_node_memory_type(int nod=
e, struct memory_dev_type *mem
>> >       }
>> >  }
>> >
>> > -static struct memory_tier *set_node_memory_tier(int node)
>> > +static struct memory_tier *set_node_memory_tier(int node, struct memo=
ry_dev_type *new_memtype)
>>
>> No. memory_dev_type are passed to the function via node_memory_types[nod=
e].memtype.
>>
>
> Got it. Will mimic the way kmem.c does. Thanks.
>
>> >  {
>> >       struct memory_tier *memtier;
>> >       struct memory_dev_type *memtype;
>> > @@ -514,7 +516,7 @@ static struct memory_tier *set_node_memory_tier(in=
t node)
>> >       if (!node_state(node, N_MEMORY))
>> >               return ERR_PTR(-EINVAL);
>> >
>> > -     __init_node_memory_type(node, default_dram_type);
>> > +     __init_node_memory_type(node, new_memtype);
>> >
>> >       memtype =3D node_memory_types[node].memtype;
>> >       node_set(node, memtype->nodes);
>> > @@ -623,6 +625,56 @@ void clear_node_memory_type(int node, struct memo=
ry_dev_type *memtype)
>> >  }
>> >  EXPORT_SYMBOL_GPL(clear_node_memory_type);
>> >
>> > +static struct memory_dev_type *hmat_find_alloc_memory_type(int adist)
>>
>> Similar function existed in drivers/dax/kmem.c.  Please abstract them
>> and move them here.
>>
>
> Got it. Will try. Thanks.
>
>> > +{
>> > +     bool found =3D false;
>> > +     struct memory_dev_type *mtype;
>> > +
>> > +     list_for_each_entry(mtype, &hmat_memory_types, list) {
>> > +             if (mtype->adistance =3D=3D adist) {
>> > +                     found =3D true;
>> > +                     break;
>> > +             }
>> > +     }
>> > +     if (!found) {
>> > +             mtype =3D alloc_memory_type(adist);
>> > +             if (!IS_ERR(mtype))
>> > +                     list_add(&mtype->list, &hmat_memory_types);
>> > +     }
>> > +     return mtype;
>> > +}
>> > +
>> > +static void mt_create_with_hmat(int node)
>> > +{
>> > +     struct memory_dev_type *mtype =3D NULL;
>> > +     int adist =3D MEMTIER_ADISTANCE_DRAM;
>> > +
>> > +     mt_calc_adistance(node, &adist);
>> > +     if (adist !=3D MEMTIER_ADISTANCE_DRAM) {
>> > +             mtype =3D hmat_find_alloc_memory_type(adist);
>> > +             if (IS_ERR(mtype))
>> > +                     pr_err("%s() failed to allocate a tier\n", __fun=
c__);
>> > +     } else {
>> > +             mtype =3D default_dram_type;
>> > +     }
>> > +
>> > +     set_node_memory_tier(node, mtype);
>> > +}
>> > +
>> > +void mt_init_with_hmat(void)
>> > +{
>> > +     int nid;
>> > +
>> > +     mutex_lock(&memory_tier_lock);
>> > +     for_each_node_state(nid, N_MEMORY)
>> > +             if (!node_state(nid, N_CPU))
>> > +                     mt_create_with_hmat(nid);
>> > +
>> > +     establish_demotion_targets();
>> > +     mutex_unlock(&memory_tier_lock);
>> > +}
>> > +EXPORT_SYMBOL_GPL(mt_init_with_hmat);
>> > +
>>
>> I guess that we can put most hmat related code above in hmat.c.
>>
>
> To put the heat-related code to hmat.c I will need to export some
> static functions in memory-tiers.c, like set_node_memory_tier() and
> establish_demotion_targets(). Is that ok?

Think about this again.  In fact, although there are "_hmat" in the name
of the above functions, the code has nothing to do with hmat.  So, we
should rename these functions, but don't need to move them to hmat.c.
And, to set memory_tier for CPUless node on system without HMAT.  We
should call mt_init_with_hmat() with late_initcall().  Where HMAT
information is expected to be available on system with HMAT.  On system
without HMAT, default_dram_type will be used.

>> >  static void dump_hmem_attrs(struct access_coordinate *coord, const ch=
ar *prefix)
>> >  {
>> >       pr_info(
>> > @@ -636,7 +688,7 @@ int mt_set_default_dram_perf(int nid, struct acces=
s_coordinate *perf,
>> >  {
>> >       int rc =3D 0;
>> >
>> > -     mutex_lock(&memory_tier_lock);
>> > +     mutex_lock(&mt_perf_lock);
>> >       if (default_dram_perf_error) {
>> >               rc =3D -EIO;
>> >               goto out;
>> > @@ -684,7 +736,7 @@ int mt_set_default_dram_perf(int nid, struct acces=
s_coordinate *perf,
>> >       }
>> >
>> >  out:
>> > -     mutex_unlock(&memory_tier_lock);
>> > +     mutex_unlock(&mt_perf_lock);
>> >       return rc;
>> >  }
>> >
>> > @@ -700,7 +752,7 @@ int mt_perf_to_adistance(struct access_coordinate =
*perf, int *adist)
>> >           perf->read_bandwidth + perf->write_bandwidth =3D=3D 0)
>> >               return -EINVAL;
>> >
>> > -     mutex_lock(&memory_tier_lock);
>> > +     mutex_lock(&mt_perf_lock);
>> >       /*
>> >        * The abstract distance of a memory node is in direct proportio=
n to
>> >        * its memory latency (read + write) and inversely proportional =
to its
>> > @@ -713,7 +765,7 @@ int mt_perf_to_adistance(struct access_coordinate =
*perf, int *adist)
>> >               (default_dram_perf.read_latency + default_dram_perf.writ=
e_latency) *
>> >               (default_dram_perf.read_bandwidth + default_dram_perf.wr=
ite_bandwidth) /
>> >               (perf->read_bandwidth + perf->write_bandwidth);
>> > -     mutex_unlock(&memory_tier_lock);
>> > +     mutex_unlock(&mt_perf_lock);
>> >
>> >       return 0;
>> >  }
>> > @@ -797,7 +849,7 @@ static int __meminit memtier_hotplug_callback(stru=
ct notifier_block *self,
>> >               break;
>> >       case MEM_ONLINE:
>> >               mutex_lock(&memory_tier_lock);
>> > -             memtier =3D set_node_memory_tier(arg->status_change_nid);
>> > +             memtier =3D set_node_memory_tier(arg->status_change_nid,=
 default_dram_type);
>> >               if (!IS_ERR(memtier))
>> >                       establish_demotion_targets();
>> >               mutex_unlock(&memory_tier_lock);
>> > @@ -836,7 +888,15 @@ static int __init memory_tier_init(void)
>> >        * types assigned.
>> >        */
>> >       for_each_node_state(node, N_MEMORY) {
>> > -             memtier =3D set_node_memory_tier(node);
>> > +             if (!node_state(node, N_CPU))
>> > +                     /*
>> > +                      * Defer memory tier initialization on CPUless n=
uma nodes.
>> > +                      * These will be initialized when HMAT informati=
on is
>> > +                      * available.
>> > +                      */
>> > +                     continue;
>> > +
>> > +             memtier =3D set_node_memory_tier(node, default_dram_type=
);
>>
>> On system with HMAT, how to fall back CPU-less node to
>> default_dram_type?  I found your description, but I don't find it in cod=
e.
>>
> I assume you meant without HMAT, if so,
> because if no HMAT, adist will not be updated in mt_calc_adistance():

Sorry, typo.  On system with HMAT, mt_init_with_hmat() will not be
called.  I have a solution in above comment.

--
Best Regards,
Huang, Ying

> + int adist =3D MEMTIER_ADISTANCE_DRAM;
> +
> + mt_calc_adistance(node, &adist);
> + if (adist !=3D MEMTIER_ADISTANCE_DRAM) {
> =E2=80=A6
> + } else {
> + mtype =3D default_dram_type;
> + }
> +
> + set_node_memory_tier(node, mtype);
>
>> >               if (IS_ERR(memtier))
>> >                       /*
>> >                        * Continue with memtiers we are able to setup
>>
>> --
>> Best Regards,
>> Huang, Ying

