Return-Path: <linux-kernel+bounces-48515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A46AB845D59
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73109B2F707
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9252660911;
	Thu,  1 Feb 2024 16:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CWVzhlFy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830197E0E3
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804546; cv=none; b=Uwywm8ORIBiojFiAakBI17YgLt3JFiouHW3RSCp2Bx4AI6azhsinsmfVyMvjBjMxAe9Xpa8fui8ZTsdF9gRGjvv27mdD/c18z7C+qzJAmSNdTl0DhZa2nzZkRsC9nHOWwcWpDWEvsx4Ebl0SoMmZyl0nQ3R0J8+Q1JU6mJirjU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804546; c=relaxed/simple;
	bh=eK22VroIPslBUu5CJjaYl0/B1pPbJ41Qb3IUc5ym+cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmSS4LDy/c53n+2X43+VUhUY669v4v7m8Y781ZcS+xSouc+nyzRjTuJhsTloPidV7DPJNKx2gc4GGbP/DB80vjCOQ/9gQpclHGa3t/s4Yrf2z04gj6LJaNP3bkwZIr9zhczTcVMx1z/op7NL9G8YzWfSt9emH0kyQm+ploU1R+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CWVzhlFy; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706804545; x=1738340545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eK22VroIPslBUu5CJjaYl0/B1pPbJ41Qb3IUc5ym+cc=;
  b=CWVzhlFyOx5x3uhY5r+ptHgzmMc45ZF9ASPak+7gnAXeI/Lm8Fz2uQEa
   uR6TI6uIB+CkYpWLPweKrdJ/eZetrEOe/7WTSgWV/sxUarc/jKwKpLWCL
   uXlvgN7JGbLuugypwK0r+CEN6VZS4vh33oiTHdhacnnyg69lsBB5QYhVV
   Bc6sFFkmh1k/J1ZSmQw5DWY3J3B9ii4NF7geQsgCRQ7dOPfEWcS2g25iO
   166wqhBpH9e3CvPst0cCSfi5gmUm2l9uR0dhaBjYh2QjUzR7NjHi7ulqW
   1lmC1nmdjM9bK/eJTFMsun430MqetyCOF/9501NzKnmt/b0OFut/0xcYO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="17321354"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="17321354"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 08:22:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="788972648"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="788972648"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 08:22:23 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rVZpV-000000011R4-0LNR;
	Thu, 01 Feb 2024 18:22:21 +0200
Date: Thu, 1 Feb 2024 18:22:20 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH v1 1/1] pcmcia: Convert to use less arguments in
 pci_bus_for_each_resource()
Message-ID: <ZbvFPM0jQYFXZhHA@smile.fi.intel.com>
References: <20231030115053.2752588-1-andriy.shevchenko@linux.intel.com>
 <Zbu19xfahgI_dKLt@smile.fi.intel.com>
 <ZbvEhVw-k7UT7Wpm@owl.dominikbrodowski.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbvEhVw-k7UT7Wpm@owl.dominikbrodowski.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 01, 2024 at 05:19:17PM +0100, Dominik Brodowski wrote:
> Am Thu, Feb 01, 2024 at 05:17:11PM +0200 schrieb Andy Shevchenko:
> > On Mon, Oct 30, 2023 at 01:50:53PM +0200, Andy Shevchenko wrote:
> > > The pci_bus_for_each_resource() can hide the iterator loop since
> > > it may be not used otherwise. With this, we may drop that iterator
> > > variable definition.
> > 
> > Can it be now applied?
> 
> Which tree will this go through? No need to involve the PCMCIA tree, and you
> already have my ACK...

I believe PCI one, okay, seems like I have to resend with Bjorn being included.

-- 
With Best Regards,
Andy Shevchenko



