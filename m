Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174447834C4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjHUVUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 17:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjHUVUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 17:20:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E8AC7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 14:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8BJjq8yqjmYPh088JAz6CoqKb0s6P0XC+U3v2FmIQUM=; b=S7rTz6dMNO1H63gjtAgM5BoygG
        irkuXiFIiP7wp0Cqo/QBe4dcmleKk75XWho+Ikva/hs3R6UzKlsgzguypxtx53pdUhTwDZcj8LQxY
        evMncg2jZ0529F8KyR9fW5p0qtOvhDcXx5XwDebj2r86/RvzObXJPmyJsg8KGPgaVmryjzgqmwdAZ
        +BAZZIq/6IXQ8KysJ/l6TObss5kUi7nm0yUdHWXhCtsoLOQZEd60xnXgYFyC5ekvkjp5aLsfhmhkJ
        oIB0rnBJdWePwag7CPqBOrK/YzL2X9md9UOzJJ4uLg4fxiIJFmLMCGM6rEAPphRdujR1XK4+SLWbH
        zL2gBkEA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qYCJj-00CTCh-B6; Mon, 21 Aug 2023 21:20:07 +0000
Date:   Mon, 21 Aug 2023 22:20:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     linux-kernel@vger.kernel.org, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, akpm@linux-foundation.org, shakeelb@google.com,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/2] fork: group allocation of per-cpu counters for mm
 struct
Message-ID: <ZOPVBz77WAfpy2xL@casper.infradead.org>
References: <20230821202829.2163744-1-mjguzik@gmail.com>
 <20230821202829.2163744-3-mjguzik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821202829.2163744-3-mjguzik@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 10:28:29PM +0200, Mateusz Guzik wrote:
> While with the patch these allocations remain a significant problem,
> the primary bottleneck shifts to:
> 
>     __pv_queued_spin_lock_slowpath+1
>     _raw_spin_lock_irqsave+57
>     folio_lruvec_lock_irqsave+91
>     release_pages+590
>     tlb_batch_pages_flush+61
>     tlb_finish_mmu+101
>     exit_mmap+327
>     __mmput+61
>     begin_new_exec+1245
>     load_elf_binary+712
>     bprm_execve+644
>     do_execveat_common.isra.0+429
>     __x64_sys_execve+50

Looking at this more closely, I don't think the patches I sent are going
to help much.  I'd say the primary problem you have is that you're trying
to free _a lot_ of pages at once on all CPUs.  Since it's the exit_mmap()
path, these are going to be the anonymous pages allocated to this task
(not the file pages it has mmaped).  The large anonymous folios work may
help you out here by decreasing the number of folios we have to manage,
and thus the length of time the LRU lock has to be held for.  It's not
an immediate solution, but I think it'll do the job once it lands.
