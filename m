Return-Path: <linux-kernel+bounces-133690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7670189A764
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30BF1F22BA4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821E72E65B;
	Fri,  5 Apr 2024 22:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Q9YOAa8G"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5DA2D022
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 22:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712357041; cv=none; b=AeVnOzv5S9s2yfW0L7Jq9IgNF1J99fo6jbj6dqYTNYUak5JuFJuBj3/IKW/143yzv7B9stpzd6+7m+vjTRK1AeZg4vHwki6OjAz3Zzx6ZyjiwvFYCEQL7IXM97RVzmJ4JV71pK5mWtIyIrRlOtn7lIxm+cK6BDNdv6LXeIKcrsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712357041; c=relaxed/simple;
	bh=JrWgAMwL1kvDvWJdq7P6eEwvsYKZ6eqw3MbLIeb0B38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kd9doxW+iEETLkb1Nh1c3mKwENCUKsnhaw9zF6G0iDJPpMY4xMvhW/a7FhFud2ae3ZWBY9bKM+FXnvF7mEDACE9I/6Zg2ZGqHhf0Ny2OhPrq4zGHQtGxmGJAvyWUY7sq4Y1m5Um6DHm77Qc8WJIU6AEMdLpzvs97Fw9QQrUDf+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Q9YOAa8G; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dd14d8e7026so2630025276.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 15:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712357038; x=1712961838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCBHfr4VKJb+nF0gfasAMfqJdSwuuy6m/sFNcO7Zez0=;
        b=Q9YOAa8GZOwgG18/U3r8Q3MIa+ALoE79ihoU/xDJ5JmaAYP8BKpxdh13i01nFQd7sq
         hJJoeqVsCQWCHTVZ6s0xSO6Qb1zFzD6MEwFoP1PT1usfkqZutBKKSt+qlJNkfdX/FWjf
         VCQJsULhL4fQMx2EzYT5GHe8Jz1UZaQhBvoEhqj5JaAVJiqCtNvYw6WXaoYQdQGaISQF
         YOg71K3AOEUi2mvCSX8zcPddQlW5W1XrXe601XZ/QldUM0c/nootaS4/nRs52dw+Znv3
         SKwQTr8VRiDFuHOthOyuIh4Z7fe4nkd2na2nDE6wf3TbKMATCVO6oA13GWSsFMa1YUoi
         Kulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712357038; x=1712961838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hCBHfr4VKJb+nF0gfasAMfqJdSwuuy6m/sFNcO7Zez0=;
        b=Ij4jZ/rjJ79eQCPzi9nCDqqXrk/zWqRyVDrI1M5MLah9wvgkzmvsOwtHj/+pUs62UH
         bVhWHA5wZpgYjQCb+xl0AYMe2/5hHcAGvTTyucRX1oNNlVBAc2/OUKEhX5gclkwgMqA5
         BRWygKFHJD1cYYhQPEi0jgMU1TPurFaoK+Fg3uVZzYkMyH3bY+pQxx1rBgBtpMtwd3Y3
         zP0Io47xMy+mdNyzmdVRJ81T6S0Y7NmB6sl+BGFZ4P55tC0K79NKWY7gTUL7xu+vki1m
         3ZM+/zZED2h0mFC/fGRqz5ASJ0emadfjMpdLyyIYmM4hStNIzdt1XyQcbs/a4aZzCNTf
         NLpw==
X-Forwarded-Encrypted: i=1; AJvYcCU7Yz6yp6kQ0t0MLiHoGloxXHQj2I1d0Cj8mvqTCeWIvmjXIR8sVEhig8sNS9PK4sqFyTMWFYds1L0wM1pgUgGfwqZCujGc0XKMdPJc
X-Gm-Message-State: AOJu0Yy/tG/jKMsDBAEVCn3sA+ON3XwBJE3klmwCAd9Gng4jsIroK4WZ
	jJ1QAoK8tiLeNV0Crzcv03OGTdqjZqYZ0AiAAWODL2DpAb0mJHz1wSutTUgNznbXhuR0PkqPNYf
	DUrMNWZWo+Pz8ZP2fAgYvWR1qhynpxPWrad0G8A==
X-Google-Smtp-Source: AGHT+IGkc0Q0l/mos/5NT0gBK0qJn5r1i2V05XNXtK/wcS38g1Oz3fhqPqidWAK23808M9UnRFIa1KWgPI5kzEPoB9g=
X-Received: by 2002:a25:6b51:0:b0:dc6:bbbc:80e4 with SMTP id
 o17-20020a256b51000000b00dc6bbbc80e4mr2701001ybm.4.1712357037795; Fri, 05 Apr
 2024 15:43:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405000707.2670063-1-horenchuang@bytedance.com>
 <20240405000707.2670063-3-horenchuang@bytedance.com> <20240405150244.00004b49@Huawei.com>
In-Reply-To: <20240405150244.00004b49@Huawei.com>
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Date: Fri, 5 Apr 2024 15:43:47 -0700
Message-ID: <CAKPbEqpGM_nR+LKbsoFTviBZaKUKYqJ3zbJp9EOCJAGvuPy6aQ@mail.gmail.com>
Subject: Re: [PATCH v11 2/2] memory tier: create CPUless memory tiers after
 obtaining HMAT info
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

On Fri, Apr 5, 2024 at 7:03=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri,  5 Apr 2024 00:07:06 +0000
> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> wrote:
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
> > Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
>
> Hi - one remaining question. Why can't we delay init for all nodes
> to either drivers or your fallback late_initcall code.
> It would be nice to reduce possible code paths.

I try not to change too much of the existing code structure in
this patchset.

To me, postponing/moving all memory tier registrations to
late_initcall() is another possible action item for the next patchset.

After tier_mem(), hmat_init() is called, which requires registering
`default_dram_type` info. This is when `default_dram_type` is needed.
However, it is indeed possible to postpone the latter part,
set_node_memory_tier(), to `late_init(). So, memory_tier_init() can
indeed be split into two parts, and the latter part can be moved to
late_initcall() to be processed together.

Doing this all memory-type drivers have to call late_initcall() to
register a memory tier. I=E2=80=99m not sure how many they are?

What do you guys think?

>
> Jonathan
>
>
> > ---
> >  mm/memory-tiers.c | 94 +++++++++++++++++++++++++++++++++++------------
> >  1 file changed, 70 insertions(+), 24 deletions(-)
> >
> > diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> > index 516b144fd45a..6632102bd5c9 100644
> > --- a/mm/memory-tiers.c
> > +++ b/mm/memory-tiers.c
>
>
>
> > @@ -855,7 +892,8 @@ static int __init memory_tier_init(void)
> >        * For now we can have 4 faster memory tiers with smaller adistan=
ce
> >        * than default DRAM tier.
> >        */
> > -     default_dram_type =3D alloc_memory_type(MEMTIER_ADISTANCE_DRAM);
> > +     default_dram_type =3D mt_find_alloc_memory_type(MEMTIER_ADISTANCE=
_DRAM,
> > +                                                   &default_memory_typ=
es);
> >       if (IS_ERR(default_dram_type))
> >               panic("%s() failed to allocate default DRAM tier\n", __fu=
nc__);
> >
> > @@ -865,6 +903,14 @@ static int __init memory_tier_init(void)
> >        * types assigned.
> >        */
> >       for_each_node_state(node, N_MEMORY) {
> > +             if (!node_state(node, N_CPU))
> > +                     /*
> > +                      * Defer memory tier initialization on
> > +                      * CPUless numa nodes. These will be initialized
> > +                      * after firmware and devices are initialized.
>
> Could the comment also say why we can't defer them all?
>
> (In an odd coincidence we have a similar issue for some CPU hotplug
>  related bring up where review feedback was move all cases later).
>
> > +                      */
> > +                     continue;
> > +
> >               memtier =3D set_node_memory_tier(node);
> >               if (IS_ERR(memtier))
> >                       /*
>


--=20
Best regards,
Ho-Ren (Jack) Chuang
=E8=8E=8A=E8=B3=80=E4=BB=BB

