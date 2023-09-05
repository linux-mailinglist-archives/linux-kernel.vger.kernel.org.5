Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59544792A9A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244016AbjIEQkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351049AbjIEFFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 01:05:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FF6CC5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 22:05:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C1376144F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 05:05:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A382EC433CA;
        Tue,  5 Sep 2023 05:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693890318;
        bh=vc/fpVk3bxy2ex4nbxSxEwbS+F8Y//JwnGv+3rBD+Rs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qm7hFpPuoneMtpu352C4KgS1bjCK9qX6s/MPeb+HOZsrPJ1aU/5DDsqNm7L/gv2NW
         WfADhO00YENHlRM5wKgo5eh6JWSW24XQ3x7YKLSHmcDtfuG2ID21sTTr3sa6ROh95Q
         wGfaxre5AdYJd7KPFABwPu9iHhV1GKJzW3FUuSnRd5h3ADQEmHRzf3y3SmgyUiaDQJ
         gxRmVlI0UwmjBvZ33CcLuj3y3EoktGjdZTe2AUbgRx3t+NCSR+y501FLO4LB5pLw3I
         bpIgIdw1Q841XIRCkkBIVI+33NNYHcNyEL2HtdXlOuI/lcS7cnjhRL1mkxK56BApie
         /4iAaR4tu1wOw==
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
Subject: [PATCH v3 18/20] x86/retpoline: Remove .text..__x86.return_thunk section
Date:   Mon,  4 Sep 2023 22:05:02 -0700
Message-ID: <291aad1dcb2d27c6241fe3f182d66119857757fd.1693889988.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693889988.git.jpoimboe@kernel.org>
References: <cover.1693889988.git.jpoimboe@kernel.org>
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

