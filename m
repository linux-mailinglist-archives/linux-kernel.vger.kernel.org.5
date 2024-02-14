Return-Path: <linux-kernel+bounces-65226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 391E68549B7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B76B1C21C54
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF995338D;
	Wed, 14 Feb 2024 12:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m65Hc/Rq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCFE52F6D;
	Wed, 14 Feb 2024 12:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707915206; cv=none; b=a2/DaH4Cj4JXtUJpAf+xjIRSnC+seBe5dPjLK7XhwnaJyBWG9HpyEc++i8xGoTuqxYjLVFgY4XLWn4XPueZJ3gFhB3Y4rnnvUFHYasLCu6OH/015UK4dZOWZpg8Z9vd4iD2svvaNf4s9FNhQPnyJ8XneUf8e2PJi5Z9K7SvNizg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707915206; c=relaxed/simple;
	bh=/ugjthiYNVRZbQHfNTQs8D389INhtH0zhWqQPZwLa04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2LTE1qunGDKHx49BITOV1RuD8BNBb52QrJ0rNVvJzHQELA82YBljz6moio4jvC1ij+LNbo7EgYHfekS99JjKcL0u1q8ncMdq6H/lVex5g1w/dGO0GpTigzVIPoYxk6r/KfLG1H2hvwg9rpwaU6wBWN2SUdDu36Rwk/N1qzjIFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m65Hc/Rq; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707915205; x=1739451205;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/ugjthiYNVRZbQHfNTQs8D389INhtH0zhWqQPZwLa04=;
  b=m65Hc/RqzQ6YsrVvR3knd2JULvDWT9gTk4khGymegXD86dNrggsj66xT
   JP4/rUVJwNNnDoUBwF5yQeX5WZrLz6ePdZAGB1TrGhdsV0cYPLgdObX/x
   4f4RwoFOjXyrm83xrzJYZckYjDRZXM6bhGdTRo8cbiKGw2M4rWl3HhiJp
   E7FxtGeU0AKYE4bhnCltmRKVbiYdqw4epOrZ5olxhFk1pqk83++KrOGko
   JzndZFcTnUB3rPRx8bh2sODoe+6Crq0nim3RqTL0BOU3ujDdCfAgaduv3
   eFNjg1uCO1gsRMwjHkaejUR6G7MeujHxjazWqCMGCXIrICBjHLPhrqq6o
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1809965"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="1809965"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 04:53:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="912083940"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="912083940"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 04:53:21 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1raElK-00000004UaX-3iWL;
	Wed, 14 Feb 2024 14:53:18 +0200
Date: Wed, 14 Feb 2024 14:53:18 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>, Mark Brown <broonie@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 0/4] gpio: fix SRCU bugs
Message-ID: <Zcy3voO1yTPHo88T@smile.fi.intel.com>
References: <20240214084419.6194-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214084419.6194-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 14, 2024 at 09:44:15AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Here are four fixes to some bugs in recent SRCU changes. The first one fixes
> an actual race condition. The other three just make lockdep happy.

Same comment here, can we simply redo this work so we won't have tons of fixes
on top of the nice RCU rework?

-- 
With Best Regards,
Andy Shevchenko



