Return-Path: <linux-kernel+bounces-158323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 142508B1E55
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 455B31C215C5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC98B84E17;
	Thu, 25 Apr 2024 09:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hA+51ocC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F66E84E06
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714038354; cv=none; b=Bb5rQ2hrZpzIO1/Qn8fdk7WDWGMrtiwXKKB/85XaxKbJYXnzE3aBbJzXYblSEQf/7s7++9SNwSI/5YLJRO8/os8L0qg52o0gdssO9Nj2Yh3XFPQw8rPeESO/nK13kYkZqdKKhFY9Unzxy9oOXXbUNt9BYySiri9Sx9+iUcrdOOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714038354; c=relaxed/simple;
	bh=/oVl3AjiJEOEaBDGsZSThW66CADV4XIvv9sn85hqQlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acuWRi9jPSCAmB1U8TYvIaiBaTLVKWTHY3GrrR8qJPlVtIFTy0pxX5AiZdKAE75adEMFy99VfJJqWQ61/DFw3iUzqAUwWeeU6gxSGF5j1oD7rnMyl57+FjbH83rTfOWVM6s0wC7tYCYDWif+9bGPiSp1SJni2mGG0ZZddWhwCdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hA+51ocC; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714038353; x=1745574353;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/oVl3AjiJEOEaBDGsZSThW66CADV4XIvv9sn85hqQlc=;
  b=hA+51ocCfc7d0xYW7q038pitA6/d5Nqb0AXUBQOT7mjn3kikJXaZWsyS
   PD9BXQpkosr8cF8VwP7ttxTXH90Ccr79e0UsZ1EXEfU5njlUVeKV7rnqv
   kTny3MKtu7WCDNBShgcHyOSlqr+pJ1JFkP5nqCV1bPe8wJ4LIW0Vtu7re
   1p7tRx1jMAVWlV+V46lG43hkIj99zcUeRbqoCjUSQHqLPVsU5TRL7rBBr
   GkuX28+1i9YHq/66/fJ9stsz3kYFdD8zW0FkH6MlClrtYLhl7pwukBdD4
   7rr5YBff8iJvs8PLPAqJRw7AUpn20aGsWQ39ZTzTQLsYYnAiFvTZd+U8G
   A==;
X-CSE-ConnectionGUID: z3kQ6s/SSF6iao0OSTERIQ==
X-CSE-MsgGUID: npNpZxs8RnSX8NMjqxsQAA==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="21133188"
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="21133188"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 02:45:52 -0700
X-CSE-ConnectionGUID: BXcjopMXRPWnKL65Zhc1WQ==
X-CSE-MsgGUID: PiSM1DAURgeDBvLyq5Vh+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="25005287"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 02:45:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rzvfa-00000000x43-2PlG;
	Thu, 25 Apr 2024 12:45:34 +0300
Date: Thu, 25 Apr 2024 12:45:34 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] mm: page_alloc: Avoid defining unused function
Message-ID: <ZiomPotab29kNe5f@smile.fi.intel.com>
References: <20240423161506.2637177-1-andriy.shevchenko@linux.intel.com>
 <68489f85-5579-5cff-eed1-55ae585916f3@huawei.com>
 <ZiofNBBRAKTUsh9Q@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiofNBBRAKTUsh9Q@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 25, 2024 at 12:15:32PM +0300, Andy Shevchenko wrote:
> On Thu, Apr 25, 2024 at 02:25:24PM +0800, Miaohe Lin wrote:
> > On 2024/4/24 0:14, Andy Shevchenko wrote:

..

> > > In some configurations I got
> > > mm/page_alloc.c:656:20: warning: unused function 'add_to_free_list' [-Wunused-function]
> > > Becuase the only user is guarged with a certain ifdeffery,
> > 
> > guarged?
> 
> A typo, thanks!

FWIW, Andrew fixed this along with "Because". Thank you, Andrew!

> > ifdeffery?
> 
> Yes, this is established term.
> 
> > > do the same for add_to_free_list().

-- 
With Best Regards,
Andy Shevchenko



