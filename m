Return-Path: <linux-kernel+bounces-48345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DDD845AB5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C43921C23321
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3797A5F492;
	Thu,  1 Feb 2024 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UvTd7czH"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6ECEACC;
	Thu,  1 Feb 2024 14:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706799477; cv=none; b=NU65DFS1v/kC2ictEX6vdTEXmytnjOYu48dTZGAsbUdrmfFGtbmYE9EyQbYhMsahzqq2ksTRGIb8nNTEeGbTiNCg/MS9djcexoyGqSgyUu+gaU5ymmf4+of+cmPlqiFfrXfXDkq6fmenjZyNyemlmGMaIaMX97PgybeeN5l5amo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706799477; c=relaxed/simple;
	bh=uDfO6MKK5anA6LUKyDyinlEfESTgcA6SEeVsHi7/kiA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kglT+zT+MpuAruJOvpq3xDrLxmmmk44xDCai6FkI0E87nNtfo1jK4BKl0mUx62Ku5g+Ccq5PEu2Q0jqPF+Fr/XIR7eg/N5eQ366DJHtyCuInVYj//ehWwypa8M+K4HiVUQe5FQ82q8Ud2kAOjeIyYiT7mPj/8tRQJbuywslJ/8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UvTd7czH; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706799476; x=1738335476;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=uDfO6MKK5anA6LUKyDyinlEfESTgcA6SEeVsHi7/kiA=;
  b=UvTd7czHsrG2ZEdAQUr1XaPYIJQ5nOEf0E9K6t0qbfnZXpcQ8FwmnAtW
   dWcKI6sO6jkcyFu0gZ3Gb5/wh0azRCN5y2680Hn707abekxtLGwB9Td2r
   1wKDSchGUfD/5p9M+kA63TZ+XnjQ+2tLmbet6OIe51f9BgXWGBAJAuN0T
   Z8whpmfp3kkb0WQli9EliRVDJZL0gyhyLAJqDOrmNRyjqLGpksywoIFR9
   0CwMYCEivZg9PV8G127ehrNM61NTrYYoR3YtChUD1XLFSQUxWN3pQvzcV
   AT186rOTlAvLTJBXrf1TwNNqoCcMJ8oY8i7fygt3B/fgHeFvXcVpRtOOn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="394360664"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="394360664"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:57:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="822936089"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="822936089"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:57:53 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rVYVj-00000000rec-0kE8;
	Thu, 01 Feb 2024 16:57:51 +0200
Date: Thu, 1 Feb 2024 16:57:50 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
	Linus Walleij <linus.walleij@linaro.org>, openbmc@lists.ozlabs.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] pinctrl: nuvoton: Constify wpcm450_groups
Message-ID: <Zbuxbp6IWRBGjQSW@smile.fi.intel.com>
References: <20231211154239.4190429-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211154239.4190429-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Dec 11, 2023 at 05:42:39PM +0200, Andy Shevchenko wrote:
> There is no modifications are assumed for wpcm450_groups. Constify it.

Linus, can this be applied?

-- 
With Best Regards,
Andy Shevchenko



