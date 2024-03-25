Return-Path: <linux-kernel+bounces-117481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8AF88ABDC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EDDF1C3E678
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55761327E3;
	Mon, 25 Mar 2024 16:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VMcTjYur"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0BC1DA5B;
	Mon, 25 Mar 2024 16:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711384590; cv=none; b=hJJi0HJ2A5JAnhXO9wet4utG6V9gV8xyR6xl0ddKX+dExJk5f00J1rX+8JTnLr2ODQdw69YYYBT+/B8UDrDivwO5qClSNj/M7DSMdRyYHCpTB/gW66pvLUlqoGkr09+biTN4cAhndzckns/ypTl5lM9nFvTUVAf+4Sc2ACNXKNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711384590; c=relaxed/simple;
	bh=M3E1qUULEtpURQnJIQzXnaBfJprZIZR2pAEYVcGH0lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcHfaUnUACJmGwKPlUsBBm7WyjNlbfhRgPtG2VZx7+U4uW1vvX6H02xNALtTJAdV7a11P7HMDK8106DjRsEz4olTvZdz7onDn8eZVvTwB2VQkNAuCIHGqHus7yqIbL4IYIYWztw3A+YCPgd7ZoMnsWdJYZSjG9OEwYHtJ1rcgSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VMcTjYur; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711384589; x=1742920589;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M3E1qUULEtpURQnJIQzXnaBfJprZIZR2pAEYVcGH0lw=;
  b=VMcTjYurOoSEFgJzEs9Gd6t1Qk90oF5sMJIeeOwNx9oueScBR8Ux0m3Y
   Ks7qhgRsLQXKFPaYO2Yf42fSdEom9z/1e5ONf9rrj6dXFN6xB29K2ActK
   DFo+/7V/guPuDmu7WN+12m/OdX+c6V2KzIs4FfVpmouUbHOqE3pqR0hy9
   NFAX7GIbmF+6dgDDmwgT0tjWarNzoq8IPc0FHYIpCAtgWDA1JYkZzsnHh
   v0WmufdhMkfFaXjNOMLtPEoWwp3bAno5BIDgLat1612/h7zBbRC/v3YuC
   5i7e7h8F4c3jISZ0miCgIpMdHpEvDAdK8e7ADym3xBMkkTIOGFdCi1UA8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="17029096"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="17029096"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 09:36:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="914848627"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="914848627"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 09:36:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ronJA-0000000G32x-1urR;
	Mon, 25 Mar 2024 18:36:24 +0200
Date: Mon, 25 Mar 2024 18:36:24 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v1 3/3] hwmon: (pmbus/mp2975) Use i2c_get_match_data()
Message-ID: <ZgGoCF66zUZpWnhm@smile.fi.intel.com>
References: <20240325120952.3019767-1-andriy.shevchenko@linux.intel.com>
 <20240325120952.3019767-4-andriy.shevchenko@linux.intel.com>
 <f874c321-16b9-43f6-95c3-c94b7c9d3cb6@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f874c321-16b9-43f6-95c3-c94b7c9d3cb6@roeck-us.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 25, 2024 at 09:31:08AM -0700, Guenter Roeck wrote:
> On Mon, Mar 25, 2024 at 02:07:44PM +0200, Andy Shevchenko wrote:

..

> >  static const struct of_device_id __maybe_unused mp2975_of_match[] = {
> 
> This is no longer __maybe_unused.

True, thank you!

-- 
With Best Regards,
Andy Shevchenko



