Return-Path: <linux-kernel+bounces-94548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5347E87413B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A0971F23725
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB6B140E4D;
	Wed,  6 Mar 2024 20:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W2Df2c/H"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88646140E25;
	Wed,  6 Mar 2024 20:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709755932; cv=none; b=f3ndk0dWm6D3rh8BwU2sko9iSnYOSrua8MohPDdtoltsPqjz1Hbox8ejyD25XKlLhSzMLIFGagxzmJMadw1YvgckzLGdkEvQ9SI9cxUQE6ESBwSNdZo9qS8YGhHoAOrh/yyjuCtAcQu178HC2FzEo3rHx0QbpmmXbwszeYNFYpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709755932; c=relaxed/simple;
	bh=Bvy6rY8w+1vMChBQ7NK2oz9a9xIKn6UQ0LHrxARu3fI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMGV4bcjEWdqpX0TZ9UGTAoGZomhhmvio0y9i4Wt4cnhkIJax60UyhJAtn+8028jPFT/nU9Sz0zRNWxvnF6uNs7Wb+0TbXg96n8x7gCExmWWy9a/45apLnVDhZMIeoHGeRA3ULmXiBaUqsv2MUxX2wN8L1lCmNBUOxrgsKT5cHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W2Df2c/H; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709755930; x=1741291930;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bvy6rY8w+1vMChBQ7NK2oz9a9xIKn6UQ0LHrxARu3fI=;
  b=W2Df2c/H9BGFSE7cwm05Aktbu96MGlKuYkixyyh+TSVnfkTkf6L3nXIx
   TAbIYzsNd1sXmlNDo9yBhivsScODy2DCAoih1NOUTCOOfpN7eqHKkCB8N
   54XhWMNoZCYxPwX/tf42AdjS7SDAO+clnWMaS9fDyh35T7GKi/1jIUBQi
   aGiKzSCxuPQGy9iO/GT8nv67TFb6MLdcoxHijUYGgWfbpTpZaVRRRgEdP
   EJiilU7R2Uz/mu00KZbbcx8L8GKBObsFanmnCs1HxSlO5wxqiNjrMMkzf
   mTg2OVMi8ra7H3+VszR5tPdwSEva+inVQz1lgUT6L+vnl7ejVE8pdPY76
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="21915606"
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="21915606"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 12:12:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="914188488"
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="914188488"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 12:12:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rhxcU-0000000AMJf-2uWY;
	Wed, 06 Mar 2024 22:12:06 +0200
Date: Wed, 6 Mar 2024 22:12:06 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] spi: Fix multiple issues with Chip Select
 variables and comments
Message-ID: <ZejOFr4glx-OUSWA@smile.fi.intel.com>
References: <20240306160114.3471398-1-andriy.shevchenko@linux.intel.com>
 <20240306160114.3471398-4-andriy.shevchenko@linux.intel.com>
 <32c04b04-17c1-40f6-ad57-6c18e47f4842@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32c04b04-17c1-40f6-ad57-6c18e47f4842@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 06, 2024 at 06:08:43PM +0000, Mark Brown wrote:
> On Wed, Mar 06, 2024 at 05:59:42PM +0200, Andy Shevchenko wrote:
> > There are the following issues with the current code:
> > - inconsistent use of 0xFF and -1 for invalid chip select pin
> > - inconsistent plain or BIT() use
> > - wrong types used for last_cs_* fields
> > - wrong multi-line comment style
> > - misleading or hard-to-understand comments
> > 
> > Fix all of these here.
> 
> Please don't do this, as covered in submitting-patches.rst submit one
> change per patch.  This makes it much easier to review things.

Fine by me, consider this patch as RFC to understand if we want to have this
or not in general. I will rework it, if the idea is acceptable.

If you are fine on the first two, perhaps they can be applied first.

-- 
With Best Regards,
Andy Shevchenko



