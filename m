Return-Path: <linux-kernel+bounces-52823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 259F6849D0F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C907AB250D2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B837F2C19E;
	Mon,  5 Feb 2024 14:29:00 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0671CD0C;
	Mon,  5 Feb 2024 14:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707143340; cv=none; b=taXfU72SVmWPseDqb1wakhm2vKNXvUgdWNeyYPK7DCGN60+lfHOcXDxmMUy9WJpuOGrhHMbU++Jy0TIsazC4aErAxMk/Gao7pxVfsK189hgTrTnaSF1u5jHCcZeJMgyPcCGouOriESIFtY31z8Kh2umZQT3spDolRBMxvqQsQ/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707143340; c=relaxed/simple;
	bh=1TuBlPp+4WAxPwp0NyqSzCaFlu4c7lpHxFzqKwnZtpE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kd7sVRSCkSwbxQ4d4tzGV0+IlGdy2x+whhVrct0Z61jDWj7z4HJmmqS1QNMIP9ytX2OsPJBHI28fkFDEoLbYktLP72NCVO4Rv+rUTDmdO4fCgcdhwKCCMGPk/v2gyukghsX286AS0ikC9+oUDDPR0gGzlTUKy/6VFjWqqIlR/4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TT7vQ1prQz6JB84;
	Mon,  5 Feb 2024 22:25:22 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 76FB0140B73;
	Mon,  5 Feb 2024 22:28:56 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 5 Feb
 2024 14:28:56 +0000
Date: Mon, 5 Feb 2024 14:28:55 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
CC: Peter Zijlstra <peterz@infradead.org>, Dan Williams
	<dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Ira Weiny
	<ira.weiny@intel.com>
Subject: Re: [PATCH 1/2 v2] cleanup: Add cond_guard() to conditional guards
Message-ID: <20240205142855.0000414e@Huawei.com>
In-Reply-To: <20240205142613.23914-2-fabio.maria.de.francesco@linux.intel.com>
References: <20240205142613.23914-1-fabio.maria.de.francesco@linux.intel.com>
	<20240205142613.23914-2-fabio.maria.de.francesco@linux.intel.com>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon,  5 Feb 2024 15:26:12 +0100
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
> Consistently with the other guards, locks are unlocked at the exit of the
> scope where cond_guard() is called.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>

This version looks good to me, but these are still fairly new to me so good to get
inputs from others.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

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


