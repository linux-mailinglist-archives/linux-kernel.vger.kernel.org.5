Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1C976BD59
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 21:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjHATJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 15:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjHATJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 15:09:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC1F1BF1;
        Tue,  1 Aug 2023 12:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bVP85O9/QcNBPIvfcxax7LD7hWg5oCRrHtBzjxz8bi4=; b=WIo8351O6aN09tVsscNgMq+qor
        xOZP9/a7mh273Btla3YmqEMCZnBtPeJjHw6u5T7VA6FxqJRFehzBcG6QBIC3FZ6goP173sts64DnD
        gpcB6/u9ZpcBnGWmYMY0Uw1S47k5JWvL5vGNAMzoAL276v7iIVVxRAAQBm5c9g81MwqE5miESZk91
        e2+LHOZmkHpK2qB9X+b46spycuXObuWAMu0v0zd1yNNTv1xiUG25Al+dPk4rwpPd5MeOuBZilsg3x
        ysx+ZazrzVRb44wiSKmxLKaVf7k//WZwMTwYlWQGybC1VHtyV6ZI6J1AtwICDlav4vLoSRtGhyw3W
        gyeoy/JQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qQujl-00AUuc-PR; Tue, 01 Aug 2023 19:08:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 92BF6300134;
        Tue,  1 Aug 2023 21:08:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 81821201BD3C3; Tue,  1 Aug 2023 21:08:52 +0200 (CEST)
Date:   Tue, 1 Aug 2023 21:08:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Roy Hopkins <rhopkins@suse.de>,
        Joel Fernandes <joel@joelfernandes.org>, paulmck@kernel.org,
        Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        rcu@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>
Subject: Re: scheduler problems in -next (was: Re: [PATCH 6.4 000/227]
 6.4.7-rc1 review)
Message-ID: <20230801190852.GG11704@hirez.programming.kicks-ass.net>
References: <3da81a5c-700b-8e21-1bde-27dd3a0b8945@roeck-us.net>
 <20230731141934.GK29590@hirez.programming.kicks-ass.net>
 <20230731143954.GB37820@hirez.programming.kicks-ass.net>
 <f5a18aa3-9db7-6ad2-33d5-3335a18e4e2f@roeck-us.net>
 <20230731145232.GM29590@hirez.programming.kicks-ass.net>
 <7ff2a2393d78275b14ff867f3af902b5d4b93ea2.camel@suse.de>
 <20230731161452.GA40850@hirez.programming.kicks-ass.net>
 <baa58a8e-54f0-2309-b34e-d62999a452a1@roeck-us.net>
 <20230731211517.GA51835@hirez.programming.kicks-ass.net>
 <a05743a3-4dec-6af7-302f-d1d2a0db7d3e@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a05743a3-4dec-6af7-302f-d1d2a0db7d3e@roeck-us.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 10:32:45AM -0700, Guenter Roeck wrote:
> On 7/31/23 14:15, Peter Zijlstra wrote:
> > On Mon, Jul 31, 2023 at 09:34:29AM -0700, Guenter Roeck wrote:
> > > > Ha!, I was poking around the same thing. My hack below seems to (so far,
> > > > <20 boots) help things.
> > > > 
> > > 
> > > So, dumb question:
> > > How comes this bisects to "sched/fair: Remove sched_feat(START_DEBIT)" ?
> > 
> > That commit changes the timings of things; dumb luck otherwise.
> 
> Kind of scary. So I only experienced the problem because the START_DEBIT patch
> happened to be queued roughly at the same time, and it might otherwise have
> found its way unnoticed into the upstream kernel. That makes me wonder if this
> or other similar patches may uncover similar problems elsewhere in the kernel
> (i.e., either hide new or existing race conditions or expose existing ones).
> 
> This in turn makes me wonder if it would be possible to define a test which
> would uncover such problems without the START_DEBIT patch. Any idea ?

IIRC some of the thread sanitizers use breakpoints to inject random
sleeps, specifically to tickle races.
