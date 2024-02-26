Return-Path: <linux-kernel+bounces-82113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB317867F75
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A6151F2FD21
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AAA12EBE5;
	Mon, 26 Feb 2024 18:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UM6Gobfs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD681292FF;
	Mon, 26 Feb 2024 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708970444; cv=none; b=ShY95imxGQyZMwLQ5StnX9fVLU6dSO8OaMGChZ1HJ8fG1ZCzQnY7L/G5Z33HuFVEg0C6IhjnTPH/fC50GVJT0PuLeeHm6dg1UP4M1MUfYKF++YhlOfO+c1kyhgOG6xQ/E2AjTTXn7xn8zr4adUL86oKOnilknqM3ieK9t8UcRJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708970444; c=relaxed/simple;
	bh=VMcEaJqmh4W1rqCAomEaP9U63qI/c6mU4JSNDfwoC/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lc22/o2tiJrjgfG7uDSHIJMp9mVKPYJGS1GmLA+iTfifmQsoy6PIrpPWAW7QBMhudvGoNEDodya3Vo6sxVzrx/Ey/sl8ABpLAgFZ/elGATvHrDhLFkObXV2LroSKVwoVTrQLT+mOC0GuWvXLNOIx2E7coaDrwJAHn014kpQH4fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UM6Gobfs; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708970443; x=1740506443;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VMcEaJqmh4W1rqCAomEaP9U63qI/c6mU4JSNDfwoC/c=;
  b=UM6Gobfsh5Iok/CZ4wD7bQAC/9j1WrY+qJLpMfJ0ij0zJZTWC0eF3bLh
   5iTcsVQYY40wNN1Dr51FPIsj/C9F0E6RmjlehPZcBm12tmtRTyawZAWCj
   61twzmTUCWezuAcrjw7xdBPIaLXLRagwjP1eZGydC4qfvvN8d6KhvLWP0
   /SrtMLyJWAyqbBVvGSliBp9ibHdUCgtcDrguPmFklFFxxV9y3iLOPKbX1
   S2/uCRAanNRKG6xtW2aEu7gg4mXuYcYCRlT399W1w3NIuHSka7Bc3M6md
   nLFPLPZwCxGFpUcd7LcL5cWX7rL0jh+xaBE/z85ZAkGKDnkXDl47dnTab
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3146179"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="3146179"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 10:00:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="913883609"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="913883609"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 10:00:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1refHI-00000007kpJ-3WOC;
	Mon, 26 Feb 2024 20:00:36 +0200
Date: Mon, 26 Feb 2024 20:00:36 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>
Subject: Re: [PATCH v3 0/9] auxdisplay: linedisp: Clean up and add new driver
Message-ID: <ZdzRxFG0WSDL8p6K@smile.fi.intel.com>
References: <20240219170337.2161754-1-andriy.shevchenko@linux.intel.com>
 <ZddRZWftWhMHUl23@smile.fi.intel.com>
 <CAMuHMdWQ1hx143eJYyCcEj-uqQ3uXLWfB_x70bQDn=wp3kQG7A@mail.gmail.com>
 <Zdy7PH8R21Zgzq1t@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zdy7PH8R21Zgzq1t@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 26, 2024 at 06:24:29PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 22, 2024 at 02:56:35PM +0100, Geert Uytterhoeven wrote:
> > On Thu, Feb 22, 2024 at 2:51 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Mon, Feb 19, 2024 at 06:57:59PM +0200, Andy Shevchenko wrote:
> > > > Add a new initial driver for Maxim MAX6958/6959 chips.
> > > > While developing that driver I realised that there is a lot
> > > > of duplication between ht16k33 and a new one. Hence set of
> > > > cleanups and refactorings.
> > > >
> > > > Note, the new driver has minimum support of the hardware and
> > > > I have plans to cover more features in the future.
> > >
> > > Geert, would it be possible to give one more round of reviewing/testing
> > > this week? I want to close auxdisplay for next merge window next week.
> > 
> > For 1-7 (linedisp and ht16k33):
> > Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> Thank you for the testing and review, I have pushed patches 2-7, postponed
> patch 1 and will see what I can do with patches 8-9.

After discussion I have applied the patches 8-9 as is in this series with
Geert's tags. The other things are considered as new features that can be
implemented later on.

-- 
With Best Regards,
Andy Shevchenko



