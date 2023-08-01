Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E181C76BF3A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 23:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjHAVY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 17:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbjHAVYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:24:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62093592
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 14:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=cHqWgaJkJ5qtFAhmMTpbhaOFq5y0G8rgvXv1BYzTllE=; b=P/i9xWGUlVcwh7RQPf/flKOyqV
        t4QkAzk/LeXskddGfo7526ldpn+05lvNdgpTvOJt5VaVsAzyCeOkEB5pqEt8w+a1/b6Wb0rmIUkU3
        dFORhH+izWoOuAxRvLSN/k6ZHhsQ1Wp9QIg0WSDoa74vSWWuFsUIz8OrcqEkjvkRJiruQQAuIMnGb
        LDdTz08jEMuKKftrwbTT15Dog4B1JillXyKL8+AOHX/w79Bn9VrBwIyz8b0Em7TIMQ4TJ9MKJyQj8
        kWz49UjAZQIiQKz2zdHTXF71+HTxrihzgUHWLvGLfY67hjIJ7drota+6HbP1bOFUmPBXyaZQNnwhm
        qtEQvcwQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qQwqm-00B5yY-0o; Tue, 01 Aug 2023 21:24:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 549FF300134;
        Tue,  1 Aug 2023 23:24:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 346CE202989E5; Tue,  1 Aug 2023 23:24:15 +0200 (CEST)
Message-ID: <20230801204121.929256934@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 01 Aug 2023 22:41:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] sched: Use lock guards, wave 1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the first of two series converting kernel/sched/core.c to use the shiny
new Scope-Based Resource Management machinery that has recently been merged:

  https://lkml.kernel.org/r/20230612093537.614161713%40infradead.org

TL;DR:

	void foo()
	{
		raw_spin_lock(&lock);
		if (!cond)
			goto unlock;
		...
	unlock:
		raw_spin_unlock(&lock);
	}

can now be written like:

	void foo()
	{
		guard(raw_spinlock)(&lock);
		if (!cond)
			return;
		...
	}

or:

	void foo()
	{
		scoped_guard (raw_spinlock, &lock) {
			if (!cond)
				break;
			...
		}
	}

Where guard() instantiates a 'cleanup' variable that is initialized by an
expression that locks and returns the lock pointer. When this variable goes out
of scope, the cleanup does the unlock. And scoped_guard() does the same but
creates an explicit scope (using for).

By having the unlock be implicit, the code becomes simpler since it is no
longer needed to manually track the various exit/error cases and many goto's
just go away.

Specifically, every patch in this series is aimed at removing an out/unlock
label and it's corresponding gotos.

If there are no objections / comments, I'm aiming to post the second batch at
the end of the week.

Also available at:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/guards


