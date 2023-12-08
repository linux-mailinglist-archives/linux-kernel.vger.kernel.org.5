Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1ACC80A6FA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574360AbjLHPMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574187AbjLHPL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:11:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B95385C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 07:10:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0427C433C9;
        Fri,  8 Dec 2023 15:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702048246;
        bh=HCvGsfz3Vdu/xFP3RmrxB/dHcXYV1Nvtry8yb2qqgWc=;
        h=From:To:Cc:Subject:Date:From;
        b=NGjLb6dCAeMjgRqiITyAjM8BpXvxxXmnQ7klcAIgJfgHOQOqZoizF0n1OQ27XFr7Y
         GywSyKvoMwdu3vLwHMw8yxzdQnQALJIbcbe5yHV/5Zvdi6zI3hE2DUl3vDm9O/38ED
         D0CLGQvEPTwwQDQCq2vvFPKa+sfYbAUnyY08d0c7UJPMghb3yYgeR7+UO/AS5tFDME
         IdqTvz5bwvtbnCGca5msjARy4iSlfBIsAGloP0YLlEWgBXYR7Du7tuiBNAXl5h9OiE
         +41pXxUqimy6zOi8NvUV9kuyqn72damP9IwFBTMAd2+eDdwGudz9y/wZNwdkZGEvki
         3iqpExDEbNaqg==
From:   guoren@kernel.org
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        akpm@linux-foundation.org, alexghiti@rivosinc.com,
        catalin.marinas@arm.com, willy@infradead.org, david@redhat.com,
        muchun.song@linux.dev, will@kernel.org, peterz@infradead.org,
        rppt@kernel.org, paulmck@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, alex@ghiti.fr, mike.kravetz@oracle.com,
        dfustini@baylibre.com, wefu@redhat.com, jszhang@kernel.org,
        falcon@tinylab.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>, Guo Ren <guoren@kernel.org>
Subject: [PATCH] riscv: pgtable: Enhance set_pte to prevent OoO risk
Date:   Fri,  8 Dec 2023 10:10:36 -0500
Message-Id: <20231208151036.2458921-1-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
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

From: Guo Ren <guoren@linux.alibaba.com>

When changing from an invalid pte to a valid one for a kernel page,
there is no need for tlb_flush. It's okay for the TSO memory model, but
there is an OoO risk for the Weak one. eg:

sd t0, (a0) // a0 = pte address, pteval is changed from invalid to valid
...
ld t1, (a1) // a1 = va of above pte

If the ld instruction is executed speculatively before the sd
instruction. Then it would bring an invalid entry into the TLB, and when
the ld instruction retired, a spurious page fault occurred. Because the
vmemmap has been ignored by vmalloc_fault, the spurious page fault would
cause kernel panic.

This patch was inspired by the commit: 7f0b1bf04511 ("arm64: Fix barriers
used for page table modifications"). For RISC-V, there is no requirement
in the spec to guarantee all tlb entries are valid and no requirement to
PTW filter out invalid entries. Of course, micro-arch could give a more
robust design, but here, use a software fence to guarantee.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/pgtable.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 294044429e8e..2fae5a5438e0 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -511,6 +511,13 @@ static inline int pte_same(pte_t pte_a, pte_t pte_b)
 static inline void set_pte(pte_t *ptep, pte_t pteval)
 {
 	*ptep = pteval;
+
+	/*
+	 * Only if the new pte is present and kernel, otherwise TLB
+	 * maintenance or update_mmu_cache() have the necessary barriers.
+	 */
+	if (pte_val(pteval) & (_PAGE_PRESENT | _PAGE_GLOBAL))
+		RISCV_FENCE(rw,rw);
 }
 
 void flush_icache_pte(pte_t pte);
-- 
2.40.1

