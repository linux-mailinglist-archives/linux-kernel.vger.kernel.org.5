Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1303B790191
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 19:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243739AbjIARpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 13:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjIARph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 13:45:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD89CF3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 10:45:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 98EEB21860;
        Fri,  1 Sep 2023 17:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693590332;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2WDV4cZI/jGkvW0HxPF8zZMCvY6ntoMZAhWO84hyr8Y=;
        b=YJu8K2C7XqqD0qr1QQ8wVPUgIRKeZOKaV9uURNsWJhcaYMl/4jgMnH7TelwbjbPUANbeK8
        QUn+koWGjrrUbe8bKbIq1SaBqRW/0TpVeIpFTBmW6/5Jq+Qe6fu3aMJYsHCoKrM9EBB/bl
        X0l4a0XJ5f7Y5hcbBEbWJ30t0jpfWbM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693590332;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2WDV4cZI/jGkvW0HxPF8zZMCvY6ntoMZAhWO84hyr8Y=;
        b=W1NtcSpx1em5TyQsHqWeSQ1ELONwon02RO5/A3RYlDPt0JFM9W8PVpZ41KqdRf0JFx21yt
        MxhnCvvgG3AnLjDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 777811358B;
        Fri,  1 Sep 2023 17:45:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /lnIGjsj8mQNPgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 01 Sep 2023 17:45:31 +0000
Date:   Fri, 1 Sep 2023 19:45:29 +0200
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
        linux-kernel@vger.kernel.org, ltp@lists.linux.it
Subject: Re: [LTP] [PATCH] sched/rt: Disallow writing invalid values to
 sched_rt_period_us
Message-ID: <20230901174529.GB364687@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20230901154355.5351-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901154355.5351-1-chrubis@suse.cz>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The validation of the value written to sched_rt_period_us was broken
> because:

> - the sysclt_sched_rt_period is declared as unsigned int
> - parsed by proc_do_intvec()
> - the range is asserted after the value parsed by proc_do_intvec()

> Because of this negative values written to the file were written into a
> unsigned integer that were later on interpreted as large positive
> integers which did passed the check:

> if (sysclt_sched_rt_period <= 0)
> 	return EINVAL;

> This commit fixes the parsing by setting explicit range for both
> perid_us and runtime_us into the sched_rt_sysctls table and processes
> the values with proc_dointvec_minmax() instead.

> Alternatively if we wanted to use full range of unsigned int for the
> period value we would have to split the proc_handler and use
> proc_douintvec() for it however even the
> Documentation/scheduller/sched-rt-group.rst describes the range as 1 to
> INT_MAX.

> As far as I can tell the only problem this causes is that the sysctl
> file allows writing negative values which when read back may confuse
> userspace.

> There is also a LTP test being submitted for these sysctl files at:

> http://patchwork.ozlabs.org/project/ltp/patch/20230901144433.2526-1-chrubis@suse.cz/

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  kernel/sched/rt.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 0597ba0f85ff..aed3d55de2dd 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -37,6 +37,8 @@ static struct ctl_table sched_rt_sysctls[] = {
>  		.maxlen         = sizeof(unsigned int),
>  		.mode           = 0644,
>  		.proc_handler   = sched_rt_handler,
> +		.extra1         = SYSCTL_ONE,
> +		.extra2         = SYSCTL_INT_MAX,
>  	},
>  	{
>  		.procname       = "sched_rt_runtime_us",
> @@ -44,6 +46,8 @@ static struct ctl_table sched_rt_sysctls[] = {
>  		.maxlen         = sizeof(int),
>  		.mode           = 0644,
>  		.proc_handler   = sched_rt_handler,
> +		.extra1         = SYSCTL_NEG_ONE,
> +		.extra2         = SYSCTL_INT_MAX,
Documentation/scheduller/sched-rt-group.rst [1] specifies this as values from -1 to
(INT_MAX - 1), I guess due int range. Looking into proc_dointvec_minmax() [2]
even INT_MAX would pass the check. I suppose we can do nothing about that,
because there is no value in sysctl_vals[] which would represent INT_MAX - 1.

And you specify in LTP test range: from -1 to INT_MAX.

But even much shorter value than INT_MAX fails:

$ echo 1234567 > /proc/sys/kernel/sched_rt_runtime_us
sh: echo: write error: Invalid argument

Ranges in /proc/sys/kernel/sched_rt_period_us works as expected.

[1] https://www.kernel.org/doc/html/latest/scheduler/sched-rt-group.html#system-wide-settings
[2] https://elixir.bootlin.com/linux/latest/source/kernel/sysctl.c#L843

>  	},
>  	{
>  		.procname       = "sched_rr_timeslice_ms",
> @@ -2985,9 +2989,6 @@ static int sched_rt_global_constraints(void)
>  #ifdef CONFIG_SYSCTL
>  static int sched_rt_global_validate(void)
>  {
> -	if (sysctl_sched_rt_period <= 0)
> -		return -EINVAL;
> -
>  	if ((sysctl_sched_rt_runtime != RUNTIME_INF) &&
>  		((sysctl_sched_rt_runtime > sysctl_sched_rt_period) ||
>  		 ((u64)sysctl_sched_rt_runtime *
> @@ -3018,7 +3019,7 @@ static int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
>  	old_period = sysctl_sched_rt_period;
>  	old_runtime = sysctl_sched_rt_runtime;

> -	ret = proc_dointvec(table, write, buffer, lenp, ppos);
> +	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);

>  	if (!ret && write) {
>  		ret = sched_rt_global_validate();
