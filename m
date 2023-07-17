Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F28B756924
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjGQQ37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjGQQ3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:29:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE0C1B6;
        Mon, 17 Jul 2023 09:29:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE16661155;
        Mon, 17 Jul 2023 16:29:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2FBC433C7;
        Mon, 17 Jul 2023 16:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689611382;
        bh=caz2XbEJt91Q9GaRlQpaWMJ4zxXZhHkp8Rizzu85iLI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=O5e3/lQoThiujvGOHB53OlqJzetexeIcHTaGXJoBGOD91jOEvy2RsE6Rtv3Pxb5SV
         FdLQZ/KyWId9J+wekwcQuWLoykZ0fEGmMqmTCfDFXiilYU2fyISMigNUZYy7MbX6We
         i0CtJytivhOF9yoaqNm4pMTIN3Sjnr1W+/v315zELpD3B9hRBlvjz0Kjb6Fls1xU6m
         7akGgELlX5ZhNKLETGD5eIUqdkPfBWiwy939LGWER7WZAiHrL6hy0OGkTA6vMSI0K8
         19uhkDh+jmYxyiSwfuV4DecVlsX4mZUjxraMuf+LQ5NEWnPxFIEWCcp+lhcfjW6jU0
         A4MNrfsnkkP9Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D65B2CE03F1; Mon, 17 Jul 2023 09:29:41 -0700 (PDT)
Date:   Mon, 17 Jul 2023 09:29:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] rcu: Don't dump the stalled CPU on where RCU GP
 kthread last ran twice
Message-ID: <4595d31f-8e0b-4183-967d-1a439b297889@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230712151557.760-1-thunder.leizhen@huawei.com>
 <20230712151557.760-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712151557.760-3-thunder.leizhen@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 11:15:57PM +0800, Zhen Lei wrote:
> The stacks of all stalled CPUs will be dumped in rcu_dump_cpu_stacks().
> If the CPU on where RCU GP kthread last ran is stalled, its stack does
> not need to be dumped again. We can search the corresponding backtrace
> based on the printed CPU ID.
> 
> For example:
> [   87.328275] rcu: rcu_sched kthread starved for ... ->cpu=3  <--------|
> ... ...                                                                 |
> [   89.385007] NMI backtrace for cpu 3                         <--------|
> [   89.385179] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 5.10.0+ #22 <--|
> [   89.385188] Hardware name: linux,dummy-virt (DT)
> [   89.385196] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
> [   89.385204] pc : arch_cpu_idle+0x40/0xc0
> [   89.385211] lr : arch_cpu_idle+0x2c/0xc0
> ... ...
> [   89.385566] Call trace:
> [   89.385574]  arch_cpu_idle+0x40/0xc0
> [   89.385581]  default_idle_call+0x100/0x450
> [   89.385589]  cpuidle_idle_call+0x2f8/0x460
> [   89.385596]  do_idle+0x1dc/0x3d0
> [   89.385604]  cpu_startup_entry+0x5c/0xb0
> [   89.385613]  secondary_start_kernel+0x35c/0x520
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

I queued both patches, thank you both!

							Thanx, Paul

> ---
>  kernel/rcu/tree_stall.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index dcfaa3d5db2cbc7..cc884cd49e026a3 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -534,12 +534,14 @@ static void rcu_check_gp_kthread_starvation(void)
>  		       data_race(READ_ONCE(rcu_state.gp_state)),
>  		       gpk ? data_race(READ_ONCE(gpk->__state)) : ~0, cpu);
>  		if (gpk) {
> +			struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> +
>  			pr_err("\tUnless %s kthread gets sufficient CPU time, OOM is now expected behavior.\n", rcu_state.name);
>  			pr_err("RCU grace-period kthread stack dump:\n");
>  			sched_show_task(gpk);
>  			if (cpu_is_offline(cpu)) {
>  				pr_err("RCU GP kthread last ran on offline CPU %d.\n", cpu);
> -			} else  {
> +			} else if (!(data_race(READ_ONCE(rdp->mynode->qsmask)) & rdp->grpmask)) {
>  				pr_err("Stack dump where RCU GP kthread last ran:\n");
>  				dump_cpu_task(cpu);
>  			}
> -- 
> 2.25.1
> 
