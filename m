Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EA180ED21
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376724AbjLLNR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376673AbjLLNRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:17:20 -0500
Received: from fzi-msx-e-01.fzi.de (fzi-msx-e-01.fzi.de [141.21.8.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992E6123
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:17:21 -0800 (PST)
From:   Frederik Haxel <haxel@fzi.de>
CC:     Vitaly Wool <vitaly.wool@konsulko.com>,
        Frederik Haxel <haxel@fzi.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>,
        Greentime Hu <greentime.hu@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andy Chiu <andy.chiu@sifive.com>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Guo Ren <guoren@kernel.org>, Nam Cao <namcaov@gmail.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Baoquan He <bhe@redhat.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Chen Jiahao <chenjiahao16@huawei.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] riscv: Allow disabling of BUILTIN_DTB for XIP
Date:   Tue, 12 Dec 2023 14:01:14 +0100
Message-ID: <20231212130116.848530-4-haxel@fzi.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212130116.848530-1-haxel@fzi.de>
References: <20231212130116.848530-1-haxel@fzi.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [141.21.46.139]
X-ClientProxiedBy: fzi-msx-05.fzi.de (2001:67c:2acc:8:141:21:17:45) To
 fzi-msx-05.fzi.de (2001:67c:2acc:8:141:21:17:45)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables, among other things, testing with the QEMU virt machine.

To build an XIP kernel for the QEMU virt machine, configure the
the kernel as desired and apply the following configuration
```
CONFIG_NONPORTABLE=y
CONFIG_XIP_KERNEL=y
CONFIG_XIP_PHYS_ADDR=0x20000000
CONFIG_PHYS_RAM_BASE=0x80200000
CONFIG_BUILTIN_DTB=n
```

Since the QEMU virt flash memory expects a 32 MB file, the built image
must be padded. For example, with
`truncate -s 32M arch/riscv/boot/xipImage`

The kernel can be started using the following command in QEMU (v8+)
```
qemu-system-riscv64 -M virt,pflash0=pflash0 \
 -blockdev node-name=pflash0,driver=file,read-only=on,\
filename=arch/riscv/boot/xipImage <optional parameters>
```

Signed-off-by: Frederik Haxel <haxel@fzi.de>
---
 arch/riscv/Kconfig       | 6 +++---
 arch/riscv/kernel/head.S | 4 +++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 95a2a06acc6a..72bc31b6eeb9 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -904,13 +904,13 @@ config RISCV_ISA_FALLBACK
 	  on the replacement properties, "riscv,isa-base" and
 	  "riscv,isa-extensions".
 
-endmenu # "Boot options"
-
 config BUILTIN_DTB
-	bool
+	bool "Built-in device tree"
 	depends on OF && NONPORTABLE
 	default y if XIP_KERNEL
 
+endmenu # "Boot options"
+
 config PORTABLE
 	bool
 	default !NONPORTABLE
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index a2e2f0dd3899..a8939558702c 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -266,10 +266,12 @@ SYM_CODE_START(_start_kernel)
 	la sp, _end + THREAD_SIZE
 	XIP_FIXUP_OFFSET sp
 	mv s0, a0
+	mv s1, a1
 	call __copy_data
 
-	/* Restore a0 copy */
+	/* Restore a0 & a1 copy */
 	mv a0, s0
+	mv a1, s1
 #endif
 
 #ifndef CONFIG_XIP_KERNEL
-- 
2.34.1

