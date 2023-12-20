Return-Path: <linux-kernel+bounces-7173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC4B81A2BC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E0A028A7D5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86B5405C9;
	Wed, 20 Dec 2023 15:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MQn9GWxH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614133FB03;
	Wed, 20 Dec 2023 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703086476; x=1734622476;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MCpjHy60vOZcPxidi339EczwHIe1GscXSj0PrPScous=;
  b=MQn9GWxH88N5mBhGGCicBeTWvYlTtt2CQxecuIPNEJjtBcfGNJTF+dDS
   za9WxD7qvJr0vatwH5nDrzmU75mSexXgH5Qrc4vjTDokiJx4GYioCOID/
   SUfg8zsmaTaB+cOy3Ox4kwPpF+BdY+0CJECcqW6QEwpjy2OV7nWLE3M/O
   Muuxy3lnAJ1XwGesr7/MOnN67YBRtgXYazaujVPgmbCJDx//OCjlOw0As
   PjJ+tdA8lP7ihhZAZhEGNQf1DZaDWGcv6Tmh0Z29RkeAdml7h5L38QRaP
   haUwlzseISZjgKEU4HBrHubj5PuwPQMC1t8iaov6JICftxLgffs6fao/v
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="2921206"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="2921206"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 07:34:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="810636058"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="810636058"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 07:34:32 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rFyab-00000007aYe-0DyS;
	Wed, 20 Dec 2023 17:34:29 +0200
Date: Wed, 20 Dec 2023 17:34:28 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, jringle@gridpoint.com,
	kubakici@wp.pl, phil@raspberrypi.org, bo.svangard@embeddedart.se,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, stable@vger.kernel.org
Subject: Re: [PATCH 01/18] serial: sc16is7xx: fix segfault when removing
 driver
Message-ID: <ZYMJhKvGAFgj9phL@smile.fi.intel.com>
References: <20231219171903.3530985-1-hugo@hugovil.com>
 <20231219171903.3530985-2-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219171903.3530985-2-hugo@hugovil.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 19, 2023 at 12:18:45PM -0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> If a problem with a device occurs during probing, and we subsequently
> try to remove the driver, we get the following error:
> 
> $ rmmod sc16is7xx
> [   62.783166] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000040
> [   62.994226] Call trace:
> [   62.996672]  serial_core_unregister_port+0x58/0x2b0
> [   63.001558]  serial_ctrl_unregister_port+0x18/0x30
> [   63.006354]  uart_remove_one_port+0x18/0x30
> [   63.010542]  sc16is7xx_spi_remove+0xc0/0x190 [sc16is7xx]
> Segmentation fault
> 
> Tested on a custom board with two SC16IS742 ICs, and by simulating a fault
> when probing channel (port) B of the second device.
> 
> The reason is that uart_remove_one_port() has already been called during
> probe in the out_ports: error path, and is called again in
> sc16is7xx_remove().
> 
> Fix the problem by clearing the device drvdata in probe error path to
> indicate that all resources have been deallocated. And only deallocate
> resources in sc16is7xx_remove() if device drvdata is non-null.

...

> +	dev_set_drvdata(dev, NULL);

I believe this is wrong approach to fix the issue as this one is prone
to be cleaned up in the future as we don't do this call explicitly for
the past ~15 years.

-- 
With Best Regards,
Andy Shevchenko



