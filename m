Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36716791F03
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 23:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238722AbjIDVXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 17:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbjIDVXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 17:23:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D644E12E;
        Mon,  4 Sep 2023 14:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+bXo/OOfabGOhpwY+ygPsWhPvhQ+9/AictARt51sgQE=; b=Gj6uvdLJogXXAcm8J+bFMi6Nbz
        sq0Zzvz0/2jxJCy6lK9kkNtY9YgF/tVV/bTdXbZklKH9zpOt7cPXpXmjUJkk0fy7QJLOO9NPb1CCC
        WPYJmTydXu/6YYhdRxObIs0NFxiicCsluhhVjDt5G/4MloQ7vWodUodqcCBRbYaEWjvc8TGD2aCl7
        /I1Xy9shKfPrEtluvuuN0sS6Iqw9TRySMK3gQouX8zN54jt45+tiJp4b0DTP4FjCi6wO8TKi1OqOm
        ETVZKxP6+bi1dVe7MgU6y6VJUOqAHUwI5GUvGBuZ2tWz8NRe2zk0Bpp4hm88SENerGUOxc0GhwjNN
        PqLLqh/Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qdH2b-002WR7-0g; Mon, 04 Sep 2023 21:23:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8B6F3300642; Mon,  4 Sep 2023 23:23:24 +0200 (CEST)
Date:   Mon, 4 Sep 2023 23:23:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>, kernel@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Prakash Viswalingam <quic_prakashv@quicinc.com>
Subject: Re: [PATCH v2] freezer,sched: Use saved_state to reduce some
 spurious wakeups
Message-ID: <20230904212324.GA2568@noisy.programming.kicks-ass.net>
References: <20230830-avoid-spurious-freezer-wakeups-v2-1-8877245cdbdc@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830-avoid-spurious-freezer-wakeups-v2-1-8877245cdbdc@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 10:42:39AM -0700, Elliot Berman wrote:

> Avoid the spurious wakeups by saving the state of TASK_FREEZABLE tasks.
> If the task was running before entering TASK_FROZEN state
> (__refrigerator()) or if the task received a wake up for the saved
> state, then the task is woken on thaw. saved_state from PREEMPT_RT locks
> can be re-used because freezer would not stomp on the rtlock wait flow:
> TASK_RTLOCK_WAIT isn't considered freezable.

You don't actually assert that anywhere I think, so the moment someone
makes that happen you crash and burn.

Also:

> -#ifdef CONFIG_PREEMPT_RT
> +#if IS_ENABLED(CONFIG_PREEMPT_RT) || IS_ENABLED(CONFIG_FREEZER)

That makes wakeup more horrible for everyone :/
