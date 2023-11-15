Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BBB7EBC28
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 04:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbjKODkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 22:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbjKODj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 22:39:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C32DE9;
        Tue, 14 Nov 2023 19:39:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5355C433C8;
        Wed, 15 Nov 2023 03:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700019594;
        bh=+VdOPNVOtMDbHo9iumrFhTwtzxHPvdBl8+h1APQ9S1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p5N24urEZYLrUFvvRgzwYi0aSY2hYjb8XZ9Nn3+yycTJTG03K0YwY8B92clWQYLe8
         lsG7deLBpNKhm3oC52y6WOVv6SQboJ5cMj+rYFwCzUOBKlr1TPnVCX9OBGhQzDgKIc
         PjJh8kMXFdZGrAeK4pzUmxdMZIgTUwMjK0LfDYB9xsbfRoANWq9t9p/2aerRwECiUu
         3gowKia9B3bik7OwtJpRUNFC+YpKElrbaWmc4yUNfkyF/9ijzXiMrkSGm2dxotzfYx
         GZQrSMKGHd1BaxkigTMV5LgVLIRwPCmKFi9Tl9iJncj89RiJ94yWpKwKtZ+sdVPKd5
         zaxHXsU+V/LEw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Sasha Levin <sashal@kernel.org>, chenhuacai@kernel.org,
        maobibo@loongson.cn, yangtiezhu@loongson.cn, jpoimboe@kernel.org,
        wangliupu@loongson.cn, vschneid@redhat.com, zhoubinbin@loongson.cn,
        loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 4/6] LoongArch/smp: Call rcutree_report_cpu_starting() earlier
Date:   Tue, 14 Nov 2023 22:35:58 -0500
Message-ID: <20231115033608.1229058-4-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115033608.1229058-1-sashal@kernel.org>
References: <20231115033608.1229058-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.62
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huacai Chen <chenhuacai@loongson.cn>

[ Upstream commit a2ccf46333d7b2cf9658f0d82ac74097c1542fae ]

rcutree_report_cpu_starting() must be called before cpu_probe() to avoid
the following lockdep splat that triggered by calling __alloc_pages() when
CONFIG_PROVE_RCU_LIST=y:

 =============================
 WARNING: suspicious RCU usage
 6.6.0+ #980 Not tainted
 -----------------------------
 kernel/locking/lockdep.c:3761 RCU-list traversed in non-reader section!!
 other info that might help us debug this:
 RCU used illegally from offline CPU!
 rcu_scheduler_active = 1, debug_locks = 1
 1 lock held by swapper/1/0:
  #0: 900000000c82ef98 (&pcp->lock){+.+.}-{2:2}, at: get_page_from_freelist+0x894/0x1790
 CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.6.0+ #980
 Stack : 0000000000000001 9000000004f79508 9000000004893670 9000000100310000
         90000001003137d0 0000000000000000 90000001003137d8 9000000004f79508
         0000000000000000 0000000000000001 0000000000000000 90000000048a3384
         203a656d616e2065 ca43677b3687e616 90000001002c3480 0000000000000008
         000000000000009d 0000000000000000 0000000000000001 80000000ffffe0b8
         000000000000000d 0000000000000033 0000000007ec0000 13bbf50562dad831
         9000000005140748 0000000000000000 9000000004f79508 0000000000000004
         0000000000000000 9000000005140748 90000001002bad40 0000000000000000
         90000001002ba400 0000000000000000 9000000003573ec8 0000000000000000
         00000000000000b0 0000000000000004 0000000000000000 0000000000070000
         ...
 Call Trace:
 [<9000000003573ec8>] show_stack+0x38/0x150
 [<9000000004893670>] dump_stack_lvl+0x74/0xa8
 [<900000000360d2bc>] lockdep_rcu_suspicious+0x14c/0x190
 [<900000000361235c>] __lock_acquire+0xd0c/0x2740
 [<90000000036146f4>] lock_acquire+0x104/0x2c0
 [<90000000048a955c>] _raw_spin_lock_irqsave+0x5c/0x90
 [<900000000381cd5c>] rmqueue_bulk+0x6c/0x950
 [<900000000381fc0c>] get_page_from_freelist+0xd4c/0x1790
 [<9000000003821c6c>] __alloc_pages+0x1bc/0x3e0
 [<9000000003583b40>] tlb_init+0x150/0x2a0
 [<90000000035742a0>] per_cpu_trap_init+0xf0/0x110
 [<90000000035712fc>] cpu_probe+0x3dc/0x7a0
 [<900000000357ed20>] start_secondary+0x40/0xb0
 [<9000000004897138>] smpboot_entry+0x54/0x58

raw_smp_processor_id() is required in order to avoid calling into lockdep
before RCU has declared the CPU to be watched for readers.

See also commit 29368e093921 ("x86/smpboot: Move rcu_cpu_starting() earlier"),
commit de5d9dae150c ("s390/smp: move rcu_cpu_starting() earlier") and commit
99f070b62322 ("powerpc/smp: Call rcu_cpu_starting() earlier").

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/kernel/smp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index 14508d429ffa3..401c0e06734b4 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -471,8 +471,9 @@ asmlinkage void start_secondary(void)
 	unsigned int cpu;
 
 	sync_counter();
-	cpu = smp_processor_id();
+	cpu = raw_smp_processor_id();
 	set_my_cpu_offset(per_cpu_offset(cpu));
+	rcutree_report_cpu_starting(cpu);
 
 	cpu_probe();
 	constant_clockevent_init();
-- 
2.42.0

