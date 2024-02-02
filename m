Return-Path: <linux-kernel+bounces-49949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB3C8471E4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8FB1287928
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3ADF13EFEA;
	Fri,  2 Feb 2024 14:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ivxg97nG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57950185B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 14:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706884058; cv=none; b=Es45pRKiYAdC7Y9igsoLveenDyLG0Q2OBA/8ZwNhBrSBKu2UFbUz+J1sLmdZ0DocQ7A4+XVx/S48UufpvDMrW7tH0QGhfl56Swgd6y3EiwYqqEp9o+4ZOUlKmnhpymjBxiMIyFHjX6Li5sNXOy1H/j4OS6GoYwxYX3ya7Xkv3WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706884058; c=relaxed/simple;
	bh=RzkeTVJAPZ5UeUS0i8ASAlXVNONascUvWW6yqCnA87c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DdLwBYvVYy3XjTGKhe3diAeW/jJFpLlXO+GV1moPuaZzw26s5gYYqD1zfc6fudtrb3wd9ekXfHyQRgpspL1pd7XDRzVLB7SAPDh21pGUFdf128Si4C7nzn/l7CpW8qMipHzQbss7Cp+zAyRCkYI4+Fxjmb7iD75ek5OP4GMaWrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ivxg97nG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706884055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mWxjXKpTPExhRJhA5TVTwzLtj+lqSzikS80hkJerkB4=;
	b=ivxg97nGyjtPaLA2sn9DpuaURIeEuguP+6T4YO65gqo0Kisgw/FUKpE0CKUqbtooxWAGYQ
	KbLEhTXieg85TANE9CHLuo1a13R2riAweSymoprUhXaUEJ7wqixWh0a+zpPDKvFVPcXx/i
	Lt9HL+qdLOPgREF5TURkbrALrRSvY9g=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-eF4zarJEN8-cLo-cSwsLRw-1; Fri, 02 Feb 2024 09:27:33 -0500
X-MC-Unique: eF4zarJEN8-cLo-cSwsLRw-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6e12d22c2e3so2265442a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 06:27:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706884049; x=1707488849;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mWxjXKpTPExhRJhA5TVTwzLtj+lqSzikS80hkJerkB4=;
        b=O/flIfdbzhYp2tKEhVMR3Upi/ItBtlSdWngOlgupspOabcivl8F1bAnp9g8KCoN+5l
         K1sJaHt4CDaRyai8voiyiAYzO1jYJBNmK6yEJzp5IZhc2T4YksTNUZ0ROOM/EuN/+THn
         nMPq5n3MG0MZUtrJXoptHHX9pfYmWfcVNok8gSYG5Q7czGhFCSbM34WYjBdMTa0eRGC+
         +kfU4LiivCL2ZX9+s6dXfbX4gIFivRMjULTCzrDiYrIbXu56Ae0yNV0N13Ei+1G91PF8
         RJ/b6PFZVH2nqgR2grR0eIlqCQEtVslCZhhIDkreKnnA1hDACuPtp/kYXmUCQGTx9RID
         r/bw==
X-Gm-Message-State: AOJu0YzX55XNChDOIaaF8sLnWKmz+W/9VC7vfaRCoQnLCWYHAsMpOtBj
	ISIaT7o6x0Ve0T1In7iP2SK0MwgjFLvekG/tcewcq9GhTLFpAr989P2zrn1J95/An9uiCC5t7QM
	7nuJP5XimNt3C/c+hq9+h+QimvgLF8eqML8DIXzOO1bD8JET6ucluI7GXkw6c9IXhPZEPHg==
X-Received: by 2002:a05:6830:1295:b0:6e1:1236:987c with SMTP id z21-20020a056830129500b006e11236987cmr8499153otp.20.1706884049223;
        Fri, 02 Feb 2024 06:27:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvrwRb1UXyhXSuiFy5Thk9pVxjt68fQDcdXXW7DA8IOypQnFL934Ulny7vBS1aeePLFL4iqg==
X-Received: by 2002:a05:6830:1295:b0:6e1:1236:987c with SMTP id z21-20020a056830129500b006e11236987cmr8499139otp.20.1706884048964;
        Fri, 02 Feb 2024 06:27:28 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXYLBd9q2TZ0zA1K5ogSDjceVV8BSn2IZAROqFnNca5r9ynkTGamrJrrY32qMvkg/vqWSDu2mIra6o6I3B3tAeFSeKvbL338wjItOkQngPYFpLF9nmIVB+WAdDu2LmNVZ48k2tUEwiYcO03eAJ1bC5oU3p9plbtzD3fSFmgu0sA8EzjPjDXsWajbzYQNfvFCtZAVneu22Molr8iag1lQnm/Q2iShjOKcoadgLXy3QwTstk4g4UUi1LP+egQVwFjcilFzsyCU4lPRERP6HDFAoZZFue8lCbkZyD0Znh8qqPeQfTL6O7qAcIuM4WT/lqUPRF5jYT5dShAPBdknTqLNQnIq2EHiz5gzVjqLRR1u/phsEqzY3BqbAmyVMsXcJ4pUauet/OGNnr9z9LMqhOX6b8pQq+FkylvJLT0SMRA
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id j13-20020ac84f8d000000b0042ab59ccd6csm862250qtw.4.2024.02.02.06.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 06:27:27 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: alexs@kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, linux-kernel@vger.kernel.org,
 ricardo.neri-calderon@linux.intel.com, sshegde@linux.ibm.com
Cc: Alex Shi <alexs@kernel.org>
Subject: Re: [PATCH v3 2/4] sched/fair: remove unused parameters
In-Reply-To: <20240201115447.522627-2-alexs@kernel.org>
References: <20240201115447.522627-1-alexs@kernel.org>
 <20240201115447.522627-2-alexs@kernel.org>
Date: Fri, 02 Feb 2024 15:27:24 +0100
Message-ID: <xhsmh1q9vhrg3.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 01/02/24 19:54, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
>
> sds isn't used in function sched_asym(), so remove it to cleanup code.
>
> Signed-off-by: Alex Shi <alexs@kernel.org>
> Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

AFAICT this is unsused as of:
  c9ca07886aaa ("sched/fair: Do not even the number of busy CPUs via asym_packing")

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

> To: Valentin Schneider <vschneid@redhat.com>
> To: Vincent Guittot <vincent.guittot@linaro.org>
> To: Juri Lelli <juri.lelli@redhat.com>
> To: Peter Zijlstra <peterz@infradead.org>
> To: Ingo Molnar <mingo@redhat.com>
> ---
>  kernel/sched/fair.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 46ba8329b10a..8d70417f5125 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9750,7 +9750,6 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
>  /**
>   * sched_asym - Check if the destination CPU can do asym_packing load balance
>   * @env:	The load balancing environment
> - * @sds:	Load-balancing data with statistics of the local group
>   * @sgs:	Load-balancing statistics of the candidate busiest group
>   * @group:	The candidate busiest group
>   *
> @@ -9769,8 +9768,7 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
>   * otherwise.
>   */
>  static inline bool
> -sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs,
> -	   struct sched_group *group)
> +sched_asym(struct lb_env *env, struct sg_lb_stats *sgs, struct sched_group *group)
>  {
>       /* Ensure that the whole local core is idle, if applicable. */
>       if (!sched_use_asym_prio(env->sd, env->dst_cpu))
> @@ -9941,7 +9939,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>       /* Check if dst CPU is idle and preferred to this group */
>       if (!local_group && env->sd->flags & SD_ASYM_PACKING &&
>           env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
> -	    sched_asym(env, sds, sgs, group)) {
> +	    sched_asym(env, sgs, group)) {
>               sgs->group_asym_packing = 1;
>       }
>
> --
> 2.43.0


