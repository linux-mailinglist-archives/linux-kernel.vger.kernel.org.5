Return-Path: <linux-kernel+bounces-58443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D43BB84E690
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B4911C23903
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E2281AAA;
	Thu,  8 Feb 2024 17:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vg5TJcgC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F9E7C0AA;
	Thu,  8 Feb 2024 17:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707412866; cv=none; b=u5C9VOrVcVQNqHo0W5JCk529IHlbs7dKkqGgQleJM50AYJ53G9Dj6k9ZTUkZfyAnVR7iaF33kBbqJTM7osy6IKbXJ+Q3XRjQNIbR5eURKYGS441AuQDBTilxxbas26FT8ndabNmo5bxLmy3iRuBzVd2g/3v+FI/rJk1wanOCJ+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707412866; c=relaxed/simple;
	bh=1WIsraADeMoj5x/ZRHer9ovJUiWD3L5WQqbbh8SnjJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUHsa84ZzsBg8ZLW5H82l/0DjAPFnHkKtD7/wAX2x5ShT6U9jQ6vX2CxCv96ojXVQ0Jr9oeL73V97qqWu5nagRyaqU1UrpmaxsJY6Te647Bdkoj9SLJpU0dVTovsvQC5L/skkMWtaUUDYaLUZED8plvHl6LozgDu+7v4RGFFwsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vg5TJcgC; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707412865; x=1738948865;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1WIsraADeMoj5x/ZRHer9ovJUiWD3L5WQqbbh8SnjJI=;
  b=Vg5TJcgCYCZGfBnyroHeTfTMC23e0RMFM1flhJq59If9H+nYfzNwChaO
   Ln0RmPyGXUSx9I0Ch6WTtWhxk2uvPk0IumtNGj8R18SThz182OxymROTD
   6jo0p+2BYBNJteF9XRLa+ZLZ8jqtL52tyFgj76pLv0jfjSXQHU6e7HThP
   btk79zLmxZ3f9wjJIqn5VTJhnExB6csk1UNq+UbnUglMg5GWeOR/5gk6q
   SOQp+nHDLzQmTbKBVUDl8axX1dHsHces5MNZcDai3Mb1CTr0cgreMDpDb
   RT9t95isfrxJtlZtJLei9gH43I+fwDAAaqaT3VBPz7AOOnvdyHTeReZhQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="11843161"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="11843161"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 09:21:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="910433188"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="910433188"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 09:21:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rY855-00000002w3t-39BW;
	Thu, 08 Feb 2024 19:20:59 +0200
Date: Thu, 8 Feb 2024 19:20:59 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: u.kleine-koenig@pengutronix.de, jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com, lakshmi.sowjanya.d@intel.com,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] pwm: dwc: Add 16 channel support for Intel
 Elkhart Lake
Message-ID: <ZcUNe09gDtkztmbk@smile.fi.intel.com>
References: <20240208070529.28562-1-raag.jadav@intel.com>
 <20240208070529.28562-3-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208070529.28562-3-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 08, 2024 at 12:35:26PM +0530, Raag Jadav wrote:
> Intel Elkhart Lake PSE includes two instances of PWM as a single PCI
> function with 8 channels each. Add support for the remaining channels.

Side Q: Have you used --histogram diff algo when prepared the series?
If no, it's better to start using it.

-- 
With Best Regards,
Andy Shevchenko



