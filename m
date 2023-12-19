Return-Path: <linux-kernel+bounces-5459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC479818AE3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF4DC1C21CDB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4D01C694;
	Tue, 19 Dec 2023 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NIkGZftw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31CA1CF86;
	Tue, 19 Dec 2023 15:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702998719; x=1734534719;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+xlnfKcJqebKZFuV6jH/QlOiaHFOq5igRUWnHrLzm+U=;
  b=NIkGZftwLirVlqp0o2yFyWhIyGIMeJEEoLJOpJ+A3vUzqewi+bldG+U+
   11yAIZR0yu/B6sKQeFfIvOlBwbL98szYQnoomk5Hp31Crxszegkxhblgi
   tqX1lAkxsxoqf+ijGPUYY+vzLjzpyv4Ov5uPK1r5v5n151EdBiOZSa2vJ
   ugY/CeP5QBibfHuRAIE17yAzZNlDpBon8vzN1B2X7N4MnUM3B7wti7Zzt
   YxJlpTujECRoHFVnEemU/Smq14iyYcLBy8JDjW+tct9qyQls8ULcwGHPR
   r9xI5WlaE+1JL7UK/pHFROS+5PHi+7YWqDn03biWCFPRZ6vTR4moqYQ/n
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="460014993"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="460014993"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 07:11:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="866669664"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="866669664"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 07:11:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rFblC-00000007IDy-3Oqf;
	Tue, 19 Dec 2023 17:11:54 +0200
Date: Tue, 19 Dec 2023 17:11:54 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpiolib: use __counted_by() for GPIO descriptors
Message-ID: <ZYGyumQXaM8PXzcz@smile.fi.intel.com>
References: <20231219125706.23284-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219125706.23284-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 19, 2023 at 01:57:06PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Pull the array of GPIO descriptors into struct gpio_device as a flexible
> array and use __counted_by() to control its size.

How big is the struct gpio_device? Unifying like this might provoke subtle
errors on very fragmented memory, where k*alloc() might not find enough free
space. Note, k*alloc() guarantees finding only memory for a single page.
With PAGE_SIZE = 4k, this might be an issue.

I would suggest, if nothing prevents us from switching, to use kvmalloc().

-- 
With Best Regards,
Andy Shevchenko



