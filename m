Return-Path: <linux-kernel+bounces-111220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DBA88694E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A52C1C23F1A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F14A21340;
	Fri, 22 Mar 2024 09:32:27 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDCD208D1;
	Fri, 22 Mar 2024 09:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711099946; cv=none; b=lAghhOvAJYWk0AX3XkY8+Q3F1+MTj3vQl/jxiZ3PaFYLle/Dt+1EGSm/QNnv4MmWmpkMofa/zeC4T9iDfjjCpTvf6vUVH383ZplHXY4YovEwCrzs4cpZpQ2nkNIPLMn/GZEPJf06IrtomrlQWM9/wukBsJUi0tGefKBEGzp8JOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711099946; c=relaxed/simple;
	bh=Oj5iih5wQJ0xyqRGIIw88Fc2AtQfArFbMA8zGE302ww=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l33w3zIpO/EITQ5UrU1UnRseeIO3h1gl/Kip5Ao2zsMNGBLjpjYu0LwuIBzGeIGMV2e2naYOWodjmFJn7/tXkHFA1++3bjK4rRb5KL9G4ccsT/5cb2apcSta4ejLGhrb1V0rJvKs7ruk0C0OFu4pvlabq8lQqeKbiq8STKGmaaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V1HCC6rW4z67lcT;
	Fri, 22 Mar 2024 17:31:35 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E10A9140519;
	Fri, 22 Mar 2024 17:32:13 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 22 Mar
 2024 09:32:13 +0000
Date: Fri, 22 Mar 2024 09:32:12 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Sreenivas Bagalkote <sreenivas.bagalkote@broadcom.com>
CC: <linux-cxl@vger.kernel.org>, Brett Henning <brett.henning@broadcom.com>,
	Harold Johnson <harold.johnson@broadcom.com>, Sumanesh Samanta
	<sumanesh.samanta@broadcom.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>, Davidlohr Bueso
	<dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, <linuxarm@huawei.com>,
	<linux-api@vger.kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Natu, Mahesh" <mahesh.natu@intel.com>, <Ariel.Sibley@microchip.com>
Subject: Re: RFC: Restricting userspace interfaces for CXL fabric management
Message-ID: <20240322093212.00003173@Huawei.com>
In-Reply-To: <CACX_a4VPV16OFNZLCVUJrGFR5brcdiYN3aAgrxtO8ksUdNdkQQ@mail.gmail.com>
References: <20240321174423.00007e0d@Huawei.com>
	<CACX_a4VPV16OFNZLCVUJrGFR5brcdiYN3aAgrxtO8ksUdNdkQQ@mail.gmail.com>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 21 Mar 2024 14:41:00 -0700
Sreenivas Bagalkote <sreenivas.bagalkote@broadcom.com> wrote:

> Thank you for kicking off this discussion, Jonathan.

Hi Sreenivas,

>=20
> We need guidance from the community.
>=20
> 1. Datacenter customers must be able to manage PCIe switches in-band.

What is the use case? My understanding so far is that clouds and
similar sometimes use an in band path but it would be from a management
only host, not a general purpose host running other software. Sure
that control host just connects to a different upstream port so, from
a switch point of view, it's the same as any other host.  From a host
software point of view it's not running general cloud workloads or
(at least in most cases) a general purpose OS distribution.

This is the key question behind this discussion.

> 2. Management of switches includes getting health, performance, and error
> telemetry.

For telemetry(subject to any odd corners like commands that might lock
the interface up for a long time, which we've seen with commands in the
Spec!) I don't see any problem supporting those on all host software.
They should be non destructive to other hosts etc.

> 3. These telemetry functions are not yet part of the CXL standard

Ok, so this we should try to pin down the boundaries around this.
The thread linked below lays out the reasoning behind a general rule
of not accepting vendor defined commands, but perhaps there are routes
to answer some of those concerns.

'Maybe' if you were to publish a specification for those particular
vendor defined commands, it might be fine to add them to the allow list
for the switch-cci. Key here is that Broadcom would be committing to not
using those particular opcodes from the vendor space for anything else
in the future (so we could match on VID + opcode).  This is similar to
some DVSEC usage in PCIe (and why DVSEC is different from VSEC).

Effectively you'd be publishing an additional specification building on CXL.
Those are expected to surface anyway from various standards orgs - should
we treat a company published one differently?  I don't see why.
Exactly how this would work might take some figuring out (in main code,
separate driver module etc?)

That specification would be expected to provide a similar level of detail
to CXL spec defined commands (ideally the less vague ones, but meh, up to
you as long as any side effects are clearly documented!)

Speaking for myself, I'd consider this approach.
Particularly true if I see clear effort in the standards org to push
these into future specifications as that shows broadcom are trying to
enhance the ecosystems.


> 4. We built the CCI mailboxes into our PCIe switches per CXL spec and
> developed our management scheme around them.
>=20
> If the Linux community does not allow a CXL spec-compliant switch to be
> managed via the CXL spec-defined CCI mailbox, then please guide us on
> the right approach. Please tell us how you propose we manage our switches
> in-band.

The Linux community is fine supporting this in the kernel (the BMC or
Fabric Management only host case - option 2 below, so the code will be ther=
e)
the question here is what advice we offer to the general purpose
distributions and what protections we need to put in place to mitigate the
'blast radius' concerns.

Jonathan
>=20
> Thank you
> Sreeni
>=20
> On Thu, Mar 21, 2024 at 10:44=E2=80=AFAM Jonathan Cameron <
> Jonathan.Cameron@huawei.com> wrote: =20
>=20
> > Hi All,
> >
> > This is has come up in a number of discussions both on list and in priv=
ate,
> > so I wanted to lay out a potential set of rules when deciding whether or
> > not
> > to provide a user space interface for a particular feature of CXL Fabric
> > Management.  The intent is to drive discussion, not to simply tell peop=
le
> > a set of rules.  I've brought this to the public lists as it's a Linux
> > kernel
> > policy discussion, not a standards one.
> >
> > Whilst I'm writing the RFC this my attempt to summarize a possible
> > position rather than necessarily being my personal view.
> >
> > It's a straw man - shoot at it!
> >
> > Not everyone in this discussion is familiar with relevant kernel or CXL
> > concepts
> > so I've provided more info than I normally would.
> >
> > First some background:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > CXL has two different types of Fabric. The comments here refer to both,=
 but
> > for now the kernel stack is focused on the simpler VCS fabric, not the =
more
> > recent Port Based Routing (PBR) Fabrics. A typical example for 2 hosts
> > connected to a common switch looks something like:
> >
> >  ________________               _______________
> > |                |             |               |    Hosts - each sees
> > |    HOST A      |             |     HOST B    |    a PCIe style tree
> > |                |             |               |    but from a fabric
> > config
> > |   |Root Port|  |             |   |Root Port| |    point of view it's =
more
> >  -------|--------               -------|-------     complex.
> >         |                              |
> >         |                              |
> >  _______|______________________________|________
> > |      USP (SW-CCI)                   USP       | Switch can have lots =
of
> > |       |                              |        | Upstream Ports. Each =
one
> > |   ____|________               _______|______  | has a virtual hierarc=
hy.
> > |  |             |              |             | |
> > | vPPB          vPPB          vPPB          vPPB| There are virtual
> > |  x             |             |              | | "downstream
> > ports."(vPPBs)
> > |                \            /              /  | That can be bound to =
real
> > |                 \          /              /   | downstream ports.
> > |                  \        /              /    |
> > |                   \      /              /     | Multi Logical Devices=
 are
> > |      DSP0           DSP1             DSP 2    | support more than one
> > vPPB
> > ------------------------------------------------  bound to a single
> > physical
> >          |             |                 |        DSP (transactions are
> > tagged
> >          |             |                 |        with an LD-ID)
> >         SLD0           MLD0              SLD1
> >
> > Some typical fabric management activities:
> > 1) Bind/Unbind vPPB to physical DSP (Results in hotplug / unplug events)
> > 2) Access config space or BAR space of End Points below the switch.
> > 3) Tunneling messages through to devices downstream (e.g Dynamic Capaci=
ty
> >    Forced Remove that will blow away some memory even if a host is using
> > it).
> > 4) Non destructive stuff like status read back.
> >
> > Given the hosts may be using the Type 3 hosted memory (either Single
> > Logical
> > Device - SLD, or an LD on a Multi logical Device - MLD) as normal memor=
y,
> > unbinding a device in use can result in the memory access from a
> > different host being removed. The 'blast radius' is perhaps a rack of
> > servers.  This discussion applies equally to FM-API commands sent to Mu=
lti
> > Head Devices (see CXL r3.1).
> >
> > The Fabric Management actions are done using the CXL spec defined Fabric
> > Management API, (FM-API) which is transported over various means includ=
ing
> > OoB MCTP over your favourite transport (I2C, PCIe-VDM...) or via normal
> > PCIe read/write to a Switch-CCI.  A Switch-CCI is mailbox in PCI BAR
> > space on a function found alongside one of the switch upstream ports;
> > this mailbox is very similar to the MMPT definition found in PCIe r6.2.
> >
> > In many cases this switch CCI / MCTP connection is used by a BMC rather
> > than a normal host, but there have been some questions raised about whe=
ther
> > a general purpose server OS would have a valid reason to use this inter=
face
> > (beyond debug and testing) to configure the switch or an MHD.
> >
> > If people have a use case for this, please reply to this thread to give
> > more details.
> >
> > The most recently posted CXL Switch-CCI support only provided the RAW C=
XL
> > command IOCTL interface that is already available for Type 3 memory
> > devices.
> > That allows for unfettered control of the switch but, because it is
> > extremely easy to shoot yourself in the foot and cause unsolvable bug
> > reports,
> > it taints the kernel. There have been several requests to provide this
> > interface
> > without the taint for these switch configuration mailboxes.
> >
> > Last posted series:
> >
> > https://lore.kernel.org/all/20231016125323.18318-1-Jonathan.Cameron@hua=
wei.com/
> > Note there are unrelated reasons why that code hasn't been updated since
> > v6.6 time,
> > but I am planning to get back to it shortly.
> >
> > Similar issues will occur for other uses of PCIe MMPT (new mailbox in P=
CI
> > that
> > sometimes is used for similarly destructive activity such as PLDM based
> > firmware update).
> >
> >
> > On to the proposed rules:
> >
> > 1) Kernel space use of the various mailboxes, or filtered controls from
> > user space.
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Absolutely fine - no one worries about this, but the mediated traffic w=
ill
> > be filtered for potentially destructive side effects. E.g. it will reje=
ct
> > attempts to change anything routing related if the kernel either knows a
> > host is
> > using memory that will be blown away, or has no way to know (so affecti=
ng
> > routing to another host).  This includes blocking 'all' vendor defined
> > messages as we have no idea what the do.  Note this means the kernel has
> > an allow list and new commands are not initially allowed.
> >
> > This isn't currently enabled for Switch CCIs because they are only real=
ly
> > interesting if the potentially destructive stuff is available (an earli=
er
> > version did enable query commands, but it wasn't particularly useful to
> > know what your switch could do but not be allowed to do any of it).
> > If you take a MMPT usecase of PLDM firmware update, the filtering would
> > check that the device was in a state where a firmware update won't rip
> > memory out from under a host, which would be messy if that host is
> > doing the update.
> >
> > 2) Unfiltered userspace use of mailbox for Fabric Management - BMC kern=
els
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >
> > (This would just be a kernel option that we'd advise normal server
> > distributions not to turn on. Would be enabled by openBMC etc)
> >
> > This is fine - there is some work to do, but the switch-cci PCI driver
> > will hopefully be ready for upstream merge soon. There is no filtering =
of
> > accesses. Think of this as similar to all the damage you can do via
> > MCTP from a BMC. Similarly it is likely that much of the complexity
> > of the actual commands will be left to user space tooling:
> > https://gitlab.com/jic23/cxl-fmapi-tests has some test examples.
> >
> > Whether Kconfig help text is strong enough to ensure this only gets
> > enabled for BMC targeted distros is an open question we can address
> > alongside an updated patch set.
> >
> > (On to the one that the "debate" is about)
> >
> > 3) Unfiltered user space use of mailbox for Fabric Management - Distro
> > kernels
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > (General purpose Linux Server Distro (Redhat, Suse etc))
> >
> > This is equivalent of RAW command support on CXL Type 3 memory devices.
> > You can enable those in a distro kernel build despite the scary config
> > help text, but if you use it the kernel is tainted. The result
> > of the taint is to add a flag to bug reports and print a big message to=
 say
> > that you've used a feature that might result in you shooting yourself
> > in the foot.
> >
> > The taint is there because software is not at first written to deal with
> > everything that can happen smoothly (e.g. surprise removal) It's hard
> > to survive some of these events, so is never on the initial feature list
> > for any bus, so this flag is just to indicate we have entered a world
> > where almost all bets are off wrt to stability.  We might not know what
> > a command does so we can't assess the impact (and no one trusts vendor
> > commands to report affects right in the Command Effects Log - which
> > in theory tells you if a command can result problems).
> >
> > A concern was raised about GAE/FAST/LDST tables for CXL Fabrics
> > (a r3.1 feature) but, as I understand it, these are intended for a
> > host to configure and should not have side effects on other hosts?
> > My working assumption is that the kernel driver stack will handle
> > these (once we catch up with the current feature backlog!) Currently
> > we have no visibility of what the OS driver stack for a fabrics will
> > actually look like - the spec is just the starting point for that.
> > (patches welcome ;)
> >
> > The various CXL upstream developers and maintainers may have
> > differing views of course, but my current understanding is we want
> > to support 1 and 2, but are very resistant to 3!
> >
> > General Notes
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > One side aspect of why we really don't like unfiltered userspace access=
 to
> > any
> > of these devices is that people start building non standard hacks in an=
d we
> > lose the ecosystem advantages. Forcing a considered discussion + patches
> > to let a particular command be supported, drives standardization.
> >
> >
> > https://lore.kernel.org/linux-cxl/CAPcyv4gDShAYih5iWabKg_eTHhuHm54vEAei=
8ZkcmHnPp3B0cw@mail.gmail.com/
> > provides some history on vendor specific extensions and why in general =
we
> > won't support them upstream.
> >
> > To address another question raised in an earlier discussion:
> > Putting these Fabric Management interfaces behind guard rails of some t=
ype
> > (e.g. CONFIG_IM_A_BMC_AND_CAN_MAKE_A_MESS) does not encourage the risk
> > of non standard interfaces, because we will be even less likely to acce=
pt
> > those upstream!
> >
> > If anyone needs more details on any aspect of this please ask.
> > There are a lot of things involved and I've only tried to give a fairly
> > minimal illustration to drive the discussion. I may well have missed
> > something crucial.
> >
> > Jonathan
> >
> > =20
>=20


