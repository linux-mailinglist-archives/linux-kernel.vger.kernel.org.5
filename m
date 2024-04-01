Return-Path: <linux-kernel+bounces-126876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5D5894268
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22A028362E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED1D4CB47;
	Mon,  1 Apr 2024 16:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KEhXl3pc"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433834B5AE
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 16:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990325; cv=none; b=exP2vTViKfd3rpAQkoUPKXxKUglssAxLPdtchq9jF7098IPn1kv6ytlH/swPgwJ0f/1hzaF0C/TgxnF1Q7N2Yj1bcxYwkS9NziUmUSsLgNBD6ZkggIsF6M5IRtn8EgATwyguKrXcsIASmB6T9xA334e7rR//38QSgZn35+yz2jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990325; c=relaxed/simple;
	bh=lVehNpSeLR7nK73M0ynbo/3Ee4MgIGVXX8XscRozPAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ssS8pA3nE3+vxkzmjwn+JIkeNk/gdsI1MrIZYI6P145iEqBLm8rjx9AO30uoXAdrPkSyep91+9egi3qTyj5w4e1+pIfpQhSvMNaX9I7wSR3BIx4ohgOJ+WtLXuhxBD1ycutjN4yHojET74vL3LGbA9RxrOoVU19ivaL+rTF/aQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KEhXl3pc; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dd14d8e7026so3329261276.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 09:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1711990321; x=1712595121; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0vn8l7B5ZgKhV6ixzXWo+GPE95h3QfSy6vN9+KEuTDc=;
        b=KEhXl3pcFa6OVmSifJ5vCYsk+YPerLf2CNKT8YtdugomL4tizEQLhBX+1/rO8h0KyW
         fPLdej8KW5Bb1yVS6gbYPvOLQT8qT47HqwJ0WLChnms0P1HwSO1vKaGXQORi+slztipp
         Le6v9qyc3hZ1d7gpbffvxVnuE2HARqPo3KHXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711990321; x=1712595121;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0vn8l7B5ZgKhV6ixzXWo+GPE95h3QfSy6vN9+KEuTDc=;
        b=ROApZcYoPqfFsdh38aRKn0YuZgtYiFnUs1Fu4ftV7xdspo9cHCOL9judA3ji3ZhmQm
         dtXG/a5aD1SCveWRv3ZifCQ2MwzlW9o4QpZg351APsTv8o5+qCJQbiCPaOIqaFSQuy3g
         mCvrhRoDR8rRj9Ao5gqIMFqw7Y/M3wL9wmSyjx1rTXksaWH5TNlQr38knsAjpJxf4rju
         mowk1oYkQoN1M23p7fb6SCnN35+Ts5EvI/zAJuokPn4kMIxMqEvrH0tkQ9WB2kbkn/Gr
         pzs0n4IVW7RbVfAAo7ttXZm+dr9MioifgjOnb7YYyOIIPZYWehTiEHM3QimXc2gs5DD2
         6aeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQuBVmHNYz1EJHAwuKCiDbL0lrHOnTG4ARJcAtkyqfWf+tIFj6ToDS6ElRpo14dKXADYT74Q3O/8TO9ewkMI1uy6AcevQjtPZTE7/R
X-Gm-Message-State: AOJu0YwKNdGTi9KzvH1gU8AYtQ1a2ySPNZyMV4lGI1ed/G156oFqMA22
	GBYv6JtHcFrvp4g0OiPQhsSeE0FXwczsnByjpP5gqZekr/B/OC/X3IH8sccJZ8l4nU87qAGxnlf
	sEs/RbXzwcSs5b6Cn3eXl0ZY2iICK/78Y2IjYaVzn84I8yRg98vsfDF3AMUiXyW1RGUmgCljvOZ
	V4wzGivI3OgIk5PL8jAwrOAWFZZQ==
X-Google-Smtp-Source: AGHT+IHxZoMMTf0CJlOChOVk3+adBAtB4RH/OT1cfVCs9uys6jaS+G6LCbGSaOlY43vnWEYaV4r9RH7Itrr1G0OYDzY=
X-Received: by 2002:a25:8452:0:b0:dcd:26a8:7f84 with SMTP id
 r18-20020a258452000000b00dcd26a87f84mr7871713ybm.47.1711990320736; Mon, 01
 Apr 2024 09:52:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321174423.00007e0d@Huawei.com> <CACX_a4VPV16OFNZLCVUJrGFR5brcdiYN3aAgrxtO8ksUdNdkQQ@mail.gmail.com>
 <20240322093212.00003173@Huawei.com> <CACX_a4U_==8pVqrqyrKeUhMuvvcP53g4irkwauFK3Edxbxp9NA@mail.gmail.com>
In-Reply-To: <CACX_a4U_==8pVqrqyrKeUhMuvvcP53g4irkwauFK3Edxbxp9NA@mail.gmail.com>
From: Sreenivas Bagalkote <sreenivas.bagalkote@broadcom.com>
Date: Mon, 1 Apr 2024 22:21:32 +0530
Message-ID: <CACX_a4VKxns-s5c=XaKo3TJzjCUv09jARYwb+PL_OntQJ4aEbA@mail.gmail.com>
Subject: Re: RFC: Restricting userspace interfaces for CXL fabric management
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	"Williams, Dan J" <dan.j.williams@intel.com>, "Natu, Mahesh" <mahesh.natu@intel.com>
Cc: linux-cxl@vger.kernel.org, Brett Henning <brett.henning@broadcom.com>, 
	Harold Johnson <harold.johnson@broadcom.com>, 
	Sumanesh Samanta <sumanesh.samanta@broadcom.com>, linux-kernel@vger.kernel.org, 
	Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, linuxarm@huawei.com, linux-api@vger.kernel.org, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Ariel.Sibley@microchip.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f89fec06150bce7e"

--000000000000f89fec06150bce7e
Content-Type: multipart/alternative; boundary="000000000000ed55b106150bce15"

--000000000000ed55b106150bce15
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Dan, Jonathan -

> >
> > 'Maybe' if you were to publish a specification for those particular
> > vendor defined commands, it might be fine to add them to the allow list
> > for the switch-cci.
> >
>
> Your proposal sounds reasonable. I will let you all experts figure out
how to support the vendor-defined commands. CXL spec has them for a reason
and they need to be supported.

Please confirm that you will support an "allow list" of the vendor-defined
commands. We will publish it once you confirm.

Thank you
Sreeni
Sreenivas Bagalkote <Sreenivas.Bagalkote@broadcom.com>
Product Planning & Management
Broadcom Datacenter Solutions Group

On Fri, Mar 22, 2024 at 6:54=E2=80=AFPM Sreenivas Bagalkote <
sreenivas.bagalkote@broadcom.com> wrote:

> Jonathan,
>
> >
> > What is the use case? My understanding so far is that clouds and
> > similar sometimes use an in band path but it would be from a management
> > only host, not a general purpose host running other software
> >
>
> The overwhelming majority of the PCIe switches get deployed in a single
> server. Typically four to eight switches are connected to two or more roo=
t
> complexes in one or two CPUs. The deployment scenario you have in mind -
> multiple physical hosts running general workloads and a management-only
> host - exists. But it is insignificant.
>
> >
> > For telemetry(subject to any odd corners like commands that might lock
> > the interface up for a long time, which we've seen with commands in the
> > Spec!) I don't see any problem supporting those on all host software.
> > They should be non destructive to other hosts etc.
> >
>
> Thank you. As you do this, please keep in mind that your concern about no=
t
> affecting "other" hosts is theoretically valid but doesn't exist in the
> real world beyond science experiments. If there are real-world deployment=
s,
> they are insignificant. I urge you all to make your stuff work with 99.99=
%
> of the deployments.
>
> >
> > 'Maybe' if you were to publish a specification for those particular
> > vendor defined commands, it might be fine to add them to the allow list
> > for the switch-cci.
> >
>
> Your proposal sounds reasonable. I will let you all experts figure out ho=
w
> to support the vendor-defined commands. CXL spec has them for a reason an=
d
> they need to be supported.
>
> Sreeni
>
> On Fri, Mar 22, 2024 at 2:32=E2=80=AFAM Jonathan Cameron <
> Jonathan.Cameron@huawei.com> wrote:
>
>> On Thu, 21 Mar 2024 14:41:00 -0700
>> Sreenivas Bagalkote <sreenivas.bagalkote@broadcom.com> wrote:
>>
>> > Thank you for kicking off this discussion, Jonathan.
>>
>> Hi Sreenivas,
>>
>> >
>> > We need guidance from the community.
>> >
>> > 1. Datacenter customers must be able to manage PCIe switches in-band.
>>
>> What is the use case? My understanding so far is that clouds and
>> similar sometimes use an in band path but it would be from a management
>> only host, not a general purpose host running other software. Sure
>> that control host just connects to a different upstream port so, from
>> a switch point of view, it's the same as any other host.  From a host
>> software point of view it's not running general cloud workloads or
>> (at least in most cases) a general purpose OS distribution.
>>
>> This is the key question behind this discussion.
>>
>> > 2. Management of switches includes getting health, performance, and
>> error
>> > telemetry.
>>
>> For telemetry(subject to any odd corners like commands that might lock
>> the interface up for a long time, which we've seen with commands in the
>> Spec!) I don't see any problem supporting those on all host software.
>> They should be non destructive to other hosts etc.
>>
>> > 3. These telemetry functions are not yet part of the CXL standard
>>
>> Ok, so this we should try to pin down the boundaries around this.
>> The thread linked below lays out the reasoning behind a general rule
>> of not accepting vendor defined commands, but perhaps there are routes
>> to answer some of those concerns.
>>
>> 'Maybe' if you were to publish a specification for those particular
>> vendor defined commands, it might be fine to add them to the allow list
>> for the switch-cci. Key here is that Broadcom would be committing to not
>> using those particular opcodes from the vendor space for anything else
>> in the future (so we could match on VID + opcode).  This is similar to
>> some DVSEC usage in PCIe (and why DVSEC is different from VSEC).
>>
>> Effectively you'd be publishing an additional specification building on
>> CXL.
>> Those are expected to surface anyway from various standards orgs - shoul=
d
>> we treat a company published one differently?  I don't see why.
>> Exactly how this would work might take some figuring out (in main code,
>> separate driver module etc?)
>>
>> That specification would be expected to provide a similar level of detai=
l
>> to CXL spec defined commands (ideally the less vague ones, but meh, up t=
o
>> you as long as any side effects are clearly documented!)
>>
>> Speaking for myself, I'd consider this approach.
>> Particularly true if I see clear effort in the standards org to push
>> these into future specifications as that shows broadcom are trying to
>> enhance the ecosystems.
>>
>>
>> > 4. We built the CCI mailboxes into our PCIe switches per CXL spec and
>> > developed our management scheme around them.
>> >
>> > If the Linux community does not allow a CXL spec-compliant switch to b=
e
>> > managed via the CXL spec-defined CCI mailbox, then please guide us on
>> > the right approach. Please tell us how you propose we manage our
>> switches
>> > in-band.
>>
>> The Linux community is fine supporting this in the kernel (the BMC or
>> Fabric Management only host case - option 2 below, so the code will be
>> there)
>> the question here is what advice we offer to the general purpose
>> distributions and what protections we need to put in place to mitigate t=
he
>> 'blast radius' concerns.
>>
>> Jonathan
>> >
>> > Thank you
>> > Sreeni
>> >
>> > On Thu, Mar 21, 2024 at 10:44=E2=80=AFAM Jonathan Cameron <
>> > Jonathan.Cameron@huawei.com> wrote:
>> >
>> > > Hi All,
>> > >
>> > > This is has come up in a number of discussions both on list and in
>> private,
>> > > so I wanted to lay out a potential set of rules when deciding whethe=
r
>> or
>> > > not
>> > > to provide a user space interface for a particular feature of CXL
>> Fabric
>> > > Management.  The intent is to drive discussion, not to simply tell
>> people
>> > > a set of rules.  I've brought this to the public lists as it's a Lin=
ux
>> > > kernel
>> > > policy discussion, not a standards one.
>> > >
>> > > Whilst I'm writing the RFC this my attempt to summarize a possible
>> > > position rather than necessarily being my personal view.
>> > >
>> > > It's a straw man - shoot at it!
>> > >
>> > > Not everyone in this discussion is familiar with relevant kernel or
>> CXL
>> > > concepts
>> > > so I've provided more info than I normally would.
>> > >
>> > > First some background:
>> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > >
>> > > CXL has two different types of Fabric. The comments here refer to
>> both, but
>> > > for now the kernel stack is focused on the simpler VCS fabric, not
>> the more
>> > > recent Port Based Routing (PBR) Fabrics. A typical example for 2 hos=
ts
>> > > connected to a common switch looks something like:
>> > >
>> > >  ________________               _______________
>> > > |                |             |               |    Hosts - each see=
s
>> > > |    HOST A      |             |     HOST B    |    a PCIe style tre=
e
>> > > |                |             |               |    but from a fabri=
c
>> > > config
>> > > |   |Root Port|  |             |   |Root Port| |    point of view
>> it's more
>> > >  -------|--------               -------|-------     complex.
>> > >         |                              |
>> > >         |                              |
>> > >  _______|______________________________|________
>> > > |      USP (SW-CCI)                   USP       | Switch can have
>> lots of
>> > > |       |                              |        | Upstream Ports.
>> Each one
>> > > |   ____|________               _______|______  | has a virtual
>> hierarchy.
>> > > |  |             |              |             | |
>> > > | vPPB          vPPB          vPPB          vPPB| There are virtual
>> > > |  x             |             |              | | "downstream
>> > > ports."(vPPBs)
>> > > |                \            /              /  | That can be bound
>> to real
>> > > |                 \          /              /   | downstream ports.
>> > > |                  \        /              /    |
>> > > |                   \      /              /     | Multi Logical
>> Devices are
>> > > |      DSP0           DSP1             DSP 2    | support more than
>> one
>> > > vPPB
>> > > ------------------------------------------------  bound to a single
>> > > physical
>> > >          |             |                 |        DSP (transactions
>> are
>> > > tagged
>> > >          |             |                 |        with an LD-ID)
>> > >         SLD0           MLD0              SLD1
>> > >
>> > > Some typical fabric management activities:
>> > > 1) Bind/Unbind vPPB to physical DSP (Results in hotplug / unplug
>> events)
>> > > 2) Access config space or BAR space of End Points below the switch.
>> > > 3) Tunneling messages through to devices downstream (e.g Dynamic
>> Capacity
>> > >    Forced Remove that will blow away some memory even if a host is
>> using
>> > > it).
>> > > 4) Non destructive stuff like status read back.
>> > >
>> > > Given the hosts may be using the Type 3 hosted memory (either Single
>> > > Logical
>> > > Device - SLD, or an LD on a Multi logical Device - MLD) as normal
>> memory,
>> > > unbinding a device in use can result in the memory access from a
>> > > different host being removed. The 'blast radius' is perhaps a rack o=
f
>> > > servers.  This discussion applies equally to FM-API commands sent to
>> Multi
>> > > Head Devices (see CXL r3.1).
>> > >
>> > > The Fabric Management actions are done using the CXL spec defined
>> Fabric
>> > > Management API, (FM-API) which is transported over various means
>> including
>> > > OoB MCTP over your favourite transport (I2C, PCIe-VDM...) or via
>> normal
>> > > PCIe read/write to a Switch-CCI.  A Switch-CCI is mailbox in PCI BAR
>> > > space on a function found alongside one of the switch upstream ports=
;
>> > > this mailbox is very similar to the MMPT definition found in PCIe
>> r6.2.
>> > >
>> > > In many cases this switch CCI / MCTP connection is used by a BMC
>> rather
>> > > than a normal host, but there have been some questions raised about
>> whether
>> > > a general purpose server OS would have a valid reason to use this
>> interface
>> > > (beyond debug and testing) to configure the switch or an MHD.
>> > >
>> > > If people have a use case for this, please reply to this thread to
>> give
>> > > more details.
>> > >
>> > > The most recently posted CXL Switch-CCI support only provided the RA=
W
>> CXL
>> > > command IOCTL interface that is already available for Type 3 memory
>> > > devices.
>> > > That allows for unfettered control of the switch but, because it is
>> > > extremely easy to shoot yourself in the foot and cause unsolvable bu=
g
>> > > reports,
>> > > it taints the kernel. There have been several requests to provide th=
is
>> > > interface
>> > > without the taint for these switch configuration mailboxes.
>> > >
>> > > Last posted series:
>> > >
>> > >
>> https://lore.kernel.org/all/20231016125323.18318-1-Jonathan.Cameron@huaw=
ei.com/
>> > > Note there are unrelated reasons why that code hasn't been updated
>> since
>> > > v6.6 time,
>> > > but I am planning to get back to it shortly.
>> > >
>> > > Similar issues will occur for other uses of PCIe MMPT (new mailbox i=
n
>> PCI
>> > > that
>> > > sometimes is used for similarly destructive activity such as PLDM
>> based
>> > > firmware update).
>> > >
>> > >
>> > > On to the proposed rules:
>> > >
>> > > 1) Kernel space use of the various mailboxes, or filtered controls
>> from
>> > > user space.
>> > >
>> > >
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>> > >
>> > > Absolutely fine - no one worries about this, but the mediated traffi=
c
>> will
>> > > be filtered for potentially destructive side effects. E.g. it will
>> reject
>> > > attempts to change anything routing related if the kernel either
>> knows a
>> > > host is
>> > > using memory that will be blown away, or has no way to know (so
>> affecting
>> > > routing to another host).  This includes blocking 'all' vendor defin=
ed
>> > > messages as we have no idea what the do.  Note this means the kernel
>> has
>> > > an allow list and new commands are not initially allowed.
>> > >
>> > > This isn't currently enabled for Switch CCIs because they are only
>> really
>> > > interesting if the potentially destructive stuff is available (an
>> earlier
>> > > version did enable query commands, but it wasn't particularly useful
>> to
>> > > know what your switch could do but not be allowed to do any of it).
>> > > If you take a MMPT usecase of PLDM firmware update, the filtering
>> would
>> > > check that the device was in a state where a firmware update won't r=
ip
>> > > memory out from under a host, which would be messy if that host is
>> > > doing the update.
>> > >
>> > > 2) Unfiltered userspace use of mailbox for Fabric Management - BMC
>> kernels
>> > >
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > >
>> > > (This would just be a kernel option that we'd advise normal server
>> > > distributions not to turn on. Would be enabled by openBMC etc)
>> > >
>> > > This is fine - there is some work to do, but the switch-cci PCI driv=
er
>> > > will hopefully be ready for upstream merge soon. There is no
>> filtering of
>> > > accesses. Think of this as similar to all the damage you can do via
>> > > MCTP from a BMC. Similarly it is likely that much of the complexity
>> > > of the actual commands will be left to user space tooling:
>> > > https://gitlab.com/jic23/cxl-fmapi-tests has some test examples.
>> > >
>> > > Whether Kconfig help text is strong enough to ensure this only gets
>> > > enabled for BMC targeted distros is an open question we can address
>> > > alongside an updated patch set.
>> > >
>> > > (On to the one that the "debate" is about)
>> > >
>> > > 3) Unfiltered user space use of mailbox for Fabric Management - Dist=
ro
>> > > kernels
>> > >
>> > >
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>> > > (General purpose Linux Server Distro (Redhat, Suse etc))
>> > >
>> > > This is equivalent of RAW command support on CXL Type 3 memory
>> devices.
>> > > You can enable those in a distro kernel build despite the scary conf=
ig
>> > > help text, but if you use it the kernel is tainted. The result
>> > > of the taint is to add a flag to bug reports and print a big message
>> to say
>> > > that you've used a feature that might result in you shooting yoursel=
f
>> > > in the foot.
>> > >
>> > > The taint is there because software is not at first written to deal
>> with
>> > > everything that can happen smoothly (e.g. surprise removal) It's har=
d
>> > > to survive some of these events, so is never on the initial feature
>> list
>> > > for any bus, so this flag is just to indicate we have entered a worl=
d
>> > > where almost all bets are off wrt to stability.  We might not know
>> what
>> > > a command does so we can't assess the impact (and no one trusts vend=
or
>> > > commands to report affects right in the Command Effects Log - which
>> > > in theory tells you if a command can result problems).
>> > >
>> > > A concern was raised about GAE/FAST/LDST tables for CXL Fabrics
>> > > (a r3.1 feature) but, as I understand it, these are intended for a
>> > > host to configure and should not have side effects on other hosts?
>> > > My working assumption is that the kernel driver stack will handle
>> > > these (once we catch up with the current feature backlog!) Currently
>> > > we have no visibility of what the OS driver stack for a fabrics will
>> > > actually look like - the spec is just the starting point for that.
>> > > (patches welcome ;)
>> > >
>> > > The various CXL upstream developers and maintainers may have
>> > > differing views of course, but my current understanding is we want
>> > > to support 1 and 2, but are very resistant to 3!
>> > >
>> > > General Notes
>> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > >
>> > > One side aspect of why we really don't like unfiltered userspace
>> access to
>> > > any
>> > > of these devices is that people start building non standard hacks in
>> and we
>> > > lose the ecosystem advantages. Forcing a considered discussion +
>> patches
>> > > to let a particular command be supported, drives standardization.
>> > >
>> > >
>> > >
>> https://lore.kernel.org/linux-cxl/CAPcyv4gDShAYih5iWabKg_eTHhuHm54vEAei8=
ZkcmHnPp3B0cw@mail.gmail.com/
>> > > provides some history on vendor specific extensions and why in
>> general we
>> > > won't support them upstream.
>> > >
>> > > To address another question raised in an earlier discussion:
>> > > Putting these Fabric Management interfaces behind guard rails of som=
e
>> type
>> > > (e.g. CONFIG_IM_A_BMC_AND_CAN_MAKE_A_MESS) does not encourage the ri=
sk
>> > > of non standard interfaces, because we will be even less likely to
>> accept
>> > > those upstream!
>> > >
>> > > If anyone needs more details on any aspect of this please ask.
>> > > There are a lot of things involved and I've only tried to give a
>> fairly
>> > > minimal illustration to drive the discussion. I may well have missed
>> > > something crucial.
>> > >
>> > > Jonathan
>> > >
>> > >
>> >
>>
>>

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

--000000000000ed55b106150bce15
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-size:small"><fo=
nt face=3D"monospace">Hello Dan, Jonathan -=C2=A0</font></div><div class=3D=
"gmail_default" style=3D"font-size:small"><font face=3D"monospace"><br></fo=
nt></div><div class=3D"gmail_default" style=3D"font-size:small"><span class=
=3D"gmail-im" style=3D"color:rgb(80,0,80)"><div class=3D"gmail_default"><fo=
nt face=3D"monospace">&gt; &gt;</font></div><div class=3D"gmail_default"><s=
pan style=3D"font-family:monospace">&gt;</span><span style=3D"font-family:m=
onospace">=C2=A0</span>&gt; &#39;Maybe&#39; if you were to publish a specif=
ication for those particular<br><span style=3D"font-family:monospace">&gt;=
=C2=A0</span>&gt; vendor defined commands, it might be fine to add them to =
the allow list<br><span style=3D"font-family:monospace">&gt;=C2=A0</span>&g=
t; for the switch-cci.<font face=3D"monospace"><br></font></div><div class=
=3D"gmail_default"><span style=3D"font-family:monospace">&gt;</span><span s=
tyle=3D"font-family:monospace">=C2=A0</span>&gt;</div><div class=3D"gmail_d=
efault"><span style=3D"font-family:monospace">&gt;=C2=A0</span><br></div></=
span><div class=3D"gmail_default"><span style=3D"color:rgb(80,0,80);font-fa=
mily:monospace">&gt;</span><span style=3D"color:rgb(80,0,80);font-family:mo=
nospace">=C2=A0</span><font face=3D"monospace">Your proposal sounds reasona=
ble. I will let you all experts figure out how to support the vendor-define=
d commands. CXL spec has them for a reason and they need to be supported.</=
font></div><br class=3D"gmail-Apple-interchange-newline"></div><div class=
=3D"gmail_default" style=3D"font-size:small"><font face=3D"monospace">Pleas=
e confirm that you will support an &quot;allow list&quot; of the vendor-def=
ined commands. We will publish it once you confirm.</font></div><div class=
=3D"gmail_default" style=3D"font-size:small"><font face=3D"monospace"><br><=
/font></div><div class=3D"gmail_default" style=3D"font-size:small"><font fa=
ce=3D"monospace">Thank you</font></div><div class=3D"gmail_default" style=
=3D"font-size:small"><font face=3D"monospace">Sreeni</font></div><div><div =
dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><d=
iv dir=3D"ltr"><div><font size=3D"1" color=3D"#666666" face=3D"trebuchet ms=
, sans-serif"><a href=3D"mailto:Sreenivas.Bagalkote@broadcom.com" target=3D=
"_blank">Sreenivas Bagalkote</a></font></div><font size=3D"1" color=3D"#666=
666" face=3D"trebuchet ms, sans-serif">Product Planning &amp; Management</f=
ont><div><font size=3D"1" color=3D"#666666" face=3D"trebuchet ms, sans-seri=
f">Broadcom Datacenter Solutions Group</font></div></div></div></div></div>=
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri=
, Mar 22, 2024 at 6:54=E2=80=AFPM Sreenivas Bagalkote &lt;<a href=3D"mailto=
:sreenivas.bagalkote@broadcom.com">sreenivas.bagalkote@broadcom.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-size:s=
mall"><font face=3D"monospace">Jonathan,</font></div><div class=3D"gmail_de=
fault" style=3D"font-size:small"><font face=3D"monospace"><br></font></div>=
<div class=3D"gmail_default" style=3D"font-size:small"><font face=3D"monosp=
ace">&gt;</font></div><div class=3D"gmail_default" style=3D"font-size:small=
">&gt; What is the use case? My understanding so far is that clouds and<br>=
&gt; similar sometimes use an in band path but it would be from a managemen=
t<br>&gt; only host, not a general purpose host running other software<font=
 face=3D"monospace"><br></font></div><div class=3D"gmail_default" style=3D"=
font-size:small"><font face=3D"monospace">&gt;</font></div><div class=3D"gm=
ail_default" style=3D"font-size:small"><font face=3D"monospace"><br></font>=
</div><div class=3D"gmail_default" style=3D"font-size:small"><font face=3D"=
monospace">The overwhelming majority of the PCIe switches get deployed in a=
 single server. Typically four to eight switches are connected to two or mo=
re root complexes in one or two CPUs. The deployment scenario you have in m=
ind - multiple physical hosts running general workloads and a management-on=
ly host - exists. But it is insignificant.</font></div><div class=3D"gmail_=
default" style=3D"font-size:small"><font face=3D"monospace"><br></font></di=
v><div class=3D"gmail_default" style=3D"font-size:small">&gt;=C2=A0<font fa=
ce=3D"monospace"><br></font></div><div class=3D"gmail_default" style=3D"fon=
t-size:small">&gt; For telemetry(subject to any odd corners like commands t=
hat might lock<br>&gt;=C2=A0the interface up for a long time, which we&#39;=
ve seen with commands in the<br>&gt;=C2=A0Spec!) I don&#39;t see any proble=
m supporting those on all host software.<br>&gt;=C2=A0They should be non de=
structive to other hosts etc.<font face=3D"monospace"><br></font></div><div=
 class=3D"gmail_default" style=3D"font-size:small">&gt;=C2=A0<br></div><div=
 class=3D"gmail_default" style=3D"font-size:small"><font face=3D"monospace"=
><br></font></div><div class=3D"gmail_default" style=3D"font-size:small"><f=
ont face=3D"monospace">Thank you. As you do this, please keep in mind that =
your concern about not affecting &quot;other&quot; hosts is theoretically v=
alid but doesn&#39;t exist in the real world beyond science experiments. If=
 there are real-world deployments, they are insignificant. I urge you all t=
o make your stuff work with 99.99% of the deployments.</font></div><div cla=
ss=3D"gmail_default" style=3D"font-size:small"><font face=3D"monospace"><br=
></font></div><div class=3D"gmail_default" style=3D"font-size:small"><font =
face=3D"monospace">&gt;</font></div><div class=3D"gmail_default" style=3D"f=
ont-size:small">&gt; &#39;Maybe&#39; if you were to publish a specification=
 for those particular<br>&gt; vendor defined commands, it might be fine to =
add them to the allow list<br>&gt; for the switch-cci.<font face=3D"monospa=
ce"><br></font></div><div class=3D"gmail_default" style=3D"font-size:small"=
>&gt;</div><div class=3D"gmail_default" style=3D"font-size:small"><br></div=
><div class=3D"gmail_default" style=3D"font-size:small"><font face=3D"monos=
pace">Your proposal sounds reasonable. I will let you all experts figure ou=
t how to support the vendor-defined commands. CXL spec has them for a reaso=
n and they need to be supported.</font></div><div class=3D"gmail_default" s=
tyle=3D"font-size:small"><font face=3D"monospace"><br></font></div><div cla=
ss=3D"gmail_default" style=3D"font-size:small"><font face=3D"monospace">Sre=
eni</font></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Fri, Mar 22, 2024 at 2:32=E2=80=AFAM Jonathan Cameron &l=
t;<a href=3D"mailto:Jonathan.Cameron@huawei.com" target=3D"_blank">Jonathan=
Cameron@huawei.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">On Thu, 21 Mar 2024 14:41:00 -0700<br>
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
--000000000000ed55b106150bce15--

--000000000000f89fec06150bce7e
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
QSAyMDIwAgxWGkS0kzZ2sG5VN8swDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIDh0
AHCi/K4kbkeD4Z0974FJoiUhBeoZMgL8618LSPAvMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI0MDQwMTE2NTIwMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJ
KoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAfF33xm7jit4etpfE9q+XQ
qS1KMWKu+7LLcTjOc2TxW/WfbP+IFyYgL4Q0SF1yO9Em7SUUqSYMB33eUgePtnWiyp4JPg3Im9s3
b1ULNaXWtlTHgymVuzQReSAvnzhi2zwBLShLUXYrPT4YYDBnrtCLs8m22Emduwa9HygiKPiwWk8T
VVDy1ScZqgC8s3iM+9GsUanm85V82OEyX97kV1VJNyKRZNrRWnEETaDIHd76JCZXJWGGp85swueN
DYHEHuGUXW0kUxF5Kg3AHc5/aAdbTxyl4aUrWOXYi93NP8g69maWc4BkoNJNvDgpDpyv9AhCIHEg
kDhmqA0sywlRiltI
--000000000000f89fec06150bce7e--

