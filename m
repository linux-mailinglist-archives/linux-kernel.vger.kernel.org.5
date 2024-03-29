Return-Path: <linux-kernel+bounces-125188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E5E8921EB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 490501F254CA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607214D110;
	Fri, 29 Mar 2024 16:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZPV+4gn/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317B92562E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 16:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711730788; cv=none; b=KQJAbC6gMhRdnA39k9Dp0hORh20jCfGDXdF3bYnbhtXHp8rJ5gtHKvmiGnGG4csI8jM0M8VqKTBoKmYcEBgD0Y6B3NUso1M9A9vvhWiIZ9tpQVA5PnGa1ZKrrWz4aq+pneyDDYSsFUfnZZFkC5Ml0SAsdZwLPdR915V6lyJkUr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711730788; c=relaxed/simple;
	bh=9J9/SVQoxobDsgFffjqeuaYTm5tfTP8Boo3RqpviRwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfHKLa07FZEHpGvmXzjcycu9WvZZe1Zhmi3Kb9Gd78S/AwdiPwtgq+zeQtuYrBzgI6/wLV8kY6SjitzVhKh2TP0eK41Pvw4evRjZJEvP2pu5Y4fIxFGZ5eXZWXUILtMm1bKRn7lKH1EeRd6IbDWN0KkJ0aEos0lxGfZKCHEuQTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZPV+4gn/; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711730787; x=1743266787;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9J9/SVQoxobDsgFffjqeuaYTm5tfTP8Boo3RqpviRwc=;
  b=ZPV+4gn/ZfoMuQEeC3jjoKYsAhtg5NTIRic4qQIoj5dfuoE3F+XnZoPQ
   y9r3lxh5kCwFRKXtb1hg3OKeE5Wv6SzddpP4wMIhjbNMLHOjqrQ0je1/6
   syQ1gZT7hxM8v/O/NpAG29zI4bb7tEndDr+3a4JkqIc6TU3R4IxVx94CF
   HRIAuWxdFHtT72vUOCE8MU2FqevBpNJZI8XNL64zXSjxUhXmbvFE1SWrb
   hi27Z2Rjcs0DdPFHKEx/RblcttxvYPRB6y2Uz+G/Xq51oySXpV57WbgJD
   Joh0xJHQoalaNHFwmOIp8hAdwZehWiIKv/y29d+dDFIeAb6XyMYvct4QP
   w==;
X-CSE-ConnectionGUID: WlHTzRu2SPipae7NpORK7Q==
X-CSE-MsgGUID: L4cfAz5KRUyrDK+Vu9d+NQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="10707776"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="10707776"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 09:46:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="17062236"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.105])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 09:46:26 -0700
Date: Fri, 29 Mar 2024 09:46:25 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/74] x86/cpu/vfm: Add/initialize x86_vfm field to
 struct cpuinfo_x86
Message-ID: <ZgbwYb3D3tBtXZ8y@agluck-desk3>
References: <20240328163746.243023-1-tony.luck@intel.com>
 <20240328163746.243023-2-tony.luck@intel.com>
 <20240328164811.GDZgWfSzAWZXO7dUky@fat_crate.local>
 <20240328165251.GEZgWgY1Clb9z4t3VX@fat_crate.local>
 <SJ1PR11MB6083AADC97E50462C1137D71FC3B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240328171204.GGZgWk5JNOzQzoaEql@fat_crate.local>
 <SJ1PR11MB6083D8BB65748452B204ED8AFC3B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240329114007.GAZgaolwSFtjHStiuL@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329114007.GAZgaolwSFtjHStiuL@fat_crate.local>

On Fri, Mar 29, 2024 at 12:40:07PM +0100, Borislav Petkov wrote:
> On Thu, Mar 28, 2024 at 06:32:35PM +0000, Luck, Tony wrote:
> > I don't think the format is really that big an issue. Including stepping in the
> > format adds complexity to a thousand places these checks are made while
> > only being useful in a few dozen.
> 
> I've figured out what the problem is with steppings - ranges. If you
> have a range of steppings which all belong to the same model, then you
> have to complicate the checks by either masking out the stepping or use
> the X86_STEPPING_ANY thing which forces you to use x86_match_cpu()
> instead of a simple integer comparison.

I think you are talking about a range of models that all belong to
the same family (rather than steppings in the same model).

> And you should talk to your folks what their plan is for the new
> families because if they do a range of model numbers which all belong to
> the same CPU model like AMD does, then your simple comparison scheme
> goes out the window because it can't really deal with ranges.

History of Intel model number allocations apparently looks like
we just throw a dart in the general area of a block of unused
model numbers :-)  I will check with the relevent folks, but this
seems unlikely. There's more push (from the Linux community!) to
assign CPUID feature bits for stuff that goes more than 2-3
CPU generations. That leaves the stuff that is different almost
every time (perfomaance counters, power management, EDAC, etc.).

> Because from looking at your set, I don't see a slick way to check
> whether a concrete f/m/s tuple belongs to a range without involved
> checking.
> 
> For example, models:
> 
>                 case 0x30 ... 0x4f:
>                 case 0x60 ... 0x7f:
>                 case 0x90 ... 0x91:
>                 case 0xa0 ... 0xaf:
> 
> are all Zen2. I could do a X86_MATCH_VF_MODEL_RANGE and we even had

I'm glad I don't have to keep track of groups of hex numbers like that.

> a patch like that at some point but it didn't go in. But even if I did
> that, I'd still need to do x86_match_cpu() instead of the current
> X86_FEATURE_ZEN* checks we're doing.

My patch doesn't help with this, but doesn't prevent you from doing
a switch (c->x86_model).  If that list of model number ranges shows
up more than twice you could add a helper that converts that list to
a #define AMD_ZEN2 to make the code clearer.

> So I don't think I can switch AMD to use that. It looks like the 'V' in
> "VFM" could just as well turn into "I".

Patch 3 includes:

#define IFM(_fam, _model)      VFM_MAKE(X86_VENDOR_INTEL, _fam, _model)

as a helper to build model numbers in <asm/intel-family.h>
> 
> :-)
> 
> I'd say.

So keep the "V" in the common code. Maybe one of the other x86
vendors will want to have #define names for their CPU models
some day.

Thanks for digging into this.

-Tony

