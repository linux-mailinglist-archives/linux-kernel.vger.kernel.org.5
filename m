Return-Path: <linux-kernel+bounces-76741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5804285FBD6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1245C284EE7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E110148FF9;
	Thu, 22 Feb 2024 15:06:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2A41487EA;
	Thu, 22 Feb 2024 15:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708614359; cv=none; b=K9R6WR+yNmhXAZ2uGUCAAOo0R/aqYcpcwh+86j5dD6psGQMzCOmpsm9Yo5mQOOyMXxBaFwp7GiG6sbBP91LoBWkvCI13FchIxmMsP4HxRD2/69yorF3XhHkr+Lz9Z8dBBii+8hPaAcwOnJpha6/1EnpSExGtbzC/JjeZOZkdE3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708614359; c=relaxed/simple;
	bh=cd+fw1zjVFNNUYAipYH+nLzvBTj6aKd7CiyHwblYLZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+Yt8bPQaTsRlM7DnnqgCwKVcXHiDEgx4iC8PgHPukLANCqkX2d7ARbR76M7l+Rqxe32eg6YtSSUivB5m2J4I++R90l3m4DkrDfY+k3lN9RSWiub/bt7gUXx7b/tnGwd2lf7tAncODCao/G6EW6rieoqKcTPfc7z9XNOsbSCWeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="2707034"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="2707034"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 07:05:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="913539729"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="913539729"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 07:05:56 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1rdAe1-00000006eu7-2MCA;
	Thu, 22 Feb 2024 17:05:53 +0200
Date: Thu, 22 Feb 2024 17:05:53 +0200
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: Use serial8250_do_set_termios for uartclk
 updating
Message-ID: <Zddi0S0Esw-dUVIV@smile.fi.intel.com>
References: <20240222145058.28307-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222145058.28307-1-fancer.lancer@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 22, 2024 at 05:50:56PM +0300, Serge Semin wrote:
> The serial8250_update_uartclk() body was created based on the several
> method calls copied from the serial8250_do_set_termios() function. Seeing
> aside with some other things the later method can update the baud rate
> based on the new reference clock let's just call it instead thus
> simplifying the code a bit.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Link: https://lore.kernel.org/linux-serial/ZczD7KPbeRnY4CFc@black.fi.intel.com
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

Thank you! This looks like a good simplification and turning to "one source" of
the same flow principle.

Assuming that it's working on your hardware,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko



