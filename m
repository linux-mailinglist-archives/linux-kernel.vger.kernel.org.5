Return-Path: <linux-kernel+bounces-137496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD62289E2E5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 109F9B22965
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EC6156F50;
	Tue,  9 Apr 2024 19:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Izq4ogMf"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFA7157489
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 19:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712689365; cv=none; b=l40RZwp7j0Je5beIEVIqySvVXCl15YjLYC0i8Bq7j7bG9nMBHah/EYfOcmz9tB1S1OzntRe7Sqp5a2SjxJUYYa9U5TFvgqME1gdF4rSyXKi9NO+d5xXkzhA8WRGM123HoCr6zfgmeUI+dVndU9OsZfLxec7BhpywH/Cnh72Zt5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712689365; c=relaxed/simple;
	bh=pjO/EdIcJWhe4jLC9dLVMdCS9P4ixop/idJjzexUyv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OOhRFMbasJrFtRZHZPpr8XEIRN19xD7FZgFdsXY8XiP0IJtmmYk1kyqmDqGKkU+HFht+pL+4ioeKnX/BrieTB2wlp3fOIHBGRiY9Moo5BCNfWSJh4h+nlrF+fPLOfSqLNVc0/yh/8caI+nHxt3d11JVdfsJPzaxVTdwgVkGJvw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Izq4ogMf; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcc80d6004bso6051173276.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 12:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712689362; x=1713294162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9JT5x/b9oaUqCAXwkz87p9Kfabiba0RNb5HLj9kkfw=;
        b=Izq4ogMfAavb1rQq2gEQ9afDj2/DJ2gaL1zYfiCuitlv+jfepFFaN2lP2sEyQeLtxZ
         gxFN4BrH15VcOT+ZPKyrkW8oS8TGeNOhZ8ynOJVjmyMjqb0hI62mx1PljsdUIQm4VTbs
         V4y+9cfr6fekOV3le0fpbUySwfxTI4PNWLGiMa1X45POvaM4DVXGqRrMYP++o7+LKWWI
         KYjVQi1AvmScnEFj/d8FI457nwbXfdu5XGa70LOek4ApNbmwHZMHiTe1YJkfVjpQOckE
         MNkmXSyIcD/6OSzcFxMKu1x+PfTUnOX4RkLnvV7nLAeK1hhyLb+yhXUZ5h+KGUUq+vMX
         p/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712689362; x=1713294162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9JT5x/b9oaUqCAXwkz87p9Kfabiba0RNb5HLj9kkfw=;
        b=wkJ0P8RnOSLTw3+00gFT6JJ0V7LhB4mpYMx+mGCo3pNi9YRdztIss7y1F4onUxfI2K
         oZCc0M46OJgVxChIiRbeiFUIsOC7JoK2+2DjPaWkurCqJCDvmZkOwBk5p1Y3+lFQglqE
         9fNqvOifhaicmnJ/iXSyufOs/JhU0bythtF0n8wMYCC3JNa83BRzP1yOjI6gD/eih3qt
         vK/FPuzkjKiuEWW4d+wI6giELoIADwsyXELiR2ZLL0VwsIPa6r3YKnfQ6/TPKgbLhMf7
         fmci/37hYKW0+mUiT0SgjiWAUJPAvgofIlIueuwseLuY5HReOCK2mrn/cwonVsMM54VJ
         pkfg==
X-Forwarded-Encrypted: i=1; AJvYcCWjNLAaRXHHLjeAsuqxrhQuSReJfUMZujZbNhHiRxTCGwSnDahjuguNc7uXO9QvVMRwYwVIOgDNsR+ePPpY0EB0Dg2xN1MTMLfkCn9j
X-Gm-Message-State: AOJu0YxokCBG2OYuWMK5asvZ8EfapqjviM1X6DFcSS0E8gnyyyUPJME6
	II3zqDwENA4bdntULHGGltWjSH8zpcPnDo3Aq0VX6kGlNc/rJZUnS7trFOjHz9AtfOtRk5yJftw
	+nTD0j2K/AipOY8xIY4Xmj09F424hXhay5VynYw==
X-Google-Smtp-Source: AGHT+IEhGXon713SAihpC+CGTqCe5Yi+IkEzhQrqxAFLZdzLSTS9HBsKOtlx/4EZ5ThM7PRsnpjepkyCsqvR+OR0zTE=
X-Received: by 2002:a5b:ac2:0:b0:de0:de85:e388 with SMTP id
 a2-20020a5b0ac2000000b00de0de85e388mr666317ybr.24.1712689362423; Tue, 09 Apr
 2024 12:02:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405000707.2670063-1-horenchuang@bytedance.com>
 <20240405000707.2670063-3-horenchuang@bytedance.com> <20240405150244.00004b49@Huawei.com>
 <CAKPbEqpGM_nR+LKbsoFTviBZaKUKYqJ3zbJp9EOCJAGvuPy6aQ@mail.gmail.com> <20240409171204.00001710@Huawei.com>
In-Reply-To: <20240409171204.00001710@Huawei.com>
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Date: Tue, 9 Apr 2024 12:02:31 -0700
Message-ID: <CAKPbEqry55fc51hQ8oUC8so=PD_wWoJMEPiR-eq03BgB5q86Yw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v11 2/2] memory tier: create CPUless memory
 tiers after obtaining HMAT info
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, Gregory Price <gourry.memverge@gmail.com>, 
	aneesh.kumar@linux.ibm.com, mhocko@suse.com, tj@kernel.org, 
	john@jagalactic.com, Eishan Mirakhur <emirakhur@micron.com>, 
	Vinicius Tavares Petrucci <vtavarespetr@micron.com>, Ravis OpenSrc <Ravis.OpenSrc@micron.com>, 
	Alistair Popple <apopple@nvidia.com>, Srinivasulu Thanneeru <sthanneeru@micron.com>, 
	SeongJae Park <sj@kernel.org>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linux Memory Management List <linux-mm@kvack.org>, "Ho-Ren (Jack) Chuang" <horenc@vt.edu>, 
	"Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, qemu-devel@nongnu.org, 
	Hao Xiang <hao.xiang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Tue, Apr 9, 2024 at 9:12=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 5 Apr 2024 15:43:47 -0700
> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> wrote:
>
> > On Fri, Apr 5, 2024 at 7:03=E2=80=AFAM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Fri,  5 Apr 2024 00:07:06 +0000
> > > "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> wrote:
> > >
> > > > The current implementation treats emulated memory devices, such as
> > > > CXL1.1 type3 memory, as normal DRAM when they are emulated as norma=
l memory
> > > > (E820_TYPE_RAM). However, these emulated devices have different
> > > > characteristics than traditional DRAM, making it important to
> > > > distinguish them. Thus, we modify the tiered memory initialization =
process
> > > > to introduce a delay specifically for CPUless NUMA nodes. This dela=
y
> > > > ensures that the memory tier initialization for these nodes is defe=
rred
> > > > until HMAT information is obtained during the boot process. Finally=
,
> > > > demotion tables are recalculated at the end.
> > > >
> > > > * late_initcall(memory_tier_late_init);
> > > > Some device drivers may have initialized memory tiers between
> > > > `memory_tier_init()` and `memory_tier_late_init()`, potentially bri=
nging
> > > > online memory nodes and configuring memory tiers. They should be ex=
cluded
> > > > in the late init.
> > > >
> > > > * Handle cases where there is no HMAT when creating memory tiers
> > > > There is a scenario where a CPUless node does not provide HMAT info=
rmation.
> > > > If no HMAT is specified, it falls back to using the default DRAM ti=
er.
> > > >
> > > > * Introduce another new lock `default_dram_perf_lock` for adist cal=
culation
> > > > In the current implementation, iterating through CPUlist nodes requ=
ires
> > > > holding the `memory_tier_lock`. However, `mt_calc_adistance()` will=
 end up
> > > > trying to acquire the same lock, leading to a potential deadlock.
> > > > Therefore, we propose introducing a standalone `default_dram_perf_l=
ock` to
> > > > protect `default_dram_perf_*`. This approach not only avoids deadlo=
ck
> > > > but also prevents holding a large lock simultaneously.
> > > >
> > > > * Upgrade `set_node_memory_tier` to support additional cases, inclu=
ding
> > > >   default DRAM, late CPUless, and hot-plugged initializations.
> > > > To cover hot-plugged memory nodes, `mt_calc_adistance()` and
> > > > `mt_find_alloc_memory_type()` are moved into `set_node_memory_tier(=
)` to
> > > > handle cases where memtype is not initialized and where HMAT inform=
ation is
> > > > available.
> > > >
> > > > * Introduce `default_memory_types` for those memory types that are =
not
> > > >   initialized by device drivers.
> > > > Because late initialized memory and default DRAM memory need to be =
managed,
> > > > a default memory type is created for storing all memory types that =
are
> > > > not initialized by device drivers and as a fallback.
> > > >
> > > > Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> > > > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> > > > Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> > >
> > > Hi - one remaining question. Why can't we delay init for all nodes
> > > to either drivers or your fallback late_initcall code.
> > > It would be nice to reduce possible code paths.
> >
> > I try not to change too much of the existing code structure in
> > this patchset.
> >
> > To me, postponing/moving all memory tier registrations to
> > late_initcall() is another possible action item for the next patchset.
> >
> > After tier_mem(), hmat_init() is called, which requires registering
> > `default_dram_type` info. This is when `default_dram_type` is needed.
> > However, it is indeed possible to postpone the latter part,
> > set_node_memory_tier(), to `late_init(). So, memory_tier_init() can
> > indeed be split into two parts, and the latter part can be moved to
> > late_initcall() to be processed together.
> >
> > Doing this all memory-type drivers have to call late_initcall() to
> > register a memory tier. I=E2=80=99m not sure how many they are?
> >
> > What do you guys think?
>
> Gut feeling - if you are going to move it for some cases, move it for
> all of them.  Then we only have to test once ;)
>
> J

Thank you for your reminder! I agree~ That's why I'm considering
changing them in the next patchset because of the amount of changes.
And also, this patchset already contains too many things.

> >
> > >
> > > Jonathan
> > >
> > >
> > > > ---
> > > >  mm/memory-tiers.c | 94 +++++++++++++++++++++++++++++++++++--------=
----
> > > >  1 file changed, 70 insertions(+), 24 deletions(-)
> > > >
> > > > diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> > > > index 516b144fd45a..6632102bd5c9 100644
> > > > --- a/mm/memory-tiers.c
> > > > +++ b/mm/memory-tiers.c
> > >
> > >
> > >
> > > > @@ -855,7 +892,8 @@ static int __init memory_tier_init(void)
> > > >        * For now we can have 4 faster memory tiers with smaller adi=
stance
> > > >        * than default DRAM tier.
> > > >        */
> > > > -     default_dram_type =3D alloc_memory_type(MEMTIER_ADISTANCE_DRA=
M);
> > > > +     default_dram_type =3D mt_find_alloc_memory_type(MEMTIER_ADIST=
ANCE_DRAM,
> > > > +                                                   &default_memory=
_types);
> > > >       if (IS_ERR(default_dram_type))
> > > >               panic("%s() failed to allocate default DRAM tier\n", =
__func__);
> > > >
> > > > @@ -865,6 +903,14 @@ static int __init memory_tier_init(void)
> > > >        * types assigned.
> > > >        */
> > > >       for_each_node_state(node, N_MEMORY) {
> > > > +             if (!node_state(node, N_CPU))
> > > > +                     /*
> > > > +                      * Defer memory tier initialization on
> > > > +                      * CPUless numa nodes. These will be initiali=
zed
> > > > +                      * after firmware and devices are initialized=
.
> > >
> > > Could the comment also say why we can't defer them all?
> > >
> > > (In an odd coincidence we have a similar issue for some CPU hotplug
> > >  related bring up where review feedback was move all cases later).
> > >
> > > > +                      */
> > > > +                     continue;
> > > > +
> > > >               memtier =3D set_node_memory_tier(node);
> > > >               if (IS_ERR(memtier))
> > > >                       /*
> > >
> >
> >
>


--=20
Best regards,
Ho-Ren (Jack) Chuang
=E8=8E=8A=E8=B3=80=E4=BB=BB

