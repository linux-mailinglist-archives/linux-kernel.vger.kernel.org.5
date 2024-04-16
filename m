Return-Path: <linux-kernel+bounces-147213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D758A710E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 937621C21E18
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6532C130492;
	Tue, 16 Apr 2024 16:16:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4847A1E876
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713284171; cv=none; b=gqDDQ9rh5QclRGIRCOAoX3IG2Lqa06kKBc1MuHPMa2hOOCchK9o57Is4EDKAxi5tnrx1mazYMVw3hBEu4F1+mjgblGjcirnzYeXlP5s7aCGcrvBDypi8gFRpO72dg1pN7oIM3SY00sau3tHcL1Hzsh8/kxZ7nlQ3QsnR7ZnAQsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713284171; c=relaxed/simple;
	bh=tmcmVLBCHmfUrKUkAV6fbdi3UWGWorkgyZg1eThRIK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpjyOBefs5OFa+wT3AN71DaNYZK/Kj/54gP0bO2xD6z0HnU4tvarP9UXg9+KiDHtuyuCy1AbmmJcC3wxlgMVua3UrscFPvXv5f69f/HloTb1B53eO7Ne6zp4BGJmSL2QBeLYG1/C4eUSt8ZCxP7EMywfqYLBfm8qM6ZY9FfmaOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79FA0339;
	Tue, 16 Apr 2024 09:16:37 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8570A3F792;
	Tue, 16 Apr 2024 09:16:06 -0700 (PDT)
Date: Tue, 16 Apr 2024 17:16:04 +0100
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
Message-ID: <Zh6kRMkqVpu0Km4l@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-4-james.morse@arm.com>
 <e85e7786-7995-42d5-a5ac-1e08a84492fe@intel.com>
 <ZhleZ2q60ysIRapv@e133380.arm.com>
 <9daa5c12-c43d-4069-b2a6-c505217e2387@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9daa5c12-c43d-4069-b2a6-c505217e2387@intel.com>

On Mon, Apr 15, 2024 at 10:44:34AM -0700, Reinette Chatre wrote:
> Hi Dave,
> 
> On 4/12/2024 9:16 AM, Dave Martin wrote:
> > On Mon, Apr 08, 2024 at 08:14:47PM -0700, Reinette Chatre wrote:
> >> On 3/21/2024 9:50 AM, James Morse wrote:
> 
> >>> @@ -195,6 +204,14 @@ int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
> >>>  	return 0;
> >>>  }
> >>>  
> >>> +static ctrlval_parser_t *get_parser(struct rdt_resource *res)
> >>> +{
> >>> +	if (res->fflags & RFTYPE_RES_CACHE)
> >>> +		return &parse_cbm;
> >>> +	else
> >>> +		return &parse_bw;
> >>> +}
> >>
> >> This is borderline ... at minimum it expands what fflags means and how it
> >> is intended to be used and that needs to be documented because it reads:
> >>
> >> 	* @fflags:		flags to choose base and info files
> >>
> >> I am curious why you picked fflags instead of an explicit check against
> >> rid?
> >>
> >> Reinette
> > 
> > Is fflags already somewhat overloaded?  There seem to be a mix of things
> > that are independent Boolean flags, while other things seem mutually
> > exclusive or enum-like.
> > 
> > Do we expect RFTYPE_RES_CACHE | RFTYPE_RES_MB ever to make sense,
> > as David points out?
> > 
> > 
> > With MPAM, we could in theory have cache population control and egress
> > memory bandwidth controls on a single interconnect component.
> > 
> > If that would always be represented through resctrl as two components
> > with the MB controls considered one level out from the CACHE controls,
> > then I guess these control types remain mutually exclusive from
> > resctrl's point of view.
> > 
> > Allowing a single rdt_resource to sprout multiple control types looks
> > more invasive in the code, even if it logically makes sense in terms of
> > the hardware.
> > 
> > (I'm guessing that may have already been ruled out?  Apologies if I
> > seem to be questioning things that were decided already.  That's not
> > my intention, and James will already have thought about this in any
> > case...)
> > 
> > 
> > Anyway, for this patch, there seem to be a couple of assumptions:
> > 
> > a) get_parser() doesn't get called except for rdt_resources that
> > represent resource controls (so, fflags = RFTYPE_RES_foo for some "foo",
> > with no other flags set), and
> > 
> > b) there are exactly two kinds of "foo", so whatever isn't a CACHE is
> > a BW.
> > 
> > These assumptions seem to hold today (?)
> 
> (c) the parser for user provided data is based on the resource type.
> 
> As I understand (c) may not be true for MPAM that supports different
> partitioning controls for a single resource. For example, for a cache
> MPAM supports portion as well as maximum capacity controls that
> I expect would need different parsers (perhaps mapping to different
> schemata entries?) from user space but will be used to control the
> same resource.
> 
> I do now know if the goal is to support this MPAM capability via
> resctrl but do accomplish this I wonder if it may not be more appropriate
> to associate the parser with the schema entry that is presented to user space.
> 
> > But the semantics of fflags already look a bit complicated, so I can
> > see why it might be best to avoid anything that may add more
> > complexity.
> 
> ack.
> 
> > If the main aim is to avoid silly copy-paste errors when coding up
> > resources for a new arch, would it make sense to go for a more low-
> > tech approach and just bundle up related fields in a macro?
> 
> I understand this as more than avoiding copy-paste errors. I understand
> the goal is to prevent architectures from having architecture specific
> parsers.
> 
> > 
> > E.g., something like:
> > 
> > #define RDT_RESOURCE_MB_DEFAULTS		\
> > 	.format_str	= "%d=%*u",		\
> > 	.fflags		= RFTYPE_RES_MB,	\
> > 	.parse_ctrlval	= parse_bw
> > 
> > #define RDT_RESOURCE_CACHE_DEFAULTS		\
> > 	.format_str	= "%d=%0*x",		\
> > 	.fflags		= RFTYPE_RES_CACHE,	\
> > 	.parse_ctrlval	= parse_cbm
> > 
> > This isn't particularly pretty, but would at least help avoid accidents
> > and reduce the amount of explicit boilerplate in the resource
> > definitions.
> > 
> > Thoughts?
> 
> I understand the goal of this patch to make the parser something that
> the fs code owns. This is done in support of a consistent user interface.
> It is not clear how turning this into macros prevents arch code from
> still overriding the parser.
> 
> You do highlight another point though, shouldn't the fs code own the
> format_str also? I do not think we want arch code to control the
> print format, this is also something that should be consistent between
> all archs and owned by fs code, again perhaps more appropriate for
> a schema entry.
> 
> Reinette

Fair points, I guess.

For the print format, I was presuming that this ought to be consistent
with the parse format, so probably a core property too (until/unless
someone comes up with a convincing counterexample).


Would something like the following make sense, if you want a less
informal approach?  (Modulo minor details like naming conventions etc.)


/* In fs/resctrl.c */

struct struct resctrl_ctrl_traits {
	const char		*format_str;
	ctrlval_parser_t	*parse_ctrlval;
};

static const struct resctrl_ctrl_traits resource_traits[]  = {
	[RESTYPE_INVALID] = {},
	[RESTYPE_MB] = {
		.format_str	= "%d=%*u",
		.parse_ctrlval	= parse_bw,
	},
	[RESTYPE_CACHE] = {
		.format_str	= "%d=%0*x",
		.parse_ctrlval	= parse_cbm,
	},
};

static bool is_resource(const struct rdt_resource *r)
{
	return r->fflags & RFTYPE_RES;
}


/* In include/linux/resctrl_types.h */

+#define RFTYPE_RES			BIT(8)
-#define RFTYPE_RES_CACHE		BIT(8)
-#define RFTYPE_RES_MB			BIT(9)

/* For RFTYPE_RES: */
enum resctrl_resource_type {
	RRESTYPE_INVALID,
	RRESTYPE_MB,
	RRESTYPE_CACHE,
};

/* In include/linux/resctrl.h */

struct rdt_resource {
/* ... */

-	const char			*format_str;
+	enum resctrl_resource_type	res_type;

/* ... */
};


(RRESTYPE_INVALID would just be there to catch cases where .res_type is
not assigned.)


James might also have other thoughts about this when he gets back...

In any case, it might make sense to detach this change from this series
if we're making more significant changes in this area than just
splitting the code into core and arch parts.

(Note also, your suggestion about indexing using rid may also work;
I tend to assume that the mapping from rid to resource types may not be
fixed, but maybe I'm being too strongly influenced by MPAM...)

Cheers
---Dave

