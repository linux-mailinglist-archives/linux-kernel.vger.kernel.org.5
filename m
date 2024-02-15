Return-Path: <linux-kernel+bounces-67320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD308569CB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A76871F21663
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E3B135A76;
	Thu, 15 Feb 2024 16:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e/e71qZg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A5C1754B;
	Thu, 15 Feb 2024 16:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708015398; cv=none; b=FwNOfaCqq3V0B8HrTceSfdYeYA+2UGUegGuhMeeDwRlaPRYrbEC+HYjukPy6dVYnaR9mpIaoeoVOXcKsKtQF04OV/H7A/0i9u+a6ZnYBIZkFBXU/+AGEelTxnQgciRCOiCxcag4P/7t5uhYdjnbX3T8LPTS8ZEzSBKk/GFozoo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708015398; c=relaxed/simple;
	bh=HAkLyN4waiCqyMpQ1OnoyH8jXYcr26Pbi3JxBhpV5/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AE+JJBL7EMX66aSWnksXtNkykRiuA32h8Zcpyhrvakbtc+vGT4kvxAzD8yTWCACuz/b3axd6iuZ+eZqzN8lw8OQfQy04S8dNNUsExY3N4A0wvzPVEoB98RuzpOtCaUTyR/YB4cfZjZ/bX2u1OXf1bRB//yH/EB8ubPAUbWyGryk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e/e71qZg; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708015398; x=1739551398;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=HAkLyN4waiCqyMpQ1OnoyH8jXYcr26Pbi3JxBhpV5/4=;
  b=e/e71qZgy4XXnm+C4jFLWETChq20mlUp4YUZLGhTVkXTflQD9UjiKjBa
   G16Az9lawmKneRhLy0LfQ/NaqiGz7/uAySvld+yS5u0pJvxt0yZPN3QxA
   1hjtrQ9hcePzFtJQYPncCNYl6vPfrbf/LkPiynI972LdNV0nYokxHut0j
   UoB+1rDP4qDDcC8JpclE/nnvw+txY+pHHRvKyIhAXV0BZBWMPUSJgQ1zX
   HOxmC7ibAgtgQr2TacvYFCPbbV9RSAdnX5Va8aMMO54k/MfqQWew3Qa9f
   aq2rYCv6YKFXmZ7zfH40Sz1Y7SyxBQipF+4na3cumC0MdDlPd6v2EXiTD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2231952"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="2231952"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 08:43:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="912192246"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="912192246"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 08:43:15 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1raepM-00000004qMt-2Mjp;
	Thu, 15 Feb 2024 18:43:12 +0200
Date: Thu, 15 Feb 2024 18:43:12 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-serial <linux-serial@vger.kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 1/1] serial: 8250_of: Drop quirk fot NPCM from
 8250_port
Message-ID: <Zc4_IHMQWSGtCCC2@smile.fi.intel.com>
References: <20240215145029.581389-1-andriy.shevchenko@linux.intel.com>
 <835925e0-0df0-fed6-6b29-0cf4a9f811b0@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <835925e0-0df0-fed6-6b29-0cf4a9f811b0@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 15, 2024 at 06:40:15PM +0200, Ilpo Järvinen wrote:
> On Thu, 15 Feb 2024, Andy Shevchenko wrote:

..

> > +	/*
> > +	 * Nuvoton calls the scratch register 'UART_TOR' (timeout
> > +	 * register). Enable it, and set TIOC (timeout interrupt
> > +	 * comparator) to be 0x20 for correct operation.
> > +	 */
> > +	serial_port_out(port, UART_NPCM_TOR, UART_NPCM_TOIE | 0x20);
> > +
> > +	return serial8250_do_startup(port);
> 
> I know this matches how it is currently done\

Exactly, I haven't changed the workflow.
Does it mean you are okay with the change?

> but I wonder if TOIE should not be enabled until ->setup_irq()
> has been called.

No idea, this will need an extensive test on the hardware and should
be done separately anyway. I have no HW to test this.

-- 
With Best Regards,
Andy Shevchenko



