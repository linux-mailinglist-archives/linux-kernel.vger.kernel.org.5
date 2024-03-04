Return-Path: <linux-kernel+bounces-90542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 812268700ED
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 211131F2283B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C7A3B797;
	Mon,  4 Mar 2024 12:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EdBGxJgh"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF543B296
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 12:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709553989; cv=none; b=JWAPbATRoDsFZ9RSh6PiCGEM2VIBVN6i4VtUYbgcC3LqNlhnyTYsVz9pyw9yzZq1hJE/fLDGYw1ZCVWuNw1qGIq+La7UGB15OPzBi8RE6PwGNuDO8V890mlzcBAg40GHuULoER71NMEP5TV635WFWYwvCaNbbS46aUtvkMQV9XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709553989; c=relaxed/simple;
	bh=rouCzjV6bOoIGvm9tyZKK4i0hTCtgK0FYJWQQX1FqOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ii0XOrfQRcO40kbjMeVrj8oo/DOJ3C8NCQQUW2Ip08wBp14pVVzHcPcjOtbLXJgpWLItm/MJBqse0YtbctJ/5R0GS3LzAna4lnKtLyLYQgC8qZ9oWcmpfXrV8PctBO2Ae+N6yhl9qgJkPeuVhLg+19nYeA8O+dkUnUQvISQhb7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EdBGxJgh; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d8ddbac4fbso4250000a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 04:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709553987; x=1710158787; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CgxzTcU3BdCEJE3ZqyMFypVrQhGptbwjJKMwC07WyY8=;
        b=EdBGxJghe7xbPBPBkreclWT5pnZtuGfRVoUf5gSXoeSirbUYT0Byo55DMXJh51KZPG
         lewD9FZVu/lyF8DQWhOv6iPz/2KmiQ1Xg9b/SSaogGbvJ7Xaa4ZZ5c/miAyGP8JjDb1m
         fanzQhk+t+oTCJiy+28tuxrsxDl1eDsOzdDNki6p6keP81iUYOk4X3WVxBg+RjN7RQ+L
         YId96N7Mf8RhZrmOsEWGnWJwkTCjx/rOfh5pt9jHwmsxhbnmSFNfSNiLn2K9Z859aJu3
         WkmkXqZ0eOVq1528h/kLHs93SoGZPa5f3HeNvPTOAKK40cXz04wYz7abrwP6mK/j9oYl
         dHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709553987; x=1710158787;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CgxzTcU3BdCEJE3ZqyMFypVrQhGptbwjJKMwC07WyY8=;
        b=vA49H+emvzMehWwpT5JTGUUBH1D3Ap5sjHczwJpzVfP9NYMvSv+hyCdvsISWg8iVvl
         6H5sS1QDncBAttFJe5M0aAE15/886rditfdTzMca88cO4yoy1Mp2ABXVOqT77DE0+K95
         dTvwcUxK2sg719dtYV3MVAcURJ2tcgoDtEPHiRBiH1jhnUTO8Iex2cC6tOarC7iw71z1
         tfajn1jke4S5VNuxya4+sRTCOSCljOOI7KJ83Lj5HY8XYQPhxxmrE+7cuYuTJB0Yq+c2
         WjNaoFLICq3axsQ4zZsylagDvX7k6AsI/REE6aigcSLqRBCwDQ//2BZ/iVi+0YTeLSdQ
         sLaw==
X-Forwarded-Encrypted: i=1; AJvYcCXx9tLDTklX9J2/pzC6LE0rAhxpUgcnNzpNTFaQ5bJbSKjgLJNis5kvpURN5EPbJ3J0dDFUF53iCBuuHw/VPhxhBc3N42CqOD6AlBio
X-Gm-Message-State: AOJu0YwEeCN5VqMjpcXkPPR097T1a24KHxPRQ/imMHUTmUMFYRvWw98J
	4ey06Tocwm14VXzPu2Zb1kJaAh3HJ9hLNaRXScUg7fSK+P1KLqWWlhVSjjMHfO8=
X-Google-Smtp-Source: AGHT+IFI4HtMfoMDwI3q58aqENgQigQfbQsh5ubZVMHYOfqUID8tcz5nyA0kcR3/3U4x3FA180p72w==
X-Received: by 2002:a17:90a:8008:b0:29a:bf47:e133 with SMTP id b8-20020a17090a800800b0029abf47e133mr7112943pjn.23.1709553986901;
        Mon, 04 Mar 2024 04:06:26 -0800 (PST)
Received: from [10.84.154.116] ([203.208.167.154])
        by smtp.gmail.com with ESMTPSA id db12-20020a17090ad64c00b00298ca3a93f1sm10066602pjb.4.2024.03.04.04.06.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 04:06:26 -0800 (PST)
Message-ID: <8136b9a7-480d-4d47-aca1-adf0c7d90d21@bytedance.com>
Date: Mon, 4 Mar 2024 20:06:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sched/eevdf: Fix miscalculation in reweight_entity()
 when se is not curr
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
 <20240304030042.2690-3-dtcccc@linux.alibaba.com>
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20240304030042.2690-3-dtcccc@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/24 11:00 AM, Tianchen Ding Wrote:
> reweight_eevdf() only keeps V unchanged inside itself. When se !=
> cfs_rq->curr, it would be dequeued from rb tree first. So that V is
> changed and the result is wrong. Pass the original V to reweight_eevdf()
> to fix this issue.
> 
> Fixes: eab03c23c2a1 ("sched/eevdf: Fix vruntime adjustment on reweight")
> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
> ---
>   kernel/sched/fair.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5551ce2af73e..091a1a750638 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3676,11 +3676,10 @@ static inline void
>   dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
>   #endif
>   
> -static void reweight_eevdf(struct cfs_rq *cfs_rq, struct sched_entity *se,
> +static void reweight_eevdf(struct sched_entity *se, u64 avruntime,
>   			   unsigned long weight)
>   {
>   	unsigned long old_weight = se->load.weight;
> -	u64 avruntime = avg_vruntime(cfs_rq);
>   	s64 vlag, vslice;
>   
>   	/*
> @@ -3787,10 +3786,12 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>   			    unsigned long weight)
>   {
>   	bool curr = cfs_rq->curr == se;
> +	u64 avruntime;
>   
>   	if (se->on_rq) {
>   		/* commit outstanding execution time */
>   		update_curr(cfs_rq);
> +		avruntime = avg_vruntime(cfs_rq);
>   		if (!curr)
>   			__dequeue_entity(cfs_rq, se);
>   		update_load_sub(&cfs_rq->load, se->load.weight);
> @@ -3804,7 +3805,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>   		 */
>   		se->vlag = div_s64(se->vlag * se->load.weight, weight);
>   	} else {
> -		reweight_eevdf(cfs_rq, se, weight);
> +		reweight_eevdf(se, avruntime, weight);
>   	}
>   
>   	update_load_set(&se->load, weight);

Reviewed-by: Abel Wu <wuyun.abel@bytedance.com>

