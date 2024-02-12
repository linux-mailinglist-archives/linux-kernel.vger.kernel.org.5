Return-Path: <linux-kernel+bounces-62002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4D48519E7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE2742843FC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127243EA87;
	Mon, 12 Feb 2024 16:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SNkknt76"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99EB3EA78
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 16:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707756234; cv=none; b=ZXkDV5UpBV9oqiQRoMghHcy4Sd5Sd3hRTJNGI7hADahGloEUQzmOZVAUxcg/5gU3Olr2xCE/vZMJWRwnwAvp3o8nwphoOuWpTgNyGVFaHEwA20asKckEr2to9iYXyLuPSKWGxvZuamtnIgnPBQWISNa7oeVb233Ubj0rh/w73/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707756234; c=relaxed/simple;
	bh=CZaeI7dFNIhZbrmUIIVZgiNI/akJCBHtk6c/GQ4ueIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHg8y6LFzw4Opm6nHX0VFNuYXO8CCdrkc9DMf56p7eVZYcKcKO58r22gB7mZsXaDQou6ggVToWwOm+5xxEYumKqJm15ajuLvhHMWK9gu/OlDTdND+qoXw0bgWwcSbqhDLn2t6XARUqWxU5oBUP5SR02NXlVQdkKGt3Rl+NIN2fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SNkknt76; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707756233; x=1739292233;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CZaeI7dFNIhZbrmUIIVZgiNI/akJCBHtk6c/GQ4ueIQ=;
  b=SNkknt76eoSGEX2BfuXy65RIPgqfymOD3JKVm8OUQjegkRM/Yp0WkYww
   HtNnoivqvShYbIKhosEawlwc3hyhn0bHIzAuTO0Lt2uhFYvzgO98Md+KK
   jHXVV/3OT+yfv31Qz1bC7iEBhO5tKbLyQ1UGxatNAZH2ef1GaMlJa16CW
   nzVZf6F34UHpAiHwSbhWB5ha2GZzd0QGhsQvrAKgGr+lmnGR2eONMi4fN
   kqJQEe29ybRLyCxrjUxOBmUL/FqjiHZMtjbQACpkjVJSYGp5m+zWKcd5s
   f7rzTAYVF+k23Hw7KeF/VHX0qa1OG0hSf3CxTuVr/hG0sDEq3+9DbVBqK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="19246505"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="19246505"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 08:43:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="911538670"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="911538670"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 08:43:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rZZPH-00000003x1M-1kl4;
	Mon, 12 Feb 2024 18:43:47 +0200
Date: Mon, 12 Feb 2024 18:43:47 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-kernel@vger.kernel.org,
	Javier Martinez Canillas <javierm@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 1/3] auxdisplay: Take over maintainership, but in Odd
 Fixes mode
Message-ID: <ZcpKwz8J8OoODMYl@smile.fi.intel.com>
References: <20240212132515.2660837-2-andriy.shevchenko@linux.intel.com>
 <20240212132515.2660837-3-andriy.shevchenko@linux.intel.com>
 <9c7df0e5-31a9-4c86-b996-4cba82c4ea2f@suse.de>
 <ZcpKh_EgNM5IaV-P@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcpKh_EgNM5IaV-P@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 12, 2024 at 06:42:48PM +0200, Andy Shevchenko wrote:
> On Mon, Feb 12, 2024 at 05:33:39PM +0100, Thomas Zimmermann wrote:
> > Am 12.02.24 um 14:23 schrieb Andy Shevchenko:
> > > I have no time for this, but since it looks like I'm the main
> > > contributor for the last few years to the subsystem, I'll take
> > > it for now. Geert agreed to help me with as a designated reviwer.
> > > Let's see how it will go...
> > 
> > A few days ago, I talked to Javier about how auxdisplay is a hotchpodge of
> > various drivers that seem to belong into other subsystems. Could we attempt
> > to move all drivers into other places and then remove the auxdisplay
> > subsystem?
> 
> Can you be more precise on how it can be done? We have at least two clusters of
> the displays: line-display and HD44780-based ones. Moreover, the latter might
> use the former in the future (in some cases).

Btw, I have no time for major things here, if you wish, please take over,
I will be happy to get rid of this.

-- 
With Best Regards,
Andy Shevchenko



