Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEA9755DE9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 10:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjGQIIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 04:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjGQIIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 04:08:52 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9858A1FDB
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 01:08:28 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R4F424VsSzNmQS;
        Mon, 17 Jul 2023 16:04:50 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 16:08:09 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] arm64: enable dead code elimination
Date:   Mon, 17 Jul 2023 16:07:39 +0800
Message-ID: <20230717080739.1000460-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION for arm64, allowing the
user to enable dead code elimination. In order for this to work, ensure
that we keep the necessary tables by annotating them with KEEP, also it
requires further changes to linker script to KEEP some tables and wildcard
compiler generated sections into the right place.

The following comparison is based 6.5-rc2 with defconfig,

$ ./scripts/bloat-o-meter vmlinux-base vmlinux-new
add/remove: 3/1106 grow/shrink: 4102/6964 up/down: 35704/-99980 (-64276)
Function                                     old     new   delta
...
Total: Before=17888959, After=17824683, chg -0.36%

add/remove: 0/1 grow/shrink: 0/1 up/down: 0/-44 (-44)
Data                                         old     new   delta
...
Total: Before=4820808, After=4820764, chg -0.00%

add/remove: 0/1 grow/shrink: 0/1 up/down: 0/-1096 (-1096)
RO Data                                      old     new   delta
...
Total: Before=5179123, After=5178027, chg -0.02%

$ size vmlinux-base vmlinux
   text	   data	     bss      dec       hex	filename
25433734  15385766  630656  41450156  2787aac	vmlinux-base
24756738  15360870  629888  40747496  26dc1e8	vmlinux-new

Memory available after booting, saving 704k on qemu,
base: 8084532K/8388608K
new:  8085236K/8388608K

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/Kconfig              | 1 +
 arch/arm64/kernel/vmlinux.lds.S | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a2511b30d0f6..73bb908ec62f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -148,6 +148,7 @@ config ARM64
 	select GENERIC_VDSO_TIME_NS
 	select HARDIRQS_SW_RESEND
 	select HAS_IOPORT
+	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
 	select HAVE_MOVE_PMD
 	select HAVE_MOVE_PUD
 	select HAVE_PCI
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 3cd7e76cc562..bb4ce6cd6896 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -238,7 +238,7 @@ SECTIONS
 	. = ALIGN(4);
 	.altinstructions : {
 		__alt_instructions = .;
-		*(.altinstructions)
+		KEEP(*(.altinstructions))
 		__alt_instructions_end = .;
 	}
 
@@ -258,8 +258,9 @@ SECTIONS
 		INIT_CALLS
 		CON_INITCALL
 		INIT_RAM_FS
-		*(.init.altinstructions .init.bss)	/* from the EFI stub */
+		KEEP(*(.init.altinstructions .init.bss*))	/* from the EFI stub */
 	}
+
 	.exit.data : {
 		EXIT_DATA
 	}
-- 
2.27.0

