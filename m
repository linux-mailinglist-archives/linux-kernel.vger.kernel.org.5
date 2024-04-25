Return-Path: <linux-kernel+bounces-158451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C89EF8B2053
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC8FE1C217F1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D616712AAD4;
	Thu, 25 Apr 2024 11:33:54 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6E884DEE;
	Thu, 25 Apr 2024 11:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714044834; cv=none; b=CzMPE8c05WPrJBX+RaXHNImDaddJpiKi9TxIG9NCiXuccX0sXMvVEvvvmM+SCn7dzFbIjxUvMDo/UrPriXDI52J4Yprr2stnWdHg08EdsGyVqp2+Z+kEf+WEk4HZzHvmvGhW9xnJXzNBFeVNzib51/sbflXDvhuYhijavV/epZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714044834; c=relaxed/simple;
	bh=5Q1ztjo0rbFrVlWVjogoIXWhHiTDXjAOBjW05MpCtEw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RXSJCk1xJkGmiirW1CFA3TkB/uUq/2mHSRZtmq2iRn4gXuwwZ6EwpC9oDXabWOeS1pcpVUOWFBc3LJxPCBEYZMUc86PF5plJu98STudQRGLKCHnmcRhR99IbzdsA/eFGVs+fqjSWStlmGgqF+CSJWgH+Uk4Ct06Rd25eQxkZtEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VQDFh36gfz6K6XF;
	Thu, 25 Apr 2024 19:31:20 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A415B140AB8;
	Thu, 25 Apr 2024 19:33:45 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 25 Apr
 2024 12:33:45 +0100
Date: Thu, 25 Apr 2024 12:33:44 +0100
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
Message-ID: <20240425123344.000001a9@Huawei.com>
In-Reply-To: <66284d5e8ac01_690a29431@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240321174423.00007e0d@Huawei.com>
	<66109191f3d6d_2583ad29468@dwillia2-xfh.jf.intel.com.notmuch>
	<20240410124517.000075f2@Huawei.com>
	<66284d5e8ac01_690a29431@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 23 Apr 2024 17:07:58 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> [..]
> > > It is not clear to me that this material makes sense to house in
> > > drivers/ vs tools/ or even out-of-tree just for maintenance burden
> > > relief of keeping the universes separated. What does the Linux kernel
> > > project get out of carrying this in mainline alongside the inband code?  
> > 
> > I'm not sure what you mean by in band.  Aim here was to discuss
> > in-band drivers for switch CCI etc. Same reason from a kernel point of
> > view for why we include embedded drivers.  I'll interpret in band
> > as host driven and not inband as FM-API stuff.
> >    
> > > I do think the mailbox refactoring to support non-CXL use cases is
> > > interesting, but only so far as refactoring is consumed for inband use
> > > cases like RAS API.  
> > 
> > If I read this right, I disagree with the 'only so far' bit.
> > 
> > In all substantial ways we should support BMC use case of the Linux Kernel
> > at a similar level to how we support forms of Linux Distros.  
> 
> I think we need to talk in terms of specifics, because in the general
> case I do not see the blockage. OpenBMC currently is based on v6.6.28
> and carries 136 patches. An additional patch to turn off raw commands
> restrictions over there would not even be noticed.

Hi Dan,

That I'm fine with - it's a reasonable middle ground where we ensure
they have a sensible upstream solution, but just patch around the
taint etc in the downstream projects.

Note 136 patches is tiny for a distro and reflects their hard work
upstreaming stuff.

> 
> > It may not be our target market as developers for particular parts of
> > our companies, but we should not block those who want to support it.  
> 
> It is also the case that there is a responsibility to build maintainable
> kernel interfaces that can be reasoned about, especially with devices as
> powerful as CXL that are trusted to host system memory and be caching
> agents. For example, I do not want to be in the position of auditing
> whether proposed tunnels and passthroughs violate lockdown expectations.

I agree with that - this can be made dependent on not locking down
in the same way lots of other somewhat dangerous interfaces are.
We can relax that restriction as things do get audited - sure
tunnels aren't going to be on that allowed list in the short term.

> 
> Also, the assertion that these kernels will be built with
> CONFIG_SECURITY_LOCKDOWN_LSM=n and likely CONFIG_STRICT_DEVMEM=n, then
> the entire user-mode driver ABI is available for use. CXL commands are
> simple polled mmio, does Linux really benefit from carrying drivers in
> the kernel that the kernel itself does not care about?

Sure we could it in userspace...  It's bad engineering, limits the design
to polling only and uses a bunch of interfaces we put a lot of effort into
telling people not to use except for debug.

I really don't see the advantage in pushing a project/group of projects
all of which are picking the upstream kernel up directly, to do a dirty
hack. We loose all the advantages of a proper well maintained kernel
driver purely on the argument that one use model is not the same as
this one.  Sensible security lockdown requirements is fine (along
with all the other kernel features that must be disable for that
to work), making open kernel development on for a large Linux
market harder is not.

> 
> [..]
> > Switch CCI Driver: PCI driver doing everything beyond the CXL mbox specific bit.
> > Type 3 Stack: All the normal stack just with the CXL Mailbox specific stuff factored
> >               out. Note we can move different amounts of shared logic in here, but
> >               in essence it deals with the extra layer on top of the raw MMPT mbox.
> > MMPT Mbox: Mailbox as per the PCI spec.
> > RAS API:   Shared RAS API specific infrastructure used by other drivers.  
> 
> Once the CXL mailbox core is turned into a library for kernel internal
> consumers, like RAS API, or CXL accelerators, then it becomes easier to
> add a Switch CCI consumer (perhaps as an out-of-tree module in tools/),
> but it is still not clear why the kernel benefits from that arrangement.

We can argue later on this. But from my point of view, in tree module not
in tools is a must.  Doesn't have to be in drivers/cxl if its simply the
association aspect that is a blocker.

> 
> This is less about blocking developers that have different goals it is
> about finding the right projects / places to solve the problem
> especially when disjoint design goals are in play and user space drivers
> might be in reach.

Key here is this is not a case of openBMC is the one true distro on 
which all Linux BMCs and fabric management platforms are based.
So we are really talking a random out of tree driver with all the maintenance
overhead that brings.  Yuck.

So I don't see there being any good solution out side of upstream support
other than pushing this to be a userspace hack.

> 
> [..]
> > > > The various CXL upstream developers and maintainers may have
> > > > differing views of course, but my current understanding is we want
> > > > to support 1 and 2, but are very resistant to 3!    
> > > 
> > > 1, yes, 2, need to see the patches, and agree on 3.  
> > 
> > If we end up with top architecture of the diagrams above, 2 will look pretty
> > similar to last version of the switch-cci patches.  So raw commands only + taint.
> > Factoring out MMPT is another layer that doesn't make that much difference in
> > practice to this discussion. Good to have, but the reuse here would be one layer
> > above that.
> > 
> > Or we just say go for second proposed architecture and 0 impact on the
> > CXL specific code, just reuse of the MMPT layer.  I'd imagine people will get
> > grumpy on code duplication (and we'll spend years rejecting patch sets that
> > try to share the cdoe) but there should be no maintenance burden as
> > a result.  
> 
> I am assuming that the shared code between MMPT and CXL will happen and
> that all of the command infrastructure is where centralized policy can
> not keep up.

There is actually very little to MMPT, but sure there will be some sharing
of code and the policy won't sit in that shared part as it is protocol
specific.

> If OpenBMC wants to land a driver that consumes the MMPT
> core in tools/ that would seem to satisfy both the concerns of mainline
> not shipping ABI that host kernels need to strictly reason about while
> letting OpenBMC not need to carry out-of-tree patches indefinitely.

We can argue that detail later, but tools is not in my opinion
a valid solution to supporting properly maintained upstream drivers.
Its a hack for test and example modules only.  The path of just
blocking this driver in any locked down situation seems much more inline
with kernel norms.  It is also extremely bad precedence.

Jonathan

p.s. I don't care in the slightest about openBMC (other than general
warm fuzzy feelings about a good open source project), I do care
rather more about BMCs and other fabric managers.





