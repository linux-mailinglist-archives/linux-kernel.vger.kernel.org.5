Return-Path: <linux-kernel+bounces-91167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA2E870A87
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8002B2545D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8917579931;
	Mon,  4 Mar 2024 19:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cJ9ZT3lJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D94078B53;
	Mon,  4 Mar 2024 19:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579915; cv=none; b=KHXFTH7oLJelWIOjOc5Ybb9Uw+XPZNlrV5RzvkzFp2shvetRI4ku8M8w+/boyJmjlrpQZ5Zid50+wUWIlg/8xDTXF2M4OUWjf4nKEQYKkjhSDK9BFH3Gj9gtltuVlvNT5RYtawyMuxRdMxN5hq/zFRzZDe05qzG6/pH1xlQLD9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579915; c=relaxed/simple;
	bh=OidSgRgOiBrajJB9JvcNktFUgtOc4+6/4HD0banv1Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAviliRMUYgdr6m1ZXPnc5oSR9arx+0rn7lk3BeRvNfF+YNVoeNANOEiq7UV+6gDthUaP7Po9oFqXJ2COwiWE7mm6MGjE3ExA4o7y5VSa8RB/0Q6zhwPeVBbeg0SXgTnmiDstO/pkSvpf+QxLkiOrJVKmq8peVK8hgZv0b45Vmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cJ9ZT3lJ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709579914; x=1741115914;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OidSgRgOiBrajJB9JvcNktFUgtOc4+6/4HD0banv1Dk=;
  b=cJ9ZT3lJVOYtqr1vNbPQMyyO7KGnfBOlo8pj1/3LM6PZuUP+I9J2S8sc
   XaiwENFzcsVachRE+XbBI49vMUTltEPllibPbEBo/XTa4Gh9TKlAjXTLE
   j+t7Ygw5+WCrHrmGmo+facz7H4/jX47NuRKnwp+9mQ51xjUIt5aJYamIm
   ph4/xsPrZS5steky3sSLW2rZBS8+Gg7aAUnBmR8BjOrWpvIykisydrgN7
   Z+qVBz6EQsgAFd2CqeTvHGkB5s8Kk4pVVqu8WMm/TpvVpFs4pSgz+GUWK
   unU7fibu34eZ+iA+r9LtUbA5tMcwQSbapAftkNgs3tHom3mCLcOBI1OiF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="21629934"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="21629934"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 11:18:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="914113473"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="914113473"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 11:18:30 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rhDpT-00000009nXY-35rR;
	Mon, 04 Mar 2024 21:18:27 +0200
Date: Mon, 4 Mar 2024 21:18:27 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: pressure: Add triggered buffer support for
 BMP280 driver
Message-ID: <ZeYegxEF521ixMTs@smile.fi.intel.com>
References: <20240303165300.468011-1-vassilisamir@gmail.com>
 <20240303165300.468011-5-vassilisamir@gmail.com>
 <ZeW15Q2juyQuTw5q@smile.fi.intel.com>
 <20240304190838.GA4431@vamoiridPC>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304190838.GA4431@vamoiridPC>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 04, 2024 at 08:08:38PM +0100, Vasileios Amoiridis wrote:
> On Mon, Mar 04, 2024 at 01:52:05PM +0200, Andy Shevchenko wrote:
> > On Sun, Mar 03, 2024 at 05:53:00PM +0100, Vasileios Amoiridis wrote:

..

> > > +	struct {
> > > +		s32 temperature;
> > > +		u32 pressure;
> > > +		u32 humidity;
> > 
> > > +		s64 timestamp;
> > 
> > Shouldn't this be aligned properly?
> 
> I saw that in some drivers it was added and in some it was not. What is the
> difference of aligning just the timestamp of the kernel?

You can count yourself. With provided structure as above there is a high
probability of misaligned timeout field. The latter has to be aligned on
8 bytes.

> > > +	} iio_buffer;

-- 
With Best Regards,
Andy Shevchenko



