Return-Path: <linux-kernel+bounces-135571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B3B89C7B7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB6651C21812
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436BE13F438;
	Mon,  8 Apr 2024 15:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="INAQY9pl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278BD13F422;
	Mon,  8 Apr 2024 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712588524; cv=none; b=KMPNX2NE/vSNpmGZCpq8SlUjs7ITerXAk/NQMUWr81QexcV/Gh/k/ty8jlYNrdmZT0O4pl/zWwRs3mdwscpDns3Yw7axBeOUWdlvrYN+PhNqwSPG3NklkBdv9VDiVi5OSLlZdil3SaVrKOzHW0xHhJdwT/L6nKotdDF2ZayjApc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712588524; c=relaxed/simple;
	bh=0fm5UAQptjK49s3k4o1ZvgOcWUKR5HCx6nDBDq21tGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5CO5xP+zPVSlX7aQTmyfUg2DfOV300azifBLOyVOs037ejbhDwfYZXKkHOjNAyeqYKi1Zf/ErFk3tE9cKTldA0G6CalQKCqqMF94DJat7j0lCbAkdwJTgp+59jsk/SoWouOQY2gWtjNWzVocOpdQw72OEdU63KqJa1PjUDn5PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=INAQY9pl; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712588523; x=1744124523;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0fm5UAQptjK49s3k4o1ZvgOcWUKR5HCx6nDBDq21tGs=;
  b=INAQY9plPpuJJypnBB+48hrLMzChAbMBs4WCY/V/nmPZxQiK4CM5LF7A
   8vu257uazWHoeys5z9CdkHGmaIofNNn+PFojB/2rQ5cYqX5T6BBaEpzsM
   gyRNqNJiIsXpy4A/Yu/tJQHL9IZLLNB2GaOEhmVyu9TjTtOQjojsfKFub
   N+5Zf7S0U9IOL2+dwKoh92Cix8loplWMa4PlOQKxbVYi+K9R+T2E2ywa3
   gb3Fv5kf138y+NSh1bV9JwmaD6rWgCUpX/f358260crB9qbUu9BDS6G0n
   CNRs7x8WPgnoIlA//gzwT0tpCtuB203FhsHEM6R44fOqzQI9rYkAno/nS
   A==;
X-CSE-ConnectionGUID: KpFNMJy0QHmFBF4jgUhSyg==
X-CSE-MsgGUID: /eVH7T/iQDClHDlI1aO2iQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7727281"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="7727281"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 08:02:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="915367984"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="915367984"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 08:01:58 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rtqVP-00000002YZr-2wNS;
	Mon, 08 Apr 2024 18:01:55 +0300
Date: Mon, 8 Apr 2024 18:01:55 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Angel Iglesias <ang.iglesiasg@gmail.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
	u.kleine-koenig@pengutronix.de, biju.das.jz@bp.renesas.com,
	linus.walleij@linaro.org, semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] Driver cleanup and series to add triggered buffer
Message-ID: <ZhQG41ZhHprOvgsH@smile.fi.intel.com>
References: <20240407172920.264282-1-vassilisamir@gmail.com>
 <57fe9ec305efff58a2ef1e2ba6e334f042a2ad77.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57fe9ec305efff58a2ef1e2ba6e334f042a2ad77.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Apr 07, 2024 at 11:51:22PM +0200, Angel Iglesias wrote:
> On Sun, 2024-04-07 at 19:29 +0200, Vasileios Amoiridis wrote:
> > Based on next-20240405.
> 
> Hi there! Small tip, with git's format-patch, you can include this information
> for the people applying the patches with the argument --base=<commit or branch>.
> This will point to git the base commit from which the series build the
> changeset.

Moreover, CIs will be able to properly test it.

-- 
With Best Regards,
Andy Shevchenko



