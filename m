Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4064E759413
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 13:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjGSLVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 07:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjGSLVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 07:21:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF59189
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 04:21:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1D0B71FE99;
        Wed, 19 Jul 2023 11:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689765699;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CL6zWa7lw7sIuV2Jg643OeYAj2G6p2CpNAc2SRUEpQ8=;
        b=1CeUjh5s3vg1cFto/9ZDbGCTVdszTdb/M+tyhGlUQxwvsrB8AHvVrFT7t5WkeyxY0hQwDH
        1t/iQvOl8+shHCgyHbeepkTM2rThTHED33laTdjpendMjC6DxEp+xbkf41s6Y6Q6Nh2Mkw
        Dd7sOfIysAdyMYEDZ0iiP/Nz4l7wUI8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689765699;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CL6zWa7lw7sIuV2Jg643OeYAj2G6p2CpNAc2SRUEpQ8=;
        b=rTA7yFELXf0R91FljTJmH6Wj2AJV4CnHYHQSVTpuCNovMynOp3/G7Zc75oY9bS3RdzAJMa
        qwhG8RM+wOWSBKCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 51B331361C;
        Wed, 19 Jul 2023 11:21:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2mJvEkLHt2S8XQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 19 Jul 2023 11:21:38 +0000
Date:   Wed, 19 Jul 2023 13:21:36 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Jiri Bohac <jbohac@suse.cz>,
        ltp@lists.linux.it, Shile Zhang <shile.zhang@nokia.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>
Subject: Re: [LTP] [PATCH 1/2] sched/rt: Fix sysctl_sched_rr_timeslice intial
 value
Message-ID: <20230719112136.GA1239020@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20230719103743.4775-1-chrubis@suse.cz>
 <20230719103743.4775-2-chrubis@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719103743.4775-2-chrubis@suse.cz>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[ Cc Shile Zhang ]

> Thre is 10% rounding error in the intial value of the
> sysctl_sched_rr_timeslice with  CONFIG_HZ_300=y.

> This was found with LTP test sched_rr_get_interval01:

> sched_rr_get_interval01.c:57: TPASS: sched_rr_get_interval() passed
> sched_rr_get_interval01.c:64: TPASS: Time quantum 0s 99999990ns
> sched_rr_get_interval01.c:72: TFAIL: /proc/sys/kernel/sched_rr_timeslice_ms != 100 got 90
> sched_rr_get_interval01.c:57: TPASS: sched_rr_get_interval() passed
> sched_rr_get_interval01.c:64: TPASS: Time quantum 0s 99999990ns
> sched_rr_get_interval01.c:72: TFAIL: /proc/sys/kernel/sched_rr_timeslice_ms != 100 got 90

> What this test does is to compare the return value from the
> sched_rr_get_interval() and the sched_rr_timeslice_ms sysctl file and
> fails if they do not match.

> The prolem it found is the intial sysctl file value which was computed as:

> static int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;

> which works fine as long as MSEC_PER_SEC is multiple of HZ, however it
> introduces 10% rounding error for CONFIG_HZ_300:

> (MSEC_PER_SEC / HZ) * (100 * HZ / 1000)

> (1000 / 300) * (100 * 300 / 1000)

> 3 * 30 = 90

> This can be easily fixed by reversing the order of the multiplication
> and division. After this fix we get:

> (MSEC_PER_SEC * (100 * HZ / 1000)) / HZ

> (1000 * (100 * 300 / 1000)) / 300

> (1000 * 30) / 300 = 100

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> CC: Jiri Bohac <jbohac@suse.cz>
> ---
>  kernel/sched/rt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 00e0e5074115..185d3d749f6b 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -25,7 +25,7 @@ unsigned int sysctl_sched_rt_period = 1000000;
>  int sysctl_sched_rt_runtime = 950000;

>  #ifdef CONFIG_SYSCTL
> -static int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;
> +static int sysctl_sched_rr_timeslice = (MSEC_PER_SEC * RR_TIMESLICE) / HZ;

It looks like very old bug, from v4.11-rc1. I guess this should go to all stable
and LTS kernels.

Fixes: 975e155ed873 ("sched/rt: Show the 'sched_rr_timeslice' SCHED_RR timeslice tuning knob in milliseconds")

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

>  static int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
>  		size_t *lenp, loff_t *ppos);
>  static int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
