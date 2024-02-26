Return-Path: <linux-kernel+bounces-81634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A07386788C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02C5D28E45F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E44C12AAD6;
	Mon, 26 Feb 2024 14:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FpfIWN0s"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A7B1E525;
	Mon, 26 Feb 2024 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708957846; cv=none; b=M7N86ReWC8ptqIKP2JIsuolf73yf7UtYsrA0BjuWHb7NiYuThKQ0OjVmnoont/ekwFbArj+FYqRkovNC+7grNXTtlgLETJ2xdp1Sd1NiibXFvWmAinXfzdjYHDspcgYfCSL79pmDWQm0rd0rJR5EJLDJtKW+6hh/IQNG9SwRZag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708957846; c=relaxed/simple;
	bh=LhBfHEEPy2p8r111dcrfVfVQQ2d/9cT/TEBeONpztyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gE02+Xdw9ZcJe+GC5Z+Mv8Hwr13sC00i/24taz0MC6aeaVMuwizxkZY8KIGdnVIO1+N49p+yvgGKtw1yu7KQUXMh9O3edHH5wHIcxBjvD5XI+ghOWkJfzV7QYCWbpDyigppDjoxbWV9RXN0+UK6SAo3UWNx2Lq/FtxkcBnd2og8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FpfIWN0s; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708957845; x=1740493845;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=LhBfHEEPy2p8r111dcrfVfVQQ2d/9cT/TEBeONpztyc=;
  b=FpfIWN0sMD9wBLtjFG0VJWfT3BGKF6PH5MQpys4DdPVB/9y3nsPFMylV
   tPRy3Z4yoKB0W05MjQPL8qlcectuapNa+f+tdzXr4C/zP+bjSr0XCy4iN
   djNRbuiKM5pAm5tpCPik/uFzXZ6Hwyj+NxdIsy0eCVzgZ7qgUKqaGiwlv
   C3fpC7xwDT58Sy427X8QUcmTrRqsQw9LOnziuvK81Rp/4ao3tN8yeYN6D
   GAXszQAmOXLSB/9e7rG2hnn+PrgXu0bK9Zi+5tEigcJaaFeAp53Sx9aLG
   emwPr+KSnAOKkmZtj1HEDRXeXsYDck7fHBlPQ9rZUO5qQzSIciske23MH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="7049684"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="7049684"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:30:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="913873128"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="913873128"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:30:42 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rec07-00000007hfX-317g;
	Mon, 26 Feb 2024 16:30:39 +0200
Date: Mon, 26 Feb 2024 16:30:39 +0200
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
Message-ID: <Zdygj7NvL1kbiv52@smile.fi.intel.com>
References: <20240219170337.2161754-1-andriy.shevchenko@linux.intel.com>
 <ZddRZWftWhMHUl23@smile.fi.intel.com>
 <CAMuHMdWQ1hx143eJYyCcEj-uqQ3uXLWfB_x70bQDn=wp3kQG7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWQ1hx143eJYyCcEj-uqQ3uXLWfB_x70bQDn=wp3kQG7A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 22, 2024 at 02:56:35PM +0100, Geert Uytterhoeven wrote:
> On Thu, Feb 22, 2024 at 2:51 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Feb 19, 2024 at 06:57:59PM +0200, Andy Shevchenko wrote:
> > > Add a new initial driver for Maxim MAX6958/6959 chips.
> > > While developing that driver I realised that there is a lot
> > > of duplication between ht16k33 and a new one. Hence set of
> > > cleanups and refactorings.
> > >
> > > Note, the new driver has minimum support of the hardware and
> > > I have plans to cover more features in the future.
> >
> > Geert, would it be possible to give one more round of reviewing/testing
> > this week? I want to close auxdisplay for next merge window next week.
> 
> For 1-7 (linedisp and ht16k33):
> Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thank you!

> I hope to get to the actual review later...

Hope you will find time soon...

-- 
With Best Regards,
Andy Shevchenko



