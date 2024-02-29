Return-Path: <linux-kernel+bounces-86575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A87F086C74C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBFDC1C22978
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BA07A700;
	Thu, 29 Feb 2024 10:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N6Pv2Zeq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842C865194
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709203806; cv=none; b=Ls6+zPz6fFq6d88xP7dzyiqBWsV5YPG/r4EVCsLn8vBklSPKbnhr/NhqmpSSxJ1P0+/QkeG4Wh9QeRP5lq5LOu/SueGVIVnZExHt2fDCUoqj8Mz30I3uUc55VpDLYaTCnGAWEZOnqZb315VKKskDqKTRcsX4xiUKSvZ78eo5qQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709203806; c=relaxed/simple;
	bh=0Ghs1427kpjULFuDpCFdojY0v88USn8crvkTL9I/BSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7cTnYkUjDlgrAZ6dWXwhB5zS5pxNU7c5Nx2X60a0OIbjH5fFvqLRRYlLd3CC4lYCDTm1ThZH+cRN/XIEmSCXnpT2fIQij8Nah0fqXDoG0/TgIXT5iCf3MWuwSrtlWtSjDlvfC0ODeYF+sF4D2gcSvu0xKQvlpS8cgkxALNGxoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N6Pv2Zeq; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709203805; x=1740739805;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0Ghs1427kpjULFuDpCFdojY0v88USn8crvkTL9I/BSk=;
  b=N6Pv2Zeq3cWfFKggCRbj1IAic3YB+s2daIHsXIjPMj7JQ8b419s8+XX7
   Uj+bDExNjhqg+7mdARsSU8uHmGJEeRT7HheLe3OD7TizapdzsUS9O9YAj
   CgZS7fJdiJb4yfQFSNRl+c0sRVCbM4KPgz67j/nwr+AfyNvQF+fCO6q8X
   MrkGsKHRsExPv0v2t62xQURPWDhX/gjSRuh9n5Qmldu4ivbjE5kqop5MH
   4MhFCPuw5ITcEFqYDcKUr3p6UcTdEGnp6sNF2fyuDI27HEYkDAJHd4YGC
   mueG+EC/bhsx60AoyU4frKrrAIzrKe8v/xud8GhgY5WZtOhYwKEjVHVsC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="21121860"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="21121860"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 02:50:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="913978834"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="913978834"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 02:50:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rfdzC-00000008e4b-0MBF;
	Thu, 29 Feb 2024 12:49:58 +0200
Date: Thu, 29 Feb 2024 12:49:57 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v3 1/3] bits: introduce fixed-type genmasks
Message-ID: <ZeBhVb__VNQCgTQk@smile.fi.intel.com>
References: <20240208074521.577076-1-lucas.demarchi@intel.com>
 <20240208074521.577076-2-lucas.demarchi@intel.com>
 <CAA8EJpprfrtOjNzT6TFhV1n6MXzLdTahanfxcRW4uVjeHaBduA@mail.gmail.com>
 <ZdZlVn9BI-0q1Xdn@smile.fi.intel.com>
 <btssirjumey2kcp5dyhe6m3embdwd5bswjz3c6swrhxfijfhld@lztxaptkegw6>
 <ZddfF7kb54o2c/QR@yury-ThinkPad>
 <3o3nvkg76sofrhgcuogo3wuhitnz3bgus6qzle7pejng3v4s62@frdbuj46uiu7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3o3nvkg76sofrhgcuogo3wuhitnz3bgus6qzle7pejng3v4s62@frdbuj46uiu7>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 28, 2024 at 05:39:21PM -0600, Lucas De Marchi wrote:
> On Thu, Feb 22, 2024 at 06:49:59AM -0800, Yury Norov wrote:
> > On Wed, Feb 21, 2024 at 03:59:06PM -0600, Lucas De Marchi wrote:
> > > On Wed, Feb 21, 2024 at 11:04:22PM +0200, Andy Shevchenko wrote:
> > > > On Wed, Feb 21, 2024 at 10:30:02PM +0200, Dmitry Baryshkov wrote:
> > > > > On Thu, 8 Feb 2024 at 09:45, Lucas De Marchi <lucas.demarchi@intel.com> wrote:

..

> I build-tested this in x86-64, x86-32 and arm64. I didn't like much the
> need to fork the __GENMASK() implementation on the 2 sides of the ifdef
> since I think the GENMASK_INPUT_CHECK() should be the one covering the
> input checks. However to make it common we'd need to solve 2 problems:
> the casts and the sizeof. The sizeof can be passed as arg to
> __GENMASK(), however the casts I think would need a __CAST_U8(x)
> or the like and sprinkle it everywhere, which would hurt readability.
> Not pretty. Or go back to the original submission and make it less
> horrible :-/

I'm wondering if we can use _Generic() approach here.

..

> > #define GENMASK_INPUT_CHECK(h, l) 0
> > +#define __GENMASK(t, h, l) \
> > +	((~0 - (1 << (l)) + 1) & (~0 >> (BITS_PER_LONG - 1 - (h))))
> 
> humn... this builds, but does it work if GENMASK_ULL() is used in
> assembly? That BITS_PER_LONG does not match the type width.

UL()/ULL() macros are not just for fun.

-- 
With Best Regards,
Andy Shevchenko



