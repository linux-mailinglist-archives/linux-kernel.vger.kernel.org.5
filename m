Return-Path: <linux-kernel+bounces-65686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1903F855069
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8147FB216BE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20968405C;
	Wed, 14 Feb 2024 17:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ELSP9WyT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77416839ED
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 17:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931937; cv=none; b=cVHBaHAaXFPSBkb869nDuIYo271UXZ3cuqrpOZk191sXxQM6mBu0tnuWywsgmvH8ZNBbYfVGHPt9lk2EgI+6uXBECafOGbZdx81uu9ZKfQYX9KEx5Vzunss47R56v0++XtWDWN2xBQQdzeiQ+bWWKoPYw/KQTF/CckkutZsCzig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931937; c=relaxed/simple;
	bh=HFuTE/RRyHBJ0w6ayf2wpkyBRUytUEblMcir9+zBrtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=am3EBnfHXhTBez8gjKxV+tVz7mUeRRTm4+oZXioIrrodrAolKP0OsViA2acPiLJ5z9dS5UFuAbGHR174SI/Dx4UZkRxxgbQ0agnCNc8jhyVtQAMzGM0QrVi6q/55lCb+hQalQRxde2bENmU77nbkIRMUmZeuy0F40tDfq9w7e8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ELSP9WyT; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707931935; x=1739467935;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HFuTE/RRyHBJ0w6ayf2wpkyBRUytUEblMcir9+zBrtc=;
  b=ELSP9WyTAuwki0mux3E/33UevsEFPBWsoAZE1IjuGmK30ExOgL96Y/Fw
   mH23bFpi34875enwECv4Ks8gjvUCbUax2bCjO5on15JCDlY70rjin4U86
   pJJByjsB1xJr/KkT7FGI0d20ttkf/HnH3Df6cSaJxexk4sma6sGnrN+3t
   Rh6p3E2lsE3OlQfoeOXAkMexWshOSqEsPGTujanONfsK8oY0qE3LTFzvM
   VHnPEmwSKCnr3rB71+eZjwOFikWKyb+uV2xKHLo3EGecsDKvXgUbc9ydf
   egIPd184jOkeXrcVGPFy5LEj0FLexF2vHx39ikQuIm6DCxJkeJ3hpPhz2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="13378323"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="13378323"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 09:32:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="912092212"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="912092212"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 09:32:12 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1raJ7C-00000004YRz-3g2Q;
	Wed, 14 Feb 2024 19:32:10 +0200
Date: Wed, 14 Feb 2024 19:32:10 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	linux-kernel@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [RFC] include/linux/make_type.h: Helpers for making u16/u32/u64
 values
Message-ID: <Zcz5GmAtPbdInWJU@smile.fi.intel.com>
References: <ffa107dd-23dd-47e0-b3bb-06c60ca3e2e2@p183>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffa107dd-23dd-47e0-b3bb-06c60ca3e2e2@p183>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 14, 2024 at 08:20:55PM +0300, Alexey Dobriyan wrote:

..

> Secondly,
> 
> 	#define make_u64(hi__, lo__)  ((u64)(hi__) << 32 | (u32)(lo__))
> 
> doesn't truncate hi, why?

Because it's not needed (the whole point AFAIU is to override promotion
to a _signed_ type (int) and here it makes no difference)?

-- 
With Best Regards,
Andy Shevchenko



