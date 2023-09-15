Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636817A1AD3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbjIOJkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbjIOJkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:40:05 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC4B2105
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R244OAVYC7tNAKMEhuS6kh2LVOae3N+9/6Hn1T0tkIQ=; b=G8hK4HBq5QEtSvcVs5SpKS8Lcf
        LrwLYtrVYR4yiWkYCM5Bj4cXJr8pSUw1P4K9uTL7NgH4M9+lEFVBLZxb4HKiD6gLqClBoU37sTkmI
        iyXU+mTGILIswDxKT+FerVsmC5Sa4/heE+j/nqyNw6QVxM017ETO/BuFBLKUSjmvf6lQDi2i1w4EN
        7txBYBl2rDXthazUWK2CAoBlkSjYZmWM1Tp66AdRgI0RMQfMJvXbMmoDXhlHBfuNWaP/R4KVmjIrC
        ZwFRv3qxX21PN4RXMfMghBmhpUFwkzAx+HiVvC/SzdvGzkpZZaeJFHNWH2nSgJgGF7ucEDvAqInjC
        utezs8Ww==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qh5Hq-008wIu-22;
        Fri, 15 Sep 2023 09:38:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id B8CA93003F2; Fri, 15 Sep 2023 11:38:55 +0200 (CEST)
Date:   Fri, 15 Sep 2023 11:38:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] panic: Reenable preemption in WARN slowpath
Message-ID: <20230915093855.GB6743@noisy.programming.kicks-ass.net>
References: <3ec48fde01e4ee6505f77908ba351bad200ae3d1.1694763684.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ec48fde01e4ee6505f77908ba351bad200ae3d1.1694763684.git.lukas@wunner.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 09:55:39AM +0200, Lukas Wunner wrote:
> Commit 5a5d7e9badd2 ("cpuidle: lib/bug: Disable rcu_is_watching() during
> WARN/BUG") amended warn_slowpath_fmt() to disable preemption until the
> WARN splat has been emitted.
> 
> However the commit neglected to reenable preemption in the !fmt codepath,
> i.e. when a WARN splat is emitted without additional format string.
> 
> One consequence is that users may see more splats than intended.  E.g. a
> WARN splat emitted in a work item results in at least two extra splats:
> 
>   BUG: workqueue leaked lock or atomic
>   (emitted by process_one_work())
> 
>   BUG: scheduling while atomic
>   (emitted by worker_thread() -> schedule())
> 
> Ironically the point of the commit was to *avoid* extra splats. ;)
> 
> Fix it.
> 
> Fixes: 5a5d7e9badd2 ("cpuidle: lib/bug: Disable rcu_is_watching() during WARN/BUG")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v6.1+
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
> The original commit went in through the tip tree, hence submitting to
> tip maintainers.  The commit was backported to v6.1-stable (even though
> it wasn't tagged for stable), hence this fix needs a stable designation.
> 
>  kernel/panic.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 07239d4..ffa037fa 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -697,6 +697,7 @@ void warn_slowpath_fmt(const char *file, int line, unsigned taint,
>  	if (!fmt) {
>  		__warn(file, line, __builtin_return_address(0), taint,
>  		       NULL, NULL);
> +		warn_rcu_exit(rcu);
>  		return;
>  	}

Urgh, thanks!
