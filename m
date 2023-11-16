Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A42B7ED9C5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 03:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344517AbjKPCvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 21:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344286AbjKPCvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 21:51:49 -0500
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C219199
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 18:51:45 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700103103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Rm3MIRi4L3hl6jy/1gRTHrDOCrZWkofygygPBBT5WW4=;
        b=cYvdubWIuXabFzddH3lM5zHTCjZtg7HxxHhoD1+vpDP9W5X0tKV0KQH0a8FB5m3GhcU1Gg
        xZlwb5DaCZPFOfcqv1P9AE+R9rjP4OIjBCahjcm35Wv5/n3vcD4IM5wkZnEJ5qegRVJS2z
        Za1OvHszi1Fnoz9ExSaxt6Umd1QL7B4=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Erhard Furtner <erhard_f@mailbox.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Dennis Zhou <dennis@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>, stable@vger.kernel.org
Subject: [PATCH] mm: kmem: properly initialize local objcg variable in current_obj_cgroup()
Date:   Wed, 15 Nov 2023 18:51:09 -0800
Message-ID: <20231116025109.3775055-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Erhard reported that the 6.7-rc1 kernel panics on boot if being
built with clang-16. The problem was not reproducible with gcc.

[    5.975049] general protection fault, probably for non-canonical address 0xf555515555555557: 0000 [#1] SMP KASAN PTI
[    5.976422] KASAN: maybe wild-memory-access in range [0xaaaaaaaaaaaaaab8-0xaaaaaaaaaaaaaabf]
[    5.977475] CPU: 3 PID: 1 Comm: systemd Not tainted 6.7.0-rc1-Zen3 #77
[    5.977860] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
[    5.977860] RIP: 0010:obj_cgroup_charge_pages+0x27/0x2d5
[    5.977860] Code: 90 90 90 55 41 57 41 56 41 55 41 54 53 89 d5 41 89 f6 49 89 ff 48 b8 00 00 00 00 00 fc ff df 49 83 c7 10 4d3
[    5.977860] RSP: 0018:ffffc9000001fb18 EFLAGS: 00010a02
[    5.977860] RAX: dffffc0000000000 RBX: aaaaaaaaaaaaaaaa RCX: ffff8883eb9a8b08
[    5.977860] RDX: 0000000000000005 RSI: 0000000000400cc0 RDI: aaaaaaaaaaaaaaaa
[    5.977860] RBP: 0000000000000005 R08: 3333333333333333 R09: 0000000000000000
[    5.977860] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8883eb9a8b18
[    5.977860] R13: 1555555555555557 R14: 0000000000400cc0 R15: aaaaaaaaaaaaaaba
[    5.977860] FS:  00007f2976438b40(0000) GS:ffff8883eb980000(0000) knlGS:0000000000000000
[    5.977860] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.977860] CR2: 00007f29769e0060 CR3: 0000000107222003 CR4: 0000000000370eb0
[    5.977860] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    5.977860] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    5.977860] Call Trace:
[    5.977860]  <TASK>
[    5.977860]  ? __die_body+0x16/0x75
[    5.977860]  ? die_addr+0x4a/0x70
[    5.977860]  ? exc_general_protection+0x1c9/0x2d0
[    5.977860]  ? cgroup_mkdir+0x455/0x9fb
[    5.977860]  ? __x64_sys_mkdir+0x69/0x80
[    5.977860]  ? asm_exc_general_protection+0x26/0x30
[    5.977860]  ? obj_cgroup_charge_pages+0x27/0x2d5
[    5.977860]  obj_cgroup_charge+0x114/0x1ab
[    5.977860]  pcpu_alloc+0x1a6/0xa65
[    5.977860]  ? mem_cgroup_css_alloc+0x1eb/0x1140
[    5.977860]  ? cgroup_apply_control_enable+0x26b/0x7c0
[    5.977860]  mem_cgroup_css_alloc+0x23f/0x1140
[    5.977860]  cgroup_apply_control_enable+0x26b/0x7c0
[    5.977860]  ? cgroup_kn_set_ugid+0x2d/0x1a0
[    5.977860]  cgroup_mkdir+0x455/0x9fb
[    5.977860]  ? __cfi_cgroup_mkdir+0x10/0x10
[    5.977860]  kernfs_iop_mkdir+0x130/0x170
[    5.977860]  vfs_mkdir+0x405/0x530
[    5.977860]  do_mkdirat+0x188/0x1f0
[    5.977860]  __x64_sys_mkdir+0x69/0x80
[    5.977860]  do_syscall_64+0x7d/0x100
[    5.977860]  ? do_syscall_64+0x89/0x100
[    5.977860]  ? do_syscall_64+0x89/0x100
[    5.977860]  ? do_syscall_64+0x89/0x100
[    5.977860]  ? do_syscall_64+0x89/0x100
[    5.977860]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[    5.977860] RIP: 0033:0x7f297671defb
[    5.977860] Code: 8b 05 39 7f 0d 00 bb ff ff ff ff 64 c7 00 16 00 00 00 e9 61 ff ff ff e8 23 0c 02 00 0f 1f 00 f3 0f 1e fa b88
[    5.977860] RSP: 002b:00007ffee6242bb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
[    5.977860] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f297671defb
[    5.977860] RDX: 0000000000000000 RSI: 00000000000001ed RDI: 000055c6b449f0e0
[    5.977860] RBP: 00007ffee6242bf0 R08: 000000000000000e R09: 0000000000000000
[    5.977860] R10: 0000000000000000 R11: 0000000000000246 R12: 000055c6b445db80
[    5.977860] R13: 00000000000003a0 R14: 00007f2976a68651 R15: 00000000000003a0
[    5.977860]  </TASK>
[    5.977860] Modules linked in:
[    6.014095] ---[ end trace 0000000000000000 ]---
[    6.014701] RIP: 0010:obj_cgroup_charge_pages+0x27/0x2d5
[    6.015348] Code: 90 90 90 55 41 57 41 56 41 55 41 54 53 89 d5 41 89 f6 49 89 ff 48 b8 00 00 00 00 00 fc ff df 49 83 c7 10 4d3
[    6.017575] RSP: 0018:ffffc9000001fb18 EFLAGS: 00010a02
[    6.018255] RAX: dffffc0000000000 RBX: aaaaaaaaaaaaaaaa RCX: ffff8883eb9a8b08
[    6.019120] RDX: 0000000000000005 RSI: 0000000000400cc0 RDI: aaaaaaaaaaaaaaaa
[    6.019983] RBP: 0000000000000005 R08: 3333333333333333 R09: 0000000000000000
[    6.020849] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8883eb9a8b18
[    6.021747] R13: 1555555555555557 R14: 0000000000400cc0 R15: aaaaaaaaaaaaaaba
[    6.022609] FS:  00007f2976438b40(0000) GS:ffff8883eb980000(0000) knlGS:0000000000000000
[    6.023593] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    6.024296] CR2: 00007f29769e0060 CR3: 0000000107222003 CR4: 0000000000370eb0
[    6.025279] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    6.026139] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    6.027000] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

Actually the problem is caused by uninitialized local variable in
current_obj_cgroup(). If the root memory cgroup is set as an active
memory cgroup for a charging scope (as in the trace, where systemd
tries to create the first non-root cgroup, so the parent cgroup is
the root cgroup), the "for" loop is skipped and uninitialized objcg is
returned, causing a panic down the accounting stack.

The fix is trivial: initialize the objcg variable to NULL
unconditionally before the "for" loop.

Fixes: e86828e5446d ("mm: kmem: scoped objcg protection")
Reported-by: Erhard Furtner <erhard_f@mailbox.org>
Closes: https://github.com/ClangBuiltLinux/linux/issues/1959
Signed-off-by: Roman Gushchin (Cruise) <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: David Rientjes <rientjes@google.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: stable@vger.kernel.org
---
 mm/memcontrol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 774bd6e21e27..b138501e6489 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3165,6 +3165,7 @@ __always_inline struct obj_cgroup *current_obj_cgroup(void)
 	return NULL;
 
 from_memcg:
+	objcg = NULL;
 	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg)) {
 		/*
 		 * Memcg pointer is protected by scope (see set_active_memcg())
-- 
2.42.0

