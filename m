Return-Path: <linux-kernel+bounces-126736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3722E893C18
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B811C20E67
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973FB4087A;
	Mon,  1 Apr 2024 14:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwCT/04G"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0AE3FE2D
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 14:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711981064; cv=none; b=T73Hys4aFWqcewaoAFX6KT+W+cHUnfJGBZ/0wdnbIJ5uAI6cb9sctVJVSLbwv94LTkWbhZrcoYlBYMnG04P+7QZoS08wbKV2p7dlJlcm/HbLOVMeT42zzEHX/rfCC/7PPYFjvFVJ6BDGvBetS6jjflLxNMuHWHVujYRRT5Z3uVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711981064; c=relaxed/simple;
	bh=BpS4pipU3ByiDbGb6EOGazi3orlwJfalP1pR72F+5Rc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rF5U2/vLy41eoLrfESBBYVVk4UYFgX9OR9CSdAMRP0PwA+q3gQYxSlA5fY2/V7WEJd1b2bwDsBUrXO3aOK7bfL0s7gDb0MCX74JNKCkKCYMnJHyX8p9L6Vzyr9KVaqWWYyX2XNob46URG8dLksUUPEiffKWfKui7na0V6ssMvoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fwCT/04G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711981061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CJRxiasyHmUKvqfQpZ1nrM5CdUFwh/nhoJJg5a06Pdg=;
	b=fwCT/04GW/BuU1eVCthO/QK/MIVEs0hjH3Iro15H7rigC8KDKWVgKEeAEnFrBHJiQrNFZH
	lTPhc1KRziryp/foCN4WbPsfg1tGPklWk+Yg22rd3RgO689EyB7mcjtOjrAOSrL+TeHVAO
	sOf7/xpNGgNpzA3RpSsLrRlLmcrVpLI=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-crdgSQwpP9iVYxwwRGWCnQ-1; Mon, 01 Apr 2024 10:17:39 -0400
X-MC-Unique: crdgSQwpP9iVYxwwRGWCnQ-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3c3cfc89b23so3031477b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 07:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711981059; x=1712585859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJRxiasyHmUKvqfQpZ1nrM5CdUFwh/nhoJJg5a06Pdg=;
        b=lMLNXxkf3NIXKBV9mHGdm63Ty+0Z/+Uue2NP3/xE5luGEhRGUKhySxARwIwXGd9h2i
         BbsihNuxWy1cWyIFWpXlisDcT2zctZpLV7BxS4iRhCXgwbLqoiJsV2MARkAukcbns36m
         fcktXiV+mmPbB3GkCBJmzJTmOjenMcS3OaYqs6RylSaA1+fNHiSeuNfculmlGYTFPJSB
         iqHESK6TRd0nN5qIuXMJbBIfge1cIK7EeNyYOJ3ad6pznhAEOwnXGZiI+WPjWl2hEzWh
         LFEocm5FUMRPmTRcEpwEQURF/+kR2OExJ8/sWz4+x5wlYzxAfJJrlhnjr6qr6hUjXlGX
         6qyQ==
X-Gm-Message-State: AOJu0YzeyTNc+aGWzSqclhfFrc2ldkNm5gv28nDtogrF3y9pi1MJmI35
	0CWpNcAvOHttJVzsvEhTzqE6N3BEu7WKnb92jNQBbmzCJzfpHv/qurQAmpQbbzbcSAPmB7V+yWc
	fHjDZXXyqLpkFmPHFCaoM1Iuh+l3SltYVQdJJIgFdydzTXZJbHT+tWS46LGqvLgNCOm6G1sfwCN
	g2IIU7CQyIhe8+BtJ40joZwO+KybvN+MMWwB0g
X-Received: by 2002:a05:6808:1995:b0:3c3:8517:3472 with SMTP id bj21-20020a056808199500b003c385173472mr14104557oib.41.1711981057495;
        Mon, 01 Apr 2024 07:17:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKAaot5gPu/xKNuoiU5ZEryU7ovco8JGNrBFL3wur8CERMVFMJ3iEOAuH9JO+iko79W/n109Mabrud3lV8ZsM=
X-Received: by 2002:a05:6808:1995:b0:3c3:8517:3472 with SMTP id
 bj21-20020a056808199500b003c385173472mr14104453oib.41.1711981055880; Mon, 01
 Apr 2024 07:17:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301203023.2197451-1-jsavitz@redhat.com> <87jzmduiva.fsf@kernel.org>
 <CAL1p7m5BoxFDeK0MryQCmTDCeBLN3rMLRGx3cHa6teS02wsgZw@mail.gmail.com>
In-Reply-To: <CAL1p7m5BoxFDeK0MryQCmTDCeBLN3rMLRGx3cHa6teS02wsgZw@mail.gmail.com>
From: Joel Savitz <jsavitz@redhat.com>
Date: Mon, 1 Apr 2024 10:17:19 -0400
Message-ID: <CAL1p7m5VHGL+-st7zgGA9LPft6DND=qz0ifiD_ki1hLvfRv=7Q@mail.gmail.com>
Subject: Re: [PATCH] powerpc: align memory_limit to 16MB in early_parse_mem
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Benjamin Gray <bgray@linux.ibm.com>, 
	Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@lists.ozlabs.org, 
	Gonzalo Siero <gsierohu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 12:45=E2=80=AFAM Joel Savitz <jsavitz@redhat.com> w=
rote:
>
> On Fri, Mar 8, 2024 at 5:18=E2=80=AFAM Aneesh Kumar K.V <aneesh.kumar@ker=
nel.org> wrote:
> >
> > Joel Savitz <jsavitz@redhat.com> writes:
> >
> > > On 64-bit powerpc, usage of a non-16MB-aligned value for the mem=3D k=
ernel
> > > cmdline parameter results in a system hang at boot.
> > >
> > > For example, using 'mem=3D4198400K' will always reproduce this issue.
> > >
> > > This patch fixes the problem by aligning any argument to mem=3D to 16=
MB
> > > corresponding with the large page size on powerpc.
> > >
> > > Fixes: 2babf5c2ec2f ("[PATCH] powerpc: Unify mem=3D handling")
> > > Co-developed-by: Gonzalo Siero <gsierohu@redhat.com>
> > > Signed-off-by: Gonzalo Siero <gsierohu@redhat.com>
> > > Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> > > ---
> > >  arch/powerpc/kernel/prom.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> > > index 0b5878c3125b..8cd3e2445d8a 100644
> > > --- a/arch/powerpc/kernel/prom.c
> > > +++ b/arch/powerpc/kernel/prom.c
> > > @@ -82,8 +82,12 @@ static int __init early_parse_mem(char *p)
> > >  {
> > >       if (!p)
> > >               return 1;
> > > -
> > > +#ifdef CONFIG_PPC64
> > > +     /* Align to 16 MB =3D=3D size of ppc64 large page */
> > > +     memory_limit =3D ALIGN(memparse(p, &p), 0x1000000);
> > > +#else
> > >       memory_limit =3D PAGE_ALIGN(memparse(p, &p));
> > > +#endif
> > >       DBG("memory limit =3D 0x%llx\n", memory_limit);
> > >
> > >       return 0;
> > > --
> > > 2.43.0
> >
> > Can you try this change?
> >
> > commit 5555bc55e1aa71f545cff31e1eccdb4a2e39df84
> > Author: Aneesh Kumar K.V (IBM) <aneesh.kumar@kernel.org>
> > Date:   Fri Mar 8 14:45:26 2024 +0530
> >
> >     powerpc/mm: Align memory_limit value specified using mem=3D kernel =
parameter
> >
> >     The value specified for the memory limit is used to set a restricti=
on on
> >     memory usage. It is important to ensure that this restriction is wi=
thin
> >     the linear map kernel address space range. The hash page table
> >     translation uses a 16MB page size to map the kernel linear map addr=
ess
> >     space. htab_bolt_mapping() function aligns down the size of the ran=
ge
> >     while mapping kernel linear address space. Since the memblock limit=
 is
> >     enforced very early during boot, before we can detect the type of m=
emory
> >     translation (radix vs hash), we align the memory limit value specif=
ied
> >     as a kernel parameter to 16MB. This alignment value will work for b=
oth
> >     hash and radix translations.
> >
> >     Signed-off-by: Aneesh Kumar K.V (IBM) <aneesh.kumar@kernel.org>
> >
> > diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> > index 0b5878c3125b..9bd965d35352 100644
> > --- a/arch/powerpc/kernel/prom.c
> > +++ b/arch/powerpc/kernel/prom.c
> > @@ -824,8 +824,11 @@ void __init early_init_devtree(void *params)
> >                 reserve_crashkernel();
> >         early_reserve_mem();
> >
> > -       /* Ensure that total memory size is page-aligned. */
> > -       limit =3D ALIGN(memory_limit ?: memblock_phys_mem_size(), PAGE_=
SIZE);
> > +       if (memory_limit > memblock_phys_mem_size())
> > +               memory_limit =3D 0;
> > +
> > +       /* Align down to 16 MB which is large page size with hash page =
translation */
> > +       limit =3D ALIGN_DOWN(memory_limit ?: memblock_phys_mem_size(), =
SZ_16M);
> >         memblock_enforce_memory_limit(limit);
> >
> >  #if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_PPC_4K_PAGES)
> > diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom=
_init.c
> > index e67effdba85c..d6410549e141 100644
> > --- a/arch/powerpc/kernel/prom_init.c
> > +++ b/arch/powerpc/kernel/prom_init.c
> > @@ -817,8 +817,8 @@ static void __init early_cmdline_parse(void)
> >                 opt +=3D 4;
> >                 prom_memory_limit =3D prom_memparse(opt, (const char **=
)&opt);
> >  #ifdef CONFIG_PPC64
> > -               /* Align to 16 MB =3D=3D size of ppc64 large page */
> > -               prom_memory_limit =3D ALIGN(prom_memory_limit, 0x100000=
0);
> > +               /* Align down to 16 MB which is large page size with ha=
sh page translation */
> > +               prom_memory_limit =3D ALIGN_DOWN(prom_memory_limit, SZ_=
16M);
> >  #endif
> >         }
> >
> >
>
> Sorry for the delayed reply. I just tested this patch and it fixes the
> bug for me.

Hi,

Just a quick follow up on this.

The above patch fixed the bug for me.

How do we want to proceed?

Best,
Joel Savitz


