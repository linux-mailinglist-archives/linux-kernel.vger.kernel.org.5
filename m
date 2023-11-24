Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1557F6FF2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjKXJd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbjKXJdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:33:55 -0500
X-Greylist: delayed 190 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Nov 2023 01:33:57 PST
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A44C10C2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:33:57 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9633E1FB78;
        Fri, 24 Nov 2023 09:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1700818435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dN2IlGcDTrVpBzasxMgeU6tNQKLc4MOOnU/SQr2kNZ8=;
        b=li51CbE1Ey2FwgQ5N4urURDRSCIZsScNQ/vTVsPQXR4C/DA09W9DONYIEgUHELe++94ldO
        Urxq9IJUtliCzBfkOTFX3bRW/QkKpGYj6DeImNB25eMaHyf/6m0/zBLU8SadA6+gqsaMd1
        XI+9fz6GlQXYcR6EybQlDdhPhJz344A=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7705013A98;
        Fri, 24 Nov 2023 09:33:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id NPeuGQNuYGXTZwAAD6G6ig
        (envelope-from <mhocko@suse.com>); Fri, 24 Nov 2023 09:33:55 +0000
Date:   Fri, 24 Nov 2023 10:33:54 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     gaoxu <gaoxu2@hihonor.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        yipengxiang <yipengxiang@hihonor.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIG1tLG9v?=
 =?utf-8?B?bV9yZWFwZXI6?= avoid run queue_oom_reaper if task is not oom
Message-ID: <ZWBuAvcrb20MmX7m@tiehlicka>
References: <400d13bddb524ef6af37cb2220808c75@hihonor.com>
 <20231122134715.487677f38de74a6f8e0111cd@linux-foundation.org>
 <cba9d589a666493b9f034c0a8e48f26c@hihonor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cba9d589a666493b9f034c0a8e48f26c@hihonor.com>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
         ARC_NA(0.00)[];
         TO_DN_EQ_ADDR_SOME(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         RCPT_COUNT_FIVE(0.00)[6];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-0.20)[-0.999];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 24-11-23 02:52:34, gaoxu wrote:
> On Web, 22 Nov 2023 21:47:44 +0000 Andrew Morton wrote:
> > On Wed, 22 Nov 2023 12:46:44 +0000 gaoxu <gaoxu2@hihonor.com> wrote:
> 
> >> The function queue_oom_reaper tests and sets tsk->signal->oom_mm->flags.
> >> However, it is necessary to check if 'tsk' is an OOM victim before 
> >> executing 'queue_oom_reaper' because the variable may be NULL.
> >> 
> >> We encountered such an issue, and the log is as follows:
> >> [3701:11_see]Out of memory: Killed process 3154 (system_server) 
> >> total-vm:23662044kB, anon-rss:0kB, file-rss:0kB, shmem-rss:0kB,
> >> UID:1000 pgtables:4056kB oom_score_adj:-900
> >> [3701:11_see][RB/E]rb_sreason_str_set: sreason_str set null_pointer
> >> [3701:11_see][RB/E]rb_sreason_str_set: sreason_str set unknown_addr 
> >> [3701:11_see]Unable to handle kernel NULL pointer dereference at 
> >> virtual address 0000000000000328
> 
> > Well that isn't good.  How frequently does this happen and can you suggest why some quite old code is suddenly causing problems? 
> > What is your workload doing that others' do not do?
> This is a low probability issue. We conducted monkey testing for a month,
> and this problem occurred only once.
> The cause of the OOM error is the process surfaceflinger has encountered dma-buf memory leak.
> 
> I have not found the root cause of this problem.
> The physical memory of the process killed by OOM has been released, indicating that the issue may have occurred due to a concurrency problem
> between process termination and OOM kill.
> oom kill log：
> Out of memory: Killed process 3154 (system_server) total-vm:23662044kB, anon-rss:0kB, file-rss:0kB, shmem-rss:0kB,
> UID:1000 pgtables:4056kB oom_score_adj:-900
> 
> >> [3701:11_see]user pgtable: 4k pages, 39-bit VAs, pgdp=00000000821de000 
> >> [3701:11_see][0000000000000328] pgd=0000000000000000,
> >> p4d=0000000000000000,pud=0000000000000000
> >> [3701:11_see]tracing off
> >> [3701:11_see]Internal error: Oops: 96000005 [#1] PREEMPT SMP 
> >> [3701:11_see]Call trace:
> >> [3701:11_see] queue_oom_reaper+0x30/0x170 [3701:11_see] 
> >> __oom_kill_process+0x590/0x860 [3701:11_see] 
> >> oom_kill_process+0x140/0x274 [3701:11_see] out_of_memory+0x2f4/0x54c 
> >> [3701:11_see] __alloc_pages_slowpath+0x5d8/0xaac
> >> [3701:11_see] __alloc_pages+0x774/0x800 [3701:11_see] 
> >> wp_page_copy+0xc4/0x116c [3701:11_see] do_wp_page+0x4bc/0x6fc 
> >> [3701:11_see] handle_pte_fault+0x98/0x2a8 [3701:11_see] 
> >> __handle_mm_fault+0x368/0x700 [3701:11_see] 
> >> do_handle_mm_fault+0x160/0x2cc [3701:11_see] do_page_fault+0x3e0/0x818 
> >> [3701:11_see] do_mem_abort+0x68/0x17c [3701:11_see] el0_da+0x3c/0xa0 
> >> [3701:11_see] el0t_64_sync_handler+0xc4/0xec [3701:11_see] 
> >> el0t_64_sync+0x1b4/0x1b8 [3701:11_see]tracing off
> >> 
> >> Signed-off-by: Gao Xu <gaoxu2@hihonor.com>
> 
> > I'll queue this for -stable backporting, assuming review is agreeable. 
> > Can we please identify a suitable Fixes: target to tell -stable maintainers which kernels need the fix?  It looks like this goes back a long way.
> The problem occurred on Linux version 5.15.78, There is no difference between the latest kernel version code and Linux version 5.15.78 in the
> Function __oom_kill_process, so this problem is likely common to both versions.

__oom_kill_process is not the only involved part. The exit path plays a
really huge role there as well. I do understand that this was one off
and likely hard to reproduce but without knowing that the current Linus
tree can trigger this, we cannot really do much, I am afraid.

-- 
Michal Hocko
SUSE Labs
