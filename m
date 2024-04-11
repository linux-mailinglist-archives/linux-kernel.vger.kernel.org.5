Return-Path: <linux-kernel+bounces-140414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAB38A1415
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57A25284D68
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBAD14B081;
	Thu, 11 Apr 2024 12:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="coIDmvSM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827D0140E3C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 12:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712837554; cv=none; b=Ahj/iTEYeTFeBhIKghkaqBv9R8jeg1EkOhAH5v/8ifJebdsLZ6MxYljYeTw1rFnccYdfGqX0eVPYyxbMMOotTz2PM8UmOq2zwcF8eAqYAX17Usi2S4wxCXvEMZW7teLQIOAM59dZYdUQynONLzX2UAjN/NE5CpZVnzfu1JTIe8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712837554; c=relaxed/simple;
	bh=LAtup1PCqqwNPOCmnMi87BqYF73KLNQmtLQWOBQjdv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQAMkco1p0y1wRfZmeNDy1ftwDKmJ5AZeyZGmcE/DWCkk8q4UUTcEsGdREYYos0vVGYif5gLySHeLUCFF8d7Fl7pE0wsu9jZUYodKCqQ/N/C6BPntwG7S1PRN0AJWADaKvPJyhsgLfaXmKVonesj/YhdUN0MqDwJgLqExch358U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=coIDmvSM; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712837553; x=1744373553;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LAtup1PCqqwNPOCmnMi87BqYF73KLNQmtLQWOBQjdv0=;
  b=coIDmvSMCcOKxZ/T1oGYH720J332kNHOFUa4OLi6L+EjQ8Uki9zsGpMD
   QZta5wDCwt3jGHf8+9TUpJD2x8Q8OpRnME5R49pFXBUhIkBH+Nlj+SzB2
   kKvZriksa59PtkQ/PEslIYqkkuVIXVKwqn9IB6JZQrQuFM0p1QacsH6ui
   enlHy2pfmOpNFAx+svKCM8FYqx7rOyUFKrda59vUYkah+Wtw+OnjsvBIg
   cOJk8AY0f0XHjrVcn2/G0Rp2uA+6go8xkt72+pC+FtzVxeTDeyD+llxSE
   +a5waITxYF05fjgYwD6xDdrFcEGLd7R8yVK3WobFBhv47qgVpTJEfELst
   w==;
X-CSE-ConnectionGUID: 228GPrSlQciQdYUCwG75cQ==
X-CSE-MsgGUID: 0fuQhEyyR1mYpSApF6ZQhQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="12020467"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="12020467"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 05:12:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="915461944"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="915461944"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 05:12:31 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rutI5-00000003LO3-0Ab2;
	Thu, 11 Apr 2024 15:12:29 +0300
Date: Thu, 11 Apr 2024 15:12:28 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/6] mfd: kempld: A few cleanups
Message-ID: <ZhfTrHrdq58LrZDs@smile.fi.intel.com>
References: <20240223195113.880121-1-andriy.shevchenko@linux.intel.com>
 <Zgwk1tr7x4HnnlD9@smile.fi.intel.com>
 <20240411092928.GB1980182@google.com>
 <Zhe5YPsvEp1rzsTp@smile.fi.intel.com>
 <20240411105607.GE1980182@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411105607.GE1980182@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 11, 2024 at 11:56:07AM +0100, Lee Jones wrote:
> On Thu, 11 Apr 2024, Andy Shevchenko wrote:
> > On Thu, Apr 11, 2024 at 10:29:28AM +0100, Lee Jones wrote:
> > > On Tue, 02 Apr 2024, Andy Shevchenko wrote:
> > > > On Fri, Feb 23, 2024 at 09:49:49PM +0200, Andy Shevchenko wrote:
> > > > > Just a set of ad-hoc cleanups. No functional change intended.
> > > > 
> > > > Any comments?
> > > > 
> > > > (I assume the 6+ weeks in the mailing list is enough for all kind of CIs
> > > >  to complain. But they hadn't AFAICS.)
> > > 
> > > Not sure why these were dropped from my queue.
> > > 
> > > Likely another Mutt "feature".
> > 
> > Hmm... Using mutt as well, but probably not in advanced way.
> 
> I use:
> 
>   I               flag-message               toggle a message's 'important' flag
> 
> ... to mark messages as requiring review.

I don't (yet?).

> Sometimes Mutt drops them for seemingly no reason.  It's also not
> uncommon for me to fetch new mail or open Mutt to find 300 unread mails
> which I've already parsed.  When that happens, all of the mails that
> I've previously flagged have also been (not so) helpfully unflagged!
> 
> It's just something that I've grown accustomed to.

Okay, thanks for sharing your experience.

-- 
With Best Regards,
Andy Shevchenko



