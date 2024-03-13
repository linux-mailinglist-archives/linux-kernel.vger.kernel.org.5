Return-Path: <linux-kernel+bounces-101427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4407287A6F3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5297B20D16
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1929A3F9E1;
	Wed, 13 Mar 2024 11:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O+FjSmVX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BAD3F9C5;
	Wed, 13 Mar 2024 11:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710328475; cv=none; b=hKlgBuoc0lXBFpXLwruONpKNUQfhakw9a+uk0cQpGarXfdxlO8cMh9MR88qyZwGXHxkxFAIdqR06cK06wmPBAYYo4XRI3h+iNWkT6ANTcmCQBsVatsgF+7XfvUbFED3gSRAqOIhjxjeZIOLA2JUvW6z+XnNarxHcw4CtMPyJMVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710328475; c=relaxed/simple;
	bh=rjBWIoX7FUFBKjKqdMh9OVQTIYw1aLir8rSR4UM0APg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSHC8EP8947lX//eB0EfBf4j27UpSAxNGVtuUB/f5TdN865o+KCi4mOA7FGKl2WxhA1cvQxvbkPv/jlqANqFXpXyg25Aq0vDRRyxyFPfjVMnT9C7eJAfu/BSaX2m+k2idWaZO7CepoDM0X7xiwU7srzyfX8NFlSqxCD4BhAZLV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O+FjSmVX; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710328474; x=1741864474;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=rjBWIoX7FUFBKjKqdMh9OVQTIYw1aLir8rSR4UM0APg=;
  b=O+FjSmVXZAjPNpfNfb/LO9tL7dZii7cKbjTOjZvrDR4Gd6M6+lGpMMrW
   T6m81jQ5b+Sf3gXZUhIDSt6mrSEELEU+TSIOhnf4/PJgZ5SDBacNxwK8t
   NOOd9Gqq2qe/pIYYK5nl0UD75aF2zV7/7gjL1++CZH9D3sdVU1F56P8s2
   8ANhds6VyqqF1tIntJVS90cP3cDHojoLCrXTeXJjPj2D48WCl+42IFEg9
   l17nUwKtKqoPgnMxOfufmSDZjJvyMjVoAteA4268JdLE3I/CFT+9dzICN
   D4mtaqbhZck9tUX6XQbptoIP746MxKmAlfFk3vAbnj4c4hvqr9W/UmtzD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="16532504"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="16532504"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 04:14:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="914429190"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="914429190"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 04:14:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rkMZ0-0000000CCC4-378N;
	Wed, 13 Mar 2024 13:14:26 +0200
Date: Wed, 13 Mar 2024 13:14:26 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Hu Haowen <2023002089@link.tyut.edu.cn>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v1 0/3] gpiolib: Get rid of
 gpio_free_array()/gpio_request_array()
Message-ID: <ZfGKkjxIT9AEd8dy@smile.fi.intel.com>
References: <20240307135109.3778316-1-andriy.shevchenko@linux.intel.com>
 <CACRpkda6bykOFY6gcZqRKLAnprUooZooQ_g7Rj_63da2akbwtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkda6bykOFY6gcZqRKLAnprUooZooQ_g7Rj_63da2akbwtA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 07, 2024 at 03:36:18PM +0100, Linus Walleij wrote:
> On Thu, Mar 7, 2024 at 2:51 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > There are only two users left of the gpio_free_array()/gpio_request_array().
> > Convert them to very basic legacy APIs (it requires much less work for
> > now) and drop no more used gpio_free_array()/gpio_request_array().
> 
> That's reasonable and makes the kernel a better place.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thank you!

Bart, do you want me to take it via my tree or you want to take directly?

-- 
With Best Regards,
Andy Shevchenko



