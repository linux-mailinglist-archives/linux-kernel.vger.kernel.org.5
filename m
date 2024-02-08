Return-Path: <linux-kernel+bounces-58446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2A884E699
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA5272914A4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B0F81AC7;
	Thu,  8 Feb 2024 17:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OIbJRjz/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3047EEFA;
	Thu,  8 Feb 2024 17:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707412979; cv=none; b=uIn7EXU4+NsCTeYfTEPi8h6SA31XebJenG0wmR3Ex5Z3WfGG+5s9xpmPQTtRj8JRTqgp19kVP6eWSyjKSf6oifmtqQiHFQJfUBdjA8vf6gt/kyIqPdQnfEVFjAp/9iIRFdELzPvhixOnp5P1slUVZsjfSHk3S1u9ltdkJ32LLmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707412979; c=relaxed/simple;
	bh=1bh9xr/XqEbUTggHrqqyAfc+sa/UnUpOI42HqtZ2lr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lD397a5XD/iFMl8ymkQFeBzVAachx8SWTiu5aGeYbFZzuQjO5DUqPfT7zxLB1G5MTnAnrdmwFSBEqVZ/BGlcpLGbusS2jKbK2lJgq7Q3ZnIu6tE9dnPH4n01mmO0e/mF/JnJ0v2P8rx6fsBcx1FrROd/R8Nd5x1CWWG+OLORZvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OIbJRjz/; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707412978; x=1738948978;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1bh9xr/XqEbUTggHrqqyAfc+sa/UnUpOI42HqtZ2lr4=;
  b=OIbJRjz/M2lUniXXXFT2OSUW0QcRdaEZ01PLmJ8lsa7eummXrZtDRsdH
   1IfQF/zMQ8uRXlemGEXEx++w9UDvVQhVB4tVw+yiSQSs7s/VNf7g6aLU5
   Wj3Zq4WeoMNfbWpeozusK+bTmNwwj3TNizQlyakj1NmlRiJhbkyBF9QfO
   bZYpMMMi3o+9DE3i7ld1psIv8UAxEbNVxamPsRayOlxUIEHLxioOXzSEF
   S6NreN8MRHqm4KmRTQFv/RjyJP8W43QNgBXZLO835JaGC3jvIgUR4JqoK
   F7J5imV5pWOPu7VjVXWIrV0T4LrEYl/fijov4ieAE9UQGfxRC14YAUoXY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="11843533"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="11843533"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 09:22:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="910433919"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="910433919"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 09:22:54 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rY86u-00000002w5j-1w5D;
	Thu, 08 Feb 2024 19:22:52 +0200
Date: Thu, 8 Feb 2024 19:22:52 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: u.kleine-koenig@pengutronix.de, jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com, lakshmi.sowjanya.d@intel.com,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] pwm: dwc: use pm_sleep_ptr() macro
Message-ID: <ZcUN7NHCSEXnezV5@smile.fi.intel.com>
References: <20240208070529.28562-1-raag.jadav@intel.com>
 <20240208070529.28562-6-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208070529.28562-6-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 08, 2024 at 12:35:29PM +0530, Raag Jadav wrote:
> Since we don't have runtime PM handles here, we should be using
> pm_sleep_ptr() macro, so that the compiler can discard it in case
> CONFIG_PM_SLEEP=n.

> Fixes: 30b5b066fa83 ("pwm: dwc: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions")

Fixes always should go first in the series.

-- 
With Best Regards,
Andy Shevchenko



