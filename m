Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F957B15BA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjI1IJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjI1IJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:09:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF5192;
        Thu, 28 Sep 2023 01:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J3atQWxYv516rGAsTWQWrekcnTVWQgdCD2qn0DOCtlc=; b=pnCohN7+ceUcVO2SKAY4uzXR4q
        PveV2LWQXH1JKKnR/ndaTmVoZU3f+wvfurcG7U2LfGyhbLVUQ+2FlP2QXjvRT/fpyurrD3BnEda5T
        1EaaBdh7E0fgn2kheitEvLZsz0cNEFE4Z7q851G/8R6MMjU0Q/IQKadQxPnynTAl9jy5k5vRUazPX
        nmW8NZGimlnEMJlZhrE+IuWSuwCIzaluTo0hB0PA/BD+lM2bRdbf3v54/0K0Au3QK6Yenm2cR1nxR
        kBhWQU5XukCwGfbbaLFEFXeesTiTHAR4aWr6SPIeNZR9FG90bnUcm0206qXQB2aBnBfLgxVwhyIZy
        /RARU8/g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qlm4z-001K5l-AM; Thu, 28 Sep 2023 08:09:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id F36B1300288; Thu, 28 Sep 2023 10:09:00 +0200 (CEST)
Date:   Thu, 28 Sep 2023 10:09:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        John Ogness <john.ogness@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [RFC PATCH] srcu: Use try-lock lockdep annotation for NMI-safe
 access.
Message-ID: <20230928080900.GF9829@noisy.programming.kicks-ass.net>
References: <20230927160231.XRCDDSK4@linutronix.de>
 <ZRUX0YUrXfepRGKE@Boquns-Mac-mini.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRUX0YUrXfepRGKE@Boquns-Mac-mini.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 11:06:09PM -0700, Boqun Feng wrote:

> I think this is a "side-effect" of commit f0f44752f5f6 ("rcu: Annotate
> SRCU's update-side lockdep dependencies"). In verify_lock_unused(), i.e.
> the checking for NMI lock usages, the logic is that

I think I'm having a problem with this commit -- that is, by adding
lockdep you're adding tracepoint, which rely on RCU being active.

The result is that SRCU is now no longer usable from !RCU regions.

Was this considered and intended?

