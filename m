Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390FD77CB95
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236698AbjHOLSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236689AbjHOLRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:17:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880E3EE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 04:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=8earX3r0sIh2/8rl9iwG2HlAaQmkPP9fYoiwKlrBrYg=; b=NOBKhMVdmQxKQn/SrJb6yeL7Mk
        rrK/A8cOAea4SJKbmpW4OouH++Y+QnQ1tYq1BCYNizawidGl1mAwB5rw2MVzffH8b1WriFJ+NdXF1
        vOsRjjhaPmOp6UYz5ayvaqWIXzpmcEmtqOKK+M+GPbgYO7Xuo9S74r5jw1nAN5C+QTUIRV3FB4vxH
        0ZVKmhHubENAoLy2/GtAbC+SNA///7ArStI7x7tLEboHjwed928twl5rofNYZTjbhN8kPcqOwb07Y
        6dxYuzZ6Jc82HpOtc1rLrLui7UwU/zlie0DG9hG/Nr4A2FBkgzFjn+PeUW6QAhf2q+bf+jyhUsGJS
        hoUlUrrw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qVs2c-00Bo43-0H;
        Tue, 15 Aug 2023 11:16:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0F61B30020B;
        Tue, 15 Aug 2023 13:16:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E53662074B3D8; Tue, 15 Aug 2023 13:16:48 +0200 (CEST)
Message-ID: <20230815110121.117752409@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 15 Aug 2023 13:01:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     bigeasy@linutronix.de, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        bsegall@google.com, boqun.feng@gmail.com, swood@redhat.com,
        bristot@redhat.com, dietmar.eggemann@arm.com, mingo@redhat.com,
        jstultz@google.com, juri.lelli@redhat.com, mgorman@suse.de,
        rostedt@goodmis.org, vschneid@redhat.com,
        vincent.guittot@linaro.org, longman@redhat.com, will@kernel.org
Subject: [PATCH 0/6] locking/rtmutex: Avoid PI state recursion through sched_submit_work()
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is basically the 'same' patches as send earlier by Sebastian here:

  https://lkml.kernel.org/r/20230427111937.2745231-1-bigeasy@linutronix.de

I spend a number of days trying to invert rtmutex, only to make a giant mess of
things and finally conceded that this is the least horrible approach.

There's a bunch of naming differences and I added some asserts that should
hopefully avoid things from going sideways without notice. I've also updated
the changelogs to high-light the actual problem. The whole pi_blocked_on
'corruption' is a mere consequence of the more fundamental problem that the
whole PI state recurses.

I've not tested this with the rest of the RT patches stuck on, so very limited
actual testing happened.

If anybody could please confirm stuff still works as advertised, I'll go queue
this mess and we can hopefully forget all about it.

