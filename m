Return-Path: <linux-kernel+bounces-129502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94093896BAC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE9372920AA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93501137774;
	Wed,  3 Apr 2024 10:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i/SOJQMH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ED013667E;
	Wed,  3 Apr 2024 10:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712138878; cv=none; b=lyj4CyIRrcEht20YnNJpW/NiMakmRScPmsXxhiABkL2Zc6/2zTucUIRydpOChQbDjy3P0omvu2j8U7hhC8BYVoPjouHWmlN0Jy4ptDdgu5wjT6cXjsWS2p1MK8UNp04zSEI8uWqP5is3XAoUUUoTlZ6eQsgP9EEWfsBqZC4Pro8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712138878; c=relaxed/simple;
	bh=lliMUOsXEts4XSI5J1Vp7adBehF0j1L3Zhp4i236Y6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0vjb6c44xVsABccy1q2HpzQRAAXSxMpMzMbhwRPejZIEycXbVEebdHvSrsyRCR0HhtEHwptSP1ky4AUA6D7X0XleMBg9ZxfCvEbliaE4ymUoJIUCldoTtagNDwGrt3Cv2/AKPy5eQzpac0dxpivWb9jf0ovI6NFaJ+1qoo7FWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i/SOJQMH; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712138877; x=1743674877;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lliMUOsXEts4XSI5J1Vp7adBehF0j1L3Zhp4i236Y6Q=;
  b=i/SOJQMHzfDx/fVHPSPhSPihxIKlKCH3/NvmZy7NNLU6rQwGCYwach4U
   Q7M/aSwWkPvs/fEVhsBxRpcBPiOC+peFgbIqOxGR+qvqdSyqzDJxUdFuw
   MM0zMbfJlKFAvWl/DQyzfNJ6Z1XxM+FTicnvy6880hHGpe99Yr/tK2yOf
   i+avZAFjq3dq680k75Ur/awLmlLfhu0gI/4jfQ3xpkMFTqLjwvl7V+j33
   hxe8WweqBoVuK79A2H9ScYETvz79VL0qQSvVic9cxcFCF5agkQkkeUqTA
   yBm6IgKY1P4+E6amFEZLf26iad6Eh7ZIfA5TbpEWibjWVzThc/VKY4QQ0
   w==;
X-CSE-ConnectionGUID: Jt/UJR3jRfm5+5X/RPTYPQ==
X-CSE-MsgGUID: 3n3i0ZQbRnqm91KCIytBCg==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7486071"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7486071"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 03:07:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="915177337"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="915177337"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 03:07:52 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rrxX4-000000015JQ-1M10;
	Wed, 03 Apr 2024 13:07:50 +0300
Date: Wed, 3 Apr 2024 13:07:50 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Guanbing Huang <albanhuang@outlook.com>
Cc: gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com,
	linux-acpi@vger.kernel.org, tony@atomide.com,
	john.ogness@linutronix.de, yangyicong@hisilicon.com,
	jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, lvjianmin@loongson.cn,
	albanhuang@tencent.com, tombinfan@tencent.com
Subject: Re: [PATCH v4 0/3] serial: 8250_pnp: Support configurable reg shift
 property
Message-ID: <Zg0qdpZu1N4SJw8E@smile.fi.intel.com>
References: <PSAPR06MB49524F135EBF81C4F2D181BCC93D2@PSAPR06MB4952.apcprd06.prod.outlook.com>
 <Zg0pBzp5IRPkrZeQ@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zg0pBzp5IRPkrZeQ@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 03, 2024 at 01:01:44PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 03, 2024 at 03:41:27PM +0800, Guanbing Huang wrote:
> > From: Guanbing Huang <albanhuang@tencent.com>
> > 
> > The 16550a serial port based on the ACPI table requires obtaining the
> > reg-shift attribute. In the ACPI scenario, If the reg-shift property
> > is not configured like in DTS, the 16550a serial driver cannot read or
> > write controller registers properly during initialization.
> > 
> > To address the issue of configuring the reg-shift property, the 
> > __uart_read_properties() universal interface is called to implement it.
> > Adaptation of pnp devices is done in the __uart_read_properties() function.
> 
> Thank you!
> 
> I have a few comments, mostly cosmetic except a couple in the last patch.
> Most likely the v4 will be good enough for merging.

Btw, your cover letter is not chained in the same mail thread, be sure you run

	git format-patch -v4 --thread --cover-letter ...

to have proper versioning and cover letter to be chained with the rest.

-- 
With Best Regards,
Andy Shevchenko



