Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6C87F52D5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 22:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbjKVVrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 16:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjKVVrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 16:47:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034BC1A4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 13:47:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC7FC433C7;
        Wed, 22 Nov 2023 21:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1700689636;
        bh=9VzYb6GVbDcnppeRQnlTkvIRXkoMc3iK59bHSb8T6Rs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rzcL/Wybyt9UUlUKYPs5udDFmAVA4CHPuJizrgnyV0S0qHksiNrRomWRr/6Hos7A3
         LAHUfiZgOT0m6UY9p0GAofa1xfXfjp90eYK4sDlE3nhZaJF9KI+6iFPkyi4fe6Tm+R
         yAnpIA3xQ0T+cJ3v+J8d2MUvRq3ueQ/Y+2CYBvl8=
Date:   Wed, 22 Nov 2023 13:47:15 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     gaoxu <gaoxu2@hihonor.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        yipengxiang <yipengxiang@hihonor.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm,oom_reaper: avoid run queue_oom_reaper if task is
 not oom
Message-Id: <20231122134715.487677f38de74a6f8e0111cd@linux-foundation.org>
In-Reply-To: <400d13bddb524ef6af37cb2220808c75@hihonor.com>
References: <400d13bddb524ef6af37cb2220808c75@hihonor.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 12:46:44 +0000 gaoxu <gaoxu2@hihonor.com> wrote:

> The function queue_oom_reaper tests and sets tsk->signal->oom_mm->flags.
> However, it is necessary to check if 'tsk' is an OOM victim before
> executing 'queue_oom_reaper' because the variable may be NULL.
> 
> We encountered such an issue, and the log is as follows:
> [3701:11_see]Out of memory: Killed process 3154 (system_server)
> total-vm:23662044kB, anon-rss:0kB, file-rss:0kB, shmem-rss:0kB,
> UID:1000 pgtables:4056kB oom_score_adj:-900
> [3701:11_see][RB/E]rb_sreason_str_set: sreason_str set null_pointer
> [3701:11_see][RB/E]rb_sreason_str_set: sreason_str set unknown_addr
> [3701:11_see]Unable to handle kernel NULL pointer dereference at virtual
> address 0000000000000328

Well that isn't good.  How frequently does this happen and can you
suggest why some quite old code is suddenly causing problems?  What is
your workload doing that others' do not do?

> [3701:11_see]user pgtable: 4k pages, 39-bit VAs, pgdp=00000000821de000
> [3701:11_see][0000000000000328] pgd=0000000000000000,
> p4d=0000000000000000,pud=0000000000000000
> [3701:11_see]tracing off
> [3701:11_see]Internal error: Oops: 96000005 [#1] PREEMPT SMP
> [3701:11_see]Call trace:
> [3701:11_see] queue_oom_reaper+0x30/0x170
> [3701:11_see] __oom_kill_process+0x590/0x860
> [3701:11_see] oom_kill_process+0x140/0x274
> [3701:11_see] out_of_memory+0x2f4/0x54c
> [3701:11_see] __alloc_pages_slowpath+0x5d8/0xaac
> [3701:11_see] __alloc_pages+0x774/0x800
> [3701:11_see] wp_page_copy+0xc4/0x116c
> [3701:11_see] do_wp_page+0x4bc/0x6fc
> [3701:11_see] handle_pte_fault+0x98/0x2a8
> [3701:11_see] __handle_mm_fault+0x368/0x700
> [3701:11_see] do_handle_mm_fault+0x160/0x2cc
> [3701:11_see] do_page_fault+0x3e0/0x818
> [3701:11_see] do_mem_abort+0x68/0x17c
> [3701:11_see] el0_da+0x3c/0xa0
> [3701:11_see] el0t_64_sync_handler+0xc4/0xec
> [3701:11_see] el0t_64_sync+0x1b4/0x1b8
> [3701:11_see]tracing off
> 
> Signed-off-by: Gao Xu <gaoxu2@hihonor.com>

I'll queue this for -stable backporting, assuming review is agreeable. 
Can we please identify a suitable Fixes: target to tell -stable
maintainers which kernels need the fix?  It looks like this goes back a
long way.

