Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A66678345C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjHUUoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 16:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbjHUUn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 16:43:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C393CE5C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 13:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CfTLPs2L3oXCEz4CISXc6ITznDvMqhqDEKATU13XeAg=; b=V4YMFgC+g4OYRPMeH0zXq1bZJF
        qG5C+S3Ngm28nQlUZn3lvhSkzHWIJdcrGZvk/lpmZP6hzWud24Z++6b2EUcni7q+qoTOaZEx0l2gV
        henrEYKyXUzFpVavviPNHhdJgc/W60ra8efyrauieBwmSHcjquuuSemaYG3J6oVCFtKwrlsvJ+ik3
        BJD/ite8thS/THZnzL3yUvcZ/nTV9MJtJMjSr9TSHfgZ3WJlytR5wybA414gylmbbeDdc9vfiKcBc
        9HfM0BMIYN1RqQ2O4TP5aHVlmcLFqbq86ieHwEyvFCbXWfzFLhScC2uUS73Kr54FtQLmcq38BeiY2
        Ud7VuahA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qYBjL-00CIfE-TN; Mon, 21 Aug 2023 20:42:31 +0000
Date:   Mon, 21 Aug 2023 21:42:31 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     linux-kernel@vger.kernel.org, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, akpm@linux-foundation.org, shakeelb@google.com,
        linux-mm@kvack.org
Subject: Re: [PATCH 0/2] execve scalability issues, part 1
Message-ID: <ZOPMNyZ3gKb/bdjO@casper.infradead.org>
References: <20230821202829.2163744-1-mjguzik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821202829.2163744-1-mjguzik@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 10:28:27PM +0200, Mateusz Guzik wrote:
> > While with the patch these allocations remain a significant problem,
> > the primary bottleneck shifts to:
> > 
> >     __pv_queued_spin_lock_slowpath+1
> >     _raw_spin_lock_irqsave+57
> >     folio_lruvec_lock_irqsave+91
> >     release_pages+590
> >     tlb_batch_pages_flush+61
> >     tlb_finish_mmu+101
> >     exit_mmap+327
> >     __mmput+61
> >     begin_new_exec+1245
> >     load_elf_binary+712
> >     bprm_execve+644
> >     do_execveat_common.isra.0+429
> >     __x64_sys_execve+50
> >     do_syscall_64+46
> >     entry_SYSCALL_64_after_hwframe+110
> 
> I intend to do more work on the area to mostly sort it out, but I would
> not mind if someone else took the hammer to folio. :)

Funny you should ask ... these patches are from ~3 weeks ago.  They may
or may not apply to a current tree, but I'm working on this area.
