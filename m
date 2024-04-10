Return-Path: <linux-kernel+bounces-139013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6F889FD76
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36D381C212FA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883CB17BB03;
	Wed, 10 Apr 2024 16:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JF4hql+8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEB731A60
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712767995; cv=none; b=tFYmTKV6LKzC+2FHq0lm2NrCpzL+Eo+a3IVAVGMwL7aP7RQ1qIRgqO3cego6halMFijbCvvGjWdBI4riTbdqNOfslrMSY0IYrq7N76FoUgcdmXAYFMbBOH9ANexZA1TT1zsIaAok5ZJnfBxwYpuDIuYh8plg2vlrihBRf2eypcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712767995; c=relaxed/simple;
	bh=GFqXfh1P99115kzS55VnkeqptSG3HhIzsRgPu/wHXVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NzSD1NQZD4kjZ3K5NwWFLNtcEZiLmG/BUtsgX5QWtd+22yWTJh47TIAvr5VYBzUp0BVYAf/5D/pt/hBcaTUylDWof+0I7s/SA+2qIFNSygiJQ4so96fsRRoRnx4hbFQ/uCKFN8PSGBE5WFJGGwbmejqczrRGh2e2KIftMdJqad8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JF4hql+8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712767993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KlddPZxMxfFFdReOuFZj/5SHihq3pB3QhO9d2mti7JU=;
	b=JF4hql+8AyWM4CxQZFon6CmVYUdZidPTrfTYcDAM0fDnVm9snQSYPaL9BiV4xiny3kkULm
	d+ll41Ew2bYs+3dJAcLo99bu3YGhAMciisZ/B7J4PnFb1bB7t7ciT1oyg2/Hw/f33YEdlt
	hBq65xa4ojrj8pgCOGsKRjQQ1c3uxhI=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-D1yMpGi3OGShLDQkbCNBBw-1; Wed, 10 Apr 2024 12:53:10 -0400
X-MC-Unique: D1yMpGi3OGShLDQkbCNBBw-1
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-479e72a0621so795099137.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 09:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712767990; x=1713372790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KlddPZxMxfFFdReOuFZj/5SHihq3pB3QhO9d2mti7JU=;
        b=gG5de5WHP3HM1yAaKe+3wfpayK6amjXzwc+cnYfl+ASq/Paimy8eUL0jRaDHSNLgHR
         TKBVzy+uK0+SRgRMNbJkzkDqE48uzhudbvZ+iSvcUTQRmqPWDgru/7WGwjGln93efDoq
         z7UGYs25N08XpwwJ+bUanx8jr1iATcRxhfXTITwWlWd1TYt/yw+LtF7Wi03Q9BBpZ53o
         rpVZgpyXt2sNNnmQQmU+6CxK4GBA79w7woeHrEGLvTJPAWtObFpJX0VfQbUWj1SJcEHJ
         Omk8PS9gcHi5Y+VisQ8p/8QKHCEsWUkrjzBGFSeuifY4oi+ejkFhh9tiHbluvzdDIG6/
         2XgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKer3hjCUSzvoRDTy3Qe+3/xfNtp+1HaE8aBepfR/fD9fPOoTF6KdqINgdQMae8bSFZzRXpqpTBkq3igHSS1LwWK6vlSdj2pPN1SbL
X-Gm-Message-State: AOJu0Yz3TSy+wdkwAMw4ZhrWOzWsH89kAxLVuTEoI1pPNBwrckWJNCOK
	UgUnTRS3iFFMp8B24S4z9nJVJ3UBmtdImA5+rKWDojfj1hc3hPENOyzahvFbceXt4vcYstYWCQu
	H4nppocSVNmc0pQegLUVjmgOCDN4JseL6eCq9uSPD7kXtflI2dhtr/h0kiH4J7upxtff4BP0gJL
	PD/SVqNGmB/OQChsl+iG0MKlS3yOZL/kj/FKRr
X-Received: by 2002:a05:6102:955:b0:47a:317f:eff7 with SMTP id a21-20020a056102095500b0047a317feff7mr450284vsi.0.1712767990106;
        Wed, 10 Apr 2024 09:53:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRV5DLBFYMOImJA2ctjr0M3wUT0pvxqzCmawzQbF7B0UfSi2ElF9+rYYd+50ET+UTbyrBS9zA7qjbu22HjDvo=
X-Received: by 2002:a05:6102:955:b0:47a:317f:eff7 with SMTP id
 a21-20020a056102095500b0047a317feff7mr450259vsi.0.1712767989684; Wed, 10 Apr
 2024 09:53:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301203023.2197451-1-jsavitz@redhat.com> <87jzmduiva.fsf@kernel.org>
 <CAL1p7m5BoxFDeK0MryQCmTDCeBLN3rMLRGx3cHa6teS02wsgZw@mail.gmail.com>
 <CAL1p7m5VHGL+-st7zgGA9LPft6DND=qz0ifiD_ki1hLvfRv=7Q@mail.gmail.com>
 <CAL1p7m7f=b_qJrU8qea2n1+-1KzEVLMOpY9ov5fH2ZZxGrDK5A@mail.gmail.com> <39df36ad-91a4-4bc1-bec9-a1b3ea619200@csgroup.eu>
In-Reply-To: <39df36ad-91a4-4bc1-bec9-a1b3ea619200@csgroup.eu>
From: Joel Savitz <jsavitz@redhat.com>
Date: Wed, 10 Apr 2024 12:52:53 -0400
Message-ID: <CAL1p7m7WY8bJPWUNiyE6kidkyk7hELPhhtt3PzOWK9uPHiOW9w@mail.gmail.com>
Subject: Re: [PATCH] powerpc: align memory_limit to 16MB in early_parse_mem
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Paul Mackerras <paulus@ozlabs.org>, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Gonzalo Siero <gsierohu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 11:31=E2=80=AFAM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 10/04/2024 =C3=A0 17:22, Joel Savitz a =C3=A9crit :
> > [Vous ne recevez pas souvent de courriers de jsavitz@redhat.com. D=C3=
=A9couvrez pourquoi ceci est important =C3=A0 https://aka.ms/LearnAboutSend=
erIdentification ]
> >
> > On Mon, Apr 1, 2024 at 10:17=E2=80=AFAM Joel Savitz <jsavitz@redhat.com=
> wrote:
> >>
> >> On Tue, Mar 26, 2024 at 12:45=E2=80=AFAM Joel Savitz <jsavitz@redhat.c=
om> wrote:
> >>>
> >>> On Fri, Mar 8, 2024 at 5:18=E2=80=AFAM Aneesh Kumar K.V <aneesh.kumar=
@kernel.org> wrote:
> >>>>
> >>>> Joel Savitz <jsavitz@redhat.com> writes:
> >>>>
> >>>>> On 64-bit powerpc, usage of a non-16MB-aligned value for the mem=3D=
 kernel
> >>>>> cmdline parameter results in a system hang at boot.
> >>>>>
> >>>>> For example, using 'mem=3D4198400K' will always reproduce this issu=
e.
> >>>>>
> >>>>> This patch fixes the problem by aligning any argument to mem=3D to =
16MB
> >>>>> corresponding with the large page size on powerpc.
> >>>>>
> >>>>> Fixes: 2babf5c2ec2f ("[PATCH] powerpc: Unify mem=3D handling")
> >>>>> Co-developed-by: Gonzalo Siero <gsierohu@redhat.com>
> >>>>> Signed-off-by: Gonzalo Siero <gsierohu@redhat.com>
> >>>>> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> >>>>> ---
> >>>>>   arch/powerpc/kernel/prom.c | 6 +++++-
> >>>>>   1 file changed, 5 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.=
c
> >>>>> index 0b5878c3125b..8cd3e2445d8a 100644
> >>>>> --- a/arch/powerpc/kernel/prom.c
> >>>>> +++ b/arch/powerpc/kernel/prom.c
> >>>>> @@ -82,8 +82,12 @@ static int __init early_parse_mem(char *p)
> >>>>>   {
> >>>>>        if (!p)
> >>>>>                return 1;
> >>>>> -
> >>>>> +#ifdef CONFIG_PPC64
> >>>>> +     /* Align to 16 MB =3D=3D size of ppc64 large page */
> >>>>> +     memory_limit =3D ALIGN(memparse(p, &p), 0x1000000);
> >>>>> +#else
> >>>>>        memory_limit =3D PAGE_ALIGN(memparse(p, &p));
> >>>>> +#endif
> >>>>>        DBG("memory limit =3D 0x%llx\n", memory_limit);
> >>>>>
> >>>>>        return 0;
> >>>>> --
> >>>>> 2.43.0
> >>>>
> >>>> Can you try this change?
> >>>>
> >>>> commit 5555bc55e1aa71f545cff31e1eccdb4a2e39df84
> >>>> Author: Aneesh Kumar K.V (IBM) <aneesh.kumar@kernel.org>
> >>>> Date:   Fri Mar 8 14:45:26 2024 +0530
> >>>>
> >>>>      powerpc/mm: Align memory_limit value specified using mem=3D ker=
nel parameter
> >>>>
> >>>>      The value specified for the memory limit is used to set a restr=
iction on
> >>>>      memory usage. It is important to ensure that this restriction i=
s within
> >>>>      the linear map kernel address space range. The hash page table
> >>>>      translation uses a 16MB page size to map the kernel linear map =
address
> >>>>      space. htab_bolt_mapping() function aligns down the size of the=
 range
> >>>>      while mapping kernel linear address space. Since the memblock l=
imit is
> >>>>      enforced very early during boot, before we can detect the type =
of memory
> >>>>      translation (radix vs hash), we align the memory limit value sp=
ecified
> >>>>      as a kernel parameter to 16MB. This alignment value will work f=
or both
> >>>>      hash and radix translations.
> >>>>
> >>>>      Signed-off-by: Aneesh Kumar K.V (IBM) <aneesh.kumar@kernel.org>
> >>>>
> >>>> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> >>>> index 0b5878c3125b..9bd965d35352 100644
> >>>> --- a/arch/powerpc/kernel/prom.c
> >>>> +++ b/arch/powerpc/kernel/prom.c
> >>>> @@ -824,8 +824,11 @@ void __init early_init_devtree(void *params)
> >>>>                  reserve_crashkernel();
> >>>>          early_reserve_mem();
> >>>>
> >>>> -       /* Ensure that total memory size is page-aligned. */
> >>>> -       limit =3D ALIGN(memory_limit ?: memblock_phys_mem_size(), PA=
GE_SIZE);
> >>>> +       if (memory_limit > memblock_phys_mem_size())
> >>>> +               memory_limit =3D 0;
> >>>> +
> >>>> +       /* Align down to 16 MB which is large page size with hash pa=
ge translation */
> >>>> +       limit =3D ALIGN_DOWN(memory_limit ?: memblock_phys_mem_size(=
), SZ_16M);
> >>>>          memblock_enforce_memory_limit(limit);
> >>>>
> >>>>   #if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_PPC_4K_PAGES)
> >>>> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/p=
rom_init.c
> >>>> index e67effdba85c..d6410549e141 100644
> >>>> --- a/arch/powerpc/kernel/prom_init.c
> >>>> +++ b/arch/powerpc/kernel/prom_init.c
> >>>> @@ -817,8 +817,8 @@ static void __init early_cmdline_parse(void)
> >>>>                  opt +=3D 4;
> >>>>                  prom_memory_limit =3D prom_memparse(opt, (const cha=
r **)&opt);
> >>>>   #ifdef CONFIG_PPC64
> >>>> -               /* Align to 16 MB =3D=3D size of ppc64 large page */
> >>>> -               prom_memory_limit =3D ALIGN(prom_memory_limit, 0x100=
0000);
> >>>> +               /* Align down to 16 MB which is large page size with=
 hash page translation */
> >>>> +               prom_memory_limit =3D ALIGN_DOWN(prom_memory_limit, =
SZ_16M);
> >>>>   #endif
> >>>>          }
> >>>>
> >>>>
> >>>
> >>> Sorry for the delayed reply. I just tested this patch and it fixes th=
e
> >>> bug for me.
> >>
> >> Hi,
> >>
> >> Just a quick follow up on this.
> >>
> >> The above patch fixed the bug for me.
> >>
> >> How do we want to proceed?
> >>
> >> Best,
> >> Joel Savitz
> >
> > Hi,
> >
> > I haven't heard anything on this thread so I'm just sending a quick fol=
low up.
> >
> > Do we want to merge this
> >
>
> Is it the same as
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20240403083611.17=
2833-1-aneesh.kumar@kernel.org/
> ?

Yes that appears to be the case.


