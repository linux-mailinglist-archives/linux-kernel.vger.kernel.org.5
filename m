Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A886277CC2B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236784AbjHOL5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237131AbjHOL4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:56:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5161FE7;
        Tue, 15 Aug 2023 04:55:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 47CED1F38D;
        Tue, 15 Aug 2023 11:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692100451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pt1M7QGWW9eA1A+fqS8YPgpwOF2TukRlUiBvaRgXL+0=;
        b=UDdVeE2vyOyvFbkvlEtE+aQGaofliGaRpuxq0SRjIFjp6T9WSczREqnXoK1WruDHfm8H4+
        txQwVjNFRFt8/wtH0CNHed3I4XvSV14Mp6Zs9Z3Ix3FN5z99+VEodWcTlKOe8LeqEO5iBr
        lDNH4HYRoKdaPKDzEj+t0S1DWVpATwY=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 09BA72C143;
        Tue, 15 Aug 2023 11:54:11 +0000 (UTC)
Date:   Tue, 15 Aug 2023 13:54:07 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Helge Deller <deller@gmx.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] watchdog: Fix lockdep warning
Message-ID: <ZNtnX7m_lHE0u-g1@alley>
References: <ZNZr0mPsIuqKzb5u@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNZr0mPsIuqKzb5u@p100>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding workqueue and lockdep people into Cc.

On Fri 2023-08-11 19:11:46, Helge Deller wrote:
> Fully initialize detector_work work struct to avoid this kernel warning
> when lockdep is enabled:
> 
>  =====================================
>  WARNING: bad unlock balance detected!
>  6.5.0-rc5+ #687 Not tainted
>  -------------------------------------
>  swapper/0/1 is trying to release lock (detector_work) at:
>  [<000000004037e554>] __flush_work+0x60/0x658
>  but there are no more locks to release!
> 
>  other info that might help us debug this:
>  no locks held by swapper/0/1.
> 
>  stack backtrace:
>  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc5+ #687
>  Hardware name: 9000/785/C3700
>  Backtrace:
>   [<0000000041455d5c>] print_unlock_imbalance_bug.part.0+0x20c/0x230
>   [<000000004040d5e8>] lock_release+0x2e8/0x3f8
>   [<000000004037e5cc>] __flush_work+0xd8/0x658
>   [<000000004037eb7c>] flush_work+0x30/0x60
>   [<000000004011f140>] lockup_detector_check+0x54/0x128
>   [<0000000040306430>] do_one_initcall+0x9c/0x408
>   [<0000000040102d44>] kernel_init_freeable+0x688/0x7f0
>   [<000000004146df68>] kernel_init+0x64/0x3a8
>   [<0000000040302020>] ret_from_kernel_thread+0x20/0x28
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> ---
> 
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index be38276a365f..eab0dfcfa3f9 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -1022,5 +1022,6 @@ void __init lockup_detector_init(void)
>  	else
>  		allow_lockup_detector_init_retry = true;
> 
> +	INIT_WORK(&detector_work, lockup_detector_delay_init);
>  	lockup_detector_setup();
>  }

Strange. The work is initialized when declared:

static struct work_struct detector_work __initdata =
		__WORK_INITIALIZER(detector_work, lockup_detector_delay_init);

, which should initialize the lockdep map as well. I would expect
this is enough.

And I do not see this on x86_64 with CONFIG_PROVE_LOCKING=y
on today's Linus' tree. And the flush_work() is always called
from the lockup_detector_check() late init call.

IMHO, it must be a bug somewhere else. Otherwise, many other
users of DECLARE_WORK() or __WORK_INITIALIZER() would have
the same problem.

Or do I miss something?

Best Regards,
Petr
