Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2745E7ACE6B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 04:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjIYCnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 22:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjIYCny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 22:43:54 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E6092
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 19:43:46 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Rv6Y00FB5zMlpJ;
        Mon, 25 Sep 2023 10:40:04 +0800 (CST)
Received: from huawei.com (10.67.174.58) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 25 Sep
 2023 10:43:44 +0800
From:   Chen Jiahao <chenjiahao16@huawei.com>
To:     <bhe@redhat.com>, <thunder.leizhen@huawei.com>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <conor.dooley@microchip.com>,
        <alexghiti@rivosinc.com>, <ajones@ventanamicro.com>,
        <jszhang@kernel.org>, <sunilvl@ventanamicro.com>,
        <robh@kernel.org>, <bjorn@rivosinc.com>, <zephray@outlook.com>,
        <akpm@linux-foundation.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <chenjiahao16@huawei.com>
Subject: [PATCH -next v2] riscv: kdump: fix crashkernel reserving problem on RISC-V
Date:   Mon, 25 Sep 2023 10:43:33 +0800
Message-ID: <20230925024333.730964-1-chenjiahao16@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When testing on risc-v QEMU environment with "crashkernel="
parameter enabled, a problem occurred with the following
message:

[    0.000000] crashkernel low memory reserved: 0xf8000000 - 0x100000000 (128 MB)
[    0.000000] crashkernel reserved: 0x0000000177e00000 - 0x0000000277e00000 (4096 MB)
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at kernel/resource.c:779 __insert_resource+0x8e/0xd0
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.6.0-rc2-next-20230920 #1
[    0.000000] Hardware name: riscv-virtio,qemu (DT)
[    0.000000] epc : __insert_resource+0x8e/0xd0
[    0.000000]  ra : insert_resource+0x28/0x4e
[    0.000000] epc : ffffffff80017344 ra : ffffffff8001742e sp : ffffffff81203db0
[    0.000000]  gp : ffffffff812ece98 tp : ffffffff8120dac0 t0 : ff600001f7ff2b00
[    0.000000]  t1 : 0000000000000000 t2 : 3428203030303030 s0 : ffffffff81203dc0
[    0.000000]  s1 : ffffffff81211e18 a0 : ffffffff81211e18 a1 : ffffffff81289380
[    0.000000]  a2 : 0000000277dfffff a3 : 0000000177e00000 a4 : 0000000177e00000
[    0.000000]  a5 : ffffffff81289380 a6 : 0000000277dfffff a7 : 0000000000000078
[    0.000000]  s2 : ffffffff81289380 s3 : ffffffff80a0bac8 s4 : ff600001f7ff2880
[    0.000000]  s5 : 0000000000000280 s6 : 8000000a00006800 s7 : 000000000000007f
[    0.000000]  s8 : 0000000080017038 s9 : 0000000080038ea0 s10: 0000000000000000
[    0.000000]  s11: 0000000000000000 t3 : ffffffff80a0bc00 t4 : ffffffff80a0bc00
[    0.000000]  t5 : ffffffff80a0bbd0 t6 : ffffffff80a0bc00
[    0.000000] status: 0000000200000100 badaddr: 0000000000000000 cause: 0000000000000003
[    0.000000] [<ffffffff80017344>] __insert_resource+0x8e/0xd0
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Failed to add a Crash kernel resource at 177e00000

The crashkernel memory has been allocated successfully, whereas
it failed to insert into iomem_resource. This is due to the
unique reserving logic in risc-v arch specific code, i.e.
crashk_res/crashk_low_res will be added into iomem_resource
later in init_resources(), which is not aligned with current
unified reserving logic in reserve_crashkernel_{generic,low}()
and therefore leads to the failure of crashkernel reservation.

Removing the arch specific code within #ifdef CONFIG_KEXEC_CORE
in init_resources() to fix above problem.

Fixes: 31549153088e ("riscv: kdump: use generic interface to simplify crashkernel reservation")
Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>
---
 arch/riscv/kernel/setup.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index e600aab116a4..aac853ae4eb7 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -173,19 +173,6 @@ static void __init init_resources(void)
 	if (ret < 0)
 		goto error;
 
-#ifdef CONFIG_KEXEC_CORE
-	if (crashk_res.start != crashk_res.end) {
-		ret = add_resource(&iomem_resource, &crashk_res);
-		if (ret < 0)
-			goto error;
-	}
-	if (crashk_low_res.start != crashk_low_res.end) {
-		ret = add_resource(&iomem_resource, &crashk_low_res);
-		if (ret < 0)
-			goto error;
-	}
-#endif
-
 #ifdef CONFIG_CRASH_DUMP
 	if (elfcorehdr_size > 0) {
 		elfcorehdr_res.start = elfcorehdr_addr;
-- 
2.34.1

