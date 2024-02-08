Return-Path: <linux-kernel+bounces-58210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 056BD84E2C4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 992B81F220FE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F457868F;
	Thu,  8 Feb 2024 14:04:13 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C4A77F33;
	Thu,  8 Feb 2024 14:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707401052; cv=none; b=c4Q5ak3z4EdP6ReTqCoSwZMPwtAoqLCbixzGuqLL//7G6TGsGJjlEzMnt/3TOSjPK/WQ2I5CdEhqlIgCHxs5XdbsTELyrkjGEpgbZ2Plpq6m7YTSZn+rKEhZnreKORE13xft2MV3EbhsEmoRbJkXY+S0PP5HhVihi87kTm8ARpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707401052; c=relaxed/simple;
	bh=4kvYFrZx1wBuKLgLt/zTMYUAP5dUk4VX1HzeYWC4XaM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZO1fUtjQd5JwnGAs7HUNRrXvFK6ywBEyGNPftE2L3T1lGNTVTqUHvdByMiWvsRJLDNUBvHz9XSwAzWctgWOKJf5EBAuIi8rJ7ONK1vy1URkMCzIFWoBi9SDdnvNAVM2qPAoIpldE4gQ9fudNpgFnpelCg5CtqzVQJueJyzTbqOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TVzC91vLnz6JB44;
	Thu,  8 Feb 2024 22:00:21 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 564BC140595;
	Thu,  8 Feb 2024 22:04:04 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 8 Feb
 2024 14:04:03 +0000
Date: Thu, 8 Feb 2024 14:04:03 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
CC: Peter Zijlstra <peterz@infradead.org>, Dan Williams
	<dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Dave Jiang
	<dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 1/2 v4] cleanup: Add cond_guard() to conditional guards
Message-ID: <20240208140403.0000238f@Huawei.com>
In-Reply-To: <20240208130424.59568-2-fabio.maria.de.francesco@linux.intel.com>
References: <20240208130424.59568-1-fabio.maria.de.francesco@linux.intel.com>
	<20240208130424.59568-2-fabio.maria.de.francesco@linux.intel.com>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu,  8 Feb 2024 14:04:23 +0100
"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com> wrote:

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
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
I like the defensive else {}

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> Cc: Peter Zijlstra <peterz@infradead.org>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>
> ---
>  include/linux/cleanup.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> index c2d09bc4f976..7b54ee996414 100644
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
> +	else { }
> +
>  #define scoped_guard(_name, args...)					\
>  	for (CLASS(_name, scope)(args),					\
>  	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void *)1)


