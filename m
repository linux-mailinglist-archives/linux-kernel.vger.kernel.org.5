Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815A179397F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 12:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbjIFKHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 06:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235686AbjIFKHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:07:19 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDC21BC6
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 03:06:46 -0700 (PDT)
X-QQ-mid: bizesmtp77t1693994304tbs1f5fp
Received: from localhost.localdomain ( [221.226.144.218])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 06 Sep 2023 17:58:20 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: 1OQ4fzPuJwa4CnM18ZyX6sw3+4M5cE1N93fmTWEuCPfoL34gU/m35awvJ+qzy
        KEqeeZow+/+yU3bTEtcEr9fDxqGOyP/Id1CRKrwzXmRu+b306s+jgkT1KMo9eSKQ1ys7ZYI
        urhLlokF4HwS5LjITI3zbGJCZNoLYmX7mzFkDDgz2ej2f6tSHy9jqukP6u0lm+MritL4lVX
        ZL0u0tFwmWGAN9cPaA4UdtahEf+9w0pY/zwajuTcZC4gzS/TfB0o+LXTTBaNN/sIrkZEfSD
        Ipt8tVlpKrwhhcdYWJcEUcsnUO2AzHZQ4V266iSYWbOLuO1UQQ8CE1BUlMVa2eO/OMQHyl8
        TyNs2jb4vxhzrA3Lvrww02GZS+eVRMI016bb6svEfr6OcqaTZ4=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9162341374277156945
From:   Song Shuai <songshuaishuai@tinylab.org>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, lihuafei1@huawei.com,
        conor.dooley@microchip.com, liaochang1@huawei.com,
        songshuaishuai@tinylab.org, lizhengyu3@huawei.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH -fixes] riscv: kexec: Align the kexeced kernel entry
Date:   Wed,  6 Sep 2023 17:58:17 +0800
Message-Id: <20230906095817.364390-1-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_PBL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current riscv boot protocol requires 2MB alignment for RV64
and 4MB alignment for RV32.

In KEXEC_FILE path, the elf_find_pbase() function should align
the kexeced kernel entry according to the requirement, otherwise
the kexeced kernel would silently BUG at the setup_vm().

Fixes: 8acea455fafa ("RISC-V: Support for kexec_file on panic")
Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
---
You can use my kexec-tools[1] to test the kexec-file-syscall and this patch.

[1]: https://github.com/sugarfillet/kexec-tools/tree/fix-riscv 
---
 arch/riscv/kernel/elf_kexec.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
index 5372b708fae2..9a81d6926ac6 100644
--- a/arch/riscv/kernel/elf_kexec.c
+++ b/arch/riscv/kernel/elf_kexec.c
@@ -98,7 +98,13 @@ static int elf_find_pbase(struct kimage *image, unsigned long kernel_len,
 	kbuf.image = image;
 	kbuf.buf_min = lowest_paddr;
 	kbuf.buf_max = ULONG_MAX;
-	kbuf.buf_align = PAGE_SIZE;
+
+	/*
+	 * Current riscv boot protocol requires 2MB alignment for
+	 * RV64 and 4MB alignment for RV32
+	 *
+	 */
+	kbuf.buf_align = PMD_SIZE;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	kbuf.memsz = ALIGN(kernel_len, PAGE_SIZE);
 	kbuf.top_down = false;
-- 
2.20.1

