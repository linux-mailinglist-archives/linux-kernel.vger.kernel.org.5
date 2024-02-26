Return-Path: <linux-kernel+bounces-81447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB8D867617
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB3B81C286A1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A328063D;
	Mon, 26 Feb 2024 13:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iCrNU7Yv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9EA604BF
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 13:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708953015; cv=none; b=EB5I39w4EbhFpFaoVeZgUx0FWDt1RaG1TPHQZKv0/gWc8LNvlSP2wvFcl0oUCD3VZwEiQeZHETC2/R9Lie7nQDBgFcw9/4G7Ie0/Xu0fZNe8IPPAWSzNgSKhwCe3X33K4fndu3l4RiacPJArxgg1kIb8+sZW/f64uxWv1VDxPUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708953015; c=relaxed/simple;
	bh=IEntOfzJkMUOI5LibQULm5rlRuQbtScOfPwEQty/vnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHKCxE1jwDWfZ6P4iqdPRJDK3LoeVGSUzidtUZQUnHfXRq1wZpcTHA9AW5rbvHzA7R349XdioIcXyodRsaVOGZkrLf5WdJ8hZ+s4ZB0rrd7xYVQ9xxEKOHbgfhHaAzxao0i0C4zMcOYLiM6eXybX9JQBqljT02S4BTlfknlKNwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iCrNU7Yv; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708953014; x=1740489014;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IEntOfzJkMUOI5LibQULm5rlRuQbtScOfPwEQty/vnM=;
  b=iCrNU7Yvv8OuThnpSbL3u2XMDw4/rg58PZMPPvk+8Y6MVe40WCJIJPh/
   t5QlyLRp0QBbRAcNjgd+2JbRpX03vFFHaf6CSq/4H3Q+V90BHKUJHAnAr
   bfvuglLc0Z70BUedqmNwT/rYP+rAH/+xS7klwsNqhSdGlbcUlUTS0cNgc
   ziVb2Z7UdF9etZYNv91AeAuBNQU3PsdXmKQfZUEJ8t3MJNio7DIs5Tjcs
   64zLYeMWhGOKiK/jqJN4nJkX7RtmEXKcqJnVW9ve66u5xY7Xc+5LLS44a
   Z3Yi7qzvXSceaq3v53LzfiEM/lKxpcfcWaWxuoBNEbf3faml0IalOhrub
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3351329"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3351329"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 05:10:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="937029985"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="937029985"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Feb 2024 05:10:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 8E41B3C1; Mon, 26 Feb 2024 15:10:06 +0200 (EET)
Date: Mon, 26 Feb 2024 15:10:06 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7 10/16] x86/tdx: Convert shared memory back to private
 on kexec
Message-ID: <6rbvgzd7l5nw3hjxyup5cm2d3dl7cmkqmmq4zdgzlcp544o4pj@ykyquc6u5glc>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-11-kirill.shutemov@linux.intel.com>
 <a14bda4a-15ad-4d20-8b60-0ab92b608f2f@intel.com>
 <3nqc34o54ydpdvo6j7a5hltyjs6kkw5jy5i6dgvivg7f4hzec2@l6jetcopnm6k>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3nqc34o54ydpdvo6j7a5hltyjs6kkw5jy5i6dgvivg7f4hzec2@l6jetcopnm6k>

On Sun, Feb 25, 2024 at 04:58:46PM +0200, Kirill A. Shutemov wrote:
> On Fri, Feb 23, 2024 at 11:39:07AM -0800, Dave Hansen wrote:
> > On 2/12/24 02:44, Kirill A. Shutemov wrote:
> > > +static void tdx_kexec_stop_conversion(bool crash)
> > > +{
> > > +	/* Stop new private<->shared conversions */
> > > +	conversion_allowed = false;
> > > +
> > > +	/*
> > > +	 * Make sure conversion_allowed is cleared before checking
> > > +	 * conversions_in_progress.
> > > +	 */
> > > +	barrier();
> > > +
> > > +	/*
> > > +	 * Crash kernel reaches here with interrupts disabled: can't wait for
> > > +	 * conversions to finish.
> > > +	 *
> > > +	 * If race happened, just report and proceed.
> > > +	 */
> > > +	if (!crash) {
> > > +		unsigned long timeout;
> > > +
> > > +		/*
> > > +		 * Wait for in-flight conversions to complete.
> > > +		 *
> > > +		 * Do not wait more than 30 seconds.
> > > +		 */
> > > +		timeout = 30 * USEC_PER_SEC;
> > > +		while (atomic_read(&conversions_in_progress) && timeout--)
> > > +			udelay(1);
> > > +	}
> > > +
> > > +	if (atomic_read(&conversions_in_progress))
> > > +		pr_warn("Failed to finish shared<->private conversions\n");
> > > +}
> > 
> > I'd really prefer we find a way to do this with actual locks, especially
> > 'conversion_allowed'.
> > 
> > This is _awfully_ close to being able to be handled by a rwsem where the
> > readers are the converters and tdx_kexec_stop_conversion() takes a write.
> 
> Okay, here's what I come up with. It needs more testing.

I don't see a problem during testing.

#include <linux/delay.h> has to be dropped, but otherwise the patch is
fine to me.

Any feedback?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

