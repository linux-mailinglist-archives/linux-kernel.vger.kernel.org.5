Return-Path: <linux-kernel+bounces-138865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E6E89FB69
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E07B1F23B0A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391AF16E871;
	Wed, 10 Apr 2024 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fpcj2kka"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAA516D30E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 15:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712762587; cv=none; b=RteHCbBTZ6xLdpKyLGGtW9tyPQBiiIUIpFQq0Y1e3+2CJb427LVlHuUkmy5gkLmld1B53Hp6ESjJtzcIsrGuAKVby7JuWPwfvI59towDLLztMJiY+7csWtu2q2xqu4QzIML+x2mv9hRvEMy8gJcVKZKXYyMt1fqOXoXzi8vUyDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712762587; c=relaxed/simple;
	bh=2YA6ScZP2GPnSctrWzlZF+AF+jlSQgnZuSK6LYSu3Wo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ME5voR/NCfgIEC03QLuhVNTASWzHqbaOYh2sfc3m+gZVDum55E1NnRtOZYFySnu3oJfl3bnZgcgs/UAnDSIDl99Him4va+DM08kS61xYD88XM8UD45z8qe3f7qlVQ6Om5IOjWRKO6nTqcaJIuw+t7IEdAZzjoGtQFpcBeGs5WzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fpcj2kka; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712762584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IVcVKrk4PzUgF4HuIkdKngsDaWK3az1O5+iMCoeeUwY=;
	b=Fpcj2kkacXVBs91eS6FDxP4GtLk3y7UKIwgiWh7VpaHMZruCFYkpi7CLlDdRIfFwbU+oq1
	DnAANK9WcHxshTz4gkeu0mNoowpc6Vz5LE9ux59WDYZ/BeT2aGAe69Fkyg5IG1uWIIgoa0
	HOGmqzndwlk7DwID6KFJlUf2Bdt6fRw=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-X3ym9ZzXONqLdowp-1PJrA-1; Wed, 10 Apr 2024 11:23:03 -0400
X-MC-Unique: X3ym9ZzXONqLdowp-1PJrA-1
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-4daa117d98fso2689661e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 08:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712762582; x=1713367382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IVcVKrk4PzUgF4HuIkdKngsDaWK3az1O5+iMCoeeUwY=;
        b=Rtu92W+lrmFmVxvq6vsNBdaQh0Un7ilg/xPxOKkrTCnLXzW9i8S8iM/33Idm2vdg8+
         dIvDD301Tlz8W+Nht79lHPztdx8yVdxquD+ccxHNxDtGUEVZbkQqD4Y9FPjfT/MPoVXs
         sfUfrTkP7qHLSlXkMmBO075ZpeG2VxPLka0Nt/wzkTZ1w0vK2iZBxW7swnv869F6q96K
         8had1amOpiLYs5MQbBgBdIfjapd7aNsLe4WJSpu3rgO4U+21Dzr9CBg0V/uFdqx50YSI
         egd6029s83B7qOvrqAKSnop858LLsBD4xxSSh4IFyk6g47aol4CoABlM51mrOGacPQue
         UEGA==
X-Gm-Message-State: AOJu0YykSbfDRZ2dKEEymkGG8vNy020xtu6XblUT5sbXxlSv1WYtf2IT
	94ZT6AGJhXh3qz+e/0VcU2d5JYtWWiz1sGI/8Clj8ZAT22lPULE1u7nSwWE35Lxatx5x/FZFLzk
	RbYNuymkNKMoYLsuYL4LQ83cMHFuWcL8du3h6EHQYzrfMo5TvmkdL46ZFzD9fHDBytRaGdGZ1tB
	gvEfL5dGSXV3NRMT8vfMLau0uHR5EuLrIeHGXulF2Hpq0tVx4=
X-Received: by 2002:a05:6122:180a:b0:4d4:5d86:b2d with SMTP id ay10-20020a056122180a00b004d45d860b2dmr3229323vkb.16.1712762581867;
        Wed, 10 Apr 2024 08:23:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJWo2zPN31Xwn+WhgCfznSm122A5t6DqHNfh/1O9Ip5bewsx/OT7yR409bQ3WLhcc2xiDSSP0AdARyJNyKtt4=
X-Received: by 2002:a05:6122:180a:b0:4d4:5d86:b2d with SMTP id
 ay10-20020a056122180a00b004d45d860b2dmr3229309vkb.16.1712762581508; Wed, 10
 Apr 2024 08:23:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301203023.2197451-1-jsavitz@redhat.com> <87jzmduiva.fsf@kernel.org>
 <CAL1p7m5BoxFDeK0MryQCmTDCeBLN3rMLRGx3cHa6teS02wsgZw@mail.gmail.com> <CAL1p7m5VHGL+-st7zgGA9LPft6DND=qz0ifiD_ki1hLvfRv=7Q@mail.gmail.com>
In-Reply-To: <CAL1p7m5VHGL+-st7zgGA9LPft6DND=qz0ifiD_ki1hLvfRv=7Q@mail.gmail.com>
From: Joel Savitz <jsavitz@redhat.com>
Date: Wed, 10 Apr 2024 11:22:45 -0400
Message-ID: <CAL1p7m7f=b_qJrU8qea2n1+-1KzEVLMOpY9ov5fH2ZZxGrDK5A@mail.gmail.com>
Subject: Re: [PATCH] powerpc: align memory_limit to 16MB in early_parse_mem
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Benjamin Gray <bgray@linux.ibm.com>, 
	Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@lists.ozlabs.org, 
	Gonzalo Siero <gsierohu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 10:17=E2=80=AFAM Joel Savitz <jsavitz@redhat.com> wr=
ote:
>
> On Tue, Mar 26, 2024 at 12:45=E2=80=AFAM Joel Savitz <jsavitz@redhat.com>=
 wrote:
> >
> > On Fri, Mar 8, 2024 at 5:18=E2=80=AFAM Aneesh Kumar K.V <aneesh.kumar@k=
ernel.org> wrote:
> > >
> > > Joel Savitz <jsavitz@redhat.com> writes:
> > >
> > > > On 64-bit powerpc, usage of a non-16MB-aligned value for the mem=3D=
 kernel
> > > > cmdline parameter results in a system hang at boot.
> > > >
> > > > For example, using 'mem=3D4198400K' will always reproduce this issu=
e.
> > > >
> > > > This patch fixes the problem by aligning any argument to mem=3D to =
16MB
> > > > corresponding with the large page size on powerpc.
> > > >
> > > > Fixes: 2babf5c2ec2f ("[PATCH] powerpc: Unify mem=3D handling")
> > > > Co-developed-by: Gonzalo Siero <gsierohu@redhat.com>
> > > > Signed-off-by: Gonzalo Siero <gsierohu@redhat.com>
> > > > Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> > > > ---
> > > >  arch/powerpc/kernel/prom.c | 6 +++++-
> > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.=
c
> > > > index 0b5878c3125b..8cd3e2445d8a 100644
> > > > --- a/arch/powerpc/kernel/prom.c
> > > > +++ b/arch/powerpc/kernel/prom.c
> > > > @@ -82,8 +82,12 @@ static int __init early_parse_mem(char *p)
> > > >  {
> > > >       if (!p)
> > > >               return 1;
> > > > -
> > > > +#ifdef CONFIG_PPC64
> > > > +     /* Align to 16 MB =3D=3D size of ppc64 large page */
> > > > +     memory_limit =3D ALIGN(memparse(p, &p), 0x1000000);
> > > > +#else
> > > >       memory_limit =3D PAGE_ALIGN(memparse(p, &p));
> > > > +#endif
> > > >       DBG("memory limit =3D 0x%llx\n", memory_limit);
> > > >
> > > >       return 0;
> > > > --
> > > > 2.43.0
> > >
> > > Can you try this change?
> > >
> > > commit 5555bc55e1aa71f545cff31e1eccdb4a2e39df84
> > > Author: Aneesh Kumar K.V (IBM) <aneesh.kumar@kernel.org>
> > > Date:   Fri Mar 8 14:45:26 2024 +0530
> > >
> > >     powerpc/mm: Align memory_limit value specified using mem=3D kerne=
l parameter
> > >
> > >     The value specified for the memory limit is used to set a restric=
tion on
> > >     memory usage. It is important to ensure that this restriction is =
within
> > >     the linear map kernel address space range. The hash page table
> > >     translation uses a 16MB page size to map the kernel linear map ad=
dress
> > >     space. htab_bolt_mapping() function aligns down the size of the r=
ange
> > >     while mapping kernel linear address space. Since the memblock lim=
it is
> > >     enforced very early during boot, before we can detect the type of=
 memory
> > >     translation (radix vs hash), we align the memory limit value spec=
ified
> > >     as a kernel parameter to 16MB. This alignment value will work for=
 both
> > >     hash and radix translations.
> > >
> > >     Signed-off-by: Aneesh Kumar K.V (IBM) <aneesh.kumar@kernel.org>
> > >
> > > diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> > > index 0b5878c3125b..9bd965d35352 100644
> > > --- a/arch/powerpc/kernel/prom.c
> > > +++ b/arch/powerpc/kernel/prom.c
> > > @@ -824,8 +824,11 @@ void __init early_init_devtree(void *params)
> > >                 reserve_crashkernel();
> > >         early_reserve_mem();
> > >
> > > -       /* Ensure that total memory size is page-aligned. */
> > > -       limit =3D ALIGN(memory_limit ?: memblock_phys_mem_size(), PAG=
E_SIZE);
> > > +       if (memory_limit > memblock_phys_mem_size())
> > > +               memory_limit =3D 0;
> > > +
> > > +       /* Align down to 16 MB which is large page size with hash pag=
e translation */
> > > +       limit =3D ALIGN_DOWN(memory_limit ?: memblock_phys_mem_size()=
, SZ_16M);
> > >         memblock_enforce_memory_limit(limit);
> > >
> > >  #if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_PPC_4K_PAGES)
> > > diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/pr=
om_init.c
> > > index e67effdba85c..d6410549e141 100644
> > > --- a/arch/powerpc/kernel/prom_init.c
> > > +++ b/arch/powerpc/kernel/prom_init.c
> > > @@ -817,8 +817,8 @@ static void __init early_cmdline_parse(void)
> > >                 opt +=3D 4;
> > >                 prom_memory_limit =3D prom_memparse(opt, (const char =
**)&opt);
> > >  #ifdef CONFIG_PPC64
> > > -               /* Align to 16 MB =3D=3D size of ppc64 large page */
> > > -               prom_memory_limit =3D ALIGN(prom_memory_limit, 0x1000=
000);
> > > +               /* Align down to 16 MB which is large page size with =
hash page translation */
> > > +               prom_memory_limit =3D ALIGN_DOWN(prom_memory_limit, S=
Z_16M);
> > >  #endif
> > >         }
> > >
> > >
> >
> > Sorry for the delayed reply. I just tested this patch and it fixes the
> > bug for me.
>
> Hi,
>
> Just a quick follow up on this.
>
> The above patch fixed the bug for me.
>
> How do we want to proceed?
>
> Best,
> Joel Savitz

Hi,

I haven't heard anything on this thread so I'm just sending a quick follow =
up.

Do we want to merge this

Best,
Joel Savitz


