Return-Path: <linux-kernel+bounces-52462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F5D84987F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83848B29221
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0082182DB;
	Mon,  5 Feb 2024 11:09:43 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0B118622;
	Mon,  5 Feb 2024 11:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707131383; cv=none; b=sUyr8kCs2gY1Owj9zkc9VZ46PAQkfIdBBUUg7rH4dla7I3BHnV2zWx0/Vp6rlra35u2FT+jWFEDQ8QloeAaarJLSNzhBLEu8wpNgNw6dryN+yZFrxZbYacGygwBAd1f3BQQXZHPvCzpm0yp7dKBkqBj1W9hWol8lyw0QOEVHxUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707131383; c=relaxed/simple;
	bh=6fDq7Awy6E71ynDuxpB8rBXU5HkmEDHMF/KRwCpZ5XU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BrO2amYz7ADwbTPKonlNFoQ2UpvviDmXtlNy2f3VmRfNhSLSWxaj03rzCBhuYLjHgNTdveQRgAfBaJFigsHAiHzASq4W1//e3cZLx+WkeVDfkr7eqsJYkRJQEeyrEZy0faUrhkmV11FnEOyh+GCn408De+h4S6zRLCZ++eyqI18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TT3Tt6vmFz6K5ks;
	Mon,  5 Feb 2024 19:06:26 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id CEEF6141DB5;
	Mon,  5 Feb 2024 19:09:38 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 5 Feb
 2024 11:09:38 +0000
Date: Mon, 5 Feb 2024 11:09:37 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
CC: Peter Zijlstra <peterz@infradead.org>, Dan Williams
	<dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>, Ingo Molnar
	<mingo@kernel.org>, <linux-cxl@vger.kernel.org>, Ira Weiny
	<ira.weiny@intel.com>
Subject: Re: [PATCH 1/2] cleanup: Add cond_guard() to conditional guards
Message-ID: <20240205110937.000036cc@Huawei.com>
In-Reply-To: <20240204173105.935612-2-fabio.maria.de.francesco@linux.intel.com>
References: <20240204173105.935612-1-fabio.maria.de.francesco@linux.intel.com>
	<20240204173105.935612-2-fabio.maria.de.francesco@linux.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun,  4 Feb 2024 18:31:04 +0100
"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com> wrote:

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
> Consistenly with the other guards, locks are unlocked at the exit of the
Spell check.

> scope where cond_guard() is called.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>
> ---
>  include/linux/cleanup.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> index c2d09bc4f976..3826e8ed4e09 100644
> --- a/include/linux/cleanup.h
> +++ b/include/linux/cleanup.h
> @@ -134,6 +134,16 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
>   *	an anonymous instance of the (guard) class, not recommended for
>   *	conditional locks.
>   *
> + * cond_guard(name, fail, args...):
> + *	a guard to be used with the conditional variants of locks, like
> + *	down_read_trylock() or mutex_lock_interruptible. 'fail' are one or more
> + *	statements that are executed if waiting for a lock is interrupted or
> + *	if a _trylock() fails in case of contention.
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
> +#define cond_guard(_name, _ret, args...) \
> +	CLASS(_name, scope)(args); \
> +	if (!__guard_ptr(_name)(&scope)) _ret

Use the naming that scoped_cond_guard() uses: _fail rather than _ret

> +
>  #define scoped_guard(_name, args...)					\
>  	for (CLASS(_name, scope)(args),					\
>  	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void *)1)


