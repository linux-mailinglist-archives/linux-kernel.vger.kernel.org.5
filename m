Return-Path: <linux-kernel+bounces-93980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A138737C1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A44F0B24669
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78BC131756;
	Wed,  6 Mar 2024 13:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IR3vlW0k"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93129130E29;
	Wed,  6 Mar 2024 13:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709731949; cv=none; b=MF3AJrXQXNhk4+zCB8qA5QeGYf1MBbKHzTq7MljiYI867iy9LEc3teYcisWIm36BQ2mYjbV1x/xU0cIm8yn5ZpzLAkH7Rpc5tpwkWKMEOaH6iK/ZaFKY/zVzdMTEvyB3oETj7tCYDrV3GyL+vNFwH63krTg8Xxk5QJyQjwfEfT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709731949; c=relaxed/simple;
	bh=aGELYDGD7Ti4XMKL2XgiV5+gB0Fy1G20BwlunO1v0ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZRN0VXYqXJBNqsyT3RCGOtdgRv/si1R4clrvF/TKj41gB92SzACOsot6XrgazfkyBtsR9KtXn3hMxKeZmyfYIVdZHxVeGKS+Ifbv6onYy97cDS934gQUfK3JMtjzGk2FQb1+mtvNQFuNeyV5WsQ40eNPRt5xQ1v4l3NGt0AIUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IR3vlW0k; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709731947; x=1741267947;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=aGELYDGD7Ti4XMKL2XgiV5+gB0Fy1G20BwlunO1v0ic=;
  b=IR3vlW0kClSGOMG76Bff5iP8lWD5VqDEIEgtO8JgRSYClr1AxG9mL/zu
   9JfD4dDu4uRGEHZPYbQ8mOjwDGeB/TMgKWCpKyp66GXXB0D4ndq+wvR9l
   DOraTIe1VdeYTSS73XQdWHT3owy3KblpfmMegYd8UJzOiM7YbOC9+oCVI
   6eRuSg9d0++Q9BFdmPIMsbcuBUUs7mZXOkF6xh1D/SfxZk1ZyXEYODE/b
   0QGmDd843Oxy2Fz17AF9PXj2IqcZlSCH/Aw8rRbr1GH5n1MboT9vB1sU/
   I5dto2HoyFKeVYRV2bRAUWt5ordSswH2TYgameYcv4HoE3F9OphOQ/GJb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4524313"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="4524313"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 05:32:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="914178509"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="914178509"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 05:32:25 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rhrNe-0000000AHCi-3niC;
	Wed, 06 Mar 2024 15:32:22 +0200
Date: Wed, 6 Mar 2024 15:32:22 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Julian Winkler <julian.winkler1@web.de>,
	platform-driver-x86@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 2/2] platform/x86: intel_scu_pcidrv: Remove unused
 intel-mid.h
Message-ID: <ZehwZghx_KHbezBD@smile.fi.intel.com>
References: <20240305161539.1364717-1-andriy.shevchenko@linux.intel.com>
 <20240305161539.1364717-3-andriy.shevchenko@linux.intel.com>
 <31213f82-196d-8ab0-6c24-a09a2db43388@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31213f82-196d-8ab0-6c24-a09a2db43388@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 06, 2024 at 12:44:03PM +0200, Ilpo Järvinen wrote:
> On Tue, 5 Mar 2024, Andy Shevchenko wrote:
> 
> > intel-mid.h is providing some core parts of the South Complex PM,
> > which are usually are not used by individual drivers. In particular,
> 
> Both applied to review-ilpo. I fixed that double "are" for you while 
> applying.

Thank you!

-- 
With Best Regards,
Andy Shevchenko



