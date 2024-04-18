Return-Path: <linux-kernel+bounces-149808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 820438A9619
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A660283D49
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE5D15AD8F;
	Thu, 18 Apr 2024 09:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aTPzgFRY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C6715B570;
	Thu, 18 Apr 2024 09:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713432258; cv=none; b=czwU7yAK2i9zR/zFPrdDZPKPXM6eT5+J22OvhGNg+2SaD9KSRuy6OOSY991JBuCNcs6G7R5SS4JbzgF4SLXGxcYudo986D+SMwbbWzzyiR1ZMytOVF1IemBnjo8m9rCpsRFwNBgD/GD2tvsvRPg3sovu/NFeKMPEx0pv6TlstVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713432258; c=relaxed/simple;
	bh=U1AlG7GPSbT464wLiCA+lZkn+DfPs+8Zs9M+XjjoA1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esNOwSx1SjXl0aqkcZHZU2DfNI0vNsAYRZm+n2m/yXx+biFXy5YXd1D4DleLcsuYSvan7ZGz+xF0JDU+uLvZUsnI3zTaeJy+bVVSa2ZupLtuBEuL08caqU1wYtHsMlLvakeJgsHbm88/RPr9A6t7J1QcZcKb07oDjz6ivqGJ3bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aTPzgFRY; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713432257; x=1744968257;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U1AlG7GPSbT464wLiCA+lZkn+DfPs+8Zs9M+XjjoA1w=;
  b=aTPzgFRYBkMB7ArLTQJVJmFZUVpFrCbeQ3Mv0gFtX8o7kr4ihhgqR4F2
   o2/Z3fdBf18rfKPNMj5azAFAp+BASWxUvCXbe6rijvspVmtWLeC819eAY
   /UsryfoW++A9fYFGEHxir2D4K9nDl7pD5lo8w4V5/zjqjJT/KLIBPFRF4
   6xoOn3y8JULvW4nTjSfmMddq0IeE12osYzjhpgkspqIygKJoCeKynTDDi
   l5gp8+3VCG9+WijSESCnZmBRbdISRW7xVt32SS8d3PsXIhtkausznP6uA
   YXMBgj2mficAwDQe2xSxDkrPhaioAzO60Osv/QBAaVgdN7ckGHVXm3Y3a
   g==;
X-CSE-ConnectionGUID: ACigW82zQwGkwSmcfjjm1A==
X-CSE-MsgGUID: cB75FagKSS6b+KVG55qUTw==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="12804648"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="12804648"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 02:24:17 -0700
X-CSE-ConnectionGUID: 3vZ+XjlFTrusF1KnzFOdig==
X-CSE-MsgGUID: nJYqE6E2RciLrJ+EfpsRcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="23528795"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 02:24:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rxO04-00000000HZt-2Nzk;
	Thu, 18 Apr 2024 12:24:12 +0300
Date: Thu, 18 Apr 2024 12:24:12 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 2/2] gpiolib: acpi: Set label for IRQ only lines
Message-ID: <ZiDmvEw7dTWn5mA-@smile.fi.intel.com>
References: <20240417103829.2324960-1-andriy.shevchenko@linux.intel.com>
 <20240417103829.2324960-3-andriy.shevchenko@linux.intel.com>
 <20240418044950.GP112498@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418044950.GP112498@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 18, 2024 at 07:49:50AM +0300, Mika Westerberg wrote:
> On Wed, Apr 17, 2024 at 01:37:28PM +0300, Andy Shevchenko wrote:
> > When line locked as IRQ it has no label assigned. Assign
> > the meaningful value to it.
> 
> Same here.

Same answer as in the first reply.

-- 
With Best Regards,
Andy Shevchenko



