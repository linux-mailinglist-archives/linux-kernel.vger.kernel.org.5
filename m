Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27E37DA9A1
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 23:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjJ1VaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 17:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1VaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 17:30:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0F2CA;
        Sat, 28 Oct 2023 14:30:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95391C433C8;
        Sat, 28 Oct 2023 21:30:07 +0000 (UTC)
Date:   Sat, 28 Oct 2023 17:30:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH] refscale: Optimize process_durations()
Message-ID: <20231028173005.5d266f7a@rorschach.local.home>
In-Reply-To: <bbbab32e3e104bdc2238724a6a4a85e539f49ddd.1698512661.git.christophe.jaillet@wanadoo.fr>
References: <bbbab32e3e104bdc2238724a6a4a85e539f49ddd.1698512661.git.christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Oct 2023 19:04:44 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> process_durations() is not a hot path, but there is no good reason to
> iterate over and over the data already in 'buf'.
> 
> Using a seq_buf saves some useless strcat() and the need of a temp buffer.
> Data is written directly at the correct place.
> 

Agreed.

> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  kernel/rcu/refscale.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
> index 2c2648a3ad30..861485d865ec 100644
> --- a/kernel/rcu/refscale.c
> +++ b/kernel/rcu/refscale.c
> @@ -28,6 +28,7 @@
>  #include <linux/rcupdate_trace.h>
>  #include <linux/reboot.h>
>  #include <linux/sched.h>
> +#include <linux/seq_buf.h>
>  #include <linux/spinlock.h>
>  #include <linux/smp.h>
>  #include <linux/stat.h>
> @@ -890,31 +891,36 @@ static u64 process_durations(int n)
>  {
>  	int i;
>  	struct reader_task *rt;
> -	char buf1[64];
> +	struct seq_buf s;
>  	char *buf;
>  	u64 sum = 0;
>  
>  	buf = kmalloc(800 + 64, GFP_KERNEL);
>  	if (!buf)
>  		return 0;
> -	buf[0] = 0;
> +
> +	seq_buf_init(&s, buf, 800 + 64);
> +
>  	sprintf(buf, "Experiment #%d (Format: <THREAD-NUM>:<Total loop time in ns>)",
>  		exp_idx);
>  
>  	for (i = 0; i < n && !torture_must_stop(); i++) {
>  		rt = &(reader_tasks[i]);
> -		sprintf(buf1, "%d: %llu\t", i, rt->last_duration_ns);
>  
>  		if (i % 5 == 0)
> -			strcat(buf, "\n");
> -		if (strlen(buf) >= 800) {
> +			seq_buf_putc(&s, '\n');

I was confused here thinking it was originally adding a '\n' to buf1 on
i % 5, but it's adding it to buf!

Yeah, using seq_buf is much less confusing and then less error prone.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve


> +
> +		if (seq_buf_used(&s) >= 800) {
> +			seq_buf_terminate(&s);
>  			pr_alert("%s", buf);
> -			buf[0] = 0;
> +			seq_buf_clear(&s);
>  		}
> -		strcat(buf, buf1);
> +
> +		seq_buf_printf(&s, "%d: %llu\t", i, rt->last_duration_ns);
>  
>  		sum += rt->last_duration_ns;
>  	}
> +	seq_buf_terminate(&s);
>  	pr_alert("%s\n", buf);
>  
>  	kfree(buf);

