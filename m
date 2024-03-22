Return-Path: <linux-kernel+bounces-111475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 365A2886CD0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B5D11C21A0F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672B345C16;
	Fri, 22 Mar 2024 13:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dJfxy038"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B8645BEC
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 13:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711113910; cv=none; b=jQW/lFp5f0Jqk6IMjYMK/sCj0FJ+uxDJlwAEZV8MfQddhgplF0IKn0MoL2MhXkg56DN4wNoZiC5Ca9qwohz5aOuYC8ZiG5jSzrvPHbf2cgvAff7wdJ6hExDWMpo90cble+ticO13BpuKai+lS4O/PgxGCBX2jTfjiA1n/lOJgwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711113910; c=relaxed/simple;
	bh=a860Q+FCKCxIx3a3OW1MP3J55EdbrgkWmdqqx+0Xhdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uvyd1NwC2TG0+2VtwDc6oe0ngEwhKpIgIuiGZV69gEk/rEt/Ff8QedqaITHqI1x2Ord7YcKXq/zLrt3CXgRvFxL5N5u37OtIYwUlDL6IrgRmLZP1+CRd0qRCmUVjfw9pZR3/UX7GYbnUBZqF35LEXep3Q6jCV1O3fwKOL74fuHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dJfxy038; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-609fd5fbe50so22907107b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 06:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1711113907; x=1711718707; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lMYW7skRbn3pAYp8hi7a3mZ6ZY5qDCShasXZFbgLBfM=;
        b=dJfxy0388HJq712YVbB2BgmYW9Ct6yaj5qSENSGD/TsUkSnxixxJGjbhCThc73MOiL
         3rLoOUHcKAO7gpeYmnIJyX1HBn5deuNWTXd7z8EpTEvbUC+G3D5GrTJoliQzgXUDR5HE
         6NCXeKhLgO0EmIf/1QNtNmYxQaPGrzQ3taW9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711113907; x=1711718707;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lMYW7skRbn3pAYp8hi7a3mZ6ZY5qDCShasXZFbgLBfM=;
        b=ouGtxJhySl4SBV7dRZIH53y/wpcgyMDE+x6cv63MPTADeA6ge454dyB8Owz5RnIieI
         O14T+EBNgR/QGRRV22w+bkyjPne8YUNLURIfzDklsO6F78UpbDs62nmh+nLcdrAAVVZn
         EcYjZfDOFf+A5iQaHp15vq406+Mmtt9uUZ+L6s+mmmyrX/rFfJ39Tas3kqdBajWx7ZbS
         NG/SddmeAHi65YAXvEk4BfAlO1vnoI5VlIBXpS/u/FYkXHqn8zjscm0o6bW1F2povo5W
         WxqVnUnTAVTcBaYxhLOboDG50Kd5+t5puqBTywHlkKBy74fjyjYuXt3kQG9ad514Mopy
         FkYA==
X-Forwarded-Encrypted: i=1; AJvYcCXhe/Ux7J3KUP7XCVih9QNhVJiAbj9a9fyOsot5692J0ukH9OWjVJGdMLZPD5bjYQeqHH51eWx1eYRtfcrviOaMrQuqaq1C4gPGe5a3
X-Gm-Message-State: AOJu0YxwLZtviJu9p24/Lpmh4UBrApqxiKgrkkEdGX0iLTdpYD1OAlZJ
	n3PuZSZzxhEN9JInM1SOyy4loQRA7jVK4Ls6uUyeqAjU7N/Pqk5eEadQYr5Mn7+NJwqkrIFjK1T
	eQGno4S4msNZf1QlX916ceBjU03pkDQ1VWs5MXIDRcHkJNm1Hxb8Xvtt91/GQRiZzqC20SmLoxv
	rvcxKFucpLeuRpztfODG0x9Fmfag==
X-Google-Smtp-Source: AGHT+IHu7w4bkMH6HzPqJ9Drr3zsoc1W3zmDvaJOlfYBBUWHQVhNLa3D1w+yosZdtzHQyDI43TAgO8f2NcABD/4H2AY=
X-Received: by 2002:a25:d890:0:b0:dc7:4800:c758 with SMTP id
 p138-20020a25d890000000b00dc74800c758mr2085019ybg.10.1711113905552; Fri, 22
 Mar 2024 06:25:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321174423.00007e0d@Huawei.com> <CACX_a4VPV16OFNZLCVUJrGFR5brcdiYN3aAgrxtO8ksUdNdkQQ@mail.gmail.com>
 <20240322093212.00003173@Huawei.com>
In-Reply-To: <20240322093212.00003173@Huawei.com>
From: Sreenivas Bagalkote <sreenivas.bagalkote@broadcom.com>
Date: Fri, 22 Mar 2024 06:24:37 -0700
Message-ID: <CACX_a4U_==8pVqrqyrKeUhMuvvcP53g4irkwauFK3Edxbxp9NA@mail.gmail.com>
Subject: Re: RFC: Restricting userspace interfaces for CXL fabric management
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, Brett Henning <brett.henning@broadcom.com>, 
	Harold Johnson <harold.johnson@broadcom.com>, 
	Sumanesh Samanta <sumanesh.samanta@broadcom.com>, 
	"Williams, Dan J" <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, 
	Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, linuxarm@huawei.com, linux-api@vger.kernel.org, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, "Natu, Mahesh" <mahesh.natu@intel.com>, 
	Ariel.Sibley@microchip.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000098f19106143fc0a9"

--00000000000098f19106143fc0a9
Content-Type: multipart/alternative; boundary="0000000000008364af06143fc053"

--0000000000008364af06143fc053
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jonathan,

>
> What is the use case? My understanding so far is that clouds and
> similar sometimes use an in band path but it would be from a management
> only host, not a general purpose host running other software
>

The overwhelming majority of the PCIe switches get deployed in a single
server. Typically four to eight switches are connected to two or more root
complexes in one or two CPUs. The deployment scenario you have in mind -
multiple physical hosts running general workloads and a management-only
host - exists. But it is insignificant.

>
> For telemetry(subject to any odd corners like commands that might lock
> the interface up for a long time, which we've seen with commands in the
> Spec!) I don't see any problem supporting those on all host software.
> They should be non destructive to other hosts etc.
>

Thank you. As you do this, please keep in mind that your concern about not
affecting "other" hosts is theoretically valid but doesn't exist in the
real world beyond science experiments. If there are real-world deployments,
they are insignificant. I urge you all to make your stuff work with 99.99%
of the deployments.

>
> 'Maybe' if you were to publish a specification for those particular
> vendor defined commands, it might be fine to add them to the allow list
> for the switch-cci.
>

Your proposal sounds reasonable. I will let you all experts figure out how
to support the vendor-defined commands. CXL spec has them for a reason and
they need to be supported.

Sreeni

On Fri, Mar 22, 2024 at 2:32=E2=80=AFAM Jonathan Cameron <
Jonathan.Cameron@huawei.com> wrote:

> On Thu, 21 Mar 2024 14:41:00 -0700
> Sreenivas Bagalkote <sreenivas.bagalkote@broadcom.com> wrote:
>
> > Thank you for kicking off this discussion, Jonathan.
>
> Hi Sreenivas,
>
> >
> > We need guidance from the community.
> >
> > 1. Datacenter customers must be able to manage PCIe switches in-band.
>
> What is the use case? My understanding so far is that clouds and
> similar sometimes use an in band path but it would be from a management
> only host, not a general purpose host running other software. Sure
> that control host just connects to a different upstream port so, from
> a switch point of view, it's the same as any other host.  From a host
> software point of view it's not running general cloud workloads or
> (at least in most cases) a general purpose OS distribution.
>
> This is the key question behind this discussion.
>
> > 2. Management of switches includes getting health, performance, and err=
or
> > telemetry.
>
> For telemetry(subject to any odd corners like commands that might lock
> the interface up for a long time, which we've seen with commands in the
> Spec!) I don't see any problem supporting those on all host software.
> They should be non destructive to other hosts etc.
>
> > 3. These telemetry functions are not yet part of the CXL standard
>
> Ok, so this we should try to pin down the boundaries around this.
> The thread linked below lays out the reasoning behind a general rule
> of not accepting vendor defined commands, but perhaps there are routes
> to answer some of those concerns.
>
> 'Maybe' if you were to publish a specification for those particular
> vendor defined commands, it might be fine to add them to the allow list
> for the switch-cci. Key here is that Broadcom would be committing to not
> using those particular opcodes from the vendor space for anything else
> in the future (so we could match on VID + opcode).  This is similar to
> some DVSEC usage in PCIe (and why DVSEC is different from VSEC).
>
> Effectively you'd be publishing an additional specification building on
> CXL.
> Those are expected to surface anyway from various standards orgs - should
> we treat a company published one differently?  I don't see why.
> Exactly how this would work might take some figuring out (in main code,
> separate driver module etc?)
>
> That specification would be expected to provide a similar level of detail
> to CXL spec defined commands (ideally the less vague ones, but meh, up to
> you as long as any side effects are clearly documented!)
>
> Speaking for myself, I'd consider this approach.
> Particularly true if I see clear effort in the standards org to push
> these into future specifications as that shows broadcom are trying to
> enhance the ecosystems.
>
>
> > 4. We built the CCI mailboxes into our PCIe switches per CXL spec and
> > developed our management scheme around them.
> >
> > If the Linux community does not allow a CXL spec-compliant switch to be
> > managed via the CXL spec-defined CCI mailbox, then please guide us on
> > the right approach. Please tell us how you propose we manage our switch=
es
> > in-band.
>
> The Linux community is fine supporting this in the kernel (the BMC or
> Fabric Management only host case - option 2 below, so the code will be
> there)
> the question here is what advice we offer to the general purpose
> distributions and what protections we need to put in place to mitigate th=
e
> 'blast radius' concerns.
>
> Jonathan
> >
> > Thank you
> > Sreeni
> >
> > On Thu, Mar 21, 2024 at 10:44=E2=80=AFAM Jonathan Cameron <
> > Jonathan.Cameron@huawei.com> wrote:
> >
> > > Hi All,
> > >
> > > This is has come up in a number of discussions both on list and in
> private,
> > > so I wanted to lay out a potential set of rules when deciding whether
> or
> > > not
> > > to provide a user space interface for a particular feature of CXL
> Fabric
> > > Management.  The intent is to drive discussion, not to simply tell
> people
> > > a set of rules.  I've brought this to the public lists as it's a Linu=
x
> > > kernel
> > > policy discussion, not a standards one.
> > >
> > > Whilst I'm writing the RFC this my attempt to summarize a possible
> > > position rather than necessarily being my personal view.
> > >
> > > It's a straw man - shoot at it!
> > >
> > > Not everyone in this discussion is familiar with relevant kernel or C=
XL
> > > concepts
> > > so I've provided more info than I normally would.
> > >
> > > First some background:
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > CXL has two different types of Fabric. The comments here refer to
> both, but
> > > for now the kernel stack is focused on the simpler VCS fabric, not th=
e
> more
> > > recent Port Based Routing (PBR) Fabrics. A typical example for 2 host=
s
> > > connected to a common switch looks something like:
> > >
> > >  ________________               _______________
> > > |                |             |               |    Hosts - each sees
> > > |    HOST A      |             |     HOST B    |    a PCIe style tree
> > > |                |             |               |    but from a fabric
> > > config
> > > |   |Root Port|  |             |   |Root Port| |    point of view it'=
s
> more
> > >  -------|--------               -------|-------     complex.
> > >         |                              |
> > >         |                              |
> > >  _______|______________________________|________
> > > |      USP (SW-CCI)                   USP       | Switch can have lot=
s
> of
> > > |       |                              |        | Upstream Ports. Eac=
h
> one
> > > |   ____|________               _______|______  | has a virtual
> hierarchy.
> > > |  |             |              |             | |
> > > | vPPB          vPPB          vPPB          vPPB| There are virtual
> > > |  x             |             |              | | "downstream
> > > ports."(vPPBs)
> > > |                \            /              /  | That can be bound t=
o
> real
> > > |                 \          /              /   | downstream ports.
> > > |                  \        /              /    |
> > > |                   \      /              /     | Multi Logical
> Devices are
> > > |      DSP0           DSP1             DSP 2    | support more than o=
ne
> > > vPPB
> > > ------------------------------------------------  bound to a single
> > > physical
> > >          |             |                 |        DSP (transactions a=
re
> > > tagged
> > >          |             |                 |        with an LD-ID)
> > >         SLD0           MLD0              SLD1
> > >
> > > Some typical fabric management activities:
> > > 1) Bind/Unbind vPPB to physical DSP (Results in hotplug / unplug
> events)
> > > 2) Access config space or BAR space of End Points below the switch.
> > > 3) Tunneling messages through to devices downstream (e.g Dynamic
> Capacity
> > >    Forced Remove that will blow away some memory even if a host is
> using
> > > it).
> > > 4) Non destructive stuff like status read back.
> > >
> > > Given the hosts may be using the Type 3 hosted memory (either Single
> > > Logical
> > > Device - SLD, or an LD on a Multi logical Device - MLD) as normal
> memory,
> > > unbinding a device in use can result in the memory access from a
> > > different host being removed. The 'blast radius' is perhaps a rack of
> > > servers.  This discussion applies equally to FM-API commands sent to
> Multi
> > > Head Devices (see CXL r3.1).
> > >
> > > The Fabric Management actions are done using the CXL spec defined
> Fabric
> > > Management API, (FM-API) which is transported over various means
> including
> > > OoB MCTP over your favourite transport (I2C, PCIe-VDM...) or via norm=
al
> > > PCIe read/write to a Switch-CCI.  A Switch-CCI is mailbox in PCI BAR
> > > space on a function found alongside one of the switch upstream ports;
> > > this mailbox is very similar to the MMPT definition found in PCIe r6.=
2.
> > >
> > > In many cases this switch CCI / MCTP connection is used by a BMC rath=
er
> > > than a normal host, but there have been some questions raised about
> whether
> > > a general purpose server OS would have a valid reason to use this
> interface
> > > (beyond debug and testing) to configure the switch or an MHD.
> > >
> > > If people have a use case for this, please reply to this thread to gi=
ve
> > > more details.
> > >
> > > The most recently posted CXL Switch-CCI support only provided the RAW
> CXL
> > > command IOCTL interface that is already available for Type 3 memory
> > > devices.
> > > That allows for unfettered control of the switch but, because it is
> > > extremely easy to shoot yourself in the foot and cause unsolvable bug
> > > reports,
> > > it taints the kernel. There have been several requests to provide thi=
s
> > > interface
> > > without the taint for these switch configuration mailboxes.
> > >
> > > Last posted series:
> > >
> > >
> https://lore.kernel.org/all/20231016125323.18318-1-Jonathan.Cameron@huawe=
i.com/
> > > Note there are unrelated reasons why that code hasn't been updated
> since
> > > v6.6 time,
> > > but I am planning to get back to it shortly.
> > >
> > > Similar issues will occur for other uses of PCIe MMPT (new mailbox in
> PCI
> > > that
> > > sometimes is used for similarly destructive activity such as PLDM bas=
ed
> > > firmware update).
> > >
> > >
> > > On to the proposed rules:
> > >
> > > 1) Kernel space use of the various mailboxes, or filtered controls fr=
om
> > > user space.
> > >
> > >
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > Absolutely fine - no one worries about this, but the mediated traffic
> will
> > > be filtered for potentially destructive side effects. E.g. it will
> reject
> > > attempts to change anything routing related if the kernel either know=
s
> a
> > > host is
> > > using memory that will be blown away, or has no way to know (so
> affecting
> > > routing to another host).  This includes blocking 'all' vendor define=
d
> > > messages as we have no idea what the do.  Note this means the kernel
> has
> > > an allow list and new commands are not initially allowed.
> > >
> > > This isn't currently enabled for Switch CCIs because they are only
> really
> > > interesting if the potentially destructive stuff is available (an
> earlier
> > > version did enable query commands, but it wasn't particularly useful =
to
> > > know what your switch could do but not be allowed to do any of it).
> > > If you take a MMPT usecase of PLDM firmware update, the filtering wou=
ld
> > > check that the device was in a state where a firmware update won't ri=
p
> > > memory out from under a host, which would be messy if that host is
> > > doing the update.
> > >
> > > 2) Unfiltered userspace use of mailbox for Fabric Management - BMC
> kernels
> > >
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > (This would just be a kernel option that we'd advise normal server
> > > distributions not to turn on. Would be enabled by openBMC etc)
> > >
> > > This is fine - there is some work to do, but the switch-cci PCI drive=
r
> > > will hopefully be ready for upstream merge soon. There is no filterin=
g
> of
> > > accesses. Think of this as similar to all the damage you can do via
> > > MCTP from a BMC. Similarly it is likely that much of the complexity
> > > of the actual commands will be left to user space tooling:
> > > https://gitlab.com/jic23/cxl-fmapi-tests has some test examples.
> > >
> > > Whether Kconfig help text is strong enough to ensure this only gets
> > > enabled for BMC targeted distros is an open question we can address
> > > alongside an updated patch set.
> > >
> > > (On to the one that the "debate" is about)
> > >
> > > 3) Unfiltered user space use of mailbox for Fabric Management - Distr=
o
> > > kernels
> > >
> > >
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > > (General purpose Linux Server Distro (Redhat, Suse etc))
> > >
> > > This is equivalent of RAW command support on CXL Type 3 memory device=
s.
> > > You can enable those in a distro kernel build despite the scary confi=
g
> > > help text, but if you use it the kernel is tainted. The result
> > > of the taint is to add a flag to bug reports and print a big message
> to say
> > > that you've used a feature that might result in you shooting yourself
> > > in the foot.
> > >
> > > The taint is there because software is not at first written to deal
> with
> > > everything that can happen smoothly (e.g. surprise removal) It's hard
> > > to survive some of these events, so is never on the initial feature
> list
> > > for any bus, so this flag is just to indicate we have entered a world
> > > where almost all bets are off wrt to stability.  We might not know wh=
at
> > > a command does so we can't assess the impact (and no one trusts vendo=
r
> > > commands to report affects right in the Command Effects Log - which
> > > in theory tells you if a command can result problems).
> > >
> > > A concern was raised about GAE/FAST/LDST tables for CXL Fabrics
> > > (a r3.1 feature) but, as I understand it, these are intended for a
> > > host to configure and should not have side effects on other hosts?
> > > My working assumption is that the kernel driver stack will handle
> > > these (once we catch up with the current feature backlog!) Currently
> > > we have no visibility of what the OS driver stack for a fabrics will
> > > actually look like - the spec is just the starting point for that.
> > > (patches welcome ;)
> > >
> > > The various CXL upstream developers and maintainers may have
> > > differing views of course, but my current understanding is we want
> > > to support 1 and 2, but are very resistant to 3!
> > >
> > > General Notes
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > One side aspect of why we really don't like unfiltered userspace
> access to
> > > any
> > > of these devices is that people start building non standard hacks in
> and we
> > > lose the ecosystem advantages. Forcing a considered discussion +
> patches
> > > to let a particular command be supported, drives standardization.
> > >
> > >
> > >
> https://lore.kernel.org/linux-cxl/CAPcyv4gDShAYih5iWabKg_eTHhuHm54vEAei8Z=
kcmHnPp3B0cw@mail.gmail.com/
> > > provides some history on vendor specific extensions and why in genera=
l
> we
> > > won't support them upstream.
> > >
> > > To address another question raised in an earlier discussion:
> > > Putting these Fabric Management interfaces behind guard rails of some
> type
> > > (e.g. CONFIG_IM_A_BMC_AND_CAN_MAKE_A_MESS) does not encourage the ris=
k
> > > of non standard interfaces, because we will be even less likely to
> accept
> > > those upstream!
> > >
> > > If anyone needs more details on any aspect of this please ask.
> > > There are a lot of things involved and I've only tried to give a fair=
ly
> > > minimal illustration to drive the discussion. I may well have missed
> > > something crucial.
> > >
> > > Jonathan
> > >
> > >
> >
>
>

--=20
This electronic communication and the information and any files transmitted=
=20
with it, or attached to it, are confidential and are intended solely for=20
the use of the individual or entity to whom it is addressed and may contain=
=20
information that is confidential, legally privileged, protected by privacy=
=20
laws, or otherwise restricted from disclosure to anyone else. If you are=20
not the intended recipient or the person responsible for delivering the=20
e-mail to the intended recipient, you are hereby notified that any use,=20
copying, distributing, dissemination, forwarding, printing, or copying of=
=20
this e-mail is strictly prohibited. If you received this e-mail in error,=
=20
please return the e-mail to the sender, delete it from your computer, and=
=20
destroy any printed copy of it.

--0000000000008364af06143fc053
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><font face=3D"monospace">Jonathan,</font></div><div class=3D"=
gmail_default" style=3D"font-size:small"><font face=3D"monospace"><br></fon=
t></div><div class=3D"gmail_default" style=3D"font-size:small"><font face=
=3D"monospace">&gt;</font></div><div class=3D"gmail_default" style=3D"font-=
size:small">&gt; What is the use case? My understanding so far is that clou=
ds and<br>&gt; similar sometimes use an in band path but it would be from a=
 management<br>&gt; only host, not a general purpose host running other sof=
tware<font face=3D"monospace"><br></font></div><div class=3D"gmail_default"=
 style=3D"font-size:small"><font face=3D"monospace">&gt;</font></div><div c=
lass=3D"gmail_default" style=3D"font-size:small"><font face=3D"monospace"><=
br></font></div><div class=3D"gmail_default" style=3D"font-size:small"><fon=
t face=3D"monospace">The overwhelming majority of the PCIe switches get dep=
loyed in a single server. Typically four to eight switches are connected to=
 two or more root complexes in one or two CPUs. The deployment scenario you=
 have in mind - multiple physical hosts running general workloads and a man=
agement-only host - exists. But it is insignificant.</font></div><div class=
=3D"gmail_default" style=3D"font-size:small"><font face=3D"monospace"><br><=
/font></div><div class=3D"gmail_default" style=3D"font-size:small">&gt;=C2=
=A0<font face=3D"monospace"><br></font></div><div class=3D"gmail_default" s=
tyle=3D"font-size:small">&gt; For telemetry(subject to any odd corners like=
 commands that might lock<br>&gt;=C2=A0the interface up for a long time, wh=
ich we&#39;ve seen with commands in the<br>&gt;=C2=A0Spec!) I don&#39;t see=
 any problem supporting those on all host software.<br>&gt;=C2=A0They shoul=
d be non destructive to other hosts etc.<font face=3D"monospace"><br></font=
></div><div class=3D"gmail_default" style=3D"font-size:small">&gt;=C2=A0<br=
></div><div class=3D"gmail_default" style=3D"font-size:small"><font face=3D=
"monospace"><br></font></div><div class=3D"gmail_default" style=3D"font-siz=
e:small"><font face=3D"monospace">Thank you. As you do this, please keep in=
 mind that your concern about not affecting &quot;other&quot; hosts is theo=
retically valid but doesn&#39;t exist in the real world beyond science expe=
riments. If there are real-world deployments, they are insignificant. I urg=
e you all to make your stuff work with 99.99% of the deployments.</font></d=
iv><div class=3D"gmail_default" style=3D"font-size:small"><font face=3D"mon=
ospace"><br></font></div><div class=3D"gmail_default" style=3D"font-size:sm=
all"><font face=3D"monospace">&gt;</font></div><div class=3D"gmail_default"=
 style=3D"font-size:small">&gt; &#39;Maybe&#39; if you were to publish a sp=
ecification for those particular<br>&gt; vendor defined commands, it might =
be fine to add them to the allow list<br>&gt; for the switch-cci.<font face=
=3D"monospace"><br></font></div><div class=3D"gmail_default" style=3D"font-=
size:small">&gt;</div><div class=3D"gmail_default" style=3D"font-size:small=
"><br></div><div class=3D"gmail_default" style=3D"font-size:small"><font fa=
ce=3D"monospace">Your proposal sounds reasonable. I will let you all expert=
s figure out how to support the vendor-defined commands. CXL spec has them =
for a reason and they need to be supported.</font></div><div class=3D"gmail=
_default" style=3D"font-size:small"><font face=3D"monospace"><br></font></d=
iv><div class=3D"gmail_default" style=3D"font-size:small"><font face=3D"mon=
ospace">Sreeni</font></div></div><br><div class=3D"gmail_quote"><div dir=3D=
"ltr" class=3D"gmail_attr">On Fri, Mar 22, 2024 at 2:32=E2=80=AFAM Jonathan=
 Cameron &lt;<a href=3D"mailto:Jonathan.Cameron@huawei.com">Jonathan.Camero=
n@huawei.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">On Thu, 21 Mar 2024 14:41:00 -0700<br>
Sreenivas Bagalkote &lt;<a href=3D"mailto:sreenivas.bagalkote@broadcom.com"=
 target=3D"_blank">sreenivas.bagalkote@broadcom.com</a>&gt; wrote:<br>
<br>
&gt; Thank you for kicking off this discussion, Jonathan.<br>
<br>
Hi Sreenivas,<br>
<br>
&gt; <br>
&gt; We need guidance from the community.<br>
&gt; <br>
&gt; 1. Datacenter customers must be able to manage PCIe switches in-band.<=
br>
<br>
What is the use case? My understanding so far is that clouds and<br>
similar sometimes use an in band path but it would be from a management<br>
only host, not a general purpose host running other software. Sure<br>
that control host just connects to a different upstream port so, from<br>
a switch point of view, it&#39;s the same as any other host.=C2=A0 From a h=
ost<br>
software point of view it&#39;s not running general cloud workloads or<br>
(at least in most cases) a general purpose OS distribution.<br>
<br>
This is the key question behind this discussion.<br>
<br>
&gt; 2. Management of switches includes getting health, performance, and er=
ror<br>
&gt; telemetry.<br>
<br>
For telemetry(subject to any odd corners like commands that might lock<br>
the interface up for a long time, which we&#39;ve seen with commands in the=
<br>
Spec!) I don&#39;t see any problem supporting those on all host software.<b=
r>
They should be non destructive to other hosts etc.<br>
<br>
&gt; 3. These telemetry functions are not yet part of the CXL standard<br>
<br>
Ok, so this we should try to pin down the boundaries around this.<br>
The thread linked below lays out the reasoning behind a general rule<br>
of not accepting vendor defined commands, but perhaps there are routes<br>
to answer some of those concerns.<br>
<br>
&#39;Maybe&#39; if you were to publish a specification for those particular=
<br>
vendor defined commands, it might be fine to add them to the allow list<br>
for the switch-cci. Key here is that Broadcom would be committing to not<br=
>
using those particular opcodes from the vendor space for anything else<br>
in the future (so we could match on VID + opcode).=C2=A0 This is similar to=
<br>
some DVSEC usage in PCIe (and why DVSEC is different from VSEC).<br>
<br>
Effectively you&#39;d be publishing an additional specification building on=
 CXL.<br>
Those are expected to surface anyway from various standards orgs - should<b=
r>
we treat a company published one differently?=C2=A0 I don&#39;t see why.<br=
>
Exactly how this would work might take some figuring out (in main code,<br>
separate driver module etc?)<br>
<br>
That specification would be expected to provide a similar level of detail<b=
r>
to CXL spec defined commands (ideally the less vague ones, but meh, up to<b=
r>
you as long as any side effects are clearly documented!)<br>
<br>
Speaking for myself, I&#39;d consider this approach.<br>
Particularly true if I see clear effort in the standards org to push<br>
these into future specifications as that shows broadcom are trying to<br>
enhance the ecosystems.<br>
<br>
<br>
&gt; 4. We built the CCI mailboxes into our PCIe switches per CXL spec and<=
br>
&gt; developed our management scheme around them.<br>
&gt; <br>
&gt; If the Linux community does not allow a CXL spec-compliant switch to b=
e<br>
&gt; managed via the CXL spec-defined CCI mailbox, then please guide us on<=
br>
&gt; the right approach. Please tell us how you propose we manage our switc=
hes<br>
&gt; in-band.<br>
<br>
The Linux community is fine supporting this in the kernel (the BMC or<br>
Fabric Management only host case - option 2 below, so the code will be ther=
e)<br>
the question here is what advice we offer to the general purpose<br>
distributions and what protections we need to put in place to mitigate the<=
br>
&#39;blast radius&#39; concerns.<br>
<br>
Jonathan<br>
&gt; <br>
&gt; Thank you<br>
&gt; Sreeni<br>
&gt; <br>
&gt; On Thu, Mar 21, 2024 at 10:44=E2=80=AFAM Jonathan Cameron &lt;<br>
&gt; <a href=3D"mailto:Jonathan.Cameron@huawei.com" target=3D"_blank">Jonat=
han.Cameron@huawei.com</a>&gt; wrote:=C2=A0 <br>
&gt; <br>
&gt; &gt; Hi All,<br>
&gt; &gt;<br>
&gt; &gt; This is has come up in a number of discussions both on list and i=
n private,<br>
&gt; &gt; so I wanted to lay out a potential set of rules when deciding whe=
ther or<br>
&gt; &gt; not<br>
&gt; &gt; to provide a user space interface for a particular feature of CXL=
 Fabric<br>
&gt; &gt; Management.=C2=A0 The intent is to drive discussion, not to simpl=
y tell people<br>
&gt; &gt; a set of rules.=C2=A0 I&#39;ve brought this to the public lists a=
s it&#39;s a Linux<br>
&gt; &gt; kernel<br>
&gt; &gt; policy discussion, not a standards one.<br>
&gt; &gt;<br>
&gt; &gt; Whilst I&#39;m writing the RFC this my attempt to summarize a pos=
sible<br>
&gt; &gt; position rather than necessarily being my personal view.<br>
&gt; &gt;<br>
&gt; &gt; It&#39;s a straw man - shoot at it!<br>
&gt; &gt;<br>
&gt; &gt; Not everyone in this discussion is familiar with relevant kernel =
or CXL<br>
&gt; &gt; concepts<br>
&gt; &gt; so I&#39;ve provided more info than I normally would.<br>
&gt; &gt;<br>
&gt; &gt; First some background:<br>
&gt; &gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D<br>
&gt; &gt;<br>
&gt; &gt; CXL has two different types of Fabric. The comments here refer to=
 both, but<br>
&gt; &gt; for now the kernel stack is focused on the simpler VCS fabric, no=
t the more<br>
&gt; &gt; recent Port Based Routing (PBR) Fabrics. A typical example for 2 =
hosts<br>
&gt; &gt; connected to a common switch looks something like:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 ________________=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0_______________<br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 Hosts - each sees<br>
&gt; &gt; |=C2=A0 =C2=A0 HOST A=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0HOST B=C2=A0 =C2=A0 |=C2=A0=
 =C2=A0 a PCIe style tree<br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 but from a fabric<br>
&gt; &gt; config<br>
&gt; &gt; |=C2=A0 =C2=A0|Root Port|=C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0|Root Port| |=C2=A0 =C2=A0 point of view it&=
#39;s more<br>
&gt; &gt;=C2=A0 -------|--------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0-------|-------=C2=A0 =C2=A0 =C2=A0complex.<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
<br>
&gt; &gt;=C2=A0 _______|______________________________|________<br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 USP (SW-CCI)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0USP=C2=A0 =C2=A0 =C2=A0 =C2=A0| Switc=
h can have lots of<br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | Upstream Ports. Each one<br>
&gt; &gt; |=C2=A0 =C2=A0____|________=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0_______|______=C2=A0 | has a virtual hierarchy.<br>
&gt; &gt; |=C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| |<br>
&gt; &gt; | vPPB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vPPB=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 vPPB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vPPB| There are virtu=
al<br>
&gt; &gt; |=C2=A0 x=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | | &quot;downstream<br>
&gt; &gt; ports.&quot;(vPPBs)<br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /=C2=A0 | That can be bound to real<br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /=C2=A0 =C2=A0| downstream ports.<br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /=C2=A0 =C2=A0 |<br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0\=C2=A0 =C2=A0 =C2=A0 /=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /=C2=A0 =C2=A0 =C2=A0| Multi Logical Devices are<br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 DSP0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0DSP1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DSP 2=C2=A0 =C2=A0 |=
 support more than one<br>
&gt; &gt; vPPB<br>
&gt; &gt; ------------------------------------------------=C2=A0 bound to a=
 single<br>
&gt; &gt; physical<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 DSP (transactions are<br>
&gt; &gt; tagged<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 with an LD-ID)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SLD0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0MLD0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SLD1<br>
&gt; &gt;<br>
&gt; &gt; Some typical fabric management activities:<br>
&gt; &gt; 1) Bind/Unbind vPPB to physical DSP (Results in hotplug / unplug =
events)<br>
&gt; &gt; 2) Access config space or BAR space of End Points below the switc=
h.<br>
&gt; &gt; 3) Tunneling messages through to devices downstream (e.g Dynamic =
Capacity<br>
&gt; &gt;=C2=A0 =C2=A0 Forced Remove that will blow away some memory even i=
f a host is using<br>
&gt; &gt; it).<br>
&gt; &gt; 4) Non destructive stuff like status read back.<br>
&gt; &gt;<br>
&gt; &gt; Given the hosts may be using the Type 3 hosted memory (either Sin=
gle<br>
&gt; &gt; Logical<br>
&gt; &gt; Device - SLD, or an LD on a Multi logical Device - MLD) as normal=
 memory,<br>
&gt; &gt; unbinding a device in use can result in the memory access from a<=
br>
&gt; &gt; different host being removed. The &#39;blast radius&#39; is perha=
ps a rack of<br>
&gt; &gt; servers.=C2=A0 This discussion applies equally to FM-API commands=
 sent to Multi<br>
&gt; &gt; Head Devices (see CXL r3.1).<br>
&gt; &gt;<br>
&gt; &gt; The Fabric Management actions are done using the CXL spec defined=
 Fabric<br>
&gt; &gt; Management API, (FM-API) which is transported over various means =
including<br>
&gt; &gt; OoB MCTP over your favourite transport (I2C, PCIe-VDM...) or via =
normal<br>
&gt; &gt; PCIe read/write to a Switch-CCI.=C2=A0 A Switch-CCI is mailbox in=
 PCI BAR<br>
&gt; &gt; space on a function found alongside one of the switch upstream po=
rts;<br>
&gt; &gt; this mailbox is very similar to the MMPT definition found in PCIe=
 r6.2.<br>
&gt; &gt;<br>
&gt; &gt; In many cases this switch CCI / MCTP connection is used by a BMC =
rather<br>
&gt; &gt; than a normal host, but there have been some questions raised abo=
ut whether<br>
&gt; &gt; a general purpose server OS would have a valid reason to use this=
 interface<br>
&gt; &gt; (beyond debug and testing) to configure the switch or an MHD.<br>
&gt; &gt;<br>
&gt; &gt; If people have a use case for this, please reply to this thread t=
o give<br>
&gt; &gt; more details.<br>
&gt; &gt;<br>
&gt; &gt; The most recently posted CXL Switch-CCI support only provided the=
 RAW CXL<br>
&gt; &gt; command IOCTL interface that is already available for Type 3 memo=
ry<br>
&gt; &gt; devices.<br>
&gt; &gt; That allows for unfettered control of the switch but, because it =
is<br>
&gt; &gt; extremely easy to shoot yourself in the foot and cause unsolvable=
 bug<br>
&gt; &gt; reports,<br>
&gt; &gt; it taints the kernel. There have been several requests to provide=
 this<br>
&gt; &gt; interface<br>
&gt; &gt; without the taint for these switch configuration mailboxes.<br>
&gt; &gt;<br>
&gt; &gt; Last posted series:<br>
&gt; &gt;<br>
&gt; &gt; <a href=3D"https://lore.kernel.org/all/20231016125323.18318-1-Jon=
athan.Cameron@huawei.com/" rel=3D"noreferrer" target=3D"_blank">https://lor=
e.kernel.org/all/20231016125323.18318-1-Jonathan.Cameron@huawei.com/</a><br=
>
&gt; &gt; Note there are unrelated reasons why that code hasn&#39;t been up=
dated since<br>
&gt; &gt; v6.6 time,<br>
&gt; &gt; but I am planning to get back to it shortly.<br>
&gt; &gt;<br>
&gt; &gt; Similar issues will occur for other uses of PCIe MMPT (new mailbo=
x in PCI<br>
&gt; &gt; that<br>
&gt; &gt; sometimes is used for similarly destructive activity such as PLDM=
 based<br>
&gt; &gt; firmware update).<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; On to the proposed rules:<br>
&gt; &gt;<br>
&gt; &gt; 1) Kernel space use of the various mailboxes, or filtered control=
s from<br>
&gt; &gt; user space.<br>
&gt; &gt;<br>
&gt; &gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; &gt;<br>
&gt; &gt; Absolutely fine - no one worries about this, but the mediated tra=
ffic will<br>
&gt; &gt; be filtered for potentially destructive side effects. E.g. it wil=
l reject<br>
&gt; &gt; attempts to change anything routing related if the kernel either =
knows a<br>
&gt; &gt; host is<br>
&gt; &gt; using memory that will be blown away, or has no way to know (so a=
ffecting<br>
&gt; &gt; routing to another host).=C2=A0 This includes blocking &#39;all&#=
39; vendor defined<br>
&gt; &gt; messages as we have no idea what the do.=C2=A0 Note this means th=
e kernel has<br>
&gt; &gt; an allow list and new commands are not initially allowed.<br>
&gt; &gt;<br>
&gt; &gt; This isn&#39;t currently enabled for Switch CCIs because they are=
 only really<br>
&gt; &gt; interesting if the potentially destructive stuff is available (an=
 earlier<br>
&gt; &gt; version did enable query commands, but it wasn&#39;t particularly=
 useful to<br>
&gt; &gt; know what your switch could do but not be allowed to do any of it=
).<br>
&gt; &gt; If you take a MMPT usecase of PLDM firmware update, the filtering=
 would<br>
&gt; &gt; check that the device was in a state where a firmware update won&=
#39;t rip<br>
&gt; &gt; memory out from under a host, which would be messy if that host i=
s<br>
&gt; &gt; doing the update.<br>
&gt; &gt;<br>
&gt; &gt; 2) Unfiltered userspace use of mailbox for Fabric Management - BM=
C kernels<br>
&gt; &gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br>
&gt; &gt;<br>
&gt; &gt; (This would just be a kernel option that we&#39;d advise normal s=
erver<br>
&gt; &gt; distributions not to turn on. Would be enabled by openBMC etc)<br=
>
&gt; &gt;<br>
&gt; &gt; This is fine - there is some work to do, but the switch-cci PCI d=
river<br>
&gt; &gt; will hopefully be ready for upstream merge soon. There is no filt=
ering of<br>
&gt; &gt; accesses. Think of this as similar to all the damage you can do v=
ia<br>
&gt; &gt; MCTP from a BMC. Similarly it is likely that much of the complexi=
ty<br>
&gt; &gt; of the actual commands will be left to user space tooling:<br>
&gt; &gt; <a href=3D"https://gitlab.com/jic23/cxl-fmapi-tests" rel=3D"noref=
errer" target=3D"_blank">https://gitlab.com/jic23/cxl-fmapi-tests</a> has s=
ome test examples.<br>
&gt; &gt;<br>
&gt; &gt; Whether Kconfig help text is strong enough to ensure this only ge=
ts<br>
&gt; &gt; enabled for BMC targeted distros is an open question we can addre=
ss<br>
&gt; &gt; alongside an updated patch set.<br>
&gt; &gt;<br>
&gt; &gt; (On to the one that the &quot;debate&quot; is about)<br>
&gt; &gt;<br>
&gt; &gt; 3) Unfiltered user space use of mailbox for Fabric Management - D=
istro<br>
&gt; &gt; kernels<br>
&gt; &gt;<br>
&gt; &gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<br>
&gt; &gt; (General purpose Linux Server Distro (Redhat, Suse etc))<br>
&gt; &gt;<br>
&gt; &gt; This is equivalent of RAW command support on CXL Type 3 memory de=
vices.<br>
&gt; &gt; You can enable those in a distro kernel build despite the scary c=
onfig<br>
&gt; &gt; help text, but if you use it the kernel is tainted. The result<br=
>
&gt; &gt; of the taint is to add a flag to bug reports and print a big mess=
age to say<br>
&gt; &gt; that you&#39;ve used a feature that might result in you shooting =
yourself<br>
&gt; &gt; in the foot.<br>
&gt; &gt;<br>
&gt; &gt; The taint is there because software is not at first written to de=
al with<br>
&gt; &gt; everything that can happen smoothly (e.g. surprise removal) It&#3=
9;s hard<br>
&gt; &gt; to survive some of these events, so is never on the initial featu=
re list<br>
&gt; &gt; for any bus, so this flag is just to indicate we have entered a w=
orld<br>
&gt; &gt; where almost all bets are off wrt to stability.=C2=A0 We might no=
t know what<br>
&gt; &gt; a command does so we can&#39;t assess the impact (and no one trus=
ts vendor<br>
&gt; &gt; commands to report affects right in the Command Effects Log - whi=
ch<br>
&gt; &gt; in theory tells you if a command can result problems).<br>
&gt; &gt;<br>
&gt; &gt; A concern was raised about GAE/FAST/LDST tables for CXL Fabrics<b=
r>
&gt; &gt; (a r3.1 feature) but, as I understand it, these are intended for =
a<br>
&gt; &gt; host to configure and should not have side effects on other hosts=
?<br>
&gt; &gt; My working assumption is that the kernel driver stack will handle=
<br>
&gt; &gt; these (once we catch up with the current feature backlog!) Curren=
tly<br>
&gt; &gt; we have no visibility of what the OS driver stack for a fabrics w=
ill<br>
&gt; &gt; actually look like - the spec is just the starting point for that=
<br>
&gt; &gt; (patches welcome ;)<br>
&gt; &gt;<br>
&gt; &gt; The various CXL upstream developers and maintainers may have<br>
&gt; &gt; differing views of course, but my current understanding is we wan=
t<br>
&gt; &gt; to support 1 and 2, but are very resistant to 3!<br>
&gt; &gt;<br>
&gt; &gt; General Notes<br>
&gt; &gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; &gt;<br>
&gt; &gt; One side aspect of why we really don&#39;t like unfiltered usersp=
ace access to<br>
&gt; &gt; any<br>
&gt; &gt; of these devices is that people start building non standard hacks=
 in and we<br>
&gt; &gt; lose the ecosystem advantages. Forcing a considered discussion + =
patches<br>
&gt; &gt; to let a particular command be supported, drives standardization.=
<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; <a href=3D"https://lore.kernel.org/linux-cxl/CAPcyv4gDShAYih5iWab=
Kg_eTHhuHm54vEAei8ZkcmHnPp3B0cw@mail.gmail.com/" rel=3D"noreferrer" target=
=3D"_blank">https://lore.kernel.org/linux-cxl/CAPcyv4gDShAYih5iWabKg_eTHhuH=
m54vEAei8ZkcmHnPp3B0cw@mail.gmail.com/</a><br>
&gt; &gt; provides some history on vendor specific extensions and why in ge=
neral we<br>
&gt; &gt; won&#39;t support them upstream.<br>
&gt; &gt;<br>
&gt; &gt; To address another question raised in an earlier discussion:<br>
&gt; &gt; Putting these Fabric Management interfaces behind guard rails of =
some type<br>
&gt; &gt; (e.g. CONFIG_IM_A_BMC_AND_CAN_MAKE_A_MESS) does not encourage the=
 risk<br>
&gt; &gt; of non standard interfaces, because we will be even less likely t=
o accept<br>
&gt; &gt; those upstream!<br>
&gt; &gt;<br>
&gt; &gt; If anyone needs more details on any aspect of this please ask.<br=
>
&gt; &gt; There are a lot of things involved and I&#39;ve only tried to giv=
e a fairly<br>
&gt; &gt; minimal illustration to drive the discussion. I may well have mis=
sed<br>
&gt; &gt; something crucial.<br>
&gt; &gt;<br>
&gt; &gt; Jonathan<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 <br>
&gt; <br>
<br>
</blockquote></div></div>

<br>
<span style=3D"background-color:rgb(255,255,255)"><font size=3D"2">This ele=
ctronic communication and the information and any files transmitted with it=
, or attached to it, are confidential and are intended solely for the use o=
f the individual or entity to whom it is addressed and may contain informat=
ion that is confidential, legally privileged, protected by privacy laws, or=
 otherwise restricted from disclosure to anyone else. If you are not the in=
tended recipient or the person responsible for delivering the e-mail to the=
 intended recipient, you are hereby notified that any use, copying, distrib=
uting, dissemination, forwarding, printing, or copying of this e-mail is st=
rictly prohibited. If you received this e-mail in error, please return the =
e-mail to the sender, delete it from your computer, and destroy any printed=
 copy of it.</font></span>
--0000000000008364af06143fc053--

--00000000000098f19106143fc0a9
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBWEwggRJoAMCAQICDFYaRLSTNnawblU3yzANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwOTI0MjNaFw0yNTA5MTAwOTI0MjNaMIGc
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xHDAaBgNVBAMTE1NyZWVuaXZhcyBCYWdhbGtvdGUxLzAtBgkq
hkiG9w0BCQEWIHNyZWVuaXZhcy5iYWdhbGtvdGVAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAuuAqYt2XMpXqqYrSYVv64PlRiKuXJ1Hesi3rmZm4+g8EIZRtyETO
RWiFc6q59aDOqgjp94efpIVthPgLGM5Uv2iBj+XGsZzaiJn4ZasS5UNh0N6Rpj6dLHXBwRGaQsld
e5WvrXWFBwSZWVNj241paUqCIV+ybg8DS6/tCwEetzOgmjs4LgYlpj957G5EryaCzH5ncDrHz2Kj
q98WQ9dndZnpUpaPV2hP60IVspaStey0I6WjPBy7qNhbZV4J4ZN71tnZ7CrNkXy5KhwKEs+MiegU
OQvZ9yJQdMq9Ry3cO3DNfLXNGHuM2IKh6YPPScUnfGbmK/wkpXthxhJx+kn1IQIDAQABo4IB4TCC
Ad0wDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAu
Y3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29u
YWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0
cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBA
MD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2Ey
MDIwLmNybDArBgNVHREEJDAigSBzcmVlbml2YXMuYmFnYWxrb3RlQGJyb2FkY29tLmNvbTATBgNV
HSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4E
FgQU08YdPZld7W8H+uK8S2EPeYqBn20wDQYJKoZIhvcNAQELBQADggEBAGUBviL4v9e/8GOQBEZO
mm5a/OZCkJ6COPgkQ4TEHxWWx7iYG+TVkJ2qxNS1fXQUPnAC/TBfb37wLVynlBBRTb4PYzKIfaHW
bH9AscUsus4kEUyzYSLHYqQilComzpGFxor1x2fbLYpHMCU950wueyUHPHA3jwpWrluCE7283dWT
rz/VNFx2cjW+y8+T+lVxO44XmrQoa8lnz3fb+QCVvRyH8sUqAYjfkscFkknlkF0NobKXFSKwK1zZ
4ZQOk9tT7FYGWvy0nhOEUt/uKZNncumowkhquxqJve0HiOF6Z6R0eKybmGDGaWDYE11aHV62bKTn
/SH9BOZuA2GG8ZiNR08xggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9i
YWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBD
QSAyMDIwAgxWGkS0kzZ2sG5VN8swDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIHbl
cMRtYX4CMRt4q7xHqEziqCH3lY7kqJL1pdqB3+K6MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI0MDMyMjEzMjUwN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJ
KoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBgh3E5vbHZC0Z3vWwzQyBK
VwV7RKvpeaujROgiktTbmNOmRP/xgTIMW7rv5Y9rBTQoPd0rCcImX2ODMZ30NvO7mlb+5DAciT35
LWFz2Ofwif7EAlED6Am8Uxwbkqs6AunKrrOeTTdFNMdjr/r8OogEg3MEo3QG797jxTlThVhPv8JD
iFc1h3/dWGxiDYbRVxQym+S+hPyWPk1lO23VNz46Hah4xnfHDgvkFe/JvMytMEcJ/tiGxGQMqtgK
N1iy0sz7YHkBIr2LV3tJtWDJJRxuGYLJKQc1eoYqMpmR7KNCQxCQHWbzIyEBARAIaCvmZ6RXPF/t
HoQmGBnGtpf6pIgG
--00000000000098f19106143fc0a9--

