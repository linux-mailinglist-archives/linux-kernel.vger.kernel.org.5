Return-Path: <linux-kernel+bounces-73110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9974985BDB5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A79FB225E2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3BB6FBB7;
	Tue, 20 Feb 2024 13:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="imjvNTTQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23A9745D1;
	Tue, 20 Feb 2024 13:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708437103; cv=none; b=iNhiYncMDKLVOBWafhA2vOa5SdZ77sdlm/58dLZmIEy4AUPiebYpyYaOTwVpmVT8gqx47L2Nyj7u2ayo2J31cKHz47WSJ4h4fxpwZhlQNrhfmtZav/0IiiDdrnjD/t9KrlmZos8TNmMZty8NkAiRD9fsN+Tc30TY4JUyZyswPuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708437103; c=relaxed/simple;
	bh=u/nkQIbUOOazaOCFAMFqzg5k3FPWQwHYWcP2DyIsmOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cld9wY9F9FspExeleAK7trCBaYihqVPJ39P4iUgupmE/jiFSQiqDtuYf54jMYqynB2A5oQYc2FdYBfWXVpWoYcBKsICQrNiC5dvMwaDXafQTjhffPT1vGmXBCPla9K7O8U6GxxNiJmO681xvsxMC3NbMsMpOg19KhP3l5v02g6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=imjvNTTQ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708437102; x=1739973102;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u/nkQIbUOOazaOCFAMFqzg5k3FPWQwHYWcP2DyIsmOM=;
  b=imjvNTTQIKwEmG5eh1ZkCr9S2ClZ86Whles5fbjNuH5BVXUi4b2QY4Yy
   cLOH36L0CR8uIZc7dH4R8PIlUtO+6TWOjeR4e7/wQU0HGF3NYmxT0ciWN
   7DoVNRONhaGGUKiItgeYQkXuyxaHYmLYwfdx+8qn4grUSneEE93mCGVgE
   7mXHiGDXWLTgs2o9dIAbfSjYJp1wlgddM4uksUpYfYuLnJQVRdzazCUXa
   TcdoGWk657Xi0a6oH8qnBiPmhAby69leMfGQQU19i63cbJgR8OI/bNqxn
   rY1T2C/SPcYePV+1mI4U9kNndLNEAkcoziG7aY5qSK3YYSsQSEssiAedq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="6356328"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="6356328"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 05:51:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="913079649"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="913079649"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 05:51:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rcQX2-0000000661a-1DSI;
	Tue, 20 Feb 2024 15:51:36 +0200
Date: Tue, 20 Feb 2024 15:51:36 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, lars@metafoo.de,
	ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
	semen.protsenko@linaro.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: iio: pressure: Fixes BMP38x and BMP390 SPI
 support
Message-ID: <ZdSuaLA36yPrdwqz@smile.fi.intel.com>
References: <20240219191359.18367-1-vassilisamir@gmail.com>
 <20240219194213.6b0f02bc@jic23-huawei>
 <20240219195145.GA18787@vamoiridPC>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219195145.GA18787@vamoiridPC>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 19, 2024 at 08:51:45PM +0100, Vasileios Amoiridis wrote:
> On Mon, Feb 19, 2024 at 07:42:36PM +0000, Jonathan Cameron wrote:
> > On Mon, 19 Feb 2024 20:13:59 +0100
> > Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> > 
> > > According to the datasheet of BMP38x and BMP390 devices, for an SPI
> > > read operation the first byte that is returned needs to be dropped,
> > > and the rest of the bytes are the actual data returned from the
> > > sensor.
> > > 
> > > Fixes: 8d329309184d ("iio: pressure: bmp280: Add support for BMP380 sensor family")
> > No line break. The fixes tag is part of the main tag block.
> > I can fix that whilst applying.
> > Otherwise this looks fine to me.
> > 
> > I'll leave it on list a little longer though as both Linus and Angel
> > are still about and might have time to also take a look at this.
> >
> 
> Thank you very much again for the quick answer. Since you can fix it while applying,
> I should not annoy the mailing list with more e-mails. Just for future reference,
> when you mean no line break you mean between the main block and the "Fixes" line
> or between the "Fixes" line and the "Signed-off-by: ...." ? 
> > > 
> > > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>

The standard pattern for the patch (as it is seen in the `git log`):

---8<---

iio: ...Subject line, summary of the change...
BLANK LINE
..Multi-line description, may contain blank lines...
BLANK LINE
..Tag block: SoB, Rb, etc. tags (may NOT contain blank lines)...

---8<---

-- 
With Best Regards,
Andy Shevchenko



