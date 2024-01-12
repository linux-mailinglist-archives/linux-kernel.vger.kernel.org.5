Return-Path: <linux-kernel+bounces-24227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F54882B96E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 03:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F4081286C4E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 02:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEEB1390;
	Fri, 12 Jan 2024 02:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="wveAHh6j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5B71117
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 02:19:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA84C433F1;
	Fri, 12 Jan 2024 02:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1705025972;
	bh=jGLKt7eYqBhg4JlNz4xdgTnf3tS7DbNcjW1RCNfMbFQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=wveAHh6jSvZ2H7ZAUXG/TX2KtT+RWzpCFhCAOOotg5D6EnopwMgxXjONsvuD9hnfC
	 HPec7SW2A0nojHl8Fd+vCTg4On8IzUJ/QXzYaUH8JA+CZsiNIJCeGRPIa2OM+QrHGF
	 aKmogL1p7E4J8f2mbW9kxlvI9N6j8LsGoWvvlljw=
Date: Thu, 11 Jan 2024 18:19:31 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, Abaci Robot
 <abaci@linux.alibaba.com>
Subject: Re: [PATCH] lib/group_cpus: Fix unsigned expression compared with
 zero
Message-Id: <20240111181931.e3305d8b55858147e788a190@linux-foundation.org>
In-Reply-To: <20240112020250.48087-1-jiapeng.chong@linux.alibaba.com>
References: <20240112020250.48087-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jan 2024 10:02:50 +0800 Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:

> The nr_present and nr_others is defined as unsigned int type,
> if(nr_present < 0) and if(nr_others < 0 )is invalid. At the same time, the
> return value of function __group_cpus_evenly also of type int. so modified
> the types of nr_present and nr_others to int.
> 
> lib/group_cpus.c:380 group_cpus_evenly() warn: unsigned 'nr_present' is never less than zero.
> lib/group_cpus.c:396 group_cpus_evenly() warn: unsigned 'nr_others' is never less than zero.
> 
> ...
>
> --- a/lib/group_cpus.c
> +++ b/lib/group_cpus.c
> @@ -354,7 +354,8 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
>  	cpumask_var_t *node_to_cpumask __free(free_node_to_cpumask) = alloc_node_to_cpumask();
>  	struct cpumask *masks __free(kfree) = kcalloc(numgrps, sizeof(*masks), GFP_KERNEL);
>  	cpumask_var_t npresmsk __free(free_cpumask_var);
> -	unsigned int curgrp, nr_present, nr_others;
> +	unsigned int curgrp;
> +	int nr_present, nr_others;
>  
>  	if (!masks || !node_to_cpumask || !alloc_cpumask_var(&npresmsk, GFP_KERNEL))
>  		return NULL;

Thanks.

Current mm.git (pushed 3 hours ago) has

	int curgrp, nr_present, nr_others;


