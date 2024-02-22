Return-Path: <linux-kernel+bounces-76611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1A585F9FF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DDDEB22A44
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9628E134CCC;
	Thu, 22 Feb 2024 13:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D0N/jtdN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9E5133296;
	Thu, 22 Feb 2024 13:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708609142; cv=none; b=RjIZgTbkFxAc6f3XCW+iEvMPE3WOLN3ZYarY63F3RPcLxrRidIQP5PavxKvAySOFXJ+JsK4fQ/cpZrWkH1E+YQ+grXbnOx3AO2oCwL41KUsT3wzZofwku42LbNF2y7NFgE1KxHOyX2k1ETirXbEwvzb5xSG8ci3yBPbno0dS7Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708609142; c=relaxed/simple;
	bh=VDI69W9BEPBXTrDEQxaH2glTMR00W37uK2EAbFcjDpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzIdhHc9+7VDSWAERiVzTxxE9FQle1flAPDivBHVxPVD/5ErWCPM4nEmi2jC5/cHoMAwROJpdm1h5C/9sTcf1AVXK+IuPSU34aNzoQdF49NBFihTCwyOrksEpMWC2lbGEX3Mz9WafLwOP9RYOSVadEH8hzjndfl1XKIH9dnIKrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D0N/jtdN; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708609141; x=1740145141;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VDI69W9BEPBXTrDEQxaH2glTMR00W37uK2EAbFcjDpw=;
  b=D0N/jtdNsoUEow9cmcxWQWWtfNs+6AIKi5A7ciCc7p0naF5/vkzIhzUY
   kwWZOYnWKJva0jkGfl5IlEakZRzWTf8i0P28f0weX1zWPsbnccl6z21mQ
   +WPjXvsiwU/GO7dUio4S1CbEjiOx5OzM71umXbMbsGR+/ES6lBeAas3ml
   OuSXPlgOPiYiJq7BucyxZzIrOGESGlpAEMUN3acQbScaKtd6+pEK5/Whc
   b7c5TghB/fDukuDJqd6GkdDpWkq0reIZ8SKm2p/jzM9Z82HggDMq79v8q
   JBElAyysh2UKIJmfgbFk2tFkbyGm049EPjAyl8oJJ6rFwFJb1dbxyLAUr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="25294783"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="25294783"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 05:39:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="913527400"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="913527400"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 05:38:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rd9Hs-00000006dj0-2vOb;
	Thu, 22 Feb 2024 15:38:56 +0200
Date: Thu, 22 Feb 2024 15:38:56 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] gpiolib: Deduplicate cleanup for-loop in
 gpiochip_add_data_with_key()
Message-ID: <ZddOcJrYEANc2B2Y@smile.fi.intel.com>
References: <20240221193647.13777-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=McECxKW+uS7fQyGtYVfcSZQaAJZFi+s+wNMoRiHxef0zw@mail.gmail.com>
 <ZddL7L24RXoqR7sN@smile.fi.intel.com>
 <CAMRc=Md6d19hhySFti+vSLV9pfyzuHNUDmHN_XYV73uCWDAY7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Md6d19hhySFti+vSLV9pfyzuHNUDmHN_XYV73uCWDAY7w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 22, 2024 at 02:30:03PM +0100, Bartosz Golaszewski wrote:
> On Thu, Feb 22, 2024 at 2:28 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Feb 22, 2024 at 10:48:00AM +0100, Bartosz Golaszewski wrote:
> > > On Wed, Feb 21, 2024 at 8:36 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:

..

> > > > +       while (desc_index--)
> > >
> > > What about gdev->descs[0]?
> >
> > What about it? :-)
> >
> > for (i = i - 1; i >= 0; i--)
> > while (--i >= 0)
> > while (i--)
> >
> > are all equivalents.
> >
> > The difference is what the value will i get _after_ the loop.
> 
> Ugh of course. But the first one is more readable given I got tricked
> by variant #3 at a quick glance but the for loop says out loud what it
> does.

I disagree. `while (i--)` is very well known cleanup pattern.
Less letters to parse, easier to understand.

-- 
With Best Regards,
Andy Shevchenko



