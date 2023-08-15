Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7E977D427
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237940AbjHOUbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237828AbjHOUbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:31:25 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B341BF7;
        Tue, 15 Aug 2023 13:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=5qU/5VuCNxpl7AX33gP+0AiuqhusLaBl3uuYx+5QjPY=; b=O48VbhaB/crYgFw5YXDyYmVlmD
        c6yFbFo9wu37AXbWrb1K7w7G2IMtEdNqHwk8zFqTW8m5B64YaHxl+OqkfHo7rwXNBLrmvyl/Ma0b0
        zO0G2nQjK0r3QtA5OR1TYNIx/SgjtoBgS3oToZLa0Oi6k6g5LNGqSMUCZ4GhYQYFkD8FK1knZAqbN
        of0V+d9ic6KlxpS39laH9gW38gGqk0o5AUxowGd2sI5/cnl64PxDsb7Ui61KTdi9FfrowSbatS2xX
        ZhgPZvGHrIc7xQ4bcTC18seZ799MVpy+PHtgzx+p6L4DMP2WOsExYG/8cVPuNeC0fUfsn13gInE1o
        Ly4nPrrg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qW0hB-00C4qZ-2k;
        Tue, 15 Aug 2023 20:31:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4FD07300222;
        Tue, 15 Aug 2023 22:31:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 39F702B57699C; Tue, 15 Aug 2023 22:31:17 +0200 (CEST)
Date:   Tue, 15 Aug 2023 22:31:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 2/2] gpio: sim: simplify code with cleanup helpers
Message-ID: <20230815203117.GA971582@hirez.programming.kicks-ass.net>
References: <20230809131442.25524-1-brgl@bgdev.pl>
 <20230809131442.25524-2-brgl@bgdev.pl>
 <CACRpkdavsv3nJnhtdqW8ANAVfxbgHdM-SpcfOv4p_t-7EOaOHQ@mail.gmail.com>
 <20230815155253.GK212435@hirez.programming.kicks-ass.net>
 <ZNugkmhj1Joygorj@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZNugkmhj1Joygorj@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 06:58:10PM +0300, Andy Shevchenko wrote:
> On Tue, Aug 15, 2023 at 05:52:53PM +0200, Peter Zijlstra wrote:
> > On Tue, Aug 15, 2023 at 10:04:32AM +0200, Linus Walleij wrote:
> > > On Wed, Aug 9, 2023 at 3:14 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> 
> 
> > > > -       mutex_lock(&chip->lock);
> > > > +       guard(mutex)(&chip->lock);
> 
> > Looks about right.
> 
> Btw, why don't we have something like
> 
> 	guard_mutex()
> 
> to be used as
> 
> 	guard_mutex(&chip->lock);

Because this way I can write:

DEFINE_LOCK_GUARD_1(rq_lock_irqsave, struct rq,
		    rq_lock_irqsave(_T->lock, &_T->rf),
		    rq_unlock_irqrestore(_T->lock, &_T->rf),
		    struct rq_flags rf);

And have:

	guard(rq_lock_irqsave)(rq);

and

	scoped_guard (rq_lock_irqsave, rq) {
	}

just work.

And if you look in tip/sched/core, you'll find exactly this.

Or look here:

  https://lkml.kernel.org/r/20230612090713.652690195@infradead.org

for a bunch more examples -- I've wanted to get more of that merged, but
alas, only 24h in a day and life got in the way. Defining local guard
types is very useful.

> Moreover, maybe some macro that can predict the API call from the type of
> the parameter?

The whole type inferrence in C is not extensible. That is, you get to
write a single _Generic() statement, and every case that is included in
it will work, but the moment you use a new type, one that is not
included in your giant _Generic() statement, you're out of luck.
