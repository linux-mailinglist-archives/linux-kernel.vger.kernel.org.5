Return-Path: <linux-kernel+bounces-86566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D8B86C71D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3872BB262A4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9E279DBD;
	Thu, 29 Feb 2024 10:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JfKvwEfB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C94F5F46C
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 10:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709203288; cv=none; b=Jf47M42HJQq3owHrtZU1xUkIMtAE8wjsB+trrEcH7rMbl5yagJHsLS62O66Y197WyFoLgZMaZRIFNwkPXzWYanM6mpw0PIxDH/e54wh5tTTO1QwWjaFEiFS0iHR+W/tqyKymVFw1hcPwivH2ts3Qn3a4prGPOnT4D3NdrdgULdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709203288; c=relaxed/simple;
	bh=qxg5mCeN0Xd6dPBZltJOVCLRNbLYaMZtIrIHS5F6WZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r53TBVi234K/mOc09NckwweLOP7CpYVyNdJ1vqCrWrTir+lQ0gthfKVb8GrPR4X913JF33PduJfX+Bob0FQGAoDnDRLLAilL+6Cl0GoUiVhQsgB4AneWbdRF2U8sQInfDfrOSfBeuy734RnhphrfhuR65obxQXqoEoOQBzR4fow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JfKvwEfB; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709203287; x=1740739287;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qxg5mCeN0Xd6dPBZltJOVCLRNbLYaMZtIrIHS5F6WZ4=;
  b=JfKvwEfBiOO0fTkjDEzvtshFwgaMwdN05GJSti5lai33Zn3J8taQ00fe
   wCB+GrqSIr5pp8pe+skdKLBIxE3T9OlbJerk//nLojXkrqJaoSyjww+yF
   XdhDqRkir2QLqVyyRPDnlZv/ffEkiIQhk7xbyhMYnlmLXLDmHRXokrGr5
   UZDDy4FF89rXS/Zt2y+5jj20yQ4MznWgHIus51By81IhNZfgi3GF+aZeG
   5y7TRtM+38i/5uzALpdrGIkzcOCrioIRloPsbJUQcsiiDNjhTRowbJ6z4
   9nQK+tLL1wsVhNr8+vcQ0pb+LKJ69XH/iC1faozxgtZT+e5JvpS3GE+kt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="21121022"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="21121022"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 02:41:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="913978617"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="913978617"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 02:41:25 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rfdqs-00000008dyT-3J8h;
	Thu, 29 Feb 2024 12:41:22 +0200
Date: Thu, 29 Feb 2024 12:41:22 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v1 1/2] devres: Switch to use dev_err_probe() for
 unification
Message-ID: <ZeBfUnFciCPmFUOj@smile.fi.intel.com>
References: <20240227175910.3031342-1-andriy.shevchenko@linux.intel.com>
 <20240227175910.3031342-2-andriy.shevchenko@linux.intel.com>
 <e2f49a1f1877550c4ca733bbca26949836d4fef1.camel@redhat.com>
 <ZeBe-ubcNvtDdAG6@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeBe-ubcNvtDdAG6@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 29, 2024 at 12:39:55PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 29, 2024 at 09:52:34AM +0100, Philipp Stanner wrote:
> > On Tue, 2024-02-27 at 19:58 +0200, Andy Shevchenko wrote:

..

> > That way it would be obvious that the error code is never changed and
> > it will always return -EINVAL. Otherwise you have to look up the
> > function definition of dev_err_probe().

And to this, it's a common pattern in some cases, esp. when you have a chain of
the similar calls and you want to simplify the code (see CCI accessors in
Video4Linux2 as an example). So, I also don't think it's something unusual.

-- 
With Best Regards,
Andy Shevchenko



