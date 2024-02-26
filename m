Return-Path: <linux-kernel+bounces-81618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE14D86786F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 994A6291A41
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE1F129A9C;
	Mon, 26 Feb 2024 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hEaKarT0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ECA129A7C;
	Mon, 26 Feb 2024 14:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708957686; cv=none; b=Uc0ieM8XNij08vCjrIz9Ig+P/ErizjFHwUWZSmUUdwv1ojZxZiiIVFis7BSvHNue7q9NwLEkyUv36Kk9ZB8cgW40RYbUMSC6MzrYpfbILH5YjVMri6fN6YvThO0wx99QOwDglt88Zw9FVwIg9HWj4FMwvIf0POvJUr0b0AwNmEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708957686; c=relaxed/simple;
	bh=8weYkNnLSd37UT6VttUJajmr9tlGLDcafJ7hhi4s00E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFWNhZ8WaIENbe38TvwqETFRj2T9bdTfEWQZXBB+unjCQ67TLMAQHmZraX+WtedZr8tThcBzb5mrcWHlRhdkBwwYZEGJ5KYXKfO/7xqiNKWVrHOHF7L4Xn8X+E/IBmEMvXHk5pbxEKGd36fKuKi2n8M3JEMRKCq+aCe0h7quGmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hEaKarT0; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708957684; x=1740493684;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8weYkNnLSd37UT6VttUJajmr9tlGLDcafJ7hhi4s00E=;
  b=hEaKarT0jk+yrKzxXurOXNQUfC8smrMqkgNtcvVXStjWXmTNDMepgNHS
   EIfVByZ2Fgo89T8wyFbA/3naSmzVsh/HShLeX/gE/TVwDPP35c9A7JOjj
   0SCJr5kVGlc8DBPuMs5srWff/Wft4T3ctIEMfEE/45qqy66IhDQlITfFT
   2RNXNO/hMKInmXCkWTBjBoadtFZ8yhGloCCEkzIPt23wfrG1erwPtHzvo
   htOr8iS8KJAqZbFTMHUSzICVyzRw8tSqg9paLCJIITULmr3eGUnbkxhXz
   D6j520RRdyUJt8H0YcogAq50pFEmdVBJ4WNvW2WLLpRc1El6Bo3aPAmZg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="7049300"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="7049300"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:28:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="913872960"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="913872960"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:28:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rebxY-00000007hbE-0VRS;
	Mon, 26 Feb 2024 16:28:00 +0200
Date: Mon, 26 Feb 2024 16:27:59 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v2 1/1] leds: expresswire: Don't use "proxy" headers
Message-ID: <Zdyf7y-nKy6ihciq@smile.fi.intel.com>
References: <20240223203010.881065-1-andriy.shevchenko@linux.intel.com>
 <ZdkGmE2HFxXpIonR@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdkGmE2HFxXpIonR@duo.ucw.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 23, 2024 at 09:56:56PM +0100, Pavel Machek wrote:

..

> > +struct gpio_desc;
> 
> If include tweak means you need to declare struct, is it ian
> improvement?

Of course, we increase a build time by dropping the header that's
not used for the compilation.

-- 
With Best Regards,
Andy Shevchenko



