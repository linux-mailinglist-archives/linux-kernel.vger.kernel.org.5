Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF04F8031ED
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 12:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjLDL6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbjLDL5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:57:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931AF106
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 03:57:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DEBBC433C9;
        Mon,  4 Dec 2023 11:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701691053;
        bh=z4zTk3CFfY1MGmK1f12Tfq9m5AIiq4yOUL5+WPN+Gys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cODGOLl96hF2fMQuvWNXpIGHYoQzt9fWAatg6+BNPuHZnwJ68CuLR53MQL+varhML
         GlBKYYHvIrAUXdJ8R9bGTKLkSuGuwg5u4dO96dIuofZL0rQXRzxDxRzB6pvVrFQ9V3
         bWNLnEJrLD2v654rNAKTT5PZ9D2L5Z3B/kXuD6+1DAbc1Q28LlG2rHtj4iIOEpDgDF
         o8vBqd1uB3MvkFFG0iZPGoNetO4Q7aUCGci9AZr8gKlNtKqeierpE2SGTYeMM+T2i9
         P2hF8rd3l9mXz/uycj/77GeKbsrM/1EhBEVIw+nqnMiTt8tMkyDOWtCJNs8VwNxsLC
         40ACTDpfKXtgA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-mips@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Stephen Rothwell" <sfr@rothwell.id.au>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Subject: [PATCH 07/20] mips: move build_tlb_refill_handler() prototype
Date:   Mon,  4 Dec 2023 12:56:57 +0100
Message-Id: <20231204115710.2247097-8-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231204115710.2247097-1-arnd@kernel.org>
References: <20231204115710.2247097-1-arnd@kernel.org>
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

From: Arnd Bergmann <arnd@arndb.de>

Instead of having a declaration for each caller, have one that is shared
with the function definition, which avoids a warning:

arch/mips/mm/tlbex.c:2547:6: error: no previous prototype for 'build_tlb_refill_handler' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/include/asm/tlbex.h | 1 +
 arch/mips/mm/tlb-r3k.c        | 3 +--
 arch/mips/mm/tlb-r4k.c        | 3 +--
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/tlbex.h b/arch/mips/include/asm/tlbex.h
index 6d97e23f30ab..24a2d06cc1c3 100644
--- a/arch/mips/include/asm/tlbex.h
+++ b/arch/mips/include/asm/tlbex.h
@@ -23,6 +23,7 @@ void build_update_entries(u32 **p, unsigned int tmp, unsigned int ptep);
 void build_tlb_write_entry(u32 **p, struct uasm_label **l,
 			   struct uasm_reloc **r,
 			   enum tlb_write_entry wmode);
+void build_tlb_refill_handler(void);
 
 extern void handle_tlbl(void);
 extern char handle_tlbl_end[];
diff --git a/arch/mips/mm/tlb-r3k.c b/arch/mips/mm/tlb-r3k.c
index 53dfa2b9316b..1fb2cf8c8bfa 100644
--- a/arch/mips/mm/tlb-r3k.c
+++ b/arch/mips/mm/tlb-r3k.c
@@ -23,11 +23,10 @@
 #include <asm/io.h>
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
+#include <asm/tlbex.h>
 
 #undef DEBUG_TLB
 
-extern void build_tlb_refill_handler(void);
-
 /* CP0 hazard avoidance. */
 #define BARRIER				\
 	__asm__ __volatile__(		\
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index 93c2d695588a..a542b255019a 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -22,10 +22,9 @@
 #include <asm/hazards.h>
 #include <asm/mmu_context.h>
 #include <asm/tlb.h>
+#include <asm/tlbex.h>
 #include <asm/tlbmisc.h>
 
-extern void build_tlb_refill_handler(void);
-
 /*
  * LOONGSON-2 has a 4 entry itlb which is a subset of jtlb, LOONGSON-3 has
  * a 4 entry itlb and a 4 entry dtlb which are subsets of jtlb. Unfortunately,
-- 
2.39.2

