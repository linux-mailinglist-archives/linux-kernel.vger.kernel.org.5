Return-Path: <linux-kernel+bounces-166910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A52BA8BA1D0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB5001C21FCA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989AE180A96;
	Thu,  2 May 2024 21:06:59 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEAB16D4C2;
	Thu,  2 May 2024 21:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714684019; cv=none; b=BFQc7gOGRaWhkmXAMhCdF086IrjT0lk3zmkZiCWEtEUgV4EM5pGeVX0ml0jaoeY0ESHKYk16bkMwfUAb2vp3iAwMKp/1FM2T3IRUfbLM0yskyRGqHH2NW18d3681eUGEzJSUuhWZBG4+LdPY4QH9YEi1+RfRdoAyruAnp+b6IA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714684019; c=relaxed/simple;
	bh=y64jK/AUuv5FzhPuBOwbPsWYnjoJ4kXGIYP8XVguRw8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JiY3EXPexzCmC//kLxLBiTjI5EBPid3SZ0WxfP0pxnsqPD7hbRIooqAyVQ9bu9US2IXQIUe2BzcAhmA1OCy4Eac5i2BbKXPKunya5gM0z1jfROLEYBLtVEGNRIiB2uFTJwPWP7K81wzFYf2iYRRD5PP38WaJkZzuPYGuAaMJc+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D84AC113CC;
	Thu,  2 May 2024 21:06:57 +0000 (UTC)
Date: Thu, 2 May 2024 17:07:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Zheng Yejian <zhengyejian1@huawei.com>
Cc: <mhiramat@kernel.org>, <mark.rutland@arm.com>,
 <mathieu.desnoyers@efficios.com>, <Markus.Elfring@web.de>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] ftrace: Fix possible use-after-free issue in
 ftrace_location()
Message-ID: <20240502170743.15a5ff1c@gandalf.local.home>
In-Reply-To: <20240417032830.1764690-1-zhengyejian1@huawei.com>
References: <20240401125543.1282845-1-zhengyejian1@huawei.com>
	<20240417032830.1764690-1-zhengyejian1@huawei.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Apr 2024 11:28:30 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index da1710499698..e05d3e3dc06a 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -1581,7 +1581,7 @@ static struct dyn_ftrace *lookup_rec(unsigned long start, unsigned long end)
>  }
>  
>  /**
> - * ftrace_location_range - return the first address of a traced location
> + * ftrace_location_range_rcu - return the first address of a traced location

kerneldoc comments are for external functions. You need to move this down
to ftrace_location_range() as here you are commenting a local static function.

But I have to ask, why did you create this static function anyway? There's
only one user of it (the ftrace_location_range()). Why didn't you just
simply add the rcu locking there?

unsigned long ftrace_location_range(unsigned long start, unsigned long end)
{
	struct dyn_ftrace *rec;
	unsigned long ip = 0;

	rcu_read_lock();
	rec = lookup_rec(start, end);
	if (rec)
		ip = rec->ip;
	rcu_read_unlock();

	return ip;
}

-- Steve


>   *	if it touches the given ip range
>   * @start: start of range to search.
>   * @end: end of range to search (inclusive). @end points to the last byte
> @@ -1592,7 +1592,7 @@ static struct dyn_ftrace *lookup_rec(unsigned long start, unsigned long end)
>   * that is either a NOP or call to the function tracer. It checks the ftrace
>   * internal tables to determine if the address belongs or not.
>   */
> -unsigned long ftrace_location_range(unsigned long start, unsigned long end)
> +static unsigned long ftrace_location_range_rcu(unsigned long start, unsigned long end)
>  {
>  	struct dyn_ftrace *rec;
>  
> @@ -1603,6 +1603,16 @@ unsigned long ftrace_location_range(unsigned long start, unsigned long end)
>  	return 0;
>  }
>  
> +unsigned long ftrace_location_range(unsigned long start, unsigned long end)
> +{
> +	unsigned long loc;
> +
> +	rcu_read_lock();
> +	loc = ftrace_location_range_rcu(start, end);
> +	rcu_read_unlock();
> +	return loc;
> +}

