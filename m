Return-Path: <linux-kernel+bounces-16699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73C082429F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAACA1C21E9A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF2C22337;
	Thu,  4 Jan 2024 13:21:59 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1390C22313;
	Thu,  4 Jan 2024 13:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-59584f41f1eso74784eaf.1;
        Thu, 04 Jan 2024 05:21:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704374516; x=1704979316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EO6yGu/hNfKIRPFZyFi3Yd8i7VyVLeoh6f7ilAMeImg=;
        b=Jxhw9ijCiPpdiHBytCq6fWoP298jEBuqx3Q2bvnXM4QXcApnaA7aa+ws8cuaVXl7im
         sschgxWW8/5u8qL90/Orhdg7COJrf9fX+zXfIb8m3yN4y/fYR+MwHxXUdnOc0EdRVWqc
         iTO7s8E9U37rQZQCb3cY5lUcw2kU8ic4lGhKAuJIZk053O9mBlYeYNss0VoYHU47+pLE
         47IizJ7M9DaPgw0Ny/wLtgIPRwobleLtDFZu3C8aCe2zLMCjZVZ3Z39nod1xi8dvd+CB
         ynpf01HFe0JyXur+Ysmd8nZwlgH2yE7ZfNpBJ4AoNkWvWIjGhOi7W3so4VSy3oDt8Z0y
         ZIIQ==
X-Gm-Message-State: AOJu0YxnW153JzMCYUAgPv6OFaU9DMN5zFFESb22vZO/dc6ejxgNJynb
	RgDLTRa6E7/Z7cx/vMAtab1mMjxKUPsAtV8gBC4=
X-Google-Smtp-Source: AGHT+IHGI9ygj6RJgfCVJJy2grElIEhwy9dgb0OilqnwIPrWvCFIrdnNZvrzITFDivU+/1bFoJI9D8gatWGp1VPFa7Q=
X-Received: by 2002:a4a:a306:0:b0:596:2300:27b7 with SMTP id
 q6-20020a4aa306000000b00596230027b7mr1013014ool.1.1704374516146; Thu, 04 Jan
 2024 05:21:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230905104721.52199-1-lpieralisi@kernel.org> <20231227110038.55453-1-lpieralisi@kernel.org>
 <CAJZ5v0gUBU=VL8E34sjROssoGNbLnhmUQVHGWT60hgBG_ufTHw@mail.gmail.com>
 <86h6jt9vs7.wl-maz@kernel.org> <ZZaeyBXn85AnsIk6@shell.armlinux.org.uk>
In-Reply-To: <ZZaeyBXn85AnsIk6@shell.armlinux.org.uk>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Jan 2024 14:21:44 +0100
Message-ID: <CAJZ5v0jcZ4WEiNUs3sAQUyy1uVJRNWmVJx2j0e3hLwi7heK1+A@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] irqchip/gic-v3: Enable non-coherent GIC designs probing
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Marc Zyngier <maz@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, Mark Rutland <mark.rutland@arm.com>, 
	Robin Murphy <robin.murphy@arm.com>, Fang Xiang <fangxiang3@xiaomi.com>, 
	Robert Moore <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 1:04=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Thu, Jan 04, 2024 at 11:34:48AM +0000, Marc Zyngier wrote:
> > On Wed, 03 Jan 2024 13:43:16 +0000,
> > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > >
> > > On Wed, Dec 27, 2023 at 12:00=E2=80=AFPM Lorenzo Pieralisi
> > > <lpieralisi@kernel.org> wrote:
> > > >
> > > > This series is v4 of previous series:
> > > >
> > > > v3: https://lore.kernel.org/all/20231006125929.48591-1-lpieralisi@k=
ernel.org
> > > > v2: https://lore.kernel.org/all/20230906094139.16032-1-lpieralisi@k=
ernel.org
> > > > v1: https://lore.kernel.org/all/20230905104721.52199-1-lpieralisi@k=
ernel.org
> > > >
> > > > v3 -> v4:
> > > >         - Dropped patches [1-3], already merged
> > > >         - Added Linuxized ACPICA changes accepted upstream
> > > >         - Rebased against v6.7-rc3
> > > >
> > > > v2 -> v3:
> > > >         - Added ACPICA temporary changes and ACPI changes to implem=
ent
> > > >           ECR https://bugzilla.tianocore.org/show_bug.cgi?id=3D4557
> > > >         - ACPI changes are for testing purposes - subject to ECR co=
de
> > > >           first approval
> > > >
> > > > v1 -> v2:
> > > >         - Updated DT bindings as per feedback
> > > >         - Updated patch[2] to use GIC quirks infrastructure
> > > >
> > > > Original cover letter
> > > > ---
> > > > The GICv3 architecture specifications provide a means for the
> > > > system programmer to set the shareability and cacheability
> > > > attributes the GIC components (redistributors and ITSes) use
> > > > to drive memory transactions.
> > > >
> > > > Albeit the architecture give control over shareability/cacheability
> > > > memory transactions attributes (and barriers), it is allowed to
> > > > connect the GIC interconnect ports to non-coherent memory ports
> > > > on the interconnect, basically tying off shareability/cacheability
> > > > "wires" and de-facto making the redistributors and ITSes non-cohere=
nt
> > > > memory observers.
> > > >
> > > > This series aims at starting a discussion over a possible solution
> > > > to this problem, by adding to the GIC device tree bindings the
> > > > standard dma-noncoherent property. The GIC driver uses the property
> > > > to force the redistributors and ITSes shareability attributes to
> > > > non-shareable, which consequently forces the driver to use CMOs
> > > > on GIC memory tables.
> > > >
> > > > On ARM DT DMA is default non-coherent, so the GIC driver can't rely
> > > > on the generic DT dma-coherent/non-coherent property management lay=
er
> > > > (of_dma_is_coherent()) which would default all GIC designs in the f=
ield
> > > > as non-coherent; it has to rely on ad-hoc dma-noncoherent property =
handling.
> > > >
> > > > When a consistent approach is agreed upon for DT an equivalent bind=
ing will
> > > > be put forward for ACPI based systems.
> > > >
> > > > Lorenzo Pieralisi (3):
> > > >   ACPICA: MADT: Add GICC online capable bit handling
> > > >   ACPICA: MADT: Add new MADT GICC/GICR/ITS non-coherent flags handl=
ing
> > > >   irqchip/gic-v3: Enable non-coherent redistributors/ITSes ACPI pro=
bing
> > > >
> > > >  drivers/acpi/processor_core.c    | 21 +++++++++++++++++++++
> > > >  drivers/irqchip/irq-gic-common.h |  8 ++++++++
> > > >  drivers/irqchip/irq-gic-v3-its.c |  4 ++++
> > > >  drivers/irqchip/irq-gic-v3.c     |  9 +++++++++
> > > >  include/acpi/actbl2.h            | 12 ++++++++++--
> > > >  include/linux/acpi.h             |  3 +++
> > > >  6 files changed, 55 insertions(+), 2 deletions(-)
> > > >
> > > > --
> > >
> > > I can apply the first 2 patches, but I would need an ACK for the 3rd =
one.
> > >
> > > Alternatively, feel free to add
> > >
> > > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > to the first 2 patches and route them via ARM64.
> >
> > Thanks for that. I have some comments on the third patch, which I'd
> > like to see addressed beforehand. This is probably all 6.9 material
> > anyway (nobody is affected by this so far).
>
> From a purely selfish point of view, it would be useful to have the
> first patch merged merely to reduce the burden of patches for vcpu
> hotplug.

OK, since there will be at least one more iteration of patch [3/3]
AFAICS, I'll queue up patches [1-2/3] for 6.8 (next week, though).

