Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6567F52F5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbjKVWF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjKVWF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:05:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9765210C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 14:05:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D05C433C9;
        Wed, 22 Nov 2023 22:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1700690722;
        bh=6xOIEj/qsKa5m7ejSZ5W5X0UvOk1jhvFPhHiF6L75xA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=y1Hk41eg3sODEMExVfE8eRdPshbzoz1JkHYScAyrOF9UQXOkBEqF4tLDuJW/zZAs8
         Gop3nqGi5IL6iTAf116t19POFywvldo5I57ilCW9TMso5lmyJD8mahO0HgeX//oGts
         r28xnV3VX1+qxKwiYFSYyUA4inIKEJcFXSlVlUjw=
Date:   Wed, 22 Nov 2023 14:05:21 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     lizhe.67@bytedance.com
Cc:     dianders@chromium.org, pmladek@suse.com,
        lecopzer.chen@mediatek.com, kernelfans@gmail.com,
        linux-kernel@vger.kernel.org, lizefan.x@bytedance.com
Subject: Re: [PATCH v2] softlockup: serialized softlockup's log
Message-Id: <20231122140521.85c66b789625e8d270722b3c@linux-foundation.org>
In-Reply-To: <20231122100212.94327-1-lizhe.67@bytedance.com>
References: <20231122100212.94327-1-lizhe.67@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 18:02:12 +0800 lizhe.67@bytedance.com wrote:

> From: Li Zhe <lizhe.67@bytedance.com>
> 
> If multiple CPUs trigger softlockup at the same time with
> 'softlockup_all_cpu_backtrace=0', the softlockup's logs will appear
> staggeredly in dmesg, which will affect the viewing of the logs for
> developer. Since the code path for outputting softlockup logs is not
> a kernel hotspot and the performance requirements for the code are
> not strict, locks are used to serialize the softlockup log output to
> improve the readability of the logs.

Seems reasonable, but...

> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -28,6 +28,8 @@
>  #include <linux/kvm_para.h>
>  
>  static DEFINE_MUTEX(watchdog_mutex);
> +/* This lock is used to prevent concurrent actions of softlockup output logs */
> +static DEFINE_SPINLOCK(watchdog_output_lock);

It would be a little neater to reduce the scope of this - move the
definition into that little code block in watchdog_timer_fn() where it
is actually used.

>  #if defined(CONFIG_HARDLOCKUP_DETECTOR) || defined(CONFIG_HARDLOCKUP_DETECTOR_SPARC64)
>  # define WATCHDOG_HARDLOCKUP_DEFAULT	1
> @@ -514,6 +516,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
>  		/* Start period for the next softlockup warning. */
>  		update_report_ts();
>  
> +		spin_lock(&watchdog_output_lock);

The hrtimer callout function is called from [soft]irq context, yes? 
Doesn't lockdep get upset when we take a spinlock in such a context?

>  		pr_emerg("BUG: soft lockup - CPU#%d stuck for %us! [%s:%d]\n",
>  			smp_processor_id(), duration,
>  			current->comm, task_pid_nr(current));
> @@ -523,6 +526,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
>  			show_regs(regs);
>  		else
>  			dump_stack();
> +		spin_unlock(&watchdog_output_lock);
>  
>  		if (softlockup_all_cpu_backtrace) {
>  			trigger_allbutcpu_cpu_backtrace(smp_processor_id());

