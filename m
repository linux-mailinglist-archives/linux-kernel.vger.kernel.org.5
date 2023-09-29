Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63907B2DDD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 10:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbjI2IcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 04:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbjI2Ibw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 04:31:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011BBCEC
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 01:31:43 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 83B3B218E9;
        Fri, 29 Sep 2023 08:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695976302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VQ4i7GMFX0Wcbqf7uT/UkMLF7aH0vc6JCn27kk7fT1o=;
        b=kOSb50xZLelbJ8FkUQIcqKkPi+P0Ft3h4cvJDz9Rt7AOrDj+xM84gphsAmvjRF+XtJxSz2
        pLdFRNb3XiJz+cIk25rayru4CSNLaH9yfvDbaQHvmS7s3eYBdeplZ/V1gBfaTJ8t//3l0d
        bxce4fIk7Q0IdfW0m1S7KxS+XQ8It3k=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1D4722C142;
        Fri, 29 Sep 2023 08:31:42 +0000 (UTC)
Date:   Fri, 29 Sep 2023 10:31:41 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH printk v2 11/11] lockdep: Add atomic write enforcement
 for lockdep splats
Message-ID: <ZRaLbUHStnPAGAjR@alley>
References: <20230919230856.661435-1-john.ogness@linutronix.de>
 <20230919230856.661435-12-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919230856.661435-12-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-09-20 01:14:56, John Ogness wrote:
> Invoke the atomic write enforcement functions for lockdep
> splats to ensure that the information gets out to the consoles.
> 
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -3967,9 +3968,13 @@ static void
>  print_usage_bug(struct task_struct *curr, struct held_lock *this,
>  		enum lock_usage_bit prev_bit, enum lock_usage_bit new_bit)
>  {
> +	enum nbcon_prio prev_prio;
> +
>  	if (!debug_locks_off() || debug_locks_silent)
>  		return;
>  
> +	prev_prio = nbcon_atomic_enter(NBCON_PRIO_EMERGENCY);
> +
>  	pr_warn("\n");
>  	pr_warn("================================\n");
>  	pr_warn("WARNING: inconsistent lock state\n");
> @@ -3998,6 +4003,8 @@ print_usage_bug(struct task_struct *curr, struct held_lock *this,
>  
>  	pr_warn("\nstack backtrace:\n");
>  	dump_stack();
> +
> +	nbcon_atomic_exit(NBCON_PRIO_EMERGENCY, prev_prio);
>  }

The location of the emergency context looks good. I have just proposed
another way for tracking the emergency context. It would allow to
call nbcon_emergency_enter()/exit() without any parameter,
see https://lore.kernel.org/r/ZRLBxsXPCym2NC5Q@alley

Best Regards,
Petr
