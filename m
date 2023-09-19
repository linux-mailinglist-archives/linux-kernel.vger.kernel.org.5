Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07CC7A5F1A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjISKLp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 19 Sep 2023 06:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjISKLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:11:42 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD68BF1;
        Tue, 19 Sep 2023 03:11:36 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-59e88a28b98so34265927b3.1;
        Tue, 19 Sep 2023 03:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695118295; x=1695723095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYqZKFJbKh5757ZqCWdgT+gGsUEEZwvBEuN7rACzqNc=;
        b=C5XwvoAJknhcSuf12TsSQPcCElmjlsz2nDVkLTsCRclO6rupMuoLBQd+5NoIotH2w2
         ZpkgGyrRDFPHRTg1bgVfwQfHicj28iCYErz02QKusH2Us6P3sFXqM5uUdNqyxRGff8mY
         Gw6m1SCYh0MzBUwJoDO22luGcBUXPvfcHh75GwRPcB8/sTXrOnPaT6CNUpUFGT98zy3u
         BbNIG/qTT3zw562Uy332K/1h768kzTMj+J28T34b/M8/lHSow5fWqkw6oQPNGwLGVFHo
         uPvtGt6aAcgsqzooNI3aRLAzaAYsBXALr9CKq13yaYHdl+pSfqhcMQ/sjmooH9A8FTYs
         hCVQ==
X-Gm-Message-State: AOJu0YxMQlsjTmDqw8thVsTZPUaS1G2l5NI/EkhCjfuXqJzwo2Z0tC1t
        hyq5/AxIsOp/iWTPxM+DBN0iGDQO6tuD+A==
X-Google-Smtp-Source: AGHT+IGTmjckLSX5BXo3pLx4BnWkgM6omU7LEGUJqirGKpNsYBoZ5HsUURM4RUIOek0EkhhqpcbDSw==
X-Received: by 2002:a81:9115:0:b0:56d:4d1e:74ab with SMTP id i21-20020a819115000000b0056d4d1e74abmr2582291ywg.23.1695118295663;
        Tue, 19 Sep 2023 03:11:35 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id v129-20020a814887000000b0059b516ed11fsm3138871ywa.110.2023.09.19.03.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 03:11:34 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-58dce1f42d6so88990867b3.0;
        Tue, 19 Sep 2023 03:11:33 -0700 (PDT)
X-Received: by 2002:a81:a04b:0:b0:577:3cd0:3728 with SMTP id
 x72-20020a81a04b000000b005773cd03728mr2309678ywg.14.1695118293278; Tue, 19
 Sep 2023 03:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230915174444.2835306-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230915174444.2835306-1-Liam.Howlett@oracle.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Sep 2023 12:11:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWBsTC6F3YK+dzRd4OD+4BsVWNVujPtdR1Zhbz=7oNcYA@mail.gmail.com>
Message-ID: <CAMuHMdWBsTC6F3YK+dzRd4OD+4BsVWNVujPtdR1Zhbz=7oNcYA@mail.gmail.com>
Subject: Re: [PATCH v2] kernel/sched: Modify initial boot task idle setup
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liam,

On Fri, Sep 15, 2023 at 7:45 PM Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
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

And unlike v1, this does not cause lots of new warnings on e.g. R-Car M2-W.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
