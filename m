Return-Path: <linux-kernel+bounces-47252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227F8844B00
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55E3C1C2291F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D45E3FB2D;
	Wed, 31 Jan 2024 22:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QVvgUAvK"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D563B3BB29
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 22:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706739613; cv=none; b=VtXjLZ3cW2apY+aWLWIES7Xu+p22s4M7T7IlbcdP6eLyfSjH/t/JY838NXQuhZetO9ViTo9yUe/YqoBzM3qxFChWu+57xojCwKFhOTASU+2BGA4YcuUWhJZW10+GwKIzQvxy2L0PAIOByjF0hfxwOAotWBEU7+Jpl9u1SQBDHhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706739613; c=relaxed/simple;
	bh=Znshv+RH0oLXtMaY0APjfhexQmz7CI7Km/3plXspJn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKHqOO8wdtOl7+Sg955JMt0tqmfYt9+pgzr9Df0faK++sIZEFnuOsNakJOX6s93hRVJuVXDzadhFf3+V135i6d0zerU/eby83Ae08IFj2u/si8659qZNwpRkbabO82F0tSaVx7IeM/0iAEEitqu6qRdDhPtnMtDwQYXe/1SWEZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QVvgUAvK; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706739611; x=1738275611;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Znshv+RH0oLXtMaY0APjfhexQmz7CI7Km/3plXspJn8=;
  b=QVvgUAvKmIfwdFYX3AmeRR1bURlwpQDJtAo1abnkDjukMrSDR594lQUv
   kRxZll+Nf53g9p2utkoXFTu0+R+ei94cd99c45iY1YO7is02KBHieHem8
   jXLNSmUR7oUcuhs1X24U7G6n1AZlQM8tQG030IrS9dBcu2WfpUQ5QgwLb
   vsbwnIi6UNpsQxmVVrqTfbTQ9u4/OSGdpsGRyJfEx6/HlbGxeAelvr22/
   M9qXSZyanALZaNOvi5HMCEooUQgL/Gr+VGuqXNQzd8ZlOCqLX9e1Tz7lP
   X3SALlnrn7wIU4pkdQbfgTL9fNWyYWejulCUfPzd00bHrKGanQ1XRJ0PW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="434910651"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="434910651"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 14:20:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="788739786"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="788739786"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 31 Jan 2024 14:20:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 3331639B; Thu,  1 Feb 2024 00:17:32 +0200 (EET)
Date: Thu, 1 Feb 2024 00:17:32 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH, RESEND] x86/pat: Simplifying the PAT programming protocol
Message-ID: <fvzki5mtpbsoyljy354qnva5rllgukba7iuxufxjttceio5osd@tdvgddwttfqo>
References: <20240124130650.496056-1-kirill.shutemov@linux.intel.com>
 <20240131175738.GIZbqKEhlDKhaKfh_w@fat_crate.local>
 <67hqgqargmt6nln5mds672g263lka7glyzbvcdgt4owdg7xc2e@v6wvuizw5ond>
 <20240131202340.GLZbqsTJkeFQycXT0B@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131202340.GLZbqsTJkeFQycXT0B@fat_crate.local>

On Wed, Jan 31, 2024 at 09:23:40PM +0100, Borislav Petkov wrote:
> On Wed, Jan 31, 2024 at 08:52:46PM +0200, Kirill A. Shutemov wrote:
> > The second step is relevant for set_memory code that already does the
> > flushing on changing memory type.
> 
> So the "relaxation" is the removal of that CR0.CD requirement?

And double WBINVD if the machine has no X86_FEATURE_SELFSNOOP (before and
after TLB flush).

> > Our HW folks confirmed that the new optimized sequence works on all past
> > processors that support PAT.
> 
> Your folks confirmed that for all released hw and for x86 hardware from
> other vendors?

No. They can only talk for Intel CPUs. But AMD docs don't require MTTR
flow to begin with.

It is better to double-check on AMD side.

> > Testing wouldn't hurt, but it cannot possibly prove that the new flow is
> > safe by testing.
> 
> This basically says that I should not take this patch at all as there's
> no way of even testing it?!
> 
> I hope I'm misunderstanding you.

Testing can prove that the proposed patch is broken if a problem show ups.
But if you found no issue during testing you cannot say that the patch is
safe. You could just get lucky and don't hit pathological scenario with
broken cache/TLB aliases or something.

It is better to get confirmation from HW folks.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

