Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC5F77DF91
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244216AbjHPKqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244174AbjHPKpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:45:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B0D2D59
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 03:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0JdrWOJluu/S8f7RqK4Xy++CAfnHudALXmCN2ITRnFc=; b=eOD5p639gXFa+3sNEG3NyWt+sY
        SmtBM8olp0sYRHaISNgwz6iZ1Oi4jnXxb31C4TG4SN7VBHZuIL6PpBzO7fbnoUiaEpvJUPOML25ky
        qLK44B9nyrpNHa9qL2m5VNdNDMwT9Oe8O2nvp27msrphYjop0NupfENBUcsm4GAQ6Iut8ljCOmezv
        JkWTu0rwhZq1Hn9zMBVA3Zl7Q5peiI25BCLN+LGR03EGa5Q/KryNSCuSd5w5jc6uSwvCH9O55v2v4
        SeCSnAAAvEScmmxb1CnOnLA1FtAX0zFH3HvuKr2Z52S71XwLTviqwZA2x/NM9zWtkoBnr4zkJ5MO2
        AWreRPrA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qWE0j-00EByf-2Q; Wed, 16 Aug 2023 10:44:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 00B82300137;
        Wed, 16 Aug 2023 12:44:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CD7562C8E889B; Wed, 16 Aug 2023 12:44:19 +0200 (CEST)
Date:   Wed, 16 Aug 2023 12:44:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@kernel.org, x86@kernel.org
Cc:     baron@akamai.com, rostedt@goodmis.org, ardb@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, christian@bricart.de,
        song@kernel.org, mcgrof@kernel.org
Subject: [PATCH v2] x86/static_call: Fix __static_call_fixup()
Message-ID: <20230816104419.GA982867@hirez.programming.kicks-ass.net>
References: <20230815230809.GA973560@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815230809.GA973560@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Christian reported spurious module load crashes after some of Song's
module memory layout patches.

Turns out that if the very last instruction on the very last page of the
module is a 'JMP __x86_return_thunk' then __static_call_fixup() will
trip a fault and die.

And while the module rework made this slightly more likely to happen,
it's always been possible.

Fixes: ee88d363d156 ("x86,static_call: Use alternative RET encoding")
Reported-by: Christian Bricart <christian@bricart.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/static_call.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -186,6 +186,19 @@ EXPORT_SYMBOL_GPL(arch_static_call_trans
  */
 bool __static_call_fixup(void *tramp, u8 op, void *dest)
 {
+	unsigned long addr = (unsigned long)tramp;
+	/*
+	 * Not all .return_sites are a static_call trampoline (most are not).
+	 * Check if the 3 bytes after the return are still kernel text, if not,
+	 * then this definitely is not a trampoline and we need not worry
+	 * further.
+	 *
+	 * This avoids the memcmp() below tripping over pagefaults etc..
+	 */
+	if (((addr >> PAGE_SHIFT) != ((addr + 7) >> PAGE_SHIFT)) &&
+	    !kernel_text_address(addr + 7))
+		return false;
+
 	if (memcmp(tramp+5, tramp_ud, 3)) {
 		/* Not a trampoline site, not our problem. */
 		return false;
