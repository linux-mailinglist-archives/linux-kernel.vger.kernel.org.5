Return-Path: <linux-kernel+bounces-92775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBF68725CA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 137BA1F265D7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420C917581;
	Tue,  5 Mar 2024 17:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a9gYloUw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18DE16427;
	Tue,  5 Mar 2024 17:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709660274; cv=none; b=fa/cw01M6UMY8xcbE9u62z4/efZX3Sz7ZejnHC1XpO6bmmzGc9gh7frP+VkJiKb0PMC4NJtMi2tUrTKPfyw12B6xED10y47dTofCKR1j3TjYtcWVLzjt+fBIs3C3kCXCNvuMAV/Tc3xYybFTfEJAq7fJTSEFPch3Md6SNuOE8qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709660274; c=relaxed/simple;
	bh=SPFp/5wiVzGfJXSCxTcdGU463JEV+G32mBsZrWelyIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Db6Yi6ppWnOnbrAbfHL3kAJeMB37JBmAs86moaAujrFbCTGt9HY/C7mX3UCfKW8dpdN1puVFnSetGtYaKaKTZp6ji2QLCyOvHJ35uGJ9iDv4TEwOtvf1ItxZGvgfWuv+hqc6tw8ikUe9QG8uckTulf+baYvYiPPJ8GIEP25ZaqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a9gYloUw; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709660273; x=1741196273;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SPFp/5wiVzGfJXSCxTcdGU463JEV+G32mBsZrWelyIo=;
  b=a9gYloUwJHauoByuDz0p7Is4eqUeqvNCmSzT3iiwwE8OggaTQGXGtRd7
   sJKsC5fTiRZoSFkWdFSUzEXtsMi5c+EkzMBUHNPAONvoucCcC/eFfY7pL
   G7SVo9pfm1drHP3McXQQxagJ4f0dzXqai9Y0utV26f6duDkAkIDSvrN0x
   /4tkhWeFaIElxPrK/vePTgeXwMQ5Ml+He4AQyiCTHwe5Upd+5GlnTUhw3
   WAK0Vcli589F8twwwRlWy4uEWUB239T8LK9KVNyA9rOV79TO+IvVnM6DR
   CcswKMdc9Or62gRz4hu0+u+F5CPMrI62ePCbzHO8TVUTNLNGM+n9ywsbv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4092841"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="4092841"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 09:37:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="914146037"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="914146037"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 09:37:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rhYjc-0000000A391-1BLr;
	Tue, 05 Mar 2024 19:37:48 +0200
Date: Tue, 5 Mar 2024 19:37:47 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sean Young <sean@mess.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v1 1/1] media: ir-spi: Remove unused of_gpio.h
Message-ID: <ZedYa962KkB4A3Pp@smile.fi.intel.com>
References: <20240304180331.1200827-1-andriy.shevchenko@linux.intel.com>
 <ZebisPvr_eFPm_0o@gofer.mess.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZebisPvr_eFPm_0o@gofer.mess.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 05, 2024 at 09:15:28AM +0000, Sean Young wrote:
> On Mon, Mar 04, 2024 at 08:03:31PM +0200, Andy Shevchenko wrote:

..

> > -#include <linux/of_gpio.h>
> 
> This does not build, I get errors saying of_property_read_bool() is undefined.
> I think we need linux/of.h instead of linux/of_gpio.h.

Oh, good catch! The header block there is a mess.
I will replace this patch by something better, I'll Cc you.

-- 
With Best Regards,
Andy Shevchenko



