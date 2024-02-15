Return-Path: <linux-kernel+bounces-67591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC24C856DD0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C07EBB22E7B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C59C13A24E;
	Thu, 15 Feb 2024 19:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="atrljX81"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733D3139563;
	Thu, 15 Feb 2024 19:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708025671; cv=none; b=nL2WYRxlz/78n/ts9Q9+qgTPtVInQVe7SlFAEBa5JAX1eM7aY2YKiv/zDbsSOCKli4MQW69bYlApuXJL32nJkJZ+UIP7LcKbgB4BHaxNX+OgZ1Sm6JZqGKZNxJHDqYfIpJGjKHoQ1axozIGWPvDD3B8RhJPgdPmR3Y5bPGp0D8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708025671; c=relaxed/simple;
	bh=DpX+QLqMpXLedN4ugddvfd9mbmUiqpJiSZRn+YSTau8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AR/hp/sowRCjVvRwSMhYYeIwgtj6nmWOu4xP4dtOeoMmHg0FdMFW5c82iJS8Rw1+I6SmiYrVm1tPHi4B0PMqjxZ8rEOaoHLec9atLr4bpjyEZMnd1XL0iHXzKjmD/qWirxXeT4/8ZrTaqJOdbdUX9hiNnQ6a7ZZYFRvPSIFBnSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=atrljX81; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708025670; x=1739561670;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DpX+QLqMpXLedN4ugddvfd9mbmUiqpJiSZRn+YSTau8=;
  b=atrljX81KYRXN+uI4jedHA23GkMyx8dSafQe6kxNXds/qU7sKEztQ2Yj
   OVpRoiK2QNASDofP7zss51oJqHVKpKASyuvQC9FUVkfvWOJ7M+JpBBIcD
   uL55stagHHJRWhNYzNG0s8e1ji60ceXyjlQj4uRqL4+wK5e/ozGp9yNlD
   cEjCtACviXXipddAzK920pSbm7rCLJIQVQkvkD1mBeRhbkLyfptditFuS
   mEY35zGeviIiEtTRHATrtpCFS3mMHiHdBBFoOJ2rFlHKh4FlQEAzDDgVw
   y8z64+fhItHx7L5UNGkwkv+upir7kJOB1mBxOpQYu1cN1h4cUwYyAl39b
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="5948276"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="5948276"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 11:34:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="912217578"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="912217578"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 11:34:04 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rahUf-00000004sJi-3y0g;
	Thu, 15 Feb 2024 21:34:01 +0200
Date: Thu, 15 Feb 2024 21:34:01 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kees Cook <keescook@chromium.org>
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] cocci: Add rules to find str_plural() replacements
Message-ID: <Zc5nKZezYhg3Khtr@smile.fi.intel.com>
References: <20240215180156.work.548-kees@kernel.org>
 <Zc5nCsE74E33PdD2@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc5nCsE74E33PdD2@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 15, 2024 at 09:33:31PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 15, 2024 at 10:02:00AM -0800, Kees Cook wrote:
> > Add rules for finding places where str_plural() can be used. This
> > currently finds:
> >  54 files changed, 62 insertions(+), 61 deletions(-)
> 
> Can we extend this to cover string_choices and call the script probably
> str_choices.cocci ?

(And add it to MAINTAINERS?)

-- 
With Best Regards,
Andy Shevchenko



