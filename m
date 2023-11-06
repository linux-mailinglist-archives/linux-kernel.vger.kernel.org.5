Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12E87E26B7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjKFOY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 09:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbjKFOYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:24:55 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A88BD49
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 06:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ru6akWdDI9qjF0C1ZdQG8GZxuKhYDPwGk6ba5A7x1CA=; b=PxqlT8UHec1fHIpMhVTMPPCBcK
        nh07BatdHfqbJ/ViFgutWH8OnFxL+htc5mE6/U238dsRYrg56dZDA+TFfzuPmljxH2B7bK041NYLm
        4uNneNjHZlTy3t5LPKLvxx+DbhzrmOjoeiGRiHxRlX68QjH11G+T/GoxT2gIyz0N3TCi4K4g2byfC
        F/FWVhZx9W/vzKqSXs7lTf+3kSCFt+0cDhUb0uBnN1QAVwo4ZAMV01Q2M9pwR0ynDQjQtixrSyAZf
        aRnTjNWZZfkghbTjKNmEJU2yCGeJWEJy3UvyY5dzh4+MW0mRprYI1RsmGPDwH+X9t9UjgtKYr77m6
        e0wd3N/Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r00Wk-00Aa2M-2h;
        Mon, 06 Nov 2023 14:24:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7B14230049D; Mon,  6 Nov 2023 15:24:30 +0100 (CET)
Date:   Mon, 6 Nov 2023 15:24:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v5 5/7] sched/fair: Add trivial fair server
Message-ID: <20231106142430.GF3818@noisy.programming.kicks-ass.net>
References: <cover.1699095159.git.bristot@kernel.org>
 <4e0d14eb6e0ec33055197ac7ddb57ef7ab3894a5.1699095159.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e0d14eb6e0ec33055197ac7ddb57ef7ab3894a5.1699095159.git.bristot@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2023 at 11:59:22AM +0100, Daniel Bristot de Oliveira wrote:

> [ dl_server do not account for rt ]

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 541d547e1019..1d7b96ca9011 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1382,6 +1382,13 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
>  			resched_curr(rq);
>  	}
>  
> +	/*
> +	 * The fair server (sole dl_server) does not account for real-time
> +	 * workload because it is running fair work.
> +	 */
> +	if (dl_server(dl_se))
> +		return;
> +
>  	/*
>  	 * Because -- for now -- we share the rt bandwidth, we need to
>  	 * account our runtime there too, otherwise actual rt tasks

Should we perhaps write this like so?

	if (dl_se == &rq->fair_server)
		return;

