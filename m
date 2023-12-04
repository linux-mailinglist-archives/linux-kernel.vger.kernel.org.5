Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE417803C16
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjLDRwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjLDRwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:52:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047E2119
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:52:49 -0800 (PST)
Date:   Mon, 4 Dec 2023 18:52:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701712368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=glKbnxxwCXhUDZregwQm9CMF28tfdZZf41aiv7xKBeE=;
        b=AyKVjv+ybgBrVJdhxTxe5xeDV+C2F3xLJKAZ0ZOdfd3IFRR7nKSmRvVmZSUFPBa2DGIl3c
        Xd0forYphoRjecepKA8xxySmYk216dPmwvne/iGmv/PrMDPhkvzSjb2pnaBhKfLPsB9iOE
        /Y5nmWO/YkEZJu1bp/xQmP+SeN2BzekeV5tlY0NXY/w43FqdMS1x8AZ0PZsayaziEPbBh/
        2Rmi0UbZSCQbk5cj6I8VRFRvn4+O7X5mPqOeY4sAbX3uqQq/HrU0jnZDN7mAL/MDHgf5Cw
        lKosyHWH3iwGOIqRBYj3+TZ+UaBQqxO2szSQGDbFZNxRLImOFgQ+4+0sDL5Teg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701712368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=glKbnxxwCXhUDZregwQm9CMF28tfdZZf41aiv7xKBeE=;
        b=XJEZvFr5g0pisYqDApibVBx27ym1jjGIUnglNwZK87lrJh1VRtFSxd3DpQzJS/vku34aIF
        Ylk9jayTODpUbdBg==
From:   Sebastian Siewior <bigeasy@linutronix.de>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v9 16/32] timers: Optimization for
 timer_base_try_to_set_idle()
Message-ID: <20231204175246.J_8wNRQp@linutronix.de>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
 <20231201092654.34614-17-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231201092654.34614-17-anna-maria@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-01 10:26:38 [+0100], Anna-Maria Behnsen wrote:
> When tick is stopped also the timer base is_idle flag is set. When
> reentering the timer_base_try_to_set_idle() with the tick stopped, there is
> no need to check whether the timer base needs to be set idle again. When a
> timer was enqueued in the meantime, this is already handled by the
> nohz_get_next_event() call which was executed before tick_nohz_stop_tick().

as of #15 tick_stopped is set later in tick_nohz_stop_tick() and both
(tick_sched::tick_stopped and timer_base::is_idle) are cleared in
tick_nohz_restart_sched_tick().

Then we have tick_nohz_idle_retain_tick() with only one caller and is
only clearing timer_base::is_idle. Now, wouldn't it make sense to
preload timer_idle based on timer_base::is_idle?

I don't know if it there is a different outcome if timer_base::is_idle
gets cleared in the idle path vs tick_sched::tick_stopped.
I can't find nohz_get_next_event().

> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Sebastian
