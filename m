Return-Path: <linux-kernel+bounces-92183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFA9871C5D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40AE61C22E4F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9125B20E;
	Tue,  5 Mar 2024 10:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fg6hWNLK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DB95A782
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 10:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635859; cv=none; b=aT92GAkGoyMmGuLJT74wwVsSYZoyCL9G7iIYFrhi4Lz8UB5+ekgqgfSb14SLO6b7RwTPWYex5OoXDEp2aL1AjLsqHd3mvGXiYZbhVfooqf2SJfJefeb3SmMroZPU+X+NQu3ioPztsoQkIShteTNc2Q/uf9B9pEQDyCJ4KuRPoUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635859; c=relaxed/simple;
	bh=4JbccXLVHkGwTjCOoatmizF0As7RMhlHeIAYb7I3OuU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cw2+RLL5GwBtfuOBchyenrFCaNiJ39rMP5MSg8PGdNdmWq978cbql95X5MzZ556vtvPaKmFdzEXsXkxfVs3EDjI4xoLSzbR5iqPuLH2mALKrHC5Ahp+k32Hf6wg4sxgaR3Gx796Nf89x9N0/NUE/6j1K0NiuuvnCAYd+J5rEI3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fg6hWNLK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709635857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=STInnfJUgELKh4o3m/dGIlSNOSlQYa7DAEhtfW5fXSQ=;
	b=Fg6hWNLKygggN+PShVNnqmJcqgtHvsJz2wwoZ95EU3XUVtTzw3qJkvNRFaZAdXDr4rtUOi
	8a58nJqPwBBEyGc6RNkgIjLRl8SRC+DAmOwV8p8+zrPO40gFrhbDUb+caYUtFwFkWdFWbJ
	irg4NJM31JcFz49xeA0t9xPn5Y0LxjQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-cebmtvkUPtW3jhwubnct0g-1; Tue, 05 Mar 2024 05:50:55 -0500
X-MC-Unique: cebmtvkUPtW3jhwubnct0g-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-69053d28753so58581076d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 02:50:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709635854; x=1710240654;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=STInnfJUgELKh4o3m/dGIlSNOSlQYa7DAEhtfW5fXSQ=;
        b=b5E+hJp0qPFEQbYh4SjgrpkjGnPbYN8ERrq+nlgvNeIVjc3QVncVi4ao5UsaJRtJnU
         48/xd2Vi9X1kzxynx8HX7HJQEWM7G0yYcoT0bObVqYXvTljkjpUAr/qQhO8fLUYKQJrM
         janqBwEBzdlqyymQOkH3cZLqLM4cWBsDfdk3fGk17lwpyoAVRfq0CjRjWUcOggAaTgTQ
         WWbaD6YZSvMDoyAj3AmROOmTcDpbwyEnMZCWbI53fIqAwxGBvyMGWc8UrmMqFS5lnn/V
         OVFcYdX8EHOJM+LUTcKBceKBRpC5V8AwCFYaXEpDXEGYoWPnm4RvjZOJCjpQfn08kYM+
         9o4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjQgSB/artvYO0SSCeX1Yu6HH6UCefYGZrbdMU/ORY0C3SRJ3mbaJ0xEvQPiZP7hJOPErRk3/CoYWmgQOMK2+uGyLgcyTzwsBV3g7O
X-Gm-Message-State: AOJu0YwcDiVWocuXDZp8NtRqiB3/HxURfyK+CVH5sq9chWVLs0xLVG4U
	vLsbG6T46xt3j0Q/1D7uPch0wZB3iNSO+vvJBEFBYDyXDfOvHvhiHZhfsuoX9ewdLkebnJZlU34
	RClmU5tKugCQr7/Agxsxym8oBPvi6O8X1z3Cg2vvFS8EMVziIrfCs3FFZ6EqLUg==
X-Received: by 2002:a05:6214:57ca:b0:690:8f12:b73f with SMTP id lw10-20020a05621457ca00b006908f12b73fmr143980qvb.35.1709635854758;
        Tue, 05 Mar 2024 02:50:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExDU/tQJVwzs9X4iPIXDLMYNMaeU6FyUbgdX0lEVSFWWPoTmuo9Z7AQlDCSSys7dXvMz30RA==
X-Received: by 2002:a05:6214:57ca:b0:690:8f12:b73f with SMTP id lw10-20020a05621457ca00b006908f12b73fmr143970qvb.35.1709635854527;
        Tue, 05 Mar 2024 02:50:54 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id lb27-20020a056214319b00b00690456832c8sm6065883qvb.29.2024.03.05.02.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 02:50:54 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, Peter Zijlstra
 <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH 6/9] sched/balancing: Update run_rebalance_domains()
 comments
In-Reply-To: <20240304094831.3639338-7-mingo@kernel.org>
References: <20240304094831.3639338-1-mingo@kernel.org>
 <20240304094831.3639338-7-mingo@kernel.org>
Date: Tue, 05 Mar 2024 11:50:51 +0100
Message-ID: <xhsmhbk7tdkac.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 04/03/24 10:48, Ingo Molnar wrote:
> The first sentence of the comment explaining run_rebalance_domains()
> is historic and not true anymore:
>
>     * run_rebalance_domains is triggered when needed from the scheduler tick.
>
> ... contradicted/modified by the second sentence:
>
>     * Also triggered for NOHZ idle balancing (with NOHZ_BALANCE_KICK set).
>
> Avoid that kind of confusion straight away and explain from what
> places sched_balance_softirq() is triggered.
>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Valentin Schneider <vschneid@redhat.com>
> ---
>  kernel/sched/fair.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 4c46bffb6a7a..18b7d2999cff 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -12409,8 +12409,13 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>  }
>
>  /*
> - * run_rebalance_domains is triggered when needed from the scheduler tick.
> - * Also triggered for NOHZ idle balancing (with NOHZ_BALANCE_KICK set).
> + * The run_rebalance_domains() softirq handler is triggered via SCHED_SOFTIRQ
> + * from two places:
> + *
> + *  - the scheduler_tick(),
> + *
> + *  - from the SMP cross-call function nohz_csd_func(),
> + *    used by NOHZ idle balancing (with NOHZ_BALANCE_KICK set).

Bit of a nit but the CSD is also triggered via the scheduler_tick():

  scheduler_tick()
  `\
    trigger_load_balance()
    `\
      raise_softirq(SCHED_SOFTIRQ)

  scheduler_tick()
  `\
    trigger_load_balance()
    `\
      nohz_balance_kick()
      `\
        kick_ilb()
        `\
          smp_call_function_single_async(ilb_cpu, &cpu_rq(ilb_cpu)->nohz_csd);

I got to the below which is still somewhat confusing, thoughts?

"""
The run_rebalance_domains() softirq handler is triggered via SCHED_SOFTIRQ
from two places:

- directly from trigger_load_balance() in scheduler_tick(), for periodic
  load balance

- indirectly from kick_ilb() (invoked down the scheduler_tick() too), which
  issues an SMP cross-call to nohz_csd_func() which will itself raise the
  softirq, for NOHZ idle balancing.
"""

>   */
>  static __latent_entropy void run_rebalance_domains(struct softirq_action *h)
>  {
> --
> 2.40.1


