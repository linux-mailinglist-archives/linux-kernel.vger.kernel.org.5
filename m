Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A79B7CF87C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345380AbjJSMOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbjJSMOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:14:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC00121
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:14:35 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697717674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=58U0eUXdd4M6jZI9lKg9MYDjXA9pyTqDZLUuXlBoJw0=;
        b=GZoPHMjR5E4rPkZ3s/bu/sVO2VPM+SyrhdhfK0s3l70+lEDoLRAszLbTIexbIyQzyfxn4R
        UoI0u3s2BaXC4F6j+blqzge499LIKXwPVIhxRH2XpbXKcNerLXbsysySosH5Y9ch0Lw8j+
        WQfEKTIAER9hZI37UANwWoRlLlQV8JGj9cadkke8/Y8T1kBPDMqxdFHfiEnT8UB69hyusw
        l6mkfJI/ATDq+UyR0o/gOI6ED6nyZ9ij5Lem95Ca2iKJEn9JmDUzTnblKFBJSpu8LYx4KJ
        SSHcMHkA9J9JA5cgYVzTo/ys5T2pWcL8PeR662dn1H54iTMMFwzlcHViy/3mkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697717674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=58U0eUXdd4M6jZI9lKg9MYDjXA9pyTqDZLUuXlBoJw0=;
        b=7yExDj+tM7UeVAQmasjeeBaRpV86CZ5qFF0wxbSmY+APAlANXqp52rLMcOGCITsf3ONk3+
        I5kNWwGwwfcUY+BA==
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        paulmck@kernel.org
Cc:     John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86@kernel.org, joel@joelfernandes.org
Subject: Re: [PATCH] clocksource: disable irq when holding watchdog_lock.
In-Reply-To: <5ef329fe-1f3b-4d81-9625-9738620f051e@I-love.SAKURA.ne.jp>
References: <80ff5036-8449-44a6-ba2f-0130d3be6b57@I-love.SAKURA.ne.jp>
 <CANDhNCpw+hEHNbtdAZR01HsHW_L1C0BXjZq21eXouQGNnYuUNQ@mail.gmail.com>
 <878r826xys.ffs@tglx>
 <90361195-4309-4a02-bd3f-8ee606e6d35b@I-love.SAKURA.ne.jp>
 <c9ddbc3f-dbb8-4ccc-8eb6-43554327984b@paulmck-laptop>
 <5ef329fe-1f3b-4d81-9625-9738620f051e@I-love.SAKURA.ne.jp>
Date:   Thu, 19 Oct 2023 14:14:34 +0200
Message-ID: <87r0lq3j2t.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19 2023 at 18:30, Tetsuo Handa wrote:
> On 2023/10/17 23:10, Paul E. McKenney wrote:
>>> But I'm hitting something different (but might be timer/scheduler related) problem.
>>> What config option would cause taking more than 2 minutes to bring up only 8 CPUs?
>>> (This environment is Oracle VM VirtualBox on Windows 11 host.)
>>>
>> The timing is about the same in both cases.  Does this happen in kernels
>> built with CONFIG_PROVE_LOCKING=n?
>
> Disabling all options in "Lock Debugging (spinlocks, mutexes, etc...)" does not help.
>
>> 
>> Either way, what mainline or -stable version is this?
>
> The kernel is latest commit of upstream linux.git tree.
> I'm seeing this slowdown (almost hung-up) problem for many releases,
> but nobody else seems to be reporting this problem.

Maybe because of this:
>>> (This environment is Oracle VM VirtualBox on Windows 11 host.)

> The only reliable workaround is to specify "nosmp" kernel command line option.

Which makes the kernel keep TSC as clocksource because there is no
synchronization problem between CPU0 and CPU0 :)

What is the fallback clocksource when the TSC is discarded on SMP?

From the dmesg snippets I assume it is the ACPI PMTIMER, which is I/O
port based and presumably takes a VMEXIT on every read and depending on
the emulation this might be slooooow.

So you could boot with "nosmp clocksource=acpi_pm" on the command line
and compare that against a "nosmp" boot.

If my assumption is right, then on UP the ACPI PM variant won't see the
massive slowdown SMP observes, but there should be still an observable
difference.

Thanks,

        tglx
