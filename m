Return-Path: <linux-kernel+bounces-119315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 884FB88C6F4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54C011C63E36
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B8413C90D;
	Tue, 26 Mar 2024 15:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A/vLvjET"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A88513C83C;
	Tue, 26 Mar 2024 15:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466959; cv=none; b=rxwAPz+qzs3nIqXt2UIHu/Q5G710Te6CrtSQG23FHOaV/4Mzdw39cfb/MLZ2E2arU0sqRiZSrQIed+4n1cNVpT5zwmnDg5MmKmQXA2x6pYmfI0X4Xm3dm9fMAVb3m3YyxJYVYVcUaQkn9on6LCAiOkHqtl2gZVhZhUKsJXOn6Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466959; c=relaxed/simple;
	bh=GIOVKygProOFQxNSEBqrYix0YouMUJ42MxRavpDOBV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4P5weSNWjvLulwoPa3/2MYao8uIfMlSobZ5n27GKruazoAsce9c39vHty6DuXYaNzhN7wDnG5ODCaMDUWHL1FyGAG06bosRXA5OJ8lZjTLZhbCLR6RdVrqhoFeVZ3Wqcr7xQPl8t9JBIu1JemDCpcnLIJOiFw4xbz1D0AtGCRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A/vLvjET; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711466958; x=1743002958;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GIOVKygProOFQxNSEBqrYix0YouMUJ42MxRavpDOBV8=;
  b=A/vLvjETfH7Ku9SY8f6IUFXJKgDWc2qxBoHt///XAn162LlMPe2udIx3
   ZPdlPSmCJ7GtE5A7H2ZG6m4C+kNHJfkxnMKMutZvEkrDPQVHWVBu/8aQc
   Vy+bgact5r8n5GnCwsMhXC/PgRH5GqWVCqb+EbQsxBb24dkgKEKdj7hFu
   M51N7YDcIcVouOz39xlyEpT8DWwTHkuqeQ2dIu1VtTGEuy+BW7lganGo6
   RsE7EDqmFCWBRUZjMBLG342dFFY0xyax9JNjmb03JB9wE9xYBY769H99z
   JURdujmwDokftR7gEcOIgv/NJtujoauojRWP/gp4bMWrrBG+a6dClq1YS
   w==;
X-CSE-ConnectionGUID: Ou5j85P0RCa71qhaLiAUHw==
X-CSE-MsgGUID: z5DnR3BWRp+8JBjPwnm8ug==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6420442"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6420442"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 08:29:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="914883352"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="914883352"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 08:29:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rp8jh-0000000GL6G-0OaB;
	Tue, 26 Mar 2024 17:29:13 +0200
Date: Tue, 26 Mar 2024 17:29:12 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
	linux-modules@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v3] module: don't ignore sysfs_create_link() failures
Message-ID: <ZgLpyDIsHThTT_KG@smile.fi.intel.com>
References: <20240326145733.3413024-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326145733.3413024-1-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 26, 2024 at 03:57:18PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The sysfs_create_link() return code is marked as __must_check, but the
> module_add_driver() function tries hard to not care, by assigning the
> return code to a variable. When building with 'make W=1', gcc still
> warns because this variable is only assigned but not used:
> 
> drivers/base/module.c: In function 'module_add_driver':
> drivers/base/module.c:36:6: warning: variable 'no_warn' set but not used [-Wunused-but-set-variable]
> 
> Rework the code to properly unwind and return the error code to the
> caller. My reading of the original code was that it tries to
> not fail when the links already exist, so keep ignoring -EEXIST
> errors.

> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>

Wondering if you can move these to be after --- to avoid polluting commit
message. This will have the same effect and be archived on lore. But on
pros side it will unload the commit message(s) from unneeded noise.

..

> +	error = module_add_driver(drv->owner, drv);
> +	if (error) {
> +		printk(KERN_ERR "%s: failed to create module links for %s\n",
> +			__func__, drv->name);

What's wrong with pr_err()? Even if it's not a style used, in a new pieces of
code this can be improved beforehand. So, we will reduce a technical debt, and
not adding to it.

> +		goto out_detach;
> +	}

..

> +int module_add_driver(struct module *mod, struct device_driver *drv)
>  {
>  	char *driver_name;
> -	int no_warn;
> +	int ret;

I would move it...

>  	struct module_kobject *mk = NULL;

..to be here.

-- 
With Best Regards,
Andy Shevchenko



