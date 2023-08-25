Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D94788090
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 09:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243344AbjHYHDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 03:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242733AbjHYHCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 03:02:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A621D3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 00:02:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20AEB66658
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:02:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DA7C433CB;
        Fri, 25 Aug 2023 07:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692946934;
        bh=vc/fpVk3bxy2ex4nbxSxEwbS+F8Y//JwnGv+3rBD+Rs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mLHfznP8aizF6S7oxNi5andly3kHpxrG2MNiA7O5/5BmyJfQXd1HI0bp2RTsLSx1O
         qey0EXBV+RiYQMwjVsLZf2J2H9KCW3U9pUDTx4eXZI/Dy2nGtYQsKDi1Pc1adJ/ZZl
         Pk6uhMI/VfeS2cd4IdX4lQJEDP32Q6OCpGBI33mIcpSEf2KYVt2j0eFM5r0+rDKv9C
         /I4BPaA4iDrQ3QZem10oo1LgWaB4hCUr3OLtXJ3m26GlmA0kaJsfo/WiSgXnRA6I3s
         sML77KR4BFhXe5XYeev+14FmO1RMwTcD04zXzC/FN5GynAFg0Oi/VlIVOmKgh2+NCr
         zGo80eQ8t135w==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 21/23] x86/retpoline: Remove .text..__x86.return_thunk section
Date:   Fri, 25 Aug 2023 00:01:52 -0700
Message-ID: <34947acf1c8a1be2d3ba9a4d0dd8a3001ae3c0db.1692919072.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692919072.git.jpoimboe@kernel.org>
References: <cover.1692919072.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The '.text..__x86.return_thunk' section has no purpose.  Remove it and
let the return thunk code live in '.text..__x86.indirect_thunk'.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kernel/vmlinux.lds.S | 3 ---
 arch/x86/lib/retpoline.S      | 2 --
 2 files changed, 5 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 9188834e56c9..f1c3516d356d 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -132,10 +132,7 @@ SECTIONS
 		LOCK_TEXT
 		KPROBES_TEXT
 		SOFTIRQENTRY_TEXT
-#ifdef CONFIG_RETPOLINE
 		*(.text..__x86.indirect_thunk)
-		*(.text..__x86.return_thunk)
-#endif
 		STATIC_CALL_TEXT
 
 		ALIGN_ENTRY_TEXT_BEGIN
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 415521dbe15e..49f2be7c7b35 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -129,8 +129,6 @@ SYM_CODE_END(__x86_indirect_jump_thunk_array)
 
 #ifdef CONFIG_RETHUNK
 
-	.section .text..__x86.return_thunk
-
 #ifdef CONFIG_CPU_SRSO
 
 /*
-- 
2.41.0

