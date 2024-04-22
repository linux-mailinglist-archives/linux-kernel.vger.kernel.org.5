Return-Path: <linux-kernel+bounces-153372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 984048ACD41
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 556E32826FD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C14114A09E;
	Mon, 22 Apr 2024 12:49:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426EC146011;
	Mon, 22 Apr 2024 12:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713790165; cv=none; b=EKXT7GYMN1NcRCiPLWSLxAl+FtMq4LcvpekbH0mjmQ9ndDWAXVCxXSiONJKjH4q8jlqocK/UHI23ryl+683rOuQnNxqQSt42f8lGkwwI7X1LT4RH85TBTwT7Tz7Osu/EZqDxo2M3OHfX9rDdrCExHA3PCIxQdDhq5YNX5/NtV5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713790165; c=relaxed/simple;
	bh=t4UHjuj+d/K/lNATspsn1mjTNAh1Hn+pGTWUW38Q4K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMGrkTmbVqhsEGM7WqXF6wOFK5Pwi/KBE3p1vFmEF6cbK0OywfI9AtRB30UoyBrip3lX4ybfUZBGgmB9G/rALxVXF0U4DQGxUSUwG87dIK7aGFkAsyy5R0trWiSiVGzJtKaMwtwEw40knBDBCGfB5kTshg4yvRlUX3btXKRSf8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: NBLrMRuGSTiUr9k/z4gArg==
X-CSE-MsgGUID: muiuPbSwQBG8fhDhI2ochQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="20725179"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="20725179"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 05:49:23 -0700
X-CSE-ConnectionGUID: 8L/NvYCbSjaclNgkXsf7dw==
X-CSE-MsgGUID: DPEoVRMYQq6hdm17l03wSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="23878063"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 05:49:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1ryt6g-000000003dr-14U3;
	Mon, 22 Apr 2024 15:49:14 +0300
Date: Mon, 22 Apr 2024 15:49:14 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Konstantin Pugin <rilian.la.te@ya.ru>
Cc: krzk@kernel.org, conor@kernel.org, lkp@intel.com, vz@mleia.com,
	robh@kernel.org, jcmvbkbc@gmail.com, nicolas.ferre@microchip.com,
	manikanta.guntupalli@amd.com, corbet@lwn.net, ychuang3@nuvoton.com,
	u.kleine-koenig@pengutronix.de, Maarten.Brock@sttls.nl,
	Konstantin Pugin <ria.freelander@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v6 1/3] serial: sc16is7xx: announce support of
 SER_RS485_RTS_ON_SEND
Message-ID: <ZiZcyhoKRgfteO5d@smile.fi.intel.com>
References: <20240422123801.2695129-1-rilian.la.te@ya.ru>
 <20240422123801.2695129-2-rilian.la.te@ya.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422123801.2695129-2-rilian.la.te@ya.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 22, 2024 at 03:37:55PM +0300, Konstantin Pugin wrote:
> From: Konstantin Pugin <ria.freelander@gmail.com>
> 
> The hardware supports both RTS_ON_SEND and RTS_AFTER_SEND modes, but
> after the commit 4afeced55baa ("serial: core: fix sanitizing check for
> RTS settings") we always end up with SER_RS485_RTS_AFTER_SEND set and
> always write to the register field SC16IS7XX_EFCR_RTS_INVERT_BIT, which
> breaks some hardware using these chips.

LGTM, but I leave it to Hugo for testing and other comments, if any,
as I don't have a HW.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

-- 
With Best Regards,
Andy Shevchenko



