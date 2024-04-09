Return-Path: <linux-kernel+bounces-137390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A63D89E15E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E42B1F22E44
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D98715625B;
	Tue,  9 Apr 2024 17:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cTbcuocS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3984C85;
	Tue,  9 Apr 2024 17:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712682966; cv=none; b=ZHxTIYXzVyj9Wc5XPBPNDAVRpy+DhRS5XvY6GIkLj1dlvwmb/+pFfHsGdA5VwYFawX5cFZ4HUb3Ude2UJbbYMCC84uOTXO5A92wbbnIXE1FIOsjMDif/1bPSDMn6mWUps5DtI9l34Qz3Aw6lwySR+8Vldh50tzelVTVKkcd9eV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712682966; c=relaxed/simple;
	bh=sLn1MkuowWjc6krARTBpYDuzXpWucWq2bmwehniidC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVAres22MFw4RZnpkGuWohao46EW94IXtYmnsZELYd35FBgDrokWKplkhwGjlEwcIilwS0lbrEk2ISRJl5+Q9CC2c+BrO7CHdnRx0FN1t5QLUMjRRizdmI6PIN6r73P3njlEhn0URMK65sJtwZbfVNk3lIIjICOMBVjGC67Syi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cTbcuocS; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712682962; x=1744218962;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sLn1MkuowWjc6krARTBpYDuzXpWucWq2bmwehniidC4=;
  b=cTbcuocSVEUwF/PxfZitr06XsU24gddl+egzds5jWzaDSQjDRKCmeabt
   Q2gxrwC8MoQ5Ai+kQhTGQrIJnWH7Y0iYikGcBbSiVSAXlenzLWeZ1rHoA
   Y9ywQh7bJH0D18HN2I4lpV71MUhe2Vsr2wHRIkT0UzyQqC/Y5Jiz662ga
   aZnYbT/0bQBsdyrFRqhSngFU+XYGCr36yaVHId5Zem4x+XE563/P2HjdD
   tRfhDYjWRxaqqd9+gtNF+uMHik65YDqfAj9mk+OV8R5vxK+VSsnKVGUJM
   ZOqE9bGy+d/vQOVDW9H8TFzB4wXoCRZKwPg4Ap3Q62sZBy/Ji/TsT82xW
   w==;
X-CSE-ConnectionGUID: sFO0iKuoSRGVoHY+0wx90g==
X-CSE-MsgGUID: NihCW0DjQtSPgPa91ZNbPQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7924889"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7924889"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 10:16:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="915405484"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="915405484"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 10:15:59 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ruF4f-00000002rrI-2EXk;
	Tue, 09 Apr 2024 20:15:57 +0300
Date: Tue, 9 Apr 2024 20:15:57 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v1 1/1] platform/x86/intel: atomisp2: Replace deprecated
 UNIVERSAL_DEV_PM_OPS()
Message-ID: <ZhV3zUgZjAMUZ0yD@smile.fi.intel.com>
References: <20240403105511.558395-1-andriy.shevchenko@linux.intel.com>
 <609652ce-0336-4d69-ab79-f84c8a8506e5@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <609652ce-0336-4d69-ab79-f84c8a8506e5@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 08, 2024 at 06:20:03PM +0200, Hans de Goede wrote:
> On 4/3/24 12:55 PM, Andy Shevchenko wrote:

..

> As mentioned in the description of DEFINE_RUNTIME_DEV_PM_OPS()
> DEFINE_RUNTIME_DEV_PM_OPS() is NOT a 1:1 replacement for
> UNIVERSAL_DEV_PM_OPS() specifically it uses pm_runtime_force_suspend() /
> pm_runtime_force_resume() .

Right.

> Specifically pm_runtime_force_suspend() may NOT get set (and in this case
> will not set) needs_force_resume skipping a resume + suspend cycle
> after a system suspend, which is a problem if firmware has touched
> the state of the device during the suspend/resume cycle since the device
> may now actually be left powered on.

I see, thanks for explaining me this. So this driver is kinda very special.
Still the old question, can we get rid altogether of these atomisp "drivers"
in PDx86?

> It seems there is no direct replacement for UNIVERSAL_DEV_PM_OPS()
> without a behavior change.

Correct.

..

Btw, have you seen a few cleanup patches against AtomISP v2 by me?

-- 
With Best Regards,
Andy Shevchenko



