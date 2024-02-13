Return-Path: <linux-kernel+bounces-63940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A480853699
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33698287732
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416CA5FB94;
	Tue, 13 Feb 2024 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b9q4BvpJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6C12C695;
	Tue, 13 Feb 2024 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707843098; cv=none; b=b4C//dTxDHo42zidM1zTummb8NA+hqp4CLmpRRHoDNISHY6K/W9P9V7GekawgkJj8r/QB1KoWlkr+91hknIB0VOoW928E5thmjXDwBwYFT8j+xgISMy+D3i3F8ixKi7jnHwTrDGoerbZECqAa5D0YDt7YPKZr6pWk5MmGv1bqys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707843098; c=relaxed/simple;
	bh=tBEYrGBRg+vR+MDQKtSUQPYjgrpcutOltmgfsPRJ5vY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C7YG4q5MEWwSmKvi2l0Bv0+ZsoQXwpdj4Auvaly/znuGFD59e4kF58h0W//x2YZKCEPvPneyP41D8P4biawcJtC6+ec6icvR5F5Tey/+x06HB/8t7Vrg9v2opLGskTJ0qvvZ3YAnC3UTIBSZcZ5xgv2KU5q9Hz+y3bpJgwXvTdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b9q4BvpJ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707843097; x=1739379097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tBEYrGBRg+vR+MDQKtSUQPYjgrpcutOltmgfsPRJ5vY=;
  b=b9q4BvpJ9perEqsqlM4f01ABbl4TZF8Y/kcKsGXnMxHfztq+WjzxHFvN
   ZtmViSVrvI6C9ZZULmjpf6G2YyEUKT1daaxu3vURWeOzVhjcDdZACk5tE
   eO5eLwJDJk5lI2/eynikYAOgF8q0Z/+EznkfITgKTIXXRr2lTHww4vNR8
   YVJ1D0ry9c234w1unHTUxT5jCprsc9t0MZn3zod+KUVF19SkgflSV4Yr5
   8e55eXtvebse3Q48UTo6+ZlhcQP7utAkmfNsIHIpm3xOqiSmPOCCX6z6F
   mDB++6do21HakIzKzqdx4KXlIm78Ur2StWeGg/wvfF27t9kqhOkUat25l
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="2216553"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="2216553"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 08:51:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="7579600"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.213.3.93])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 08:51:29 -0800
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org
Cc: linux-cxl@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 1/2 v4] cleanup: Add cond_guard() to conditional guards
Date: Tue, 13 Feb 2024 17:51:26 +0100
Message-ID: <3917370.kQq0lBPeGt@fdefranc-mobl3>
Organization: intel
In-Reply-To: <20240208130424.59568-2-fabio.maria.de.francesco@linux.intel.com>
References:
 <20240208130424.59568-1-fabio.maria.de.francesco@linux.intel.com>
 <20240208130424.59568-2-fabio.maria.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, 8 February 2024 14:04:23 CET Fabio M. De Francesco wrote:
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
> the scope where cond_guard() is called.
> 
[snip]
> 
> +#define cond_guard(_name, _fail, args...) \
> +	CLASS(_name, scope)(args); \
> +	if (!__guard_ptr(_name)(&scope)) _fail; \
> +	else { }
> +

I have converted and tested several functions in drivers/cxl and found that 
there are cases where this macro needs to be called twice in the same scope.

The current implementation fails to compile because any subsequent call to 
cond_guard() redefines "scope".

I have a solution for this, which is to instantiate a differently named 
variable each time cond_guard() is used:

#define __UNIQUE_LINE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __LINE__)
#define cond_guard(_name, _fail, args...) \
        CLASS(_name, __UNIQUE_LINE_ID(scope))(args); \
        if (!__guard_ptr(_name)(&__UNIQUE_LINE_ID(scope))) _fail; \
        else { }

But, before sending v5, I think it's best to wait for comments from those with 
more experience than me.

Fabio




