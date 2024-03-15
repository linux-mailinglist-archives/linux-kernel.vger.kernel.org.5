Return-Path: <linux-kernel+bounces-104126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E54C387C972
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C92A11C215AD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 07:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD22C14280;
	Fri, 15 Mar 2024 07:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IKUJHqKY"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B96134B6
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 07:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710488760; cv=none; b=rFEkgi2dxVpZX0iH280gHnjI9tFWVR9x4emBsl96fpr+XR32IzJTWcd7el0Q566KGH6xVlu2PzqFS4/A4HnQZyvPjuTMWi79VgqMRThUgt8KwCTycFSETGOeI7axmx2vtc4AzfUPoGN/1mOfBuy5LCFCTelpwJ6hOZnSSbYhkww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710488760; c=relaxed/simple;
	bh=yfAXTgwBso9H53pHEYoignG31JRruRhXqFHOsdtLxvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZJATQZNE+WILDyTv5gpNFN8jge2I1Pi0IYKONSGE59xSdgwfjmQ+WNePmmyPronQmbJIOZvozcpwhQvVgUgdiRBsTAOI8/i7Np8vBppDFaog5ODZxOA2xEeQaTH2gAYvqNrr4Z7rnFrL0tDp7EMq0g6DEAw+zLRTMS4L8LowkEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IKUJHqKY; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-29bd0669781so1380974a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 00:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710488757; x=1711093557; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WewxWuRgvW2sDqqMKjjymO745lHYBK7yKRlcJJ5RcHA=;
        b=IKUJHqKYdPLfut3AiI2BMjBRhJw0FMa30azHbXEkUhnaVmT4NLNTTDBdZstkP+Tl4O
         TTQshLgdGkrhHwCdfYwXPKOkc7YZpBbzU2ghclt/Y894Sh6qE+UikYqb1lNXXJpSbUb0
         tGxnwkE/u/34jZZM8X2Y7jfDCwj8/1uOjcM1KkOy2KVXBJZTRjNFwPFmRiTe3eliBNVW
         55QCFZNxzOmGeObotEX6ajjE+t5a9Epae2cy3bETsVa90SNmd3JdgOGfnTlsgNujRIjY
         qSLca/+trN6JMmwbCH4w81Lztm8khZC2dlO5BgTlD3ukBl/bq2ci24x1VGFy/vRCryZp
         jgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710488757; x=1711093557;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WewxWuRgvW2sDqqMKjjymO745lHYBK7yKRlcJJ5RcHA=;
        b=vDRgCyDSc5RWBk6eQ8gRaU2KI0KOZNn64eViYdkhLzSaIgAWOs8yl4OP5nPibpOU8p
         XJnd8/orfVEd/bVJSAvqOm4aS6XtF1n+xMMU+DOtbJJMi0xA+hxDEsa7Yz0vt1MLxOYk
         Nx3+F/roP4QlVvdC3XglYI2T2xN4l8aoegusJDcNA2UmNVknIt39IWEe5E0WsB6+PzWp
         CedpalvzNHjRrjd21EZKFPAsun7R1iY+shA6GQKFm2xbogzWSdA1FdtNGwiD+t4xOUwj
         sRJTw0SRo9TEb9AUpnhp4PjnZJat5YkMC1fm/TmI5qev8Rs7y0/48hFfMtmNsEOzaCds
         /aQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBPw7iYrPf/vZa+mpbtpsR5hiu1xDafqfgDVOSx6yLtRGyKbWw/OeR7pXJY3UR0L+YEeAmBWvNj939+h975nVAtyDAGlTeR0yvYd81
X-Gm-Message-State: AOJu0YwSMCw0ZaPoscx8V+VWNidt00akJY5L8AxKzaFCdEr9fLYlrI7e
	tUYdRNYKCqaNcOAhyv+35JuiKswUmqBo+biUUT38cm/dof/RtaAz99bfgKNDkc0RkOHeTTAM1xv
	FJUqCdjE47/KiD5ArC30j9G65azjnsNwMV3YcUA==
X-Google-Smtp-Source: AGHT+IE69195cVAAiKPcAhECjpD72moAgmpoV0yBgg731BqdbuiEhybSO3ZbMjwQBjYGMeyKIsA3Dtv18KpdJ3O2Bk4=
X-Received: by 2002:a17:90b:196:b0:29c:7193:29c5 with SMTP id
 t22-20020a17090b019600b0029c719329c5mr3720207pjs.30.1710488757651; Fri, 15
 Mar 2024 00:45:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315015916.21545-1-daweilics@gmail.com>
In-Reply-To: <20240315015916.21545-1-daweilics@gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 15 Mar 2024 08:45:46 +0100
Message-ID: <CAKfTPtAN3t46WGnqNV1VN1oer2C3Eu4k88O4bm-RDhdRaiGXXA@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: fix initial util_avg calculation
To: Dawei Li <daweilics@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Mar 2024 at 02:59, Dawei Li <daweilics@gmail.com> wrote:
>
> Change se->load.weight to se_weight(se) in the calculation for the
> initial util_avg to avoid unnecessarily inflating the util_avg by 1024
> times.
>
> The reason is that se->load.weight has the unit/scale as the scaled-up
> load, while cfs_rg->avg.load_avg has the unit/scale as the true task
> weight (as mapped directly from the task's nice/priority value). With
> CONFIG_32BIT, the scaled-up load is equal to the true task weight. With
> CONFIG_64BIT, the scaled-up load is 1024 times the true task weight.
> Thus, the current code may inflate the util_avg by 1024 times. The
> follow-up capping will not allow the util_avg value to go wild. But the
> calculation should have the correct logic.
>
> Signed-off-by: Dawei Li <daweilics@gmail.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
> Changes in v2:
> - update the commit message
> ---
>  kernel/sched/fair.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a19ea290b790..5f98f639bdb9 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1031,7 +1031,8 @@ void init_entity_runnable_average(struct sched_entity *se)
>   * With new tasks being created, their initial util_avgs are extrapolated
>   * based on the cfs_rq's current util_avg:
>   *
> - *   util_avg = cfs_rq->util_avg / (cfs_rq->load_avg + 1) * se.load.weight
> + *   util_avg = cfs_rq->avg.util_avg / (cfs_rq->avg.load_avg + 1)
> + *             * se_weight(se)
>   *
>   * However, in many cases, the above util_avg does not give a desired
>   * value. Moreover, the sum of the util_avgs may be divergent, such
> @@ -1078,7 +1079,7 @@ void post_init_entity_util_avg(struct task_struct *p)
>
>         if (cap > 0) {
>                 if (cfs_rq->avg.util_avg != 0) {
> -                       sa->util_avg  = cfs_rq->avg.util_avg * se->load.weight;
> +                       sa->util_avg  = cfs_rq->avg.util_avg * se_weight(se);
>                         sa->util_avg /= (cfs_rq->avg.load_avg + 1);
>
>                         if (sa->util_avg > cap)
> --
> 2.40.1
>

