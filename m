Return-Path: <linux-kernel+bounces-67035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E98385651E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815031C24387
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA370131757;
	Thu, 15 Feb 2024 13:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XHT2UyBt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4E258ABC;
	Thu, 15 Feb 2024 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708005450; cv=none; b=iXcIa8eYORXYyT9Hw3j0u7kolnt7q7H88/T5uQzeIYmVYshUDRY6n/QZrwO9nyDm1GBdNMmY/HkliAlOP3xTnwjiItFiP2fzU7cW4oVE8Kezehoghi27kjZAlAepb0C7gE/r1TwDEZAWVJuF52pDzoAENd6ygv9JSK46hmrhVss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708005450; c=relaxed/simple;
	bh=qX8uFgsdsrj52VOCLla5Dzge8AOEWRLR3S6SAVVCBws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFgYLhQhD17lq6PDyIuAOlw4fPnKCPCvYvUqeltsrnUzdsTzOtt8dIT4sMCicjRyVJ4OhktQ2+1s6DdOIGIK4Y5zoaD7mo+65llHEdCT4x6NBwhuUQ9U2d+PXwp/SD3/vG1zePQxyenPdbjr/Ic3di9NfRLrH7c40Pd8lHR+OwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XHT2UyBt; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708005449; x=1739541449;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=qX8uFgsdsrj52VOCLla5Dzge8AOEWRLR3S6SAVVCBws=;
  b=XHT2UyBth5AGYqISbDE1ajyy0vJy/3it9jghYrCar3HNy1CSHm0nIWyn
   Sena2gJSbe6XKIXJe38/ESdDxOyujO+13NOfAjf0ern4xkh6S3Gf13Gyn
   gE8Ohq24OSJAhYzi2A2kqTBHRGi1MaG7tuJgvdWIvxOikmHMEA0xtCFxM
   bjVgHp1F6gZrlYe2naQhSei1YNWBnjPjxVzIZ5Dj2pQyN6vprdMwpxq4s
   9zaKcS8tb9S91ZC4Gc5XqPWalpixVXlBLhMlm3DL0lVyB7/mWGlm3TL8M
   a1MQ8RtQWzeJTuOWWg5lPbo+UnmxXrfM6BhnCQ3+nctcuXpPlqUs+slx+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="5920031"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="5920031"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 05:57:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="912169572"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="912169572"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 05:57:25 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1racEs-00000004nyr-33bb;
	Thu, 15 Feb 2024 15:57:22 +0200
Date: Thu, 15 Feb 2024 15:57:22 +0200
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
Message-ID: <Zc4YQk1LP_DoCRGu@smile.fi.intel.com>
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
 <20240212170423.2860895-8-andriy.shevchenko@linux.intel.com>
 <CAMuHMdW=gTH12vLALAU_ioCKX9E2mJ3uR+8Q6GT0brc4yg83_A@mail.gmail.com>
 <Zc3147U697zQ6OwY@smile.fi.intel.com>
 <CAMuHMdWqfUHGP4t17=4UVE0uOFqwpc7dF8D9MCU4EmdYSnfjDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWqfUHGP4t17=4UVE0uOFqwpc7dF8D9MCU4EmdYSnfjDQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 15, 2024 at 01:35:32PM +0100, Geert Uytterhoeven wrote:
> On Thu, Feb 15, 2024 at 12:30 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Feb 15, 2024 at 11:05:00AM +0100, Geert Uytterhoeven wrote:

..

> > I can add blank lines to follow the same grouping as in Kconfig. Would it
> > work for you?
> 
> Unlike Kconfig, this is not user-visible.
> Most Makefiles use sorted entries.  If they look unsorted, people will
> just add new entries at the end.

Wouldn't be easy to catch at review phase?

-- 
With Best Regards,
Andy Shevchenko



