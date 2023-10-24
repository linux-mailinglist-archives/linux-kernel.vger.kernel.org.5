Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A8E7D58DE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343773AbjJXQlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbjJXQlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:41:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648E793;
        Tue, 24 Oct 2023 09:41:10 -0700 (PDT)
Date:   Tue, 24 Oct 2023 16:41:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698165668;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=laq+UrGh8ZQrJHWzngdcpAFroi+8VGjdjHZdPUy/rNc=;
        b=SKLfJl/XCVbAGj4FN1wg6swQ4y4pyaNVbeQ3njqyLTXClJyyE2CRdGTK/Ru+hFfuNYO4sm
        No8xCe4IKvxZjzM3WB/5mvgOIxFQVn/DIB2TXCdQMnLqk7ERXzsTzoEXzBhkIuyPqQ7kas
        bA7rGS5+NnXHJTXD1XXv0ucVfuaCj/tl93T+ky+VJckNHwDTskbcRSxurel63exj8Vwm0s
        /hTp2Bxvpkk/Cr/zs5t2O1crbi4hBhFBy+pGUXSBLShgubB9fKepVV+V/AumqBWnZzO70G
        ZhTgf/cqhGo1MRA79OkLitkhGnfiZXakpSwwez8Sup9SCfgakei2Odi9MEIgFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698165668;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=laq+UrGh8ZQrJHWzngdcpAFroi+8VGjdjHZdPUy/rNc=;
        b=Oy/VfzM+3UvS3YODWU8p4NWDzguDmXnzlRRpAlxLxGU6KVvalDtpnOLVf6n0Gm9+GSkk7o
        tnQYKKcquRNGqaAA==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/percpu: Return correct variable from
 current_top_of_stack()
Cc:     Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231024142830.3226-1-ubizjak@gmail.com>
References: <20231024142830.3226-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <169816566737.3135.2199759283838640174.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     0548eb067ed664b93043e033295ca71e3e706245
Gitweb:        https://git.kernel.org/tip/0548eb067ed664b93043e033295ca71e3e706245
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Tue, 24 Oct 2023 16:28:14 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 24 Oct 2023 18:37:20 +02:00

x86/percpu: Return correct variable from current_top_of_stack()

current_top_of_stack() should return variable from _seg_gs
qualified named address space when CONFIG_USE_X86_SEG_SUPPORT=y
is enbled.

Fixes: ed2f752e0e0a ("x86/percpu: Introduce const-qualified const_pcpu_hot to micro-optimize code generation")
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20231024142830.3226-1-ubizjak@gmail.com
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/processor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index b47a997..f20e876 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -519,7 +519,7 @@ static __always_inline unsigned long current_top_of_stack(void)
 	 *  entry trampoline.
 	 */
 	if (IS_ENABLED(CONFIG_USE_X86_SEG_SUPPORT))
-		return pcpu_hot.top_of_stack;
+		return const_pcpu_hot.top_of_stack;
 
 	return this_cpu_read_stable(pcpu_hot.top_of_stack);
 }
