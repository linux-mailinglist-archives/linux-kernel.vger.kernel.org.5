Return-Path: <linux-kernel+bounces-67319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5458569B8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0833C2851AB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5E4135A70;
	Thu, 15 Feb 2024 16:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bNUfv9rb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0F313398C
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708015265; cv=none; b=sRj46Q8FqdE0OAovHTRrh5zpQYZf451SGVqKQ/74mumscU9WK4hvd8E3hwjmsdOxUqhYooPJljc9oXsxoQ1ZSMhhVsoGw4rr7oijL8DRMUr2cF+N0UqxN7ez7AFiZb4I+1g0QnH80doLsooVmF5eYjiwdfAbm0VJzpdZzJjReL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708015265; c=relaxed/simple;
	bh=WcIDJ61KgHsUR+N2KvToOtpARl4GpkkSuqyqckdGTsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=so8zCINlofO0d++3/TAaVJ3WYDsMHRLvIXlrWqaZ0Tlmq61ylz92wDnaH8aObRb/Ob8f3NSsyoyTriwDep6mTo0HpXVV8hUPSu3MaQmJkZuaa5mUJTi1VCR25XfxRcvqzetujO2NCVgnTaD+wccZJ/SAyX9rKHpfbGEEEWW6Ztk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bNUfv9rb; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708015265; x=1739551265;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WcIDJ61KgHsUR+N2KvToOtpARl4GpkkSuqyqckdGTsQ=;
  b=bNUfv9rbfNC1CqRuKV8+UAhhGVMykkVZK1ZWsqSttaGw9Lj3DQvI+Ii0
   7K1In6U/rR64hUs0gkVeeRCITEWo8BzDgAGF+9Nm7IrSHHCJpWp3/1qP7
   gbAXO6uLwUG+K623Iz0In/Cj4cyZqFe5BTQVBHZC7f4h8/w3XDgklzzIY
   YGrcFOZpxj0lWFs3mnDg8gfEta2DBVtRAyrsaHvueeso05hEzeSGjbVad
   ktdXbuZiUSlmvROCk8dGVWgI2/sB1snSJb82HP5atO17pYHdgVHsidvfr
   cT8a4UmwBp8AiXfCX90XYoWDzUPOqFkkMzk813l0WDDT5H4wzsLGeOg0U
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2231452"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="2231452"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 08:41:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="912191912"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="912191912"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 08:41:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1raenC-00000004qLK-1Hl4;
	Thu, 15 Feb 2024 18:40:58 +0200
Date: Thu, 15 Feb 2024 18:40:58 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yueh-Shun Li <shamrocklee@posteo.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] minmax: substitute local variables using __UNIQUE_ID()
Message-ID: <Zc4-mgji8VtQDqGe@smile.fi.intel.com>
References: <20240215160726.2254451-1-shamrocklee@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215160726.2254451-1-shamrocklee@posteo.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 15, 2024 at 04:07:21PM +0000, Yueh-Shun Li wrote:
> Substitute identifier names of local variables used in macro
> definitions inside minmax.h with those generated by __UNIQUE_ID(prefix)
> to eliminate passible naming collisions.
> 
> Identifier names like __x, __y and __tmp are everywhere inside the
> kernel source. This patch ensures that macros provided by minmax.h
> will work even when identifiers of these names appear in the expanded
> input arguments.

..

> +#define min_not_zero(x, y) \
> +	__min_not_zero_impl(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y))
> +#define __min_not_zero_impl(x, y, __x, __y)                          \

Seems like the back slashes are indented at random.

Please, use TABs and make sure in a macro / group of (semantically related)
macros they are consistently occupy _the same_ column.

-- 
With Best Regards,
Andy Shevchenko



