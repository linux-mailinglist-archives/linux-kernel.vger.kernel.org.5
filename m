Return-Path: <linux-kernel+bounces-58615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 850EF84E8E1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86A1E1C26E3F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94379374C3;
	Thu,  8 Feb 2024 19:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CXB3CAHk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ABA374D2;
	Thu,  8 Feb 2024 19:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707420260; cv=none; b=pb1/3xlbIg64G5vrlFEwoqWFeSG4I2mwbWKDPW3AaSIeDTyMHQ2A+WTcGOxHKMXav0FhqMvijkATgmiMtMb4QSm3GbFLBpdqHjWWpGJgoYTzCk7xEWoGilad5CrQYNZoOjOgL8rW19SIAfMeqd+gj0cYj8qpanuLYJxXCKEMf7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707420260; c=relaxed/simple;
	bh=YMJDYqpm54nTFmCHmceV4no3uv4NhzkI8Rb3i6dSSnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIHNFgnSuptK6njIDdgaU6QwZBF39eeL6g17A8PmsqkREe66XjPcrTwTcVKhsGz9ItjOrxEQQpbHuQSIG2FdbpH1QlT6DkCXDC8LSSeqhs4NeO2otTf8++9yXEdNByBUILo611qXMCuKNdXtZ5HeroJMpA87wt7yMp3/bnOGqFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CXB3CAHk; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707420259; x=1738956259;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=YMJDYqpm54nTFmCHmceV4no3uv4NhzkI8Rb3i6dSSnU=;
  b=CXB3CAHksGl3S4tqQbjktUNgbqL8WRzQPAOzLlJi3Kf61lRXst/1sQm5
   O3KhALsJUTE7JHlveBQmcm//+QrpFWNQez9JyLVx7WcOxni1pyuVvqTqn
   6Wuel2l9qEr9IwBG/ygf/9NSg45h4iLiw2fsRDBrLAhC179QUJh7W04Mj
   PWcFqtYHm8zuqz1ri9YfB5NHW1qynKybcsnqzFhbQg82YXg35fGYoCEIL
   MWZO03VN254EK7klKWsTwc3OJ4tWgdzmGGZV9WdoCm18puYOecJo0KlBN
   l08NJuaS36k1X+nimAy/wSv08B31hvjR9wGktTnFD2aBoZyoVOmKrcdSk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="11870116"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="11870116"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 11:24:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="910480696"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="910480696"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 11:24:15 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rYA0K-00000002yFw-0ii8;
	Thu, 08 Feb 2024 21:24:12 +0200
Date: Thu, 8 Feb 2024 21:24:11 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 19/24] gpio: remove unnecessary checks from
 gpiod_to_chip()
Message-ID: <ZcUqWy34Z_QGutNn@smile.fi.intel.com>
References: <20240208095920.8035-1-brgl@bgdev.pl>
 <20240208095920.8035-20-brgl@bgdev.pl>
 <ZcURtLZoEftBDpsy@smile.fi.intel.com>
 <CAMRc=MdaxrjKVoBe92ci+4U-VbxyuxMVu30-m2E3My0k7KN65A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdaxrjKVoBe92ci+4U-VbxyuxMVu30-m2E3My0k7KN65A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 08, 2024 at 08:17:14PM +0100, Bartosz Golaszewski wrote:
> On Thu, Feb 8, 2024 at 6:39 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Feb 08, 2024 at 10:59:15AM +0100, Bartosz Golaszewski wrote:

..

> > > -     if (!desc || IS_ERR(desc) || !desc->gdev || !desc->gdev->chip)
> > > +     if (!desc || IS_ERR(desc))
> >
> > IS_ERR_OR_NULL()
> 
> Ah, good point. It's a small nit though so I'll fix it when applying
> barring some major objections for the rest.
> 
> > >               return -EINVAL;

thinking more about it, shouldn't we return an actual error to the caller which
is in desc?

     if (!desc)
               return -EINVAL;
     if (IS_ERR(desc))
	return PTR_ERR(desc);

?

-- 
With Best Regards,
Andy Shevchenko



