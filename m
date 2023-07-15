Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE4C75458F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 02:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjGOAB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 20:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjGOAB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 20:01:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0CF1BFA
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 17:01:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3297D61152
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 00:01:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC96C433C8;
        Sat, 15 Jul 2023 00:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689379314;
        bh=48z9z9MmpXB6cr2JS9/1wpOyf340RvMqtEV/mvOeGk4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HtiCKLWtwsdwvqkDrLAi/4oAfTRZ3TKJ19fLMfeH2XAvpgEUHEc4yMP4z0T080prY
         4+2AbU/WTu+smvT+ApJUV/o3UKDXi6JU/s7Y984SNc5P60s2KDCPVEMJdLOHPitQ/z
         7vUHYm6spzLOtrT23SSaafWeybdDpVcBA3SY3H529yw603nsjPdjzrK1aF1xhsSQca
         OxRiyZNN5683hpl68ZfvUG5PYYDRLS9VD5cnG5+sWjVjF/rSpH3fF2G9Jn7/V+pZON
         Qdc4OJ2/8tmMdMf8RvsphBeXpiqQ1ZGmw+pRUn22Bo0yWbJVSY2W5eb+ta2jYm/+iD
         NM52xWooaXwRg==
Date:   Sat, 15 Jul 2023 02:01:51 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] tick/nohz: Don't shutdown the lowres tick from itself
Message-ID: <ZLHh71KIIioR85aa@lothringen>
References: <20230714120852.23573-1-frederic@kernel.org>
 <20230714120852.23573-4-frederic@kernel.org>
 <9347e3d4-e774-f75f-22c4-6c2dba294423@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9347e3d4-e774-f75f-22c4-6c2dba294423@joelfernandes.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 02:44:49PM -0400, Joel Fernandes wrote:
> On 7/14/23 08:08, Frederic Weisbecker wrote:
> One slight concern here though, where in the idle loop is the removed
> statement "tick_program_event(KTIME_MAX, 1);" happening if the tick was
> already stopped before? If it is happening in tick_nohz_stop_tick(), don't
> we early return from there and avoid doing that
> "tick_program_event(KTIME_MAX, 1);" altogether, if the tick was already
> stopped and the next event has not changed?
> 
>         /* Skip reprogram of event if its not changed */
>         if (ts->tick_stopped && (expires == ts->next_tick)) {
>                 /* Sanity check: make sure clockevent is actually programmed */
>                 if (tick == KTIME_MAX || ts->next_tick ==  [...]
>                         return;
> 		[...]
> 	}

Sure, if tick_program_event(KTIME_MAX, 1) was already called in the
previous idle loop iteration, then there is no need to call that again.

Or am I missing something else?

> 
> Also just a nit, here you can remove indent by doing:
> 
> if (unlikely(ts->tick_stopped))
>     return;
> hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
> tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
> 
> Which is pretty much the original code except for the tick_program_event().

Either I remove an indent or I remove a statement. I guess it's a matter of
personal taste. I don't mind either way :-)

Thanks.

