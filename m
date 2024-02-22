Return-Path: <linux-kernel+bounces-76585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7C985F993
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6DD01C23A3B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51F21350D6;
	Thu, 22 Feb 2024 13:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VRmSJ3m1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A29133983;
	Thu, 22 Feb 2024 13:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608117; cv=none; b=mcn8sDrs/1Da2iVwVqp7HwWpImpt55E9b8wKq9VjufuL/9/VI5An4F/NgyscHyNcWPwTFl3eElJKyJ7IXBvs+afwqEF2dUn1pwLXKLUU2c+GEUOzyHZXvz9BV07jD/tQZQbjREOUdas7AUcPLLtPYsBtcMoAFcg4Kr91pA33Ujs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608117; c=relaxed/simple;
	bh=LUP/1Bq8oCXj+CsYBpJOUqAEbKSgM+4ilo2mGVOjFxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHzSsy3SsND5p7rPsvHhypkz0HsOhLvp2DKKutnqngCM5++Qo0rhJ3NHzUCXoBW1aDONj+kM3qopGYauduQz6M6St4bOzDXTUaPW+mKu57oRJlq6XaTefH/vCeduppe3aBTYJkzRDz5//wlp5F74B/PlFPrF6FSpaS2Qw2jWLkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VRmSJ3m1; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708608115; x=1740144115;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LUP/1Bq8oCXj+CsYBpJOUqAEbKSgM+4ilo2mGVOjFxQ=;
  b=VRmSJ3m1CPbF8brZL8s+uSfURQSgB4g3OBwSSCIAFElJPfz5SnuOA6gM
   XDexW3TAnmdyeX4KcVccD4uTKcMJqp0p5LoXM+axxHC5+D7Wvz0OLXWzQ
   rg/ad0g9ECRoONwuD/D3p1r3nczFOHmYIzJvs40G039Bxumi91dqVDFha
   2Lo0mjOW0yn+/uHXnqd9XIzkdh2uOk+hGBCFjIVO8gJG/pRMC4yKoEJ/f
   RUMXJo6CktXKzRO8NmhNp8hsaktk7i60kwDFa0rNovYo4/+KGNGxH6XJO
   7BvKNt8bfH7onOb0+t+BKt8ZQEOgYGufujGQdVarW72F+yshUyDL8v/FG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="25291944"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="25291944"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 05:21:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="913523354"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="913523354"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 05:21:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rd91F-00000006dVC-3OPd;
	Thu, 22 Feb 2024 15:21:45 +0200
Date: Thu, 22 Feb 2024 15:21:45 +0200
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
Message-ID: <ZddKaaB7HO0CyldD@smile.fi.intel.com>
References: <20240221183442.4124354-1-andriy.shevchenko@linux.intel.com>
 <20240221183442.4124354-3-andriy.shevchenko@linux.intel.com>
 <5aeee02f-45a6-48e5-a6f4-e55b76d4b959@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5aeee02f-45a6-48e5-a6f4-e55b76d4b959@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 22, 2024 at 07:58:32AM +0100, Jiri Slaby wrote:
> On 21. 02. 24, 19:31, Andy Shevchenko wrote:

..

> >   	unsigned char		iotype;			/* io access style */
> > +#define UPIO_UNSET		((unsigned char)~0U)	/* UCHAR_MAX */
> 
> Perhaps making the var u8 and this U8_MAX then? It would make more sense to
> me.

WFM, should it be a separate change? Btw, how can I justify it?

-- 
With Best Regards,
Andy Shevchenko



