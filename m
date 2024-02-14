Return-Path: <linux-kernel+bounces-65223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E63C8549B1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1D5D1F24AC5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A0C53E25;
	Wed, 14 Feb 2024 12:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TPcM7Pjy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A696354672;
	Wed, 14 Feb 2024 12:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707915142; cv=none; b=QargTuvzlRpZUexyx4qiZByXA+E9KU9ifRfurQvLfBMqS7gWwMPdADjHyopIYGVGNoJ1FpjGD9brvVOVaTErTRSZJZ2Tpejxt+bahcuDZnROBSe9J745+4yYK/lXQ0YbrNl35w9L7j6tPgUo1jCLlT+KBmiw9LwytV2kBgZvVBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707915142; c=relaxed/simple;
	bh=eRK/8EcqifTwYizPQGTzvSxj2p7g7gqt31lW1GqTQa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLecQUYJlVysab1tMyBGncRtsJSLwEVxD37F2oItl5f9SLG/HwyiSR8StI6pZU/bU+8SLcLE5r8yxHo7lq9+XpDXhN1onf+XFtHDgz2R/pj+2aJb4/beGBv7gkVJhOaSppuobtuine7XOKn6y5ZcBgkbzwdm3441PZtwf0OPbQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TPcM7Pjy; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707915140; x=1739451140;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eRK/8EcqifTwYizPQGTzvSxj2p7g7gqt31lW1GqTQa0=;
  b=TPcM7PjymRrFoRf1fZiIUlFCljZxuqTDv1qP5TnXARhLFZpZ+Nqkj+P4
   W5w+J9GkrlDl7zzbMJf0RBjLIqYCwXa9uQ6tZCP0vqLoxmRpfTX2Yorec
   c1jd1dUiEPD10u8ZedyaulrHvfZRMthoMO7FrTjk5xQPOKH0dpCDkTnl5
   J73wa88eWs97fg9EWxzLn/Hax6uvNbUSrQrrmFBLg3JmqpvHbfVgPHR+C
   iWn18dv0jxOILs5EfO9u9/zsrds4DMz8fyP/Jy19FohbRI3OhGw0PMMgM
   fhQiKz0u0jURPqwq5BzyyZtIvj7GeGXCnYVG2saB95fLYS2pRMbrDXuDw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1809925"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="1809925"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 04:52:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="912083919"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="912083919"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 04:52:17 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1raEkJ-00000004UZX-1NlC;
	Wed, 14 Feb 2024 14:52:15 +0200
Date: Wed, 14 Feb 2024 14:52:15 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpio: sysfs: fix inverted pointer logic
Message-ID: <Zcy3fwAZXwJZpqqu@smile.fi.intel.com>
References: <20240214085248.6534-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214085248.6534-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 14, 2024 at 09:52:48AM +0100, Bartosz Golaszewski wrote:

..

> Fixes: d83cee3d2bb1 ("gpio: protect the pointer to gpio_chip in gpio_device with SRCU")

I'm wondering if instead tons of fixes you can just fold the patches and rebase your tree.

Yes, we still have time to let it soak in Linux Next, so Torvalds won't complain.
It will be much less burden to anybody who wants to backport this nice work.

-- 
With Best Regards,
Andy Shevchenko



