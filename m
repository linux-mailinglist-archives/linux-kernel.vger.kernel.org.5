Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1957BD56E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 10:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345484AbjJIInu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 04:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345477AbjJIInt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:43:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF75EB6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 01:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1MkN/lp2ZpwFCaascyMpF3sR0iWXLMzjlTvHYfa39sQ=; b=C8tSCnsDrAzd7giZbKfL5dNAQq
        xb9j1RNtCF0B0nj3272UNSd9swAcd0UqPy00JqypxMA0czykhnGsCFuxsP9B7isFHPQfUDKjp2Ory
        IeNnVWHcwV5auefOyBuafbg3V2RCuGqEX+ehSKkXt1t77KKlw7R3tFp72bi7oXkYEHXRM2Lh82u00
        vhmq8i/uSxKsJS/2Kmacc4hf4iuKU6lpf+axO6+QPORb8CTGI4btmXpIOGVDg8FMC4gbKeHd6ltfM
        hOSSFb5+IV+E9zhXwVyyYOBqsMGWdxgEeQdVkz2jg/9McFQkDhghey0UFnWEl7Kg25EoAfED3bpuw
        d0ELj8Sw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qplrY-00FjVx-2W;
        Mon, 09 Oct 2023 08:43:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id DE84D300454; Mon,  9 Oct 2023 10:43:41 +0200 (CEST)
Date:   Mon, 9 Oct 2023 10:43:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     bsingharora@gmail.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] delayacct: convert task->delays to a object
Message-ID: <20231009084341.GA14330@noisy.programming.kicks-ass.net>
References: <cover.1696761522.git.chunguang.xu@shopee.com>
 <531ddc82793a39f4c09316d701a4b1170bcad4ab.1696761522.git.chunguang.xu@shopee.com>
 <20231008105801.GC6320@noisy.programming.kicks-ass.net>
 <5dba07eb-88f0-bf84-494e-b979f32ad44d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dba07eb-88f0-bf84-494e-b979f32ad44d@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2023 at 07:10:01PM +0800, brookxu wrote:

> > > @@ -1331,7 +1332,7 @@ struct task_struct {
> > >   	struct page_frag		task_frag;
> > >   #ifdef CONFIG_TASK_DELAY_ACCT
> > > -	struct task_delay_info		*delays;
> > > +	struct task_delay_info		delays;
> > >   #endif
> > Yeah, no.

> Yes, this way will increase about 80 bytes for task_struct, about 0.85% of
> size of task_struct, I think this just like sched_statistics, so that can
> better support dynamically enable through sysctl.

But it's 80 bytes 'nobody' will use. And arguably we should do the same
with schedstats, that's default disabled and again, that's per-task
storage nobody ever uses.

Per this argument we can grow task_struct indefinitely until it
collapses in on itself by the sheer weight of it's information density.
Every additional field will be a smaller fraction of the total.

Yes, it makes it all a little more cumbersome, but we should really not
burden everybody with the load of some.

Surely there is another solution... ?
