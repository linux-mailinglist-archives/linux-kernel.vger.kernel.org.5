Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6977F2A89
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbjKUKgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbjKUKgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:36:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B60C1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5YW8ZmTh4/Nv2y23qXTKlI3ZwdBS10aougP/UNLj3R8=; b=sefvmNdMYrMLFVQUULOkJx4VuN
        IsUuzhMxvl/AI156b/8C4XJXFk052zjD7F7RzfvZtPzQjGgd5DOjcxaOHi8f6h1z3Q/JhY7KVZ11b
        74FJIi8aHkLLFMvlZOKfh7mjwPZijHKNlvwsxb2K7zB9YGyAfu7vg9bV22HIkI2b6Ph8pVXmy2ntT
        x5R2SDK3WY3pjqQRXX8HhKPTmJp6eoQUorvLwWqsI2QsC55EgU6yDUkiv2Ku2GBGVq7v41DXyik40
        orSderWZGU9xGbfdgJqHGsdvMaIf95uJDGb1d1IXgANGc2H+q5ajFyXGoLVFNxnNScdAOsOYpP6S9
        A3lTfxcA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r5O75-005VDN-NZ; Tue, 21 Nov 2023 10:36:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 58E73300338; Tue, 21 Nov 2023 11:36:14 +0100 (CET)
Date:   Tue, 21 Nov 2023 11:36:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: lockdep + kasan bug?
Message-ID: <20231121103614.GG8262@noisy.programming.kicks-ass.net>
References: <20231120233659.e36txv3fedbjn4sx@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120233659.e36txv3fedbjn4sx@moria.home.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 06:36:59PM -0500, Kent Overstreet wrote:
> I've been seeing a lot of reports like the following in a lot of my
> lockdep + kasan tests.

I'm not aware of any such issues, then again, I rarely run with KASAN
enabled myself, I mostly leave that to the robots, who are far more
patient than me with slow kernels.

> Some lockdep patches are in my tree: they don't touch this code path
> (except I do have to increase MAX_LOCK_DEPTH from 48 to 63, perhaps that
> has unintended side effects?)
> 
> https://evilpiepirate.org/git/bcachefs.git/log/?id=2f42f415f7573001b4f4887b785d8a8747b3757f

yeah, don't see anything weird there. I mean, sad about the no-recursion
thing, esp. after you did those custom order bits.

> bcachefs does take a _large_ number of locks for lockdep to track, also
> possibly relevant
> 
> Have not dug into the lockdep hash table of outstanding locks code yet
> but happy to test patches...
> 
> 04752 ========= TEST   tiering_variable_buckets_replicas
> 04752 
> 04752 WATCHDOG 3600
> 04753 bcachefs (ea667958-8bbd-451b-9043-9132a2fd2fa4): mounting version 1.3: rebalance_work opts=metadata_replicas=2,data_replicas=2,foreground_target=ssd,background_target=hdd,promote_target=ssd,fsck
> 04753 bcachefs (ea667958-8bbd-451b-9043-9132a2fd2fa4): initializing new filesystem
> 04753 bcachefs (ea667958-8bbd-451b-9043-9132a2fd2fa4): going read-write
> 04753 bcachefs (ea667958-8bbd-451b-9043-9132a2fd2fa4): marking superblocks
> 04753 bcachefs (ea667958-8bbd-451b-9043-9132a2fd2fa4): initializing freespace
> 04753 bcachefs (ea667958-8bbd-451b-9043-9132a2fd2fa4): done initializing freespace
> 04753 bcachefs (ea667958-8bbd-451b-9043-9132a2fd2fa4): reading snapshots table
> 04753 bcachefs (ea667958-8bbd-451b-9043-9132a2fd2fa4): reading snapshots done
> 04753 WATCHDOG 3600
> 04753 randrw: (g=0): rw=randrw, bs=(R) 4096B-1024KiB, (W) 4096B-1024KiB, (T) 4096B-1024KiB, ioengine=libaio, iodepth=64
> 04753 fio-3.33
> 04753 Starting 1 process
> 04753 randrw: Laying out IO file (1 file / 3500MiB)
> 05117 Jobs: 1 (f=1)
> 05117 BUG: KASAN: global-out-of-bounds in add_chain_block+0x44/0x288
> 05117 Read of size 4 at addr ffffffc081b7a8bc by task fio/120528
> 05117 
> 05117 CPU: 11 PID: 120528 Comm: fio Tainted: G             L     6.6.0-ktest-gc18b7260ddd3 #8209
> 05117 Hardware name: linux,dummy-virt (DT)
> 05117 Call trace:
> 05117  dump_backtrace+0xa8/0xe8
> 05117  show_stack+0x1c/0x30
> 05117  dump_stack_lvl+0x5c/0xa0
> 05117  print_report+0x1e4/0x5a0
> 05117  kasan_report+0x80/0xc0
> 05117  __asan_load4+0x90/0xb0
> 05117  add_chain_block+0x44/0x288
> 05117  __lock_acquire+0x1104/0x24f8
> 05117  lock_acquire+0x1e0/0x470
> 05117  _raw_spin_lock_nested+0x54/0x78
> 05117  raw_spin_rq_lock_nested+0x30/0x50
> 05117  try_to_wake_up+0x3b4/0x1050
> 05117  wake_up_process+0x1c/0x30
> 05117  kick_pool+0x104/0x1b0
> 05117  __queue_work+0x350/0xa58
> 05117  queue_work_on+0x98/0xd0
> 05117  __bch2_btree_node_write+0xec0/0x10a0
> 05117  bch2_btree_node_write+0x88/0x138
> 05117  btree_split+0x744/0x14a0
> 05117  bch2_btree_split_leaf+0x94/0x258
> 05117  bch2_trans_commit_error.isra.0+0x234/0x7d0
> 05117  __bch2_trans_commit+0x1128/0x3010
> 05117  bch2_extent_update+0x410/0x570
> 05117  bch2_write_index_default+0x404/0x598
> 05117  __bch2_write_index+0xb0/0x3b0
> 05117  __bch2_write+0x6f0/0x928
> 05117  bch2_write+0x368/0x8e0
> 05117  bch2_direct_write+0xaa8/0x12c0
> 05117  bch2_write_iter+0x2e4/0x1050
> 05117  aio_write.constprop.0+0x19c/0x420
> 05117  io_submit_one.constprop.0+0xf30/0x17a0
> 05117  __arm64_sys_io_submit+0x244/0x388
> 05117  invoke_syscall.constprop.0+0x64/0x138
> 05117  do_el0_svc+0x7c/0x120
> 05117  el0_svc+0x34/0x80
> 05117  el0t_64_sync_handler+0xb8/0xc0
> 05117  el0t_64_sync+0x14c/0x150
> 05117 
> 05117 The buggy address belongs to the variable:
> 05117  nr_large_chain_blocks+0x3c/0x40

This is weird, nr_lage_chain_blocks is a single variable, if the
compiler keeps layout according to the source file, this would be
chaing_block_bucket[14] or something weird like that.

Perhaps figure out what it things the @size argument to
add_chain_block() would be?

> 05117 
> 05117 The buggy address belongs to the virtual mapping at
> 05117  [ffffffc081710000, ffffffc088861000) created by:
> 05117  paging_init+0x260/0x820
> 05117 
> 05117 The buggy address belongs to the physical page:
> 05117 page:00000000ce625900 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x41d7a
> 05117 flags: 0x4000(reserved|zone=0)
> 05117 page_type: 0xffffffff()
> 05117 raw: 0000000000004000 fffffffe00075e88 fffffffe00075e88 0000000000000000
> 05117 raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
> 05117 page dumped because: kasan: bad access detected
> 05117 
> 05117 Memory state around the buggy address:
> 05117  ffffffc081b7a780: 00 f9 f9 f9 f9 f9 f9 f9 00 f9 f9 f9 f9 f9 f9 f9
> 05117  ffffffc081b7a800: 00 f9 f9 f9 f9 f9 f9 f9 04 f9 f9 f9 f9 f9 f9 f9
> 05117 >ffffffc081b7a880: 04 f9 f9 f9 f9 f9 f9 f9 00 00 00 00 00 00 00 00
> 05117                                         ^
> 05117  ffffffc081b7a900: f9 f9 f9 f9 04 f9 f9 f9 f9 f9 f9 f9 04 f9 f9 f9
> 05117  ffffffc081b7a980: f9 f9 f9 f9 04 f9 f9 f9 f9 f9 f9 f9 00 f9 f9 f9
> 05117 ==================================================================
> 05117 Kernel panic - not syncing: kasan.fault=panic set ...
> 05117 CPU: 11 PID: 120528 Comm: fio Tainted: G             L     6.6.0-ktest-gc18b7260ddd3 #8209
> 05117 Hardware name: linux,dummy-virt (DT)
> 05117 Call trace:
> 05117  dump_backtrace+0xa8/0xe8
> 05117  show_stack+0x1c/0x30
> 05117  dump_stack_lvl+0x5c/0xa0
> 05117  dump_stack+0x18/0x20
> 05117  panic+0x3ac/0x408
> 05117  kasan_report_invalid_free+0x0/0x90
> 05117  kasan_report+0x90/0xc0
> 05117  __asan_load4+0x90/0xb0
> 05117  add_chain_block+0x44/0x288
> 05117  __lock_acquire+0x1104/0x24f8
> 05117  lock_acquire+0x1e0/0x470
> 05117  _raw_spin_lock_nested+0x54/0x78
> 05117  raw_spin_rq_lock_nested+0x30/0x50
> 05117  try_to_wake_up+0x3b4/0x1050
> 05117  wake_up_process+0x1c/0x30
> 05117  kick_pool+0x104/0x1b0
> 05117  __queue_work+0x350/0xa58
> 05117  queue_work_on+0x98/0xd0
> 05117  __bch2_btree_node_write+0xec0/0x10a0
> 05117  bch2_btree_node_write+0x88/0x138
> 05117  btree_split+0x744/0x14a0
> 05117  bch2_btree_split_leaf+0x94/0x258
> 05117  bch2_trans_commit_error.isra.0+0x234/0x7d0
> 05117  __bch2_trans_commit+0x1128/0x3010
> 05117  bch2_extent_update+0x410/0x570
> 05117  bch2_write_index_default+0x404/0x598
> 05117  __bch2_write_index+0xb0/0x3b0
> 05117  __bch2_write+0x6f0/0x928
> 05117  bch2_write+0x368/0x8e0
> 05117  bch2_direct_write+0xaa8/0x12c0
> 05117  bch2_write_iter+0x2e4/0x1050
> 05117  aio_write.constprop.0+0x19c/0x420
> 05117  io_submit_one.constprop.0+0xf30/0x17a0
> 05117  __arm64_sys_io_submit+0x244/0x388
> 05117  invoke_syscall.constprop.0+0x64/0x138
> 05117  do_el0_svc+0x7c/0x120
> 05117  el0_svc+0x34/0x80
> 05117  el0t_64_sync_handler+0xb8/0xc0
> 05117  el0t_64_sync+0x14c/0x150
> 05117 SMP: stopping secondary CPUs
> 05117 Kernel Offset: disabled
> 05117 CPU features: 0x0,00000000,70000001,1040500b
> 05117 Memory Limit: none
> 05117 ---[ end Kernel panic - not syncing: kasan.fault=panic set ... ]---
> 05122 ========= FAILED TIMEOUT tiering_variable_buckets_replicas in 3600s
