Return-Path: <linux-kernel+bounces-53075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E4484A05F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8F9A1F23317
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D0540BEF;
	Mon,  5 Feb 2024 17:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n72Zc6dX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8986A44C66;
	Mon,  5 Feb 2024 17:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707153264; cv=none; b=t7Unrum/HWiTk06hwSa50cZBJ3wkVqJnj28RZCw4CcEIA3ozU4oNXjr76OLej3Ri8T5DuxkfWuYkYExfO6SIbVVUoNg3W80UXkCJF9AsBMRRCQ1dpBsdQLIe2/yX7oHHXbCpYjTSHT+QdV/y92t6QDO6TMiLGmvGUz3dLaXwr10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707153264; c=relaxed/simple;
	bh=laxqA3wbZtyqLnqUWsEoBO5vLrx6MCUq1aGx2v/ddno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qkg5tdJKHIq38pB9NAXMig/lwcTNyESs+ElSaaOSUrLsfLkD9f+VdLtJqoWbzIXgFClFbDLYnIiUWUSK8K0B62GgNiq5kolaxNI325KMPUx64/Grfmr4xeQoMwcF/HlVOCa5uAXCsHCq7mDl8BvsLrAxzhr66JYazGGcc3yDBq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n72Zc6dX; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707153262; x=1738689262;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=laxqA3wbZtyqLnqUWsEoBO5vLrx6MCUq1aGx2v/ddno=;
  b=n72Zc6dXbKixvcmc/phVzp8ihe5OJeLk4ou6rksLss7tybh7TcAZr8WW
   0iM27JC0lcOuImf9sVtuJZa1YPModQQHG0sgETrJmIHrfN7lTRoHWzxmS
   mIJqHDL6zWNCkfFoQO3OvhzGokYjnA/Tpgx73O8Uyy/lq6HzuuesPnkrR
   4WYTMbuN/za5PMzggTiCM5gytAufAGO4SDKk+s4FcodVcdbdJP2bmixfU
   J+LeYVSgUwolrYPBBoOgN1J9nurbL5RtLRt+4Q0K5o7ALUfS/wOABxu9E
   NUzdbRVUKUbSvwPjGW+eB7elSNvL9We2iVYwueSXSAm2grWFsFkaCSU7y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="11210947"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="11210947"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 09:14:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="909345806"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="909345806"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.246.112.181]) ([10.246.112.181])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 09:14:20 -0800
Message-ID: <4458a933-b371-4bf2-a8b3-33b260512326@intel.com>
Date: Mon, 5 Feb 2024 10:14:20 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2 v2] cleanup: Add cond_guard() to conditional guards
Content-Language: en-US
To: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org
Cc: linux-cxl@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ira Weiny <ira.weiny@intel.com>
References: <20240205142613.23914-1-fabio.maria.de.francesco@linux.intel.com>
 <20240205142613.23914-2-fabio.maria.de.francesco@linux.intel.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240205142613.23914-2-fabio.maria.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/5/24 7:26 AM, Fabio M. De Francesco wrote:
> Add cond_guard() macro to conditional guards.
> 
> cond_guard() is a guard to be used with the conditional variants of locks,
> like down_read_trylock() or mutex_lock_interruptible().
> 
> It takes a statement (or more statements in a block) that is passed to its
> second argument. That statement (or block) is executed if waiting for a
> lock is interrupted or if a _trylock() fails in case of contention.
> 
> Usage example:
> 
> 	cond_guard(rwsem_read_try, { printk(...); return 0; }, &semaphore);
> 
> Consistently with the other guards, locks are unlocked at the exit of the
> scope where cond_guard() is called.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  include/linux/cleanup.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> index c2d09bc4f976..88af56600325 100644
> --- a/include/linux/cleanup.h
> +++ b/include/linux/cleanup.h
> @@ -134,6 +134,16 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
>   *	an anonymous instance of the (guard) class, not recommended for
>   *	conditional locks.
>   *
> + * cond_guard(name, fail, args...):
> + *	a guard to be used with the conditional variants of locks, like
> + *	down_read_trylock() or mutex_lock_interruptible. 'fail' are one or more
> + *	statements that are executed when waiting for a lock is interrupted or
> + *	when a _trylock() fails in case of contention.
> + *
> + *	Example:
> + *
> + *		cond_guard(rwsem_read_try, { printk(...); return 0; }, &semaphore);
> + *
>   * scoped_guard (name, args...) { }:
>   *	similar to CLASS(name, scope)(args), except the variable (with the
>   *	explicit name 'scope') is declard in a for-loop such that its scope is
> @@ -165,6 +175,10 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
>  
>  #define __guard_ptr(_name) class_##_name##_lock_ptr
>  
> +#define cond_guard(_name, _fail, args...) \
> +	CLASS(_name, scope)(args); \
> +	if (!__guard_ptr(_name)(&scope)) _fail
> +
>  #define scoped_guard(_name, args...)					\
>  	for (CLASS(_name, scope)(args),					\
>  	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void *)1)

