Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402867E59D5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjKHPPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjKHPPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:15:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55ABD188
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 07:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699456467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9aaIb8urRnoY67/1dS6RQ1uguu20E648z3zl88Urt0o=;
        b=SkhwqjAUA+Pj1o4ZH2lnW3TyzdhE/i0e0aK5otVw2eoEsNCrwzErWDEO7pOqqk8Dk1ZJmZ
        8zStTffx7bQVLo1464IHCslc5A3gPbZ5eu9xVarQCWPYOrzPclVndmVUOVjml/OZl+QGDo
        pBctv/JglOuiHVvnQj9W3js4RhusFRU=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-ucwAoUOENe2AjMzk8hdIaQ-1; Wed, 08 Nov 2023 10:14:26 -0500
X-MC-Unique: ucwAoUOENe2AjMzk8hdIaQ-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3b2ef9e4c25so10081589b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 07:14:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699456465; x=1700061265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9aaIb8urRnoY67/1dS6RQ1uguu20E648z3zl88Urt0o=;
        b=nToxSBM7VZqI8/H/m8olPLcEqDqcKwpn1pPi2sQ3+T3gUUvPqUPun9wC9vbvDak80G
         djJFKiwzxtil4gVjSzajYr/A0UOFDNQl/7fN3QqkxAnKYY6lHpyKCjM4nUCu0g43EFNd
         efTlo6ZBZKM+Y6rToxHk7nJxvWveQxPcwxqwBRom3ZacPccLoUs6pceL+BnlFMg9ZpoR
         sl3BjK9NuFgrAX5RHbTV4S8fvR0bJ3e2nnJWWw6l0YI4sRtGITeQ1cW0zv/OLaZg3xxE
         iOSU7beTcuRhzGiKP3ZAnlIx9LedwbxlA2GaQDS2Y6myecXVeZK2PJR/iC3b+FPnhGoK
         u7lg==
X-Gm-Message-State: AOJu0Yy+kHOZAnkQiWITnjrqL9BECosxRBB9Q3RpftuOdoz/urczBVyP
        zfYhfNAAVwZmD1ryijMaoTUYVcH/AiJ2mWfFvwwvSe0btQcr8C3mEPc3pBKZvoFAfunawzM6paq
        IQsionawjrO3NQpXqkyEBBqTl
X-Received: by 2002:a05:6808:4448:b0:3b6:a883:b40e with SMTP id ep8-20020a056808444800b003b6a883b40emr2614099oib.19.1699456465508;
        Wed, 08 Nov 2023 07:14:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGX3fd+7BamuSSGnb6HDg9OGQ5t2auJfMXE7nhbctPyuVjmSbWh/epeA64gm03OnKn2Msup7w==
X-Received: by 2002:a05:6808:4448:b0:3b6:a883:b40e with SMTP id ep8-20020a056808444800b003b6a883b40emr2614074oib.19.1699456465202;
        Wed, 08 Nov 2023 07:14:25 -0800 (PST)
Received: from localhost.localdomain ([151.29.128.75])
        by smtp.gmail.com with ESMTPSA id h14-20020a0cedae000000b0065af24495easm1164981qvr.51.2023.11.08.07.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 07:14:24 -0800 (PST)
Date:   Wed, 8 Nov 2023 16:14:18 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v5 6/7] sched/deadline: Deferrable dl server
Message-ID: <ZUulyj7tXnZzv5V6@localhost.localdomain>
References: <cover.1699095159.git.bristot@kernel.org>
 <c7b706d30d6316c52853ca056db5beb82ba72863.1699095159.git.bristot@kernel.org>
 <CAEXW_YS=PrWDx+YGVR7bmq0_SoKNztzGrreApCd9qk1yBLA5bA@mail.gmail.com>
 <CAEXW_YQ8kv3tXQJexLSguPuWi0bXiReKDyYNo9+A-Hgp=Zo1vA@mail.gmail.com>
 <CAEXW_YSjsZSrJK_RbGmbLNy4UrLCgu+7NPZjg-wiLuNbGOGr+w@mail.gmail.com>
 <20231107114732.5dd350ec@gandalf.local.home>
 <7d1ea71b-5218-4ee0-bc89-f02ee6bd5154@redhat.com>
 <3e58fad7-7f66-4e48-adcc-0fda9e9d0d07@kernel.org>
 <20231108124401.GQ8262@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108124401.GQ8262@noisy.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 08/11/23 13:44, Peter Zijlstra wrote:
> On Tue, Nov 07, 2023 at 07:50:28PM +0100, Daniel Bristot de Oliveira wrote:
> > > The code is not doing what I intended because I thought it was doing overload
> > > control on the replenishment, but it is not (my bad).
> > > 
> > 
> > I am still testing but... it is missing something like this (famous last words).
> > 
> > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > index 1092ca8892e0..6e2d21c47a04 100644
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -842,6 +842,8 @@ static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
> >   * runtime, or it just underestimated it during sched_setattr().
> >   */
> >  static int start_dl_timer(struct sched_dl_entity *dl_se);
> > +static bool dl_entity_overflow(struct sched_dl_entity *dl_se, u64 t);
> > +
> >  static void replenish_dl_entity(struct sched_dl_entity *dl_se)
> >  {
> >  	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
> > @@ -852,9 +854,18 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
> >  	/*
> >  	 * This could be the case for a !-dl task that is boosted.
> >  	 * Just go with full inherited parameters.
> > +	 *
> > +	 * Or, it could be the case of a zerolax reservation that
> > +	 * was not able to consume its runtime in background and
> > +	 * reached this point with current u > U.
> > +	 *
> > +	 * In both cases, set a new period.
> >  	 */
> > -	if (dl_se->dl_deadline == 0)
> > -		replenish_dl_new_period(dl_se, rq);
> > +	if (dl_se->dl_deadline == 0 ||
> > +		(dl_se->dl_zerolax_armed && dl_entity_overflow(dl_se, rq_clock(rq)))) {
> > +			dl_se->deadline = rq_clock(rq) + pi_of(dl_se)->dl_deadline;
> > +			dl_se->runtime = pi_of(dl_se)->dl_runtime;
> > +	}
> > 
> >  	if (dl_se->dl_yielded && dl_se->runtime > 0)
> >  		dl_se->runtime = 0;
> 
> Should we rather not cap the runtime, something like so?
> 
> Because the above also causes period drift, which we do not want.

I was honestly also concerned with the drift, but then thought it might
not be an issue for the dl_server (zerolax), as it doesn't have a
userspace counterpart that relies on synchronized clocks?

> 
> ---
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 58b542bf2893..1453a2cd0680 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -829,10 +829,12 @@ static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
>   */
>  static void replenish_dl_entity(struct sched_dl_entity *dl_se)
>  {
> +	struct sched_dl_entity *pi_se = pi_of(dl_se);
>  	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
>  	struct rq *rq = rq_of_dl_rq(dl_rq);
> +	u64 dl_runtime = pi_se->dl_runtime;
>  
> -	WARN_ON_ONCE(pi_of(dl_se)->dl_runtime <= 0);
> +	WARN_ON_ONCE(dl_runtime <= 0);
>  
>  	/*
>  	 * This could be the case for a !-dl task that is boosted.
> @@ -851,10 +853,13 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
>  	 * arbitrary large.
>  	 */
>  	while (dl_se->runtime <= 0) {
> -		dl_se->deadline += pi_of(dl_se)->dl_period;
> -		dl_se->runtime += pi_of(dl_se)->dl_runtime;
> +		dl_se->deadline += pi_se->dl_period;
> +		dl_se->runtime += dl_runtime;
>  	}
>  
> +	if (dl_se->zerolax && dl_se->runtime > dl_runtime)
> +		dl_se->runtime = dl_runtime;
> +

Anyway, I have the impression that this breaks EDF/CBS, as we are letting
the dl_server run with full dl_runtime w/o postponing the period
(essentially an u = 1 reservation until runtime is depleted).

I would say we need to either do

dl_se->deadline += pi_of(dl_se)->dl_period;
dl_se->runtime = pi_of(dl_se)->dl_runtime;

or (as Daniel proposed)

dl_se->deadline = rq_clock(rq) + pi_of(dl_se)->dl_deadline;
dl_se->runtime = pi_of(dl_se)->dl_runtime;

and I seem to be inclined towards the latter, as the former would
essentially reduce dl_server bandwidth under dl_runtime/dl_period at
times.

Best,
Juri

