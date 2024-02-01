Return-Path: <linux-kernel+bounces-48352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C585A845ACC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67211B232FB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA815F496;
	Thu,  1 Feb 2024 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QFv6ol2k"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA7038DCC;
	Thu,  1 Feb 2024 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706799786; cv=none; b=kar08yHxC+7RNfA9NPrcE22knPu5rW/0dOeWpOkRtzBoe7+UNQslOIJg/t0vfP3HaJtdwKuxvLFr/HZcJoJAnZKOFSHEGOzXzN7hTW0x21ImobwRl4QiqR0b1mpgakTkkda/VpFkiOMoxXEyYk5FeZt3hHVoV/d95ioSicPpGwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706799786; c=relaxed/simple;
	bh=sNXUraVborZXj4QhItcVoPEZab80kO5mGvnyG6+Imf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJyeS8BEpAFy2uOmf5MHdbjXxIFD8484lSUEepdozSOdmipsvPwvIpnHMTHHckhIGp8xxnwYan6CrLk0nMZCIVMLc5rRjFTkeIFSI20850GsIZdMdKAlgXJ/uPhrs3rT5kw5ghG6Vbt0VY37n4uB49e4cUhLXYH/eVZIp6JT7dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QFv6ol2k; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706799784; x=1738335784;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sNXUraVborZXj4QhItcVoPEZab80kO5mGvnyG6+Imf0=;
  b=QFv6ol2k68sFX6tMYvHiWbuwl7Bs1RBk+taHufMEluBK2NvGmoVDB5vQ
   WWgsGXvTPxcPW1hf++uLncVC/jCnUvmlsTaixEFa73Qzy9JsnqoWVgSJ2
   rcOpZXsdXYA5Hb4yH6RjHzQTxYTmcl3DJ1Kv8+R9jzeCFFpRW1VSlY4ZP
   aoYmSSy1bqgdKsO8qbxqcoqfWRQAZUPN3AcwXzJBqZDSOvXEe6GdbbpT6
   pkJlva7aSzT8bWmVmejPs6XgBoeFYZNA9hZbagStmj0P3S3qtbkumeubr
   Smn+bDIEwv8FhtA/vNgzIFrm1BjBx+9JbF/B0/x8fe2Cet4R9tryKeczY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="2846642"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="2846642"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 07:03:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="788948476"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="788948476"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 07:03:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rVY5G-00000000rG3-3PRt;
	Thu, 01 Feb 2024 16:30:30 +0200
Date: Thu, 1 Feb 2024 16:30:30 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arturas Moskvinas <arturas.moskvinas@gmail.com>
Cc: linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	akaessens@gmail.com, thomas.preston@codethink.co.uk,
	preid@electromag.com.au, u.kleine-koenig@pengutronix.de,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pinctrl: mcp23s08: Check only GPIOs which have
 interrupts enabled
Message-ID: <ZburBq7ZJhK_X_t0@smile.fi.intel.com>
References: <20240201141406.32484-2-arturas.moskvinas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201141406.32484-2-arturas.moskvinas@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 01, 2024 at 04:14:07PM +0200, Arturas Moskvinas wrote:
> GPINTEN register contains information about GPIOs with enabled
> interrupts no need to check other GPIOs for changes.
> 
> Signed-off-by: Arturas Moskvinas <arturas.moskvinas@gmail.com>
> ---

You forgot to add a changelog here, but no need to resend, just you can respond
to the email since it's not a big issue in this case.

..

> +	if (mcp_read(mcp, MCP_GPINTEN, &gpinten))
> +		goto unlock;

Do all hw variants have this register available?
Esp. I2C part, wouldn't it be problematic (exception with NACK on the bus)?

..

The rest LGTM, thanks!

-- 
With Best Regards,
Andy Shevchenko



