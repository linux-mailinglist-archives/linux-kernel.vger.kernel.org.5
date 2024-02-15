Return-Path: <linux-kernel+bounces-67572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA068856DA5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8651F2826C3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4135013959C;
	Thu, 15 Feb 2024 19:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dNJArDt/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CB31369AD;
	Thu, 15 Feb 2024 19:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708025163; cv=none; b=MQAcN7OvBntRGitmzhOE97OdQwYjSARtD5Y/eo79X3ErulqZnZRefDm1V80W9pM1SwY71yOP3gd69/Heck+3BGw9Cyv8nCyqKjH3Pkxpm68+I4nYOGXIa/yDhOatPS4GftM5ulfHwCN9GWTUBZfjmXvXkA93Jv6M+lED8Oz3MUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708025163; c=relaxed/simple;
	bh=kw3PXLxpfNXJjUQgkeonBF2W/U8/1JoSX62FFxlxwlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W21xpQBJ9j1nIiGiZPBMzEJJMJz6KvNQJq4bFkoBYGZqcTk1QOcD2TKCr+rOdt5O7KTkrKVugnrfPVK7YK4spSDUqLU6mi5ill+jHak5QZfQI6oGCUqI9DkmRppV08/wg+ZtImRlZQZtlwLegt1HMqVYlOvy7Zr3lsfj0xpTHJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dNJArDt/; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708025163; x=1739561163;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=kw3PXLxpfNXJjUQgkeonBF2W/U8/1JoSX62FFxlxwlA=;
  b=dNJArDt/OYIOlQ6RApj82K0golsYYxI9ppAoPT9zX7QNFob9jmnwOYjG
   oHS962X8Q/nJhAQrU2qaN95yUs3QM8NbfyXNjLhHKZVfpvBraT8UW+/JB
   my2m9fdO5vaqnOWcaEuVKzAFJwZKdeuLrRfjC8ISZllfls6+/gC+oASAD
   wp2G6nQMCxmBeZPNkZC3QzT7+0pROTLG7Vd6F++6KWtGPEfHDfthfYwRT
   Tg60soeQPPQ73eVBpQBV+SJmafYWkVX6Sy2IIpkET5kDak6aHnw54CmsY
   9pyqa09kKc6zeH5SihvvBHfLovR+HvPN3kG39ly7nA1QZj5XF5rUcsQ/8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="5946777"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="5946777"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 11:26:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="912216071"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="912216071"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 11:25:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rahMq-00000004sDn-3umS;
	Thu, 15 Feb 2024 21:25:56 +0200
Date: Thu, 15 Feb 2024 21:25:56 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Raag Jadav <raag.jadav@intel.com>, jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com, lakshmi.sowjanya.d@intel.com,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] pwm: dwc: drop redundant error check
Message-ID: <Zc5lRMQwROtVJdhV@smile.fi.intel.com>
References: <20240208070529.28562-1-raag.jadav@intel.com>
 <20240208070529.28562-2-raag.jadav@intel.com>
 <qrwcje4t2pbbxilnlfz2q7njodcp6vl54uaypdbvjgvwhgvc5g@4eq5wvumpjjx>
 <ZcUJoSMhgC7lhY-H@smile.fi.intel.com>
 <cv6w4n2ptcdehn5n3mipuyfrtemm4rldhiyppazk4uqdn2xx7e@hxg4kldaacxk>
 <Zcz-csPY5x29DP7v@smile.fi.intel.com>
 <sd2ugzjrmrdvcyxotoyg53qp3i7ta4yko225ln3gk4fmik7iof@a7mab6o2kkvz>
 <Zc4TTLetiGhJlx8d@smile.fi.intel.com>
 <likebxfhlcg6equjhxnf7cimsgac4qvoge3bf65qyir6apwq4n@iotwg6zjjr6c>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <likebxfhlcg6equjhxnf7cimsgac4qvoge3bf65qyir6apwq4n@iotwg6zjjr6c>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 15, 2024 at 06:20:15PM +0100, Uwe Kleine-König wrote:
> On Thu, Feb 15, 2024 at 03:36:12PM +0200, Andy Shevchenko wrote:
> > On Thu, Feb 15, 2024 at 10:22:57AM +0100, Uwe Kleine-König wrote:
> > > If a driver author knows it while writing the code, it's obvious. But if
> > > the driver author looks again in 2 years or someone else (e.g. me with
> > > the PWM maintainer hat on and with little pci experience) that knowledge
> > > might be faded.
> > 
> > This is widely used pattern. Anybody who works with Git should know how
> > to use `git grep` tool. If in doubts, always can ask in the mailing lists.
> 
> IMHO you're assuming to much. If someone sees this pattern and quickly
> looks at the implementation of pcim_iomap_table() they might (as I did)
> conclude that this call should be error checked. If they send a patch in
> say 2 years I think I won't remember this discussion/patch and happily
> accept this patch. And I probably won't get enough doubts to start
> grepping around.
> 
> > I still consider it redundant.
> > 
> > P.S. That's what you call "bikeshedding" (done by yourself here)?
> 
> I can understand that you consider that bikeshedding given that for you
> it's obvious that the second function cannot fail. For me it's not and I
> take this as a hint that it's not obvious for everyone.

The bottom line that PCI devres code should be refactored. And IIRC somebody
is doing that job, not sure at which stage it is now.

-- 
With Best Regards,
Andy Shevchenko



