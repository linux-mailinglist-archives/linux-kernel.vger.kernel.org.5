Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BF47917E5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 15:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353011AbjIDNTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 09:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243320AbjIDNTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 09:19:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDABB6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 06:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=imzn/iJ5AsrSfXpvsK3Jo8qAPkxxHyjMe8gj+8OOmuM=; b=SdcfaSBqhamRCdjPqBcIDfEkLU
        5QxFRi86h8bInKxsfLvB+8Mhedz0Xk0qdmeJQgVY63A0TUbLCsez7Akz0OSal8ZpYdQS+zGG/v3LN
        gXAW9M2KPoGUNVF2O6jP58z/6IhMrNQjPsh2kit1DpzknJjBaqd77UPEIVzrDQelVPF5SIkm3PK49
        4sLigAamy3+VJMTFD67KM1HhWUUeWEq4SnuZOdm18/RfBgvpihFMBY7zH5Zow8Yta3CyAhQheQwNc
        o3feLwNegiaxYJdvLp+WQSFpi+KZLLtojyrLKJ/YeBonACnCAk6aTVHF2URvyzvrpbbQL7844nW+I
        qMgYxf4g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qd9Ti-00GIEQ-90; Mon, 04 Sep 2023 13:18:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id D5D9130058C; Mon,  4 Sep 2023 15:18:53 +0200 (CEST)
Date:   Mon, 4 Sep 2023 15:18:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] locking/mutex: remove redundant argument from
 __mutex_lock_common()
Message-ID: <20230904131853.GA12042@noisy.programming.kicks-ass.net>
References: <49c7163433999cc1fc9367311fbe6c6d5fd9f251.1693693823.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49c7163433999cc1fc9367311fbe6c6d5fd9f251.1693693823.git.mirq-linux@rere.qmqm.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 03, 2023 at 12:33:19AM +0200, Michał Mirosław wrote:
> use_ww_ctx is equivalent to ww_ctx != NULL. The one case where
> use_ww_ctx was true but ww_ctx == NULL leads to the same
> __mutex_add_waiter() call via __ww_mutex_add_waiter().
> 
> Since now __ww_mutex_add_waiter() is called only with ww_ctx != NULL
> (from both regular and PREEMPT_RT implementations), remove the
> branch there.
> 

There were compilers that failed to constant propagate the ww_ctx==NULL
thing properly and generated crap code, the use_ww_ctx thing fixed that.

I can't remember which compilers that were (my brain is saying <gcc-6 or
something, but I could be totally wrong) and if we still care about
people using them (probably not).

