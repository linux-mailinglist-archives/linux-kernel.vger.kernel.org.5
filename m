Return-Path: <linux-kernel+bounces-81883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 908C4867C06
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D9B5B2B02E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3795112EBFA;
	Mon, 26 Feb 2024 16:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DBWZL+G/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5F912CD87;
	Mon, 26 Feb 2024 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964115; cv=none; b=t+oRyIhFmsfkU0ky5YDb/1hq4u52lkcMK+ale7q27pB5L91A3Y3Skkp+Ayl44LWca9pskqW2rwJ5lhfaWLuSNAqYCJe0gy+9PZbqz56+I6YbCRfJE42aibOY+6pZdKDw6XC4Wn0o/1ccc4D+nStK7KCzJMwV6rOvjikCzJjcmcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964115; c=relaxed/simple;
	bh=ebIz3T89aGtTZoWvteNoqSTuvZUAhKmkVJD/yZDFlAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSfE3gpoJjWTfOCNfnnzXOFV/M20HqSwsCp38j+MFX6xGejjoLRbPlVSvxQN8lPws9ycWqWqC1UYQin/6HSfDOrcMCTZ8CZ1a7h4vmU66UjyeYNnU+TSCxlPfWr3tWq+tu01F2Tfe7ucCYbUmJiLSu9XfYL00OZyT+Gpp4icuB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DBWZL+G/; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708964113; x=1740500113;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ebIz3T89aGtTZoWvteNoqSTuvZUAhKmkVJD/yZDFlAc=;
  b=DBWZL+G/jXmmZ6/GDj/NMLPd61pE1IkHaUC2ZYD4s5s3zgP5su8eeVT/
   rNigzpEi1a8AQVinM0aloAvJAN/cnqShJCfLzd5VEavl8ifSRYt2xxlG3
   Xzbi7s5mkT+49Ha7V3tmlITkFzecW5PC3MXWISvQ/YQgTJ6fFZSlstEZ1
   FUc8ohWZjG4etOGu6qmD/k4W+WZlsUcWtd1tZkqAsZ5Dyxq+Noyif8RRD
   29TNSSUfeV/oVGXwiDuELDoCpgsVs4qJJyBYdiSpJnzOZyIg4he52hWKS
   cLABCv2TayJIoVFYiGO/xANw6q4VDZ8mn3xW3WsP+9YnQV2HUmHzJeiQ7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3182113"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3182113"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 08:15:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="913880016"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="913880016"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 08:15:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1reddB-00000007jIW-42TK;
	Mon, 26 Feb 2024 18:15:05 +0200
Date: Mon, 26 Feb 2024 18:15:05 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>
Subject: Re: [PATCH v3 1/9] auxdisplay: linedisp: Group display drivers
 together
Message-ID: <Zdy5CYHO9OJDAxUJ@smile.fi.intel.com>
References: <20240219170337.2161754-1-andriy.shevchenko@linux.intel.com>
 <20240219170337.2161754-2-andriy.shevchenko@linux.intel.com>
 <CAMuHMdVv==58uen8nukLDB9ADCvJJFYTb2bZSAcFKQ0wUmqL9w@mail.gmail.com>
 <Zdy1icZvsr_NWt3O@smile.fi.intel.com>
 <CAMuHMdXDzKqTUHXE0JyKiAAqGtEoAE+cYQGboLCUzjpc52HCgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdXDzKqTUHXE0JyKiAAqGtEoAE+cYQGboLCUzjpc52HCgg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 26, 2024 at 05:03:10PM +0100, Geert Uytterhoeven wrote:
> On Mon, Feb 26, 2024 at 5:00 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Feb 26, 2024 at 04:28:20PM +0100, Geert Uytterhoeven wrote:
> > > On Mon, Feb 19, 2024 at 6:03 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:

..

> > > > +config HT16K33
> > > > +       tristate "Holtek Ht16K33 LED controller with keyscan"
> > >
> > > HT16K33 also supports dot-matrix displays using fbdev...
> > > Yes, categorizing is difficult.
> >
> > So, what to do here?
> 
> Create a new section for multi-function displays?

Not sure we need that. Too many sections.

Okay, I'll defer this patch for now. Seems too much bikeshedding around it.

-- 
With Best Regards,
Andy Shevchenko



