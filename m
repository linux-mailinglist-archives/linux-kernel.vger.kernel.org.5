Return-Path: <linux-kernel+bounces-81731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1931867978
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701271F2E6D0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554E5131E52;
	Mon, 26 Feb 2024 14:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VnFVGuTE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F79A12B15F
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708958739; cv=none; b=pETBAZVT2k68QwNrN9QGctL7s6O1mXUCxcTrbtHh8rQ9OnDsjc0HAb949R2Dchv7WPuIIFPfRUXVcFw1NOIpKfNiMblP6etpr+5lf322pnir7TMkIsuwyuIVszqajyhru6szJg6u7IZPy2Zvuf6B9/q7eSPy8s0jr/ZyQgNsUHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708958739; c=relaxed/simple;
	bh=eJkehOGsWcnIAv2C7aKxVAn/Nm5vdYM89SPCXjmFqkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flcfX4M8OnAbsxaFgUXK1ayAXLFAyPL/wf2Gi7A5iE4kfOa/iwMFZQ7BxIleBoZ92uC9/i/FPpSs19+6Fr1mehFXtDEegVdgW91IaZgH/I38OP5VhW6AmDNWCdU9M/GBbdKlbf5BtCKgbXd26ROsgY3owIx2IWr1os4RAU35wxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VnFVGuTE; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708958738; x=1740494738;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eJkehOGsWcnIAv2C7aKxVAn/Nm5vdYM89SPCXjmFqkE=;
  b=VnFVGuTE2ukPaJQOeiZxgaBiv22ES7fxJfgEw4OsQ090GZoQDJXEGk/z
   UClCMCSer0oLx5C0CS6skMStaT+6JEShT1kmRdJabN8wT1Cff6zMDMdrV
   0HofjFmIjHhs4uCjHc2Rew2fPx8s3FZ5fV/12Y5Jh4ZhajHGbYlfUa8z0
   d0BeQlMXSOjO4f+a09Xy6N5s8o7eBFdC5YgsB+ZiV9uGRg+QCdBH9OM0S
   q7HuxA851tIJ8pn9dRzNWOhXCETdURmkhXrgbyUCQe19x2nr8a4N6N4nb
   ooK2ujqfmusRouwvlzv6ydXPhSZG+6JlVypyoiDIgMCOxZ5KqeH61y09o
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="14681565"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="14681565"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:45:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="913874071"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="913874071"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:45:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1recEW-00000007hsz-1jZ9;
	Mon, 26 Feb 2024 16:45:32 +0200
Date: Mon, 26 Feb 2024 16:45:32 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shahar Avidar <ikobh7@gmail.com>
Cc: gregkh@linuxfoundation.org, luca.ceresoli@bootlin.com,
	benjamin.tissoires@redhat.com, elder@linaro.org, robh@kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] staging: pi433: Remove a duplicated F_OSC define
Message-ID: <ZdykDGo9fMw5fEdp@smile.fi.intel.com>
References: <20240225173341.1278918-1-ikobh7@gmail.com>
 <20240225173341.1278918-2-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240225173341.1278918-2-ikobh7@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Feb 25, 2024 at 07:33:38PM +0200, Shahar Avidar wrote:
> F_OSC is already defined & only used by rf69.c source file
> Also fix define comment

You missed periods at the end of the sentences.

..

> -#define F_OSC	  32000000 /* in Hz */
> +#define F_OSC	  32000000 /* Hz */

Instead of having a comment you can

  #include <linux/units.h>
  ...
  #define F_OSC	  (32 * HZ_PER_MHZ)

which will be more robust code (no need to count 0s).

-- 
With Best Regards,
Andy Shevchenko



