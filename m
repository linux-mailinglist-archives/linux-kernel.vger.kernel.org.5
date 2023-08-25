Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCD9788C40
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbjHYPOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 11:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbjHYPO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:14:26 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3002F212A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 08:14:23 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7926de0478eso45330439f.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 08:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692976462; x=1693581262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dWU0nxXevjdvt6ghvXCB5FvF1502/TurOTI/7ffia4=;
        b=aBuf5RubsHh31z/H7yKG5gX/hueMb9Z2h1P1PsWJacivaBW+vz0FKtEtn2DmLMTYUn
         biFEmqS3HB/ejWUEi/jmWISe7tN+/Phi8n4tpFkJ3jbPQt4+BdcUHWHYme9JVfMHKYK5
         bkt7zTiELAQ2OyRtdgOcVmVlpj3UW0l6LSpSm0rjEKXwDtLtIt7ZKmmRRXwOqDrR0EtW
         v78tPDYkLCsunj+aJYQ0kYCmjPZWetVXokf73BHg/OfwSlpy3x9GJUe7ohWlgz2gsPnU
         7e8RamGFqLrsJtnjgCVx2sNABzAEZCQkKcbZ9HKAtMNy8CYt5IdEe9xlNvOTBGarOTnZ
         ePYw==
X-Gm-Message-State: AOJu0YyKvMJc4aDl9/oY/zNcJMOgCoYXaNiHkuUcs1T2svCT3jPAJ2cO
        /zS9FzvKdgdZWumNiXDN0ZU=
X-Google-Smtp-Source: AGHT+IF1KJ987vueX2tYfk71qttW5eCsvu1f86s9JhMG5zr1nirKlA2jkP4qzpJF24em7mkkxBGp7w==
X-Received: by 2002:a05:6e02:1806:b0:348:d683:36bf with SMTP id a6-20020a056e02180600b00348d68336bfmr8732710ilv.12.1692976462178;
        Fri, 25 Aug 2023 08:14:22 -0700 (PDT)
Received: from snowbird (c-73-228-235-230.hsd1.mn.comcast.net. [73.228.235.230])
        by smtp.gmail.com with ESMTPSA id gg13-20020a056638690d00b0042fec8620e4sm558615jab.57.2023.08.25.08.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 08:14:21 -0700 (PDT)
Date:   Fri, 25 Aug 2023 08:14:19 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, shakeelb@google.com,
        vegard.nossum@oracle.com, linux-mm@kvack.org
Subject: Re: [PATCH v3 0/2] execve scalability issues, part 1
Message-ID: <ZOjFSwGNxMDT6bqm@snowbird>
References: <20230823050609.2228718-1-mjguzik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823050609.2228718-1-mjguzik@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Aug 23, 2023 at 07:06:07AM +0200, Mateusz Guzik wrote:
> To start I figured I'm going to bench about as friendly case as it gets
> -- statically linked *separate* binaries all doing execve in a loop.
> 
> I borrowed the bench from here:
> http://apollo.backplane.com/DFlyMisc/doexec.c
> 
> $ cc -static -O2 -o static-doexec doexec.c
> $ ./static-doexec $(nproc)
> 
> It prints a result every second.
> 
> My test box is temporarily only 26 cores and even at this scale I run
> into massive lock contention stemming from back-to-back calls to
> percpu_counter_init (and _destroy later).
> 
> While not a panacea, one simple thing to do here is to batch these ops.
> Since the term "batching" is already used in the file, I decided to
> refer to it as "grouping" instead.
> 
> Even if this code could be patched to dodge these counters,  I would
> argue a high-traffic alloc/free consumer is only a matter of time so it
> makes sense to facilitate it.
> 
> With the fix I get an ok win, to quote from the commit:
> > Even at a very modest scale of 26 cores (ops/s):
> > before: 133543.63
> > after:  186061.81 (+39%)
> 
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
>     do_syscall_64+46
>     entry_SYSCALL_64_after_hwframe+110
> 
> I intend to do more work on the area to mostly sort it out, but I would
> not mind if someone else took the hammer to folio. :)
> 
> With this out of the way I'll be looking at some form of caching to
> eliminate these allocs as a problem.
> 
> v3:
> - fix !CONFIG_SMP build
> - drop the backtrace from fork commit message
> 
> v2:
> - force bigger alignment on alloc
> - rename "counters" to "nr_counters" and pass prior to lock key
> - drop {}'s for single-statement loops
> 
> 
> Mateusz Guzik (2):
>   pcpcntr: add group allocation/free
>   fork: group allocation of per-cpu counters for mm struct
> 
>  include/linux/percpu_counter.h | 39 ++++++++++++++++++----
>  kernel/fork.c                  | 14 ++------
>  lib/percpu_counter.c           | 61 +++++++++++++++++++++++-----------
>  3 files changed, 77 insertions(+), 37 deletions(-)
> 
> -- 
> 2.41.0
> 

I've applied both to percpu#for-6.6.

Thanks,
Dennis
