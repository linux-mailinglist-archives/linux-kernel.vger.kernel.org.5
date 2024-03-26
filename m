Return-Path: <linux-kernel+bounces-118360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CABA888B97C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 05:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 479981F3D938
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 04:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DBE71B47;
	Tue, 26 Mar 2024 04:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UBNjYIA6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB4D33FD
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 04:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711428338; cv=none; b=lssh3xFqr4M4DU6aOnBUi9PKiJKQw01agmXhxFlfBUe1Ko3NVDLCVT18JYhmamr0F12Hy4eUtWb4unxr9efS3szMPTokkVxuCPFHK6EYOj0eHvZU9TcV+UdUzqfjycEZfi+pFGCo1QtWLYtg1yC7aLEFszV+Qa9I437o8Ur9zfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711428338; c=relaxed/simple;
	bh=Pgv/tT/N2P7ZAj+UJ3IWDPgKGNnA2zABKljkfQKwA2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YGE8vHDUFdmtvcKzR1wb7C9YoVzVK4saTz6pUQ+2TrVXr5YdNe28mz+eheabD5Qx68021XV03yULluJLL2v86QZxPnT+5+K7MFYOb7KvVWcooIFkP9rmpBiSU7T+n64m70wahcxc8V2bGXA+gLGOF56BeSzJ7gj18TfIPxb9KJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UBNjYIA6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711428335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iLn9q/d3IXDRXcZITYj+lKYLmTjyEeBrR8h5o+IkddE=;
	b=UBNjYIA6AbXsH2WUPAUw2yYcxeNH7uemR6Xx1mp4pb8eYZjiqBDGs1NYTL2t41FrLta6Nr
	o3evOnTNotHlpvwFXN1JeJy9S9bg6GzPRxJ84N7l+pIvxdaryyeU6w8ZQOLcxxMhQ7oIAF
	Z+NDPY4JPKfDxHa9wWJKHVvWMD9Q/0Y=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-kBzeNlrDPV61i7_pQsiBGg-1; Tue, 26 Mar 2024 00:45:33 -0400
X-MC-Unique: kBzeNlrDPV61i7_pQsiBGg-1
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-4d45644084cso1996363e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 21:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711428333; x=1712033133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLn9q/d3IXDRXcZITYj+lKYLmTjyEeBrR8h5o+IkddE=;
        b=FlY8wTJ1eY8forK3SwUlkOvvyXRHtKXf8AAL6eWB8cihx7TKqPxukauZarzcj8nASS
         ULeYs3U3ulrpYg27/QZm9YaJFWsLAK7Z4f5m0Qwz6lBwE3tLiAoHnPNmoBI2fE8dzOLC
         ev4qLRLJSS5TLDLpDurgdOVe+fdmbKsvfoAj3UJZHayxeegiLAN0yXGyOirKQasusA1U
         pg+F5d2gn4xPxNTdX2NBzYXR+KPNbMh3pH52nGDqNn72MWLbDaiBZJNyJTwb0mY3ff/t
         GDVJwu/wJelymhuG7TkI7TvXlal7A9QPyT0uk4040+0G917123go43RGO6F1DEB6MRxo
         O8rg==
X-Gm-Message-State: AOJu0YwfgWxnChF+Xa2fDGV6mx8UZNcEbn2BSAePFURJ8X6sCbCjfDVj
	G9JbpBt57LaaUZ1NkFxUQlsbusiLCkrtrV3kG+ottveTlXHdVNWRqa110ow0thbAbY0aR9nl0eB
	sLOs1ZSKr+e+xv+UhMTSVTyuWRFP76YegyW8TLaTaq/EP1jZoK9VDioJBveGnhQibMWLqF//7GE
	F5/pD0gxJDnxa7gG+BtMTtp/2k9zsLXP12D4OF
X-Received: by 2002:a05:6122:168a:b0:4c9:2540:8520 with SMTP id 10-20020a056122168a00b004c925408520mr1743467vkl.1.1711428332980;
        Mon, 25 Mar 2024 21:45:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfNLJPf8BwG8GdUEorXPr162rmx5xbKqekfpH7H27QQ3Vu30bi3pOmdnAJp/Gx6xebGiQNvKpx8wabblhWq3o=
X-Received: by 2002:a05:6122:168a:b0:4c9:2540:8520 with SMTP id
 10-20020a056122168a00b004c925408520mr1743463vkl.1.1711428332671; Mon, 25 Mar
 2024 21:45:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301203023.2197451-1-jsavitz@redhat.com> <87jzmduiva.fsf@kernel.org>
In-Reply-To: <87jzmduiva.fsf@kernel.org>
From: Joel Savitz <jsavitz@redhat.com>
Date: Tue, 26 Mar 2024 00:45:16 -0400
Message-ID: <CAL1p7m5BoxFDeK0MryQCmTDCeBLN3rMLRGx3cHa6teS02wsgZw@mail.gmail.com>
Subject: Re: [PATCH] powerpc: align memory_limit to 16MB in early_parse_mem
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Benjamin Gray <bgray@linux.ibm.com>, 
	Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@lists.ozlabs.org, 
	Gonzalo Siero <gsierohu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 5:18=E2=80=AFAM Aneesh Kumar K.V <aneesh.kumar@kerne=
l.org> wrote:
>
> Joel Savitz <jsavitz@redhat.com> writes:
>
> > On 64-bit powerpc, usage of a non-16MB-aligned value for the mem=3D ker=
nel
> > cmdline parameter results in a system hang at boot.
> >
> > For example, using 'mem=3D4198400K' will always reproduce this issue.
> >
> > This patch fixes the problem by aligning any argument to mem=3D to 16MB
> > corresponding with the large page size on powerpc.
> >
> > Fixes: 2babf5c2ec2f ("[PATCH] powerpc: Unify mem=3D handling")
> > Co-developed-by: Gonzalo Siero <gsierohu@redhat.com>
> > Signed-off-by: Gonzalo Siero <gsierohu@redhat.com>
> > Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> > ---
> >  arch/powerpc/kernel/prom.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> > index 0b5878c3125b..8cd3e2445d8a 100644
> > --- a/arch/powerpc/kernel/prom.c
> > +++ b/arch/powerpc/kernel/prom.c
> > @@ -82,8 +82,12 @@ static int __init early_parse_mem(char *p)
> >  {
> >       if (!p)
> >               return 1;
> > -
> > +#ifdef CONFIG_PPC64
> > +     /* Align to 16 MB =3D=3D size of ppc64 large page */
> > +     memory_limit =3D ALIGN(memparse(p, &p), 0x1000000);
> > +#else
> >       memory_limit =3D PAGE_ALIGN(memparse(p, &p));
> > +#endif
> >       DBG("memory limit =3D 0x%llx\n", memory_limit);
> >
> >       return 0;
> > --
> > 2.43.0
>
> Can you try this change?
>
> commit 5555bc55e1aa71f545cff31e1eccdb4a2e39df84
> Author: Aneesh Kumar K.V (IBM) <aneesh.kumar@kernel.org>
> Date:   Fri Mar 8 14:45:26 2024 +0530
>
>     powerpc/mm: Align memory_limit value specified using mem=3D kernel pa=
rameter
>
>     The value specified for the memory limit is used to set a restriction=
 on
>     memory usage. It is important to ensure that this restriction is with=
in
>     the linear map kernel address space range. The hash page table
>     translation uses a 16MB page size to map the kernel linear map addres=
s
>     space. htab_bolt_mapping() function aligns down the size of the range
>     while mapping kernel linear address space. Since the memblock limit i=
s
>     enforced very early during boot, before we can detect the type of mem=
ory
>     translation (radix vs hash), we align the memory limit value specifie=
d
>     as a kernel parameter to 16MB. This alignment value will work for bot=
h
>     hash and radix translations.
>
>     Signed-off-by: Aneesh Kumar K.V (IBM) <aneesh.kumar@kernel.org>
>
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 0b5878c3125b..9bd965d35352 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -824,8 +824,11 @@ void __init early_init_devtree(void *params)
>                 reserve_crashkernel();
>         early_reserve_mem();
>
> -       /* Ensure that total memory size is page-aligned. */
> -       limit =3D ALIGN(memory_limit ?: memblock_phys_mem_size(), PAGE_SI=
ZE);
> +       if (memory_limit > memblock_phys_mem_size())
> +               memory_limit =3D 0;
> +
> +       /* Align down to 16 MB which is large page size with hash page tr=
anslation */
> +       limit =3D ALIGN_DOWN(memory_limit ?: memblock_phys_mem_size(), SZ=
_16M);
>         memblock_enforce_memory_limit(limit);
>
>  #if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_PPC_4K_PAGES)
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_i=
nit.c
> index e67effdba85c..d6410549e141 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -817,8 +817,8 @@ static void __init early_cmdline_parse(void)
>                 opt +=3D 4;
>                 prom_memory_limit =3D prom_memparse(opt, (const char **)&=
opt);
>  #ifdef CONFIG_PPC64
> -               /* Align to 16 MB =3D=3D size of ppc64 large page */
> -               prom_memory_limit =3D ALIGN(prom_memory_limit, 0x1000000)=
;
> +               /* Align down to 16 MB which is large page size with hash=
 page translation */
> +               prom_memory_limit =3D ALIGN_DOWN(prom_memory_limit, SZ_16=
M);
>  #endif
>         }
>
>

Sorry for the delayed reply. I just tested this patch and it fixes the
bug for me.


