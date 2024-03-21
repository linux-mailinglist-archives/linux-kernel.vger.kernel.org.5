Return-Path: <linux-kernel+bounces-110700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D33978862A4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 484C51F222A2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4504E13664E;
	Thu, 21 Mar 2024 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fQtMnrmL"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B85288AE
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 21:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711057292; cv=none; b=pnPBHgSjnH95Df9PtG0Lw6bi0QXcASF8BUmwczqpSm6T4iT2dz8IOhmXw6TynkkVtTsXPk798BLIfTUuWkr5w5jpObmrn8pyuyKxTqs55fABeGfUeLtX7tNGnVMFswWQrLIc8J6z3oWiSqk2NTbPU6Hwf1ZuCg8xr6VFTRaJSyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711057292; c=relaxed/simple;
	bh=RFPVULlgp2lmyoKBFVRvjEpvE9pUOxElol2sdYl+FBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uuMbIZrVMkmXEWzO0JjTd6/ZUr05HXJjhtOtPCGXrajVy6og1u9rvd4i9mvykLSk84I04hucLQF2S/nfSAxEt2mjSYYoyfUudu382SXp7IjFSLOlTaz0V6NbuyHmVrTONqIkcs26Pwq5eEgtCfywJldP+M2izwHM6vFTb5yAQ+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fQtMnrmL; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcc84ae94c1so1441641276.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 14:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1711057288; x=1711662088; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vCRirzAmvVuzPvi7VVuEnabfWwIxJ9T0PWI9n9EGXxw=;
        b=fQtMnrmL4hAPLaaky20waxC4J/R4+d/xcu1YAMWq4ilkhws8FfuC28IBT1YqtwOeaz
         5P8dRhFDnvNbRra32cTfh4fkfw099O3+430pXDxqwXnDGFs24ZfgQH0crMH/oeuY1B/0
         r0AGTlEXfiYHIuPMDm4pfE6qTTNisyEuzq/FI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711057288; x=1711662088;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vCRirzAmvVuzPvi7VVuEnabfWwIxJ9T0PWI9n9EGXxw=;
        b=dmZKYmVOg0WItc/3u8nitK0qid2kSgSF8Gwhi6BfRGUsPNAWWr9A8Na3f8nxK/Jqo2
         hibuN2B6utat/OY5LqbPLt3pjqb6tlC2VvEFrAv1QnPvAF76iluXPSzHQHKcoVdRvMlI
         CRcyMMqpfaAKhuI4EvVlZTHyAe9AaE+hiQa0ly/LE6j1wj5C0ZpY7ytaLKlwVjmcEgi7
         IIUVi+dR1vtRYA6ErmIWLoguI1tmXt+0DcTYl/jy4+3y4htyvTP9k0sVyNwjXZkf5/l5
         ssAgY1Boz0tX9ZrJXqZrpkOtM+4UE40QoBwwTDbL0SkgPv0kI5ai4T6m2flpqO72HCx3
         9e3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXD55QU5oXWhi5TbpL2kXiTN4Oosg+D6vECEldXG3uHzNSEq9we24bmGcA4l8ZFOHZFrWOz4W12YNQ5mKtukyRT4uTTPi7wvKXchXnA
X-Gm-Message-State: AOJu0Yxsdqxpr6wIkbJWJjxz0w7VuJsU406HgbazBlRPLtGfAallMEdl
	KwWT1USbX/VX4GBt4HVv0Jkau02ssN2z9LHArjpnu0KCAFmmlDBpLZOgZfEOl5r2Q7SOAcXgMaI
	tWVTQ+z9BzpnMPwcEjfrekPcKv2vO4cC8bOULQfrRcBUAAmchBcaBYqav5Tc4pRp2s59xo0UeNH
	bOzHkIfkY8gQhUIj2L8f1qVU/p2Q==
X-Google-Smtp-Source: AGHT+IGKbow+5glhDPKybUVOTmGb01Bq5y0jEez8RCV+OLARwodzlCayQO8T3hkzhModdpWlMRheYPizH6F5nmZ4h3U=
X-Received: by 2002:a05:6902:1b13:b0:dcc:273e:1613 with SMTP id
 eh19-20020a0569021b1300b00dcc273e1613mr466188ybb.40.1711057287097; Thu, 21
 Mar 2024 14:41:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321174423.00007e0d@Huawei.com>
In-Reply-To: <20240321174423.00007e0d@Huawei.com>
From: Sreenivas Bagalkote <sreenivas.bagalkote@broadcom.com>
Date: Thu, 21 Mar 2024 14:41:00 -0700
Message-ID: <CACX_a4VPV16OFNZLCVUJrGFR5brcdiYN3aAgrxtO8ksUdNdkQQ@mail.gmail.com>
Subject: Re: RFC: Restricting userspace interfaces for CXL fabric management
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, Brett Henning <brett.henning@broadcom.com>, 
	Harold Johnson <harold.johnson@broadcom.com>, 
	Sumanesh Samanta <sumanesh.samanta@broadcom.com>, 
	"Williams, Dan J" <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, 
	Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, linuxarm@huawei.com, linux-api@vger.kernel.org, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, "Natu, Mahesh" <mahesh.natu@intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e5539d061432919b"

--000000000000e5539d061432919b
Content-Type: multipart/alternative; boundary="000000000000ca276e061432914e"

--000000000000ca276e061432914e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for kicking off this discussion, Jonathan.

We need guidance from the community.

1. Datacenter customers must be able to manage PCIe switches in-band.
2. Management of switches includes getting health, performance, and error
telemetry.
3. These telemetry functions are not yet part of the CXL standard
4. We built the CCI mailboxes into our PCIe switches per CXL spec and
developed our management scheme around them.

If the Linux community does not allow a CXL spec-compliant switch to be
managed via the CXL spec-defined CCI mailbox, then please guide us on
the right approach. Please tell us how you propose we manage our switches
in-band.

Thank you
Sreeni

On Thu, Mar 21, 2024 at 10:44=E2=80=AFAM Jonathan Cameron <
Jonathan.Cameron@huawei.com> wrote:

> Hi All,
>
> This is has come up in a number of discussions both on list and in privat=
e,
> so I wanted to lay out a potential set of rules when deciding whether or
> not
> to provide a user space interface for a particular feature of CXL Fabric
> Management.  The intent is to drive discussion, not to simply tell people
> a set of rules.  I've brought this to the public lists as it's a Linux
> kernel
> policy discussion, not a standards one.
>
> Whilst I'm writing the RFC this my attempt to summarize a possible
> position rather than necessarily being my personal view.
>
> It's a straw man - shoot at it!
>
> Not everyone in this discussion is familiar with relevant kernel or CXL
> concepts
> so I've provided more info than I normally would.
>
> First some background:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> CXL has two different types of Fabric. The comments here refer to both, b=
ut
> for now the kernel stack is focused on the simpler VCS fabric, not the mo=
re
> recent Port Based Routing (PBR) Fabrics. A typical example for 2 hosts
> connected to a common switch looks something like:
>
>  ________________               _______________
> |                |             |               |    Hosts - each sees
> |    HOST A      |             |     HOST B    |    a PCIe style tree
> |                |             |               |    but from a fabric
> config
> |   |Root Port|  |             |   |Root Port| |    point of view it's mo=
re
>  -------|--------               -------|-------     complex.
>         |                              |
>         |                              |
>  _______|______________________________|________
> |      USP (SW-CCI)                   USP       | Switch can have lots of
> |       |                              |        | Upstream Ports. Each on=
e
> |   ____|________               _______|______  | has a virtual hierarchy=
.
> |  |             |              |             | |
> | vPPB          vPPB          vPPB          vPPB| There are virtual
> |  x             |             |              | | "downstream
> ports."(vPPBs)
> |                \            /              /  | That can be bound to re=
al
> |                 \          /              /   | downstream ports.
> |                  \        /              /    |
> |                   \      /              /     | Multi Logical Devices a=
re
> |      DSP0           DSP1             DSP 2    | support more than one
> vPPB
> ------------------------------------------------  bound to a single
> physical
>          |             |                 |        DSP (transactions are
> tagged
>          |             |                 |        with an LD-ID)
>         SLD0           MLD0              SLD1
>
> Some typical fabric management activities:
> 1) Bind/Unbind vPPB to physical DSP (Results in hotplug / unplug events)
> 2) Access config space or BAR space of End Points below the switch.
> 3) Tunneling messages through to devices downstream (e.g Dynamic Capacity
>    Forced Remove that will blow away some memory even if a host is using
> it).
> 4) Non destructive stuff like status read back.
>
> Given the hosts may be using the Type 3 hosted memory (either Single
> Logical
> Device - SLD, or an LD on a Multi logical Device - MLD) as normal memory,
> unbinding a device in use can result in the memory access from a
> different host being removed. The 'blast radius' is perhaps a rack of
> servers.  This discussion applies equally to FM-API commands sent to Mult=
i
> Head Devices (see CXL r3.1).
>
> The Fabric Management actions are done using the CXL spec defined Fabric
> Management API, (FM-API) which is transported over various means includin=
g
> OoB MCTP over your favourite transport (I2C, PCIe-VDM...) or via normal
> PCIe read/write to a Switch-CCI.  A Switch-CCI is mailbox in PCI BAR
> space on a function found alongside one of the switch upstream ports;
> this mailbox is very similar to the MMPT definition found in PCIe r6.2.
>
> In many cases this switch CCI / MCTP connection is used by a BMC rather
> than a normal host, but there have been some questions raised about wheth=
er
> a general purpose server OS would have a valid reason to use this interfa=
ce
> (beyond debug and testing) to configure the switch or an MHD.
>
> If people have a use case for this, please reply to this thread to give
> more details.
>
> The most recently posted CXL Switch-CCI support only provided the RAW CXL
> command IOCTL interface that is already available for Type 3 memory
> devices.
> That allows for unfettered control of the switch but, because it is
> extremely easy to shoot yourself in the foot and cause unsolvable bug
> reports,
> it taints the kernel. There have been several requests to provide this
> interface
> without the taint for these switch configuration mailboxes.
>
> Last posted series:
>
> https://lore.kernel.org/all/20231016125323.18318-1-Jonathan.Cameron@huawe=
i.com/
> Note there are unrelated reasons why that code hasn't been updated since
> v6.6 time,
> but I am planning to get back to it shortly.
>
> Similar issues will occur for other uses of PCIe MMPT (new mailbox in PCI
> that
> sometimes is used for similarly destructive activity such as PLDM based
> firmware update).
>
>
> On to the proposed rules:
>
> 1) Kernel space use of the various mailboxes, or filtered controls from
> user space.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>
> Absolutely fine - no one worries about this, but the mediated traffic wil=
l
> be filtered for potentially destructive side effects. E.g. it will reject
> attempts to change anything routing related if the kernel either knows a
> host is
> using memory that will be blown away, or has no way to know (so affecting
> routing to another host).  This includes blocking 'all' vendor defined
> messages as we have no idea what the do.  Note this means the kernel has
> an allow list and new commands are not initially allowed.
>
> This isn't currently enabled for Switch CCIs because they are only really
> interesting if the potentially destructive stuff is available (an earlier
> version did enable query commands, but it wasn't particularly useful to
> know what your switch could do but not be allowed to do any of it).
> If you take a MMPT usecase of PLDM firmware update, the filtering would
> check that the device was in a state where a firmware update won't rip
> memory out from under a host, which would be messy if that host is
> doing the update.
>
> 2) Unfiltered userspace use of mailbox for Fabric Management - BMC kernel=
s
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> (This would just be a kernel option that we'd advise normal server
> distributions not to turn on. Would be enabled by openBMC etc)
>
> This is fine - there is some work to do, but the switch-cci PCI driver
> will hopefully be ready for upstream merge soon. There is no filtering of
> accesses. Think of this as similar to all the damage you can do via
> MCTP from a BMC. Similarly it is likely that much of the complexity
> of the actual commands will be left to user space tooling:
> https://gitlab.com/jic23/cxl-fmapi-tests has some test examples.
>
> Whether Kconfig help text is strong enough to ensure this only gets
> enabled for BMC targeted distros is an open question we can address
> alongside an updated patch set.
>
> (On to the one that the "debate" is about)
>
> 3) Unfiltered user space use of mailbox for Fabric Management - Distro
> kernels
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> (General purpose Linux Server Distro (Redhat, Suse etc))
>
> This is equivalent of RAW command support on CXL Type 3 memory devices.
> You can enable those in a distro kernel build despite the scary config
> help text, but if you use it the kernel is tainted. The result
> of the taint is to add a flag to bug reports and print a big message to s=
ay
> that you've used a feature that might result in you shooting yourself
> in the foot.
>
> The taint is there because software is not at first written to deal with
> everything that can happen smoothly (e.g. surprise removal) It's hard
> to survive some of these events, so is never on the initial feature list
> for any bus, so this flag is just to indicate we have entered a world
> where almost all bets are off wrt to stability.  We might not know what
> a command does so we can't assess the impact (and no one trusts vendor
> commands to report affects right in the Command Effects Log - which
> in theory tells you if a command can result problems).
>
> A concern was raised about GAE/FAST/LDST tables for CXL Fabrics
> (a r3.1 feature) but, as I understand it, these are intended for a
> host to configure and should not have side effects on other hosts?
> My working assumption is that the kernel driver stack will handle
> these (once we catch up with the current feature backlog!) Currently
> we have no visibility of what the OS driver stack for a fabrics will
> actually look like - the spec is just the starting point for that.
> (patches welcome ;)
>
> The various CXL upstream developers and maintainers may have
> differing views of course, but my current understanding is we want
> to support 1 and 2, but are very resistant to 3!
>
> General Notes
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> One side aspect of why we really don't like unfiltered userspace access t=
o
> any
> of these devices is that people start building non standard hacks in and =
we
> lose the ecosystem advantages. Forcing a considered discussion + patches
> to let a particular command be supported, drives standardization.
>
>
> https://lore.kernel.org/linux-cxl/CAPcyv4gDShAYih5iWabKg_eTHhuHm54vEAei8Z=
kcmHnPp3B0cw@mail.gmail.com/
> provides some history on vendor specific extensions and why in general we
> won't support them upstream.
>
> To address another question raised in an earlier discussion:
> Putting these Fabric Management interfaces behind guard rails of some typ=
e
> (e.g. CONFIG_IM_A_BMC_AND_CAN_MAKE_A_MESS) does not encourage the risk
> of non standard interfaces, because we will be even less likely to accept
> those upstream!
>
> If anyone needs more details on any aspect of this please ask.
> There are a lot of things involved and I've only tried to give a fairly
> minimal illustration to drive the discussion. I may well have missed
> something crucial.
>
> Jonathan
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

--000000000000ca276e061432914e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-size:small"><fo=
nt face=3D"monospace">Thank you for kicking off this discussion, Jonathan.<=
/font></div><div class=3D"gmail_default" style=3D"font-size:small"><font fa=
ce=3D"monospace"><br></font></div><div class=3D"gmail_default" style=3D"fon=
t-size:small"><font face=3D"monospace">We need guidance=C2=A0from the commu=
nity.=C2=A0</font></div><div class=3D"gmail_default" style=3D"font-size:sma=
ll"><span style=3D"font-family:monospace">=C2=A0</span><br></div><div class=
=3D"gmail_default" style=3D"font-size:small"><font face=3D"monospace">1. Da=
tacenter customers must=C2=A0be able to manage PCIe switches in-band.</font=
></div><div class=3D"gmail_default" style=3D"font-size:small"><font face=3D=
"monospace">2. Management of switches includes getting health, performance,=
 and error telemetry.</font></div><div class=3D"gmail_default" style=3D"fon=
t-size:small"><font face=3D"monospace">3. These telemetry functions are not=
 yet part of the CXL standard</font></div><div class=3D"gmail_default" styl=
e=3D"font-size:small"><font face=3D"monospace">4. We built the CCI mailboxe=
s into our PCIe switches=C2=A0per CXL spec and developed our management sch=
eme around them.</font></div><div class=3D"gmail_default" style=3D"font-siz=
e:small"><font face=3D"monospace"><br></font></div><div class=3D"gmail_defa=
ult" style=3D"font-size:small"><font face=3D"monospace">If the Linux commun=
ity does not allow a CXL spec-compliant switch to be managed via the CXL sp=
ec-defined CCI mailbox, then please guide us on the=C2=A0right approach. Pl=
ease tell us how you propose we manage our switches in-band.</font></div><d=
iv class=3D"gmail_default" style=3D"font-size:small"><font face=3D"monospac=
e"><br></font></div><div class=3D"gmail_default" style=3D"font-size:small">=
<font face=3D"monospace">Thank you</font></div><div class=3D"gmail_default"=
 style=3D"font-size:small"><font face=3D"monospace">Sreeni</font></div></di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On T=
hu, Mar 21, 2024 at 10:44=E2=80=AFAM Jonathan Cameron &lt;<a href=3D"mailto=
:Jonathan.Cameron@huawei.com">Jonathan.Cameron@huawei.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi All,<br>
<br>
This is has come up in a number of discussions both on list and in private,=
<br>
so I wanted to lay out a potential set of rules when deciding whether or no=
t<br>
to provide a user space interface for a particular feature of CXL Fabric<br=
>
Management.=C2=A0 The intent is to drive discussion, not to simply tell peo=
ple<br>
a set of rules.=C2=A0 I&#39;ve brought this to the public lists as it&#39;s=
 a Linux kernel<br>
policy discussion, not a standards one.<br>
<br>
Whilst I&#39;m writing the RFC this my attempt to summarize a possible<br>
position rather than necessarily being my personal view.<br>
<br>
It&#39;s a straw man - shoot at it!<br>
<br>
Not everyone in this discussion is familiar with relevant kernel or CXL con=
cepts<br>
so I&#39;ve provided more info than I normally would.<br>
<br>
First some background:<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
CXL has two different types of Fabric. The comments here refer to both, but=
<br>
for now the kernel stack is focused on the simpler VCS fabric, not the more=
<br>
recent Port Based Routing (PBR) Fabrics. A typical example for 2 hosts<br>
connected to a common switch looks something like:<br>
<br>
=C2=A0________________=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0_______________<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A0 Hosts - each sees <br>
|=C2=A0 =C2=A0 HOST A=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0HOST B=C2=A0 =C2=A0 |=C2=A0 =C2=A0 a =
PCIe style tree<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A0 but from a fabric config<br>
|=C2=A0 =C2=A0|Root Port|=C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A0|Root Port| |=C2=A0 =C2=A0 point of view it&#39;s more<=
br>
=C2=A0-------|--------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0-------|-------=C2=A0 =C2=A0 =C2=A0complex.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>
=C2=A0_______|______________________________|________<br>
|=C2=A0 =C2=A0 =C2=A0 USP (SW-CCI)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0USP=C2=A0 =C2=A0 =C2=A0 =C2=A0| Switch can have=
 lots of<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | Upstream Ports. Each one<br>
|=C2=A0 =C2=A0____|________=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0_______|______=C2=A0 | has a virtual hierarchy.<br>
|=C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| |<br>
| vPPB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vPPB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 vPPB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vPPB| There are virtual<br>
|=C2=A0 x=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | | &quot;downstream ports.&quot;(vPPBs)<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 /=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
/=C2=A0 | That can be bound to real<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 /=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
/=C2=A0 =C2=A0| downstream ports.<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 /=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /=C2=A0=
 =C2=A0 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\=C2=
=A0 =C2=A0 =C2=A0 /=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /=C2=A0=
 =C2=A0 =C2=A0| Multi Logical Devices are<br>
|=C2=A0 =C2=A0 =C2=A0 DSP0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DSP1=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DSP 2=C2=A0 =C2=A0 | support m=
ore than one vPPB<br>
------------------------------------------------=C2=A0 bound to a single ph=
ysical<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DSP (transactions are tagged<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 with an LD-ID)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 SLD0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ML=
D0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SLD1<br>
<br>
Some typical fabric management activities:<br>
1) Bind/Unbind vPPB to physical DSP (Results in hotplug / unplug events)<br=
>
2) Access config space or BAR space of End Points below the switch.<br>
3) Tunneling messages through to devices downstream (e.g Dynamic Capacity<b=
r>
=C2=A0 =C2=A0Forced Remove that will blow away some memory even if a host i=
s using it).<br>
4) Non destructive stuff like status read back.<br>
<br>
Given the hosts may be using the Type 3 hosted memory (either Single Logica=
l<br>
Device - SLD, or an LD on a Multi logical Device - MLD) as normal memory,<b=
r>
unbinding a device in use can result in the memory access from a<br>
different host being removed. The &#39;blast radius&#39; is perhaps a rack =
of<br>
servers.=C2=A0 This discussion applies equally to FM-API commands sent to M=
ulti<br>
Head Devices (see CXL r3.1).<br>
<br>
The Fabric Management actions are done using the CXL spec defined Fabric<br=
>
Management API, (FM-API) which is transported over various means including<=
br>
OoB MCTP over your favourite transport (I2C, PCIe-VDM...) or via normal<br>
PCIe read/write to a Switch-CCI.=C2=A0 A Switch-CCI is mailbox in PCI BAR<b=
r>
space on a function found alongside one of the switch upstream ports;<br>
this mailbox is very similar to the MMPT definition found in PCIe r6.2.<br>
<br>
In many cases this switch CCI / MCTP connection is used by a BMC rather<br>
than a normal host, but there have been some questions raised about whether=
<br>
a general purpose server OS would have a valid reason to use this interface=
<br>
(beyond debug and testing) to configure the switch or an MHD.<br>
<br>
If people have a use case for this, please reply to this thread to give<br>
more details.<br>
<br>
The most recently posted CXL Switch-CCI support only provided the RAW CXL<b=
r>
command IOCTL interface that is already available for Type 3 memory devices=
<br>
That allows for unfettered control of the switch but, because it is<br>
extremely easy to shoot yourself in the foot and cause unsolvable bug repor=
ts,<br>
it taints the kernel. There have been several requests to provide this inte=
rface<br>
without the taint for these switch configuration mailboxes.<br>
<br>
Last posted series:<br>
<a href=3D"https://lore.kernel.org/all/20231016125323.18318-1-Jonathan.Came=
ron@huawei.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.o=
rg/all/20231016125323.18318-1-Jonathan.Cameron@huawei.com/</a><br>
Note there are unrelated reasons why that code hasn&#39;t been updated sinc=
e v6.6 time,<br>
but I am planning to get back to it shortly.<br>
<br>
Similar issues will occur for other uses of PCIe MMPT (new mailbox in PCI t=
hat<br>
sometimes is used for similarly destructive activity such as PLDM based<br>
firmware update).<br>
<br>
<br>
On to the proposed rules:<br>
<br>
1) Kernel space use of the various mailboxes, or filtered controls from use=
r space.<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D<br>
<br>
Absolutely fine - no one worries about this, but the mediated traffic will<=
br>
be filtered for potentially destructive side effects. E.g. it will reject<b=
r>
attempts to change anything routing related if the kernel either knows a ho=
st is<br>
using memory that will be blown away, or has no way to know (so affecting<b=
r>
routing to another host).=C2=A0 This includes blocking &#39;all&#39; vendor=
 defined<br>
messages as we have no idea what the do.=C2=A0 Note this means the kernel h=
as<br>
an allow list and new commands are not initially allowed.<br>
<br>
This isn&#39;t currently enabled for Switch CCIs because they are only real=
ly<br>
interesting if the potentially destructive stuff is available (an earlier<b=
r>
version did enable query commands, but it wasn&#39;t particularly useful to=
<br>
know what your switch could do but not be allowed to do any of it).<br>
If you take a MMPT usecase of PLDM firmware update, the filtering would<br>
check that the device was in a state where a firmware update won&#39;t rip<=
br>
memory out from under a host, which would be messy if that host is<br>
doing the update.<br>
<br>
2) Unfiltered userspace use of mailbox for Fabric Management - BMC kernels<=
br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br=
>
<br>
(This would just be a kernel option that we&#39;d advise normal server<br>
distributions not to turn on. Would be enabled by openBMC etc)<br>
<br>
This is fine - there is some work to do, but the switch-cci PCI driver<br>
will hopefully be ready for upstream merge soon. There is no filtering of<b=
r>
accesses. Think of this as similar to all the damage you can do via<br>
MCTP from a BMC. Similarly it is likely that much of the complexity<br>
of the actual commands will be left to user space tooling: <br>
<a href=3D"https://gitlab.com/jic23/cxl-fmapi-tests" rel=3D"noreferrer" tar=
get=3D"_blank">https://gitlab.com/jic23/cxl-fmapi-tests</a> has some test e=
xamples.<br>
<br>
Whether Kconfig help text is strong enough to ensure this only gets<br>
enabled for BMC targeted distros is an open question we can address<br>
alongside an updated patch set.<br>
<br>
(On to the one that the &quot;debate&quot; is about)<br>
<br>
3) Unfiltered user space use of mailbox for Fabric Management - Distro kern=
els<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D<br>
(General purpose Linux Server Distro (Redhat, Suse etc))<br>
<br>
This is equivalent of RAW command support on CXL Type 3 memory devices.<br>
You can enable those in a distro kernel build despite the scary config<br>
help text, but if you use it the kernel is tainted. The result<br>
of the taint is to add a flag to bug reports and print a big message to say=
<br>
that you&#39;ve used a feature that might result in you shooting yourself<b=
r>
in the foot.<br>
<br>
The taint is there because software is not at first written to deal with<br=
>
everything that can happen smoothly (e.g. surprise removal) It&#39;s hard<b=
r>
to survive some of these events, so is never on the initial feature list<br=
>
for any bus, so this flag is just to indicate we have entered a world<br>
where almost all bets are off wrt to stability.=C2=A0 We might not know wha=
t<br>
a command does so we can&#39;t assess the impact (and no one trusts vendor<=
br>
commands to report affects right in the Command Effects Log - which<br>
in theory tells you if a command can result problems).<br>
<br>
A concern was raised about GAE/FAST/LDST tables for CXL Fabrics<br>
(a r3.1 feature) but, as I understand it, these are intended for a<br>
host to configure and should not have side effects on other hosts?<br>
My working assumption is that the kernel driver stack will handle<br>
these (once we catch up with the current feature backlog!) Currently<br>
we have no visibility of what the OS driver stack for a fabrics will<br>
actually look like - the spec is just the starting point for that.<br>
(patches welcome ;)<br>
<br>
The various CXL upstream developers and maintainers may have<br>
differing views of course, but my current understanding is we want<br>
to support 1 and 2, but are very resistant to 3!<br>
<br>
General Notes<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
One side aspect of why we really don&#39;t like unfiltered userspace access=
 to any<br>
of these devices is that people start building non standard hacks in and we=
<br>
lose the ecosystem advantages. Forcing a considered discussion + patches<br=
>
to let a particular command be supported, drives standardization.<br>
<br>
<a href=3D"https://lore.kernel.org/linux-cxl/CAPcyv4gDShAYih5iWabKg_eTHhuHm=
54vEAei8ZkcmHnPp3B0cw@mail.gmail.com/" rel=3D"noreferrer" target=3D"_blank"=
>https://lore.kernel.org/linux-cxl/CAPcyv4gDShAYih5iWabKg_eTHhuHm54vEAei8Zk=
cmHnPp3B0cw@mail.gmail.com/</a><br>
provides some history on vendor specific extensions and why in general we<b=
r>
won&#39;t support them upstream.<br>
<br>
To address another question raised in an earlier discussion:<br>
Putting these Fabric Management interfaces behind guard rails of some type<=
br>
(e.g. CONFIG_IM_A_BMC_AND_CAN_MAKE_A_MESS) does not encourage the risk<br>
of non standard interfaces, because we will be even less likely to accept<b=
r>
those upstream!<br>
<br>
If anyone needs more details on any aspect of this please ask.<br>
There are a lot of things involved and I&#39;ve only tried to give a fairly=
<br>
minimal illustration to drive the discussion. I may well have missed<br>
something crucial.<br>
<br>
Jonathan<br>
<br>
</blockquote></div>

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
--000000000000ca276e061432914e--

--000000000000e5539d061432919b
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
QSAyMDIwAgxWGkS0kzZ2sG5VN8swDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPv8
GxpGASfRfizZu9ZkHIRoDgtI25Jke1kBSFAw7MVVMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI0MDMyMTIxNDEyOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJ
KoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBM5jhtYsDHoCjOh3JJzOMZ
ZXa8xKPG3kks2dapRSuxZqZRBQREXQActXkUwgkohWYUpzM3xX3YVV6sm8IcScrmVRWCLU9nI2kW
lE/MEBzpML7lmyXSSCb7C7pZqfLzwsYEzGK5NZWGOzmhHSjIggR2s7a3zG1lBkqOPfqsbg3c5BUs
aI2Kvv17DM6OXJsrpbrhCflPfdSVbUOQsxBvGvEhr/af9MvYfuAEGaOz8kXvGvF5WKjCFv6X2+nU
FZxQWRmx96FYcnIcGPCNAS4jypw1lkNfOQmItgTTpMB/Oz2bHmX5bEQ4HL0Ii4TxuZo0RQQHC2yJ
dr5CHUZW7zlFB8zG
--000000000000e5539d061432919b--

