Return-Path: <linux-kernel+bounces-135633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBD189C8E8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE28428689E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25E7142E64;
	Mon,  8 Apr 2024 15:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="drrUGeTW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C19C14265A;
	Mon,  8 Apr 2024 15:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712591601; cv=none; b=rrAxEG1poWde8lshxzAr+8WIqmpBERs4I/sYXFxJpPZFHgErN1sQdPTFhTAxAR5vFOd95cLS2ry+4go6dIJI8O8T1kG8gOFqTG840onvi/MWNS1ONzf1dwlq9XuQ3oXW5qedtZChkSt5dgBDPA+vfiNfTSB6DfkW+nW49t22shA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712591601; c=relaxed/simple;
	bh=Ayz7Pk1l7/zi8DRIp+xNrMxlwSWlL1f67lgps6EFpgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PtHzf6jwVYvf72fkkaTczBE7AwQeFbW5ZGGsgbC2/v94AC649w6tWXVuDuGrUynGBgcr2DoGlet//2L31RMJsP8a5srPvzWYxu6uNpZzavWCoddCmNQyC4caxTPvtt+jLuSpkU/SkJMu2hxPCebIMcDq8jLruZPqEiclvsh9kTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=drrUGeTW; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712591599; x=1744127599;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Ayz7Pk1l7/zi8DRIp+xNrMxlwSWlL1f67lgps6EFpgc=;
  b=drrUGeTWb/RYNQwm1wu8S8CWkHFVY51C3OHaWLETEXQ8qymgD10m/TTj
   UEmeYGGNlu09qudh18clqQYXEuikUoEEQsPan7LCNT/VQHPGR1Tt0hIQc
   XA2zRBYG1g93mLZz8ls6yJzzoYP5Vz68+paFCBwIkvmbuR04pf/sV/hVB
   nbqU46n7Xaa9W2k5/N8chQNGDSfhN8WNQOhcep8zHnLo2AbnxAl0uq5eR
   gEtw8EvWhX/DtbaYnm/kG7vGDeEI7Vpr8Qab0gGOJaw7lO3dNzrvPCYfQ
   uBRyuKT5XfBJjZPzceWr/+SKn2XfW0IYu8hq2yadEO9JgxnhhWDer98IU
   w==;
X-CSE-ConnectionGUID: 21Rfsuo3RZuos7YudC5kVA==
X-CSE-MsgGUID: jeAbz/UJQjKf2egUneo5aA==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="10850176"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="10850176"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 08:53:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="915369182"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="915369182"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 08:53:17 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rtrJ4-00000002ZJF-3Z42;
	Mon, 08 Apr 2024 18:53:14 +0300
Date: Mon, 8 Apr 2024 18:53:14 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1] ACPI: Declare acpi_blacklisted() only if CONFIG_X86
 is enabled
Message-ID: <ZhQS6uYmpsxFD3gn@smile.fi.intel.com>
References: <20240407063341.3710801-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <ZhQE9dU-VIcWI6au@smile.fi.intel.com>
 <CAC41dw-Df3L7B=Tq2QkQHDT2Yf3MzHgy8-czPAkZhdPf0Tea4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC41dw-Df3L7B=Tq2QkQHDT2Yf3MzHgy8-czPAkZhdPf0Tea4Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 08, 2024 at 08:42:48AM -0700, Kuppuswamy Sathyanarayanan wrote:
> On Mon, Apr 8, 2024 at 7:53 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Sat, Apr 06, 2024 at 11:33:41PM -0700, Kuppuswamy Sathyanarayanan wrote:

..

> > >  extern char acpi_video_backlight_string[];
> > >  extern long acpi_is_video_device(acpi_handle handle);
> > > +#ifdef CONFIG_X86
> > >  extern int acpi_blacklisted(void);
> > > +#endif
> > >  extern void acpi_osi_setup(char *str);
> > >  extern bool acpi_osi_is_win8(void);
> >
> > IIRC there is already similar ifdeffery, can we just move the declaration
> > there?
> 
> There is none for CONFIG_X86. We only have some combinations or
> derived config checks like below:
> 
> #if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
> #ifdef CONFIG_X86_IO_APIC

Okay, it seems I mixed this with acpi_bus.h.

-- 
With Best Regards,
Andy Shevchenko



