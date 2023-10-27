Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB8D7DA13B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 21:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbjJ0TUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 15:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjJ0TUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 15:20:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A2E186;
        Fri, 27 Oct 2023 12:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fJJP+jvnbdOicjB5+lM50yNyHr0lxM58vJLUjNNi0LY=; b=Tu5c51T0HmiNseo1Iox3QQdnI2
        fpEeTvxbeV0AhehMpFbTnqVYn4wZvh48XdA0wYfBqL6kNv2DnXCODm0t+Z+mqkQIyOZKme8yRKY4O
        hRIpXk8FORVwInmS3l51gvNWFvHtHnjE5hFjmCXTrTbo+rg6svl3dXHoIgyFpBz3i4Pwfkn1rErhV
        L0kx/0JfnCmJ8UEyC1aiNp9wQgkrr3s6k5BcB28PJ9am9q6q9Ajo9GRIKWFUiJVKnHL8kIHmpW+83
        MOOqLnwkzg3MXxRB7xEloRd0Vio7HKsU8Er51BzsWoChOoIQK2ti3NNqMyRiTvrvzV2FktqzfLt0V
        L6gjU8bQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qwSNe-0056gj-Mz; Fri, 27 Oct 2023 19:20:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D09D300392; Fri, 27 Oct 2023 21:20:26 +0200 (CEST)
Date:   Fri, 27 Oct 2023 21:20:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Zqiang <qiang.zhang1211@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH 2/4] rcu/tasks: Handle new PF_IDLE semantics
Message-ID: <20231027192026.GG26550@noisy.programming.kicks-ass.net>
References: <20231027144050.110601-1-frederic@kernel.org>
 <20231027144050.110601-3-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027144050.110601-3-frederic@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 04:40:48PM +0200, Frederic Weisbecker wrote:

> +	/* Has the task been seen voluntarily sleeping? */
> +	if (!READ_ONCE(t->on_rq))
> +		return false;

> -	if (t != current && READ_ONCE(t->on_rq) && !is_idle_task(t)) {

AFAICT this ->on_rq usage is outside of scheduler locks and that
READ_ONCE isn't going to help much.

Obviously a pre-existing issue, and I suppose all it cares about is
seeing a 0 or not, irrespective of the races, but urgh..
