Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D776786385
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 00:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238727AbjHWWl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 18:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238732AbjHWWly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 18:41:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1224A8;
        Wed, 23 Aug 2023 15:41:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68977639B7;
        Wed, 23 Aug 2023 22:41:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87774C433C7;
        Wed, 23 Aug 2023 22:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692830511;
        bh=cpYns5b/CYfIc8QySiU/wyHC3JAZ3tIGEtbjDhJvsIg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hKpSYu6Oss1EQCWNhJzlhEeCSr58X84DlBgFgZ5Mlv3FZOwTdNOT38ju05QJuthqB
         TszbAeK4k67oezIaMaOH8X7WWUvM4R7IPQ8+2EC/o1zRWOZs/niQ4hyKevIvIDd1Iq
         A2OW50mZDccVPmm1ZGmxkbkohr6ttPFm3Exw5BxGZncrv7hE/T8WPExX6I+pr70dvb
         9LsQTzhQvIZqYqjwQ1InGuzv4TMXy/PI1xBkXis+hJy9+K9/uJDXEU5bwJIADUZSLJ
         XWdRNsZNKcltP1kEFJn66c/cgM6fnk4TCoMtSaIUDeh/IFKilgh9O9eKHfI9H1mjFf
         He9sSFt1rCoKQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 10FECCE02EE; Wed, 23 Aug 2023 15:41:51 -0700 (PDT)
Date:   Wed, 23 Aug 2023 15:41:51 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Z qiang <qiang.zhang1211@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Binbin Zhou <zhoubinbin@loongson.cn>
Subject: Re: [PATCH V4 2/2] rcu: Update jiffies in rcu_cpu_stall_reset()
Message-ID: <03fe7084-0509-45fa-87ee-8f8705a221a6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAAhV-H6ejw=8afS0jmmQvKUrCw=qZm_P6SA0A+tuvvb8bsq4-Q@mail.gmail.com>
 <5777BD82-2C8D-4BAB-BDD3-C2C003DC57FB@joelfernandes.org>
 <CAAhV-H58OpQJapV7LDNjZ-vM7nNJrwdkBiPjFcCutO1yRsUshQ@mail.gmail.com>
 <87ttspct76.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ttspct76.ffs@tglx>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 12:03:25AM +0200, Thomas Gleixner wrote:
> On Thu, Aug 17 2023 at 16:06, Huacai Chen wrote:
> > On Thu, Aug 17, 2023 at 3:27 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> >> > If  do_update_jiffies_64() cannot be used in NMI context,
> >>
> >> Can you not make the jiffies update conditional on whether it is
> >> called within NMI context?
> 
> Which solves what? If KGDB has a breakpoint in the jiffies lock held
> region then you still dead lock.
> 
> >> I dislike that..
> > Is this acceptable?
> >
> > void rcu_cpu_stall_reset(void)
> > {
> >         unsigned long delta;
> >
> >         delta = nsecs_to_jiffies(ktime_get_ns() - ktime_get_coarse_ns());
> >
> >         WRITE_ONCE(rcu_state.jiffies_stall,
> >                    jiffies + delta + rcu_jiffies_till_stall_check());
> > }
> >
> > This can update jiffies_stall without updating jiffies (but has the
> > same effect).
> 
> Now you traded the potential dead lock on jiffies lock for a potential
> live lock vs. tk_core.seq. Not really an improvement, right?
> 
> The only way you can do the above is something like the incomplete and
> uncompiled below. NMI safe and therefore livelock proof time interfaces
> exist for a reason.

Just for completeness, another approach, with its own advantages
and disadvantage, is to add something like ULONG_MAX/4 to
rcu_state.jiffies_stall, but also set a counter indicating that this
has been done.  Then RCU's force-quiescent processing could decrement
that counter (if non-zero) and reset rcu_state.jiffies_stall when it
does reach zero.

Setting the counter to three should cover most cases, but "live by the
heuristic, die by the heuristic".  ;-)

It would be good to have some indication when gdb exited, but things
like the gdb "next" command can make that "interesting" when applied to
a long-running function.

 							Thanx, Paul

> Thanks,
> 
>         tglx
> ---
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -51,6 +51,13 @@ struct tick_sched *tick_get_tick_sched(i
>   */
>  static ktime_t last_jiffies_update;
>  
> +unsigned long tick_estimate_stale_jiffies(void)
> +{
> +	ktime_t delta = ktime_get_mono_fast_ns() - READ_ONCE(last_jiffies_update);
> +
> +	return delta < 0 ? 0 : div_s64(delta, TICK_NSEC);
> +}
> +
>  /*
>   * Must be called with interrupts disabled !
>   */
> 
> 
