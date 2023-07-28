Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1736A76625E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 05:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbjG1DWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 23:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjG1DWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 23:22:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F1926AE;
        Thu, 27 Jul 2023 20:22:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A30D161FBA;
        Fri, 28 Jul 2023 03:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ABD7C433C8;
        Fri, 28 Jul 2023 03:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690514527;
        bh=pePRLhloPz4DGnxJGIgPUrkXOZW3z9f15MMNigCf+AE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ZgNThzMN2+YVZIpTDtIJk1ju7SvUJq7OeeMMUiGKAZksuIHYr42ZrgSTuFsI3nr8H
         Ny/2mioMaJz8spo/ukf+try9J4nILwWrmePuAXvhdQht0LV5+ySPW3dxOdhbDa3KAJ
         ZURdd+1GO70TLoQTP4Bl/Px0N/2TMMeGnyA/87HkrMk4my8YCGqJL557N9nWUvtFVz
         3Sy4TS3h1+n2lFn9wU381HhEKeTiMY1kFx1Rtsohmj01gaeh4ck6QkW3Yv87Lm+zjF
         kvzPBdawV27OzWPLTaljNmjSKOnN9WRcRCRS8MycZs+dAAMtavhjimoAa7xHqfJgBK
         Sp6JvgYfXi0dQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9F6BBCE0AD7; Thu, 27 Jul 2023 20:22:06 -0700 (PDT)
Date:   Thu, 27 Jul 2023 20:22:06 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        kernel-team@android.com, John Stultz <jstultz@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH rcu 3/9] torture: Add lock_torture_writer_fifo module
 param
Message-ID: <12d34340-6c94-4bfd-aa16-3c39026070d8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <bca717ca-a83a-4540-80ec-732c12623d2d@paulmck-laptop>
 <20230717182042.1098651-3-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717182042.1098651-3-paulmck@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 11:20:36AM -0700, Paul E. McKenney wrote:
> From: Dietmar Eggemann <dietmar.eggemann@arm.com>
> 
> Modifies locktorture writer to run as RT task.
> 
> To use it:
> insmod /lib/modules/torture.ko random_shuffle=1 lock_torture_writer_fifo=1
>                                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^
> insmod /lib/modules/locktorture.ko torture_type=mutex_lock rt_boost=1 rt_boost_factor=50 nested_locks=3
> 
> This patch has been helpful to uncover issues with the proxy-execution
> series.
> 
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: kernel-team@android.com
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> [jstultz: Include header change to build, reword commit message]
> Signed-off-by: John Stultz <jstultz@google.com>
> Acked-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  kernel/locking/locktorture.c |  3 ++-
>  kernel/torture.c             | 11 ++++++++++-
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> index 949d3deae506..aac48d323254 100644
> --- a/kernel/locking/locktorture.c
> +++ b/kernel/locking/locktorture.c
> @@ -809,7 +809,8 @@ static int lock_torture_writer(void *arg)
>  	bool skip_main_lock;
>  
>  	VERBOSE_TOROUT_STRING("lock_torture_writer task started");
> -	set_user_nice(current, MAX_NICE);
> +	if (!rt_task(current))
> +		set_user_nice(current, MAX_NICE);
>  
>  	do {
>  		if ((torture_random(&rand) & 0xfffff) == 0)
> diff --git a/kernel/torture.c b/kernel/torture.c
> index 8be83fdc6be1..db79197e257a 100644
> --- a/kernel/torture.c
> +++ b/kernel/torture.c
> @@ -37,6 +37,7 @@
>  #include <linux/ktime.h>
>  #include <asm/byteorder.h>
>  #include <linux/torture.h>
> +#include <linux/sched/rt.h>
>  #include "rcu/rcu.h"
>  
>  MODULE_LICENSE("GPL");
> @@ -57,6 +58,9 @@ module_param(verbose_sleep_duration, int, 0444);
>  static int random_shuffle;
>  module_param(random_shuffle, int, 0444);
>  
> +static int lock_torture_writer_fifo;
> +module_param(lock_torture_writer_fifo, int, 0444);
> +
>  static char *torture_type;
>  static int verbose;
>  
> @@ -734,7 +738,7 @@ bool stutter_wait(const char *title)
>  	cond_resched_tasks_rcu_qs();
>  	spt = READ_ONCE(stutter_pause_test);
>  	for (; spt; spt = READ_ONCE(stutter_pause_test)) {
> -		if (!ret) {
> +		if (!ret && !rt_task(current)) {
>  			sched_set_normal(current, MAX_NICE);
>  			ret = true;
>  		}
> @@ -944,6 +948,11 @@ int _torture_create_kthread(int (*fn)(void *arg), void *arg, char *s, char *m,
>  		*tp = NULL;
>  		return ret;
>  	}
> +
> +	if (lock_torture_writer_fifo &&
> +	    !strncmp(s, "lock_torture_writer", strlen(s)))
> +		sched_set_fifo(*tp);

I replaced this with a callback function in order to confine
locktorture-specific code to kernel/locking/locktorture.c.

I will reply with the following two patches.

1.	Add a kthread-creation callback to _torture_create_kthread().

2.	Add lock_torture writer_fifo module parameter, courtesy of
	Dietmar Eggemann.

Please let me know if you have objections to this change.

						Thanx, Paul

------------------------------------------------------------------------

 b/Documentation/admin-guide/kernel-parameters.txt |    4 ++++
 b/include/linux/torture.h                         |    7 +++++--
 b/kernel/locking/locktorture.c                    |   12 +++++++-----
 b/kernel/torture.c                                |    6 +++++-
 kernel/torture.c                                  |    3 ++-
 5 files changed, 23 insertions(+), 9 deletions(-)
