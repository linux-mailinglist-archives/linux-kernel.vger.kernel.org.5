Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C09801D28
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 14:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbjLBNuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 08:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLBNuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 08:50:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F08114
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 05:50:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6D0C433C7;
        Sat,  2 Dec 2023 13:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701525046;
        bh=EkFw389G/HhwarJ7tijLtzRjnzCQCmA31ruY3wZ3Eh0=;
        h=From:To:Cc:Subject:Date:From;
        b=LFVwJc/exjGqrxugMF9foxWoZSKoIFt8WzINNplsxOeKiICwJpuuYQmWDvGPnxn3u
         r4bTL9oW0O5lztiua4MeysgqSAE3KzO8IJR/aqQE7xTaSNf2Vaycs6kPnqcZ+iQL9i
         hBOUYFotCRax/hdg+tU2I1LfMYysTXRmQpcLbCwCl7YQvW25Lzj+MWus+TG8JGhoil
         4riGCc+d+XiMsOvrGbxUYrw9RfPuBWl1bPNEz7EcJ5Imps3AukjeH5r0R4ut3clwno
         cZ8peb+3aSgyDeI/1IXJGHziWaZXSYNbuyNTveLqDOMpgno7Q6BWGep1AF6hi9H+3H
         C+WZ16FY6rWag==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] riscv: Use asm-generic for {read,write}{bwlq} and their relaxed variant
Date:   Sat,  2 Dec 2023 21:38:13 +0800
Message-Id: <20231202133813.4003-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The asm-generic implementation is functionally identical to the riscv
version. At the same time, the readl{q}_relaxed is replaced with the
raw version for nommu building.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---

Since v1:
 - fix nommu build

 arch/riscv/include/asm/mmio.h  | 62 +---------------------------------
 arch/riscv/include/asm/timex.h |  6 ++--
 2 files changed, 4 insertions(+), 64 deletions(-)

diff --git a/arch/riscv/include/asm/mmio.h b/arch/riscv/include/asm/mmio.h
index 4c58ee7f95ec..a491590593ca 100644
--- a/arch/riscv/include/asm/mmio.h
+++ b/arch/riscv/include/asm/mmio.h
@@ -80,54 +80,7 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
 #endif
 
 /*
- * Unordered I/O memory access primitives.  These are even more relaxed than
- * the relaxed versions, as they don't even order accesses between successive
- * operations to the I/O regions.
- */
-#define readb_cpu(c)		({ u8  __r = __raw_readb(c); __r; })
-#define readw_cpu(c)		({ u16 __r = le16_to_cpu((__force __le16)__raw_readw(c)); __r; })
-#define readl_cpu(c)		({ u32 __r = le32_to_cpu((__force __le32)__raw_readl(c)); __r; })
-
-#define writeb_cpu(v, c)	((void)__raw_writeb((v), (c)))
-#define writew_cpu(v, c)	((void)__raw_writew((__force u16)cpu_to_le16(v), (c)))
-#define writel_cpu(v, c)	((void)__raw_writel((__force u32)cpu_to_le32(v), (c)))
-
-#ifdef CONFIG_64BIT
-#define readq_cpu(c)		({ u64 __r = le64_to_cpu((__force __le64)__raw_readq(c)); __r; })
-#define writeq_cpu(v, c)	((void)__raw_writeq((__force u64)cpu_to_le64(v), (c)))
-#endif
-
-/*
- * Relaxed I/O memory access primitives. These follow the Device memory
- * ordering rules but do not guarantee any ordering relative to Normal memory
- * accesses.  These are defined to order the indicated access (either a read or
- * write) with all other I/O memory accesses to the same peripheral. Since the
- * platform specification defines that all I/O regions are strongly ordered on
- * channel 0, no explicit fences are required to enforce this ordering.
- */
-/* FIXME: These are now the same as asm-generic */
-#define __io_rbr()		do {} while (0)
-#define __io_rar()		do {} while (0)
-#define __io_rbw()		do {} while (0)
-#define __io_raw()		do {} while (0)
-
-#define readb_relaxed(c)	({ u8  __v; __io_rbr(); __v = readb_cpu(c); __io_rar(); __v; })
-#define readw_relaxed(c)	({ u16 __v; __io_rbr(); __v = readw_cpu(c); __io_rar(); __v; })
-#define readl_relaxed(c)	({ u32 __v; __io_rbr(); __v = readl_cpu(c); __io_rar(); __v; })
-
-#define writeb_relaxed(v, c)	({ __io_rbw(); writeb_cpu((v), (c)); __io_raw(); })
-#define writew_relaxed(v, c)	({ __io_rbw(); writew_cpu((v), (c)); __io_raw(); })
-#define writel_relaxed(v, c)	({ __io_rbw(); writel_cpu((v), (c)); __io_raw(); })
-
-#ifdef CONFIG_64BIT
-#define readq_relaxed(c)	({ u64 __v; __io_rbr(); __v = readq_cpu(c); __io_rar(); __v; })
-#define writeq_relaxed(v, c)	({ __io_rbw(); writeq_cpu((v), (c)); __io_raw(); })
-#endif
-
-/*
- * I/O memory access primitives.  Reads are ordered relative to any following
- * Normal memory read and delay() loop.  Writes are ordered relative to any
- * prior Normal memory write.  The memory barriers here are necessary as RISC-V
+ * I/O barriers. The memory barriers here are necessary as RISC-V
  * doesn't define any ordering between the memory space and the I/O space.
  */
 #define __io_br()	do {} while (0)
@@ -135,17 +88,4 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
 #define __io_bw()	({ __asm__ __volatile__ ("fence w,o" : : : "memory"); })
 #define __io_aw()	mmiowb_set_pending()
 
-#define readb(c)	({ u8  __v; __io_br(); __v = readb_cpu(c); __io_ar(__v); __v; })
-#define readw(c)	({ u16 __v; __io_br(); __v = readw_cpu(c); __io_ar(__v); __v; })
-#define readl(c)	({ u32 __v; __io_br(); __v = readl_cpu(c); __io_ar(__v); __v; })
-
-#define writeb(v, c)	({ __io_bw(); writeb_cpu((v), (c)); __io_aw(); })
-#define writew(v, c)	({ __io_bw(); writew_cpu((v), (c)); __io_aw(); })
-#define writel(v, c)	({ __io_bw(); writel_cpu((v), (c)); __io_aw(); })
-
-#ifdef CONFIG_64BIT
-#define readq(c)	({ u64 __v; __io_br(); __v = readq_cpu(c); __io_ar(__v); __v; })
-#define writeq(v, c)	({ __io_bw(); writeq_cpu((v), (c)); __io_aw(); })
-#endif
-
 #endif /* _ASM_RISCV_MMIO_H */
diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
index a06697846e69..9ff9f398f61a 100644
--- a/arch/riscv/include/asm/timex.h
+++ b/arch/riscv/include/asm/timex.h
@@ -17,18 +17,18 @@ typedef unsigned long cycles_t;
 #ifdef CONFIG_64BIT
 static inline cycles_t get_cycles(void)
 {
-	return readq_relaxed(clint_time_val);
+	return __raw_readq(clint_time_val);
 }
 #else /* !CONFIG_64BIT */
 static inline u32 get_cycles(void)
 {
-	return readl_relaxed(((u32 *)clint_time_val));
+	return __raw_readl(((u32 *)clint_time_val));
 }
 #define get_cycles get_cycles
 
 static inline u32 get_cycles_hi(void)
 {
-	return readl_relaxed(((u32 *)clint_time_val) + 1);
+	return __raw_readl(((u32 *)clint_time_val) + 1);
 }
 #define get_cycles_hi get_cycles_hi
 #endif /* CONFIG_64BIT */
-- 
2.42.0

