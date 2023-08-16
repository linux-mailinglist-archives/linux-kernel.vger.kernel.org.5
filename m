Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E0377E2FB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245695AbjHPNrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245331AbjHPNqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:46:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5120C125
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 06:46:35 -0700 (PDT)
Date:   Wed, 16 Aug 2023 15:46:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692193592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tWBUMviS5VnX2ujsjiJgOkWFPLAfF3BRWa0qwcg/2UQ=;
        b=YmdxAecjJ9Jv8YgXQiFSXjq8dA80P2ELfVFO9G+5BrZOafgHuRYGH0+F+O3qW2Is/KzTN2
        swRjSI/czZmOatruXCPuwaogQ3CTZK6EEHHsA9Ki86TR61yeolEdNVLGK8Mf15zbvrUGvq
        dmaV6FDUxYwgMCONDHWV2AbiBXHyNaMXcfUq9dQSPyjqUWdpWYGnj9D+0rLhnCYAT3lFWR
        hbfoxbZN/6LzfYBxt5ARMArqdbu6cb13dmwjW0492szhOgCEWbG7/UWd1o1CFTXwmE0j0I
        4hT90YOnIuIqS2giiiGFVepe4CIHu6MdNALJ+LVOLGeVDADclh119y78yRrn8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692193592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tWBUMviS5VnX2ujsjiJgOkWFPLAfF3BRWa0qwcg/2UQ=;
        b=3aqUIAhHPgp+VJJbmJeR5UNNXOfHU5MrCSbg4wIXF9jRKYZDRXPYWhwOQaWdK/2Ndge3A3
        NTNopKUyuIv6rtAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bsegall@google.com, boqun.feng@gmail.com, swood@redhat.com,
        bristot@redhat.com, dietmar.eggemann@arm.com, mingo@redhat.com,
        jstultz@google.com, juri.lelli@redhat.com, mgorman@suse.de,
        rostedt@goodmis.org, vschneid@redhat.com,
        vincent.guittot@linaro.org, longman@redhat.com, will@kernel.org
Subject: Re: [PATCH 0/6] locking/rtmutex: Avoid PI state recursion through
 sched_submit_work()
Message-ID: <20230816134630.KO12Djeh@linutronix.de>
References: <20230815110121.117752409@infradead.org>
 <20230815161557.GK214207@hirez.programming.kicks-ass.net>
 <20230816085826.zfXjhNmj@linutronix.de>
 <20230816094257.GE980931@hirez.programming.kicks-ass.net>
 <20230816101902.Pz8wdats@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230816101902.Pz8wdats@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-16 12:19:04 [+0200], To Peter Zijlstra wrote:
> On 2023-08-16 11:42:57 [+0200], Peter Zijlstra wrote:
> > Not the same -- this is namespace_lock(), right? That's a regular rwsem
> > afaict and that *should* be good. Clearly I messed something up.
> 
> Most likely. I do see it also fom inode_lock() which does down_write().
> I see it only to originate from rwbase_write_lock().

I've been looking at what you did and what we had.
I'm not sure if your additional debug/assert code figured it out or me
looking at it, but in rwbase_write_lock() for down_write(), we had this
beauty with a comment that you made go away:

|        * Take the rtmutex as a first step. For rwsem this will also
|        * invoke sched_submit_work() to flush IO and workers.
|	 */
|         if (rwbase_rtmutex_lock_state(rtm, state))

for rw_semaphore we don't have any explicit rwbase_sched_submit_work()
but relied on this one. Now that I look at it again,
rwbase_rtmutex_lock_state() can succeed in the fast path so we don't
flush/ invoke rwbase_pre_schedule().
So you rightfully removed the comment as it was misleading but we do
need that rwbase_pre_schedule() thingy before
raw_spin_lock_irqsave(&rtm->wait_lock).

Sebastian
