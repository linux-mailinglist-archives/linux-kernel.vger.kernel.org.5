Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D94E77DD8A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 11:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243443AbjHPJnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 05:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243304AbjHPJnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:43:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A1513E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 02:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9tBh8YZnHJRmwQirAC6iVUYo9SGPgNOE19QJmeUHp0o=; b=R0/KWNsvaMh6SZKVoRYeSLDXep
        T5T8uT5SgcKsQ/yQxEdLUZm7wkcEWYPyTwck1P291rxM1A7tPPLTdNalq0zXajjc3YFQeimrPGx2O
        vLR/rFH7HnpqzK+1BKMuFr5Byn9/QFlLe2IlaWtWXDTHAaywxtmRLXD3xXkZZpiGmBblMhaMLQRNg
        ByJAJYU2rRAN16papDZWx6hLpgWia1grCvKWyTNLPRss2EJH6nA99bNxeDpDYZsCXD+tAZuGeGg3c
        2SbEwW2r1FcyU7Y5arwbGe7bRqXKZaFoQxzlYRymYZRXhRSGh/ZJm5Mxovss6YWPM++aorQz+UlZN
        frDSBcaw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qWD3J-00Dv9y-LM; Wed, 16 Aug 2023 09:42:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3C11C30020C;
        Wed, 16 Aug 2023 11:42:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1EC802C8D7776; Wed, 16 Aug 2023 11:42:57 +0200 (CEST)
Date:   Wed, 16 Aug 2023 11:42:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bsegall@google.com, boqun.feng@gmail.com, swood@redhat.com,
        bristot@redhat.com, dietmar.eggemann@arm.com, mingo@redhat.com,
        jstultz@google.com, juri.lelli@redhat.com, mgorman@suse.de,
        rostedt@goodmis.org, vschneid@redhat.com,
        vincent.guittot@linaro.org, longman@redhat.com, will@kernel.org
Subject: Re: [PATCH 0/6] locking/rtmutex: Avoid PI state recursion through
 sched_submit_work()
Message-ID: <20230816094257.GE980931@hirez.programming.kicks-ass.net>
References: <20230815110121.117752409@infradead.org>
 <20230815161557.GK214207@hirez.programming.kicks-ass.net>
 <20230816085826.zfXjhNmj@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816085826.zfXjhNmj@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 10:58:26AM +0200, Sebastian Andrzej Siewior wrote:
> On 2023-08-15 18:15:57 [+0200], Peter Zijlstra wrote:
> > N/m - 0day found a problem. Futex-PI trips the rt_mutex_schedule()
> > assertion for not passing through rt_mutex_pre_schedule().
> > 
> > I'll go try and untangle that...
> Is this the same as

Not the same -- this is namespace_lock(), right? That's a regular rwsem
afaict and that *should* be good. Clearly I messed something up.

Thanks!

> | ------------[ cut here ]------------
> | WARNING: CPU: 3 PID: 995 at kernel/sched/core.c:7155 rt_mutex_schedule+0x52/0x60
> | Modules linked in:
> | CPU: 3 PID: 995 Comm: mount Tainted: G        W          6.5.0-rc6-rt2+ #228
> | Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> | RIP: 0010:rt_mutex_schedule+0x52/0x60
> | Code: 00 00 00 e8 b0 80 ff ff 31 ff e8 a9 99 cb 00 bf 01 00 00 00 e8 3f 6d ff ff 48 8b 03 a9 08 00 08 00 75 db 5b e9 6f 82 cc 00 90 <0f> 0b 90 eb c6 66 0f 1f 84 00 00 0
> | RSP: 0018:ffffc90001043e28 EFLAGS: 00010246
> | RAX: ffff888107ab8040 RBX: 0000000000000202 RCX: 0000000000000000
> | RDX: 0000000000000000 RSI: ffffffff82460bfd RDI: 00000000ffffffff
> | RBP: ffffffff827e8fe0 R08: 0000000000000001 R09: 0000000000000001
> | R10: 0000000000000000 R11: 0000000000000001 R12: ffffffff827e8fe8
> | R13: 0000000000000002 R14: 0000000000000000 R15: ffff888107ab8040
> | FS:  00007fb36281e840(0000) GS:ffff88817b4c0000(0000) knlGS:0000000000000000
> | CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> | CR2: 00007fb3629702a0 CR3: 0000000108210000 CR4: 00000000003506e0
> | Call Trace:
> |  <TASK>
> |  ? __warn+0x90/0x200
> |  ? rt_mutex_schedule+0x52/0x60
> |  ? report_bug+0x1c5/0x1f0
> |  ? handle_bug+0x3b/0x70
> |  ? exc_invalid_op+0x13/0x60
> |  ? asm_exc_invalid_op+0x16/0x20
> |  ? rt_mutex_schedule+0x52/0x60
> |  rwbase_write_lock+0xc1/0x230
> |  do_lock_mount+0x4c/0x200
> |  ? __x86_return_thunk+0x5/0x10
> |  path_mount+0x8a7/0xb00
> |  __x64_sys_mount+0xf1/0x140
> |  do_syscall_64+0x44/0x90
> |  entry_SYSCALL_64_after_hwframe+0x74/0xde
> 
> Sebastian
