Return-Path: <linux-kernel+bounces-50123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACF884748B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC1028510F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5DE1474BF;
	Fri,  2 Feb 2024 16:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KAAF+dvk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0962114691C
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 16:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706890783; cv=none; b=n7Njr5vztmQY0VBOsaALo1E+8QioXkQ5yBweI1uSlyuhbRVTJxuFz9xNCHFCeDe1zmbXRAAfzw/xLgy0WHpZbJ3gwWsfTwCCO8Vg85JEFY85ALtGcyF7mAZoyF3B3T7l9+pe4NEk9wItZQHzORp7cztsoUl0CUCEbiDdHD+jLYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706890783; c=relaxed/simple;
	bh=iBulCc3SoVRLPdtGNVL+0rm2yqUVtuItnRwMqaYpERU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtMdKngsSWhS4MV9buq+U//Bu1tGUBbGl/TraZqQxOOtq7lM6bGcRV1b7qM/Fr4NCfGqUH3wtIHAWSidEpU+sCsEqc30zUgqZvfyr7ZWC1Ptz9cdI+dYe3mrBwuME8XV1l8D579IfG8/QCbPLw20Lrm4ncKLb1tBmKLIB5z7x/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KAAF+dvk; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706890782; x=1738426782;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iBulCc3SoVRLPdtGNVL+0rm2yqUVtuItnRwMqaYpERU=;
  b=KAAF+dvkCgSEIFq8gPUTlNXemc2d48IIdm8P3S3ANguQWO3DrhpsIPlI
   Ak/muZ/CfTwTJRmGr1YAvMwmjOWOqCt2Txmi13Cwy4YZWK9QFEKiHHJs1
   XQizVQBS8M2UW/Tg5CkORIeyG4H7hk0uDET8ckgMZOR9zyF7lTR2oOdAk
   oJEVYVrpAzpsr2O+JfKY7T98dv1z/vS6wi52+GlHmUjjIpsVRZJa1qwXs
   pNjC8c+ej1100wU51Y6DV67rZYeG1we1nJ0v8ANPEYeaUBcsrBDguZUQZ
   nAu+UMcV39FM0824Jk7hNTSk93fiakSkrV7DfVK9lUP+AT3/f87VoZszJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="10930188"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="10930188"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 08:19:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="823247497"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="823247497"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 08:19:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rVvZu-00000001J34-1Ij6;
	Fri, 02 Feb 2024 17:35:42 +0200
Date: Fri, 2 Feb 2024 17:35:42 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [resend, PATCH v1 1/1] logic_pio: Use RESOURCE_SIZE_MAX
 definition
Message-ID: <Zb0LzpBkE71wWyqO@smile.fi.intel.com>
References: <20231016132611.1201402-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016132611.1201402-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Oct 16, 2023 at 04:26:11PM +0300, Andy Shevchenko wrote:
> Use a predefined limit instead of hardcoding it.

Can we apply this one?

-- 
With Best Regards,
Andy Shevchenko



