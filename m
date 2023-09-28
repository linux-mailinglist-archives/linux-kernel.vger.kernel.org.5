Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339187B1864
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 12:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjI1KkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 06:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjI1KkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 06:40:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA4219B;
        Thu, 28 Sep 2023 03:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0ZBqAeAxhLgaHzA0U30eyOYtBMrVtY+bz7/Iu08opZY=; b=g7rlIogZMEeSYihTHBu7xdq+FY
        ATEFll57FfDYCVpVKC5ixPvUGmcn6PZZcL3q0qAGBY6XZZovo1npBpoA80oKeL0otH990eaH1/Aor
        mwUWU8x6wheXOpOCCHRUMw4vqnnTIbtp5sVFeXFAj8NmLQyQRPFeZ90cMzOhOM5nSAQ4BcOJNwf6l
        MBojAoJE5V06blZJTWbbOJDmalUtiCrE0kWJXR6ocJHPxx1WOYTZ439H6IsHJAyvGC+3CXSg7n6xV
        AjTipxUkFB4liGxt3UqmTrPA1qpSFfJPjMrvWfmn3eqXSzZZFWiNxHkcHSJZLTFDyhZexhQxHzUhU
        QQ8NuTJw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qloQX-004wXX-16;
        Thu, 28 Sep 2023 10:39:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 742293002E3; Thu, 28 Sep 2023 12:39:26 +0200 (CEST)
Date:   Thu, 28 Sep 2023 12:39:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
        libc-alpha@sourceware.org, Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Noah Goldstein <goldstein.w.n@gmail.com>,
        Daniel Colascione <dancol@google.com>, longman@redhat.com,
        Florian Weimer <fweimer@redhat.com>
Subject: Re: [RFC PATCH v2 1/4] rseq: Add sched_state field to struct rseq
Message-ID: <20230928103926.GI9829@noisy.programming.kicks-ass.net>
References: <20230529191416.53955-1-mathieu.desnoyers@efficios.com>
 <20230529191416.53955-2-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529191416.53955-2-mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 03:14:13PM -0400, Mathieu Desnoyers wrote:
> Expose the "on-cpu" state for each thread through struct rseq to allow
> adaptative mutexes to decide more accurately between busy-waiting and
> calling sys_futex() to release the CPU, based on the on-cpu state of the
> mutex owner.
> 
> It is only provided as an optimization hint, because there is no
> guarantee that the page containing this field is in the page cache, and
> therefore the scheduler may very well fail to clear the on-cpu state on
> preemption. This is expected to be rare though, and is resolved as soon
> as the task returns to user-space.
> 
> The goal is to improve use-cases where the duration of the critical
> sections for a given lock follows a multi-modal distribution, preventing
> statistical guesses from doing a good job at choosing between busy-wait
> and futex wait behavior.

As always, are syscalls really *that* expensive? Why can't we busy wait
in the kernel instead?

I mean, sure, meltdown sucked, but most people should now be running
chips that are not affected by that particular horror show, no?
