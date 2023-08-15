Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608DA77D682
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 01:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240534AbjHOXJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 19:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240526AbjHOXIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 19:08:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E65BC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 16:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=jbwfzUfYwAhMlh7v4ac7NWW4BAx8Lm8Q9u70PaxXfWs=; b=AglFnBZgkijyTGw5EcYzT+X6Iq
        rdUFjovtFNW7j/tW4MSZShJvIQzXzYZwKNbIwQMqTIacCdWi5Qk6SBqQkjmnDavG5PEJLe6y7NRb8
        LZkgJ/JedXTBmt2nQHjMgU9UMdWq1StN34/iBjXT/fPFZZ3KjbNrZVjtigTvvNVUcpziBqmxJ8ybi
        YjLm8MzMof1IUmPkORhM6P4s9TO5o4f++2k+RVmNeHDUOKkjIB6eJ+5auDj1ztpKEbIuSJ4/ZqAdI
        4M/mQS3QvgrW7iWb/99qAot/u/APtklZ8ZAMXCaUuvwcpiLGqb1gyILpjW6qiVPhZrrUPy335UU+W
        XGe7ABvQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qW390-00B50N-Sc; Tue, 15 Aug 2023 23:08:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 24599300222;
        Wed, 16 Aug 2023 01:08:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 025B720307331; Wed, 16 Aug 2023 01:08:09 +0200 (CEST)
Date:   Wed, 16 Aug 2023 01:08:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@kernel.org, x86@kernel.org
Cc:     baron@akamai.com, rostedt@goodmis.org, ardb@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, christian@bricart.de,
        song@kernel.org, mcgrof@kernel.org
Subject: [PATCH] x86/static_call: Fix __static_call_fixup()
Message-ID: <20230815230809.GA973560@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Christian reported spurious module crashes after some of Song's module
memory layout patches.

Turns out that if the very last instruction on the very last page of the
module is a 'JMP __x86_return_thunk' then __static_call_fixup() will
trip a fault and dies.

And while the module rework made this slightly more likely to happen,
it's always been possible.

Fixes: ee88d363d156 ("x86,static_call: Use alternative RET encoding")
Reported-by: Christian Bricart <christian@bricart.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/static_call.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index b70670a98597..2e67512d7104 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -186,6 +186,16 @@ EXPORT_SYMBOL_GPL(arch_static_call_transform);
  */
 bool __static_call_fixup(void *tramp, u8 op, void *dest)
 {
+	/*
+	 * Not all .return_sites are a static_call trampoline (most are not).
+	 * Check if the next 3 bytes are still kernel text, if not, then this
+	 * definitely is not a trampoline and we need not worry further.
+	 *
+	 * This avoids the memcmp() below tripping over pagefaults etc..
+	 */
+	if (!kernel_text_address(tramp+7))
+		return false;
+
 	if (memcmp(tramp+5, tramp_ud, 3)) {
 		/* Not a trampoline site, not our problem. */
 		return false;
