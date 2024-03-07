Return-Path: <linux-kernel+bounces-95894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FF58754AB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79F071F23994
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7BA12F398;
	Thu,  7 Mar 2024 16:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F653QqMN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586EB1DA37;
	Thu,  7 Mar 2024 16:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709830431; cv=none; b=DGGt52K6DegA6efqdRIAifeVQ0Kxqyf9hjZYUBLkWm+1Q7ws0tBJk23HNwU7RCijBblHqrTCn05NY4HkskNJRggkJQEoGvxERpuDl+sK776USlu7hJzHKDqFAxPO8fV6CWQuBnQzFsfVq2acJqItgN2cGqIEfzRRSA0cLYDsUUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709830431; c=relaxed/simple;
	bh=oganuwlF5WZy6Fd8LiJnjle4bvTjEaVC7hfAlFeYgto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bt95EjeJQbXodiLxXJxLhqE3xBgcRb8a28doF+/7UggSIbocVppr0Jmp7Shuxh4+FUyeIaHAbNFuRi5k+sdI/ROHx/JPSBNPJvw2xyemU8EvVWUAfUGqczeWg9EDxGvj7jU6r9njwj3JtvUjxdbA2IYGbDfYBhVdiF0roICHK8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F653QqMN; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709830430; x=1741366430;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oganuwlF5WZy6Fd8LiJnjle4bvTjEaVC7hfAlFeYgto=;
  b=F653QqMNZBfKLbKKVOpjSUxZ8/DhiallF52NZbBbisW6IuSA38S/M8Aq
   RkCuN3F63AyxJgT3Zk3R1U7aWmbzbH5/G80D5MSUz+3gtUvbaeQe4iNjj
   n+zhIwmDELBqxrriPVC7I+T32IPBvXGD2k4A+4WeXwKMALeSrMfiJpSjt
   hF9wws9IcIhuz1L+XBOcMeaqiB7mw6qOAH9786BNqo0COQpSfhASLUTpw
   ii7SfyLAufWc6KQpvckaSYrGAi7C3Omn6Htk7XAxuROlGwEWkvvBTL6gI
   OXWGa8dnYoaN5ymVIzkr6eXeX56c6HJJtXL4RDdU8EUsyL5xMxMlTpq9y
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15233984"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="15233984"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 08:53:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="914219411"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="914219411"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 08:53:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1riH04-0000000AcTa-1zLu;
	Thu, 07 Mar 2024 18:53:44 +0200
Date: Thu, 7 Mar 2024 18:53:44 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 2/2] spi: pxa2xx: Make num_chipselect 8-bit in the
 struct pxa2xx_spi_controller
Message-ID: <ZenxGMHYcCFlpUd4@smile.fi.intel.com>
References: <20240307160823.3800932-1-andriy.shevchenko@linux.intel.com>
 <20240307160823.3800932-3-andriy.shevchenko@linux.intel.com>
 <64cde1d1-1d4f-484a-940f-536c1279287e@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64cde1d1-1d4f-484a-940f-536c1279287e@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 07, 2024 at 05:37:17PM +0100, Arnd Bergmann wrote:
> On Thu, Mar 7, 2024, at 17:07, Andy Shevchenko wrote:

..

> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks!

..

> I wonder if we could just move the entire header to drivers/spi/.
> The spitz board only fills the num_chipselect field anyway,
> and that could be derived from the GPIO lookups instead.

It seems to be used by drivers/soc/pxa/ssp.c.

-- 
With Best Regards,
Andy Shevchenko



