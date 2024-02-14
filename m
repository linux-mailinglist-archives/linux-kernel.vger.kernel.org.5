Return-Path: <linux-kernel+bounces-65735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5A88550F4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8A3128F789
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACFB127B51;
	Wed, 14 Feb 2024 17:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CiM7ByVg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79391272CA;
	Wed, 14 Feb 2024 17:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933440; cv=none; b=bkHcTzSoeT87/pqFuU6abHsdy9u+zd205oiGa47pSztcbKniBeiZeUq8nuwQJOIiS0NyzfgVzdgUX10VufRd/bAwNjqekOdHycvJv0/0u5TUl3KUIMw4FdSPRE+ndIUR8SmZXFuX96pYEnBhggKOYPCERhWNAE6QEVj35TWZ6SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933440; c=relaxed/simple;
	bh=w7YKlQ1AIzWIBl1dATjxOvc0WtReTODZFO/0ZXY1B54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezP49czFfFXmDi9yZ/Kbh+OzsW36Lhpoppn0syxmZksD1zCEut7OJT85yERHGOxiZyn2jM3F3IM4ppzESgGKT2fmJucEwds/3eVF6J5LPG0T9EFi20Ci4bkfjBs6hnMjCCsJeUsr4IxfX0WCKW5/5z8eclqxYTzBvZiBB9lfUMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CiM7ByVg; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707933439; x=1739469439;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w7YKlQ1AIzWIBl1dATjxOvc0WtReTODZFO/0ZXY1B54=;
  b=CiM7ByVgyW9E5UNCZFnAleIc1kN7N4h8jNF85gUPAJqVG6bOh3SpyUCR
   Cv7KOXByH3eSMK+CiZ3Shqb6wyAYCiLmEN5f5nMdQoKb0l1kiPmymNYu2
   zkIXbfYYZhvQrfmy9iqjnV3ffeojBv+tmSj6j5qhcbOa3m6MWrAwua0X3
   V2575pPIJXY3dwkwrZIvFS+7MOHmkovNoTxIsS1gdrNYAwNRQ1WH29e8c
   ghYnJ0ncnbMarRN1Lj07cz2RXvR2x8BkTQR9wheVRAPoFWBPTQpRrXYwY
   iTfpcSZE4fo6sONtIIAw8kcAX2ZNVO8q32eVUR6LPuW4V6UYFBAgyqCUC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="13381607"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="13381607"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 09:57:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="912092919"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="912092919"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 09:57:15 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1raJVR-00000004YoV-1VfP;
	Wed, 14 Feb 2024 19:57:13 +0200
Date: Wed, 14 Feb 2024 19:57:13 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>
Subject: Re: [PATCH v2 00/15] auxdisplay: linedisp: Clean up and add new
 driver
Message-ID: <Zcz--YJmWLm0ikUT@smile.fi.intel.com>
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 12, 2024 at 07:01:33PM +0200, Andy Shevchenko wrote:
> Add a new initial driver for Maxim MAX6958/6959 chips.
> While developing that driver I realised that there is a lot
> of duplication between ht16k33 and a new one. Hence set of
> cleanups and refactorings.
> 
> Note, the new driver has minimum support of the hardware and
> I have plans to cover more features in the future.
> 
> In v2:
> - updated DT bindings to follow specifications and requirements (Krzysztof)
> - unified return code variable (err everywhere)
> - left patches 10 and 13 untouched, we may amend later on (Robin)

Geert, I would like to apply at least the first 13 patches.
Do you have any comments or even possibility to perform a regression test?

-- 
With Best Regards,
Andy Shevchenko



