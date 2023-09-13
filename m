Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D61179E877
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240707AbjIMM6l convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Sep 2023 08:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240702AbjIMM6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:58:37 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB5D1BC0;
        Wed, 13 Sep 2023 05:58:33 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-59b50b4556eso56721467b3.1;
        Wed, 13 Sep 2023 05:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694609913; x=1695214713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xxeNViXmBE9aJ+D4KbNZSYMYxw6j4hA0qNGsj2aEsME=;
        b=kyuaAuXLzBMP7wXGC80ipYMrJS++U0XsRbZYcIklrU0TNkE2nRe5K41jwgICDu1QfF
         XwiF713A8bktUb1V6BPVWSgCBbYxtxTZICSS5D5xoImx9YaNI1nA5A2tr+N5o7dEz5Zg
         Tv9OHKzXtQBbk650pFA5JPbxM1DTe8T3PY8ft9w6jP/T9DJ67ysAV7AtyK2dnOiEaI/r
         SSFYaA902LbNe9YVm5UBqmr41/WhQOSg1MLIyGBOhNY6Y5B+6KDnaBctvkr0HJbKy1Ky
         nVctHDajh8AlqWZrllPiFLE1jEbOVxtu3GF65b0zt0DhJnMeaGNoJwVy/dO8bIarsnd8
         ZtBw==
X-Gm-Message-State: AOJu0YzWYO+T/rBmF25BM//DJaiqTFN6EOr46uYViMQVkZ7kaCbRGTFc
        U9UrXP071G4SoQPONAh4R28YHi/AjTKxJg==
X-Google-Smtp-Source: AGHT+IE76qCHLbIm5rUON3SZXJ87b4QDB0bEPEY8AZf1iGku3FNeM1M4/iC8YI3s0XhwcbcwfDwJxQ==
X-Received: by 2002:a81:5f45:0:b0:581:5cb9:6c2b with SMTP id t66-20020a815f45000000b005815cb96c2bmr2542003ywb.45.1694609912779;
        Wed, 13 Sep 2023 05:58:32 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id b65-20020a0df244000000b005869fd2b5bcsm3119414ywf.127.2023.09.13.05.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 05:58:32 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-d8164e661abso447866276.1;
        Wed, 13 Sep 2023 05:58:32 -0700 (PDT)
X-Received: by 2002:a25:c7cb:0:b0:d7f:8e1f:6df0 with SMTP id
 w194-20020a25c7cb000000b00d7f8e1f6df0mr2208489ybe.2.1694609912250; Wed, 13
 Sep 2023 05:58:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230913005647.1534747-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230913005647.1534747-1-Liam.Howlett@oracle.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Sep 2023 14:58:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWR68a49=vthdp03stpvaHLS5BRa+rhVdnr7gQDFkNotQ@mail.gmail.com>
Message-ID: <CAMuHMdWR68a49=vthdp03stpvaHLS5BRa+rhVdnr7gQDFkNotQ@mail.gmail.com>
Subject: Re: [PATCH] init/main: Clear boot task idle flag
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Matthew Wilcox <willy@infradead.org>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liam,

On Wed, Sep 13, 2023 at 2:57 AM Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
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
> Fix this issue by clearing the PF_IDLE flag on return from sched_init()
> and restore the flag in rest_init().  Although the boot task was marked
> as idle since (at least) d80e4fda576d, I am not sure that it is wrong to
> do so.  The forced context-switch on idle task was introduced in the
> tiny_rcu update, so I'm going to claim this fixes 5f6130fa52ee.
>
> Link: https://lore.kernel.org/linux-mm/87v8cv22jh.fsf@mail.lhotse/
> Link: https://lore.kernel.org/linux-mm/CAMuHMdWpvpWoDa=Ox-do92czYRvkok6_x6pYUH+ZouMcJbXy+Q@mail.gmail.com/
> Fixes: 5f6130fa52ee ("tiny_rcu: Directly force QS when call_rcu_[bh|sched]() on idle_task")
> Cc: stable@vger.kernel.org
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Andreas Schwab <schwab@linux-m68k.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Peng Zhang <zhangpeng.00@bytedance.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Thanks for your patch!

This fixes the

      WARNING: CPU: 0 PID: 0 at init/main.c:992 start_kernel+0x2f0/0x480

I was seeing during boot on Renesas RZ/A1 and RZ/A2 since commit
cfeb6ae8bcb96ccf ("maple_tree: disable mas_wr_append() when other
readers are possible") in v6.5.

However, this causes lots of new warnings on e.g. R-Car M2-W, which
wasn't affected before, like:

+BUG: sleeping function called from invalid context at
kernel/sched/completion.c:111
+in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1, name: swapper/0
+preempt_count: 0, expected: 0
+no locks held by swapper/0/1.
+CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W
6.6.0-rc1-koelsch-02359-g9a5bed6a8bd8 #1864
+Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
+ unwind_backtrace from show_stack+0x10/0x14
+ show_stack from dump_stack_lvl+0x68/0x90
+ dump_stack_lvl from __might_resched+0x1b0/0x22c
+ __might_resched from __wait_for_common+0x38/0x170
+ __wait_for_common from kernel_init+0x10/0x130
+ kernel_init from ret_from_fork+0x14/0x30
+Exception stack(0xf0815fb0 to 0xf0815ff8)
+5fa0:                                     00000000 00000000 00000000 00000000
+5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
+5fe0: 00000000 00000000 00000000 00000000 00000013 00000000

and

+BUG: sleeping function called from invalid context at
kernel/locking/mutex.c:580
+in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1, name: systemd
+preempt_count: 0, expected: 0
+no locks held by systemd/1.
+CPU: 1 PID: 1 Comm: systemd Tainted: G        W        N
6.6.0-rc1-koelsch-02359-g9a5bed6a8bd8 #1864
+Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
+ unwind_backtrace from show_stack+0x10/0x14
+ show_stack from dump_stack_lvl+0x68/0x90
+ dump_stack_lvl from __might_resched+0x1b0/0x22c
+ __might_resched from __mutex_lock+0x34/0x3a8
+ __mutex_lock from mutex_lock_nested+0x18/0x20
+ mutex_lock_nested from do_epoll_wait+0x220/0x5ac
+ do_epoll_wait from sys_epoll_wait+0x44/0x6c
+ sys_epoll_wait from ret_fast_syscall+0x0/0x1c
+Exception stack(0xf0815fa8 to 0xf0815ff0)
+5fa0:                   beff75e0 00000004 00000004 beff75e0 0000003b ffffffff
+5fc0: beff75e0 00000004 ffffffff 000000fc 00000000 ffffffff 0000003b 00000004
+5fe0: 000000fc beff75b8 b6ef8511 b6e75786

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
