Return-Path: <linux-kernel+bounces-81732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D7486797A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90DE129A6CD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6645712C7FC;
	Mon, 26 Feb 2024 14:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lVyaofg/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708C44C8D
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708958781; cv=none; b=AzyLwykSy6wLtzmmfK0UNeODr3hA9lnGP/flI8Rbkt+4F3BrJVK5Amdl7ZRdp5v45y0yRgpVnixHl78ChINZrc9D8N8H3X+a9W8J57K1oFN+iocquWk+D3Y9gHpzbNhIqZHof5Kmxf0BMIs5KiNhkXpKSkcv7WwT4z2hqzbnA3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708958781; c=relaxed/simple;
	bh=sT7fP8INpZXRh6C0JLFk9TIeNATn3MiGgAhwNGFy5ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2AafMqnHZV8ndGpiBD0L+6jy0W8cht0ZqTKZCwMGk65gFmeIOUOhwyP5JoboEJZ9zf3/8pAWPZbQfyLSKRrncc4HhBpjQspSNu3H5QZPugcXNeSHDn+xG1+oAzbsT9NDgLIGD4S8wyykGpQOf8iFRHMxM2yDXqmOb4+KtdIGWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lVyaofg/; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708958780; x=1740494780;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sT7fP8INpZXRh6C0JLFk9TIeNATn3MiGgAhwNGFy5ps=;
  b=lVyaofg/APyLeKEenopbdaRn8dSboIr8Z7gSEJDFTEV2CvaU1pLLPt0L
   ANGUj6HmIW3AfLOhv79Z/0VAAZ/9lft/XW46+rH4ezRZ8KBYJiHy0oY4O
   NqFCbSCGMVt0jAJSwFrQ5AcQNW+0qnc+2/k+7D+aQV2hFHjDvVbvS8niC
   YEDWHpYPj1TJqBz/qpW6Z0a4UYnIieppSz6JqGfIK9ZA/D9cYu5WXLh4T
   1+U7N1/WgfBtfhTliUOVVwZ/Sp2DnbN83KJCBeWU0KCh6bo4VpbGRQ8Rk
   ePQpzO9LsgAgLIrvRTUep+dzCZpX3KMUQrRre3VAbwih8EfPeS+6PRZuh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="14681645"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="14681645"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:46:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="913874120"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="913874120"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:46:17 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1recFD-00000007htS-01CP;
	Mon, 26 Feb 2024 16:46:15 +0200
Date: Mon, 26 Feb 2024 16:46:14 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shahar Avidar <ikobh7@gmail.com>
Cc: gregkh@linuxfoundation.org, luca.ceresoli@bootlin.com,
	benjamin.tissoires@redhat.com, elder@linaro.org, robh@kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] staging: pi433: Remove a duplicated FIFO_SIZE define
Message-ID: <ZdykNjCUCvRijsGh@smile.fi.intel.com>
References: <20240225173341.1278918-1-ikobh7@gmail.com>
 <20240225173341.1278918-4-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240225173341.1278918-4-ikobh7@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Feb 25, 2024 at 07:33:40PM +0200, Shahar Avidar wrote:
> FIFO_SIZE is being used in both rf69.c & pi433_if.c source files
> It is also already defined in rf69.h header file

You can done this before patch 1, so the code will be cleaner already.

-- 
With Best Regards,
Andy Shevchenko



