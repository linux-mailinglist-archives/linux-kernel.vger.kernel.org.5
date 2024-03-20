Return-Path: <linux-kernel+bounces-108813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 239C288105B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54A551C21EFF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3B03A8CE;
	Wed, 20 Mar 2024 11:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eISfuVQ9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D01838DDC;
	Wed, 20 Mar 2024 11:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710932450; cv=none; b=k/6QINC7IIp/dTLJP/vk1WCYjjiqo1+mdPOSLGdtD3fX9wUj7KzAEOPi66cvm0zJRDfdIp+a0xPhoj1zum0UySHbXfDbP7EoZLo8AOHCUMNu1O2ptMKL/CR06ylxZEqY/EzYIME7+WGCUiCx3NgOf4Mt4bs8xtXvjqDzdcCpPBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710932450; c=relaxed/simple;
	bh=bYp5vxtMNzlWO5F87RfrA6mH3xVPEzQceIbCutrJK4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8AOoceM9D5/ccbm2SD+7MSkWmRyRHTqFe5oEWxt5hntSvpzll9LeUS3fEd3uaW3ymLMluS96oouWOgRR/ODbcr7+OmDdL00Z+wr21xlo9EE/y/NrLCp8Y6rW4dIcVQaSMC+ntPyT7neZ1IHqa14veWUlcuLX3keLuDyn5Rq0Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eISfuVQ9; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710932449; x=1742468449;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bYp5vxtMNzlWO5F87RfrA6mH3xVPEzQceIbCutrJK4o=;
  b=eISfuVQ9vDUu+6yGiJq8WGbLkfjiCh5ldOCee4WIaLGMcHBkedWhHSXu
   aZB3Wm/oHw/3apdkLOAn2WXk6Ofkj7KH1vnLpXUd6XNX8j0VBcd2nMU1m
   w4QsX4xk+Iz/+J7UzT0x3GDTNLO9fQpEwDkrV83DAdfDqH0qePLEE+yzG
   tI5+ZaVxLFZZ5Z8Q7gLxYJh8VXggYwWcyaXcBWOBC2zkWA48gOThr4q3A
   WtHMWCcLm3ofQC9YqeIuU+8Bf9xiJHX4ufUlKs5uUz3VBCtm1G4mva8RG
   4sxz5zcOLX0PwiosbvzLSJuWLPjrX+POGXem1t1i2oB5O5uV2LZ8hhSJ/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="17294755"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="17294755"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 04:00:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="914662781"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="914662781"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 04:00:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rmtgX-0000000EY2e-4ASJ;
	Wed, 20 Mar 2024 13:00:41 +0200
Date: Wed, 20 Mar 2024 13:00:41 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
	linus.walleij@linaro.org, semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] iio: pressure: BMP280 core driver headers sorting
Message-ID: <ZfrB2U2qUo_A1xye@smile.fi.intel.com>
References: <20240319002925.2121016-1-vassilisamir@gmail.com>
 <20240319002925.2121016-2-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319002925.2121016-2-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 19, 2024 at 01:29:20AM +0100, Vasileios Amoiridis wrote:
> Sort headers in alphabetical order.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



