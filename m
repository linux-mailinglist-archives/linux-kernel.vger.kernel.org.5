Return-Path: <linux-kernel+bounces-76193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C28585F409
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CA4F1C20F9F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C51A374FC;
	Thu, 22 Feb 2024 09:10:48 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC642376ED;
	Thu, 22 Feb 2024 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708593047; cv=none; b=ieixCSBVpzzLJXJCVnA3NGCx/fxe7u/3J3TKym92pTfZWkg72ENAarhsQlN+A3AIP7LElPopQFAqDEEXkC3Mp6DSE8CXg6zifMFgaG4KHM36vBUdtK/swqGRR1xehtj/iGZUT1N2BC2SJsfyOeHfCegn0gn5ewrqYrMeolZx+fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708593047; c=relaxed/simple;
	bh=7wttezoz+r/aHCzYQdvjMewRzciTsCi285NrSpusK4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oW+EsNslPE2Je4tAVlvnPd6oQcTccOlWHw5rkYIzjugVZaUIFVrZlDDvZEBy7nYGVj8ezPc+Eu+Ifeao4Xk0mK4Fkcvay2lablB7D+FWB/K9i8kICKF2yOmgXo0MRLYoEEU5xPJkpQq1uhKsjkbJhWARVAQQt4GIMGhsU6Ck1bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36592C433F1;
	Thu, 22 Feb 2024 09:10:45 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Disable IRQ before init_fn() for nonboot CPUs
Date: Thu, 22 Feb 2024 17:10:08 +0800
Message-ID: <20240222091008.162191-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disable IRQ before init_fn() for nonboot CPUs when hotplug, in order to
silence such warnings (and also avoid potential errors due to unexpected
interrupts):

WARNING: CPU: 1 PID: 0 at kernel/rcu/tree.c:4503 rcu_cpu_starting+0x214/0x280
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.6.17+ #1198
pc 90000000048e3334 ra 90000000047bd56c tp 900000010039c000 sp 900000010039fdd0
a0 0000000000000001 a1 0000000000000006 a2 900000000802c040 a3 0000000000000000
a4 0000000000000001 a5 0000000000000004 a6 0000000000000000 a7 90000000048e3f4c
t0 0000000000000001 t1 9000000005c70968 t2 0000000004000000 t3 000000000005e56e
t4 00000000000002e4 t5 0000000000001000 t6 ffffffff80000000 t7 0000000000040000
t8 9000000007931638 u0 0000000000000006 s9 0000000000000004 s0 0000000000000001
s1 9000000006356ac0 s2 9000000007244000 s3 0000000000000001 s4 0000000000000001
s5 900000000636f000 s6 7fffffffffffffff s7 9000000002123940 s8 9000000001ca55f8
   ra: 90000000047bd56c tlb_init+0x24c/0x528
  ERA: 90000000048e3334 rcu_cpu_starting+0x214/0x280
 CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
 PRMD: 00000000 (PPLV0 -PIE -PWE)
 EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
 ECFG: 00071000 (LIE=12 VS=7)
ESTAT: 000c0000 [BRK] (IS= ECode=12 EsubCode=0)
 PRID: 0014c010 (Loongson-64bit, Loongson-3A5000)
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.6.17+ #1198
Stack : 0000000000000000 9000000006375000 9000000005b61878 900000010039c000
        900000010039fa30 0000000000000000 900000010039fa38 900000000619a140
        9000000006456888 9000000006456880 900000010039f950 0000000000000001
        0000000000000001 cb0cb028ec7e52e1 0000000002b90000 9000000100348700
        0000000000000000 0000000000000001 ffffffff916d12f1 0000000000000003
        0000000000040000 9000000007930370 0000000002b90000 0000000000000004
        9000000006366000 900000000619a140 0000000000000000 0000000000000004
        0000000000000000 0000000000000009 ffffffffffc681f2 9000000002123940
        9000000001ca55f8 9000000006366000 90000000047a4828 00007ffff057ded8
        00000000000000b0 0000000000000000 0000000000000000 0000000000071000
        ...
Call Trace:
[<90000000047a4828>] show_stack+0x48/0x1a0
[<9000000005b61874>] dump_stack_lvl+0x84/0xcc
[<90000000047f60ac>] __warn+0x8c/0x1e0
[<9000000005b0ab34>] report_bug+0x1b4/0x280
[<9000000005b63110>] do_bp+0x2d0/0x480
[<90000000047a2e20>] handle_bp+0x120/0x1c0
[<90000000048e3334>] rcu_cpu_starting+0x214/0x280
[<90000000047bd568>] tlb_init+0x248/0x528
[<90000000047a4c44>] per_cpu_trap_init+0x124/0x160
[<90000000047a19f4>] cpu_probe+0x494/0xa00
[<90000000047b551c>] start_secondary+0x3c/0xc0
[<9000000005b66134>] smpboot_entry+0x50/0x58

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/smp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index 20a355478c6c..9b07dd5b60bb 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -334,6 +334,7 @@ void __noreturn arch_cpu_idle_dead(void)
 		addr = iocsr_read64(LOONGARCH_IOCSR_MBUF0);
 	} while (addr == 0);
 
+	local_irq_disable();
 	init_fn = (void *)TO_CACHE(addr);
 	iocsr_write32(0xffffffff, LOONGARCH_IOCSR_IPI_CLEAR);
 
-- 
2.43.0


