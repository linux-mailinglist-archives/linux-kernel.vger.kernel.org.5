Return-Path: <linux-kernel+bounces-135579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8669E89C7E5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F07C5B22862
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE50613F457;
	Mon,  8 Apr 2024 15:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jjQ4CwZ4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8BE12A154;
	Mon,  8 Apr 2024 15:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712589117; cv=none; b=b6v+olCweOK8/sPMPU4v5/ST7OO6hllbV/Mq5sF6gRnnJgwTenD3/Kqx46PMEZkKenaymhnHTg7KS/V6uu2crRhp+lPuUVK7VGL10cKWF0O9acnYVf5Uhy63vstIHEiDxO20CrQ94zDgFhRVpIev1MKBwfBkjfISZkneeZ1TJa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712589117; c=relaxed/simple;
	bh=P8HE0rFijZ4gW6gVZ9VNhtJuhLxXT61UoK/XpvYF5B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcYv+wBj96XjX1tk8m7WY6LIwSnsUFSMAHMncj54mLN9RCYyGxKHSq0acixaCUeJIQSzIH1I5ds5NewH8sRu7nCNTSqWp+TRRSDrZo1pRcFF3OVLjb6xFv9gfol1/NPxx9VX4X49zF+hq/8tMk2YBW5R6OYgffJzt4MDkSRJS3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jjQ4CwZ4; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712589115; x=1744125115;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P8HE0rFijZ4gW6gVZ9VNhtJuhLxXT61UoK/XpvYF5B8=;
  b=jjQ4CwZ40RzFnmBQfqqEJ1EyB2C28ChHSFJvEXobHF2i/9No5LyQYdyU
   rjNeHJHfZbEMaW4i/AZFYJelcJBdxnxMtf2Qz1NcCTTbKGs2DgnAFkg1r
   1ZBdem7Y15yirCiAuwtRPMjuOdXfhzkiyHI92QF1rQDZETDF8HL40HAHW
   rsBtte6sX/pgD0N5PZ4dzXWGy6Aesck8wvS/DuI5Sko8URKnNumLzGMd2
   m5DSvLHLJcJ4bPDkRiuZb/nP1ukC01joenQ9NTvvosvEJZXZ+jhSyg8Wy
   mZgueCAc9B7H4WHkn3yfmZSxirH8XPrgDylkWW3a2zkIk8sHYyHkmK0L9
   g==;
X-CSE-ConnectionGUID: ATRh2mS1SXeP6tSdZ9Z+bQ==
X-CSE-MsgGUID: qAgZUqkBREOhk42TORBnVA==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7728890"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="7728890"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 08:11:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="915368239"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="915368239"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 08:11:51 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rtqey-00000002Yh1-2vLX;
	Mon, 08 Apr 2024 18:11:48 +0300
Date: Mon, 8 Apr 2024 18:11:48 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Guanbing Huang <albanhuang@outlook.com>
Cc: gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com,
	linux-acpi@vger.kernel.org, tony@atomide.com,
	john.ogness@linutronix.de, yangyicong@hisilicon.com,
	jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, lvjianmin@loongson.cn,
	albanhuang@tencent.com, tombinfan@tencent.com
Subject: Re: [PATCH v5 0/3] serial: 8250_pnp: Support configurable reg shift
 property
Message-ID: <ZhQJNMM4J2KAAycn@smile.fi.intel.com>
References: <PSAPR06MB4952B86F64A6CEB853114EA4C9002@PSAPR06MB4952.apcprd06.prod.outlook.com>
 <ZhQI1RgQtQuctUuL@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhQI1RgQtQuctUuL@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 08, 2024 at 06:10:13PM +0300, Andy Shevchenko wrote:
> On Mon, Apr 08, 2024 at 11:36:21AM +0800, Guanbing Huang wrote:
> > From: Guanbing Huang <albanhuang@tencent.com>
> > 
> > The 16550a serial port based on the ACPI table requires obtaining the
> > reg-shift attribute. In the ACPI scenario, If the reg-shift property
> > is not configured like in DTS, the 16550a serial driver cannot read or
> > write controller registers properly during initialization.
> > 
> > To address the issue of configuring the reg-shift property, the 
> > __uart_read_properties() universal interface is called to implement it.
> > Adaptation of PNP devices is done in the __uart_read_properties() function.
> 
> Seems okay to me now,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Note, you have an issue with your email server. The cover letter is not chained
with the patch series. You really want to fix that if you wish to contribute
to Linux kernel project via respective mailing lists.

-- 
With Best Regards,
Andy Shevchenko



