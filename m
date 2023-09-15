Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6227A2903
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 23:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237759AbjIOVJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 17:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237863AbjIOVJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 17:09:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3B8D3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 14:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jkCUL0RKzftwVLtOw4nOB5BWk9sREif9OtWvVaTnu0k=; b=aeWfvU2UpK+D5Qk1SJC9+vBv4l
        A6mPBNqQ6QOjao2AnsbHcHf/fBLBQkHAweyg78Qg69poLPzMBFhmJllkKOKTbpovSnkDJMq3yOgDW
        fYH53XwESfbameeMqSuzZuoS+4q8Ki35MHqykVKUIJdAD4OlLMlI22l1d5lGzffeZ9LLBqAszGiIP
        gO763rmbHagSnj8gDwfB0hfmFPDlKQj9VTwuv4kvWtposyGmfEPvEsVJKsu1mdBSfhWO+iJy6dBzS
        ph0aET6OxkwV9rORAK4Mci9RuVAFWpWMu3Gr1yrHkl/PFIjfT+FQEHkvD5Mpo2Tfx6sjcF9nOECFL
        SvEYl0XQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qhG3Y-00C3p2-7A; Fri, 15 Sep 2023 21:08:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id D43113003F2; Fri, 15 Sep 2023 23:08:51 +0200 (CEST)
Date:   Fri, 15 Sep 2023 23:08:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        akpm@linux-foundation.org
Subject: Re: Buggy __free(kfree) usage pattern already in tree
Message-ID: <20230915210851.GA23174@noisy.programming.kicks-ass.net>
References: <07c32bf1-6c1a-49d9-b97d-f0ae4a2b42ab@p183>
 <CAHk-=whO1+-4ALjFWSE0kzytz1kEbWPvy3xWvcUP1dJ4t-QqkA@mail.gmail.com>
 <CACMJSetxQi+t3SBXu6OvBbmxV8AbX2CfdSA9JvF1chLJSU9Ppw@mail.gmail.com>
 <CAHk-=wgRHiV5VSxtfXA4S6aLUmcQYEuB67u3BJPJPtuESs1JyA@mail.gmail.com>
 <CACMJSevZQgik7S-62fz9H7+Mib+W0CgYMV4GyWjYV7N_E6iHVQ@mail.gmail.com>
 <CACMJSevrJ5KSPAZVheXkNaYj8KQFD8ck55kU_E4vEj4vzR8wnQ@mail.gmail.com>
 <CAHk-=wicfvWPuRVDG5R1mZSxD8Xg=-0nLOiHay2T_UJ0yDX42g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wicfvWPuRVDG5R1mZSxD8Xg=-0nLOiHay2T_UJ0yDX42g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 01:40:25PM -0700, Linus Torvalds wrote:

> Not because I think it's necessarily any kind of final rule, but
> because I think our whole cleanup thing is new enough that I think
> we're better off being a bit inflexible, and having a syntax where a
> simple "grep" ends up showing pretty much exactly what is going on wrt
> the pairing.

So in the perf-event conversion patches I do have this: 

	struct task_struct *task __free(put_task) = NULL;

	...

	if (pid != -1) {
		task = find_lively_task_by_vpid(pid);
		if (!task)
			return -ESRCH;
	}

	...

pattern. The having of task is fully optional in the code-flow.

I suppose I can try and rewrite that a little something like:

	...

	struct task_struct *task __free(put_task) =
		find_lively_task_by_vpid(pid); /* ensure pid==-1 returns NULL */

	if (!task && pid > 0)
		return -ESRCH;

	...


But a little later in that same function I then have:

	do {
		struct rw_semaphore *exec_update_lock __free(up_read) = NULL;
		if (task) {
			err = down_read_interruptible(&task->signal->exec_update_lock);
			if (err)
				return err;

			exec_update_lock = &task->signal->exec_update_lock;

			if (!perf_check_permissions(&attr, task))
				return -EACCESS;
		}

		... stuff serialized against exec *if* this is a task event ...

	} while (0);


And that might be a little harder to 'fix'.


I suppose I'm saying that when thing truly are conditional, this is a
useful pattern, but avoid where reasonably possible.
