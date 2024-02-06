Return-Path: <linux-kernel+bounces-54952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CA484B556
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 124E32899D5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3794E12F39D;
	Tue,  6 Feb 2024 12:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BmFbcJeD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067D55D8FC;
	Tue,  6 Feb 2024 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707222626; cv=none; b=HVXRFK7fAdxjp2ISt5XoEVWk5ZMV8+OAc/3+R9I0BYw6YuIz0D5+l38wuzD/08iph2r/P4q5viwyixL3aBE5w8lQ8Foru0T6OJe5HfAVj2qIGOCoRfv5gcOhFCiC67/apG/gSp63eSg9U/QFsb+N+zwAk0Oh7RNWQ1wIxOpkVMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707222626; c=relaxed/simple;
	bh=hTgkI8aNc7DauvgizYJN2eynljPZb4ZGr+yoeugS+cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qb2Fg8A8I+86Oj1w0TDVa4eh0N73FX0Jo9VyX3r+GhMebD0lQswgNawimt/dIqaD84bcpfbQAibFqruPGm8ef+NWNlCCqPMLb+LNo+fHNpwiXesaw0KMoSrilBNxxnaTm7rhawRAYzx3kwx4zjiVe7K927v0/vMv9fCx6J+5twE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BmFbcJeD; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707222625; x=1738758625;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=hTgkI8aNc7DauvgizYJN2eynljPZb4ZGr+yoeugS+cE=;
  b=BmFbcJeDhcFMyCSzMCzqcIi5TAjTzpxsUKMWs+iVQjmVQd+1U5bWMxDl
   YptKvM4gIUYNWRR3S7MP7hoV58MMl24bqHOoV1KiCvtHhBYoMXYJtsC/s
   NPCIFkxrwQHphVVsSbBB6vTAgknwo6OzBNmWAvqkY25BknMEmYT2vVuVI
   soJcoGw2aQXu6QNPmEa+4weJgGAQKnRV+E0KXskLtzQEOEVaHVfj7GLHp
   t4ejzqnCanBrqWv9zYTwOKogaz/zDLD551yzfRvGDhtpy2z/xZT1PhTOY
   z2LQ9JYOrSqsELUGU91mdBGNnrgO1FDbd4ss0G9cb+x94kyQhcedHGS0z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="18253494"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="18253494"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 04:30:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="909626381"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="909626381"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 04:30:21 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rXKag-00000002Kx3-3c7b;
	Tue, 06 Feb 2024 14:30:18 +0200
Date: Tue, 6 Feb 2024 14:30:18 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 17/23] gpio: reduce the functionality of
 validate_desc()
Message-ID: <ZcImWuSiBgSO0yO6@smile.fi.intel.com>
References: <20240205093418.39755-1-brgl@bgdev.pl>
 <20240205093418.39755-18-brgl@bgdev.pl>
 <ZcDS60dB39y-B6WR@smile.fi.intel.com>
 <CAMRc=Mf+nTw1iwbDvmF2=93KxEimxBndVEhdp9V7kAzvGqizTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mf+nTw1iwbDvmF2=93KxEimxBndVEhdp9V7kAzvGqizTQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 05, 2024 at 08:22:23PM +0100, Bartosz Golaszewski wrote:
> On Mon, Feb 5, 2024 at 2:47 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Feb 05, 2024 at 10:34:12AM +0100, Bartosz Golaszewski wrote:

..

> > >  void gpiod_free(struct gpio_desc *desc)
> > >  {
> > > -     /*
> > > -      * We must not use VALIDATE_DESC_VOID() as the underlying gdev->chip
> > > -      * may already be NULL but we still want to put the references.
> > > -      */
> > > -     if (!desc)
> > > -             return;
> > > +     VALIDATE_DESC_VOID(desc);
> >
> > IIRC we (used to) have two cases like this (you added one in some code like
> > last year).
> >
> 
> None of the consumer-facing functions does it anymore. Not sure about
> this, maybe it was removed earlier.

Okay, the only place that might be considered is gpiod_to_gpio_device().

But that API seems new, I don't know if VALIDATE_DESC_VOID() is okay to use there,
maybe it should be commented if not. Also there is a typo in the kernel doc —
'the users already holds' --> 'the user already holds'.

-- 
With Best Regards,
Andy Shevchenko



