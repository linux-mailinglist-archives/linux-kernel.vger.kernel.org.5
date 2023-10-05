Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB2E7B9F07
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbjJEOQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjJEOOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:14:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F2FE10D;
        Thu,  5 Oct 2023 06:48:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D1FB1688;
        Thu,  5 Oct 2023 06:38:51 -0700 (PDT)
Received: from [10.34.100.116] (e126645.nice.arm.com [10.34.100.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 353C13F641;
        Thu,  5 Oct 2023 06:38:12 -0700 (PDT)
Message-ID: <375571ff-c63e-9045-81ff-dc93bcade8ee@arm.com>
Date:   Thu, 5 Oct 2023 15:38:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [ANNOUNCE] v6.6-rc4-rt7
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
References: <20231004160655.0D-7XFo_@linutronix.de>
Content-Language: en-US
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20231004160655.0D-7XFo_@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sebastian,
The following happened once [1]. In pl011_console_write() from:
   commit da042bbb7a3f ("printk: Update the printk series.")
&uap->port seems to be released, but various paths don't seem
to acquire the lock,

Regards,
Pierre

[1]
[...] =====================================
[...] WARNING: bad unlock balance detected!
[...] 6.6.0-rc4-rt7-00098-g400db4a2dd90 #1157 Not tainted
[...] -------------------------------------
[...] pr/legacy/18 is trying to release lock (&port_lock_key) at:
[...] pl011_console_write ([path]/drivers/tty/serial/amba-pl011.c:2366)
[...] but there are no more locks to release!
[...]
[...] other info that might help us debug this:
[...] 2 locks held by pr/legacy/18:
[...] #0: ffff8000846bc0b8 (console_lock){+.+.}-{0:0}, at: nbcon_legacy_kthread_func ([path]/kernel/printk/printk.c:3052 [path]/kernel/printk/printk.c:3364)
[...] #1: ffff8000846bc030 (console_srcu){....}-{0:0}, at: console_flush_all ([path]/./include/linux/srcu.h:230 [path]/kernel/printk/printk.c:286 [path]/kernel/printk/printk.c:2971)
[...]
[...] stack backtrace:
[...] CPU: 1 PID: 18 Comm: pr/legacy Not tainted 6.6.0-rc4-rt7-00098-g400db4a2dd90 #1157
[...] Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Sep  5 2023
[...] Call trace:
[...] dump_backtrace ([path]/arch/arm64/kernel/stacktrace.c:235)
[...] show_stack ([path]/arch/arm64/kernel/stacktrace.c:242)
[...] dump_stack_lvl ([path]/lib/dump_stack.c:107)
[...] dump_stack ([path]/lib/dump_stack.c:114)
[...] print_unlock_imbalance_bug ([path]/kernel/locking/lockdep.c:5201)
[...] lock_release ([path]/kernel/locking/lockdep.c:5438 [path]/kernel/locking/lockdep.c:5780)
[...] rt_spin_unlock ([path]/kernel/locking/spinlock_rt.c:81)
[...] pl011_console_write ([path]/drivers/tty/serial/amba-pl011.c:2366)
[...] console_flush_all ([path]/kernel/printk/printk.c:2910 [path]/kernel/printk/printk.c:2992)
[...] nbcon_legacy_kthread_func ([path]/kernel/printk/printk.c:3053 [path]/kernel/printk/printk.c:3364)
[...] kthread ([path]/kernel/kthread.c:388)
[...] ret_from_fork ([path]/arch/arm64/kernel/entry.S:854)


On 10/4/23 18:06, Sebastian Andrzej Siewior wrote:
> Dear RT folks!
> 
> I'm pleased to announce the v6.6-rc4-rt7 patch set.
> 
> Changes since v6.6-rc4-rt6:
> 
>    - Lockdep complained about SRCU locking if printk was used from NMI.
> 
>    - The i915 driver could create a locking related splat during suspend/
>      resume. Reported by John B. Wyatt IV.
> 
>    - A new version of printk. This is an update to the current
>      development version. Large patch series provided by John Ogness.
> 
> Known issues
>       None
> 
> The delta patch against v6.6-rc4-rt6 is not appended below due to its
> size. It and can be found here:
>   
>       https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.6/incr/patch-6.6-rc4-rt6-rt7.patch.xz
> 
> and as web based diff:
>       
>       https://git.kernel.org/rt/linux-rt-devel/d/v6.6-rc4-rt7/v6.6-rc4-rt6
> 
> You can get this release via the git tree at:
> 
>      https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.6-rc4-rt7
> 
> The RT patch against v6.6-rc4 can be found here:
> 
>      https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.6/older/patch-6.6-rc4-rt7.patch.xz
> 
> The split quilt queue is available at:
> 
>      https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.6/older/patches-6.6-rc4-rt7.tar.xz
> 
> Sebastian
> 
