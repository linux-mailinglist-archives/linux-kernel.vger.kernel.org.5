Return-Path: <linux-kernel+bounces-54945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F97B84B541
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1D861F2628F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257A2133428;
	Tue,  6 Feb 2024 12:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O8y7zg8E"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4581332AF;
	Tue,  6 Feb 2024 12:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707222296; cv=none; b=s5B5hMHVG8fg8/AmhHR7ykWb+PqGIZUbE5jF3sRxbesLGhxKfVTmd0xIszrHuRV8LSelbePbME/uKr2Ca15illzU6VqxcAew+PsWcSBYDWmWXJGZz5P+G1l4A5b077WwG2JPN5dWKU5mmewnfLivbBC7hs1q57RlXuKxxdpVtwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707222296; c=relaxed/simple;
	bh=GYryW2hlQXGZNG8ZlqTk+2PvO/iRzvsrEKGkjXiEGQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZV0duEqrvxtA6FfingNWSv5drHr5uh/a57BbU1vb9XE58OQP+eZKhROlR2cu7mjE/JAkvdz+IxK6/6whDbgN0iJ6NnIb4tThYY3KEnAijG0pVVisJXscAyb5tzPf4CdJPHF4kye63pqpv66n2NkY1aCxyK+80wrF3p+72KQA9zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O8y7zg8E; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707222295; x=1738758295;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=GYryW2hlQXGZNG8ZlqTk+2PvO/iRzvsrEKGkjXiEGQ4=;
  b=O8y7zg8EoKIfA4FTcDFF73BDnAbq5qRFf9Qv2r9pcM7Oxo1TluGNamfE
   1sQQjyaOReTVwPRCa9C6l0I74bGfcYMIPyuXiid4byf1aHS3BtS4jOhoy
   OW0L1uYM+kq5sfsOiWsJfrDrHrEec0ShunG7C7WLwmExIeN8W7AP1KCca
   ybRl2RQMy/ZE5k0gCG/Gw256HX3LfVRxKYi2saZDvfCUuqmq5dDRuOcKn
   NOv3+6tm4G5dhiJoTH8mdZXheHbjfHMXpkEiOpNXI1AeZX43XCrUi8WEo
   kKVDLOk/X5k5duY/bO58sQraDAxPFZV5kcVSl/tBNlCCqzD04/IcH/+C6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="18252890"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="18252890"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 04:24:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="909625473"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="909625473"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 04:24:51 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rXKVM-00000002Ksu-3aNS;
	Tue, 06 Feb 2024 14:24:48 +0200
Date: Tue, 6 Feb 2024 14:24:48 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 21/23] gpio: protect the pointer to gpio_chip in
 gpio_device with SRCU
Message-ID: <ZcIlEEgHn5AaTEyz@smile.fi.intel.com>
References: <20240205093418.39755-1-brgl@bgdev.pl>
 <20240205093418.39755-22-brgl@bgdev.pl>
 <ZcDVNA6Id7Bmckt0@smile.fi.intel.com>
 <CAMRc=MdoGQZKM37kk=j6NpdkUUjDvs3-8YeiZVQO2EpPHRZ7Uw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdoGQZKM37kk=j6NpdkUUjDvs3-8YeiZVQO2EpPHRZ7Uw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 05, 2024 at 08:36:39PM +0100, Bartosz Golaszewski wrote:
> On Mon, Feb 5, 2024 at 1:31 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

..

> >
> > >  int gpiod_get_direction(struct gpio_desc *desc)
> > >  {
> > > -     struct gpio_chip *gc;
> > >       unsigned long flags;
> > >       unsigned int offset;
> > >       int ret;
> > >
> > > -     gc = gpiod_to_chip(desc);
> > > +     if (!desc)
> > > +             /* Sane default is INPUT. */
> > > +             return 1;
> >
> > Hmm... I can't imagine how this value may anyhow be used / useful.
> 
> What else would you return for an optional (NULL) GPIO?

An error. If somebody asks for direction of the non-existing GPIO, there is no
(valid) answer for that.

-- 
With Best Regards,
Andy Shevchenko



