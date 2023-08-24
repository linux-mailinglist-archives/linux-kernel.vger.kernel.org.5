Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83825786C21
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240660AbjHXJiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240857AbjHXJhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:37:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1F0CD5;
        Thu, 24 Aug 2023 02:37:43 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692869861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8FJ98OgH9T9QKg7dl2+I7VOlMigcXRv1vg0KHRHALbQ=;
        b=bCQRYCPfCH8MlCBO0XiiD5I8dRp2w6etgD/Oz/u7xOyIgg7XR5Y/LKLD2UcRVIgaPH7xwF
        Y+s3y+eRWteiovtDOKDockv8qNUM1hOd9SE5M+aFXLSVq5tQYt1zjtsQPSdd8piyzDNLly
        zBHaHJLMz3Lojyh09q9G+fb3sxukjps/WdeNQFu3PpIU0tWv1d8zaz206pk6vCFtcEAVMm
        C51vmC9XTkOYHvWJ5bSN7t/y6pgCtmotUoRDGbbzNQiHCGoD473gBeZqTIY08u2SM+xZUH
        vnqHcpP19nX8UrN8NyBNShKPRVSc8Au8qmJxegJSFpZ6xqhGloBINCKhtdwlXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692869861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8FJ98OgH9T9QKg7dl2+I7VOlMigcXRv1vg0KHRHALbQ=;
        b=ILfLpyht+UselfK48GdAWhPKOq92wZvdwsjBBqohZZdDaI+WdNpRzMZ5JkzRBT8DqPmhY3
        pyPtIhXzIUPrkIAw==
To:     Huacai Chen <chenhuacai@loongson.cn>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        chenhuacai@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>,
        stable@vger.kernel.org, Binbin Zhou <zhoubinbin@loongson.cn>
Subject: Re: [PATCH V3] rcu: Update jiffies locally in rcu_cpu_stall_reset()
In-Reply-To: <20230822040248.329442-1-chenhuacai@loongson.cn>
References: <20230822040248.329442-1-chenhuacai@loongson.cn>
Date:   Thu, 24 Aug 2023 11:37:41 +0200
Message-ID: <87lee0dbmi.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22 2023 at 12:02, Huacai Chen wrote:
> + * This function may be called in NMI context, so we cannot use ktime_get_ns()
> + * and ktime_get_coarse_ns(). Instead, we use their inaccurate but safe friends
> + * ktime_get_mono_fast_ns() and ktime_get_seconds() which will cause rcu_state.
> + * jiffies_stall to be a little large than expected (harmless and safer).

What's inaccurate about ktime_get_mono_fast_ns()? Bogus comments are
even worse than no comments.

>   */
>  void rcu_cpu_stall_reset(void)
>  {
> +	u64 curr, last, delta;
> +
> +	curr = ktime_get_mono_fast_ns();
> +	last = ktime_get_seconds() * NSEC_PER_SEC;

So this will trigger a warning when someone debugs suspend with KGDB.

It seems the approach taken here seems to be to throw stuff at the wall
and see what sticks.

Thanks,

        tglx
