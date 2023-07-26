Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00FE76342E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 12:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjGZKrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 06:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbjGZKrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 06:47:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538A4E63
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 03:47:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B63BE61A6A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 10:47:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E210C433C7;
        Wed, 26 Jul 2023 10:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690368459;
        bh=lq4pZ8INO+UH6l03TMi+2aIxYKEFFb1nihjG0kRG97A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rnOAttRWXvju9ATEfORudAXg5mXx0DYJAo4BbW9wdqCqNb1cGzgen63uy+pwQX6GT
         rnzbv7253qOuppPXtbBpOFKOWHCkXkEpPeYs85Pr7zgK6ivrxTBl31uLLdeAIhQdx2
         U3heifqKXUQ4obTgCTd4xGOcTL4n4cy2Gcp/ozDSMZG3AeHjPkUYUDbPnF+qJf76u/
         PqrhEiC/trkOi+FkahJaXXgzJGA+qN7moKmQQOy5q2YV9Nz4IDwuiL8g133C2ykFU3
         nsz0pS3cRzD7yJxyhNh4Dldvqhf7VVdv7JE9JkUd8vIGOWebAs2XAl46oiFI4aAD7j
         E/W+B4X4Q8tqQ==
Date:   Wed, 26 Jul 2023 12:47:35 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: Re: Stopping the tick on a fully loaded system
Message-ID: <ZMD5xyxPUkKCDlVQ@localhost.localdomain>
References: <80956e8f-761e-b74-1c7a-3966f9e8d934@linutronix.de>
 <CAKfTPtCSsLz+qD-xUnm4N1HyZqtQD+rYVagnSur+hfUHEk0sYg@mail.gmail.com>
 <ad370ab-5694-d6e4-c888-72bdc635824@linutronix.de>
 <ZL2Z8InSLmI5GU9L@localhost.localdomain>
 <CAJZ5v0ib=j+DHVE1mKCZaoyZ_CHVkA9f90v8b8wSA+3TEG1kHg@mail.gmail.com>
 <8857d035-1c1a-27dd-35cf-7ff68bbf3119@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8857d035-1c1a-27dd-35cf-7ff68bbf3119@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, Jul 25, 2023 at 03:07:05PM +0200, Anna-Maria Behnsen a écrit :
> The worst case scenario will not happen, because remote timer expiry only
> happens when CPU is not active in the hierarchy. And with your proposal
> this is valid after tick_nohz_stop_tick().
> 
> Nevertheless, I see some problems with this. But this also depends if there
> is the need to change current idle behavior or not. Right now, this are my
> concerns:
> 
> - The determinism of tick_nohz_next_event() will break: The return of
>   tick_nohz_next_event() will not take into account, if it is the last CPU
>   going idle and then has to take care of remote timers. So the first timer
>   of the CPU (regardless of global or local) has to be handed back even if
>   it could be handled by the hierarchy.

Bah, of course...

> 
> - When moving the tmigr_cpu_deactivate() to tick_nohz_stop_tick() and the
>   return value of tmigr_cpu_deactivate() is before the ts->next_tick, the
>   expiry has to be modified in tick_nohz_stop_tick().
> 
> - The load is simply moved to a later place - tick_nohz_stop_tick() is
>   never called without a preceding tick_nohz_next_event() call. Yes,
>   tick_nohz_next_event() is called under load ~8% more than
>   tick_nohz_stop_tick(), but the 'quality' of the return value of
>   tick_nohz_next_event() is getting worse.
> 
> - timer migration hierarchy is not a standalone timer infrastructure. It
>   only makes sense to handle it in combination with the existing timer
>   wheel. When the timer base is idle, the timer migration hierarchy with
>   the migrators will do the job for global timers. So, I'm not sure about
>   the impact of the changed locking - but I'm pretty sure changing that
>   increases the probability for ugly races hidden somewhere between the
>   lines.

Sure thing, and this won't be pretty.

> 
> Thanks,
> 
> 	Anna-Maria

