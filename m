Return-Path: <linux-kernel+bounces-66903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF1485635F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68653288C3A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BE712EBC9;
	Thu, 15 Feb 2024 12:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hrMhz0kT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCBB12E1FB;
	Thu, 15 Feb 2024 12:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708000706; cv=none; b=srGfhePGblmYGVt0KoJcZ3LIQC70/EZ96kAseaznuXX7DQ9RAeNqFeir//3iPi4BsmyFD7RKgGgUKYnOwfrNslvAFYhQR1Xu5k17xtY5RtWOxtdBak15fNQRxFn/j1zYWs8x8q4MdkbKosCMuyFb1LYsjqPBNHoJPd8uCT9a8vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708000706; c=relaxed/simple;
	bh=wX8xUiIMHpOyqdGdolyWgF5hNZn2Vqj8dYkmFKwuuDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/ba81O9TlG6nFNkudHg/FmkKJXrJAU2rmyYgwHuVAG9AtsSRzgq/fVGdGvZrT1lhBp/Gcc048rBi7B8ygkVvyxLVDMXDTClZPEV8SZTUP0BoHrwdrBvLOF+Lm6lEFPPVaoaoK/h6nYyLZvRo8LinqtU70KlSK3F6k+iMKvr+7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hrMhz0kT; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708000705; x=1739536705;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=wX8xUiIMHpOyqdGdolyWgF5hNZn2Vqj8dYkmFKwuuDQ=;
  b=hrMhz0kTTyRHcOYHmZzRwSQRH+m0k8yKAufCMcYyCrbuXICn2fWRhQ+3
   AteNkByHBBXN4LQmHCsAZVe2ouhT41M6mT0FdWC+Xjitv6sYAIzJNrQEX
   D6hsr1wZcHKeVO41TCFcgVPJvKYkWUiFevZoR/kVFvJHZrzELxtamp5RA
   bEIg6E/4Y79UftZ1SUPxDNfyqeoXixzP2X0hhQElKRC1C87YRK8U97P8t
   3TgRWD2BFXNub7zL4QGOA6F2406P8RcGJ9G1L2HvDhIKvmTTIG9F3ADfh
   jxR8oa5QEJlwCwpW7ivTMCvkQxQRdjSECas+I084hTAhoR2JoPxW5DGAb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="5051960"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="5051960"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 04:38:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="912159489"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="912159489"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 04:38:21 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rab0N-00000004n1N-1fm1;
	Thu, 15 Feb 2024 14:38:19 +0200
Date: Thu, 15 Feb 2024 14:38:18 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>
Subject: Re: [PATCH v2 00/15] auxdisplay: linedisp: Clean up and add new
 driver
Message-ID: <Zc4FutGKA0gUFvev@smile.fi.intel.com>
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
 <Zcz--YJmWLm0ikUT@smile.fi.intel.com>
 <CAMuHMdW5nwtuZpTyf+_41bcHeR+MA6Ko2++JiC8Xz6u1tDNQ_Q@mail.gmail.com>
 <CAMuHMdWKAf_Yi59RWoA5=K=ajS0-+Vn8tgwzy5tAzLmqizZLtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWKAf_Yi59RWoA5=K=ajS0-+Vn8tgwzy5tAzLmqizZLtg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 15, 2024 at 12:05:37PM +0100, Geert Uytterhoeven wrote:
> On Wed, Feb 14, 2024 at 7:45 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Wed, Feb 14, 2024 at 6:57 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Mon, Feb 12, 2024 at 07:01:33PM +0200, Andy Shevchenko wrote:
> > > > Add a new initial driver for Maxim MAX6958/6959 chips.
> > > > While developing that driver I realised that there is a lot
> > > > of duplication between ht16k33 and a new one. Hence set of
> > > > cleanups and refactorings.
> > > >
> > > > Note, the new driver has minimum support of the hardware and
> > > > I have plans to cover more features in the future.
> > > >
> > > > In v2:
> > > > - updated DT bindings to follow specifications and requirements (Krzysztof)
> > > > - unified return code variable (err everywhere)
> > > > - left patches 10 and 13 untouched, we may amend later on (Robin)
> > >
> > > Geert, I would like to apply at least the first 13 patches.
> > > Do you have any comments or even possibility to perform a regression test?
> >
> > I'll try to give it a try on my Adafruit Quad 14-segment display tomorrow...
> 
> With the missing return-statement added, the ht16k33 driver builds
> and works fine: the kernel version is happily scrolling by.
> I didn't test userspace line display control, as there is an issue
> with the uSD interface on my OrangeCrab, preventing it from booting
> into userspace.
> 
> Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thank you!

So far I have applied patches 1-6,8-9 with the respective suggestions
implemented.

-- 
With Best Regards,
Andy Shevchenko



