Return-Path: <linux-kernel+bounces-65702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1138B8550B0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74B64B2E685
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2A01272D8;
	Wed, 14 Feb 2024 17:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e8WL917S"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B77386626
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707932528; cv=none; b=SGuL6Vy0MFd419vDSM6d3ajnPoqaBeFuS8vK7eLUsdwS/UAjPKBLN/avJtsMK6So+s9fYPAcCcndg+gKSRBURsbE883Rt69QN0r+vFfnGeKWVYDl48yAnqxkOAv3pfbsAyOHoc2Y2LRrhLlxVpm6V1A30VGNzDbJcJhg/4ldSWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707932528; c=relaxed/simple;
	bh=RkJA8zFGyR+zYsP1Izm/sn2k0s81YzTj+3JEEfjJ+9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTPxMn6tfq2ZdUDCEzJM2TbdmeSf+RCYgjefY8qVNOnty0UsTHTb2ND1SLxUftRlSf3a9+ud0z9ahCO4+J0MXFPHcVo+Azr3a9YweSJcxh9Vp63+lPR134BKOCueUjN1s9MEtR3aOisTlXCZlnzjjXuDQGIfMUf5S6TRGU9ZAJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e8WL917S; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707932526; x=1739468526;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RkJA8zFGyR+zYsP1Izm/sn2k0s81YzTj+3JEEfjJ+9A=;
  b=e8WL917SL2+PO+Oo5gfrLMn6bh6CZ+g9rq/R7M7sQzC1aMw62OaGsMKG
   l5BFmszilU4hcQnTr1zpVUQdsF7E+sxBJ0Zc/TwSSz28V++NXz2bZsadc
   5qajUgSeb8lh9bvn008QShYC6+uFKlBJ20etldHgsb0bf++tTjnCjxOVm
   ICcB28vF4zAKIlt5VpNt/Z4+Wk1SJOgv+RyhH2aNySZilmz+oNa3pMwp1
   b+ijayNJUcWgnGpc0jl8L9oQFjmiaCCca9t6vyt1WY7E4eZevpp9MKc5r
   XTrx8ly8lOZQG9fM7fCWsfUkIsypiesf9InOuarxSs04N18oYkNo9HemU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="13379433"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="13379433"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 09:42:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="912092493"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="912092493"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 09:42:04 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1raJGj-00000004YaZ-3uqy;
	Wed, 14 Feb 2024 19:42:01 +0200
Date: Wed, 14 Feb 2024 19:42:01 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	linux-kernel@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [RFC] include/linux/make_type.h: Helpers for making u16/u32/u64
 values
Message-ID: <Zcz7aXE6bVhJGEyw@smile.fi.intel.com>
References: <ffa107dd-23dd-47e0-b3bb-06c60ca3e2e2@p183>
 <Zcz5GmAtPbdInWJU@smile.fi.intel.com>
 <cee345b1-a5aa-41bb-acb7-9b2aaef5bfb5@p183>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cee345b1-a5aa-41bb-acb7-9b2aaef5bfb5@p183>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 14, 2024 at 08:39:35PM +0300, Alexey Dobriyan wrote:
> On Wed, Feb 14, 2024 at 07:32:10PM +0200, Andy Shevchenko wrote:
> > On Wed, Feb 14, 2024 at 08:20:55PM +0300, Alexey Dobriyan wrote:

..

> > > Secondly,
> > > 
> > > 	#define make_u64(hi__, lo__)  ((u64)(hi__) << 32 | (u32)(lo__))
> > > 
> > > doesn't truncate hi, why?
> > 
> > Because it's not needed (the whole point AFAIU is to override promotion
> > to a _signed_ type (int) and here it makes no difference)?
> 
> Well,
> 
> 	make_u64((u64)-1, 0)
> 
> will return (u64)-1 unlike

How? It's shifted by 32 bits. Am I missing something?

> BTW, I'm for truncation, but it should be done everywhere.

I'm not against this.

-- 
With Best Regards,
Andy Shevchenko



