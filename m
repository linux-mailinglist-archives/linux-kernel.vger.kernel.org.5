Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D582C77360C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 03:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjHHBxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 21:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjHHBxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 21:53:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9714BB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 18:53:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 446AE62358
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 01:53:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED24C433C7;
        Tue,  8 Aug 2023 01:53:12 +0000 (UTC)
Date:   Mon, 7 Aug 2023 21:53:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: BUG: KASAN: slab-out-of-bounds in print_synth_event+0xa68/0xa78
Message-ID: <20230807215310.068fce2f@gandalf.local.home>
In-Reply-To: <yt9dsf8zfhw8.fsf@linux.ibm.com>
References: <yt9dsf8zfhw8.fsf@linux.ibm.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Aug 2023 08:20:23 +0200
Sven Schnelle <svens@linux.ibm.com> wrote:

> Hi Steven,
> 
> i noticed the following KASAN splat in CI (on s390):

Could this actually be a bug in KASAN?

The reason I ask, is because of the report.

> 
> [  218.586476] /home/svens/linux/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-stack.tc
> [  221.610410] ==================================================================
> [  221.610424] BUG: KASAN: slab-out-of-bounds in print_synth_event+0xa68/0xa78
> [  221.610440] Read of size 8 at addr 0000000087753ebc by task grep/1321

It's saying that there's a "slab-out-of-bounds on address 0x87753ebc

I guess the question is, what slab? But what if there is no slab?


> [  221.610445]
> [  221.610451] CPU: 9 PID: 1321 Comm: grep Not tainted 6.4.0-rc3-00008-g4b512860bdbd #716
> [  221.610457] Hardware name: IBM 3906 M04 704 (z/VM 7.1.0)
> [  221.610462] Call Trace:
> [  221.610466]  [<00000000026026e6>] dump_stack_lvl+0x106/0x1c8
> [  221.610479]  [<00000000009cdbbc>] print_address_description.constprop.0+0x34/0x378
> [  221.610488]  [<00000000009cdfac>] print_report+0xac/0x240
> [  221.610494]  [<00000000009ce32a>] kasan_report+0xf2/0x130
> [  221.610501]  [<00000000005e4f60>] print_synth_event+0xa68/0xa78
> [  221.610508]  [<00000000005809c0>] print_trace_line+0x2a8/0xc00
> [  221.610516]  [<0000000000582d4a>] s_show+0xc2/0x3d0
> [  221.610522]  [<0000000000b09db2>] seq_read_iter+0x912/0xf88
> [  221.610530]  [<0000000000b0a582>] seq_read+0x15a/0x1d8
> [  221.610535]  [<0000000000a75f66>] vfs_read+0x186/0x778
> [  221.610551]  [<0000000000a77b26>] ksys_read+0x126/0x210
> [  221.610557]  [<000000000010d044>] do_syscall+0x22c/0x328
> [  221.610564]  [<000000000266ea02>] __do_syscall+0x9a/0xf8
> [  221.610571]  [<000000000269f068>] system_call+0x70/0x98
> [  221.610577] 3 locks held by grep/1321:
> [  221.610580]  #0: 00000000a99db2f8 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xca/0xf88
> [  221.610595]  #1: 00000000032d0c18 (trace_event_sem){++++}-{3:3}, at: s_start+0x3c2/0x7c0
> [  221.610606]  #2: 00000000032c8cb8 (all_cpu_access_lock){+.+.}-{3:3}, at: s_start+0x502/0x7c0
> [  221.610617]
> [  221.610619] Allocated by task 1:
> [  221.610623]  kasan_save_stack+0x40/0x68
> [  221.610628]  kasan_set_track+0x36/0x48
> [  221.610632]  __kasan_kmalloc+0xbc/0xe8
> [  221.610636]  bdi_alloc+0x58/0x160
> [  221.610642]  __alloc_disk_node+0x96/0x558
> [  221.610648]  __blk_alloc_disk+0x42/0x88
> [  221.610652]  brd_alloc+0x2d8/0x730
> [  221.610659]  brd_init+0xd4/0x150
> [  221.610668]  do_one_initcall+0x17c/0x750
> [  221.610672]  do_initcalls+0x256/0x500
> [  221.610677]  kernel_init_freeable+0x59a/0xa60
> [  221.610681]  kernel_init+0x2e/0x1f8
> [  221.610685]  __ret_from_fork+0x8a/0xe8
> [  221.610689]  ret_from_fork+0xa/0x30
> [  221.610695] The buggy address belongs to the object at 0000000087754000
> [  221.610695]  which belongs to the cache kmalloc-4k of size 4096
> [  221.610700] The buggy address is located 324 bytes to the left of
> [  221.610700]  allocated 2464-byte region [0000000087754000, 00000000877549a0)

This is saying that it's allocated to the left of that region. It being:

  0x87753ebc

Shows that it's before the slab.

Now, you said that it's triggering at:

		} else if (se->fields[i]->is_stack) {
			u32 offset, data_offset, len;
			unsigned long *p, *end;

			offset = (u32)entry->fields[n_u64];
			data_offset = offset & 0xffff;
			len = offset >> 16;

			p = (void *)entry + data_offset;
			end = (void *)p + len - (sizeof(long) - 1);

			trace_seq_printf(s, "%s=STACK:\n", se->fields[i]->name);

			for (; p < end && *p; p++)  <<<<------------ BAD ADDR

				trace_seq_printf(s, "=> %pS\n", (void *)*p);
			n_u64++;


But p is pointing into the ring buffer. The ring buffer is not allocated
via slabs (nor kmalloc) but uses alloc_pages_node() (see __rb_allocate_pages()).

Could it be that KASAN sees an access close to a slab page, that isn't
being examined, and thinks it's a out-of-bounds access?

-- Steve


> [  221.610705]
> [  221.610708] The buggy address belongs to the physical page:
> [  221.610711] page:00004000021dd400 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x87750
> [  221.610718] head:00004000021dd400 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> [  221.610722] flags: 0x3ffff00000010200(slab|head|node=0|zone=1|lastcpupid=0x1ffff)
> [  221.610729] page_type: 0xffffffff()
> [  221.610735] raw: 3ffff00000010200 000000008008e800 000040000259cc10 0000000080081470
> [  221.610739] raw: 0000000000000000 0002000400000000 ffffffff00000001 0000000000000000
> [  221.610743] page dumped because: kasan: bad access detected
> [  221.610746]
> [  221.610748] Memory state around the buggy address:
> [  221.610752]  0000000087753d80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  221.610755]  0000000087753e00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  221.610759] >0000000087753e80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  221.610762]                                         ^
> [  221.610766]  0000000087753f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  221.610770]  0000000087753f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  221.610773] ==================================================================
> 
> git bisect says:
> 
