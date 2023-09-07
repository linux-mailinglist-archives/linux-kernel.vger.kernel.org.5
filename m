Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A8A797CDE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 21:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239059AbjIGTjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 15:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237872AbjIGTjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 15:39:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42293CE9;
        Thu,  7 Sep 2023 12:38:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78DBC433C7;
        Thu,  7 Sep 2023 19:38:53 +0000 (UTC)
Date:   Thu, 7 Sep 2023 15:39:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Nadav Amit <namit@vmware.com>,
        Alexey Makhalov <amakhalov@vmware.com>
Subject: Re: [PATCH 1/6] tracefs/eventfs: Use dput to free the toplevel
 events directory
Message-ID: <20230907153908.3bdac88b@gandalf.local.home>
In-Reply-To: <7C38F28D-0277-42B2-9FB1-B4B59BBEC8FF@vmware.com>
References: <20230907024710.866917011@goodmis.org>
        <20230907024803.250873643@goodmis.org>
        <7C38F28D-0277-42B2-9FB1-B4B59BBEC8FF@vmware.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sep 2023 17:48:21 +0000
Ajay Kaher <akaher@vmware.com> wrote:

> Nice catch Steve. Changes looks good to me.

I'll add your Reviewed-by then?

> 
> Would like to know how did you map the backtrace with
> use-after-free of eventfs_inode.
> 
> Thinking if same problem could happen for sub folder/files of eventfs as
> free_ef() may get call earlier then dput().

I can also post the output. Here's the full dump:

 [  175.090834] ==================================================================
 [  175.092850] BUG: KASAN: slab-use-after-free in eventfs_root_lookup+0x88/0x1b0
 [  175.094635] Read of size 8 at addr ffff888120130ca0 by task ftracetest/1201
 [  175.096375] 
 [  175.096775] CPU: 4 PID: 1201 Comm: ftracetest Not tainted 6.5.0-test-10737-g469e0a8194e7 #13
 [  175.098727] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
 [  175.100877] Call Trace:
 [  175.101452]  <TASK>
 [  175.101955]  dump_stack_lvl+0x57/0x90
 [  175.102798]  print_report+0xcf/0x670
 [  175.103617]  ? __pfx_ring_buffer_record_off+0x10/0x10
 [  175.104752]  ? _raw_spin_lock_irqsave+0x2b/0x70
 [  175.105724]  ? __virt_addr_valid+0xd9/0x160
 [  175.106626]  kasan_report+0xd4/0x110
 [  175.107401]  ? eventfs_root_lookup+0x88/0x1b0
 [  175.108357]  ? eventfs_root_lookup+0x88/0x1b0
 [  175.109266]  eventfs_root_lookup+0x88/0x1b0
 [  175.110117]  ? eventfs_root_lookup+0x33/0x1b0
 [  175.111013]  __lookup_slow+0x194/0x2a0
 [  175.111785]  ? __pfx___lookup_slow+0x10/0x10
 [  175.112660]  ? down_read+0x11c/0x330
 [  175.113381]  walk_component+0x166/0x220
 [  175.114131]  link_path_walk.part.0.constprop.0+0x3a3/0x5a0
 [  175.115185]  ? seqcount_lockdep_reader_access+0x82/0x90
 [  175.116199]  ? __pfx_link_path_walk.part.0.constprop.0+0x10/0x10
 [  175.117353]  path_openat+0x143/0x11f0
 [  175.118073]  ? __lock_acquire+0xa1a/0x3220
 [  175.118874]  ? __pfx_path_openat+0x10/0x10
 [  175.119668]  ? __pfx___lock_acquire+0x10/0x10
 [  175.120535]  do_filp_open+0x166/0x290
 [  175.121259]  ? __pfx_do_filp_open+0x10/0x10
 [  175.122070]  ? lock_is_held_type+0xce/0x120
 [  175.122899]  ? preempt_count_sub+0xb7/0x100
 [  175.123714]  ? _raw_spin_unlock+0x29/0x50
 [  175.124504]  ? alloc_fd+0x1a0/0x320
 [  175.125202]  do_sys_openat2+0x126/0x160
 [  175.125955]  ? rcu_is_watching+0x34/0x60
 [  175.126728]  ? __pfx_do_sys_openat2+0x10/0x10
 [  175.127579]  ? __might_resched+0x2cf/0x3b0
 [  175.128391]  ? __fget_light+0xdf/0x100
 [  175.129138]  __x64_sys_openat+0xcd/0x140
 [  175.129906]  ? __pfx___x64_sys_openat+0x10/0x10
 [  175.133418]  ? syscall_enter_from_user_mode+0x22/0x90
 [  175.136987]  ? lockdep_hardirqs_on+0x7d/0x100
 [  175.140421]  do_syscall_64+0x3b/0xc0
 [  175.143605]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
 [  175.147005] RIP: 0033:0x7f1dceef5e51
 [  175.150173] Code: 75 57 89 f0 25 00 00 41 00 3d 00 00 41 00 74 49 80 3d 9a 27 0e 00 00 74 6d 89 da 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 93 00 00 00 48 8b 54 24 28 64 48 2b 14 25
 [  175.158706] RSP: 002b:00007fff2cddf380 EFLAGS: 00000202 ORIG_RAX: 0000000000000101
 [  175.162676] RAX: ffffffffffffffda RBX: 0000000000000241 RCX: 00007f1dceef5e51
 [  175.166579] RDX: 0000000000000241 RSI: 000055d7520677d0 RDI: 00000000ffffff9c
 [  175.170442] RBP: 000055d7520677d0 R08: 000000000000001e R09: 0000000000000001
 [  175.174238] R10: 00000000000001b6 R11: 0000000000000202 R12: 0000000000000000
 [  175.177960] R13: 0000000000000003 R14: 000055d752035678 R15: 000055d752067788
 [  175.181738]  </TASK>
 [  175.184665] 
 [  175.187443] Allocated by task 1200:
 [  175.190554]  kasan_save_stack+0x2f/0x50
 [  175.193712]  kasan_set_track+0x21/0x30
 [  175.196836]  __kasan_kmalloc+0x8b/0x90
 [  175.199939]  eventfs_create_events_dir+0x54/0x220
 [  175.203234]  create_event_toplevel_files+0x42/0x130
 [  175.206609]  event_trace_add_tracer+0x33/0x180
 [  175.209934]  trace_array_create_dir+0x52/0xf0
 [  175.213222]  trace_array_create+0x361/0x410
 [  175.216461]  instance_mkdir+0x6b/0xb0
 [  175.219592]  tracefs_syscall_mkdir+0x57/0x80
 [  175.222852]  vfs_mkdir+0x275/0x380
 [  175.225949]  do_mkdirat+0x1da/0x210
 [  175.229048]  __x64_sys_mkdir+0x74/0xa0
 [  175.232161]  do_syscall_64+0x3b/0xc0
 [  175.235211]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
 [  175.238519] 
 [  175.241210] Freed by task 1251:
 [  175.244190]  kasan_save_stack+0x2f/0x50
 [  175.247293]  kasan_set_track+0x21/0x30
 [  175.250375]  kasan_save_free_info+0x27/0x40
 [  175.253517]  __kasan_slab_free+0x106/0x180
 [  175.256637]  __kmem_cache_free+0x149/0x2e0
 [  175.259749]  event_trace_del_tracer+0xcb/0x120
 [  175.262940]  __remove_instance+0x16a/0x340
 [  175.266080]  instance_rmdir+0x77/0xa0
 [  175.269139]  tracefs_syscall_rmdir+0x77/0xc0
 [  175.272323]  vfs_rmdir+0xed/0x2d0
 [  175.275321]  do_rmdir+0x235/0x280
 [  175.278327]  __x64_sys_rmdir+0x5f/0x90
 [  175.281395]  do_syscall_64+0x3b/0xc0
 [  175.284433]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
 [  175.287725] 
 [  175.290402] The buggy address belongs to the object at ffff888120130ca0
 [  175.290402]  which belongs to the cache kmalloc-16 of size 16
 [  175.297419] The buggy address is located 0 bytes inside of
 [  175.297419]  freed 16-byte region [ffff888120130ca0, ffff888120130cb0)
 [  175.304477] 
 [  175.307155] The buggy address belongs to the physical page:
 [  175.310514] page:000000004dbddbb0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x120130
 [  175.314581] flags: 0x17ffffc0000800(slab|node=0|zone=2|lastcpupid=0x1fffff)
 [  175.318254] page_type: 0xffffffff()
 [  175.321321] raw: 0017ffffc0000800 ffff8881000423c0 dead000000000122 0000000000000000
 [  175.325190] raw: 0000000000000000 0000000000800080 00000001ffffffff 0000000000000000
 [  175.329080] page dumped because: kasan: bad access detected
 [  175.332608] 
 [  175.335350] Memory state around the buggy address:
 [  175.338752]  ffff888120130b80: 00 00 fc fc 00 05 fc fc 00 00 fc fc 00 02 fc fc
 [  175.342664]  ffff888120130c00: 00 07 fc fc 00 00 fc fc 00 00 fc fc fa fb fc fc
 [  175.346537] >ffff888120130c80: 00 00 fc fc fa fb fc fc 00 00 fc fc 00 00 fc fc
 [  175.350391]                                ^
 [  175.353753]  ffff888120130d00: 00 00 fc fc 00 00 fc fc 00 00 fc fc fa fb fc fc
 [  175.357707]  ffff888120130d80: 00 00 fc fc 00 00 fc fc 00 00 fc fc 00 00 fc fc
 [  175.361621] ==================================================================


In the "Freed by task" above, the event_trace_del_tracer+0xcb is the tail
call from the kfree(ei) in eventfs_remove_events_dir(). It's a tail call
so that screws up the unwind in ORC, as that address returned the next line
after the call to eventfs_remove_events_dir().

I can add this to the commit change log. And also I'll update the change
log of the other patch that shows its KASAN dump.

-- Steve
