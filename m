Return-Path: <linux-kernel+bounces-48239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDF78458F4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F052F1F245E0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D64F5B67F;
	Thu,  1 Feb 2024 13:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZlCLq80j"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE68C8665C;
	Thu,  1 Feb 2024 13:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706794386; cv=none; b=caSQWpYw0RXgP1BNC7xVBE0L2/rRoPV+mFM041EbNolmF2mzfqLG1Zz2tZrfODDKLiFKqU9d79aBMwESe90eL7xyJcXYE/dKl+gvqTf3AD26dRnARko90KZ/mITg80axKkb4wa1xDi1NDddub6+tlY94vu7dWs4I6+XVtwWsDWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706794386; c=relaxed/simple;
	bh=d4nO28AX07KPa1Zt4ur/QYk2sW8LPfo64qW4Aj9sTFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLY8ZrY5+ld603iK45+WNJpPpmBdC/IK0ucjiOF0PjB9CLaqFBHUrOLBuNQeCJvwV4x/bdwV0QSWDmjd2Wu02k1jcwC4YbGxi5Kt9ZWFBo/ni0lywSqu8eMnP2TJjQC/fiWyruSJg8q4Wdi9/SQVy82ATDR2cXIiLMDZJYPcoy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZlCLq80j; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706794384; x=1738330384;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d4nO28AX07KPa1Zt4ur/QYk2sW8LPfo64qW4Aj9sTFA=;
  b=ZlCLq80jy9b5FBu5a0l1Vu0PYd62XH4CGEV198CviGhqB47cfcfOqs3H
   XKcmf9HW3lqCv1heTX2WvR3NwIGwZNlx6TWftt6yYdjHszmLZACl1geno
   LuMvBmF/pGKqKpE+wr45lwNRcY8PHhzdF1E8G9yIqwXuM5uMbCduuUzPJ
   a304QzeXUj73826XBSkbCVnMt7TVj0ixhFolSTNavzREhmriIbvQvM3eQ
   NEze46T1rX8lSdY0eaoLUOZsrqfQb8u/TJbvZMvA6xRxqyz/GNrtZhZCi
   bRjCshHIWhiqtySdHVB58BTWRz3uvuRAoI7w7fOx0pgjbaboiJlp6Kb3L
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="468127722"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="468127722"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 05:33:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="932178346"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="932178346"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 05:33:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rVX4Z-00000000qTX-09SH;
	Thu, 01 Feb 2024 15:25:43 +0200
Date: Thu, 1 Feb 2024 15:25:42 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Crutcher Dunnavant <crutcher+kernel@datastacks.com>,
	Juergen Quade <quade@hsnr.de>,
	David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH v3 1/1] lib/vsprintf: Implement spprintf() to catch
 truncated strings
Message-ID: <Zbub1upDDLN9JWne@smile.fi.intel.com>
References: <20240130160953.766676-1-lee@kernel.org>
 <ZbuFSIIGbfhXeP92@smile.fi.intel.com>
 <20240201123004.GA938078@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201123004.GA938078@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 01, 2024 at 12:30:04PM +0000, Lee Jones wrote:
> On Thu, 01 Feb 2024, Andy Shevchenko wrote:
> > On Tue, Jan 30, 2024 at 04:09:53PM +0000, Lee Jones wrote:

..

> > > [0] https://lwn.net/Articles/69419/
> > > [1] https://github.com/KSPP/linux/issues/105
> > 
> > Link: ... [0]
> > Link: ... [1]
> 
> OOI, what does that do?
> 
> Does tooling pick-up on them?

Yes, b4 shows them when you do `b4 am` and then you can click from the
terminal.

> These links are for humans.

No objections on this.

> Is there documentation I can go look at?

https://docs.kernel.org/process/submitting-patches.html

"If related discussions or any other background information behind the change
can be found on the web, add 'Link:' tags pointing to it."

-- 
With Best Regards,
Andy Shevchenko



