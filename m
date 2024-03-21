Return-Path: <linux-kernel+bounces-110464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD141885F4B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65AEE283697
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC68A131743;
	Thu, 21 Mar 2024 17:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="L+ANQnyd"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121AE24A11
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 17:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711040878; cv=none; b=XtoaBBqHWE5ZjoGY/9rqoggqER1pZE0AbruOdQBWhyylpUjmrKE4pxeLuqUrnESwkDLT6QpGPgm5joN4DOMon0c8VuxkGmh4VsZwzVBW8geK2ppuTW2KVROAbggREK9T4W/a1+3kHYVihUSimahhYcyp6ooOH95OTwHfwY861a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711040878; c=relaxed/simple;
	bh=3WBnor6WJgfPl3DPHdrh85aZZqZFmWdCne9/wH+6a4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DCm85XFRvshsIjviw6NJU3ICSJlET+aIXPTH2agqMzORF/d/ItaMUANt9C/2H+4G64n11uHbxpqEXswWMsijFZaZvPaPtvYCxda3ZVT1Qql8r83R53+tQtDgLFCcfzyX2BHOpk1X11X3NXbcVZ+wWixMBTTLWX3McBFmX9yyNEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=L+ANQnyd; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3685ee47bb9so246615ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 10:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1711040874; x=1711645674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N6T+oMJ0+P4cLh/OUo/3VM4bK5uTH8gupmfqcG+HjPc=;
        b=L+ANQnydjYUFeURiLDvFWvaKxfUexrdrq1r+3PovSnbcJZbMllcg/57jx5dZ6u67y3
         dmNNerAHpIo0/dpg9NSXFXHeB7kRhjiuvJmDlXTJ6XTbQV3d3wIcz7FdWJauG0zmdR+v
         WWwz9zNMu2wPKjZqIto2h6RvxpunTmhJ0CqfPIZA8tSOZ+p98P0xUpkaQxuk3dwJjCXI
         Lu7mT6DsGXjZ+4237ED+4UDfRGETSk9AQptUWq2on4Nuw0x6Q93zX4obuuyRws4F1O1R
         vs6rCgg36bNQ0T4keUw8myJ2wWKzpSlH/WC1gle1fRhK1m/2bMyYWiHcojHhNIcOjLMh
         NKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711040874; x=1711645674;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N6T+oMJ0+P4cLh/OUo/3VM4bK5uTH8gupmfqcG+HjPc=;
        b=WqF1/cbAJSuROQBjv40II65HDbaLBcfcNNrz636wRjnYVsw+nzVwLsm52JXLnXZ9r/
         7VoJJ2XpbrpLiJTAmzRvYAYDyekDHsycJiX70s7BYTjGbX0Gp8uWEfmf9G7hm0ywC4nH
         ++b1Tcv/rrpSLJ2+Pouk6YXN5x8preY83jYfooLai6jZbH7gIOGWaYFSaKR2OSWY/X2w
         EcKMsAb/HZqs8EryGv2kDHqGIOnrzF0kfAmthMZ7nzZ2dmHlP2QUJCCJoLuMpKlDoXau
         w5gWGCVwSOWxaxjRvT7SZvd3jnLpZKcz+k/i6csuz8POsOeocClKvnW0axBbEhfoQ1hl
         emnA==
X-Gm-Message-State: AOJu0Yy6o1XhA1m3MwHA9X8i8KSxx3BhlJEHVDGZWqVDNGpM23PjG9ua
	KX0sztSgWncRiJE9oQBRWpgWww/VvhPb0IeWT+T8C9IVtbsJQy4JHgUW/uuGPXE=
X-Google-Smtp-Source: AGHT+IGEj4mLeTaGQBLx3ZFAbk4pCOdJvwFEq0RASeoatbWso8RuxS2mXPKUJ+CEwLv1JmMT6FNvug==
X-Received: by 2002:a5d:9ec7:0:b0:7cc:7327:5b40 with SMTP id a7-20020a5d9ec7000000b007cc73275b40mr32118ioe.2.1711040874168;
        Thu, 21 Mar 2024 10:07:54 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id p20-20020a056602259400b007cc7c30e70esm41525ioo.46.2024.03.21.10.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 10:07:53 -0700 (PDT)
Message-ID: <05c44354-1c48-409e-827f-910d1e3c2db9@kernel.dk>
Date: Thu, 21 Mar 2024 11:07:52 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] blk-mq: don't schedule block kworker on isolated CPUs
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Tim Chen <tim.c.chen@linux.intel.com>,
 Juri Lelli <juri.lelli@redhat.com>, Andrew Theurer <atheurer@redhat.com>,
 Joe Mario <jmario@redhat.com>, Sebastian Jug <sejug@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Bart Van Assche <bvanassche@acm.org>, Tejun Heo <tj@kernel.org>
References: <20240320023446.882006-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240320023446.882006-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/24 8:34 PM, Ming Lei wrote:
> Kernel parameter of `isolcpus=` or 'nohz_full=' are used to isolate CPUs
> for specific task, and it isn't expected to let block IO disturb these CPUs.
> blk-mq kworker shouldn't be scheduled on isolated CPUs. Also if isolated
> CPUs is run for blk-mq kworker, long block IO latency can be caused.
> 
> Kernel workqueue only respects CPU isolation for WQ_UNBOUND, for bound
> WQ, the responsibility is on user because CPU is specified as WQ API
> parameter, such as mod_delayed_work_on(cpu), queue_delayed_work_on(cpu)
> and queue_work_on(cpu).
> 
> So not run blk-mq kworker on isolated CPUs by removing isolated CPUs
> from hctx->cpumask. Meantime use queue map to check if all CPUs in this
> hw queue are offline instead of hctx->cpumask, this way can avoid any
> cost in fast IO code path, and is safe since hctx->cpumask are only
> used in the two cases.

In general, I think the fix is fine. Only thing that's a bit odd is:

> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 555ada922cf0..187fbfacb397 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -28,6 +28,7 @@
>  #include <linux/prefetch.h>
>  #include <linux/blk-crypto.h>
>  #include <linux/part_stat.h>
> +#include <linux/sched/isolation.h>
>  
>  #include <trace/events/block.h>
>  
> @@ -2179,7 +2180,11 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
>  	bool tried = false;
>  	int next_cpu = hctx->next_cpu;
>  
> -	if (hctx->queue->nr_hw_queues == 1)
> +	/*
> +	 * Switch to unbound work if all CPUs in this hw queue fall
> +	 * into isolated CPUs
> +	 */
> +	if (hctx->queue->nr_hw_queues == 1 || next_cpu >= nr_cpu_ids)
>  		return WORK_CPU_UNBOUND;

This relies on find_next_foo() returning >= nr_cpu_ids if the set is
empty, which is a lower level implementation detail that someone reading
this code may not know.

>  	if (--hctx->next_cpu_batch <= 0) {
> @@ -3488,14 +3493,30 @@ static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
>  	return data.has_rq;
>  }
>  
> -static inline bool blk_mq_last_cpu_in_hctx(unsigned int cpu,
> -		struct blk_mq_hw_ctx *hctx)
> +static bool blk_mq_hctx_has_online_cpu(struct blk_mq_hw_ctx *hctx,
> +		unsigned int this_cpu)
>  {
> -	if (cpumask_first_and(hctx->cpumask, cpu_online_mask) != cpu)
> -		return false;
> -	if (cpumask_next_and(cpu, hctx->cpumask, cpu_online_mask) < nr_cpu_ids)
> -		return false;
> -	return true;
> +	enum hctx_type type = hctx->type;
> +	int cpu;
> +
> +	/*
> +	 * hctx->cpumask has rule out isolated CPUs, but userspace still
                            ^^

has to

> +	 * might submit IOs on these isolated CPUs, so use queue map to
							  ^^

use the queue map

> +	 * check if all CPUs mapped to this hctx are offline
> +	 */

-- 
Jens Axboe


