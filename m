Return-Path: <linux-kernel+bounces-66794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EC1856195
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B8341C21BFF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C7E12AACF;
	Thu, 15 Feb 2024 11:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VDZcAQJg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A2A53369;
	Thu, 15 Feb 2024 11:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996651; cv=none; b=kVV1XJ6lmlEa/eZE3XnKzoBCkII1wCQH4Y2qc2g8F2W8dz7K34T+ljHuoD5T96x2E14XwJgA5dBF0ICOYg2QEJS5x74l7GOb8BueDCQlmClQkTuztr/6Tl5ZLHS1Hj44vRnDgCB0GVo+cfZnut45wnz31KiO/xtDtLWLzP45aDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996651; c=relaxed/simple;
	bh=OQ3ONUklx6xe0843f/W9xcoeemcGjph6v2Pe5TPLF8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ck2/4/ZnxBaqd167eIKdQjOur6t3WuuKjul5+BIYCiU6Sc2N8V+NiAl30UiZKomIEaev0yw9zx60q3LGgfiJsk78My4XNZRwnUqZz7AF+tYdPNrHNWWbXWRCKtgy31BZ0Fkv+nu95ooi8OcfqLX5ie933FjkTHxrug00/gXbAOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VDZcAQJg; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707996649; x=1739532649;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=OQ3ONUklx6xe0843f/W9xcoeemcGjph6v2Pe5TPLF8M=;
  b=VDZcAQJgb7QA1H1QY/hyq2SWRuuUw2dXspH43hodzltN+gq3S9wwaiV1
   9097kcj2OfrprHbRRCmQ2a7u8sufTuwqoNbu9j4kMS7xJIDTdsYcJwd3/
   xHZd95H/RhDn3HUYh/QNead/U6JiO24Vn5G8jt/l7Yh71UcVcFL46dfLZ
   4XXL5gNgQfLwojh60Bc6t6W3xe9sRETe4Z4dhXAMUhYq/Z/eIuxsub+Bt
   El6W56J8RcLE/st1g6PwS0hMX8SCm81Jf40Odd/1hODCrMKi6KA26HgqU
   3F2/T2GzQ3cs0C+PWhY/qiPRa9v/aUVD0Nf54n8KZRCXO1m+5iw0gMwIZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="1954407"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="1954407"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 03:30:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="912150105"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="912150105"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 03:30:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1raZwx-00000004m5l-3Aw5;
	Thu, 15 Feb 2024 13:30:43 +0200
Date: Thu, 15 Feb 2024 13:30:43 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>
Subject: Re: [PATCH v2 07/15] auxdisplay: linedisp: Group line display
 drivers together
Message-ID: <Zc3147U697zQ6OwY@smile.fi.intel.com>
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
 <20240212170423.2860895-8-andriy.shevchenko@linux.intel.com>
 <CAMuHMdW=gTH12vLALAU_ioCKX9E2mJ3uR+8Q6GT0brc4yg83_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdW=gTH12vLALAU_ioCKX9E2mJ3uR+8Q6GT0brc4yg83_A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 15, 2024 at 11:05:00AM +0100, Geert Uytterhoeven wrote:
> On Mon, Feb 12, 2024 at 6:04 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

> I think it would be good to have "# <display type> section" comments,
> to make the grouping clear.
> Else I wonder why "L" is sorted before "K" ;-)

Makes sense, I added locally.

..


> Shouldn't this (and PARPORT_PANEL and friends) be moved up, to the
> character LCD section?

I tried to be less invasive.

..

> >  obj-$(CONFIG_CHARLCD)          += charlcd.o
> >  obj-$(CONFIG_HD44780_COMMON)   += hd44780_common.o
> > -obj-$(CONFIG_ARM_CHARLCD)      += arm-charlcd.o
> > +obj-$(CONFIG_HD44780)          += hd44780.o
> > +obj-$(CONFIG_LCD2S)            += lcd2s.o
> >  obj-$(CONFIG_KS0108)           += ks0108.o
> >  obj-$(CONFIG_CFAG12864B)       += cfag12864b.o cfag12864bfb.o
> > -obj-$(CONFIG_IMG_ASCII_LCD)    += img-ascii-lcd.o
> > -obj-$(CONFIG_HD44780)          += hd44780.o
> > -obj-$(CONFIG_HT16K33)          += ht16k33.o
> > -obj-$(CONFIG_PARPORT_PANEL)    += panel.o
> > -obj-$(CONFIG_LCD2S)            += lcd2s.o
> >  obj-$(CONFIG_LINEDISP)         += line-display.o
> > +obj-$(CONFIG_IMG_ASCII_LCD)    += img-ascii-lcd.o
> > +obj-$(CONFIG_HT16K33)          += ht16k33.o
> > +obj-$(CONFIG_ARM_CHARLCD)      += arm-charlcd.o
> > +obj-$(CONFIG_PARPORT_PANEL)    += panel.o
> 
> IMHO it hurts to not sort Makefile entries alphabetically.

I can add blank lines to follow the same grouping as in Kconfig. Would it work
for you?

-- 
With Best Regards,
Andy Shevchenko



