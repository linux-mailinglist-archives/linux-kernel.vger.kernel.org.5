Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF867CD27C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 05:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjJRDAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 23:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJRDAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 23:00:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF26BAB
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 20:00:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 316B22F4;
        Tue, 17 Oct 2023 20:01:01 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.41.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 846AF3F5A1;
        Tue, 17 Oct 2023 20:00:17 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: Independently update HDFGRTR_EL2 and HDFGWTR_EL2
Date:   Wed, 18 Oct 2023 08:30:07 +0530
Message-Id: <20231018030007.1968317-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently PMSNEVFR_EL1 system register read, and write access EL2 traps are
disabled, via setting the same bit (i.e 62) in HDFGRTR_EL2, and HDFGWTR_EL2
respectively. Although very similar, bit fields are not exact same in these
two EL2 trap configure registers particularly when it comes to read-only or
write-only accesses such as ready-only 'HDFGRTR_EL2.nBRBIDR' which needs to
be set while enabling BRBE on NVHE platforms. Using the exact same bit mask
fields for both these trap register risk writing into their RESERVED areas,
which is undesirable.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v6.6-rc6.

I guess it should be okay to use 'x2' as it is in the clobbered register
list for init_el2_state() function. But please do let me know otherwise.

 arch/arm64/include/asm/el2_setup.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index 899b5c10f84c..c534afb1a30d 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -206,16 +206,19 @@
 	cbz	x1, .Lskip_fgt_\@
 
 	mov	x0, xzr
+	mov	x2, xzr
 	mrs	x1, id_aa64dfr0_el1
 	ubfx	x1, x1, #ID_AA64DFR0_EL1_PMSVer_SHIFT, #4
 	cmp	x1, #3
 	b.lt	.Lset_debug_fgt_\@
+
 	/* Disable PMSNEVFR_EL1 read and write traps */
-	orr	x0, x0, #(1 << 62)
+	orr	x0, x0, #HDFGRTR_EL2_nPMSNEVFR_EL1_MASK
+	orr	x2, x2, #HDFGWTR_EL2_nPMSNEVFR_EL1_MASK
 
 .Lset_debug_fgt_\@:
 	msr_s	SYS_HDFGRTR_EL2, x0
-	msr_s	SYS_HDFGWTR_EL2, x0
+	msr_s	SYS_HDFGWTR_EL2, x2
 
 	mov	x0, xzr
 	mrs	x1, id_aa64pfr1_el1
-- 
2.25.1

