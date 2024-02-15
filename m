Return-Path: <linux-kernel+bounces-66789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45659856188
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00EB329176D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1665012AAC1;
	Thu, 15 Feb 2024 11:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bkqR6Eya"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5407129A75;
	Thu, 15 Feb 2024 11:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996489; cv=none; b=kYxWriWD12sG7Plmy+PQg7cZxneGATu4CdozN11kO/PKrH5AFtzTQc1lWMzGcKemrGl1K/Z7FBAXEDUFkWDC+h8BvpN//X/Z1KBLQB2lilN3RXthmTkvV+wyEWOxdTAJ3cPyhRfmff+GoqZFS/hA4j6xFYsIq6cDqYbrMmm6SdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996489; c=relaxed/simple;
	bh=xO9ERZYT04zobE8avkfrLBAVFW+bp83vnhF4juLP3AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1pDdLEn9L3ZQ5itBn1VMRNfkG30OIxLFkf1xN43ZqPI7CsEkagL3JW94ATN780PLwrIcx0HIZj91KsUgWFC3ts5JBiE2LilQMpr/zPvU1HfuAWzNRAc2BzxmnvBo6IGDPZhtAFArKCXzok1D/mVmHTzo2S0u0nxXn1UOYmK23Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bkqR6Eya; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707996487; x=1739532487;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xO9ERZYT04zobE8avkfrLBAVFW+bp83vnhF4juLP3AY=;
  b=bkqR6EyawmhotfDgII8pyqI/tFR6JZ8/XUGGfVc3F5UqDexZDaf78lJy
   HxxqxESLJK45t9yUE+GGkpw6lZW3Mbzttn+aLI1MKvWnNSZBPmDzeBu9F
   1yJjZ0iwrSx1yMSi+nHYHXdb7wI/Bwk3cjiWjHqZE7UA8J9tYRavG+MFW
   YUT2ExM/VQQnW2o+eoDGxLMMqieh3U9hr2m4NI4fh7pM1r/G9o2D0k36T
   64dRsJ36i+VG5qW3zyvh37veLTzEhvckhZSN8V4KBhRy9Me/qSoa17VMg
   Al+TI4E+PZiGjRRzCpdVCDCITdeb5C60qQ+Chyi8gleX4gn87Wc0o3lLu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="1954098"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="1954098"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 03:28:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="912149520"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="912149520"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 03:28:04 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1raZuL-00000004m4B-4BsW;
	Thu, 15 Feb 2024 13:28:02 +0200
Date: Thu, 15 Feb 2024 13:28:01 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>
Subject: Re: [PATCH v2 03/15] auxdisplay: linedisp: Use unique number for id
Message-ID: <Zc31QVEEzM5jQ0jy@smile.fi.intel.com>
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
 <20240212170423.2860895-4-andriy.shevchenko@linux.intel.com>
 <CAMuHMdUWw-_dECEXrTt--AX400YZOhP7b+tBOD0bHYQmS0z=1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUWw-_dECEXrTt--AX400YZOhP7b+tBOD0bHYQmS0z=1g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 15, 2024 at 11:03:27AM +0100, Geert Uytterhoeven wrote:
> On Mon, Feb 12, 2024 at 6:04 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

..

> >  struct linedisp {
> >         struct device dev;
> > +       unsigned int id;
> 
> Note that there is a hole on 64-bit platforms.
> Hence I'd move id below, so the hole is at the end of the
> structure, and might be filled by future changes.

I had checked timer_list, but while it has holes, without debug it ends on
4-bytes boundary (without debug enabled), otherwise on 8-bytes.
Nevertheless, relying on the above seems fragile, so I follow your suggestion.
Thank you!

> >         struct timer_list timer;
> >         void (*update)(struct linedisp *linedisp);
> >         char *buf;

-- 
With Best Regards,
Andy Shevchenko



