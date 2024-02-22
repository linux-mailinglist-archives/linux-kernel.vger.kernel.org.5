Return-Path: <linux-kernel+bounces-76595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 574E485F9C7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11C75288F7E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A386513398E;
	Thu, 22 Feb 2024 13:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MkHGNN0P"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3DB3C480;
	Thu, 22 Feb 2024 13:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608499; cv=none; b=EaM0DfO72G4lZR5bd1x8RDIZVi11KWmkJ48c2NT5azSKfk6BPWaEMUE06lx3xJEG0SIN93werxRkNKYsGwoVGfWMKNHeluBhD/1B/jV5GAFxknESxvY+mEDQLSrWWseZ2vhJWfVWoiaV+FgzN4vrabfxjZTJ3QEVWqlqytQXTac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608499; c=relaxed/simple;
	bh=ohqUpTZp0VUFM3NLMJysG88wyIHXct6Re9hKbvWxPqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEDtuJNtc4wYu/seoaBji0v7CGuL7zdK6flJoXW19dRZnEE3PzpFM49doyDUkzp2esbVvU0K5pFXKelp6PkAPOPlF1Fj/VP1u1QcEFExOSFxwAHYu18m0yHkMaw++IUrc7OVadmPMCUEVa7zIpZSsq5MNaa06oT20XP+vfivHCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MkHGNN0P; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708608497; x=1740144497;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ohqUpTZp0VUFM3NLMJysG88wyIHXct6Re9hKbvWxPqk=;
  b=MkHGNN0PkykLhcq1Qi3h00KEGbzwsZ8W2/Q0bCFCq6OZoSUc5bmAYjxl
   WYSqNG1zYYbrsDjG/Nn5p8/JnTLxIwQ3MUFPFjxvJzl9JcJeJJlVMFgij
   XGLWOhmKHqxOM37f/9WBU83UORuff+RAd2Hc9bCDefDQte8+jgs5MHwNo
   B/Vk/UPhheaT7BAbliJde87oj2Vjg+ExcVfm/UFDR24XrdmU7+ju6RSrQ
   Uh7LSNv5BJxaxuea0+jxtH9XP6fhsK9bpyLeIuoTjNM9E7cuy5+2LrMqC
   pyAYr8h4cMUGPyZL0iyeuZxwbjGdbUEcKir6fdcCjR/63m7LbIVEQ9Xxa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="25292899"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="25292899"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 05:28:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="913524931"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="913524931"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 05:28:15 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rd97V-00000006dai-0UYH;
	Thu, 22 Feb 2024 15:28:13 +0200
Date: Thu, 22 Feb 2024 15:28:12 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] gpiolib: Deduplicate cleanup for-loop in
 gpiochip_add_data_with_key()
Message-ID: <ZddL7L24RXoqR7sN@smile.fi.intel.com>
References: <20240221193647.13777-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=McECxKW+uS7fQyGtYVfcSZQaAJZFi+s+wNMoRiHxef0zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McECxKW+uS7fQyGtYVfcSZQaAJZFi+s+wNMoRiHxef0zw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 22, 2024 at 10:48:00AM +0100, Bartosz Golaszewski wrote:
> On Wed, Feb 21, 2024 at 8:36 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > There is no need to repeat for-loop twice in the error path in
> > gpiochip_add_data_with_key(). Deduplicate it. While at it,
> > rename loop variable to be more specific and avoid ambguity.
> >
> > It also properly unwinds the SRCU, i.e. in reversed order of allocating.

..

> This doesn't apply on top of gpio/for-next, I think it depends on one
> of your earlier patches?

Yes, on the fix with error path.

..

> > +       while (desc_index--)
> 
> What about gdev->descs[0]?

What about it? :-)

for (i = i - 1; i >= 0; i--)
while (--i >= 0)
while (i--)

are all equivalents.

The difference is what the value will i get _after_ the loop.

-- 
With Best Regards,
Andy Shevchenko



