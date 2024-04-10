Return-Path: <linux-kernel+bounces-137951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F1C89EA38
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAED81C21EBE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907441C6AD;
	Wed, 10 Apr 2024 05:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eI9yDIir"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7583427453
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 05:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712728569; cv=none; b=D3oZuRZksd2/exsQSXxuqJenKUDpgy24W3QEzrxjeri0JdzliWedHNNyBjMCWatlGLpIk8Xwg1idbeYrpdLt+feOt8bQVnjlp1+fGHfkuQmbHeYl39iWrHaHQev4CQ3NsqnaK1VbjMgB654UY0hG2+MUJbOBkKrEJJbk8JuvuqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712728569; c=relaxed/simple;
	bh=iRWSGvESmj50SK/3+gdejLYH0/TGzOFnE+pS8ZkDCcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dA8yvTkIqPtVhREM7YduEEhdwWofK3UF68Yz8KBpqa/jEo6NLPTj9gTgvLuyvPY8VJLPNtl0FhpfHbKkK7W2YLnpPgfU6UeDpCGJIpPwaDD/giqRCEJdJzUyCNlm430EE422mmnbrsCahLywolKufT+weOC8MSLmNchomnDgYd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eI9yDIir; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcc80d6004bso6445176276.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 22:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712728565; x=1713333365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqGY/vGIyR9LCZTBxU/bq4zwRiV3ymHiMH0aV8SV/K8=;
        b=eI9yDIir0ScwLq6U7sh4XaUhPRPKZq4v0oZtdcKLmrskAEA7PTm4WXHIDVE047iFXh
         nUzC8npiXMtss/N27lA2tDlgsW50ikTy45ni58yiFuvRomwItRiJgRZaXg9V+d6KzuUA
         e8WbP54N0Hv8TdKlK9I9Kdb/ypHWcEFNysZwZbuhuXo0hvl3l3KVbjBBM3Ul8Gmi6TKX
         2BEt19zoddP+zsYumm9yUTJ9xVZKL4RZngG2+SDFpq3TT59T1Z8ER8eLxRB943VR8JXq
         tLX8OKyYhkVEhwdd3MgoE9cfy7b3mle+zqqrZ7Z0hRoiL595IuHiYogj0BS92TwUEHKf
         Qj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712728565; x=1713333365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqGY/vGIyR9LCZTBxU/bq4zwRiV3ymHiMH0aV8SV/K8=;
        b=jWnSsJxc2CbPNofi60BVH+31UryPLNmlse1L5vUcAO+uq2e73xZ8j8jF3lxT2jscr9
         6LZwTKnVBtXeRsRrO5x0uE8smOjQKlb6ikSsGjrxVC9WlNPrdCFfEIIjybNgtWI2AdKZ
         3K3BUW8VMG9Ml8rzDTTGsNe72r+ZVyasvA4pr08PyKfAII10+lOzHfaZyV9D1ueRaBCs
         pMK7ZxRxrv2WohY2y8wZ5a5lOAqKBYVSP8oLPl2J1qiZb0V3jsxOxUhD8q4A014QnD6Q
         qNuMeCsoTVWXuZi40q1gbcXwaCbp938HhwGVWUYNpr7DhYIaPY2VuoEw6OQZW2hmnTWZ
         50xA==
X-Forwarded-Encrypted: i=1; AJvYcCVNW74S7rP+ery3GBO7yx6dz7hTw8wlEjQoFs7OJtnLtRdqpP3QT6COIMEJKVLK7iejhlWYfErZ2EV9cuGIoeUwgkRDQhmfvTaHVmaD
X-Gm-Message-State: AOJu0YznTgtVon5djeDLyPzL+icCk5vlImpoGibj08cs/T7b3ozoI83b
	pRKMLCLv5wMpm0vTsR+vkOfa9xoX32nM2Gz2mE6Gu/j01MrE0j7AZLdFKLMZr/UvHTi867Vprdv
	4UhOuqQT3UDVcPjprpHSwbuA0l7KMcSyJVEaurQ==
X-Google-Smtp-Source: AGHT+IHeeE9q1+cJcZFRlCtvV1BbpZVxnUEWrSDgdRRs3q/CuKFEvKs0kmjhM3Z408INF7Cm0W+a8a8XNmlyII/QV0E=
X-Received: by 2002:a25:be92:0:b0:dcd:5635:5c11 with SMTP id
 i18-20020a25be92000000b00dcd56355c11mr1731856ybk.45.1712728565448; Tue, 09
 Apr 2024 22:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405000707.2670063-1-horenchuang@bytedance.com>
 <20240405000707.2670063-3-horenchuang@bytedance.com> <20240405150244.00004b49@Huawei.com>
 <CAKPbEqpGM_nR+LKbsoFTviBZaKUKYqJ3zbJp9EOCJAGvuPy6aQ@mail.gmail.com> <87ttka54pr.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87ttka54pr.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Date: Tue, 9 Apr 2024 22:55:54 -0700
Message-ID: <CAKPbEqqH0nhVUAcJUxDc_bPewY85+TqhtO94MyypV35GBo33+A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v11 2/2] memory tier: create CPUless memory
 tiers after obtaining HMAT info
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Gregory Price <gourry.memverge@gmail.com>, 
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

On Tue, Apr 9, 2024 at 7:33=E2=80=AFPM Huang, Ying <ying.huang@intel.com> w=
rote:
>
> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:
>
> > On Fri, Apr 5, 2024 at 7:03=E2=80=AFAM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> >>
> >> On Fri,  5 Apr 2024 00:07:06 +0000
> >> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> wrote:
> >>
> >> > The current implementation treats emulated memory devices, such as
> >> > CXL1.1 type3 memory, as normal DRAM when they are emulated as normal=
 memory
> >> > (E820_TYPE_RAM). However, these emulated devices have different
> >> > characteristics than traditional DRAM, making it important to
> >> > distinguish them. Thus, we modify the tiered memory initialization p=
rocess
> >> > to introduce a delay specifically for CPUless NUMA nodes. This delay
> >> > ensures that the memory tier initialization for these nodes is defer=
red
> >> > until HMAT information is obtained during the boot process. Finally,
> >> > demotion tables are recalculated at the end.
> >> >
> >> > * late_initcall(memory_tier_late_init);
> >> > Some device drivers may have initialized memory tiers between
> >> > `memory_tier_init()` and `memory_tier_late_init()`, potentially brin=
ging
> >> > online memory nodes and configuring memory tiers. They should be exc=
luded
> >> > in the late init.
> >> >
> >> > * Handle cases where there is no HMAT when creating memory tiers
> >> > There is a scenario where a CPUless node does not provide HMAT infor=
mation.
> >> > If no HMAT is specified, it falls back to using the default DRAM tie=
r.
> >> >
> >> > * Introduce another new lock `default_dram_perf_lock` for adist calc=
ulation
> >> > In the current implementation, iterating through CPUlist nodes requi=
res
> >> > holding the `memory_tier_lock`. However, `mt_calc_adistance()` will =
end up
> >> > trying to acquire the same lock, leading to a potential deadlock.
> >> > Therefore, we propose introducing a standalone `default_dram_perf_lo=
ck` to
> >> > protect `default_dram_perf_*`. This approach not only avoids deadloc=
k
> >> > but also prevents holding a large lock simultaneously.
> >> >
> >> > * Upgrade `set_node_memory_tier` to support additional cases, includ=
ing
> >> >   default DRAM, late CPUless, and hot-plugged initializations.
> >> > To cover hot-plugged memory nodes, `mt_calc_adistance()` and
> >> > `mt_find_alloc_memory_type()` are moved into `set_node_memory_tier()=
` to
> >> > handle cases where memtype is not initialized and where HMAT informa=
tion is
> >> > available.
> >> >
> >> > * Introduce `default_memory_types` for those memory types that are n=
ot
> >> >   initialized by device drivers.
> >> > Because late initialized memory and default DRAM memory need to be m=
anaged,
> >> > a default memory type is created for storing all memory types that a=
re
> >> > not initialized by device drivers and as a fallback.
> >> >
> >> > Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> >> > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> >> > Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> >>
> >> Hi - one remaining question. Why can't we delay init for all nodes
> >> to either drivers or your fallback late_initcall code.
> >> It would be nice to reduce possible code paths.
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
>
> I don't think that it's good to move all memory_tier initialization in
> drivers to late_initcall().  It's natural to keep them in
> device_initcall() level.
>
> If so, we can allocate default_dram_type in memory_tier_init(), and call
> set_node_memory_tier() only in memory_tier_lateinit().  We can call
> memory_tier_lateinit() in device_initcall() level too.
>

It makes sense to me to leave only `default_dram_type ` and
hotplug_init() in memory_tier_init(), postponing all
set_node_memory_tier()s to memory_tier_late_init()

Would it be possible there is no device_initcall() calling
memory_tier_late_init()? If yes, I think putting memory_tier_late_init()
in late_init() is still necessary.

> --
> Best Regards,
> Huang, Ying
>
> > Doing this all memory-type drivers have to call late_initcall() to
> > register a memory tier. I=E2=80=99m not sure how many they are?
> >
> > What do you guys think?
> >
> >>
> >> Jonathan
> >>
> >>
> >> > ---
> >> >  mm/memory-tiers.c | 94 +++++++++++++++++++++++++++++++++++---------=
---
> >> >  1 file changed, 70 insertions(+), 24 deletions(-)
> >> >
> >> > diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> >> > index 516b144fd45a..6632102bd5c9 100644
> >> > --- a/mm/memory-tiers.c
> >> > +++ b/mm/memory-tiers.c
> >>
> >>
> >>
> >> > @@ -855,7 +892,8 @@ static int __init memory_tier_init(void)
> >> >        * For now we can have 4 faster memory tiers with smaller adis=
tance
> >> >        * than default DRAM tier.
> >> >        */
> >> > -     default_dram_type =3D alloc_memory_type(MEMTIER_ADISTANCE_DRAM=
);
> >> > +     default_dram_type =3D mt_find_alloc_memory_type(MEMTIER_ADISTA=
NCE_DRAM,
> >> > +                                                   &default_memory_=
types);
> >> >       if (IS_ERR(default_dram_type))
> >> >               panic("%s() failed to allocate default DRAM tier\n", _=
_func__);
> >> >
> >> > @@ -865,6 +903,14 @@ static int __init memory_tier_init(void)
> >> >        * types assigned.
> >> >        */
> >> >       for_each_node_state(node, N_MEMORY) {
> >> > +             if (!node_state(node, N_CPU))
> >> > +                     /*
> >> > +                      * Defer memory tier initialization on
> >> > +                      * CPUless numa nodes. These will be initializ=
ed
> >> > +                      * after firmware and devices are initialized.
> >>
> >> Could the comment also say why we can't defer them all?
> >>
> >> (In an odd coincidence we have a similar issue for some CPU hotplug
> >>  related bring up where review feedback was move all cases later).
> >>
> >> > +                      */
> >> > +                     continue;
> >> > +
> >> >               memtier =3D set_node_memory_tier(node);
> >> >               if (IS_ERR(memtier))
> >> >                       /*
> >>



--=20
Best regards,
Ho-Ren (Jack) Chuang
=E8=8E=8A=E8=B3=80=E4=BB=BB

