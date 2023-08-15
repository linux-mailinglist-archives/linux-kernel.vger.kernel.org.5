Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C9B77CFFF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 18:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238494AbjHOQQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 12:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238497AbjHOQQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 12:16:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B1D98
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 09:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=70hnSg58IJsTVXQG/lxj7heEIeJUwgyDVoxrGVzhpIQ=; b=E9iLn8dPmHg7G14WFmdWnogudi
        0x/In1R9m6KcFBG+le0tjPX5VDRCiKcF6uMExzssuJV52TE/IHCWUOTcgfYYXT8KwFOUt3c1n2gfO
        iqvStGvUOgJLXLpduZCPjKftNhIV2d7EigHb8SkzXTgE17h78BMor+sZF0ta3Qb1dS3vBByd8Do4+
        5l8R8puDL76HkIOtYF0kHRh5QOBqvu41kmyfR8ZV/KdKQ5l89+3gjaORQU8ZEQGDLo10+jncteJNw
        76ZDYtX78tAvUSGL4TV4kKDIm2QpFLdebuhbKLzFT3ekKj/xKZeAAa16YO47JVPct03nLwvDalrCb
        Dm/sI9cw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qVwi6-009AST-6F; Tue, 15 Aug 2023 16:15:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6743D300137;
        Tue, 15 Aug 2023 18:15:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4465420307345; Tue, 15 Aug 2023 18:15:57 +0200 (CEST)
Date:   Tue, 15 Aug 2023 18:15:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     bigeasy@linutronix.de, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, bsegall@google.com,
        boqun.feng@gmail.com, swood@redhat.com, bristot@redhat.com,
        dietmar.eggemann@arm.com, mingo@redhat.com, jstultz@google.com,
        juri.lelli@redhat.com, mgorman@suse.de, rostedt@goodmis.org,
        vschneid@redhat.com, vincent.guittot@linaro.org,
        longman@redhat.com, will@kernel.org
Subject: Re: [PATCH 0/6] locking/rtmutex: Avoid PI state recursion through
 sched_submit_work()
Message-ID: <20230815161557.GK214207@hirez.programming.kicks-ass.net>
References: <20230815110121.117752409@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815110121.117752409@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 01:01:21PM +0200, Peter Zijlstra wrote:
> Hi!
> 
> This is basically the 'same' patches as send earlier by Sebastian here:
> 
>   https://lkml.kernel.org/r/20230427111937.2745231-1-bigeasy@linutronix.de
> 
> I spend a number of days trying to invert rtmutex, only to make a giant mess of
> things and finally conceded that this is the least horrible approach.
> 
> There's a bunch of naming differences and I added some asserts that should
> hopefully avoid things from going sideways without notice. I've also updated
> the changelogs to high-light the actual problem. The whole pi_blocked_on
> 'corruption' is a mere consequence of the more fundamental problem that the
> whole PI state recurses.
> 
> I've not tested this with the rest of the RT patches stuck on, so very limited
> actual testing happened.
> 
> If anybody could please confirm stuff still works as advertised, I'll go queue
> this mess and we can hopefully forget all about it.
> 

N/m - 0day found a problem. Futex-PI trips the rt_mutex_schedule()
assertion for not passing through rt_mutex_pre_schedule().

I'll go try and untangle that...
