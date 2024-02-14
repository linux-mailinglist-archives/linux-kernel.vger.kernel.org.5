Return-Path: <linux-kernel+bounces-65838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5088552B2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22696B27E78
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B232138488;
	Wed, 14 Feb 2024 18:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HdqVmsai"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D13139569;
	Wed, 14 Feb 2024 18:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707936696; cv=none; b=m0SCq83N+lbjIbrzRMjSqvYsupAZml088euU1Hso9N5/XKDFH4v1G6f6bf153WB6we3lAgrJVDz2Np96ZFKPfxe/Q3ZCIhSr3OjrwxHWUtTOx0JXkE0K9+2rZEUccJ9DwXGBwBwr0dQl1asACU8f9o8qsNqK7LRAr4BOwuowwCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707936696; c=relaxed/simple;
	bh=C7ZecKmows7A/FnODjYQYrDRyqjpmvCXfGu6TaOC4B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gz+S3iGZJRHVwcf7h/qfQJkASr9Fl+s72MbEhGq/gZE76/wOFCBPY+EcTWiDvyS5mPl/zKZqPv2a5HbkVDcnXU2S93Far6juYof25wUlF//jKtykRrhQTyKnq4x4ivCoutFFFqlRW5VS/chOqE/hbriW0OTd337VlFSe1+zTZ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HdqVmsai; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707936695; x=1739472695;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=C7ZecKmows7A/FnODjYQYrDRyqjpmvCXfGu6TaOC4B0=;
  b=HdqVmsai+FgSOvtDSoxo5yDOiPQwLh5N7ow66aMdZtz5Gx+xcnTzJXSR
   X+a+5cucgr6GYtZAnHrmV0oPASxDTMQW7wybaRaIbO411NoF2kAGMgzLR
   UnOf2BhEO6XzQzNOAdxHmV5LltMpP5KLKj7MtRsKG6K9iUIT2YhirXXCn
   7xM62ewL7jv3WSQwkio9DySfycQD3xAyjsBwrFYCos1uJxmcCNWryoz6t
   UdMk7i9WVDfIJk97rT4I24yU03+yHkH84ih3hjo+d+38Iv3myuEhHFsiY
   sYK6s+i3iHesRkaKdWZ4Rio8Tg2hEazm5o3KHwP0e8fSYi7QPatyGUuuC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="1869772"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="1869772"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 10:51:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="912094191"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="912094191"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 10:51:32 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1raKLx-00000004ZvU-37RZ;
	Wed, 14 Feb 2024 20:51:29 +0200
Date: Wed, 14 Feb 2024 20:51:29 +0200
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
Message-ID: <Zc0LscBjCefhJhyx@smile.fi.intel.com>
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
 <Zcz--YJmWLm0ikUT@smile.fi.intel.com>
 <CAMuHMdW5nwtuZpTyf+_41bcHeR+MA6Ko2++JiC8Xz6u1tDNQ_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdW5nwtuZpTyf+_41bcHeR+MA6Ko2++JiC8Xz6u1tDNQ_Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 14, 2024 at 07:45:01PM +0100, Geert Uytterhoeven wrote:
> On Wed, Feb 14, 2024 at 6:57 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Feb 12, 2024 at 07:01:33PM +0200, Andy Shevchenko wrote:

..

> > Geert, I would like to apply at least the first 13 patches.
> > Do you have any comments or even possibility to perform a regression test?
> 
> I'll try to give it a try on my Adafruit Quad 14-segment display tomorrow...

Thank you!

-- 
With Best Regards,
Andy Shevchenko



