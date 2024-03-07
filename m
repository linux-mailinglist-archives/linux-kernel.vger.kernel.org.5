Return-Path: <linux-kernel+bounces-95985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CD08755A6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 370D61F21DFF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE8B13175D;
	Thu,  7 Mar 2024 17:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bP9Et7zi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A65B130E44
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 17:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709834246; cv=none; b=l3yTrBaS/PbYxFRWgpOBxWB1uXfRSqQsg0RSmU+XVpCoUnhFLoYYnGVXZ1IDSv13qUA5LfZ0PGUygLSc7elRcejjZMFdU0hfvfsobiao0H8tDQSlmhI8EBfMinFtHOEUu2QCLGAxSRcREzc/Td/+6dcmg8QS/b4DTfHIl0ZG+UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709834246; c=relaxed/simple;
	bh=waq91CYvNLCsRev1erIY6js5vkjT9ek80U+wM6ipCrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDe+g++MUhs9F9a+8JtrVAmJAZUH0SczJp8PGuw4cYaXIQ3KtfbVF9eMQC52eZKbPrPdesFuvEIp1VYk6+jAgv69uLGrcKl2TyL6RNL1mrMqyCMLOlcmYmmFGWqoDC5cggXn6U1wf9Tzf04wnHrFPCdVKHLnNGihsHK3cNG4wkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bP9Et7zi; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709834245; x=1741370245;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=waq91CYvNLCsRev1erIY6js5vkjT9ek80U+wM6ipCrQ=;
  b=bP9Et7ziGhImBg8yY3V6C0lg7huUl9jWJlUtKzilPRGSMCynuJdXyiVw
   DMt4NR8Is1qPe2ioXvZzyDAM6NPALIOZ4N+LH/C3tQZuWa+N0obeNwfrt
   KLJuxp6cTAvlf54P/to0XmhjxNykojC1rhcT+hTRahPbX5fQUEPANFeKp
   psvUzeLrzmJouqqA4iEPJan0TCetXPtuqHGyDUwjM/KdS86E7n8d68aIK
   UtniTYGenkfod8i17MVbtDC175tDiekvv4R1zMSPNxfz/qrs/Bubct/FS
   HzfcSELd+TgDctVHxj18OedobI7r6jXbs8IyG3QQ3+glDPsapKg29bCAU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15952935"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="15952935"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 09:57:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="914220720"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="914220720"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 09:57:03 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1riHzJ-0000000AdGY-2K9c;
	Thu, 07 Mar 2024 19:57:01 +0200
Date: Thu, 7 Mar 2024 19:57:01 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v1 0/5] w1: gpio: A set of cleanups
Message-ID: <Zen_7fDQghq6GJ_s@smile.fi.intel.com>
References: <20240307143644.3787260-1-andriy.shevchenko@linux.intel.com>
 <vsaqquulifmpk5fanl4i67nzag5huyibzy5lfr2jdsgk2dv7t3@5i4opts7npsj>
 <ZenuzMtybS4CzwHv@smile.fi.intel.com>
 <46qzdowo2om2bbuokiksah27x4qok7hffiefwsj4bihz2xg62y@hxrag6h55zw7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46qzdowo2om2bbuokiksah27x4qok7hffiefwsj4bihz2xg62y@hxrag6h55zw7>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 07, 2024 at 06:12:46PM +0100, Uwe Kleine-König wrote:
> On Thu, Mar 07, 2024 at 06:43:56PM +0200, Andy Shevchenko wrote:
> > On Thu, Mar 07, 2024 at 05:38:54PM +0100, Uwe Kleine-König wrote:

..

> > > I wonder about your choice of recipients. I would have added Krzysztof
> > > to To and me at most to Cc:.
> > 
> > It's automatically generated using get_maintainers.pl.
> > See details in the source of the script [1] I'm using.
> > 
> > [1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh
> 
> Getting something wrong automatically isn't an excuse for getting it
> wrong :-)

I'm not sure why you think it's wrong. You worked on the code lately and Git
heuristics considered that over threshold of 67%.

> That scripts has:
> 
> to=$(git show -$count "$COMMIT" | scripts/get_maintainer.pl $OPTS --no-m --no-r)
> cc=$(git show -$count "$COMMIT" | scripts/get_maintainer.pl $OPTS --no-l)
> 
> I recommend to swap the values for to and cc here to make sure you have
> the maintainer in $to and the relevant lists in $cc.

Hmm... I don't remember why I put it this way.

Btw, you are the first one for the entire life cycle of that script (3 years?)
who complains about such details... So, patches are welcome! :-)

-- 
With Best Regards,
Andy Shevchenko



