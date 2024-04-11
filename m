Return-Path: <linux-kernel+bounces-140522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 526948A15BD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB9851F237D5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3F014D70B;
	Thu, 11 Apr 2024 13:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y3uZr7pJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2772014D45D;
	Thu, 11 Apr 2024 13:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842649; cv=none; b=L7BkR8yjcCfHuR08bX3CSjWOjkzeN3cxMzh9ZwUYUsdulzUM7hNpIsq80omXja5FmvbVw244DM5AaHDo0rZtL/+vrbkaYhssL9dsgAIol1fkx3l552G57UoyP8VU9ELljTrv2h378NbKER3F5+fg+tF4+Ud4RoyxU7eQp57KpwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842649; c=relaxed/simple;
	bh=ZfH/I4d1hrRMe9hj7w2rGrT0Kd9Zdc2d48cUGU8d2hE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NnXWvZng0/Akq33UV5/NZuH6ZdEfv9L1gRoEsyd7QJaz+PQ+oPuxTzRMjT3a33+sifp0EKN8bpHO+EHpAfSTsxLOS4mjdvZEj/sOrIQeRJwNUuUQtoXh3bKmKy+DrirWHzgeLmQz45mJKwjoEsRGsExT6osymQFLKEjwSeY7YEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y3uZr7pJ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712842648; x=1744378648;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZfH/I4d1hrRMe9hj7w2rGrT0Kd9Zdc2d48cUGU8d2hE=;
  b=Y3uZr7pJGG2BrHZ/STELSfftynmmvfpW1FFWpwbc4i3Qwk37IWW/fSFy
   GbYcHsrf/1mRzE6tndFgsihzXmKugzMzSTofB10vmDvPNNLxv4n8nXVWe
   W0JI1+wqqHtnOYA5e3FTfSJJY95CI6cJyfTMsOt+DW2tDqsU/LqnIcv0D
   iaP1ZhSKHkhRQnbrVn9hFSzot8h9kKZRVzQgRXB8+RyLkX8EwmsOwfxQj
   nexPzEWgJBzogu1B7qvINKqwxqZfYGXe5mQkpljjbbIJMPr/ngJS93DvZ
   lXdEo+/lZs7iUIGuVJjj5/fsyObq2UuI4jv0kYnmwKTD7z03zky7csdxJ
   A==;
X-CSE-ConnectionGUID: tljXGeGBSJys7WZAOTAA4g==
X-CSE-MsgGUID: HB4JgGZxSvSTJ+/CZ/456A==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="25705540"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="25705540"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 06:37:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="915463714"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="915463714"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 06:37:24 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ruucE-00000003MYt-1MVd;
	Thu, 11 Apr 2024 16:37:22 +0300
Date: Thu, 11 Apr 2024 16:37:21 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 0/2] gpiolib: acpi: A couple of error checks amendmends
Message-ID: <ZhfnkQmhBjA1tvrk@smile.fi.intel.com>
References: <20240410202243.1658129-1-andriy.shevchenko@linux.intel.com>
 <20240411132806.GB112498@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411132806.GB112498@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 11, 2024 at 04:28:06PM +0300, Mika Westerberg wrote:
> On Wed, Apr 10, 2024 at 11:21:45PM +0300, Andy Shevchenko wrote:
> > One error check is moved and one is dropped.
> > No functional changes intended.
> > 
> > Andy Shevchenko (2):
> >   gpiolib: acpi: Remove never true check in acpi_get_gpiod_by_index()
> >   gpiolib: acpi: Check for errors first in acpi_find_gpio()
> 
> Both,
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko



