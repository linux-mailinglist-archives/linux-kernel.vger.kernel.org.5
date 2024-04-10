Return-Path: <linux-kernel+bounces-138428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B932889F118
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBD281C22F79
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05B315AAC8;
	Wed, 10 Apr 2024 11:45:26 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A563D15958A;
	Wed, 10 Apr 2024 11:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712749526; cv=none; b=Exndx3SmMtNvDf4jwO2DUKUVznnQXwzKqwgwuEzTE6y86cQ6xph8OcrUXdrKN2+S5CgGzQHG0H+l55nTNMdmRqDTmnOXaU0De1sd2HJtI+pHWEdILda/yUuasfU0i87Eq99VOVHbRYBFGgl9w7r+VDotIJohbQZgaySXPwdKBk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712749526; c=relaxed/simple;
	bh=/L8YranAUwm1ifaVgmtTP4OpW+lmj/F3rMFKXqB+Sx4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c8NFoPF7nrhOqgge9Fj6Hu8bLIydGgoH4VhgX4qaeZmF85IALeQYjqTiwtgCM9ggYTbEv5Cy7IcDHlyPieqFikuyr/bF5h08EDfx1HE4KBBtYoNW+wPodzd/qc55nDyWzKqQRtIn1Rr3r3fhoXZIkLulpr0foUn8jGlUSVOL/C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VF19D33pdz6K9Hb;
	Wed, 10 Apr 2024 19:40:32 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id AC2351408F9;
	Wed, 10 Apr 2024 19:45:19 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 10 Apr
 2024 12:45:19 +0100
Date: Wed, 10 Apr 2024 12:45:17 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Sreenivas Bagalkote
	<sreenivas.bagalkote@broadcom.com>, Brett Henning
	<brett.henning@broadcom.com>, Harold Johnson <harold.johnson@broadcom.com>,
	Sumanesh Samanta <sumanesh.samanta@broadcom.com>,
	<linux-kernel@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, "Ira Weiny" <ira.weiny@intel.com>,
	<linuxarm@huawei.com>, <linux-api@vger.kernel.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, "Natu, Mahesh" <mahesh.natu@intel.com>
Subject: Re: RFC: Restricting userspace interfaces for CXL fabric management
Message-ID: <20240410124517.000075f2@Huawei.com>
In-Reply-To: <66109191f3d6d_2583ad29468@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240321174423.00007e0d@Huawei.com>
	<66109191f3d6d_2583ad29468@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 5 Apr 2024 17:04:34 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

Hi Dan,

> Jonathan Cameron wrote:
> > Hi All,
> >=20
> > This is has come up in a number of discussions both on list and in priv=
ate,
> > so I wanted to lay out a potential set of rules when deciding whether o=
r not
> > to provide a user space interface for a particular feature of CXL Fabric
> > Management.  The intent is to drive discussion, not to simply tell peop=
le
> > a set of rules.  I've brought this to the public lists as it's a Linux =
kernel
> > policy discussion, not a standards one.
> >=20
> > Whilst I'm writing the RFC this my attempt to summarize a possible
> > position rather than necessarily being my personal view.
> >=20
> > It's a straw man - shoot at it!
> >=20
> > Not everyone in this discussion is familiar with relevant kernel or CXL=
 concepts
> > so I've provided more info than I normally would. =20
>=20
> Thanks for writing this up Jonathan!
>=20
> [..]
> > 2) Unfiltered userspace use of mailbox for Fabric Management - BMC kern=
els
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >=20
> > (This would just be a kernel option that we'd advise normal server
> > distributions not to turn on. Would be enabled by openBMC etc)
> >=20
> > This is fine - there is some work to do, but the switch-cci PCI driver
> > will hopefully be ready for upstream merge soon. There is no filtering =
of
> > accesses. Think of this as similar to all the damage you can do via
> > MCTP from a BMC. Similarly it is likely that much of the complexity
> > of the actual commands will be left to user space tooling:=20
> > https://gitlab.com/jic23/cxl-fmapi-tests has some test examples.
> >=20
> > Whether Kconfig help text is strong enough to ensure this only gets
> > enabled for BMC targeted distros is an open question we can address
> > alongside an updated patch set. =20
>=20
> It is not clear to me that this material makes sense to house in
> drivers/ vs tools/ or even out-of-tree just for maintenance burden
> relief of keeping the universes separated. What does the Linux kernel
> project get out of carrying this in mainline alongside the inband code?

I'm not sure what you mean by in band.  Aim here was to discuss
in-band drivers for switch CCI etc. Same reason from a kernel point of
view for why we include embedded drivers.  I'll interpret in band
as host driven and not inband as FM-API stuff.
=20
> I do think the mailbox refactoring to support non-CXL use cases is
> interesting, but only so far as refactoring is consumed for inband use
> cases like RAS API.

If I read this right, I disagree with the 'only so far' bit.

In all substantial ways we should support BMC use case of the Linux Kernel
at a similar level to how we support forms of Linux Distros.  It may
not be our target market as developers for particular parts of our companie=
s,
but we should not block those who want to support it.

We should support them in drivers/ - maybe with example userspace code
in tools.  Linux distros on BMCs is a big market, there are a number
of different distros using (and in some cases contributing to) the
upstream kernel. Not everyone is using openBMC so there is not one
common place where downstream patches could be carried.
=46rom a personal point of view, I like that for the same reasons that
I like there being multiple Linux sever focused distros. It's a sign
of a healthy ecosystem to have diverse options taking the mainline
kernel as their starting point.

BMCs are just another embedded market, and like other embedded markets
we want to encourage upstream first etc.=20
openBMC has a policy on this:
https://github.com/openbmc/docs/blob/master/kernel-development.md
"The OpenBMC project maintains a kernel tree for use by the project.
The tree's general development policy is that code must be upstream
first." There are paths to bypass that for openBMC so it's a little
more relaxed than some enterprise distros (today, their policies used
to look very similar to this) but we should not be telling
them they need to carry support downstream.  If we are
going to tell them that, we need to be able to point at a major
sticking point for maintenance burden.  So far I don't see the
additional complexity as remotely close reaching that bar.

So I think we do want switch-cci support and for that matter the equivalent
for MHDs in the upstream kernel.

One place I think there is some wiggle room is the taint on use of raw
commands.  Leaving removal of that for BMC kernels as a patch they need
to carry downstream doesn't seem too burdensome. I'm sure they'll push
back if it is a problem for them!  So I think we can kick that question
into the future.

Addressing maintenance burden, there is a question of where we split
the stack.  Ignore MHDs for now (I won't go into why in this forum...)

The current proposal is (simplified to ignore some sharing in lookup code e=
tc
that I can rip out if we think it might be a long term problem)

     _____________          _____________________
    |             |        |                     |
    | Switch CCI  |        |  Type 3 Driver stack|=20
    |_____________|        |_____________________|
           |___________________________|              Whatever GPU etc
                  _______|_______                   _______|______
                 |               |                 |              |
                 |  CXL MBOX     |                 | RAS API etc  |
                 |_______________|                 |______________|
                             |_____________________________|
                                           |
                                  _________|______
                                 |                |
                                 |   MMPT mbox    |
                                 |________________|

Switch CCI Driver: PCI driver doing everything beyond the CXL mbox specific=
 bit.
Type 3 Stack: All the normal stack just with the CXL Mailbox specific stuff=
 factored
              out. Note we can move different amounts of shared logic in he=
re, but
              in essence it deals with the extra layer on top of the raw MM=
PT mbox.
MMPT Mbox: Mailbox as per the PCI spec.
RAS API:   Shared RAS API specific infrastructure used by other drivers.

If we see a significant maintenance burden, maybe we duplicate the CXL spec=
ific
MBOX layer - I can see advantages in that as there is some stuff not releva=
nt
to the Switch CCI.  There will be some duplication of logic however such
as background command support (which is CXL only IIUC)  We can even use
a difference IOCTL number so the two can diverge if needed in the long run.

e.g. If it makes it easier to get upstream, we can merrily duplicated code
so that only the bit common with RAS API etc is shared (assuming the
actually end up with MMPT, not the CXL mailbox which is what their current
publicly available spec talks about and I assume is a pref MMPT left over?)

     _____________          _____________________
    |             |        |                     |
    | Switch CCI  |        |  Type 3 Driver stack|=20
    |_____________|        |_____________________|
           |                           |              Whatever GPU etc
    _______|_______             _______|_______        ______|_______
   |               |           |               |      |              |
   |  CXL MBOX     |           |  CXL MBOX     |      | RAS API etc  |
   |_______________|           |_______________|      |______________|
           |_____________________________|____________________|
                                         |
                                 ________|______
                                |               |
                                |   MMPT mbox   |
                                |_______________|


> > (On to the one that the "debate" is about)
> >=20
> > 3) Unfiltered user space use of mailbox for Fabric Management - Distro =
kernels
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > (General purpose Linux Server Distro (Redhat, Suse etc))
> >=20
> > This is equivalent of RAW command support on CXL Type 3 memory devices.
> > You can enable those in a distro kernel build despite the scary config
> > help text, but if you use it the kernel is tainted. The result
> > of the taint is to add a flag to bug reports and print a big message to=
 say
> > that you've used a feature that might result in you shooting yourself
> > in the foot.
> >=20
> > The taint is there because software is not at first written to deal with
> > everything that can happen smoothly (e.g. surprise removal) It's hard
> > to survive some of these events, so is never on the initial feature list
> > for any bus, so this flag is just to indicate we have entered a world
> > where almost all bets are off wrt to stability.  We might not know what
> > a command does so we can't assess the impact (and no one trusts vendor
> > commands to report affects right in the Command Effects Log - which
> > in theory tells you if a command can result problems). =20
>=20
> That is a secondary reason that the taint is there. Yes, it helps
> upstream not waste their time on bug reports from proprietary use cases,
> but the effect of that is to make "raw" command mode unattractive for
> deploying solutions at scale. It clarifies that this interface is a
> debug-tool that enterprise environment need not worry about.
>=20
> The more salient reason for the taint, speaking only for myself as a
> Linux kernel community member not for $employer, is to encourage open
> collaboration. Take firmware-update for example that is a standard
> command with known side effects that is inaccessible via the ioctl()
> path. It is placed behind an ABI that is easier to maintain and reason
> about. Everyone has the firmware update tool if they have the 'cat'
> command. Distros appreciate the fact that they do not need ship yet
> another vendor device-update tool, vendors get free tooling and end
> users also appreciate one flow for all devices.
>=20
> As I alluded here [1], I am not against innovation outside of the
> specification, but it needs to be open, and it needs to plausibly become
> if not a de jure standard at least a de facto standard.
>=20
> [1]: https://lore.kernel.org/all/CAPcyv4gDShAYih5iWabKg_eTHhuHm54vEAei8Zk=
cmHnPp3B0cw@mail.gmail.com/

Agree with all this.

>=20
> > A concern was raised about GAE/FAST/LDST tables for CXL Fabrics
> > (a r3.1 feature) but, as I understand it, these are intended for a
> > host to configure and should not have side effects on other hosts?
> > My working assumption is that the kernel driver stack will handle
> > these (once we catch up with the current feature backlog!) Currently
> > we have no visibility of what the OS driver stack for a fabrics will
> > actually look like - the spec is just the starting point for that.
> > (patches welcome ;)
> >=20
> > The various CXL upstream developers and maintainers may have
> > differing views of course, but my current understanding is we want
> > to support 1 and 2, but are very resistant to 3! =20
>=20
> 1, yes, 2, need to see the patches, and agree on 3.

If we end up with top architecture of the diagrams above, 2 will look pretty
similar to last version of the switch-cci patches.  So raw commands only + =
taint.
Factoring out MMPT is another layer that doesn't make that much difference =
in
practice to this discussion. Good to have, but the reuse here would be one =
layer
above that.

Or we just say go for second proposed architecture and 0 impact on the
CXL specific code, just reuse of the MMPT layer.  I'd imagine people will g=
et
grumpy on code duplication (and we'll spend years rejecting patch sets that
try to share the cdoe) but there should be no maintenance burden as
a result.

>=20
> > General Notes
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > One side aspect of why we really don't like unfiltered userspace access=
 to any
> > of these devices is that people start building non standard hacks in an=
d we
> > lose the ecosystem advantages. Forcing a considered discussion + patches
> > to let a particular command be supported, drives standardization. =20
>=20
> Like I said above, I think this is not a side aspect. It is fundamental
> to the viability Linux as a project. This project only works because
> organizations with competing goals realize they need some common
> infrastructure and that there is little to be gained by competing on the
> commons.
>=20
> > https://lore.kernel.org/linux-cxl/CAPcyv4gDShAYih5iWabKg_eTHhuHm54vEAei=
8ZkcmHnPp3B0cw@mail.gmail.com/
> > provides some history on vendor specific extensions and why in general =
we
> > won't support them upstream. =20
>=20
> Oh, you linked my writeup... I will leave the commentary I added here in =
case
> restating it helps.
>=20
> > To address another question raised in an earlier discussion:
> > Putting these Fabric Management interfaces behind guard rails of some t=
ype
> > (e.g. CONFIG_IM_A_BMC_AND_CAN_MAKE_A_MESS) does not encourage the risk
> > of non standard interfaces, because we will be even less likely to acce=
pt
> > those upstream!
> >=20
> > If anyone needs more details on any aspect of this please ask.
> > There are a lot of things involved and I've only tried to give a fairly
> > minimal illustration to drive the discussion. I may well have missed
> > something crucial. =20
>=20
> You captured it well, and this is open source so I may have missed
> something crucial as well.
>=20

Thanks for detailed reply!

Jonathan



