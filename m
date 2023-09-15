Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88B67A2937
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 23:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237423AbjIOVSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 17:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237470AbjIOVS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 17:18:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903ACA0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 14:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y1bSlQlyxuFS2ROn3PtZn/oEo4a4ZfAfEmG1nYzItZc=; b=Lx4wKg5dYpMu1OC5IesCE0ZTbL
        awcV0rg8DM4c0wKYQN6uMUK4GrBoL2/H8q/2E86K2JvXPeML78T67ZvolieM8KtP0nQTOcTNmapLP
        7hYNZLqq9xAj1AAlt+jTSzzKFdz3L8jbtb7n0Ckc+ZhO74Hr1PGCAE2pYe2BkWyZhksqwudItA9Wn
        ksCbltbnusatqyf9b8tKDTCH7FOap6mI+gAtQcE4AeUtGybKdH0+T3Ze3jYonBrl4C6HgcDGlRNdy
        SkMqoAnM6E2L2A1HUIyq9b06+DEpVETLPqqfTkd/MvioUl2utvpEJ4GYdwnUuoMmPUQlQ0CGBFiFK
        8mWKFNiw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qhGCe-00C6g9-72; Fri, 15 Sep 2023 21:18:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id D88AC300155; Fri, 15 Sep 2023 23:18:15 +0200 (CEST)
Date:   Fri, 15 Sep 2023 23:18:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        akpm@linux-foundation.org
Subject: Re: Buggy __free(kfree) usage pattern already in tree
Message-ID: <20230915211815.GA34041@noisy.programming.kicks-ass.net>
References: <07c32bf1-6c1a-49d9-b97d-f0ae4a2b42ab@p183>
 <CAHk-=whO1+-4ALjFWSE0kzytz1kEbWPvy3xWvcUP1dJ4t-QqkA@mail.gmail.com>
 <CACMJSetxQi+t3SBXu6OvBbmxV8AbX2CfdSA9JvF1chLJSU9Ppw@mail.gmail.com>
 <CAHk-=wgRHiV5VSxtfXA4S6aLUmcQYEuB67u3BJPJPtuESs1JyA@mail.gmail.com>
 <CACMJSevZQgik7S-62fz9H7+Mib+W0CgYMV4GyWjYV7N_E6iHVQ@mail.gmail.com>
 <CACMJSevrJ5KSPAZVheXkNaYj8KQFD8ck55kU_E4vEj4vzR8wnQ@mail.gmail.com>
 <CAHk-=wicfvWPuRVDG5R1mZSxD8Xg=-0nLOiHay2T_UJ0yDX42g@mail.gmail.com>
 <20230915210851.GA23174@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915210851.GA23174@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 11:08:51PM +0200, Peter Zijlstra wrote:

> But a little later in that same function I then have:
> 
> 	do {
> 		struct rw_semaphore *exec_update_lock __free(up_read) = NULL;
> 		if (task) {
> 			err = down_read_interruptible(&task->signal->exec_update_lock);
> 			if (err)
> 				return err;
> 
> 			exec_update_lock = &task->signal->exec_update_lock;
> 
> 			if (!perf_check_permissions(&attr, task))
> 				return -EACCESS;
> 		}
> 
> 		... stuff serialized against exec *if* this is a task event ...
> 
> 	} while (0);
> 
> 
> And that might be a little harder to 'fix'.

Hmm, perhaps I can do a class for it and write the thing like:

	do {
		CLASS(cond_exec_update_lock, exec_lock_guard)(task); /* allow task == NULL */
		if (task && !exec_lock_guard)
			return -EINTR;

		if (task && !perf_check_permissions(&attr, task))
			return -EACCESS;

		... the rest ...

	} while (0);

that might be nicer..
