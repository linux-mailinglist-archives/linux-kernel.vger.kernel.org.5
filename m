Return-Path: <linux-kernel+bounces-61748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B557E85160E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6B9E1C22E4F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8573E3BB3F;
	Mon, 12 Feb 2024 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E1CzMy81"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9124E40BF5
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707745579; cv=none; b=CxMMb8sjoJ1hSServx4qQp1ebWSib02qKtW/6yzZj/XNn9zSqu2YqUo/7q39VkCM3Qaz9UKuEOVHDi3PoiiXF+L/XNmSyfQnlvMomYc43aAZQdEDAQE6soT0wm75e6WB9YhuLaZO13sTefDzvulJle4y6l+5U8eDJNgLx/gzoGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707745579; c=relaxed/simple;
	bh=6fisl7qee84eeW8kief/AJ1gRZ3bAn96vAlkKmkKhMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ruEvC3AND40Rq9aOObRp5wpDPJND1uVatLB+CY8VtoOxKhYEEw0rX/1pBi8OCwYjCuEy83P2QPh9z9BViHi1fbWewxW7FuLFWszxUMNUf9O0FlhciqW3hfCeXjm66pUbIK2wEK1Jedq8Nmdjwgqz1fS9fFM2DwuWhIf/FdTex8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E1CzMy81; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707745578; x=1739281578;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=6fisl7qee84eeW8kief/AJ1gRZ3bAn96vAlkKmkKhMM=;
  b=E1CzMy81Y3rpYi56Uooe9h31ZDckKGK66+iFOkXgkdc76tD8Af8f67Uu
   a7pMjVaSXrdMaAdT9sfds6vnrZZ5nVmz0Mw/BZTEKeSJvuOoueQ6UOa1Q
   0ikeLRwoMsiA9y8THftEMhLdHd4yeDml0HEPzPr4CsWYQ7UOrbZpxpGi6
   vWeheBHTTN0i+fcKUB7sKt946mEGEZxgtIBl9GOWjLxfR75Wh9l2CPyBY
   om38XHax8lj4Ha+BlHJ3svyMZ8otZmVmRRM3RRoAqDDy8aLpW7aklzDN3
   UnCwdDCSt+IFKP7jwBGqPXobrDL85+dXoL6t0OLsJ+FLWwhKACf6nApqV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="5534098"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="5534098"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 05:46:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="911485478"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="911485478"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 05:46:16 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rZWdS-00000003uTk-0218;
	Mon, 12 Feb 2024 15:46:14 +0200
Date: Mon, 12 Feb 2024 15:46:13 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH v2 1/3] auxdisplay: Take over maintainership, but in Odd
 Fixes mode
Message-ID: <ZcohJT2bAyA0M40J@smile.fi.intel.com>
References: <20240212132515.2660837-2-andriy.shevchenko@linux.intel.com>
 <20240212132515.2660837-3-andriy.shevchenko@linux.intel.com>
 <ZcoezKt4zKvO8jOf@smile.fi.intel.com>
 <CAMuHMdVeSMavAdZxCxh7wFLcXQu-wE_vvDvpA1WV-R3mrZ2-DQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVeSMavAdZxCxh7wFLcXQu-wE_vvDvpA1WV-R3mrZ2-DQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 12, 2024 at 02:43:47PM +0100, Geert Uytterhoeven wrote:
> On Mon, Feb 12, 2024 at 2:36 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Feb 12, 2024 at 03:23:53PM +0200, Andy Shevchenko wrote:
> > > I have no time for this, but since it looks like I'm the main
> > > contributor for the last few years to the subsystem, I'll take
> > > it for now. Geert agreed to help me with as a designated reviwer.
> >
> > The typo ("reviewer") has been fixed locally.
> 
> Please drop the "with" before "as", too.

Sure!

> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks!

-- 
With Best Regards,
Andy Shevchenko



