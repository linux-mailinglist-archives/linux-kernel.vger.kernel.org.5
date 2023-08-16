Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCD777DE66
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243837AbjHPKTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243894AbjHPKTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:19:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6271999
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 03:19:06 -0700 (PDT)
Date:   Wed, 16 Aug 2023 12:19:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692181144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nKq4Lj7bJy5C6Mfz80GTTkN4qCbI70YzBo06GeXrdAI=;
        b=pktBrazY0mrvtjUxgd1bbmPm7duZ7pLScaR2aZXsMFhWHJSETwUR2EYhp+uhda2OZq1Y6b
        2bY58wAsBhR65jdKqCq8bVA8PYVGIW9NnFiPI6PIvquEG1IY7qGhzD81x2sziiwH7BwWZG
        z/LQFCTmdGYx8naWL2sjLLa6v/odICBtlpRnqXttH+PrEIK0h1cPC7bLr6Ts4do6MZF+dj
        oxJ5LbZwm1XLz/4wYzsqsmgSLsbM6SGFPrVdPIJVfrq7K6U/l+QC4Gk/cMdbX095OKRb5d
        pHNuHAxayH0cUBfkm+PzMKc+4E3MxyDaQWGvNJBfXBl+LbLCuH4ld/VirjUU9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692181144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nKq4Lj7bJy5C6Mfz80GTTkN4qCbI70YzBo06GeXrdAI=;
        b=N9iYgOkkZVnc/eql+GY+J+2yxGpIlYd6VIKcQ+v5rhJUaJ90z57apQn62GFnFrb99WS7wk
        BA/QqCJuVeBbmxCg==
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
Message-ID: <20230816101902.Pz8wdats@linutronix.de>
References: <20230815110121.117752409@infradead.org>
 <20230815161557.GK214207@hirez.programming.kicks-ass.net>
 <20230816085826.zfXjhNmj@linutronix.de>
 <20230816094257.GE980931@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230816094257.GE980931@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-16 11:42:57 [+0200], Peter Zijlstra wrote:
> Not the same -- this is namespace_lock(), right? That's a regular rwsem
> afaict and that *should* be good. Clearly I messed something up.

Most likely. I do see it also fom inode_lock() which does down_write().
I see it only to originate from rwbase_write_lock().

> Thanks!

Sebastian
