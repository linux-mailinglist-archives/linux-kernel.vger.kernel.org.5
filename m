Return-Path: <linux-kernel+bounces-55362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EA984BBBE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B46931C226C5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D238F61;
	Tue,  6 Feb 2024 17:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P0UbiIuB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29958F68;
	Tue,  6 Feb 2024 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707240213; cv=none; b=Q3foSvEmsRcIL49pAvhi0m/NVMi7UfJ196wdpJp9Kc4tuwJJfddyldUE3cyLFVNGDY7fYG4Wmj7vr0K3sX6XOx/88fgRBErbFKiw8++a8/YyS9QrkM4AeX5fPcjzlkFWSsxlxMLXQz++SbkmY5LytXx0xXtwJR0iUWImvUHsOEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707240213; c=relaxed/simple;
	bh=8JZuQFl5Ktp+sBXs223hELh4OCBn2C06QW6nfIbxPBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lkA7T2qeAO2Cp5qL1hH+/bL/TBJobG/I0/VUMKrMw0SgvwkyFbPAmz/awy1b4O6XnBtTtCgD55wBEqwD8AxQ3voT7+hxt2ZJz8DyYDUYYpjvX9+Qoc94FpDo8IUge0FcjEw9ZSRtligiQVgeauwCSzzE45FdWqmfbwAQffPvm74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P0UbiIuB; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707240212; x=1738776212;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8JZuQFl5Ktp+sBXs223hELh4OCBn2C06QW6nfIbxPBA=;
  b=P0UbiIuB5BoDOP76geca/1kQpBTs0p/ndiSnuIV5TdAJJBlt1lNJtCEO
   3PL9JXwHMYMi3m+I1CduNSFHQdO90H8e8n/Zyv1LBL+Fufz6xFbGgsj0+
   myF8PDRWI6c2P2sOPloOOo3g+/Guyy2o4OTgDYTa9zjQQZKjDY3LEy1lv
   XLUVDtx7IHWKbR2Rc9kUObSajidKwTaCW56w9tlZ1R5VbpH/5Nn4Vtz7M
   fMV7Rm2DYwrjR92mB92RKEAalNwIlm31Uakx1eRbIYzeIMwLcGISumzQJ
   FTn0linDn5anhb/Z3oFCINTDAg5hv+VTNuUrL4kbKps4sDpyw3Fxmnpey
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="950189"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="950189"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 09:23:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="5678183"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.246.113.99]) ([10.246.113.99])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 09:23:30 -0800
Message-ID: <f1935db3-14a5-443d-8994-f24e3cd8b98f@intel.com>
Date: Tue, 6 Feb 2024 10:23:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2 v3] cleanup: Add cond_guard() to conditional guards
Content-Language: en-US
To: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org
Cc: linux-cxl@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Ingo Molnar <mingo@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>
References: <20240206121301.7225-1-fabio.maria.de.francesco@linux.intel.com>
 <20240206121301.7225-2-fabio.maria.de.francesco@linux.intel.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240206121301.7225-2-fabio.maria.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/6/24 5:13 AM, Fabio M. De Francesco wrote:
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
> Consistent with other usage of _guard(), locks are unlocked at the exit of the
> scope where cond_guard() is called.
> 
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  include/linux/cleanup.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> index c2d09bc4f976..d70454e9f8dc 100644
> --- a/include/linux/cleanup.h
> +++ b/include/linux/cleanup.h
> @@ -134,6 +134,16 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
>   *	an anonymous instance of the (guard) class, not recommended for
>   *	conditional locks.
>   *
> + * cond_guard(name, fail, args...):
> + *	a guard to be used with the conditional variants of locks, like
> + *	down_read_trylock() or mutex_lock_interruptible. 'fail' is a
> + *	statement or statement-expression that is executed if waiting for a
> + *	lock is interrupted or if a _trylock() fails in case of contention.
> + *
> + *	Example:
> + *
> + *		cond_guard(mutex_intr, return -EINTR, &mutex);
> + *
>   * scoped_guard (name, args...) { }:
>   *	similar to CLASS(name, scope)(args), except the variable (with the
>   *	explicit name 'scope') is declard in a for-loop such that its scope is
> @@ -165,6 +175,11 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
>  
>  #define __guard_ptr(_name) class_##_name##_lock_ptr
>  
> +#define cond_guard(_name, _fail, args...) \
> +	CLASS(_name, scope)(args); \
> +	if (!__guard_ptr(_name)(&scope)) _fail; \
> +	else
> +
>  #define scoped_guard(_name, args...)					\
>  	for (CLASS(_name, scope)(args),					\
>  	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void *)1)

