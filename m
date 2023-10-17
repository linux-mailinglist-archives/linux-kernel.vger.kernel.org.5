Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4AA67CCBC8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344096AbjJQTHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjJQTHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:07:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E7AF7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 12:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HYaPsoYdaMrxJQb9Bpv9wx1lbwppH+cIKicdgwTndWI=; b=mcE9g/COj38TT9d5fjAbAkPoaH
        ax35fUTSy7/rLO3IgCYQVtyONf45rEiHtl7Ge0F5QaJvmDyYCndXiD6KXr3Wn2kKdRf1CR+MC1eMy
        ajhDcyVSyceh2QF0lhWly55FyWMiF/MhnqoTIjBRcRLkj7eLiz6FPtj2pYAoZHsnPnCZ/ksJGRHY3
        VatfTcZddiuctDRM6menaOX5wM4BLa7i8i54X4qfg//hAsti5aXR/xi6Gmz/2lJaKM9wHZRp7HlRz
        7JVVPoHPzPI8ymfXAXB2MBJ45zoLqc+G99FJDdxhO8bVz56H1Q6ogi1NeJ7vKN71pUnQXf+SmOEOV
        W8KpK99A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qspPL-00E1yC-CJ; Tue, 17 Oct 2023 19:07:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0F94230047C; Tue, 17 Oct 2023 21:07:11 +0200 (CEST)
Date:   Tue, 17 Oct 2023 21:07:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Safonov <0x7f454c46@gmail.com>
Cc:     mingo@kernel.org, frederic@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de,
        syzbot <syzbot+3908cdfd655fd839c82f@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [kernel?] KASAN: slab-use-after-free Read in
 reweight_entity
Message-ID: <20231017190710.GF1599@noisy.programming.kicks-ass.net>
References: <0000000000004b632f0607d07fb0@google.com>
 <CAJwJo6ZGXO07=QvW4fgQfbsDzQPs9xj5sAQ1zp=mAyPMNbHYww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJwJo6ZGXO07=QvW4fgQfbsDzQPs9xj5sAQ1zp=mAyPMNbHYww@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 07:58:56PM +0100, Dmitry Safonov wrote:
> FWIW,
> Managed to locally reproduce it twice on 58720809f527 (tag: v6.6-rc6)
> Linux 6.6-rc6 + TCP-AO patches on the top.
> (but can't reproduce reliably at will)
> 
> [dima@Mindolluin linux-tcp-ao]$ ./scripts/faddr2line vmlinux
> reweight_entity+0x3b0/0x490
> reweight_entity+0x3b0/0x490:

Could you please try:

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=sched/urgent&id=a3b75dce9d9ae4510ea75b655567f50622f48706


---
Subject: sched/eevdf: Fix heap corruption more
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue Oct 17 16:59:47 CEST 2023

Because someone is a flaming idiot... :/

Fixes: 8dafa9d0eb1a ("sched/eevdf: Fix min_deadline heap integrity")
Reported-by: 0599jiangyc@gmail.com
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218020
---
 kernel/sched/fair.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3699,7 +3699,8 @@ static void reweight_entity(struct cfs_r
 		 */
 		deadline = div_s64(deadline * old_weight, weight);
 		se->deadline = se->vruntime + deadline;
-		min_deadline_cb_propagate(&se->run_node, NULL);
+		if (se != cfs_rq->curr)
+			min_deadline_cb_propagate(&se->run_node, NULL);
 	}
 
 #ifdef CONFIG_SMP
