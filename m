Return-Path: <linux-kernel+bounces-61461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE988512B4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1657B1F264CC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A5139FCF;
	Mon, 12 Feb 2024 11:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cE7JG+MI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106BD39FC3;
	Mon, 12 Feb 2024 11:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707738804; cv=none; b=jtr2jrhyKLJngloox7YL5PxlqSp8/AbKIaCgC7cde6qD+sRZYXWjcYkjbeBK9pURf/az66yghQASjwrERmWK6sGMwiZZuYDWyMwJOBiTs3GlUbR88tapp7BWz+RafrmzIIKKR30GD192Ct1HcjCNBPrqCcz21l0d4XqzwnBBBd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707738804; c=relaxed/simple;
	bh=bysvMgUEFjn8y4Zodb9vYNfjWoNGlYwrLwAYxoEu+i4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XjH46ugzZ5GjkISWpbzK4/EO+CD2mdnOcop6mLGcvkISlod/Ng+0vIJ+IDlbvo6G0Zw6YMxzdkVxvrVPAH1uzAEMS+TlvbpdP/EDk7dJ72Qt6kZahC71w5fw/x1SgcKY4XeiZTkHeNCY0Mezcpl81IAoYUfCCCmxk0axkhEgVgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cE7JG+MI; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707738803; x=1739274803;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bysvMgUEFjn8y4Zodb9vYNfjWoNGlYwrLwAYxoEu+i4=;
  b=cE7JG+MIuKXoxYVH9weFBCIpBljpqd31uhzZ4Um0o1Nl0aONl9nWF/pZ
   /7zoooQxLPk7vbhX2esCUe7S6kqgJ04hoU1v12LPTSWUOMkjKW4Ia1TAQ
   e0otaoeQS3W+aFtj3aFxaXei1ASeYQpTdEYYNS0MPDVXHQRt2Te2in74f
   j8DPAF8D473+YDmpfKQoqCGTPvg/cqhjlEgMUM4uKbEo/Xhul63btaCLI
   GmQaz3nSDi/6u9hD9Ty6ckey3JMId4KRHI2dUSRehmchJMCEAs5Xj5wFY
   vE2DSzDruvNgG+pzg8YtVX0XBNCQBmHaKoAm/WN/4tjLofZmZ7eVhKjRo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="2055272"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="2055272"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 03:53:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="911460714"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="911460714"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 03:53:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rZUsA-00000003sxP-05DM;
	Mon, 12 Feb 2024 13:53:18 +0200
Date: Mon, 12 Feb 2024 13:53:17 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Raag Jadav <raag.jadav@intel.com>, jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com, lakshmi.sowjanya.d@intel.com,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] pwm: dwc: Add 16 channel support for Intel
 Elkhart Lake
Message-ID: <ZcoGrXo8qKLXedaa@smile.fi.intel.com>
References: <20240208070529.28562-1-raag.jadav@intel.com>
 <20240208070529.28562-3-raag.jadav@intel.com>
 <ZcUNe09gDtkztmbk@smile.fi.intel.com>
 <ZcZ6kUkf-GktlU4p@black.fi.intel.com>
 <ZcZ__nnOz1QA7uUZ@smile.fi.intel.com>
 <42pjh4zpbsyfdi6njcwhpoyllmqr6vv7u5h2lfakrje4dzitfj@3bsynlfj5mjj>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42pjh4zpbsyfdi6njcwhpoyllmqr6vv7u5h2lfakrje4dzitfj@3bsynlfj5mjj>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Feb 10, 2024 at 06:19:53PM +0100, Uwe Kleine-König wrote:
> On Fri, Feb 09, 2024 at 09:41:50PM +0200, Andy Shevchenko wrote:
> > On Fri, Feb 09, 2024 at 09:18:41PM +0200, Raag Jadav wrote:
> > > On Thu, Feb 08, 2024 at 07:20:59PM +0200, Andy Shevchenko wrote:
> > > > On Thu, Feb 08, 2024 at 12:35:26PM +0530, Raag Jadav wrote:

..

> > > > Side Q: Have you used --histogram diff algo when prepared the series?
> > > > If no, it's better to start using it.
> > > 
> > > I used it for a few weeks, but I think I've grown a bit too comfortable
> > > with patience.
> > > 
> > > I'll use histogram for pinctrl stuff if you insist :)
> > 
> > It's recommended by Torvalds:
> > https://lore.kernel.org/linux-gpio/CAHk-=wiVNOFP1dzKdCqXvoery5p8QoBB5THiJUMbZ1TxJb7FhQ@mail.gmail.com/
> 
> BTW, the magic to use it by default is:
> 
> 	git config --global diff.algorithm histogram

Yep, that's what I have on my machines for development.

-- 
With Best Regards,
Andy Shevchenko



