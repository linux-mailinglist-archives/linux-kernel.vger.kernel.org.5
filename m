Return-Path: <linux-kernel+bounces-32065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B210C8355EF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 14:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E580E1C22088
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 13:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543893717F;
	Sun, 21 Jan 2024 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bFtsE/kJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF037273FB;
	Sun, 21 Jan 2024 13:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705843793; cv=none; b=s/onxu/J+eo2QAHXCcLy0InD41Eq7LD+EatSza69q9Fp/xEicErTsXdIe9wcdEcjPWAqlwCy8ncQ0Tfq2dTOPZNGs/spfjZaKigwzNGW/BHHG3dQaPCPkRT1+Qf0MvC1+R5VcocKFnjrE4or8Jk5MQ2QH487pqQ07svFHZg36yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705843793; c=relaxed/simple;
	bh=sxYYYs4lyOVZUnzoUjZf9ycyeZ4JTQhXdYqfoan8CJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooqBz76x4AYrr63/IZ7OvugdeYR8M37aw4Ik2NwHnxXnWKIksMQqVbbVzRsqnRvDoXWUDkyPLraS9p+wawGxUdQT1/eSvukM3XrXU2i029h9gUqiMrS/ok7lRH2C7GGgDAMjHWz8982UwHOwrDmf8mAoXte4Z1dXlcRSSKf5n+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bFtsE/kJ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705843792; x=1737379792;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sxYYYs4lyOVZUnzoUjZf9ycyeZ4JTQhXdYqfoan8CJo=;
  b=bFtsE/kJktGMiznAsMkHlfWxgQv8JAaq+gncI+SwuIbHgZvO3iRYvvJt
   g+E2GcpGGyE2gpX7kPqXnbDVPFM6AcQIRd6TlTZ2HsbcezA5qqTViQPdw
   AcKqzvKgyvuErgoQCt0uPK44en0OnRgTjZlTsuVmdnyh5e9sj7o/YZKhr
   EYFfSYNT4jXHrepaxZ4blyjcnjilu3FQsJUQuUFSLg48K3i8zWqF2DTbO
   E60/vc/0szzt7zHITxvzfA+a+Bd47nm0vU55216bqu4c8AoykExRMG7sv
   CoayK1BkuQAE/MhIygZBOfvx7BCgNPAriqSNU7lJu8DW2ap+cW17AezwB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10959"; a="14541413"
X-IronPort-AV: E=Sophos;i="6.05,209,1701158400"; 
   d="scan'208";a="14541413"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 05:29:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="1116630109"
X-IronPort-AV: E=Sophos;i="6.05,209,1701158400"; 
   d="scan'208";a="1116630109"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 05:29:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rRXoA-0000000FdSz-2EDX;
	Sun, 21 Jan 2024 15:24:18 +0200
Date: Sun, 21 Jan 2024 15:24:18 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Richard Acayan <mailingradian@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hardik Gajjar <hgajjar@de.adit-jv.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: u_ether: Re-attach netif device to mirror
 detachment
Message-ID: <Za0bAlnCHXTX7Ih9@smile.fi.intel.com>
References: <20231218164532.411125-2-mailingradian@gmail.com>
 <Za0a3tVpml9c0VFv@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Za0a3tVpml9c0VFv@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Jan 21, 2024 at 03:23:42PM +0200, Andy Shevchenko wrote:
> On Mon, Dec 18, 2023 at 11:45:33AM -0500, Richard Acayan wrote:
> > In 6.7-rc1, there was a netif_device_detach call added to the
> > gether_disconnect function. This clears the __LINK_STATE_PRESENT bit of
> > the netif device and suppresses pings (ICMP messages) and TCP connection
> > requests from the connected host. If userspace temporarily disconnects
> > the gadget, such as by temporarily removing configuration in the gadget
> > configfs interface, network activity should continue to be processed
> > when the gadget is re-connected. Mirror the netif_device_detach call
> > with a netif_device_attach call in gether_connect to fix re-connecting
> > gadgets.
> 
> Tested-by: From: Andy Shevchenko <andriy.shevchenko@linux.intel.com> # Intel Merrifield

Sorry, now correct tag.

Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com> # Intel Merrifield

-- 
With Best Regards,
Andy Shevchenko



