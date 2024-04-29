Return-Path: <linux-kernel+bounces-162231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E574D8B5815
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C9842897A3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3920F6FE14;
	Mon, 29 Apr 2024 12:18:26 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3D8548EC;
	Mon, 29 Apr 2024 12:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714393105; cv=none; b=drlm01zFyzFhLLKzsd5r9OOVnecah66vsmI7apcnd+cMgtmEr5Tncg8DTbh+DA84i/M2V03Uok6676P8jGemjQkb5TgaiVy0sFpxLedGqTZ/ECwKtNHsvEdtBIXvomYxCALRJXUPRG02sofi0id+tgKGfi2Vk025rqje9itJN9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714393105; c=relaxed/simple;
	bh=NPHXUVH74K4y2grEbTSYpPMd8SrTf/Vc1B0Gzk0Q5/s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uzksINruIFmKBakNs2ESt2cq4XbUP4EMskZma+Jzab01Cs+RuwsGaCp0WktAx/lB/AgzzOhrFh6u+RxnHX05a8Jbfrr3pSFMJsvtiKr2LYMC1zurorw4hf1AyB8OA+sX7W4hEi/7YAtQ3t4nhxTRVwW98fpb8sJl7MfJ2X6j76A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VSj305HQtz6K5p5;
	Mon, 29 Apr 2024 20:15:40 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 1BB27140B63;
	Mon, 29 Apr 2024 20:18:18 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 29 Apr
 2024 13:18:17 +0100
Date: Mon, 29 Apr 2024 13:18:16 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Harold Johnson <harold.johnson@broadcom.com>
CC: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	Sreenivas Bagalkote <sreenivas.bagalkote@broadcom.com>, Brett Henning
	<brett.henning@broadcom.com>, Sumanesh Samanta
	<sumanesh.samanta@broadcom.com>, <linux-kernel@vger.kernel.org>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linuxarm@huawei.com>, <linux-api@vger.kernel.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, "Natu, Mahesh" <mahesh.natu@intel.com>,
	<gregkh@linuxfoundation.org>
Subject: Re: RFC: Restricting userspace interfaces for CXL fabric management
Message-ID: <20240429131816.00005177@Huawei.com>
In-Reply-To: <6351024b5d6206c4e9a8cd98d1a09d43@mail.gmail.com>
References: <20240321174423.00007e0d@Huawei.com>
	<66109191f3d6d_2583ad29468@dwillia2-xfh.jf.intel.com.notmuch>
	<20240410124517.000075f2@Huawei.com>
	<66284d5e8ac01_690a29431@dwillia2-xfh.jf.intel.com.notmuch>
	<20240425123344.000001a9@Huawei.com>
	<662a826dbeeff_b6e02943c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	<20240425182605.00005f22@Huawei.com>
	<662aae2fe4887_a96f294bf@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	<20240426094550.00002e37@Huawei.com>
	<662bd36caae55_a96f2943f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	<20240426175341.00002e67@Huawei.com>
	<6351024b5d6206c4e9a8cd98d1a09d43@mail.gmail.com>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 26 Apr 2024 14:25:29 -0500
Harold Johnson <harold.johnson@broadcom.com> wrote:

> Perhaps a bit more color on a few specifics might be helpful.
> 
> I think that there will always be a class of vendor specific APIs/Opcodes
> that are related to an implementation of a standard instead of the
> standard itself.  I've been party to discussion on not creating CXL
> defined API/Opcodes that get into the realm of specifying an
> implementation.  There are also a class of data that can be collected from
> a specific implementation that is helpful for debug, for health
> monitoring, and perhaps performance monitoring where the implementation
> matters and therefore are not easily abstracted to a standard.

Hi Harold,

Let's divert into a few specifics to give some routes to implementing these.
Some of them are extensions of things already well handled.  Tweaks
and extensions in the 'spirit' of the existing spec are both places where
adding some richness to the spec is probably not too difficult and where
there may be some flexibility.

In some cases the definitions in the specification almost certainly
came after your design.

> 
> A few examples:
> a) Temperature monitoring of a component or internal chip die
> temperatures.  Could CXL define a standard OpCode to gather temperatures,
> yes it could; but is this really part of CXL?  Then how many temperature
> elements and what does each element mean?  This enters into the
> implementation and therefore is vendor specific.  Unless the CXL spec
> starts to define the implementation, something along the lines of "thou
> shall have an average die temperature, rather than specific temperatures
> across a die", etc.

There is a general temperature monitoring and trip thresholds etc in the
spec via get Health Info and event logs. That covers a single value,
so not as extensive as what you refer to but it's a start. Whilst you
are right that the specification should not mandate N temperatures in
specific locations, it would be a reasonable request to allow for a
wider set of monitors with some level of description.  The intent
being that generic software can discover what is there and present
that info for logging / monitoring.
Whilst the exact meaning will vary by device, some broad scoping is
easy enough (memory controller vs various FRUs perhaps) and that is useful
to providing generic users space software.  hmwon has long handled this
sort of data from whole systems where very similar aspects of 'what does
this monitor actually mean' apply.  Sometimes that does need device
specific mapping files - so there is precedence that may be helpful here.

> 
> b) Error counters, metrics, internal counters, etc.  Could CXL define a
> set of common error counters, absolutely.  PCIe has done some of this.
> However, a specific implementation may have counters and error reporting
> that are meaningful only to a specific design and a specific
> implementation rather than a "least common denominator" approach of a
> standard body.
> 
> c) Performance counters, metric, indicators, etc.  Performance can be very
> implementation specific and tweaking performance is likely to be
> implementation specific.  Yes, generic and a least common denominator
> elements could be created, but are likely to limiting in realizing the
> maximum performance of an implementation.
These two are somewhat related.

This selection falls into two broad categories.
- Opaque logging and reporting needed just for debug.  There are patches
  on list for Vendor Debug Log.  They haven't merged yet though I think,
  so good to get your input on that series.  Intent of that feature is
  opaque logs.  There will never be a useful general tool for that stuff,
  conversely no general userspace tools will use them as a result.
  It's likely vendor engineer only territory.

- Counters that useful at runtime.
  The CXL PMU spec is rich and flexible. In common with CPU PMUs the perf driver
  allows for direct specification of events to count. The same issue with
  implementation specific counters occurs in CPUs.  Whilst you can keep
  the meaning of events opaque, if you do you loose out on useable general
  purpose software (e.g. perftool).  Alternatively some of this can be
  pushed into perf tool description files. 
  The advantage of pushing counters in to the main specification is that
  they work out of the box as the CPMU driver will report those directly
  (no need for perf tool to work with raw event codes).
  At the moment that driver implements part of the CPMU spec. If there are
  features you need (free running counters come to mind) then shout
  / patches welcome.  We decided to play wait and see with the CPMU driver as
  it wasn't clear if the full flexibility was needed for real devices.

> 
> d) Logs, errors and debug information.  In addition to spec defined
> logging of CXL topology errors, specific designs will have logs, crash
> dumps, debug data that is very specific to a implementation.  There are
> likely to be cases where a product that conforms to a specification like
> CXL, may have features that don't directly have anything to do with CXL,
> but where a standards based management interface can be used to configure,
> manage, and collect data for a non-CXL feature.

There are standard interfaces defined for some of this stuff as well.
Last I checked the discussion revolved around component state dump
only being safe to use if the background command abort was supported,
as that was needed to ensure the kernel was not locked out for an indefinite
amount of time.

If you are looking at other standards being run to configure CXL devices
excellent, but those standards should be accessed using whatever the
appropriate kernel interfaces.  Could you give some examples for this one?

> 
> e) Innovation.  I believe that innovation should be encouraged.  There may
> be designs that support CXL, but that also incorporate unique and
> innovative features or functions that might service a niche market.  The
> AI space is ripe for innovation and perhaps specialized features that may
> not make sense for the overall CXL specification.

Agreed - but those may need specific drivers.

> 
> I think that in most cases Vendor specific opcodes are not used to
> circumvent the standards, but are used when the standards group has no
> interested in driving into the standard certain features that are clearly
> either implementation specific or are vendor specific additions that have
> a specific appeal to a select class of customer, but yet are not relevant
> to a specific standard.
> 
> At the end of the day, customer want products that solve a specific
> problem.  Sometimes vendor can address market segments or niches that a
> standard group has no interest in supporting.  It can also take months,
> and in some cases years to reach an agreement on what standardized feature
> should look like.  I also believe that there can be competitive reasons
> why there might be a group that wants to slow down a vendor's
> implementation for fear of losing market share.

Whilst I appreciate the way this can slow down adoption / kernel support
it's a path that is still worth it in the end.

As Dan and others have put it, there are other routes than the main
CXL standard. Those should allow tighter collaboration on smaller topics
to define common standards.

Thanks,

Jonathan


> 
> Thanks
> Harold Johnson
> 
> 
> -----Original Message-----
> From: Jonathan Cameron [mailto:Jonathan.Cameron@Huawei.com]
> Sent: Friday, April 26, 2024 11:54 AM
> To: Dan Williams
> Cc: linux-cxl@vger.kernel.org; Sreenivas Bagalkote; Brett Henning; Harold
> Johnson; Sumanesh Samanta; linux-kernel@vger.kernel.org; Davidlohr Bueso;
> Dave Jiang; Alison Schofield; Vishal Verma; Ira Weiny;
> linuxarm@huawei.com; linux-api@vger.kernel.org; Lorenzo Pieralisi; Natu,
> Mahesh; gregkh@linuxfoundation.org
> Subject: Re: RFC: Restricting userspace interfaces for CXL fabric
> management
> 
> On Fri, 26 Apr 2024 09:16:44 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Jonathan Cameron wrote:
> > [..]  
> > > To give people an incentive to play the standards game we have to
> > > provide an alternative.  Userspace libraries will provide some  
> incentive
> > > to standardize if we have enough vendors (we don't today - so they  
> will
> > > do their own libraries), but it is a lot easier to encourage if we
> > > exercise control over the interface.  
> >
> > Yes, and I expect you and I are not far off on what can be done
> > here.
> >
> > However, lets cut to a sentiment hanging over this discussion. Referring
> > to vendor specific commands:
> >
> >     "CXL spec has them for a reason and they need to be supported."
> >
> > ...that is an aggressive "vendor specific first" sentiment that
> > generates an aggressive "userspace drivers" reaction, because the best
> > way to get around community discussions about what ABI makes sense is
> > userspace drivers.
> >
> > Now, if we can step back to where this discussion started, where typical
> > Linux collaboration shines, and where I think you and I are more aligned
> > than this thread would indicate, is "vendor specific last". Lets
> > carefully consider the vendor specific commands that are candidates to
> > be de facto cross vendor semantics if not de jure standards.
> >  
> 
> Agreed. I'd go a little further and say I generally have much more warm
> and
> fuzzy feelings when what is a vendor defined command (today) maps to more
> or less the same bit of code for a proposed standards ECN.
> 
> IP rules prevent us commenting on specific proposals, but there will be
> things we review quicker and with a lighter touch vs others where we
> ask lots of annoying questions about generality of the feature etc.
> Given the effort we are putting in on the kernel side we all want CXL
> to succeed and will do our best to encourage activities that make that
> more likely. There are other standards bodies available... which may
> make more sense for some features.
> 
> Command interfaces are not a good place to compete and maintain secrecy.
> If vendors want to do that, then they don't get the pony of upstream
> support. They get to convince distros to do a custom kernel build for
> them:
> Good luck with that, some of those folk are 'blunt' in their responses to
> such requests.
> 
> My proposal is we go forward with a bunch of the CXL spec defined commands
> to show the 'how' and consider specific proposals for upstream support
> of vendor defined commands on a case by case basis (so pretty much
> what you say above). Maybe after a few are done we can formalize some
> rules of thumb help vendors makes such proposals, though maybe some
> will figure out it is a better and longer term solution to do 'standards
> first development'.
> 
> I think we do need to look at the safety filtering of tunneled
> commands but don't see that as a particularly tricky addition -
> for the simple non destructive commands at least.
> 
> Jonathan
> 


