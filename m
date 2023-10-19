Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D162A7CFC3D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346032AbjJSOOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345569AbjJSOOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:14:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36601B0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:14:39 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697724877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NusMDWPntVj/cFGoN/CA5lDcJjp3lS3pYnJHFFANwb8=;
        b=L4HfJPX3bXzjwLEB6PoSV/FzWczlrito8u+5SlE2F29gIKQErTL9jM4AO3nGZtc22u5ZT9
        mPj2Joh/m1U153uC2Bbic0Y8lpRc5tqCMBBclgc3LePaVFe9r9Zsmbbde6FjFhWJqLMpNO
        3EelWvVpgaSJKQ60A8flMO/fsn1IxeVVbwPDe/lGs0BT8in6OBHLTXwvZPtQgZsggI0IoX
        VJVM7XKNng9slp8V8d3vjwxDv0jVgMgJLyjgk4Lm8uPpUjiBZgN5oGoSeyeBuDXBHSKxwI
        yUwF4BrWhW51zbHSbSuYunyDiAX7Fgm7sSweRv1M8zgOZ0C8CE6r7yPz0BcMjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697724877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NusMDWPntVj/cFGoN/CA5lDcJjp3lS3pYnJHFFANwb8=;
        b=2YruEtrQwGDK8WLnrFeSSUV/I+6HGhpoC+kHMA99Fc0zD9pem2dL7AB5E/jvhiTT5U/C0w
        dGfn8s2JiP1yUzBw==
To:     K Prateek Nayak <kprateek.nayak@amd.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH v8 00/25] timer: Move from a push remote at enqueue to a
 pull at expiry model
In-Reply-To: <f7e9279b-a2dc-1980-4134-c6868b47b4ee@amd.com>
References: <20231004123454.15691-1-anna-maria@linutronix.de>
 <f7e9279b-a2dc-1980-4134-c6868b47b4ee@amd.com>
Date:   Thu, 19 Oct 2023 16:14:36 +0200
Message-ID: <87cyxa8zsj.fsf@somnus>
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

Hello Prateek,

I'm sorry for the late reply!

K Prateek Nayak <kprateek.nayak@amd.com> writes:

> Hello Anna-Maria,
>
> On 10/4/2023 6:04 PM, Anna-Maria Behnsen wrote:
>> [..snip..]
>> 
>> Ping Pong Oberservation
>> ^^^^^^^^^^^^^^^^^^^^^^^
>> 
>> During testing on a mostly idle machine a ping pong game could be observed:
>> a process_timeout timer is expired remotely on a non idle CPU. Then the CPU
>> where the schedule_timeout() was executed to enqueue the timer comes out of
>> idle and restarts the timer using schedule_timeout() and goes back to idle
>> again. This is due to the fair scheduler which tries to keep the task on
>> the CPU which it previously executed on.
>
> Regarding above, are you referring to "wake_up_process(timeout->task)" in
> "process_timeout()" ends up waking the task on an idle CPU instead of the
> CPU where process_timeout() ran?

Yes.

> In which case, have you tried using the "WF_CURRENT_CPU" flag for the
> wakeup? (landed upstream in v6.6-rc1) It is only used by wait queues in
> kernel/sched/wait.c currently but perhaps we can have a
> "wake_up_process_on_current_cpu()" that process_timeout() can call.
>
> Something along the lines of:
>
> 	int wake_up_process_on_current_cpu(struct task_struct *p)
> 	{
> 		return try_to_wake_up(p, TASK_NORMAL, WF_CURRENT_CPU);
> 	}
> 	EXPORT_SYMBOL(wake_up_process_on_current_cpu);
>
> Thoughts?

I didn't look into this again. Back than, I reported the observation to
scheduler people (others also already observed this behavior). I'm not
so familiar with scheduling, so I will ping scheduler people to give you
a feedback.

Thanks,

	Anna-Maria

