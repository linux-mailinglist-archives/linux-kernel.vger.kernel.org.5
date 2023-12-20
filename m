Return-Path: <linux-kernel+bounces-7177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4AE81A2D5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321EE1F24167
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB091405CA;
	Wed, 20 Dec 2023 15:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EZLXs8Ju"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994F040BE4;
	Wed, 20 Dec 2023 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703086693; x=1734622693;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PiO+CR8tWKkwiGbcqyZpcpnZcE8du2LJsaUDrngJ0RQ=;
  b=EZLXs8JuThxS0M6FP4Cem8mgcmHnl5Ka1XSZm9JcUkhKjWVdA9ysbLiG
   c658+cVWuNrDJqAA/vZGa2NYmzYgoL+t6RHNOacIMdmifvkdqQlbDzuN9
   5fKciAgZ0kngDeTr/7gJ4VAfRL+3DYmJu8rDyD4nAXxv7fMpV/EskTj1x
   jCkt8XMGmC8ZWKnL5XGCyL8XIqVRKKYvtNDNTqP8ZvuAZG76OiaJnxqQL
   VBtwj483N5ffRVqBtGayZXLRQ02a/Q0WYcN1MuzQPZlkOsAgKDHj/5Qgh
   VVkkDZoMjPiSbQpHcTkAxZG/oYxqwW/F+uBiQ+jm1xSx7/Pqbs2nna45h
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="462280503"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="462280503"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 07:38:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="805302614"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="805302614"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 07:38:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rFye6-00000007abX-0HKe;
	Wed, 20 Dec 2023 17:38:06 +0200
Date: Wed, 20 Dec 2023 17:38:05 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, jringle@gridpoint.com,
	kubakici@wp.pl, phil@raspberrypi.org, bo.svangard@embeddedart.se,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, stable@vger.kernel.org
Subject: Re: [PATCH 01/18] serial: sc16is7xx: fix segfault when removing
 driver
Message-ID: <ZYMKXahWqvsGdy77@smile.fi.intel.com>
References: <20231219171903.3530985-1-hugo@hugovil.com>
 <20231219171903.3530985-2-hugo@hugovil.com>
 <ZYMJhKvGAFgj9phL@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYMJhKvGAFgj9phL@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Dec 20, 2023 at 05:34:29PM +0200, Andy Shevchenko wrote:
> On Tue, Dec 19, 2023 at 12:18:45PM -0500, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

...

> > +	dev_set_drvdata(dev, NULL);
> 
> I believe this is wrong approach to fix the issue as this one is prone
> to be cleaned up in the future as we don't do this call explicitly for
> the past ~15 years.

On top of that the ->remove() is not the only uart_remove_one_port() call.
It has a lot of other stuff to go with.

It seems that ->remove() doesn't check the bit in &sc16is7xx_lines, that
might be the proper fix for the issue you have.

-- 
With Best Regards,
Andy Shevchenko



