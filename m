Return-Path: <linux-kernel+bounces-76633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4179085FA46
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1486284234
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA7B14691E;
	Thu, 22 Feb 2024 13:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XxwlsWp4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231C21350C6;
	Thu, 22 Feb 2024 13:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708609904; cv=none; b=bTDhVJBlQ6l/KO8fvKQh/hSSO06xzXklFDqqXwiG9pMsq7UxpTBUgYIExTR/fC6MhyRo3f3dGYsef4ODZ/Yy6q6BvYyU1jafxRKm0jCdcCdFhJ+m22d5NDOmUW6+N4/HbexuIbHh6dua4TNFKndYM0+AnJpaYgBiwMrPQhy7PFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708609904; c=relaxed/simple;
	bh=Sxn474YLGLNPWPJtdP5TAzzEd7S/58QPzdVlk795+HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbsavVgvhmQoVmbjOzhgLRWFnrrYUcPX7LuWzZ1Qga6Q86wj2h5Zud2ckebr0xhmyrz6dXGwKwSJYKBQP801o7mch/0i1TIOHgnSFXuPxD/KOucwRZMJQPid7gajP5RPZpYCeBOO0LKs9Q7qiseHPSeealXO1wTZJENbSejrblY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XxwlsWp4; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708609900; x=1740145900;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Sxn474YLGLNPWPJtdP5TAzzEd7S/58QPzdVlk795+HA=;
  b=XxwlsWp49mqm5qHvrJGOPCaYLl1g8K7AmgEJDP2lp6UeQgtZXok9+tF8
   V+IhuSZTwkD5r1VfI3xZzu2f9LX463JM1dQzAMQssS1M8aJMKOdiLKD0e
   On20ioFpQyTgjDvNMDU3GTFXStzcyHRn7H8ybFE/YlkAm6+Kvnvkq8nkm
   zPFu6Hyb+Pc7cvTZ/+u9ofJKLHcSp9W4zmMtAets0p8tnruDAZIGYtBWK
   6VIN1p20E9SBfA+G6kHeBajD15KXuIjSBUGkWl5BjWoRf/POuv0AiQexP
   91kok0esAtTzuyqcdePdt0EzZBLSMzQ3MrDnhy9VVMQO22pbgS2+LwY1A
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="2955914"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="2955914"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 05:51:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="913529570"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="913529570"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 05:51:36 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rd9U5-00000006duI-3jGq;
	Thu, 22 Feb 2024 15:51:33 +0200
Date: Thu, 22 Feb 2024 15:51:33 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>
Subject: Re: [PATCH v3 0/9] auxdisplay: linedisp: Clean up and add new driver
Message-ID: <ZddRZWftWhMHUl23@smile.fi.intel.com>
References: <20240219170337.2161754-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219170337.2161754-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 19, 2024 at 06:57:59PM +0200, Andy Shevchenko wrote:
> Add a new initial driver for Maxim MAX6958/6959 chips.
> While developing that driver I realised that there is a lot
> of duplication between ht16k33 and a new one. Hence set of
> cleanups and refactorings.
> 
> Note, the new driver has minimum support of the hardware and
> I have plans to cover more features in the future.

Geert, would it be possible to give one more round of reviewing/testing
this week? I want to close auxdisplay for next merge window next week.

-- 
With Best Regards,
Andy Shevchenko



