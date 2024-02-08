Return-Path: <linux-kernel+bounces-58515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6C884E765
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE94E28311A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BF784FCF;
	Thu,  8 Feb 2024 18:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qp2BpA3W"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93CD823D6;
	Thu,  8 Feb 2024 18:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707415661; cv=none; b=IoAYzF1PRgjc+fVkqok5Wqs+DVSNSqskeKAURx7ERFTyQKbGjWn8kfKpYXD67CVysIrCQNsLKjxQjOGgLNqdCUDsg385vVVYeKkkoc7KNzJcTDMOj8fCM5gPs2vB4Pf5k0nHcmVTyRxgR7d48UIons1fJNH3GXK5XHMLiy894jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707415661; c=relaxed/simple;
	bh=X6nLFPQpt9TpuAIYru0WJ9kygI91piLsQjvSadjn4UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjQwEsQLmPxDDvL3GiOMiofte6BgjROEvqfrWLjP2AKK88wlR8SMO2ACmPWkzP2gBJMBVbUrIERdxwHPmO9Gy/wcP+mqm3SQZDwzquygPC1FNDIH/yjzuFZ5XLLoUqG/5E5EDG10A3ViDnvJGgH/+AtRrVakRTLT8u+i9HCQ/kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qp2BpA3W; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707415660; x=1738951660;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X6nLFPQpt9TpuAIYru0WJ9kygI91piLsQjvSadjn4UY=;
  b=Qp2BpA3Wz3a+f4oz/q2BAnGb+13doGi0NHDavLOwHdgXxDR35UzmF9FK
   O48oyYiI4nBJWRa2eINt0MSey3oQW30bQ7a/z29pSj50Pe5oTzpcxrRH4
   fVxRskRem9B9fzt3INYOX83UKxaBpkDIvoubfxfEkkWJkvbwDvPc/cEAk
   o/XtjlMi5tjieA7vrfPHX6gIBX9FV5qeyI6rSQvDZnv5TKolkZ+EaoFkC
   CuE96s7oOVyt2pwNmDqNNyP20YnjwzQEup7b+eUd5R1QLcRlLd+RmLvot
   HDtZSKpvDigkF89FBbDRAgt0QxljJ3pumqgQilALEIOzGTVLCAgv4QUgf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1437767"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1437767"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:07:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="910453258"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="910453258"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:07:36 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rY8o9-00000002weL-1f5B;
	Thu, 08 Feb 2024 20:07:33 +0200
Date: Thu, 8 Feb 2024 20:07:33 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee@kernel.org>
Cc: Flavio Suligoi <f.suligoi@asem.it>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v2 0/3] backlight: mp3309c: Allow to use on non-OF
 platforms
Message-ID: <ZcUYZRDVmHhKQu9j@smile.fi.intel.com>
References: <20240201151537.367218-1-andriy.shevchenko@linux.intel.com>
 <20240208113425.GK689448@google.com>
 <ZcUMMyV_vBTNw8Rz@smile.fi.intel.com>
 <20240208173946.GX689448@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208173946.GX689448@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 08, 2024 at 05:39:46PM +0000, Lee Jones wrote:
> On Thu, 08 Feb 2024, Andy Shevchenko wrote:
> > On Thu, Feb 08, 2024 at 11:34:25AM +0000, Lee Jones wrote:
> > > On Thu, 01 Feb 2024, Andy Shevchenko wrote:

..

> > > >   backlight: mp3309c: Utilise temporary variable for struct device
> > 
> > (1)
> > 
> > > Set no longer applies.  Please rebase, thanks.
> > 
> > I got a contradictory messages:
> > 1) email that says that all had been applied;
> > 2) this email (that tells the complete opposite);
> > 3) the repository where the first two were applied.
> > 
> > While you can amend your scripts, I think I need to rebase only the last patch
> 
> This is what I assume happened:
> 
> 1. Attempted to apply the set (as a set)
> 2. 2 commits applied cleanly
> 3. The final commit conflicted

Which is really strange. I have just applied (with b4) on top of your changes
and no complains so far.

$ git am ./v2_20240201_andriy_shevchenko_backlight_mp3309c_allow_to_use_on_non_of_platforms.mbx
Applying: backlight: mp3309c: Make use of device properties
Applying: backlight: mp3309c: use dev_err_probe() instead of dev_err()
Applying: backlight: mp3309c: Utilise temporary variable for struct device

Can you show what b4 tells you about this?

> 4. I sent you a message to say that the set failed to apply
> 5. *** I forgot to remove the 2 successful patches ***
> 6. I applied another patch
> 7. b4 noticed the 2 patches that were applied and thanked you for them
> 8. *** I didn't notice that those tys were sent ***
> 
> No need to update the scripts. :)
> 
> > (1) that may not be found in your tree currently.
> 
> I'm going to remove the other ones now.  Please submit the set.

I'll do, but I want to understand better what's going on.

-- 
With Best Regards,
Andy Shevchenko



