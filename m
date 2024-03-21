Return-Path: <linux-kernel+bounces-109738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAC4885513
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F099281F57
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7721D57894;
	Thu, 21 Mar 2024 07:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TCDYZoQg"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287B9339B1
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 07:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711007104; cv=none; b=Ht6zQepz2fEvMHkWGcLcSWJLCJGlYmbLAlENki1TM+YNC9Ub6wjFgyviuuNRbhGmCQF3EHDEdc5ogZTfDXDo6fABnEKtytafkdRFY524apKrP+t428FPc7RM3WmpjY/aBu5/0CMQfXvSIyptDBX4C5prHU8Mp25ASM52UU/41S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711007104; c=relaxed/simple;
	bh=n8mYR3pta6zA293sNqKbCFaXX/BYE15HF+gwHIKFsUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mK5hw+gCvzrz6uB9n0KT9c2iF/kQKTxGP/ElpNwGqWv3LX8YYA36Ph1AOfUlU+10oK47mcXIXWWV2ipCg/Ty0wF/beAv+nvg2FeUM0+w4eP4F1hfFAT0T1PHbdX1NIFROHS3vtfJ3hoNbo9KEIXLxkByhpHIviUkaPQtm50nORI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TCDYZoQg; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5d3907ff128so499562a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 00:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711007102; x=1711611902; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q7hSEzNRzZ851Uhhtifz0JYUcGL34CYdaLX6j7n3oFA=;
        b=TCDYZoQgk6a1AT0wRtdffZXMYnrX1sZ9aQn450/4aAwX8wVLomiYXiA/TmgSt+eRKP
         4xPhGdvt6boIkEo+l/3XfdtHy5l2EiBo24vc7TApo0iB5K9SYwpOYNMvEtScbUR5XQmo
         vkoxfK+BhjCN/x1Cy6AYxSUHyb+VJ+yDyq9wH4Vrn5tJ+NXUpwX2KMXQeoBXRyr7Wp6M
         OJbsofIYTtnahpAQjFtEIgG8gk3s4vEi+GRv5qYCCO4uusDGUA9xcpeeIlIDanWfN0IB
         D9ysK5ANkB+ywoqx/C2R12/LVjzIW1ZNXTZ/a/QVEFHIEhsd1dSbR/WFup58/wtpVRhR
         suMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711007102; x=1711611902;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7hSEzNRzZ851Uhhtifz0JYUcGL34CYdaLX6j7n3oFA=;
        b=LRKkUXqpQENbtRpSsV+SR3GrPdMLxtTFLa+ACF8Bb14E3uGbOrUB0mvB57pv9V2ZEx
         DUI4zvDQcOQungVgaMlxCVsAeEI77O7vftT3JCp3V6Cspbx6DFJJcykTys26S+HpMuId
         ynKnW3q1E3He2Bht42OGkNDXRSvrE7H7l6DeZCwCX5Qb43t486AZpSBpJC/ipTx/19om
         fHHGQBq38FrllEXvd7vaL7MNI8CMNwL+WotRMyEoWgIq3jgIFVNWIROSeE5ngIYRsQ4f
         SJasStNsVFpMJ5mZlxvuOjfI6h8Lddq3w6dzufYKmy3ZuWdnBiXbi+ANNZkYJDkiIH+v
         VxLA==
X-Forwarded-Encrypted: i=1; AJvYcCVaikcOk8vfthF7/8LfS6QR8/Vsjxxq+AwhWKYdvE8y+mWe+bkv2bdEHq1+pNit/zJJ0iTpP7FXpQyFBlqRV/OoAPF12spogy4ZQiZE
X-Gm-Message-State: AOJu0Yyhca01AafNGBRe5M3s7u2zoYIO3iwmjdzFRb60jDNCiuJhOX0f
	r63JDVax3S9QsPLgf/yfdM2819IXCb7cplPSB0NCgJYm4YYcZ1YkXfgu4zX8D9IVQaA4gsra9Eu
	v6fFbNoIHeCO063uStq3087G+zyKVVtIesaPuKw==
X-Google-Smtp-Source: AGHT+IHgam8NQRs6BCAYVH0uOovl0Io/T7Sha0lKrrrkcNdLRUyAAN8eQMuvfT6SqnVtaWwPh0I2wQ1JkAj5X3QHXQ0=
X-Received: by 2002:a17:90b:30ce:b0:29f:e772:61c3 with SMTP id
 hi14-20020a17090b30ce00b0029fe77261c3mr5492177pjb.27.1711007102322; Thu, 21
 Mar 2024 00:45:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313150133.1182298-1-sshegde@linux.ibm.com> <20240313150133.1182298-2-sshegde@linux.ibm.com>
In-Reply-To: <20240313150133.1182298-2-sshegde@linux.ibm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 21 Mar 2024 08:44:50 +0100
Message-ID: <CAKfTPtBYAibCdsPumTAPDKBwNfLP9nr5577MSNKffV_VDmHDgA@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/fair: Check rd->overload value before update
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: mingo@kernel.org, peterz@infradead.org, dietmar.eggemann@arm.com, 
	qyousef@layalina.io, linux-kernel@vger.kernel.org, vschneid@redhat.com, 
	qperret@google.com, yu.c.chen@intel.com, srikar@linux.ibm.com, 
	pierre.gondois@arm.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Mar 2024 at 16:02, Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
>
> Overload is an indicator used to inform if there is any rq in the root
> domain has 2 or more running tasks. Root domain is a global structure per
> cpuset island.
>
> Overload status is updated when adding a task to the runqueue.
> It is cleared in update_sd_lb_stats during load balance, if none of the
> rq has 2 or more running task. It is used during to newidle
> balance to see if its worth doing load balance. If it is set, then
> newidle balance will try aggressively to pull a task.
>
> Since commit 630246a06ae2 ("sched/fair: Clean-up update_sg_lb_stats
> parameters"), overload is being updated unconditionally. The change in
> value of this depends on the workload. On typical workloads, it is
> likely that this value doesn't change often. Write causes the
> cacheline to be invalidated. This would cause true sharing when the same
> variable is accessed in newidle_balance. On large systems this would
> cause more CPU bus traffic.
>
> Perf probes prove that actual change in value is less often. So it would
> be better to check the value before updating it. Detailed perf probes
> and annotation can be found in the cover letter. CPU bus traffic reduces

the cover letter will not be merged. It's better to put the figures
here if you want to mention them

> with the patch.
>
> Fixes: 630246a06ae2 ("sched/fair: Clean-up update_sg_lb_stats parameters")

I don't think it's worth a Fixes tag. This is an improvement more than
a fix as the current code works fine but generates more bus traffic

With these minor changes in the commit message:

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  kernel/sched/fair.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 02d4d224b436..eeebadd7d9ae 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10621,7 +10621,8 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>
>         if (!env->sd->parent) {
>                 /* update overload indicator if we are at root domain */
> -               WRITE_ONCE(env->dst_rq->rd->overload, sg_status & SG_OVERLOAD);
> +               if (READ_ONCE(env->dst_rq->rd->overload) != (sg_status & SG_OVERLOAD))
> +                       WRITE_ONCE(env->dst_rq->rd->overload, sg_status & SG_OVERLOAD);
>
>                 /* Update over-utilization (tipping point, U >= 0) indicator */
>                 set_rd_overutilized_status(env->dst_rq->rd,
> --
> 2.39.3
>

