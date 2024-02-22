Return-Path: <linux-kernel+bounces-77138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE41860195
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E68331F2343C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE4D73F3F;
	Thu, 22 Feb 2024 18:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GB1PlgXH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B2971724;
	Thu, 22 Feb 2024 18:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708626439; cv=none; b=Ceaz6gB8It3uFoE0a1Hyd9RK7BkKgg2ghTTFgJFHQpu6S+clistD+478KKdkb9JVxsQUFPmR3pOrxwBCdgvuDIfcsmWJGrsrC4PzddNBFC1141WwgPLEtoKDVSzCDs4TwLdzUyEmn16BNZVzRrrA3RudECpGpmVjoFDkCwIv/Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708626439; c=relaxed/simple;
	bh=s0nsI6gFwFYbbyTINrCgFKsHCJWkS0retC9bFIx1kXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D7RR8gymu5r2dt6IHM0ml7jjXeQdgIYbUE0+aUbBYzMPSEC6b05bMjFA3sR7eUOJQ9Uj9o/ZDqjSTgcohzQpkCq9wqZhvQM8Wofm5W0wCsPnF8CDNPNHfU5ayQKQEOFCRlBPFAWmh9hpcn0Eq7rOneA0YKzFHIdpwUkw2eOMelY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GB1PlgXH; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708626437; x=1740162437;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s0nsI6gFwFYbbyTINrCgFKsHCJWkS0retC9bFIx1kXI=;
  b=GB1PlgXHAbChaU6RQwCHOY+xSjZMTyUcBS57PrVJsGb6Z1OXSjBFaznq
   Vhjp7x3g9VHsWcFjZDzayDdn83x2et60xmRlBcFRoEpBKDRWEhw8Esv6I
   qeR6nl7je9k8HB/mFrkE6f8xbKJU3LAW/15C8cVNRf4l2JtKcgtFrhsPh
   cumtKOMw2uatGnV8043uRsGo56pg0LjpRHgiK5wGyQsvnf1hRNCH63m4K
   7SObG53GmQ7QyO6FD1bQ573sap/qqr8Q2KEKY3sGoTVM6sxig9qx2/S+f
   LQdxt4+Ff3pUe5YGNhtpiRVkibkuDDhROy8J/o1qdCSnFh+b8MPLKvIWw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="6697277"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="6697277"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:27:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5552089"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.246.114.198]) ([10.246.114.198])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:27:11 -0800
Message-ID: <3725d3da-645b-4aa9-ba05-94f055ed77cb@intel.com>
Date: Thu, 22 Feb 2024 11:27:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3 v5] cleanup: Add cond_guard() to conditional guards
Content-Language: en-US
To: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org
Cc: linux-cxl@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ira Weiny <ira.weiny@intel.com>
References: <20240217105904.1912368-1-fabio.maria.de.francesco@linux.intel.com>
 <20240217105904.1912368-2-fabio.maria.de.francesco@linux.intel.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240217105904.1912368-2-fabio.maria.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/17/24 3:59 AM, Fabio M. De Francesco wrote:
> Add cond_guard() macro to conditional guards.
> 
> cond_guard() is a guard to be used with the conditional variants of locks,
> like down_read_trylock() or mutex_lock_interruptible().
> 
> It takes a statement (or statement-expression) that is passed as its
> second argument. That statement (or statement-expression) is executed if
> waiting for a lock is interrupted or if a _trylock() fails in case of
> contention.
> 
> Usage example:
> 
> 	cond_guard(mutex_intr, return -EINTR, &mutex);
> 
> Consistent with other usage of _guard(), locks are unlocked at the exit of
> the scope where cond_guard() is called. This macro can be called multiple
> times in the same scope.
> 
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  include/linux/cleanup.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> index c2d09bc4f976..602afb85da34 100644
> --- a/include/linux/cleanup.h
> +++ b/include/linux/cleanup.h
> @@ -134,6 +134,19 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
>   *	an anonymous instance of the (guard) class, not recommended for
>   *	conditional locks.
>   *
> + * cond_guard(name, fail, args...):
> + *	a guard to be used with the conditional variants of locks, like
> + *	down_read_trylock() or mutex_lock_interruptible(). 'fail' is a
> + *	statement or statement-expression that is executed if waiting for a
> + *	lock is interrupted or if a _trylock() fails in case of contention.
> + *
> + *	Example:
> + *
> + *		cond_guard(mutex_intr, return -EINTR, &mutex);
> + *
> + * 	This macro can be called multiple times in the same scope, for it
> + * 	declares unique instances of type 'name'.
> + *
>   * scoped_guard (name, args...) { }:
>   *	similar to CLASS(name, scope)(args), except the variable (with the
>   *	explicit name 'scope') is declard in a for-loop such that its scope is
> @@ -165,6 +178,13 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
>  
>  #define __guard_ptr(_name) class_##_name##_lock_ptr
>  
> +#define __cond_guard(__unique, _name, _fail, args...) \
> +	CLASS(_name, __unique)(args); \
> +	if (!__guard_ptr(_name)(&__unique)) _fail; \
> +	else { }
> +#define cond_guard(_name, _fail, args...) \
> +	__cond_guard(__UNIQUE_ID(scope), _name, _fail, args)
> +
>  #define scoped_guard(_name, args...)					\
>  	for (CLASS(_name, scope)(args),					\
>  	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void *)1)

