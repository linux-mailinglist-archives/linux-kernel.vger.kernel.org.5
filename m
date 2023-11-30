Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3FA7FEE75
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 13:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345271AbjK3MAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 07:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345296AbjK3MAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 07:00:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6939F10F1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 04:00:40 -0800 (PST)
Date:   Thu, 30 Nov 2023 13:00:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701345637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ndX4No2pV02f83c7aScWg/bGo4s6E1w85WWMY13ARpA=;
        b=URoou9yEZGAQw6bqSOt2qkQx0uyaxQu2+5W0DeaX3zbNm9eocIIucIu87W0dNHHaX13yMY
        WguGs9ZBhPc/91NCJpMM528MpyGsytqSGGmUW2TgurU7Cy0l7zfhWl9ovSHQ6JEBCetnss
        IhZbLp/EBcmEfvorSMWUstlwYSc2wCn/yYC77tGN7elAGfpg9LHonn0OaiQaGSnZoAg+vr
        X4MTnFZFb5/V+UOL/6OLVSot2oe0jZ6FgCI59uXZpWMiX/+bJPR3VJUL3YRTv19nMAiUt4
        UcuiseMG91QsWomgZLn5GrR/SAOhI1vH+jdsUQ3kfkdv1GGujbHaNjyCi5S72Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701345637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ndX4No2pV02f83c7aScWg/bGo4s6E1w85WWMY13ARpA=;
        b=UhHN1nz0RRvJGJafkS+JOS5aTVVEq0tgGIliionbkTRj4ZxBIhJWvdW7jsTRsKnDPsPZwd
        Nm0CeVX7MfHbnBDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     rostedt@goodmis.org, tglx@linutronix.de, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, zyhtheonly@gmail.com,
        zyhtheonly@yeah.net
Subject: Re: [PATCH v2] sched/cputime: exclude ktimers threads in
 irqtime_account_irq
Message-ID: <20231130120036.5EpZn4eo@linutronix.de>
References: <20231127130754.3affb908@gandalf.local.home>
 <20231130094130.GA12116@didi-ThinkCentre-M930t-N000>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231130094130.GA12116@didi-ThinkCentre-M930t-N000>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-30 17:41:47 [+0800], tiozhang wrote:
> In CONFIG_PREEMPT_RT kernel, ktimers also calls __do_softirq,
> so when accounting CPUTIME_SOFTIRQ, ktimers need to be excluded
> as well as ksoftirqd.
> Also add this_cpu_ktimers to keep consistency with this_cpu_ksoftirqd.

I'm still not sure what the benefit here is. It says align with
ksoftirqd but why? Why don't we account softirq time for ksoftirqd (and
should continue to do so for ktimersd)?

ktimers runs almost all the time in softirq context. So does every
force-threaded interrupt. Should we exclude them, too?

Sebastian
