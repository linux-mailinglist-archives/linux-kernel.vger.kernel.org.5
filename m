Return-Path: <linux-kernel+bounces-85636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 564EC86B887
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 057451F271EC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDE75E072;
	Wed, 28 Feb 2024 19:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LS2mROpe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34995E061;
	Wed, 28 Feb 2024 19:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709149676; cv=none; b=VheiP11L4Mp3ygRsMnEd/u5yd64WY3u7Ur3hS87w9ick5eThgSuxrdNMy66PubQ1662FyuLVB45+Xa2aDhKyc0XPNDlHStK0WNRP/gTD9TzWxTjCnmXV91Vlsbi/8W4ZgmOCeDFpbecdA+pTga/JichnrUtr5ppqM8j159oPHCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709149676; c=relaxed/simple;
	bh=nHTzfGCJs4IkOKWW1wX/rLHwtC3DLw1dVjv11QR6YRc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+y63vuMFaRqqCbjJePL8XD57YwB02OOXcudaFKWpLXBro0DWzlNtJZtNKcy7BFLsrsbbTTS1wP16ABcVo7iYG8RgVuVeOVD+aGU53uVsILT/KGReHRpzY2u+kYKMm0G8Hxb2/8o1OWrXg1sceyLdQLKaYqeFpJeYFS2CMUhy0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LS2mROpe; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709149675; x=1740685675;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=nHTzfGCJs4IkOKWW1wX/rLHwtC3DLw1dVjv11QR6YRc=;
  b=LS2mROpecfu/kDiBobTm8Hjg7B+dVe7FORQa6NXqH+5FZQGFi6HdR5vT
   SRbrsAq+TeXZWDvwsDQR2xCc+5O0mvtDyKCPkOy34cyfu67ubCicJLkXm
   izGeH6IpOiHwwFFNOWa8Q3Xqx96FeI2lEiUOxF3NUnk8vJxrjGmytImRd
   OiKrqXVVj3EIAIxVQZddB9I28lT9h8eEL+ONkspvGj/VCRjBRWkPo5ZE9
   NkzNNiKIwjVZOdCZ9hUI2WrfU9+p/cij11d2w4/20yVMpG0JVYt3s8qV5
   CCM4LuqsUhegVpRTw7LESK62/qtdSFVIW0i0EJvP/qlihipqkm/bWgTDL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14217269"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="14217269"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 11:47:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="913959659"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="913959659"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 11:47:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rfPto-00000008Tr1-3YrB;
	Wed, 28 Feb 2024 21:47:28 +0200
Date: Wed, 28 Feb 2024 21:47:28 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] spi: oc-tiny: Replace of_gpio.h by proper one
Message-ID: <Zd-N0KM8JC7cyl2p@smile.fi.intel.com>
References: <20240228194015.3605928-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228194015.3605928-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 28, 2024 at 09:40:15PM +0200, Andy Shevchenko wrote:
> of_gpio.h is deprecated and subject to remove.
> The driver doesn't use it directly, replace it
> with what is really being used.

Oops, copy'n'paste subject.
I'll send a v2 with corrected one.

-- 
With Best Regards,
Andy Shevchenko



