Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4052751998
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbjGMHPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbjGMHPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:15:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0377DE4F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:15:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 211861570;
        Thu, 13 Jul 2023 00:16:14 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.49.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2EE083F73F;
        Thu, 13 Jul 2023 00:15:28 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     david@redhat.com, Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/mm: Set only the PTE_DIRTY bit while preserving the HW dirty state
Date:   Thu, 13 Jul 2023 12:45:18 +0530
Message-Id: <20230713071518.628440-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pte_mkdirty() creates dirty states both in SW and HW bits, which is really
not required, either in pte_wrprotect() or pte_modify() for preserving the
HW dirty state. Because pte_mkdirty() sets PTE_DIRTY and clears PTE_RDONLY
as pte_write() always evaluates to be true - otherwise pte_hw_dirty() will
not test out in the first place. Clearing PTE_RDONLY again is not required
here because the pte is already in pte_hw_dirty() but might soon loose its
dirty state thus requiring preservation in SW dirty bit i.e PTE_DIRTY.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v6.5-rc1

 arch/arm64/include/asm/pgtable.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 0bd18de9fd97..171d6d7f8087 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -212,7 +212,7 @@ static inline pte_t pte_wrprotect(pte_t pte)
 	 * clear), set the PTE_DIRTY bit.
 	 */
 	if (pte_hw_dirty(pte))
-		pte = pte_mkdirty(pte);
+		pte = set_pte_bit(pte, __pgprot(PTE_DIRTY));
 
 	pte = clear_pte_bit(pte, __pgprot(PTE_WRITE));
 	pte = set_pte_bit(pte, __pgprot(PTE_RDONLY));
@@ -823,7 +823,8 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 			      PTE_ATTRINDX_MASK;
 	/* preserve the hardware dirty information */
 	if (pte_hw_dirty(pte))
-		pte = pte_mkdirty(pte);
+		pte = set_pte_bit(pte, __pgprot(PTE_DIRTY));
+
 	pte_val(pte) = (pte_val(pte) & ~mask) | (pgprot_val(newprot) & mask);
 	return pte;
 }
-- 
2.30.2

