Return-Path: <linux-kernel+bounces-66771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 287EF856155
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05CC1F2260E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AA712A162;
	Thu, 15 Feb 2024 11:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EMb19AQD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C4A12A142;
	Thu, 15 Feb 2024 11:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707995919; cv=none; b=dIi2DHiVMQN+pKmGqY5Vo0pcoB6DwmuFRG4OEO3L42YmyAT3oDWSE7XNln2Jfvs/4QPXnW3XsWTnfpkmuFsa6GzWoIrgJY8+NRGMh12zDjwAcwYHJR8Vx0xAC4y/bTcfsSUMl/QQW1n72QF3k4igZW3OIsao26kMCGWmNbDTV7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707995919; c=relaxed/simple;
	bh=R+FFZm2kIt1rkSWq6fz+cQ9DMqvgqPj+NJHYrc5V7d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRgA9HWbxGz94YR+ShK94L6C83zt95iaKLh9ihzeHUV10pQwiG5cgiFM92F3RZfFqij3qi3DNfSsaVlhHCqz5Wmfydpeb/kVFp6ZIzrOlmUG9yFgW5S9iR6wa22UHOfnI7jIxrx8pg82/9eaegp1y+/pvLtt0zywCAvGc3rO4r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EMb19AQD; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707995919; x=1739531919;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R+FFZm2kIt1rkSWq6fz+cQ9DMqvgqPj+NJHYrc5V7d4=;
  b=EMb19AQDkn232udTtrwwNnHMrMMI8mq6K142UU+Vl0ksotGGfTonM6Cl
   DrbhB52WPKOW39RzWTS8tt3wKgOhkn+2brzb3PoLaPSzD7i2U0TePo+61
   43sAvugKNofDBX8Ydq9A0RsQWvslz/p5gEU+0uk9Jeuvz8pK7XVy20FQO
   roLi9iPC5tmZ5I5u5RKjv4zzTewALCoIYXRenA/5nexEsUvmubiVl/c61
   bBNBxhMBCAiw9eQIkM+NabcYSQONeBKn7npaymuczr8bG9SHqYjIH+xqF
   5+TZTIHz+yzrlAkPk+Qjs2oxTkaWefxOme4X3ruxbndsb+EpPak/lqH8o
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="5890849"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="5890849"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 03:18:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="912148420"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="912148420"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 03:18:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1raZlA-00000004lwe-1Gi9;
	Thu, 15 Feb 2024 13:18:32 +0200
Date: Thu, 15 Feb 2024 13:18:32 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>
Subject: Re: [PATCH v2 14/15] dt-bindings: auxdisplay: Add Maxim MAX6958/6959
Message-ID: <Zc3zCMbq9ftok3e-@smile.fi.intel.com>
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
 <20240212170423.2860895-15-andriy.shevchenko@linux.intel.com>
 <ZcpSDOk-IQVasHud@smile.fi.intel.com>
 <ZcpSaHW-RQ3dzywP@smile.fi.intel.com>
 <fc325835-6fcb-4fac-b907-93a95d8d6d7d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc325835-6fcb-4fac-b907-93a95d8d6d7d@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 15, 2024 at 09:21:10AM +0100, Krzysztof Kozlowski wrote:
> On 12/02/2024 18:16, Andy Shevchenko wrote:
> > On Mon, Feb 12, 2024 at 07:14:53PM +0200, Andy Shevchenko wrote:

..

> > Add initial device tree documentation for Maxim MAX6958/6959.
> 
> Anyway you need to send the new version to the list, so the bot will
> test it.

Sure, that's the plan after applying first ones, so the only two can be left
in v4. I will wait for Geert's comments as well.

> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thank you!

-- 
With Best Regards,
Andy Shevchenko



