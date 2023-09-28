Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58697B262D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 21:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjI1Tzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 15:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjI1Tz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 15:55:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46214F7;
        Thu, 28 Sep 2023 12:55:25 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695930921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dSvz8T6itr9FWR99Rys1NQjiPi4ExBzhoF5Qj7BihzY=;
        b=mjs6qexrVugU8k/lQ/2ebrfLj20C51JXiWSJ8xPNBWzRCSwGzngkjmcR+JR/ONH6yw7ktS
        hGkLzkBsJ7WgbYQw8ayPdfzxVmHzEoG9xKXR1ePgshxqAfopx8aOiuM3fbAqyeVrHcPI1l
        WRSBf9pL0dkkVd8AQCQ2VEajkV98Hu3LtZ+9EldKhcP0F6V/qmkp4RKeTGzvCH9KJJ1sTT
        Q2d1WG+LhtySbtafDxMHHxQFKeQh9v/sTaKKs2iVwgWNlo0j0hx9LshO5WJTKrWR6Q0oe5
        fFqmFF3l+mYiUaIoxhJg4U374ZzOVbtDsKW5s3AlVUnwa7wHC+1sFy0vIX/K+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695930921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dSvz8T6itr9FWR99Rys1NQjiPi4ExBzhoF5Qj7BihzY=;
        b=SpRahioNiaI5Gp8+sh8rdf76ZN2sFe6jyj/bug/FR6ZFkzyBWsAIB05ujDbsTrgCEkmVk7
        jYB8I/j7gDCHzXBw==
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?utf-8?Q?An?= =?utf-8?Q?dr=C3=A9?= Almeida 
        <andrealmeid@igalia.com>, libc-alpha@sourceware.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Noah Goldstein <goldstein.w.n@gmail.com>,
        Daniel Colascione <dancol@google.com>, longman@redhat.com,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH v2 4/4] selftests/rseq: Implement rseq_mutex test
 program
In-Reply-To: <20230529191416.53955-5-mathieu.desnoyers@efficios.com>
References: <20230529191416.53955-1-mathieu.desnoyers@efficios.com>
 <20230529191416.53955-5-mathieu.desnoyers@efficios.com>
Date:   Thu, 28 Sep 2023 21:55:20 +0200
Message-ID: <87v8budqdz.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29 2023 at 15:14, Mathieu Desnoyers wrote:
> +static void rseq_lock_slowpath(struct rseq_mutex *lock)
> +{
> +	int i = 0;
> +
> +	for (;;) {
> +		struct rseq_abi_sched_state *expected = NULL, *self = rseq_get_sched_state(rseq_get_abi());
> +
> +		if (__atomic_compare_exchange_n(&lock->owner, &expected, self, false,
> +						__ATOMIC_ACQUIRE, __ATOMIC_RELAXED))
> +			break;
> +		//TODO: use rseq critical section to protect dereference of owner thread's
> +		//rseq_abi_sched_state, combined with rseq fence at thread reclaim.
> +		if ((RSEQ_READ_ONCE(expected->state) & RSEQ_ABI_SCHED_STATE_FLAG_ON_CPU) &&

For robust and PI futexes the futex value is an ABI between kernel and
user space. Sure, this is only meant for demonstration, but it's the
wrong direction.

Thanks,

        tglx






