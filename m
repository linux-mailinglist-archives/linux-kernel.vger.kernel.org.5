Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F5C7B1316
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 08:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjI1GeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 02:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjI1Gd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 02:33:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753FC99;
        Wed, 27 Sep 2023 23:33:55 -0700 (PDT)
Date:   Thu, 28 Sep 2023 08:33:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695882832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jbKtaiDN0NbVfKqhqsxA6bvRSjMBbRA/u4q/d0oWGk8=;
        b=Dew4TATPZv8Jvo5pNfwv4I1cTWrI8SfFyrMkhlvIlbuOAQi6FbDPmVY7USc93CVIAtM1Px
        GBhE8FHvqZp5N1FttaoKiAiZMvG9xhpb3xiKpOEy3zWWyJFZ2QrMtdaPsc9TgtMYHMmZ3l
        +I8bZVmrSnLteSygehPQORUffSLirzYftpYabn6O2DTNH/lX8YVfK21/f4wVET7HfSw2bL
        d9QdSi7zpKVr2uV1I7jKY6jEVsr8Ymbx9lvLd5Utbo8RQLBq3Ow196w65vT4rXaVRE2Hw8
        UGdUWsL/4Ix6kKxe26kzqwbcbQYP1ZVM0V8mBX2ObVd2cflUXpYpfUIhqVX1XQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695882832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jbKtaiDN0NbVfKqhqsxA6bvRSjMBbRA/u4q/d0oWGk8=;
        b=jHcvqfm+BA/uMp0rvET7LREPx4dul9GF2CjfXUFjM9WZoS0C75Fj+HZae8OihnZGu0Z/zc
        H2kqFzju2Pktj7CA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        John Ogness <john.ogness@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [RFC PATCH] srcu: Use try-lock lockdep annotation for NMI-safe
 access.
Message-ID: <20230928063350.KveBSZGg@linutronix.de>
References: <20230927160231.XRCDDSK4@linutronix.de>
 <ZRUX0YUrXfepRGKE@Boquns-Mac-mini.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZRUX0YUrXfepRGKE@Boquns-Mac-mini.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-27 23:06:09 [-0700], Boqun Feng wrote:
> SRCU only has read lock usage from lockdep PoV, but after that commit,
> we annotate synchronize_srcu() as a write lock usage, so that we can
> detect deadlocks between *normal* srcu_read_lock() and
> synchronize_srcu(), however the side effect is now SRCU has a write lock
> usage from lockdep PoV.

Ach. There is a write annotation for SRCU and RCU has none. Okay that
explains it.

> Actually in the above commit, I explicitly leave
> srcu_read_lock_nmisafe() alone since its locking rules may be different
> compared to srcu_read_lock(). In lockdep terms, srcu_read_lock_nmisafe()
> is a !check read lock and srcu_read_lock() is a check read lock.

This was on v6.6-rc3 so it has the commit f0f44752f5f61 ("rcu: Annotate
SRCU's update-side lockdep dependencies").

>                                                                  Maybe
> instead of using the trylock trick, we change lockdep to igore !check
> locks for NMI context detection? Untested code as below:

Just tested, no splat for the SRCU-in-NMI usage.

Sebastian
