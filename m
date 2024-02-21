Return-Path: <linux-kernel+bounces-75331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7368285E6AF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECA60B21C31
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC3685940;
	Wed, 21 Feb 2024 18:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DzYocgmy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA908004E;
	Wed, 21 Feb 2024 18:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708541606; cv=none; b=cur42VPAlvnufPaCSnBoNYkjHV+u+yQ6a0DH0HMMGuO96SZj1Sz0gjWlXY/e7v9Td4r4FOZmUfeAPaiMpAj3NIsm/iPp2+9JjHV4pimTy/YbDpF//PU9U+6DVQCEj7sMZzx44FRwg9VOIoOAKDzYnkPD/i/MUZE+lhLl8qStYtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708541606; c=relaxed/simple;
	bh=eMGM5YzEKrkILV3+3vpXcMdr1HJpfGEmL2Nq2vxUdlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrusEhhm4f4NoEd5s13C3tWDNLv5SiW2iBisPtXCES2o/PzDrkTtzNUe7O5wAQ0+9eWPzlKWHMljERRPSsEzdJfW5ZYnw2xiohYl613z4qRJDhq3pvAZvkSXh/U35PZXOaxctgyuuLQ1syK9xJKVePwva98A5DbXl1D0LiUvTHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DzYocgmy; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708541605; x=1740077605;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eMGM5YzEKrkILV3+3vpXcMdr1HJpfGEmL2Nq2vxUdlA=;
  b=DzYocgmyYE5xVXo3eH3x0l1WnYqxOITEAbCnclvpCPDwPvLgc88Y7XAD
   JcT9L2g36sCA1fcnZgQljIEcSssFhg9vgUTOilcEeOijcpi8gIN4+17Vx
   BNckqNnH116PBTYZarBYpMEliBP+76mZYQRSHMwWt4ycuf5r47O60sNJc
   4yeWYTDUPjFD+jJLY5gshzCbcVQC5MTx8wHoecEO2EyLF1Vf3UuMm+1Qx
   jwnitTyRubUOfKSYsM3P9hrkoZlVjXM41/wNR4dHN3PZ5CVaITiezbvDR
   hLd/i6Nu9KFpAZpfu/xgDMg12l62XYQZZX6qVMy01fyNxfRo3JukF5QmM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="2871965"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="2871965"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 10:53:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="913353183"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="913353183"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 10:53:12 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rcriO-00000006QtU-2avs;
	Wed, 21 Feb 2024 20:53:08 +0200
Date: Wed, 21 Feb 2024 20:53:08 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-rpi-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org, linux-tegra@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>, Joel Stanley <joel@jms.id.au>,
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
Message-ID: <ZdZGlLoUd_R6JQJc@smile.fi.intel.com>
References: <20240221183442.4124354-1-andriy.shevchenko@linux.intel.com>
 <20240221183442.4124354-3-andriy.shevchenko@linux.intel.com>
 <d18d4488-aa48-4156-8087-a117664cea7b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d18d4488-aa48-4156-8087-a117664cea7b@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 21, 2024 at 10:47:13AM -0800, Florian Fainelli wrote:
> On 2/21/24 10:31, Andy Shevchenko wrote:

..

> >   	unsigned char		iotype;			/* io access style */
> > +#define UPIO_UNSET		((unsigned char)~0U)	/* UCHAR_MAX */
> 
> Nit: I would name this UPIO_UNKNOWN, or UPIO_NOTSET, unset means to me that
> it was previously set and we undid that action, whereas unknown or not set
> means we never did.

Works for me. I will wait for a few days / week to have more reviews and
likely testings to be collected. Would be nice if you be able to test on
(some of) the hardware in the list of modified drivers.

-- 
With Best Regards,
Andy Shevchenko



