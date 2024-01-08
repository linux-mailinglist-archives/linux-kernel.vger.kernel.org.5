Return-Path: <linux-kernel+bounces-19297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0D5826B07
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 114131C21D42
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB2312E73;
	Mon,  8 Jan 2024 09:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAbQPibr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0160B13AC9;
	Mon,  8 Jan 2024 09:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF012C433C8;
	Mon,  8 Jan 2024 09:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704707146;
	bh=f6WCM1z5/+ZFnyvuqtaD9vtixmN+3lnBNV++wPJ45j0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nAbQPibrQv3/Hig92JSWM9+EyJ2L7BwdnVsvdnKK9UBDsZva0Y0T1cGvdXfUXuetn
	 CFL60LWh68TC+opYZUkdUQ5BxRNhWG1wthBvONFdLirRanS8lqw3CtIUdGNgtURYsW
	 jwqM+5byNHS9eS7RLYU8PQmRjT6ZLfO//UZHEtgnKiT3jLP0tMXaKPyPnOLF8x2Rrc
	 SwQ8av8OlFUAf1d6stadBWO/sqzFiOUZA2AnaVFMSGan5h27z+G0XW4VlfiExAqN0k
	 cGIcVzf8OBj7+Ft/4Ia2Y3xYmPkIguRXHhezDyPoZtGV3RhoUjSAmO/CYOEbcTGtaa
	 hKqFoEA5R/Cww==
Date: Mon, 8 Jan 2024 10:45:40 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev, Mark Rutland <mark.rutland@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Fang Xiang <fangxiang3@xiaomi.com>,
	Robert Moore <robert.moore@intel.com>
Subject: Re: [PATCH v4 0/3] irqchip/gic-v3: Enable non-coherent GIC designs
 probing
Message-ID: <ZZvERNzqEQf0FuT/@lpieralisi>
References: <20230905104721.52199-1-lpieralisi@kernel.org>
 <20231227110038.55453-1-lpieralisi@kernel.org>
 <CAJZ5v0gUBU=VL8E34sjROssoGNbLnhmUQVHGWT60hgBG_ufTHw@mail.gmail.com>
 <86h6jt9vs7.wl-maz@kernel.org>
 <ZZaeyBXn85AnsIk6@shell.armlinux.org.uk>
 <CAJZ5v0jcZ4WEiNUs3sAQUyy1uVJRNWmVJx2j0e3hLwi7heK1+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jcZ4WEiNUs3sAQUyy1uVJRNWmVJx2j0e3hLwi7heK1+A@mail.gmail.com>

On Thu, Jan 04, 2024 at 02:21:44PM +0100, Rafael J. Wysocki wrote:
> On Thu, Jan 4, 2024 at 1:04 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Thu, Jan 04, 2024 at 11:34:48AM +0000, Marc Zyngier wrote:
> > > On Wed, 03 Jan 2024 13:43:16 +0000,
> > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > > >
> > > > On Wed, Dec 27, 2023 at 12:00 PM Lorenzo Pieralisi
> > > > <lpieralisi@kernel.org> wrote:
> > > > >
> > > > > This series is v4 of previous series:
> > > > >
> > > > > v3: https://lore.kernel.org/all/20231006125929.48591-1-lpieralisi@kernel.org
> > > > > v2: https://lore.kernel.org/all/20230906094139.16032-1-lpieralisi@kernel.org
> > > > > v1: https://lore.kernel.org/all/20230905104721.52199-1-lpieralisi@kernel.org
> > > > >
> > > > > v3 -> v4:
> > > > >         - Dropped patches [1-3], already merged
> > > > >         - Added Linuxized ACPICA changes accepted upstream
> > > > >         - Rebased against v6.7-rc3
> > > > >
> > > > > v2 -> v3:
> > > > >         - Added ACPICA temporary changes and ACPI changes to implement
> > > > >           ECR https://bugzilla.tianocore.org/show_bug.cgi?id=4557
> > > > >         - ACPI changes are for testing purposes - subject to ECR code
> > > > >           first approval
> > > > >
> > > > > v1 -> v2:
> > > > >         - Updated DT bindings as per feedback
> > > > >         - Updated patch[2] to use GIC quirks infrastructure
> > > > >
> > > > > Original cover letter
> > > > > ---
> > > > > The GICv3 architecture specifications provide a means for the
> > > > > system programmer to set the shareability and cacheability
> > > > > attributes the GIC components (redistributors and ITSes) use
> > > > > to drive memory transactions.
> > > > >
> > > > > Albeit the architecture give control over shareability/cacheability
> > > > > memory transactions attributes (and barriers), it is allowed to
> > > > > connect the GIC interconnect ports to non-coherent memory ports
> > > > > on the interconnect, basically tying off shareability/cacheability
> > > > > "wires" and de-facto making the redistributors and ITSes non-coherent
> > > > > memory observers.
> > > > >
> > > > > This series aims at starting a discussion over a possible solution
> > > > > to this problem, by adding to the GIC device tree bindings the
> > > > > standard dma-noncoherent property. The GIC driver uses the property
> > > > > to force the redistributors and ITSes shareability attributes to
> > > > > non-shareable, which consequently forces the driver to use CMOs
> > > > > on GIC memory tables.
> > > > >
> > > > > On ARM DT DMA is default non-coherent, so the GIC driver can't rely
> > > > > on the generic DT dma-coherent/non-coherent property management layer
> > > > > (of_dma_is_coherent()) which would default all GIC designs in the field
> > > > > as non-coherent; it has to rely on ad-hoc dma-noncoherent property handling.
> > > > >
> > > > > When a consistent approach is agreed upon for DT an equivalent binding will
> > > > > be put forward for ACPI based systems.
> > > > >
> > > > > Lorenzo Pieralisi (3):
> > > > >   ACPICA: MADT: Add GICC online capable bit handling
> > > > >   ACPICA: MADT: Add new MADT GICC/GICR/ITS non-coherent flags handling
> > > > >   irqchip/gic-v3: Enable non-coherent redistributors/ITSes ACPI probing
> > > > >
> > > > >  drivers/acpi/processor_core.c    | 21 +++++++++++++++++++++
> > > > >  drivers/irqchip/irq-gic-common.h |  8 ++++++++
> > > > >  drivers/irqchip/irq-gic-v3-its.c |  4 ++++
> > > > >  drivers/irqchip/irq-gic-v3.c     |  9 +++++++++
> > > > >  include/acpi/actbl2.h            | 12 ++++++++++--
> > > > >  include/linux/acpi.h             |  3 +++
> > > > >  6 files changed, 55 insertions(+), 2 deletions(-)
> > > > >
> > > > > --
> > > >
> > > > I can apply the first 2 patches, but I would need an ACK for the 3rd one.
> > > >
> > > > Alternatively, feel free to add
> > > >
> > > > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > to the first 2 patches and route them via ARM64.
> > >
> > > Thanks for that. I have some comments on the third patch, which I'd
> > > like to see addressed beforehand. This is probably all 6.9 material
> > > anyway (nobody is affected by this so far).
> >
> > From a purely selfish point of view, it would be useful to have the
> > first patch merged merely to reduce the burden of patches for vcpu
> > hotplug.
> 
> OK, since there will be at least one more iteration of patch [3/3]
> AFAICS, I'll queue up patches [1-2/3] for 6.8 (next week, though).

Thank you Rafael.

Lorenzo

