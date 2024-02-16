Return-Path: <linux-kernel+bounces-68218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D63785776A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1949B239E2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939001AACA;
	Fri, 16 Feb 2024 08:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S0ASr/SL"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648BA17732
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 08:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708071025; cv=none; b=JOZ2VqB0l3C7AuxJa5yIeE2jd1zxgvbd40f7T5n1dmwDw39zQ2hBITxsxIptWoOBzlu7b7aas4roKbJPz1/tjCuTbN069kWP7evOv1xQy1dlJgE0c9DBBN2qsRLyJrCioEBxS6F3Shy2ZmJMP4tdaSJJlRqtnuslDMIShcmuroY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708071025; c=relaxed/simple;
	bh=0uydNOdWxU499+hAnc9/iQNbM8NCAF4AuCCa9QpChxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jCgDuYxtfGl3Y8xHaNBkKI49fXWKplbpKKbkRhzCuVhV3m4Xt5u1zVQ1rnp/anJpcz0b3+rjBPR1Nm0PwKEqDBFodgUat0M9d075YDLqgf89mo0XyqxzaohyoE0jMBpkQj3KODyt20rz5wDq/amoqErxbpknI3hW83ySP0HMTFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S0ASr/SL; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso1617280a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 00:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708071023; x=1708675823; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FIMHZLHgidom8xzo0JtT7bpMHA+BcXdFvKux27+zxKg=;
        b=S0ASr/SLEpJDapQlzFwaAUSzO4DqsJmn84GeQGRpBI8BeT4xE9v96pvgSCkax7brPi
         PMM+Qw6u/XjcSYmwWGN/0Xm0sqQDuWtd83/l7nL+CsDiTOFrtmF/LIQ6ZpaWdMYgcwjD
         qvtHgG9RbRDX8f5Yd0gu1tPiTgj+3VlvUyDCcK4LSxjWO4oUHe8JWbaBhyiavOOcilVY
         IiVii/wyQJRL/s2pmEl4FUlOf4BL8IoeH/XjV+xeWUrRRYbmjFUoO/WQfzFUqBYBWMGF
         +757jS3Ha7xq5Tj9xwttqOVXXufcL0Lp+JV5TrdoKqdE4U7myhsKQCBUhjdbdX6Rg6n2
         FzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708071023; x=1708675823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FIMHZLHgidom8xzo0JtT7bpMHA+BcXdFvKux27+zxKg=;
        b=Ku3nAwHoAqxsTR3cKvuY8pDv7IvV2klKNF1lz/AUSLiESFApDx/wfpY1mB/6FV21UR
         hrQCPo9gXaVUyn9dNnkaUH56jdVbExB7XFnGY8iJEwe53TtLNIV9M2hQq6HJLUx85xyZ
         xDTVlPZv93X4MZ0QcPPoYq4o4d2tQRjtfGSVslQc7WKfdL8VdaQpK4CC10V+pCqWD0pD
         Pn7762cpIVdcPnpcvkajLedQxmnV5vRTqb3Sk9HtTY/x1SVS9IAu3VhOo8nCuMQhDfcD
         uuPvcTncaWsmtfINw/bLTLcestN315/IoGflXGK9SB2/0AoU02Moqtzm57PxsSdl3ezD
         3VHw==
X-Forwarded-Encrypted: i=1; AJvYcCWOrTThk4JlhSHLg6Td5razsVFsW7SSgf0xCplElkY7Ty0bdDkVCamxZxhfdQiYKnDlARbP5Ewd2J2fEpn5uXJv7Yh6E355LJ+4iSLj
X-Gm-Message-State: AOJu0Yx6uuWqMxkvoYHPIbtylvKJutZu8mzmLn63BhlqCE7Ov6F5BxgS
	Y3ava/2+zikyRHAWHBmvIU+74fXEU8/u6UitI1wyfmnPfOyy0FUPe8Q/MO+dlU09thNH7xoIlef
	ve51jI9OYSG7GyV2GvA3i8QyxLpQxX0AlEftY2amfsyoU4la+
X-Google-Smtp-Source: AGHT+IEA3fqIoDaQ25VyAh6A9qdU6NnwReaS2v0dhLKfI8uGBigq12wwATXweFxw1oPtdit7dobAjVX5Vbv9szvUA+c=
X-Received: by 2002:a05:6a21:670b:b0:19c:9b7b:66a with SMTP id
 wh11-20020a056a21670b00b0019c9b7b066amr4587380pzb.49.1708071023666; Fri, 16
 Feb 2024 00:10:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216061433.535522-1-sshegde@linux.ibm.com>
In-Reply-To: <20240216061433.535522-1-sshegde@linux.ibm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 16 Feb 2024 09:10:12 +0100
Message-ID: <CAKfTPtCFx3-0N+53u3Y5so1n8Zjw57c_fxf=09_Y9NTCP-zH1g@mail.gmail.com>
Subject: Re: [PATCH] sched: remove duplicate ifdefs
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: mingo@kernel.org, peterz@infradead.org, sshegde@linux.vnet.ibm.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Feb 2024 at 07:14, Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
>
> when a ifdef is used in the below manner, second one could be considered as
> duplicate.
>
> ifdef DEFINE_A
> ...code block...
> ifdef DEFINE_A       <-- This is a duplicate.
> ...code block...
> endif
> else
> ifndef DEFINE_A     <-- This is also duplicate.
> ...code block...
> endif
> endif
> More details about the script and methods used to find these code
> patterns are in cover letter of [1]
>
> In the scheduler code, there are two places where above pattern can be
> observed.
> Hunk1: Code is under check of CONFIG_UCLAMP_TASK in kernel/sched/core.c
> from line 1353. Hence the same check at line 1795 is duplicate.
> Hunk2: Minor update of comment.
> Hunk3: Code is already under the check of CONFIG_SMP in
> kernel/sched/fair.c from line 8591. Hence the same check in line 10185
> is a duplicate.
>
> No functional change is intended here. It only aims to improve code
> readability.
>
> [1]:https://lore.kernel.org/all/20240118080326.13137-1-sshegde@linux.ibm.com/
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
> Changes since v2:
> - Dropped RFC tag.
> - Split the patches into individual from the series.
> - Added more context to each Hunk for review.
>
>  kernel/sched/core.c | 4 +---
>  kernel/sched/fair.c | 2 --
>  2 files changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9116bcc90346..a76c7095f736 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1792,7 +1792,6 @@ static void cpu_util_update_eff(struct cgroup_subsys_state *css);
>  #endif
>
>  #ifdef CONFIG_SYSCTL
> -#ifdef CONFIG_UCLAMP_TASK
>  #ifdef CONFIG_UCLAMP_TASK_GROUP
>  static void uclamp_update_root_tg(void)
>  {
> @@ -1898,7 +1897,6 @@ static int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
>         return result;
>  }
>  #endif
> -#endif
>
>  static int uclamp_validate(struct task_struct *p,
>                            const struct sched_attr *attr)
> @@ -2065,7 +2063,7 @@ static void __init init_uclamp(void)
>         }
>  }
>
> -#else /* CONFIG_UCLAMP_TASK */
> +#else /* !CONFIG_UCLAMP_TASK */
>  static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p) { }
>  static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p) { }
>  static inline int uclamp_validate(struct task_struct *p,
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 533547e3c90a..8e30e2bb77a0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10182,10 +10182,8 @@ static int idle_cpu_without(int cpu, struct task_struct *p)
>          * be computed and tested before calling idle_cpu_without().
>          */
>
> -#ifdef CONFIG_SMP
>         if (rq->ttwu_pending)
>                 return 0;
> -#endif
>
>         return 1;
>  }
> --
> 2.39.3
>

