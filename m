Return-Path: <linux-kernel+bounces-41651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0B583F5E3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 15:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98C871F211CD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 14:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17491E51F;
	Sun, 28 Jan 2024 14:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jwls1GSd"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4F924B2C;
	Sun, 28 Jan 2024 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706452692; cv=none; b=AApK9YuRkmG8UmDbi2uA8pBRgkeeYZPARfzt4fBXPEFy9BT9UtVFSTMUdu4P++R7k0kIiMBi4JD5riQgkVGhmY0x13KmcLqMh/XJzyKScI7x12+sM3sZG4/MS4fqObJc1mPo9a4rnDLF6Si9D3nV94YwZy0R1rFbgfUsGiK/w6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706452692; c=relaxed/simple;
	bh=ANwtYKhLvju5//43bnHV/uOQimOHUSPddVFPoST5fb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6vptIKg9cjcKXmhJvcx2mbFpkRkmp1GadPVz0QCzt8yLmHretONER2IHfUFtwuVqLg7UePco8TQ1rreVSIeVXuiDWLBLQdtTpsotfQS8245+B35yzJ8NCN500eQAtnQmOniNUQKxH5njzaUiG9BIctVfIVRItZDv5K8hE5LUIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jwls1GSd; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706452690; x=1737988690;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ANwtYKhLvju5//43bnHV/uOQimOHUSPddVFPoST5fb4=;
  b=Jwls1GSdyA4V5DcPsoENmvwxyMFanY+KCijv3NMnmoebcSEg82xMdALB
   tNvsBukrH7t/1UdMUSaPHnzspgOXsaqgWu0dJhFUiiDnQmvDY2cwyWtMk
   rmo6u5f2UaqPw4MCNLrF5ifalFkQNwiVFz1vnhBCBeZEfPh4l0IAWMABl
   PGPzQ3S1/PRm95j/Ti+TI5mCHRpYDlHkH1eevc2//iZY8z5vHEbp0cfLe
   kN0FeE24QZQh1GLZL5jau725WeB6PUa5l9oGIJ/uLXJIIgaKOOTHKYc5t
   PovDndfJ6riEcBp8kDUOJ9WRITgVEu0ss6UGAwKiMsMR3yhnbDU46s8Ga
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="399932777"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="399932777"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 06:38:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="906818358"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="906818358"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 06:38:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rU6IO-0000000HTqZ-2aVl;
	Sun, 28 Jan 2024 16:38:04 +0200
Date: Sun, 28 Jan 2024 16:38:04 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v1 1/4] backlight: hx8357: Make use of device properties
Message-ID: <ZbZmzC6A_TxGvEWm@smile.fi.intel.com>
References: <20240114152759.1040563-1-andriy.shevchenko@linux.intel.com>
 <20240114152759.1040563-2-andriy.shevchenko@linux.intel.com>
 <20240124171953.GA15539@aspen.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124171953.GA15539@aspen.lan>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jan 24, 2024 at 05:19:53PM +0000, Daniel Thompson wrote:
> On Sun, Jan 14, 2024 at 05:25:08PM +0200, Andy Shevchenko wrote:

..

> > +typedef int (*hx8357_init)(struct lcd_device *);

> > +	hx8357_init init;
> 
> As somewhere else in this thread, I'd find this a lot more readable
> as:
> 	hx8357_init_fn init_fn;

I agree with you, dunno why I haven't added _fn in the first place...

-- 
With Best Regards,
Andy Shevchenko



