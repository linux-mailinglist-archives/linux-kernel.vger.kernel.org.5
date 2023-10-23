Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEEB7D39F0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbjJWOoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbjJWOnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:43:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067721FD4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:42:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 548FD1FE25;
        Mon, 23 Oct 2023 14:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1698072147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+I9ud1Xuz1QVsjjSIfjL5lCnrVLHZ6fU43dq2sdHnMY=;
        b=ZnpY4uBkNksiRZIcuaIZLNFna9sII/TYaINRsWSXNc6OdlfhvABzLZ16+G+q94Tzm7blpJ
        PMeCt0I7PQHC2/G80z3PJUEFkVOvR8qTtss5N2SydDmRGdI871w6Ja15+iK+hQjWSXzKJn
        h+cGzSpnfJzOfDwOp68ksqiZVoAEzZo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 39BE5139C2;
        Mon, 23 Oct 2023 14:42:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zHHgC1OGNmXFdgAAMHmgww
        (envelope-from <aporta@suse.de>); Mon, 23 Oct 2023 14:42:27 +0000
From:   Andrea della Porta <andrea.porta@suse.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nik.borisov@suse.com, arnd@arndb.de, mark.rutland@arm.com,
        Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH v2 3/4] arm64/entry-common: Make Aarch32 exceptions' availability depend on aarch32_enabled()
Date:   Mon, 23 Oct 2023 16:42:22 +0200
Message-ID: <d0484051d8ff23e0ed1f2933789cde3d390a2fa6.1698069331.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1698069331.git.andrea.porta@suse.com>
References: <cover.1698069331.git.andrea.porta@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -5.70
X-Spamd-Result: default: False [-5.70 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         REPLY(-4.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[8];
         MID_CONTAINS_FROM(1.00)[];
         FORGED_SENDER(0.30)[andrea.porta@suse.com,aporta@suse.de];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         FROM_NEQ_ENVFROM(0.10)[andrea.porta@suse.com,aporta@suse.de];
         RCVD_TLS_ALL(0.00)[]
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another major aspect of supporting running of 32bit processes is the
ability to access 32bit syscalls and exceptions. Syscalls, in
particular, can be invoked by using the svc instruction.

If Aarch32 support is disabled ensure that calling svc (or any
exceptions) from 32bit context results in the same behavior as if
CONFIG_COMPAT has not been enabled (i.e. a kernel panic).

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 arch/arm64/include/asm/exception.h |  7 +++++++
 arch/arm64/kernel/entry-common.c   | 25 ++++++++++++++++++++++---
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
index ad688e157c9b..ccb41ba8d86c 100644
--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -48,6 +48,13 @@ asmlinkage void el0t_32_irq_handler(struct pt_regs *regs);
 asmlinkage void el0t_32_fiq_handler(struct pt_regs *regs);
 asmlinkage void el0t_32_error_handler(struct pt_regs *regs);
 
+#ifdef CONFIG_COMPAT
+asmlinkage void el0t_32_sync_ni_handler(struct pt_regs *regs);
+asmlinkage void el0t_32_irq_ni_handler(struct pt_regs *regs);
+asmlinkage void el0t_32_fiq_ni_handler(struct pt_regs *regs);
+asmlinkage void el0t_32_error_ni_handler(struct pt_regs *regs);
+#endif
+
 asmlinkage void call_on_irq_stack(struct pt_regs *regs,
 				  void (*func)(struct pt_regs *));
 asmlinkage void asm_exit_to_user_mode(struct pt_regs *regs);
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 69ff9b8c0bde..32761760d9dd 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -802,6 +802,11 @@ asmlinkage void noinstr el0t_64_error_handler(struct pt_regs *regs)
 }
 
 #ifdef CONFIG_COMPAT
+UNHANDLED(el0t, 32, sync_ni)
+UNHANDLED(el0t, 32, irq_ni)
+UNHANDLED(el0t, 32, fiq_ni)
+UNHANDLED(el0t, 32, error_ni)
+
 static void noinstr el0_cp15(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_user_mode(regs);
@@ -821,6 +826,11 @@ static void noinstr el0_svc_compat(struct pt_regs *regs)
 
 asmlinkage void noinstr el0t_32_sync_handler(struct pt_regs *regs)
 {
+	if (!aarch32_enabled()) {
+		el0t_32_sync_ni_handler(regs);
+		return;
+	}
+
 	unsigned long esr = read_sysreg(esr_el1);
 
 	switch (ESR_ELx_EC(esr)) {
@@ -865,17 +875,26 @@ asmlinkage void noinstr el0t_32_sync_handler(struct pt_regs *regs)
 
 asmlinkage void noinstr el0t_32_irq_handler(struct pt_regs *regs)
 {
-	__el0_irq_handler_common(regs);
+	if (!aarch32_enabled())
+		el0t_32_irq_ni_handler(regs);
+	else
+		__el0_irq_handler_common(regs);
 }
 
 asmlinkage void noinstr el0t_32_fiq_handler(struct pt_regs *regs)
 {
-	__el0_fiq_handler_common(regs);
+	if (!aarch32_enabled())
+		el0t_32_fiq_ni_handler(regs);
+	else
+		__el0_fiq_handler_common(regs);
 }
 
 asmlinkage void noinstr el0t_32_error_handler(struct pt_regs *regs)
 {
-	__el0_error_handler_common(regs);
+	if (!aarch32_enabled())
+		el0t_32_error_ni_handler(regs);
+	else
+		__el0_error_handler_common(regs);
 }
 
 bool __aarch32_enabled __ro_after_init = true;
-- 
2.35.3

