Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410A0801D3C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 15:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbjLBOPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 09:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbjLBOPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 09:15:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A39A11C
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 06:15:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3574C433B6;
        Sat,  2 Dec 2023 14:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701526552;
        bh=f5wYmmEc/6YNMD4xeSRCsSaZscE5Ri2p04isx1ogm+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ial5msYMisNvSBLgaIv84BoLRvHY5kBgWPY2YeInOEJ03ZnAa+AU8INHjN48bxfof
         KJx5rAacZfFcgF1QYUUOkQyJSThnvmHmzlOlgdLg0I+occ47+4DyG91NJKP86M4RDs
         LPq3zhIgi1Gv/xvP4arCU2uAa8uhs2hTnlcWPYX0n4bSqHrVaf0RvoNZtQUL4xRKlF
         D1tCHvXQdP9MsjEsAAGX5Zq8SoFhlWsJdRz2FFTYbuS7DP8DJ3wgSFseWk4SMOzgF4
         z0dqLn3uX6cT306Y3tErtpAcxAmmQ39Yhnb8KVYCdM27TkerisIXDEeXZ71zPmg/nT
         KSHPimVFypkpg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] riscv: cmpxchg: implement arch_cmpxchg64_{relaxed|acquire|release}
Date:   Sat,  2 Dec 2023 22:03:23 +0800
Message-Id: <20231202140323.315-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231202140323.315-1-jszhang@kernel.org>
References: <20231202140323.315-1-jszhang@kernel.org>
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

After selecting ARCH_USE_CMPXCHG_LOCKREF, one straight futher
optimization is implementing the arch_cmpxchg64_relaxed() because the
lockref code does not need the cmpxchg to have barrier semantics. At
the same time, implement arch_cmpxchg64_acquire and
arch_cmpxchg64_release as well.

However, on both TH1520 and JH7110 platforms, I didn't see obvious
performance improvement with Linus' test case [1]. IMHO, this may
be related with the fence and lr.d/sc.d hw implementations. In theory,
lr/sc without fence could give performance improvement over lr/sc plus
fence, so add the code here to leave performance improvement room on
newer HW platforms.

Link: http://marc.info/?l=linux-fsdevel&m=137782380714721&w=4 [1]
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/include/asm/cmpxchg.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 2f4726d3cfcc..6318187f426f 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -360,4 +360,22 @@
 	arch_cmpxchg_relaxed((ptr), (o), (n));				\
 })
 
+#define arch_cmpxchg64_relaxed(ptr, o, n)				\
+({									\
+	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
+	arch_cmpxchg_relaxed((ptr), (o), (n));				\
+})
+
+#define arch_cmpxchg64_acquire(ptr, o, n)				\
+({									\
+	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
+	arch_cmpxchg_acquire((ptr), (o), (n));				\
+})
+
+#define arch_cmpxchg64_release(ptr, o, n)				\
+({									\
+	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
+	arch_cmpxchg_release((ptr), (o), (n));				\
+})
+
 #endif /* _ASM_RISCV_CMPXCHG_H */
-- 
2.42.0

