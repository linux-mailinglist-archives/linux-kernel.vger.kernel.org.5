Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621657A2969
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 23:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237566AbjIOVc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 17:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237768AbjIOVco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 17:32:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA5FB8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 14:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TNJXGjMWE/z4uo7zMO2zo9L7xP/mpflLJ9YjyGlxZWQ=; b=Oa8/8eGGCgHuh32pBkKAscfMiA
        yqNpxiMy1t+B1AH3qYjuv6yHGTxa7THIt9MxnAAseRYeNZUQFjQO76SO+MYL3iCVa1moKoKYh7oFO
        n7VfIRSSIlZjQ7jTPbw0KMaqs+TJ4/lfbEWb7lxPDjr7euIYlVUrR0phbribVZfSzgF/OZpH1Guqo
        HsgE0Bq4PTRDquhldhLdyJovfwMInE08LMaJFMebgIM7J/AQ2V6wHNpcxjj5791vc7WyAXXhmvGi0
        fToLVGg1oziP59ko7QOkSWXN5hF8+8Lh+7rFO/13rCN1xiYN5sTWi6Bl6KFNaGmaGCg2wzU8RvrLx
        TXJEjOkw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qhGQQ-009bQ8-2f;
        Fri, 15 Sep 2023 21:32:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id E39DA3003F2; Fri, 15 Sep 2023 23:32:31 +0200 (CEST)
Date:   Fri, 15 Sep 2023 23:32:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        akpm@linux-foundation.org
Subject: Re: Buggy __free(kfree) usage pattern already in tree
Message-ID: <20230915213231.GB23174@noisy.programming.kicks-ass.net>
References: <07c32bf1-6c1a-49d9-b97d-f0ae4a2b42ab@p183>
 <CAHk-=whO1+-4ALjFWSE0kzytz1kEbWPvy3xWvcUP1dJ4t-QqkA@mail.gmail.com>
 <CACMJSetxQi+t3SBXu6OvBbmxV8AbX2CfdSA9JvF1chLJSU9Ppw@mail.gmail.com>
 <CAHk-=wgRHiV5VSxtfXA4S6aLUmcQYEuB67u3BJPJPtuESs1JyA@mail.gmail.com>
 <CACMJSevZQgik7S-62fz9H7+Mib+W0CgYMV4GyWjYV7N_E6iHVQ@mail.gmail.com>
 <CACMJSevrJ5KSPAZVheXkNaYj8KQFD8ck55kU_E4vEj4vzR8wnQ@mail.gmail.com>
 <CAHk-=wicfvWPuRVDG5R1mZSxD8Xg=-0nLOiHay2T_UJ0yDX42g@mail.gmail.com>
 <20230915210851.GA23174@noisy.programming.kicks-ass.net>
 <CAHk-=whvOGL3aNhtps0YksGtzvaob_bvZpbaTcVEqGwNMxB6xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whvOGL3aNhtps0YksGtzvaob_bvZpbaTcVEqGwNMxB6xg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 02:22:02PM -0700, Linus Torvalds wrote:

> Naming is hard, let's not make it worse by making it actively misleading.

I actually did use the DEFINE_FREE() helper, will go fix. Because yes,
free is not the right word in this case.

> And honestly, I think the above is actually a *HORIBLE* argument for
> doing that "initialize to NULL, change later". I think the above is
> exactly the kind of code that we ABSOLUTELY DO NOT WANT.
> 
> You should aim for a nice
> 
>         struct rw_semaphore *struct rw_semaphore *exec_update_lock
>             __cleanup(release_exec_update_lock) = get_exec_update_lock(task);

Ah, that might be nicer still than the class thing I proposed in a
follow up email.

It also got me thinking about named_guard() for the myriad of
conditional locks we have.

	named_guard(try_mutex, foo_guard)(&foo->lock);
	if (foo_guard) {
		// we got the lock, do our thing
	}


or

	named_guard(interruptible_mutex, foo_guard)(&foo->lock);
	if (!foo_guard)
		return -EINTR;


Are these sane patterns?
