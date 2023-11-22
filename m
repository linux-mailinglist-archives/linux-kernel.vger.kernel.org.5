Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB037F468E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343832AbjKVMq5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Nov 2023 07:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbjKVMqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:46:54 -0500
Received: from mta22.hihonor.com (mta22.hihonor.com [81.70.192.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE27B19D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 04:46:49 -0800 (PST)
Received: from w002.hihonor.com (unknown [10.68.28.120])
        by mta22.hihonor.com (SkyGuard) with ESMTPS id 4Sb1FT2BH0zYlfl6;
        Wed, 22 Nov 2023 20:46:05 +0800 (CST)
Received: from a004.hihonor.com (10.68.27.131) by w002.hihonor.com
 (10.68.28.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.25; Wed, 22 Nov
 2023 20:46:45 +0800
Received: from a007.hihonor.com (10.68.22.31) by a004.hihonor.com
 (10.68.27.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.25; Wed, 22 Nov
 2023 20:46:44 +0800
Received: from a007.hihonor.com ([fe80::ccdd:b4b:ae86:edd4]) by
 a007.hihonor.com ([fe80::ccdd:b4b:ae86:edd4%10]) with mapi id 15.02.1258.025;
 Wed, 22 Nov 2023 20:46:44 +0800
From:   gaoxu <gaoxu2@hihonor.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        yipengxiang <yipengxiang@hihonor.com>
Subject: [PATCH] mm,oom_reaper: avoid run queue_oom_reaper if task is not oom
Thread-Topic: [PATCH] mm,oom_reaper: avoid run queue_oom_reaper if task is not
 oom
Thread-Index: AdodQUgb0N3ZJU2TSUK/4IicgpocdQ==
Date:   Wed, 22 Nov 2023 12:46:44 +0000
Message-ID: <400d13bddb524ef6af37cb2220808c75@hihonor.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.164.11.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function queue_oom_reaper tests and sets tsk->signal->oom_mm->flags.
However, it is necessary to check if 'tsk' is an OOM victim before
executing 'queue_oom_reaper' because the variable may be NULL.

We encountered such an issue, and the log is as follows:
[3701:11_see]Out of memory: Killed process 3154 (system_server)
total-vm:23662044kB, anon-rss:0kB, file-rss:0kB, shmem-rss:0kB,
UID:1000 pgtables:4056kB oom_score_adj:-900
[3701:11_see][RB/E]rb_sreason_str_set: sreason_str set null_pointer
[3701:11_see][RB/E]rb_sreason_str_set: sreason_str set unknown_addr
[3701:11_see]Unable to handle kernel NULL pointer dereference at virtual
address 0000000000000328
[3701:11_see]user pgtable: 4k pages, 39-bit VAs, pgdp=00000000821de000
[3701:11_see][0000000000000328] pgd=0000000000000000,
p4d=0000000000000000,pud=0000000000000000
[3701:11_see]tracing off
[3701:11_see]Internal error: Oops: 96000005 [#1] PREEMPT SMP
[3701:11_see]Call trace:
[3701:11_see] queue_oom_reaper+0x30/0x170
[3701:11_see] __oom_kill_process+0x590/0x860
[3701:11_see] oom_kill_process+0x140/0x274
[3701:11_see] out_of_memory+0x2f4/0x54c
[3701:11_see] __alloc_pages_slowpath+0x5d8/0xaac
[3701:11_see] __alloc_pages+0x774/0x800
[3701:11_see] wp_page_copy+0xc4/0x116c
[3701:11_see] do_wp_page+0x4bc/0x6fc
[3701:11_see] handle_pte_fault+0x98/0x2a8
[3701:11_see] __handle_mm_fault+0x368/0x700
[3701:11_see] do_handle_mm_fault+0x160/0x2cc
[3701:11_see] do_page_fault+0x3e0/0x818
[3701:11_see] do_mem_abort+0x68/0x17c
[3701:11_see] el0_da+0x3c/0xa0
[3701:11_see] el0t_64_sync_handler+0xc4/0xec
[3701:11_see] el0t_64_sync+0x1b4/0x1b8
[3701:11_see]tracing off

Signed-off-by: Gao Xu <gaoxu2@hihonor.com>
---
 mm/oom_kill.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 9e6071fde..3754ab4b6 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -984,7 +984,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 	}
 	rcu_read_unlock();
 
-	if (can_oom_reap)
+	if (can_oom_reap && tsk_is_oom_victim(victim))
 		queue_oom_reaper(victim);
 
 	mmdrop(mm);
-- 
2.17.1



