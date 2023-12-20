Return-Path: <linux-kernel+bounces-7181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A64A181A2DF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91601C21725
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD49405D0;
	Wed, 20 Dec 2023 15:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Te+UTjxE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950CD41212;
	Wed, 20 Dec 2023 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703086850; x=1734622850;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z45D4Vtu6D/KyysKwwEbSvOt+bIakQUcLyQ51yCetko=;
  b=Te+UTjxEG2SL288QIdY+yFQ9BYjA/J95uXg5NSoCXFz32iauF7WEQcu3
   xyzsiwXWaBD0c9CgwZO6SV1vTx7zlfptPSwJa96uBNFC/X8dzojBf3W0y
   umvOiwSZvc4mzutLuxgQxDJNhYiWmMJVd0NjoUY6VT9YL88/PHiWZvcpW
   IQqqVi7SsOaU8Wf8FkTUAvmlW0D6Wuui2lxZ4dJHADfIzQPIS07SplqPS
   a0em+Naj8qOLB2xmTD/umA/NCgEhK3p98dyzHELQbX7zUlqIB+jmjE9A3
   XuG/drOA0JWjdy6s3IqN60gpjiyrMaxZAxPqE0qAe5fe28vGdWBxdMp60
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="460173996"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="460173996"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 07:40:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="769623530"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="769623530"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 07:40:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rFygd-00000007ad6-02kC;
	Wed, 20 Dec 2023 17:40:43 +0200
Date: Wed, 20 Dec 2023 17:40:42 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, jringle@gridpoint.com,
	kubakici@wp.pl, phil@raspberrypi.org, bo.svangard@embeddedart.se,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, stable@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH 02/18] serial: sc16is7xx: fix invalid sc16is7xx_lines
 bitfield in case of probe error
Message-ID: <ZYMK-l03S86Nw19I@smile.fi.intel.com>
References: <20231219171903.3530985-1-hugo@hugovil.com>
 <20231219171903.3530985-3-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219171903.3530985-3-hugo@hugovil.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 19, 2023 at 12:18:46PM -0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> If an error occurs during probing, the sc16is7xx_lines bitfield may be left
> in a state that doesn't represent the correct state of lines allocation.
> 
> For example, in a system with two SC16 devices, if an error occurs only
> during probing of channel (port) B of the second device, sc16is7xx_lines
> final state will be 00001011b instead of the expected 00000011b.
> 
> This is caused in part because of the "i--" in the for/loop located in
> the out_ports: error path.
> 
> Fix this by checking the return value of uart_add_one_port() and set line
> allocation bit only if this was successful. This allows the refactor of
> the obfuscated for(i--...) loop in the error path, and properly call
> uart_remove_one_port() only when needed, and properly unset line allocation
> bits.
> 
> Also use same mechanism in remove() when calling uart_remove_one_port().

Yes, this seems to be the correct one to fix the problem described in
the patch 1. I dunno why the patch 1 even exists.

As for Yury's patch, you are doing fixes, so your stuff has priority on his.

-- 
With Best Regards,
Andy Shevchenko



