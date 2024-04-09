Return-Path: <linux-kernel+bounces-137294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 698C889E013
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A48E2822D8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF2D13D8A4;
	Tue,  9 Apr 2024 16:12:13 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF71213D88B;
	Tue,  9 Apr 2024 16:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712679132; cv=none; b=mISzcHNrd++d0rR0Yvy2wOKkF929nBrdLMu9lkavG5wHxLzzARENSbgXnAOBGTHRyHg3JIMVV3xaE9iiPaADa66VKh3dGZ+xZXLZ9pLr+OI7evOut0o+mXjGsjEqpAltBQITpLpIF+lga72upG1QGWl3f/V+MunDjib0+fIKrHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712679132; c=relaxed/simple;
	bh=lp0JEW66Srz5p9S+cKV1lNUbi7VeyksXm815vT1QYeQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ReV3zxk2Dlt3r6fvGYRIQ5r0/f9HXDH3lg95VJphJdxH7GE8TQd0QXwgSYfCahrihiMN+5X2CsbjBO2l3SpYxpReaj3XhKBvRl+KtXnthfdi9hWPe9vXlQgxJ3cLr7jtXO9OauEiaubssn1ryORVf6CSyUWSmNI92hWE8LCd5AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VDWC83HBWz6J9yq;
	Wed, 10 Apr 2024 00:10:28 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D5F01140519;
	Wed, 10 Apr 2024 00:12:05 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 9 Apr
 2024 17:12:05 +0100
Date: Tue, 9 Apr 2024 17:12:04 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
CC: "Huang, Ying" <ying.huang@intel.com>, Gregory Price
	<gourry.memverge@gmail.com>, <aneesh.kumar@linux.ibm.com>, <mhocko@suse.com>,
	<tj@kernel.org>, <john@jagalactic.com>, Eishan Mirakhur
	<emirakhur@micron.com>, Vinicius Tavares Petrucci <vtavarespetr@micron.com>,
	Ravis OpenSrc <Ravis.OpenSrc@micron.com>, Alistair Popple
	<apopple@nvidia.com>, Srinivasulu Thanneeru <sthanneeru@micron.com>, SeongJae
 Park <sj@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, <nvdimm@lists.linux.dev>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Linux Memory
 Management List" <linux-mm@kvack.org>, "Ho-Ren (Jack) Chuang"
	<horenc@vt.edu>, "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>,
	<qemu-devel@nongnu.org>, Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH v11 2/2] memory tier: create CPUless memory tiers after
 obtaining HMAT info
Message-ID: <20240409171204.00001710@Huawei.com>
In-Reply-To: <CAKPbEqpGM_nR+LKbsoFTviBZaKUKYqJ3zbJp9EOCJAGvuPy6aQ@mail.gmail.com>
References: <20240405000707.2670063-1-horenchuang@bytedance.com>
	<20240405000707.2670063-3-horenchuang@bytedance.com>
	<20240405150244.00004b49@Huawei.com>
	<CAKPbEqpGM_nR+LKbsoFTviBZaKUKYqJ3zbJp9EOCJAGvuPy6aQ@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 5 Apr 2024 15:43:47 -0700
"Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> wrote:

> On Fri, Apr 5, 2024 at 7:03=E2=80=AFAM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Fri,  5 Apr 2024 00:07:06 +0000
> > "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> wrote:
> > =20
> > > The current implementation treats emulated memory devices, such as
> > > CXL1.1 type3 memory, as normal DRAM when they are emulated as normal =
memory
> > > (E820_TYPE_RAM). However, these emulated devices have different
> > > characteristics than traditional DRAM, making it important to
> > > distinguish them. Thus, we modify the tiered memory initialization pr=
ocess
> > > to introduce a delay specifically for CPUless NUMA nodes. This delay
> > > ensures that the memory tier initialization for these nodes is deferr=
ed
> > > until HMAT information is obtained during the boot process. Finally,
> > > demotion tables are recalculated at the end.
> > >
> > > * late_initcall(memory_tier_late_init);
> > > Some device drivers may have initialized memory tiers between
> > > `memory_tier_init()` and `memory_tier_late_init()`, potentially bring=
ing
> > > online memory nodes and configuring memory tiers. They should be excl=
uded
> > > in the late init.
> > >
> > > * Handle cases where there is no HMAT when creating memory tiers
> > > There is a scenario where a CPUless node does not provide HMAT inform=
ation.
> > > If no HMAT is specified, it falls back to using the default DRAM tier.
> > >
> > > * Introduce another new lock `default_dram_perf_lock` for adist calcu=
lation
> > > In the current implementation, iterating through CPUlist nodes requir=
es
> > > holding the `memory_tier_lock`. However, `mt_calc_adistance()` will e=
nd up
> > > trying to acquire the same lock, leading to a potential deadlock.
> > > Therefore, we propose introducing a standalone `default_dram_perf_loc=
k` to
> > > protect `default_dram_perf_*`. This approach not only avoids deadlock
> > > but also prevents holding a large lock simultaneously.
> > >
> > > * Upgrade `set_node_memory_tier` to support additional cases, includi=
ng
> > >   default DRAM, late CPUless, and hot-plugged initializations.
> > > To cover hot-plugged memory nodes, `mt_calc_adistance()` and
> > > `mt_find_alloc_memory_type()` are moved into `set_node_memory_tier()`=
 to
> > > handle cases where memtype is not initialized and where HMAT informat=
ion is
> > > available.
> > >
> > > * Introduce `default_memory_types` for those memory types that are not
> > >   initialized by device drivers.
> > > Because late initialized memory and default DRAM memory need to be ma=
naged,
> > > a default memory type is created for storing all memory types that are
> > > not initialized by device drivers and as a fallback.
> > >
> > > Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> > > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> > > Reviewed-by: "Huang, Ying" <ying.huang@intel.com> =20
> >
> > Hi - one remaining question. Why can't we delay init for all nodes
> > to either drivers or your fallback late_initcall code.
> > It would be nice to reduce possible code paths. =20
>=20
> I try not to change too much of the existing code structure in
> this patchset.
>=20
> To me, postponing/moving all memory tier registrations to
> late_initcall() is another possible action item for the next patchset.
>=20
> After tier_mem(), hmat_init() is called, which requires registering
> `default_dram_type` info. This is when `default_dram_type` is needed.
> However, it is indeed possible to postpone the latter part,
> set_node_memory_tier(), to `late_init(). So, memory_tier_init() can
> indeed be split into two parts, and the latter part can be moved to
> late_initcall() to be processed together.
>=20
> Doing this all memory-type drivers have to call late_initcall() to
> register a memory tier. I=E2=80=99m not sure how many they are?
>=20
> What do you guys think?

Gut feeling - if you are going to move it for some cases, move it for
all of them.  Then we only have to test once ;)

J
>=20
> >
> > Jonathan
> >
> > =20
> > > ---
> > >  mm/memory-tiers.c | 94 +++++++++++++++++++++++++++++++++++----------=
--
> > >  1 file changed, 70 insertions(+), 24 deletions(-)
> > >
> > > diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> > > index 516b144fd45a..6632102bd5c9 100644
> > > --- a/mm/memory-tiers.c
> > > +++ b/mm/memory-tiers.c =20
> >
> >
> > =20
> > > @@ -855,7 +892,8 @@ static int __init memory_tier_init(void)
> > >        * For now we can have 4 faster memory tiers with smaller adist=
ance
> > >        * than default DRAM tier.
> > >        */
> > > -     default_dram_type =3D alloc_memory_type(MEMTIER_ADISTANCE_DRAM);
> > > +     default_dram_type =3D mt_find_alloc_memory_type(MEMTIER_ADISTAN=
CE_DRAM,
> > > +                                                   &default_memory_t=
ypes);
> > >       if (IS_ERR(default_dram_type))
> > >               panic("%s() failed to allocate default DRAM tier\n", __=
func__);
> > >
> > > @@ -865,6 +903,14 @@ static int __init memory_tier_init(void)
> > >        * types assigned.
> > >        */
> > >       for_each_node_state(node, N_MEMORY) {
> > > +             if (!node_state(node, N_CPU))
> > > +                     /*
> > > +                      * Defer memory tier initialization on
> > > +                      * CPUless numa nodes. These will be initialized
> > > +                      * after firmware and devices are initialized. =
=20
> >
> > Could the comment also say why we can't defer them all?
> >
> > (In an odd coincidence we have a similar issue for some CPU hotplug
> >  related bring up where review feedback was move all cases later).
> > =20
> > > +                      */
> > > +                     continue;
> > > +
> > >               memtier =3D set_node_memory_tier(node);
> > >               if (IS_ERR(memtier))
> > >                       /* =20
> > =20
>=20
>=20


