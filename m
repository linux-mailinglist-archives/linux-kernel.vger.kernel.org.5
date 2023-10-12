Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9ED7C7772
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442653AbjJLTya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442527AbjJLTyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:54:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6435D6;
        Thu, 12 Oct 2023 12:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=4Fn16qTKKDmoLngNQQ4GEd7U5ZLcnF6YO5R8MQyfSP8=; b=Q4znoG+4HTWnq0dTqEVCZDI+uU
        hA3CQAVGkFSg2dpaJpUkrb/5/eEF0IDrT3s5i4tS7hpXbiAAQY+8ibHf+KzbOF8oeotjoTwwuPmmc
        GpfmV4h3npc4vpGkaXRtVeY/9x1KlYtZaX0jsYJmMGPvwg050F7IO2wMW97T1zHc0RTAkqo6o1yrY
        toYhtsBPqOmkV6mbEZp8VIcBLAEcPoXTijfBSGuc/OEltetagGKrkoQoi1SRb8JnGMwbTJeCWC8EK
        uENSf+cYkLUQW8Xw9/Fofki1b5m+dp86eGjFpKBOSCAJQGLpeUHVc9o8km0Nq/3hrNQ+9WDEph8KB
        uDmo8dIw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qr1lA-001BSX-D7; Thu, 12 Oct 2023 19:54:16 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-sparc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Erhard Furtner <erhard_f@mailbox.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH 1/2] powerpc: Allow nesting of lazy MMU mode
Date:   Thu, 12 Oct 2023 20:54:14 +0100
Message-Id: <20231012195415.282357-2-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231012195415.282357-1-willy@infradead.org>
References: <20231012195415.282357-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As noted in commit 49147beb0ccb ("x86/xen: allow nesting of same lazy
mode"), we can now nest calls to arch_enter_lazy_mmu_mode().  Use ->active
as a counter instead of a flag and only drain the batch when the counter
hits 0.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Fixes: bcc6cc832573 ("mm: add default definition of set_ptes()")
---
 arch/powerpc/include/asm/book3s/64/tlbflush-hash.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
index 146287d9580f..bc845d876ed2 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
@@ -38,7 +38,7 @@ static inline void arch_enter_lazy_mmu_mode(void)
 	 */
 	preempt_disable();
 	batch = this_cpu_ptr(&ppc64_tlb_batch);
-	batch->active = 1;
+	batch->active++;
 }
 
 static inline void arch_leave_lazy_mmu_mode(void)
@@ -49,9 +49,8 @@ static inline void arch_leave_lazy_mmu_mode(void)
 		return;
 	batch = this_cpu_ptr(&ppc64_tlb_batch);
 
-	if (batch->index)
+	if ((--batch->active == 0) && batch->index)
 		__flush_tlb_pending(batch);
-	batch->active = 0;
 	preempt_enable();
 }
 
-- 
2.40.1

