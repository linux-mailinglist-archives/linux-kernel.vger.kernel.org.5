Return-Path: <linux-kernel+bounces-65633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E94854FB0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEC13B2CC65
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D4C82C6B;
	Wed, 14 Feb 2024 17:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bQvbor3o"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081C77D418
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 17:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707930965; cv=none; b=R238xVQoxKx5WFXESMEkDl9b2GQML9WcvGr/0DQyWdqmZx63RKbulgZ4/pZ2mPI6GRKx+MuCEnpatkf/mdIBt39yXry/uTKFP0uLqz3tTirqyejR3FcYZ9s4v6OSZNTRouu4W0nzkL7FH6L/GaSonItT/mbYXHIAei6nks+nfso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707930965; c=relaxed/simple;
	bh=RJtU3OHMizV/FeysWQDi1FGXOk/xvSYR2aW1L7j+urU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Derm7SgbwOVDupCTo0Z0u3MOY3Xnjuh/CcapGyQe1lXBEXsHAdezETizIFkPvy2SYR3kqdhKGAX5whKVDlS2ZDXDovm4O/T4QdWIcxga0mX2EUNLZZf7wdOstQJsADce25/WRNlEi2JnxgYrBkg9QuBL775OvkgQv/Q8x1A4TQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bQvbor3o; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707930965; x=1739466965;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RJtU3OHMizV/FeysWQDi1FGXOk/xvSYR2aW1L7j+urU=;
  b=bQvbor3ofg0cW3RbqarEE2TApmaxSxc2cAI3CwitFmexfJ52RaP2USOI
   XXS9jv3PRY3alq/4BF3lYY/rkHiWFuVfcgulPZSiewOA3FW0jWzeoBWxw
   Zikhvp48PYIgyuyU4up6+Ywi+rBnf9z6hb3pw+i5Myq0yjDHv5Sa2CKO8
   Y1DXZnxnZGsx1VnFg+mxwTqmiNG0PLxCKuXW6M0kXK07/cbCh+dh5bhLq
   CIWjtZBfShm8xTGHL+m/B+cw8UrgGYBQ001EDIAwfj/F9tYLm7dFjHIuA
   q9gMqjsxIZ482tI8UVLSIKLrGKHF6zTflzuH6HC9HsEM10kvf7My8UdpP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="24458520"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="24458520"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 09:16:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="912091707"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="912091707"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 09:16:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1raIrW-00000004YES-2aTZ;
	Wed, 14 Feb 2024 19:15:58 +0200
Date: Wed, 14 Feb 2024 19:15:58 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: linux-kernel@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [RFC] include/linux/make_type.h: Helpers for making u16/u32/u64
 values
Message-ID: <Zcz1ThuWCfPm_33-@smile.fi.intel.com>
References: <20240214155408.1569-1-michal.wajdeczko@intel.com>
 <ZczkhqW5_vU_hDbg@smile.fi.intel.com>
 <3cce5e9d-a79f-4b26-b758-45679b94b6ff@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cce5e9d-a79f-4b26-b758-45679b94b6ff@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 14, 2024 at 06:02:01PM +0100, Michal Wajdeczko wrote:
> On 14.02.2024 17:04, Andy Shevchenko wrote:
> > On Wed, Feb 14, 2024 at 04:54:08PM +0100, Michal Wajdeczko wrote:

..

> >> +++ b/include/linux/make_type.h
> > 
> > If we go with this, please make better name so we can combine this with
> > upper/lower_*_bits() helpers which seems related semantically to this.
> 
> what about "include/linux/uintops.h" like we have bitops.h ?

We have wordpart.h, would it work?

-- 
With Best Regards,
Andy Shevchenko



