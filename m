Return-Path: <linux-kernel+bounces-117608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BF588AD1A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4DDC1C3B24B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDE9131189;
	Mon, 25 Mar 2024 17:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S7tBN2cy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DABD12FF71;
	Mon, 25 Mar 2024 17:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387958; cv=none; b=NsG8IVNZJJEUoDSU2lOAn5hG8QZSOcpNu7pZVP1kt/o7Z7YJYLkDEE4O6coWDyWLwy5E1YTTpxcyOJF4nRgzugZZxC1FKB2Rd8926TYwTmBStuzpYdBYVhx/UXYOz7pNf1PA4wuIuLl4ZK03pNt5uh6QVxrcKAF/mBprA8aerO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387958; c=relaxed/simple;
	bh=EQVMqG03KUhv5BVkLnTVMCLuTRWpG9rrEV770Zk15xI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YW7fMFKVQ6b/c3OLqpA/w4xSa0nNaMSHUch57rpHjrhEkPkIQR9ltKZYzjTmPFZeSo9K/sZbnaGMp4aWgtxXzs+bcQrsrm37h0Ra92pMsDwAuYRJ+vUVNpF8fL9Uim0VeKjoBlT2MSOWN+hBS+vDuOEwqn+CN9Y+UcYS/JwYDt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S7tBN2cy; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711387957; x=1742923957;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EQVMqG03KUhv5BVkLnTVMCLuTRWpG9rrEV770Zk15xI=;
  b=S7tBN2cy4yafXJa2MiWqbtjWrNi2rQtE6kYl2BXpzzT5bMzkG7akZ82d
   hIt6MPp6tYV7eU/bDWjwT4YBPVXHHqtULZ2IqQDiiMJuwgJFJ1S6Z3c4k
   Ahy1pIHvkTTwVUJvJXfvxlgu9SKas91+bjqY9wYL1S+g1CTFxo4ORIQWn
   +BDnLkBBbcF2Qrv1Cz2hnfrrQRdpY7j6vrIwRfTrWR+eOYQXohq2qh3lr
   n5O8oVdjOu9+HduXh+EjTvQFotYdLWSgQZFfPmOT36mNp4kx+RDl8ljSf
   rcH6LiBt9Pg+86ZEzFJhgVax5jfT8mVFTRMODM9ClTTKUe22gbFkVpdEG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6587540"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="6587540"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 10:32:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="914849973"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="914849973"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 10:32:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rooBU-0000000G4B5-0C9G;
	Mon, 25 Mar 2024 19:32:32 +0200
Date: Mon, 25 Mar 2024 19:32:31 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 1/1] ASoC: soc-jack: Get rid of legacy GPIO support
Message-ID: <ZgG1LwVAd1xxqJTg@smile.fi.intel.com>
References: <20240318202602.182619-1-andriy.shevchenko@linux.intel.com>
 <e6900b97-c1b7-45a5-bc3c-4a4a2745fdf3@sirena.org.uk>
 <ZgGJE0JNAESe5xUf@smile.fi.intel.com>
 <92f1cf44-3228-4eca-b8d3-39057c1150bb@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92f1cf44-3228-4eca-b8d3-39057c1150bb@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 25, 2024 at 05:22:55PM +0000, Mark Brown wrote:
> On Mon, Mar 25, 2024 at 04:24:19PM +0200, Andy Shevchenko wrote:
> > On Mon, Mar 25, 2024 at 02:16:15PM +0000, Mark Brown wrote:
> > > On Mon, Mar 18, 2024 at 10:25:16PM +0200, Andy Shevchenko wrote:

..

> > > > If I am not mistaken, after
> > > > https://lore.kernel.org/r/20240318200804.181516-1-andriy.shevchenko@linux.intel.com
> > > > there is no more users. Hence the above is the only dependency.
> 
> > > You are mistaken, please try compile tests:

..

> > > (this is among other things in x86 allmodconfig).
> 
> > I usually enable the particular drivers and I have compile tested this,
> > but indeed, I haven't enabled _all_ modules.
> 
> > Thank you for the pointing out.
> 
> Especially if you're doing this sort of "I think I got everything" type
> change it's sensible to do at least one allmodconfig build, it won't get
> everything but it'll catch a lot.

True, as even `git grep` output can be misinterpreted and some occurrences
may disappear from the sight.

-- 
With Best Regards,
Andy Shevchenko



