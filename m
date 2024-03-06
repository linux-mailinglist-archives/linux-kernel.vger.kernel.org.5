Return-Path: <linux-kernel+bounces-93264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99480872D41
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 556E2288556
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A936F4E2;
	Wed,  6 Mar 2024 03:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DlJRNxMm"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9DCDDAB
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 03:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709694476; cv=none; b=D/tWGYzcUIwTw+QXUA9LnQxm2UMh3+QoW3V8JIdeahpdbKaHvKexerg9d8YcOU8oSYGGjCktjmdp1+JitXrmXkzzgxygCNPMOdMHh+rqA3d4A+YCaOz6njTFhWSS1WATdJaSTwpvRFwkks5yq454pM9wws+An4wqpMshkYvtTtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709694476; c=relaxed/simple;
	bh=Vtwk64MJfFurchghTacEBkuQ/GO/QTdi/78Hoc2Pm3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KSd7gZsLOnWwoqWnApeikVBY0s/gOIsdfNunhrOeJEarvqQ2abUQI82wNmpa3mdLA+t/Jyf71RYiqd3e8dhphjqVFLi8xpbOPNkawp6IhQuPiK0G+76Ls0nMPnDfCEMdI/9oa5Of5OJA4D43OElrJeX6ooQv/Aq+4UcD+Juhmlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DlJRNxMm; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-29ab78237d2so4386019a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 19:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709694473; x=1710299273; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fpYzOvRaHq4gHEmEypaVl6DouqaHn7yaLW4F5xgQiHk=;
        b=DlJRNxMmxSvW4Nh4AkV1ahQMFBtNScEn5fC8/zo9dykb9ehHuXOPXNJHMhByFqTWq9
         AOD6oNLq0JWwdrZ6wkckWi7Boa22luQNcEJW8IeUEiLqcWtOhv3fnhizKp4ea9zMDCYf
         ge3zyU03iPgYKP4JyFKHuVb9W1Yw6QDz8Jesn12EdR6B1bfwnIoj4hT+XYKwA6sNaNDE
         B428hH3SP5eyx+u5bIOS596aJrca0ukjjRve251GpJ+F5mzKOK42Mrd2vxCXpf6D0Kw7
         h48C2q6Yr7QJ/nmaAzB0/Z0r644smjXCtVM7p7ublPOXL+ZnuWj5kOrmr3QkcNO96YL4
         xEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709694473; x=1710299273;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fpYzOvRaHq4gHEmEypaVl6DouqaHn7yaLW4F5xgQiHk=;
        b=AfiPfzhI5g0C7nnWSSRq5GD/ZxYjSvSuRyw34ja5QYzIHWaALHtCFoux9ATa0b7DkT
         7lbdgnWHOvV6HN+eoF5E37MbraxgYrOHJ0aDMWhFLtTBk9YWHh31UhvfkRJYeXrcVYtX
         oaFTN7c/8zzuzMULegvFMSt/dKoYar52Nt81vBfBvBLlUCFg3Bp4ipL/hTEoc4W2HMBP
         oTc+DXpdIIqQNA5Ucm/P137Ikmf1TNQS0b0XJR13enFpe/VTf420PjOHLMIMO2ge++YG
         wqmTVpR6k5L/UyOG0nIZ5o1rHQ4qLfdN1MN0B8yNSkhuZOp/GZFG52tB6IrHJW4XH5fx
         hY0A==
X-Forwarded-Encrypted: i=1; AJvYcCXeUoY0EyEKMWViKMhIpX96pAd3tOshIs4/IsQ9Cvz7xxUeRiHMem43JmMGGWdfeMbS399WHoI179M8IOsHd7M8ab1gNCcDxAqgWeXw
X-Gm-Message-State: AOJu0Yx4uKi7edmicK8X4jf/Bi9mYNl+PCQ9D7drpNLLHrMdWzSUJXCh
	BOmlEg6n/td43pMtIo5dRRHt/1y2VPLdk6nh42uL2RZUVWk/hiK8SIFw+Xe5o9w=
X-Google-Smtp-Source: AGHT+IEkulV0CF0+6jCbcIRX7tivRu/l6oZ/37/IH08UQvwjeOE8FRrP/N47GBJ8LezOo/DmItXFqw==
X-Received: by 2002:a17:90a:5404:b0:29b:347f:23ea with SMTP id z4-20020a17090a540400b0029b347f23eamr8063152pjh.3.1709694473410;
        Tue, 05 Mar 2024 19:07:53 -0800 (PST)
Received: from [10.84.154.116] ([203.208.167.155])
        by smtp.gmail.com with ESMTPSA id m2-20020a17090a34c200b00298d8804ba8sm13624811pjf.46.2024.03.05.19.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 19:07:52 -0800 (PST)
Message-ID: <10c71757-032f-4aa0-a178-cdc8cff5f2e6@bytedance.com>
Date: Wed, 6 Mar 2024 11:06:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] sched/eevdf: Always update V if se->on_rq when
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
References: <20240306022133.81008-1-dtcccc@linux.alibaba.com>
 <20240306022133.81008-2-dtcccc@linux.alibaba.com>
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20240306022133.81008-2-dtcccc@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/6/24 10:21 AM, Tianchen Ding Wrote:
> reweight_eevdf() needs the latest V to do accurate calculation for new
> ve and vd. So update V unconditionally when se is runnable.
> 
> Fixes: eab03c23c2a1 ("sched/eevdf: Fix vruntime adjustment on reweight")
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

Reviewed-by: Abel Wu <wuyun.abel@bytedance.com>

Thanks!

