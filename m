Return-Path: <linux-kernel+bounces-159726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBE48B3335
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FAF3B20C57
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E08613C9B3;
	Fri, 26 Apr 2024 08:46:01 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A1643AC5;
	Fri, 26 Apr 2024 08:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714121160; cv=none; b=ORqJfFcvFfThT3SnTnqMeoxBO5sD5LD+9TLQ/2eaunISJp6tsRmv46AxvprtCaYSs3+IvL4nnm4ArLOeY1tT06qkdkvqawp3mTi8gH0QyEVn0LUmH3pMxL4SCGSw0PQMPpwCMvxrU2ociH2eljLukZGRHcoclz0sRu1QTVMIKL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714121160; c=relaxed/simple;
	bh=EDtk/whEi0DosHfj2kOk77Fv02Xgxkz/v+jOQXINgeA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L0X/WfV+ZGrPCew2QANY/7LNG7sELCTrdXpObIjzNDQrlFNtx/SCeCrfui9qCVF8hFaIK0OFW2SZqrZ3zs3VClOK51gzV6H2McW7KPXx+7uirhKGXmHbEvxZujDa7PPzULilQhy5yLGRAbXdhYwQJv/IsKPurHeZY5MAzHMGdT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VQmX50mgSz6D96f;
	Fri, 26 Apr 2024 16:45:41 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B7EF140447;
	Fri, 26 Apr 2024 16:45:52 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 26 Apr
 2024 09:45:51 +0100
Date: Fri, 26 Apr 2024 09:45:50 +0100
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
	<lpieralisi@kernel.org>, "Natu, Mahesh" <mahesh.natu@intel.com>,
	<gregkh@linuxfoundation.org>
Subject: Re: RFC: Restricting userspace interfaces for CXL fabric management
Message-ID: <20240426094550.00002e37@Huawei.com>
In-Reply-To: <662aae2fe4887_a96f294bf@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240321174423.00007e0d@Huawei.com>
	<66109191f3d6d_2583ad29468@dwillia2-xfh.jf.intel.com.notmuch>
	<20240410124517.000075f2@Huawei.com>
	<66284d5e8ac01_690a29431@dwillia2-xfh.jf.intel.com.notmuch>
	<20240425123344.000001a9@Huawei.com>
	<662a826dbeeff_b6e02943c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	<20240425182605.00005f22@Huawei.com>
	<662aae2fe4887_a96f294bf@dwillia2-mobl3.amr.corp.intel.com.notmuch>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 25 Apr 2024 12:25:35 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > Dan Williams <dan.j.williams@intel.com> wrote:  
> > > The minimum requirement for justifying an in kernel driver is that
> > > something else in the kernel consumes that facility. So, again, I want
> > > to get back to specifics what else in the kernel is going to leverage
> > > the Switch CCI mailbox?  
> > 
> > Why?  I've never heard of such as a requirement and numerous drivers
> > provide fairly direct access to hardware. Sometimes there is a subsystem
> > aiding the data formatting etc, but fundamentally that's a convenience.
> > 
> > Taking this to a silly level, on this basis all networking drivers would
> > not be in the kernel.  They are there mainly to provide userspace access to
> > a network.  
> 
> Networking is an odd choice to bring into this discussion because that
> subsystem has a long history of wrestling with the "kernel bypass"
> concern. It has largely been able to weather the storm of calls to get
> out of the way and let vendor drivers have free reign.
> 
> The AF_XDP socket family was the result of finding a path to let
> userspace networking stacks build functionality without forfeiting the
> relevance and ongoing collaboration on the in-kernel stack.

This first chunk of my reply was all about poking holes in the 'must
have an in kernel user' not trying to make any broader points. That argument
is one bullet of perhaps 20 good reasons for in-kernel support, you've listed
quite a few more so point hopefully made.

I fully agree with the other reasons you've given for why things
are in the kernel, but key here is we don't need to meet the
in-kernel user requirement.  Here the focus is on encouraging standards
adoption.

> 
> > Any of the hardware access subsystems such hwmon, input, IIO
> > etc are primarily about providing a convenient way to get data to/from
> > a device.  They are kernel drivers because that is the cleaner path
> > for data marshaling, interrupt handling etc.  
> 
> Those are drivers supporting a subsystem to bring a sane kernel
> interface to front potenitally multiple vendor implementations of
> similar functionality.

I have painful memories of early feedback on IIO that was very similar
to arguments here - it wasn't far off killing of the whole effort.

> 
> They are not asking for kernel bypass facilities that defeat the purpose
> of ever talking to the kernel community again for potentially
> system-integrity violating functionality behind disparate vendor
> interfaces.

I'm not asking for that at all.  This discussion got a bit derailed
though so I can see why you might have taken that impression away.

> 
> > In kernel users are a perfectly valid reason to have a kernel driver,
> > but it's far from the only one.  None of the AI accelerators have in kernel
> > users today (maybe they will in future). Sure there are other arguments
> > that mean only a few such devices have been upstreamed, but it's not
> > that they need in kernel users. If it's really an issue I'll just submit
> > it to driver/misc and Greg can take a view on whether it's an acceptable
> > device to have driver for... (after he's asked the obvious question of
> > why aren't the CXL folk taking it!) +cc Greg to save providing info later.  
> 
> AI accelerators are heavy consumers of the core-mm you can not
> reasonably coordinate with the core-mm from userspace.
> 
> If the proposal is to build a new CXL Fabric Management subsystem with
> proper ABIs and openly defined command sets that will sit behind thought
> out kernel interfaces then I can get on board with that.
> 
> Where I am stuck currently is the assertion that step 1 is "build ioctl
> passthrough tunnels with 'do anything you want and get away with it'
> semantics".

If you think step 1 is the end goal, then indeed I see your problem.

Reality is that this stuff is needed today and similar to type 3 there
will be people who use the raw interface to enabled their custom stuff
- we can enable that but put similar measures in place to to encourage
upstreaming / standarization.  I should perhaps not have diverted
into the fact openBMC 'might' patch out the taint.  I suspect some
server distros will do that for type 3 devices to, but the advantages
to vendors of playing nicely with upstream still apply. I do however
want to encourage openBMC folk to collaborate on support and if that
means letting them play fast and loose with what they do downstream for
now that's fine - they will not want to carry such patches long term anyway.

The end goal is to enable multiple things:

1) Standardization: That's exactly why I proposed that if broadcomm want
   to have upstream support for their interfaces they should do two things:
   a) Take a proposal to the consortium to extend the standard definition
      to incorporate those features (we want to see them playing the game
      so everyone benefits!) 
   b) Provide clear description of the vendor defined commands so that
      the safe ones can be audited and enabled as 'defacto' standards.
      We do this with lots of other things - if you are playing the game
      nicely we relax the rules a little to encourage you to keep doing so.
   This is the path being proposed for the upstream driver.

2) A path sharing that same standard infrastructure for the more destructive
   commands. That can have all the protections we want to add.
   For the BMC stacks some of that stuff will be vital and it's complex
   so there is an argument that not all that belongs in the kernel or at
   least not today. One of the other comments I recall for the raw command
   support in the type 3 driver was to allow people to test stuff that was
   safe, was in the spec, but was not yet audited by the driver.  I'd put
   a lot of this in that category.  We can absolutely do tunneled commands
   nicely and filter them for destructive activity etc - it just doesn't
   belong in the first patch set.
   Ultimately I would expect approaches to enable the destructive commands
   as well via standard interfaces, but those will of course need guard
   rails / opt in etc.

I never intended to propose that the raw command path is the main one
used - that's there for the same reasons we have one in CXL type3, though
here I suspect the path to supporting everything needed via non
raw interfaces will be longer.

> 
> Recall that the current restriction for raw commands was to encourage
> vendor collaboration and building sane kernel interfaces, and that
> distros would enable it in their "debug" kernels to enable hardware
> validation test benches. If the assertion is "that's too restrictive,
> enable a vendor ecosystem based on kernel bypass" that goes too far.

This is a clear description of the concern and it's one I fully share.
My interpretation of your earlier responses was clearly wrong - this
is about avoiding kernel bypass and encouraging standardization.
Your comments on doing user space drivers read to me like you were
telling the switch vendors to go do exactly that and that is why
I was pushing back strongly!  All the other responses were based on
me trying to answer other concerns (maintainability for example)
rather than this one.

WRT to relationship to the raw commands: this is the same proposal.
Much like the initial CXL mailbox support provide a raw bypass for
the cases not supported and put the same guards around it (or tighter
ones). That is better in the upstream kernel than pushing the problem
downstream and basically removing any reason at all for switch vendors
to do things right. Give them a path and they will come. So far
what I suspect they are seeing is no path at all - driving fragmentation.
(handy switch vendors in the CC list feel free to say how you are interpretting
 this discussion!)

If we'd had upstream support already in place with those restrictions
the rules for switch vendors would have been clear and (assuming they
have some active ecosystem folk) their design would have taken this
into account.

The early switch-cci code proposal was exactly the same as the CXL mailbox.
It had a bunch of commands (IIRC) included get temperature, get timestamp etc
that were safe and handled in exactly the same fashion as the in
kernel interfaces.  The reason that I ripped that out was to reduce
the amount and complexity of the first proposal so the focus would lie
on the necessary refactoring of the CXL core to allow for code reuse.
That stuff will comeback in patch set 2 - we can easily put it back in
the first patch set if that helps make the strategy clear - it's just
a few lines of code.

All the infrastructure is still there to support safe commands vs unsafe ones.
Same logic, same approach and actually the same code as for the CXL mailbox.
I fully agree with all that approach.

> 
> > For background this is a PCI function with a mailbox used for switch
> > configuration. The mailbox is identical to the one found on CXL type3
> > devices. Whole thing defined in the CXL spec. It gets a little complex
> > because you can tunnel commands to devices connected to the switch,
> > potentially affecting other hosts.  Typical Linux device doing this
> > would be a BMC, but there have been repeated questions about providing
> > a subset of access to any Linux system (avoiding the foot guns)
> > Whole thing fully discoverable - proposal is a standard PCI driver.
> >   
> > > The generic-Type-3-device mailbox has an in kernel driver because the
> > > kernel has need to send mailbox commands internally and it is
> > > fundamental to RAS and provisioning flows that the kernel have this
> > > coordination. What are the motivations for an in-band Switch CCI command
> > > submission path?
> > > 
> > > It could be the case that you have a self-evident example in mind that I
> > > have thus far failed to realize.
> > >   
> > 
> > There are possibilities, but for now it's a transport driver just like
> > MCTP etc with a well defined chardev interface, with documented ioctl
> > interface etc (which I'd keep inline with one the CXL mailbox uses
> > just to avoid reinventing the wheel - I'd prefer to use that directly
> > to avoid divergence but I don't care that much).
> > 
> > As far as I can see, with the security / blast radius concern alleviated
> > by disabling this if lockdown is in use + taint for unaudited commands
> > (and a nasty sounding config similar to the cxl mailbox one)
> > there is little reason not to take such a driver into the kernel.
> > It has next to no maintenance impact outside of itself and a bit of
> > library code which I've proposed pushing down to the level of MMPT
> > (so PCI not CXL) if you think that is necessary. 
> > 
> > We want interrupt handling and basic access controls / command
> > interface to userspace.
> > 
> > Apologies if I'm grumpy - several long days of battling cpu hotplug code.  
> 
> Again, can we please get back to the specifics of the commands to be
> enabled here? I am open to CXL Fabric Management as a first class
> citizen, I am not currently open to CXL Fabric Management gets to live
> in the corner of the kernel that is unreviewable because all it does is
> take opaque ioctl blobs and marshal them to hardware.
> 

That I'm fully on board with.  However there are plenty of spec defined
commands that in this safe category and to show how this works we can
implement those in parallel to a discussion about those defined outside
the CXL specification.

Encouraging people to do things via a hacky userspace driver as I read
you as doing earlier in this thread will have given exactly the opposite
impression.

To give people an incentive to play the standards game we have to
provide an alternative.  Userspace libraries will provide some incentive
to standardize if we have enough vendors (we don't today - so they will
do their own libraries), but it is a lot easier to encourage if we
exercise control over the interface.

Jonathan


