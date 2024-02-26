Return-Path: <linux-kernel+bounces-81601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C266A867810
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 633BCB21F50
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6801212AAF4;
	Mon, 26 Feb 2024 14:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XLDWD9hK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E217129A75;
	Mon, 26 Feb 2024 14:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708957035; cv=none; b=H2/igorI3HUWG9PE3CtrHo6RVhfusoOMmm4RFiIAMQjZb+Wz+TsBvib9iqYURvjwJ9PhBJohu9Lz+xrmHoF7JvJ+yddszElaSZc21lfr+VqfT37qHnS4hEkFCbGc+M7pNFTfQTmdMZ9jGc6VpB85PAOujkmqfpqhA08bj8iGZLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708957035; c=relaxed/simple;
	bh=HZlXZGpEZ0auGfIkoqRiKy72XZYfKXmXVmc4SJZWGJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAl0fRMvnnTyhadnN5JzNlLyfk4ha6ANIgn2pWRxd7XTwtoYc2C5BlLuJiQstRX6FQdpTImG6WC9j0ISpJGJErLJXH6Rl8Mp/E5UnBD1f6oGqv4WSb/Ql73GlsznL+JGw8HoFxjpAKGxQJA1TsPk+gfQtMSRavv+1hQ3bAPkKHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XLDWD9hK; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708957035; x=1740493035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HZlXZGpEZ0auGfIkoqRiKy72XZYfKXmXVmc4SJZWGJo=;
  b=XLDWD9hKWSYS93+37BvlTXBZ6JM6TPO2yMqN8070OaF1NRVheRzy7aNh
   C8+aBkPAeDa3JRuo//3OTkghATG1dNXAZjETuIcXLR3TP+cQdrocS38f7
   J6xBn9Ls3gxQCKn92fLTM6foUg26500JT1tcbjMfzCKQ9giYPa99uRXL7
   /JUOcfxPai348/cfF/y84SSZNT30zEuRGFfM8UlfdLpNHoAzBPFmvWY1R
   ALlskxrfP3+PR4xvYS4oGQDxViRLcDoAGnyLGtx/4BaXHB4cz1KU7JNZh
   l+25I4qtB65xEIzy+8e3uXlZ/++WDLpJuzg9TItX+fBVLotxpDDKIJfk5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="7047436"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="7047436"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:17:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="913872291"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="913872291"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:17:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rebmx-00000007hRa-3oE3;
	Mon, 26 Feb 2024 16:17:03 +0200
Date: Mon, 26 Feb 2024 16:17:03 +0200
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
Message-ID: <ZdydX79GBaedFqku@smile.fi.intel.com>
References: <20240221183442.4124354-1-andriy.shevchenko@linux.intel.com>
 <20240221183442.4124354-3-andriy.shevchenko@linux.intel.com>
 <5aeee02f-45a6-48e5-a6f4-e55b76d4b959@kernel.org>
 <ZddKaaB7HO0CyldD@smile.fi.intel.com>
 <fa46f220-a1c4-43f4-91e1-5929ff335be0@kernel.org>
 <ZdiyzKMZPlkN462G@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdiyzKMZPlkN462G@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 23, 2024 at 04:59:25PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 23, 2024 at 06:42:15AM +0100, Jiri Slaby wrote:
> > On 22. 02. 24, 14:21, Andy Shevchenko wrote:
> > > On Thu, Feb 22, 2024 at 07:58:32AM +0100, Jiri Slaby wrote:
> > > > On 21. 02. 24, 19:31, Andy Shevchenko wrote:

..

> > > > >    	unsigned char		iotype;			/* io access style */
> > > > > +#define UPIO_UNSET		((unsigned char)~0U)	/* UCHAR_MAX */
> > > > 
> > > > Perhaps making the var u8 and this U8_MAX then? It would make more sense to
> > > > me.
> > > 
> > > WFM, should it be a separate change?
> > 
> > Likely.
> 
> Then I need a commit message, because I'm unable to justify this change myself.
> 
> > > Btw, how can I justify it?
> > 
> > Hmm, thinking about it, why is it not an enum?
> 
> Maybe, but it is a replica of UAPI definitions, do we want to see it as a enum?
> To me it will be a bit ugly looking.
> 
> > But it could be also an u8 because you want it be exactly 8 bits as you want
> > to be sure values up to 255 fit.
> 
> Depends on what we assume UAPI does with those flags. It maybe even less than
> 8 bits, or great than, currently 8 bits is enough...
> 
> TL;DR: I would rather take a patch from you and incorporate into the series
> than trying hard to invent a justification and proper type.

Okay, I want to send a new version, for now I leave the type change for
the next time. It looks that quirks as well will benefit from type clarifying.

-- 
With Best Regards,
Andy Shevchenko



