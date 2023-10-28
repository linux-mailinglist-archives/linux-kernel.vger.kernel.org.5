Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6A57DA783
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 16:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjJ1ON3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 10:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjJ1ON2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 10:13:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC71D6
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 07:13:26 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698502405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZkdR3LIP6X/T4MnDwMCMqbjfio/IUFaqU9qNtOKypaQ=;
        b=sU7SjGBUin4H0wmUtQOdW3ZA+3paJlHz5t2fuCOjlM1lfN1epLOphVLEW0IvItVPy+Dbh0
        elkkb22BBy6xf7wjUx6demOzyuY/UpO92NeF4zDg9jPR579PwuFk40AkQLuwrJjhYjbrfr
        FED4Mi0vC8EW0oBsc+VRQpwn46p+13Q/7tW6NKUG5vzuy/fkAcekYZvsXdkkup8Dr113X0
        PWIo0xiShjll5OfZ2t+MkYij3w6Fwx+6rRI3E6XmXrJosXmtNEc3mbTROUXUfsrpbt7Af6
        SAvSlks94qP8Aze+E6PpWC+EJkBq/bjxW/FCXEAapJw4KPTGODiXWKbS7CYkVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698502405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZkdR3LIP6X/T4MnDwMCMqbjfio/IUFaqU9qNtOKypaQ=;
        b=I3kavjQv7ypz0TwyykJn9g35qRAyF11mKbWEZ9fjN0wMmWbIxgKJJd+2st7tFRbC55mT8o
        uSK6gL3XQiJdsSAQ==
To:     David Woodhouse <dwmw2@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] lockdep: add lockdep_cleanup_dead_cpu()
In-Reply-To: <e5ba02138c31da60daf91ce505ac3860d022332b.camel@infradead.org>
References: <e5ba02138c31da60daf91ce505ac3860d022332b.camel@infradead.org>
Date:   Sat, 28 Oct 2023 16:13:24 +0200
Message-ID: <877cn625tn.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28 2023 at 12:14, David Woodhouse wrote:

> From: David Woodhouse <dwmw@amazon.co.uk>
>
> Add a function to check that an offlone CPU left the tracing infrastructure
> in a sane state. The acpi_idle_play_dead() function was recently observed
> calling safe_halt() instead of raw_safe_halt(), which had the side-effect
> of setting the hardirqs_enabled flag for the offline CPU. On x86 this
> triggered lockdep warnings when the CPU came back online, but too early
> for the exception to be handled correctly, leading to a triple-fault.
>
> Add lockdep_cleanup_dead_cpu() to check for this kind of failure mode,
> print the events leading up to it, and correct it so that the CPU can
> come online again correctly.
>
> [   61.556652] smpboot: CPU 1 is now offline
> [   61.556769] CPU 1 left hardirqs enabled!
> [   61.556915] irq event stamp: 128149
> [   61.556965] hardirqs last  enabled at (128149): [<ffffffff81720a36>] acpi_idle_play_dead+0x46/0x70
> [   61.557055] hardirqs last disabled at (128148): [<ffffffff81124d50>] do_idle+0x90/0xe0
> [   61.557117] softirqs last  enabled at (128078): [<ffffffff81cec74c>] __do_softirq+0x31c/0x423
> [   61.557199] softirqs last disabled at (128065): [<ffffffff810baae1>] __irq_exit_rcu+0x91/0x100
>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
