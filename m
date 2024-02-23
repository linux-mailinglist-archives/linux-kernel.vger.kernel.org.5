Return-Path: <linux-kernel+bounces-78557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7568614FE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DCBA2859D1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639496AF81;
	Fri, 23 Feb 2024 14:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GDchqFob"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9E737C;
	Fri, 23 Feb 2024 14:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708700376; cv=none; b=CGoBQSrju1USvGfEzxn8haGhCp10DZu8KyytDaecd2ebpRkqklpHdXKhPER/lU4MwOXX/CZwe/2vXG0Io4q2lnMst6prrSkd3A5qkId3BkVuE13B2zV4Qsudxne9kvnXjHoA0w3nhjIen1/tNOj0E6gJ4zD3wHlcMcXeAk9+aQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708700376; c=relaxed/simple;
	bh=tKzaZ4SrfW3NZnt7/A7BvgRIDvidSwzO3kkc6CIop9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9nTGCK3I2LgkBcZS6JT0oM2ZOofgZDnrhFjNmviCceDjrAX2JsPM0C+GXiODoVlhpyD0nLsVnqZWD8pMjHiPEYQurzNF1WIQhnRkp/NqqPpAmYePXGWRS52kYbhyA4KupcuCF1zrWizTbPkAbG1iTq1ySumbwW9T62kznoFF5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GDchqFob; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708700375; x=1740236375;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tKzaZ4SrfW3NZnt7/A7BvgRIDvidSwzO3kkc6CIop9s=;
  b=GDchqFobBfQnhm7ZOUv5uXX1pNcff42gdVnbD8hMTZQu/M3PloU0sAen
   PpBXVV/trFzapLTpCV8X8ZBFz8zeobXijsSSUfD9kOPFpBHZmQe0Be8Ib
   Wq1hyduuptoHTcpriSrMWhZ/cuwqJf3FXA90Tx9gh4htG+r2wGl/CCXbF
   ExpTzLrRlFjhCzgVa6hTKIwxTeIOxanofEhbWshUbxVbUL+g4ypfrYXu3
   /34Ulqb9UNs+KeS0xTNj5ijT0AecXqlMuTiW5nFlgbT8sl72i/jDGEr/+
   VSAjNw5cn99+ShEdb3y5jXke31z5Fzg5rxYejuYFxIAHtzBZuCDsO5W3g
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="6832450"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6832450"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 06:59:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="913748299"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="913748299"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 06:59:28 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rdX1I-00000006ve5-4BqP;
	Fri, 23 Feb 2024 16:59:25 +0200
Date: Fri, 23 Feb 2024 16:59:24 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-rpi-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org, linux-tegra@vger.kernel.org,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v1 02/14] serial: core: Add UPIO_UNSET constant for unset
 port type
Message-ID: <ZdiyzKMZPlkN462G@smile.fi.intel.com>
References: <20240221183442.4124354-1-andriy.shevchenko@linux.intel.com>
 <20240221183442.4124354-3-andriy.shevchenko@linux.intel.com>
 <5aeee02f-45a6-48e5-a6f4-e55b76d4b959@kernel.org>
 <ZddKaaB7HO0CyldD@smile.fi.intel.com>
 <fa46f220-a1c4-43f4-91e1-5929ff335be0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa46f220-a1c4-43f4-91e1-5929ff335be0@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 23, 2024 at 06:42:15AM +0100, Jiri Slaby wrote:
> On 22. 02. 24, 14:21, Andy Shevchenko wrote:
> > On Thu, Feb 22, 2024 at 07:58:32AM +0100, Jiri Slaby wrote:
> > > On 21. 02. 24, 19:31, Andy Shevchenko wrote:

..

> > > >    	unsigned char		iotype;			/* io access style */
> > > > +#define UPIO_UNSET		((unsigned char)~0U)	/* UCHAR_MAX */
> > > 
> > > Perhaps making the var u8 and this U8_MAX then? It would make more sense to
> > > me.
> > 
> > WFM, should it be a separate change?
> 
> Likely.

Then I need a commit message, because I'm unable to justify this change myself.

> > Btw, how can I justify it?
> 
> Hmm, thinking about it, why is it not an enum?

Maybe, but it is a replica of UAPI definitions, do we want to see it as a enum?
To me it will be a bit ugly looking.

> But it could be also an u8 because you want it be exactly 8 bits as you want
> to be sure values up to 255 fit.

Depends on what we assume UAPI does with those flags. It maybe even less than
8 bits, or great than, currently 8 bits is enough...

TL;DR: I would rather take a patch from you and incorporate into the series
than trying hard to invent a justification and proper type.

-- 
With Best Regards,
Andy Shevchenko



