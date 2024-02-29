Return-Path: <linux-kernel+bounces-86795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1631F86CAE7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45C231C20D77
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9D112E1FD;
	Thu, 29 Feb 2024 14:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I8NS4JOl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB9415D2;
	Thu, 29 Feb 2024 14:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709215390; cv=none; b=aLTaQJ3JgVXWLTQLJ+la10NCxkYGKpXSdhva8/g1NhWEf7z7EpNDdZYKtWqkDHhsUFSPYdllJI/Bi7162K/987Jlytq95kKsr3O74jrzHzVe/mG7X0sGJkzu4RuweOI5saKG1ewqbhmyshd7kkkSoG/FIvxIEkLwXxJ2PsYdPgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709215390; c=relaxed/simple;
	bh=of78azqk9pyl3dbaAzM1nddstYUe6Qj3+UufZgaZ84Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ts46bBVKn0509a/QMcjm41E80c2dt2OuFNS4poJ4CYVm9BwygyMG+WHZWFPrd17jnvE3irE7Kl2mM0yhkrpcCIDKaVHq29fMejQULQgH4W2YU80zk9re1oK4y5HYGHIK6tetK4ko9RNDose3TuAdQwzE/6hFZf8Meg6rAB1q/90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I8NS4JOl; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709215389; x=1740751389;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=of78azqk9pyl3dbaAzM1nddstYUe6Qj3+UufZgaZ84Y=;
  b=I8NS4JOllwUcL1Wlm9oWfF+kiV7QZ4/ISS/kVEfI29ZJqarOTiyNmmUO
   EUMvavfeRVsKSWGI9V4f2mQUrrT32qwMJ1NwHsad90B6IpVmbYC3qBMPv
   DzvqyxEZSFNHDbm0F0kxYzuo+ddz0cRX1TasZc0U1hauPSvtWybIG91xz
   6lzAPXEccAPFStq+/IBLQG6t9LptCPEJZWXkA32uP7nFykFEiuPAe5U1n
   wFbzc88LB2ocdf3Q4zcTI0eWrwmNOMEaGRjjBDGsVKE1zjBb/jDCn7wN9
   ObBsicUTEmbqGD+BTHwA/ZViIuF5FbjCmsYyGPWRMlUsiCl4X/BDvlIGV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="29116843"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="29116843"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 06:03:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="913982839"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="913982839"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 06:03:06 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rfh03-00000008gdV-1Zia;
	Thu, 29 Feb 2024 16:03:03 +0200
Date: Thu, 29 Feb 2024 16:03:03 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Herve Codina <herve.codina@bootlin.com>
Cc: Luc Van Oostenryck <lucvoo@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	linux-sparse@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] parse: handle __cleanup__ attribute
Message-ID: <ZeCOlzq6qLJtuc0O@smile.fi.intel.com>
References: <8d596a06-9f25-4d9f-8282-deb2d03a6b0a@moroto.mountain>
 <i4s2gnr6rlq3yhmfiy7lkbsahnaioilksvmx3eocdjfh2434zo@zhxhwwgqpxt2>
 <44e22df1-734e-49c5-b20b-4f4cdbce24a6@suswa.mountain>
 <75ee8bd3-aa80-46dc-9f0c-874a8f4e9d48@suswa.mountain>
 <k6ztyjq24ik24qtsu3aqpipodzgq37i2ko42ag7wzn4t2ryrzf@i4gbxu7kvslt>
 <c3884893-44fe-4622-8e8e-576a0bdff19f@suswa.mountain>
 <troz4beymvsw2m4y4ocghwiidohi4nbj45ry2tfmbekanu2ray@ooravawiynxr>
 <Zag2fYsyJDtDR7a6@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zag2fYsyJDtDR7a6@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jan 17, 2024 at 12:20:13PM -0800, Dmitry Torokhov wrote:
> On Mon, Dec 18, 2023 at 02:51:32PM +0100, Luc Van Oostenryck wrote:
> > On Thu, Dec 14, 2023 at 04:20:20PM +0300, Dan Carpenter wrote:
> > > Yep.  Perfect.  Thanks so much!
> > 
> > Pushed now.
> 
> Any chance someone is looking at making context tracking working for
> code annotated as __cleanup? We already have a bunch of code using
> constructs like:
> 
> 	...
> 	guard(spinlock_irqsave)(&gpio_lock);
> 
> 	if (!test_bit(FLAG_REQUESTED, &desc->flags))
> 		return NULL;
> 	...
> 
> which resuls in:
> 
> $ make C=1 W=1 drivers/gpio/gpiolib.o
>   CALL    scripts/checksyscalls.sh
>   DESCEND objtool
>   INSTALL libsubcmd_headers
>   CC      drivers/gpio/gpiolib.o
>   CHECK   drivers/gpio/gpiolib.c
> drivers/gpio/gpiolib.c:2359:6: warning: context imbalance in 'gpiochip_dup_line_label' - different lock contexts for basic block
> 
> and I expect we'll see more and more of this.

+1 here. It's quite annoying for every Linux kernel developer in the world
(which are at least 2k of active ones).

-- 
With Best Regards,
Andy Shevchenko



