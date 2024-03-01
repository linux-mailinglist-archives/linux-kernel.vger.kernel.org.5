Return-Path: <linux-kernel+bounces-88460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C98986E1E9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D66551F213DD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED636CDD6;
	Fri,  1 Mar 2024 13:19:42 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D2B10E9;
	Fri,  1 Mar 2024 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709299181; cv=none; b=OHECKY5GnCyV0HhrMy5LP5HBioaIVeZh5xYb7K2qWWyW7sPuPblxGzV/5mqb12b6smUScCgbAVZdnUseQ1LRTzP1NcKzMqSROW0EMxH1TawXGZ758T97sFGr5ly2F1bZahSQ/lUop0ZB5pknOSj9CdI76jGulV7XATSYJoLLlpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709299181; c=relaxed/simple;
	bh=HGAOZ9rzwRj4KaggpswQDdIDQnkCzfQ+ozJfEoUzsGo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K+CUGb3kbwNzlMx06J5JGKOfS3RKUBjVDdCVgk9j0ngx/v5Ydsoe7PrTprpznE0l3McPgwgJbEVOC7tGgyP6QmV5pLgdVmU6xa4wBi79pvQU54H1MTrCKsS0nbwp5seN4B41+wugdEk4fDrg4grgtCmhNlD30tM1Q3ewOmxZvJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TmT8S1fYbz6JB7j;
	Fri,  1 Mar 2024 21:14:48 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 482BB140B73;
	Fri,  1 Mar 2024 21:19:33 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 1 Mar
 2024 13:19:32 +0000
Date: Fri, 1 Mar 2024 13:19:31 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Tony Luck <tony.luck@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Shiju Jose
	<shiju.jose@huawei.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"david@redhat.com" <david@redhat.com>, "Vilas.Sridharan@amd.com"
	<Vilas.Sridharan@amd.com>, "leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "rientjes@google.com"
	<rientjes@google.com>, "jiaqiyan@google.com" <jiaqiyan@google.com>,
	"Jon.Grimm@amd.com" <Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "naoya.horiguchi@nec.com"
	<naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
	<somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
	<duenwen@google.com>, "mike.malvestuto@intel.com"
	<mike.malvestuto@intel.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>, wanghuiqiang
	<wanghuiqiang@huawei.com>, Linuxarm <linuxarm@huawei.com>, John Groves
	<John@Groves.net>
Subject: Re: [RFC PATCH v6 00/12] cxl: Add support for CXL feature commands,
 CXL device patrol scrub control and DDR5 ECS control features
Message-ID: <20240301131931.000070c7@Huawei.com>
In-Reply-To: <ZeDsESXK5pMeialz@agluck-desk3>
References: <20240215111455.1462-1-shiju.jose@huawei.com>
	<65d6936952764_1138c7294e@dwillia2-xfh.jf.intel.com.notmuch>
	<54c55412e9374e4e9cacf8410a5a98cb@huawei.com>
	<65d8f5201f8cc_2509b29467@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	<20240226102944.000070a3@Huawei.com>
	<ZeDsESXK5pMeialz@agluck-desk3>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 29 Feb 2024 12:41:53 -0800
Tony Luck <tony.luck@intel.com> wrote:

> > Obviously can't talk about who was involved in this feature
> > in it's definition, but I have strong confidence it will get implemented
> > for reasons I can point at on a public list. 
> > a) There will be scrubbing on devices.
> > b) It will need control (evidence for this is the BIOS controls mentioned below
> >    for equivalent main memory).
> > c) Hotplug means that control must be done by OS driver (or via very fiddly
> >    pre hotplug hacks that I think we can all agree should not be necessary
> >    and aren't even an option on all platforms)
> > d) No one likes custom solutions.
> > This isn't a fancy feature with a high level of complexity which helps.  

Hi Tony,
> 
> But how will users know what are appropriate scrubbing
> parameters for these devices?
> 
> Car analogy: Fuel injection systems on internal combustion engines
> have tweakable controls. But no auto manufacturer wires them up to
> a user accessible dashboad control.

Good analogy - I believe performance tuning 3rd parties will change
them for you. So the controls are used - be it not by every user.

> 
> Back to computers:
> 
> I'd expect the OEMs that produce memory devices to set appropriate
> scrubbing rates based on their internal knowledge of the components
> used in construction.

Absolutely agree that they will set a default / baseline value,
but reality is that 'everyone' (for the first few OEMs I googled)
exposes tuning controls in their shipping BIOS menus to configure
this because there are users who want to change it.  I'd expect
them to clamp the minimum scrub frequency to something that avoids
them getting hardware returned on mass for reliability and the
maximum at whatever ensures the perf is good enough that they sell
hardware in the first place.  I'd also expect a bios menu to
allow cloud hosts etc to turn off exposing RAS2 or similar.

> 
> What is the use case where some user would need to override these
> parameters and scrub and a faster/slower rate than that set by the
> manufacturer?

Its a performance vs reliability trade off.  If your larger scale
architecture (many servers) requires a few nodes to be super stable you
will pay pretty much any cost to keep them running. If a single node
failure makes little or no difference, you'll happily crank this down
(same with refresh) in order to save some power / get a small
performance lift.  Or if you care about latency tails, more than
reliability you'll turn this off.

For comedy value, some BIOS guides point out that leaving scrub on may
affect performance benchmarking. Obviously not a good data point, but
a hint at the sort of market that cares.  Same market that buy cheaper
RAM knowing they are going to have more system crashes.

There is probably a description gap. That might be a paperwork
question as part of system specification.
What is relationship between scrub rate and error rate under particular
styles of workload (because you get a free scrub whenever you access
the memory)?  The RAM dimms themselves could in theory provide inputs
but the workload dependence makes this hard. Probably fallback on a
a test and tune loop over very long runs.  Single bit error rates
used to detect when getting below a level people are happy with for
instance.

With the fancier units that can be supported, you can play more reliable
memory games by scanning subsets of the memory more frequently.

Though it was about a kernel daemon doing scrub, Jiaqi's RFC document here
https://lore.kernel.org/all/20221103155029.2451105-1-jiaqiyan@google.com/
provided justification for on demand scrub - some interesting stuff in the
bit on hardware patrol scrubbing.  I see you commented on the thread
and complexity of hardware solutions.

- Cheap memory makes this all more important.
- Need for configuration of how fast and when depending on system state.
- Lack of flexibility of what is scanned (RAS2 provides some by association
  with NUMA node + option to request particular ranges, CXL provides per
  end point controls).

There are some gaps on hardware scrubbers, but offloading this problem
definitely attractive.

So my understanding is there is demand to tune this but it won't be exposed
on every system.

Jonathan

 
> 
> -Tony


