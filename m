Return-Path: <linux-kernel+bounces-90543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C738700EF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33AB31C21382
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B076B3B797;
	Mon,  4 Mar 2024 12:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PrLYPWAg"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244803C470
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 12:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709554010; cv=none; b=YRR+ym2L3gegLlm1Ss1OpAlihfPF1483orUxkcgQMenNsFhOpQa+gPuFDv5YvQ8nr2PwLtAg3aV8POnCRqVH4dGIl8LRWDvEwjCjVLNkm8TIRcTjlD/TgEa3ixsbUhB0Q1/kLqPUaSgix3gxqh3s91C2mSdouHpXQ4uLE0gxbl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709554010; c=relaxed/simple;
	bh=uBm/n0NHZvt5+ColQES5wagCqJXG7xgmoLcacmNoqeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YgO6tci5fQQUju+0c6A5fWGEOAKHUDg+fjFFaBB5SyJbvfqa+46OMgSSAznG2fs06Z8S08AoFXnXn35UfLW5YCyqnhLnayr/boF+J3EVuWVUE0DWIPtKYEKRn5XlQADwK/Q36h/HHIg5rvGhvhvlqBDsJKpH0bfyjdNd0ikTpXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PrLYPWAg; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-29a5f100c1aso2382603a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 04:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709554007; x=1710158807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UOwdNmmS+lo5WC+XNlRH5Md5+/3CtAUckFzaCM2z8kQ=;
        b=PrLYPWAgTsuL3Te98+dq/a+0rKEBX/v7hgV3+Du6qyFpxcP5VujCiCazePpkjU+FAB
         fwpsh4fdtt6ziOhtGcdIM4AM+MgXi54EZuIWAO+jWWJe3L6P0Kgq7kbj1jk6O+bn6Qi4
         +0E7JaOX68J7f9sy2a30TJZGPAkx9btlD3sdGyPoHpVDvjrs3DufZ+oSsatXS6S1Smwr
         ZlFEB8o7NNDdZU/SKa9GHeynXSWWne/SsHeRnnJpC3gPVVvcBvz0NDvvTHpcpRXspMiE
         uzjkkxJ5znfQXrM5furZq5yYJJxbLKIF7wCQYIRFXNydh8bz9uilRB3XxZY95LUJRVdP
         iXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709554007; x=1710158807;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UOwdNmmS+lo5WC+XNlRH5Md5+/3CtAUckFzaCM2z8kQ=;
        b=vpy8wNp5Rql+BOGIFqDbIOLvz3wsjVG6t65JYOVNK1QU4yTRqM3t0/mwAuv01DFDpG
         SSTTRIuA9wdoRbrvv/8vXVx6lqqYrGAmEcC7MSbFdep+5N/ENln66A5PGoxlS5Gi/ULG
         0j5p8WGKjQnqID12nfTa7+4Biwgl52tO7SyFJlGkGu47MAk/xJWmY0S1bl0XHIFTJ28y
         k/18OjLEbAQ2RvDH7mg1ZdbJaoEIuc1kr+xbfT41IU7q0v5/TVn+77s4mbpow3WZHGVP
         jZgdPwTHSmU1jGlDgA5D5TSk8poSIBXbRpF/4xa4gOygL1kkMDjWf2U8vU1gx+/igLRj
         OMrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3SOq9NZfOGHVNHm+5hgvGui0kntsjqqBeh1/4U1Mipe3ovxyDWfrVPPGJXjjG8eHUlkAFPBWMDUM1j52vrNEXPBrPO4VqA3W8ynUC
X-Gm-Message-State: AOJu0Yz3e4vzp2X2zHC88fwvvkCfbqxbf759dR6CAC2Ex6s9Wg74YfxV
	7b67U+kAjMBuK7K+qWlebJS4lLg8vI4R9MrS3jT9NNQBJztiDcsakXwSGZ4Crmk=
X-Google-Smtp-Source: AGHT+IHb6etMqsxi7+KJM4iVFZB+rGm238H62YgAqFkBOlJSbk8XKiCprxmCXmfLSmFn8ZHMHznEDQ==
X-Received: by 2002:a17:90a:b88:b0:29a:76f5:6557 with SMTP id 8-20020a17090a0b8800b0029a76f56557mr5392749pjr.19.1709554006436;
        Mon, 04 Mar 2024 04:06:46 -0800 (PST)
Received: from [10.84.154.116] ([203.208.167.154])
        by smtp.gmail.com with ESMTPSA id db12-20020a17090ad64c00b00298ca3a93f1sm10066602pjb.4.2024.03.04.04.06.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 04:06:45 -0800 (PST)
Message-ID: <ad801d18-6243-47c5-8e37-ce712ca5d0c5@bytedance.com>
Date: Mon, 4 Mar 2024 20:06:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched/eevdf: Always update V if se->on_rq when
 reweighting
Content-Language: en-US
To: Tianchen Ding <dtcccc@linux.alibaba.com>, linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>
References: <20240304030042.2690-1-dtcccc@linux.alibaba.com>
 <20240304030042.2690-2-dtcccc@linux.alibaba.com>
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20240304030042.2690-2-dtcccc@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/24 11:00 AM, Tianchen Ding Wrote:
> reweight_eevdf() needs the latest V to do accurate calculation for new
> ve and vd. So update V unconditionally when se is runnable.

As this should come along with commit eab03c23c2a1, I think it would
be better add a Fixes tag?

> 
> Suggested-by: Abel Wu <wuyun.abel@bytedance.com>
> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
> ---
>   kernel/sched/fair.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 03be0d1330a6..5551ce2af73e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3790,9 +3790,8 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>   
>   	if (se->on_rq) {
>   		/* commit outstanding execution time */
> -		if (curr)
> -			update_curr(cfs_rq);
> -		else
> +		update_curr(cfs_rq);
> +		if (!curr)
>   			__dequeue_entity(cfs_rq, se);
>   		update_load_sub(&cfs_rq->load, se->load.weight);
>   	}

