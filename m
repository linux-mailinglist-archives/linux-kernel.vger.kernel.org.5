Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B3A79A18D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 05:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjIKDBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 23:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjIKDBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 23:01:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2764EB0;
        Sun, 10 Sep 2023 20:00:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE05C433C7;
        Mon, 11 Sep 2023 03:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694401257;
        bh=Zb7G9oX8iegZtBsmuXgSqpVqEQBV6K+Fp0vyiTnpncg=;
        h=Date:From:To:Cc:Subject:From;
        b=NxRbMGrreQxY0Lky1aNLhQC7ns0e8bXWzjuIarTimGyS1ota/Krv5YkhRuyPYI6r4
         5S/UAQoNRSHSUcNHm9vrPtv5ReRqENayqQkCuelL8mf8uk61RZE39lQewT2NPthaz9
         5VHpTVYYA9KfKVuAa4BGxYQVtaftT2WANM7HeYNcENRs8+ojiMg8tRO694QJtbDNrW
         NRlejlewZYaeeSXlpegbihmBmXtjibub7zs9ur9C7n3J9EzEd0nB6LkFzABEse/g1v
         4lTFC0Fb9PsyLdsCodAuTFsZECHdjFWVb1zJBzAEcb0tvBYhqtOrGbE8jY0zG1tnpD
         wkrytWS61qxOA==
Date:   Mon, 11 Sep 2023 12:00:53 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: suspicious RCU usage warning on tracing/urgent
Message-Id: <20230911120053.ca82f545e7f46ea753deda18@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

I got this suspicious RCU usage warning when I ran ftracetest on
tracing/urgent branch.

[1] Basic trace file check[   17.172817] 
[   17.174621] =============================
[   17.177730] WARNING: suspicious RCU usage
[   17.180962] 6.5.0-10750-g595efe1079cd #47 Tainted: G                 N
[   17.185528] -----------------------------
[   17.188685] fs/tracefs/event_inode.c:455 RCU-list traversed in non-reader section!!
[   17.194633] 
[   17.194633] other info that might help us debug this:
[   17.194633] 
[   17.200969] 
[   17.200969] rcu_scheduler_active = 2, debug_locks = 1
[   17.206086] 1 lock held by ftracetest/171:
[   17.209265]  #0: ffffffff829c2d30 (eventfs_srcu){.+.+}-{0:0}, at: dcache_dir_open_wrapper+0x3f/0x190
[   17.215551] 
[   17.215551] stack backtrace:
[   17.218498] CPU: 5 PID: 171 Comm: ftracetest Tainted: G                 N 6.5.0-10750-g595efe1079cd #47
[   17.223364] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   17.228206] Call Trace:
[   17.230076]  <TASK>
[   17.231812]  dump_stack_lvl+0x66/0x80
[   17.234260]  lockdep_rcu_suspicious+0x158/0x1c0
[   17.237113]  ? __pfx_dcache_dir_open_wrapper+0x10/0x10
[   17.240026]  dcache_dir_open_wrapper+0x14c/0x190
[   17.242663]  ? __pfx_dcache_dir_open_wrapper+0x10/0x10
[   17.245592]  do_dentry_open+0x16a/0x550
[   17.248203]  do_open+0x272/0x3d0
[   17.250584]  path_openat+0x119/0x290
[   17.253046]  ? __lock_acquire+0x504/0xb70
[   17.255658]  do_filp_open+0xb6/0x160
[   17.258015]  ? find_held_lock+0x2b/0x80
[   17.260421]  ? alloc_fd+0x12b/0x220
[   17.262839]  ? trace_preempt_on+0x7a/0x90
[   17.265763]  ? preempt_count_sub+0x4b/0x60
[   17.268631]  ? _raw_spin_unlock+0x2d/0x50
[   17.271249]  do_sys_openat2+0x96/0xd0
[   17.273499]  __x64_sys_openat+0x57/0xa0
[   17.275808]  do_syscall_64+0x3f/0x90
[   17.277995]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[   17.281250] RIP: 0033:0x4bce8c
[   17.283498] Code: 24 18 31 c0 41 83 e2 40 75 44 89 f0 25 00 00 41 00 3d 00 00 41 00 74 36 44 89 c2 4c 89 ce bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 44 48 8b 4c 24 18 64 48 33 0c 25 28 00 00 00
[   17.294543] RSP: 002b:00007fffa59a3e20 EFLAGS: 00000287 ORIG_RAX: 0000000000000101
[   17.299479] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004bce8c
[   17.303935] RDX: 0000000000090800 RSI: 000000000130b0c0 RDI: 00000000ffffff9c
[   17.308187] RBP: 00007fffa59a4098 R08: 0000000000090800 R09: 000000000130b0c0
[   17.312483] R10: 0000000000000000 R11: 0000000000000287 R12: 00000000013099ff
[   17.316401] R13: 0000000000000012 R14: 0000000001309a00 R15: 000000000130b0c7
[   17.320543]  </TASK>

But it seems correctly taking srcu_read_lock().

    452 
    453         ei = ti->private;
    454         idx = srcu_read_lock(&eventfs_srcu);
    455         list_for_each_entry_rcu(ef, &ei->e_top_files, list) {
    456                 create_dentry(ef, dentry, false);
    457         }
    458         srcu_read_unlock(&eventfs_srcu, idx);
    459         return dcache_dir_open(inode, file);
    460 }
    461 

This may false-positive warning, or srcu_read_lock() is not enough for
list_for_each_entry_rcu(). In latter case, maybe we need to use a
mutex instead of srcu for update the ef.

BTW, the ftracetest itself passed without any problem.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
