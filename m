Return-Path: <linux-kernel+bounces-143041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D29DE8A3383
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 012291C20FC1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F1C149DF7;
	Fri, 12 Apr 2024 16:16:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BAC14882F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 16:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938608; cv=none; b=FVLpbP3icqSUqPvWuXuHAQ+dQKRw4cMAd7h13mb7D1i4QYRPwd29N/8Cl49TiPHdk8RmEgqpBbFzzPrrxaoMivhLh7Y3SOup/ttn8Wz1xyQ/c8UC8qxJouzM3iMgOM59PoTZTIIvJObQhdiXhvPqRU+o2/TEPRwn7exP9Io9MpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938608; c=relaxed/simple;
	bh=iT8fIFzg5vFMvUBl82Bb1L7n2kIu+6n9K237w+bQp8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAmdXS42LT/hvi55u5uxt04jHVqkZXiumOh70ffjJP3CFCfL7NerFzpKuIpr7bVaLOX852YzMeJUYNdtnEtfqzQI+V0vx3whPKcfhVID8qUnu/HfkVnFsR7tJvXYKq3qbtaveOEQPJ3Xj+3QU8hkWEQL2kANqy/ZhAtkUhwQJ1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4F4D339;
	Fri, 12 Apr 2024 09:17:13 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACECF3F64C;
	Fri, 12 Apr 2024 09:16:41 -0700 (PDT)
Date: Fri, 12 Apr 2024 17:16:39 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: James Morse <james.morse@arm.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com, lcherian@marvell.com,
	bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
	dfustini@baylibre.com, amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: Re: [PATCH v1 03/31] x86/resctrl: Move ctrlval string parsing policy
 away from the arch code
Message-ID: <ZhleZ2q60ysIRapv@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-4-james.morse@arm.com>
 <e85e7786-7995-42d5-a5ac-1e08a84492fe@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e85e7786-7995-42d5-a5ac-1e08a84492fe@intel.com>

On Mon, Apr 08, 2024 at 08:14:47PM -0700, Reinette Chatre wrote:
> Hi James,
> 
> On 3/21/2024 9:50 AM, James Morse wrote:
> > The policy for parsing the configuration values as a string from
> > user-space is specified by a function pointer the arch code specifies.
> > 
> > These strings are part of resctrl's ABI, and the functions and their
> > caller both live in the same file. Exporting the parsing functions and
> > allowing the architecture to choose how a schema is parsed allows an
> > architecture to get this wrong.
> > 
> > Keep this all in the flesystem parts of resctrl. This should prevent any
> 
> flesystem -> filesystem

Noted, thanks.


> > architecture's string-parsing behaviour from varying without core code
> > changes. Use the fflags to spot caches and bandwidth resources, and use
> > the appropriate helper.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > ---
> 
> ..
> 
> > @@ -195,6 +204,14 @@ int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
> >  	return 0;
> >  }
> >  
> > +static ctrlval_parser_t *get_parser(struct rdt_resource *res)
> > +{
> > +	if (res->fflags & RFTYPE_RES_CACHE)
> > +		return &parse_cbm;
> > +	else
> > +		return &parse_bw;
> > +}
> 
> This is borderline ... at minimum it expands what fflags means and how it
> is intended to be used and that needs to be documented because it reads:
> 
> 	* @fflags:		flags to choose base and info files
> 
> I am curious why you picked fflags instead of an explicit check against
> rid?
> 
> Reinette

Is fflags already somewhat overloaded?  There seem to be a mix of things
that are independent Boolean flags, while other things seem mutually
exclusive or enum-like.

Do we expect RFTYPE_RES_CACHE | RFTYPE_RES_MB ever to make sense,
as David points out?


With MPAM, we could in theory have cache population control and egress
memory bandwidth controls on a single interconnect component.

If that would always be represented through resctrl as two components
with the MB controls considered one level out from the CACHE controls,
then I guess these control types remain mutually exclusive from
resctrl's point of view.

Allowing a single rdt_resource to sprout multiple control types looks
more invasive in the code, even if it logically makes sense in terms of
the hardware.

(I'm guessing that may have already been ruled out?  Apologies if I
seem to be questioning things that were decided already.  That's not
my intention, and James will already have thought about this in any
case...)


Anyway, for this patch, there seem to be a couple of assumptions:

a) get_parser() doesn't get called except for rdt_resources that
represent resource controls (so, fflags = RFTYPE_RES_foo for some "foo",
with no other flags set), and

b) there are exactly two kinds of "foo", so whatever isn't a CACHE is
a BW.

These assumptions seem to hold today (?)

But the semantics of fflags already look a bit complicated, so I can
see why it might be best to avoid anything that may add more
complexity.


If the main aim is to avoid silly copy-paste errors when coding up
resources for a new arch, would it make sense to go for a more low-
tech approach and just bundle up related fields in a macro?

E.g., something like:

#define RDT_RESOURCE_MB_DEFAULTS		\
	.format_str	= "%d=%*u",		\
	.fflags		= RFTYPE_RES_MB,	\
	.parse_ctrlval	= parse_bw

#define RDT_RESOURCE_CACHE_DEFAULTS		\
	.format_str	= "%d=%0*x",		\
	.fflags		= RFTYPE_RES_CACHE,	\
	.parse_ctrlval	= parse_cbm

This isn't particularly pretty, but would at least help avoid accidents
and reduce the amount of explicit boilerplate in the resource
definitions.

Thoughts?

Cheers
---Dave

