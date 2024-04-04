Return-Path: <linux-kernel+bounces-131402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D07898729
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F3D4298169
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1503C85C70;
	Thu,  4 Apr 2024 12:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i6P2868z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB71384FD8;
	Thu,  4 Apr 2024 12:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233147; cv=none; b=YAi5qjC3Ag+eclZm/PGxIXckA8wd52MOtWDW19jyyZLqxqHgNL8Yjt2yrOKTvq7+Ch+k9H8wJS2ttBbJR6YDFi45oQarELJPoRmEi/oJqFI58eEonYN9yc37esAu/nIru6dxEfQyVGRYx2hc5NJX2nGyEa+LMU1oQjwMlXWU0Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233147; c=relaxed/simple;
	bh=mil+HQR04IvA/pn5IicgtVQd4s2jM36JG4PRtJicsTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pg4oQdzxS0yPVtmya5qzoqT/+duS5OtuSSk/b1hZvUEriWAz1j/iCMlPB/5ul7x3117Se5p496ZcuB3rPfNcaXrzJSd2/NSjnrr9rBGX3SZV0aJzOQKnomBukTXeH5pHoPE9VpTdJLaDoYD3J/UKn3GUjW7A5xmgNHAiRDSsl/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i6P2868z; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712233146; x=1743769146;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mil+HQR04IvA/pn5IicgtVQd4s2jM36JG4PRtJicsTY=;
  b=i6P2868zuuT20xDdFlvrkrSaSePHagN9oVumbNhBdMgds5S0S0h/iXdK
   RCyrC9MAB7Ludp6ivmc0gBzzFtimy+70wahNqCDsoqgNf+Og+xQ2Fv6yw
   7cySGbvPQMYaNc5spJ4aKgkiTvzPaOhTqNfma6wcpMbJYuXajREbOgs3M
   lRjVLXTD1uAIM51uPYzD3F0jjgwg3BkAareDdOJCQNZzBZpz6K78RYuLL
   rylOeaith6Nt1lw0GEbT+8kDB8OsnICf1gg/pSnKdXpSv7JlF83B5E8+m
   wXtg05pdL+GWXguw29i0+mv4z2P293kXuCP6SMwfGM9j94T8aYlAwg0/L
   w==;
X-CSE-ConnectionGUID: WXBqaGseRNqiYTp4+J8qqA==
X-CSE-MsgGUID: 9G/BbE/JRYaCp1J2xROuqg==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="18663390"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="18663390"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 05:19:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="915216555"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="915216555"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 05:19:02 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rsM3X-00000001QHL-2Qqa;
	Thu, 04 Apr 2024 15:18:59 +0300
Date: Thu, 4 Apr 2024 15:18:59 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Nuno Sa <nuno.sa@analog.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Jyoti Bhayana <jbhayana@google.com>,
	Chris Down <chris@chrisdown.name>,
	John Ogness <john.ogness@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/4] dev_printk: add dev_errp_probe() helper
Message-ID: <Zg6as8asLMcLi6qM@smile.fi.intel.com>
References: <20240404-dev-add_dev_errp_probe-v1-0-d18e3eb7ec3f@analog.com>
 <Zg6Z51uebr2dWLq2@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zg6Z51uebr2dWLq2@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 04, 2024 at 03:15:35PM +0300, Andy Shevchenko wrote:
> +Cc: Andi
> 
> On Thu, Apr 04, 2024 at 01:06:22PM +0200, Nuno Sa wrote:
> > This series adds a dev_errp_probe() helper. This is similar to
> > dev_err_probe() but for cases where an ERR_PTR() is to be returned
> > simplifying patterns like:
> > 
> > 	dev_err_probe(dev, ret, ...);
> > 	return ERR_PTR(ret)
> 
> What about ERR_CAST() cases?
> 
> > The other three patches are adding users for it. The main motivator for
> > this were the changes in the commit ("iio: temperature: ltc2983: convert
> > to dev_err_probe()"). Initially I just had a local helper [1] but then
> > it was suggested to try a new, common helper. As a result, I looked for
> > a couple more users.
> > 
> > I then move into dev_errp_probe() [2] but it was then suggested to separare
> > the patch series so we have onde dedicated for the printk helper.
> > 
> > [1]: https://lore.kernel.org/all/20240301-ltc2983-misc-improv-v3-1-c09516ac0efc@analog.com/
> > [2]: https://lore.kernel.org/all/20240328-ltc2983-misc-improv-v4-0-0cc428c07cd5@analog.com/
> 
> Have you seen mine?
> 
> 20220214143248.502-1-andriy.shevchenko@linux.intel.com
> 
> (Note, I'm pretty much fine and thankful that you take care of this)

Also you might be interested to have this
20231201151446.1593472-1-andriy.shevchenko@linux.intel.com

-- 
With Best Regards,
Andy Shevchenko



