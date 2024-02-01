Return-Path: <linux-kernel+bounces-48062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D59C8456CA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE4FF289EA0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230C915DBA9;
	Thu,  1 Feb 2024 12:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aJkbIrqw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405FA15DBDB;
	Thu,  1 Feb 2024 12:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789012; cv=none; b=M9uLDjHtrk1viMbmhn8v2hJ98gPpfSSa3ViLhuPPrGi3U2zg3BjvzzAI8Egl8ZPwvVJSTTWEmojKZ5sTkrYnYmdBwGBu3NoG8YWAw725E2r9OV5MnZzD2zpa/G/Ws7oXzT6vYMRvEeQuQDIi1gBLn4/Q+HqS4M3Ur+A1ip7JFm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789012; c=relaxed/simple;
	bh=2SUmf9R/YYigzJmyWuD8soVbsph5ihQXY0L6ZAEW93E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jghUdXMq5apFU1KJdjOSXrIvvLRSOVBoDBEC3lk79g/2DpdQ1lAq8tV5aErm8Bfo/c4AmzZnIIPhFyf0zSLPRpPEnfN3eFvIWptHU7R4sKpCPN8wNi0E9kFRJwBcQ+f3J3UFq/2W5QYRDIm5ag+ntIMCXf2k1uLVDA8+CwsNSyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aJkbIrqw; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706789010; x=1738325010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2SUmf9R/YYigzJmyWuD8soVbsph5ihQXY0L6ZAEW93E=;
  b=aJkbIrqwVXj/FiKd2A1sE6hQ73o2PHm33kmqbC8gZ9xvZTzSmISXnJql
   dAKFnJoqVHfb0vD+Pn4CXeKWt3Tv6Rlv9PPJ6Kl9WzaGS7dXiR1QAxwxx
   JaCS4Hqe98aY1HxqVhdnkNhaggyrnclJJer9RuM1MVa7NHSeW+QOdCTUw
   iN57H9zyAtNkrRJ5l0cocTNyAcxl/CGa2t6DQxoLNxHIksgpvT8Gxlax3
   TlkymFZ5IlDRMCOWZzFtNb6jIBhHCJU/+HUYATty/+O6/kprKYl/el6Hj
   la8/xhSebEY93Ru3WCgFQvhWN1gtPK+uMxob799hA6UC7358oF4B0lDe4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10630044"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="10630044"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 04:03:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="912106710"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="912106710"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 04:03:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rVVMt-00000000os0-1uN7;
	Thu, 01 Feb 2024 13:36:31 +0200
Date: Thu, 1 Feb 2024 13:36:31 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arturas Moskvinas <arturas.moskvinas@gmail.com>
Cc: linus.walleij@linaro.org, u.kleine-koenig@pengutronix.de,
	radim.pavlik@tbs-biometrics.com, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: mcp23s08: Check only GPIOs which have
 interrupts enabled
Message-ID: <ZbuCP4rN_DEsH-Un@smile.fi.intel.com>
References: <20240130073710.10110-1-arturas.moskvinas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130073710.10110-1-arturas.moskvinas@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jan 30, 2024 at 09:37:10AM +0200, Arturas Moskvinas wrote:
> GPINTEN register contains information about GPIOs with enabled
> interrupts no need to check other GPIOs for changes.

..

> +	if (mcp_read(mcp, MCP_GPINTEN, &gpinten))
> +		goto unlock;

> +	enabled_interrupts = gpinten;

Move this line to be...

..

> -	for (i = 0; i < mcp->chip.ngpio; i++) {
> -		/* We must check all of the inputs on the chip,
> -		 * otherwise we may not notice a change on >=2 pins.

..just here (w/o any blank line in between).

> +	for_each_set_bit(i, &enabled_interrupts, mcp->chip.ngpio) {

..

> +		/* We must check all of the inputs with enabled interrupts
> +		 * on the chip, otherwise we may not notice a change
> +		 * on >=2 pins.

Missing space after =. But better to spell in proper English, i.e.
"...great than or equal to 2 pins."

>  		 *
>  		 * On at least the mcp23s17, INTCAP is only updated

/*
 * Use proper multi-line
 * comment style as depicted
 * in this example.
 */

-- 
With Best Regards,
Andy Shevchenko



