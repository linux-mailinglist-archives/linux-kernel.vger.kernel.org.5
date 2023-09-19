Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2C07A5CFE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjISIwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjISIwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:52:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E36128;
        Tue, 19 Sep 2023 01:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D0J+Cns0mkEWbetgv3wNhMNFLngmF0J05SNVGokTFs8=; b=Q4zp/1xVc7F+bIIs1U06af6OFD
        bHO1KEq7Qn+nbKoGHCc/YuSqafkrGq24k7iXZRUEOrinUSpwTxTR2ShMHBv0auoVzDiMJ+JWbY+BN
        etQp7Gs3QpCoCOQPr+A9XW2NOeThdlJz0KNKFLvm4m5OdDbOevzjpOUVkDL+nr25+zEpKsWTH+rDH
        rZps5Q2kO9XXYJfz98r+q982/sN2ERMqkQR9MhmO1W84XWVEmpT0q/mAFWXhOFxvuVtg9kztGzdOt
        0tIfg5CRAEwjV/FI4/lfxRsUGWDXiBd79hz49wD1Kq072LKL5FSFsT1bxHThgohfVovlDC268HnkY
        czcYnIaw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qiWQ7-00DT7s-1W;
        Tue, 19 Sep 2023 08:51:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8F86430042E; Tue, 19 Sep 2023 10:49:24 +0200 (CEST)
Date:   Tue, 19 Sep 2023 10:49:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Matthew Wilcox <willy@infradead.org>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2] kernel/sched: Modify initial boot task idle setup
Message-ID: <20230919084924.GB21729@noisy.programming.kicks-ass.net>
References: <20230915174444.2835306-1-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915174444.2835306-1-Liam.Howlett@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 01:44:44PM -0400, Liam R. Howlett wrote:
> Initial booting is setting the task flag to idle (PF_IDLE) by the call
> path sched_init() -> init_idle().  Having the task idle and calling
> call_rcu() in kernel/rcu/tiny.c means that TIF_NEED_RESCHED will be
> set.  Subsequent calls to any cond_resched() will enable IRQs,
> potentially earlier than the IRQ setup has completed.  Recent changes
> have caused just this scenario and IRQs have been enabled early.
> 
> This causes a warning later in start_kernel() as interrupts are enabled
> before they are fully set up.
> 
> Fix this issue by setting the PF_IDLE flag later in the boot sequence.
> 
> Although the boot task was marked as idle since (at least) d80e4fda576d,
> I am not sure that it is wrong to do so.  The forced context-switch on
> idle task was introduced in the tiny_rcu update, so I'm going to claim
> this fixes 5f6130fa52ee.
> 
> Link: https://lore.kernel.org/linux-mm/87v8cv22jh.fsf@mail.lhotse/
> Link: https://lore.kernel.org/linux-mm/CAMuHMdWpvpWoDa=Ox-do92czYRvkok6_x6pYUH+ZouMcJbXy+Q@mail.gmail.com/
> Fixes: 5f6130fa52ee ("tiny_rcu: Directly force QS when call_rcu_[bh|sched]() on idle_task")
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---

Thanks!, I've queued this up for sched/urgent but will let the robots at
it before I push it out to -tip.


