Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494EC7CDA12
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjJRLNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjJRLNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:13:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D748111
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 04:13:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B48B521AC1;
        Wed, 18 Oct 2023 11:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697627608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u6u9y46jkVER60u+w3B28cBFCMC/ngKcpVS2qgksG3Q=;
        b=X7SBrMoEQA863Gp09EG6nMRYgpeIDOKNyRXqyAkkW+4By2yAHuAlxs+R5qEdc3uv6MkMCp
        J43eUsCyGcfMCZQSdG/Vc34Cewggg01DdijWLay3oeLCxm1bUTSDP35iZ7qY7cZCbB5K4R
        B8mSF0lltb02NNExrl1v4rW8FH9Hw90=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9BFB813915;
        Wed, 18 Oct 2023 11:13:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZFg1JNi9L2VPZwAAMHmgww
        (envelope-from <aporta@suse.de>); Wed, 18 Oct 2023 11:13:28 +0000
From:   Andrea della Porta <andrea.porta@suse.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nik.borisov@suse.com, Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH 3/4] arm64/entry-common: Make Aarch32 syscalls' availability depend on aarch32_enabled()
Date:   Wed, 18 Oct 2023 13:13:21 +0200
Message-ID: <88bdea628a13747bff32c0c3055d6d6ef7264d96.1697614386.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697614386.git.andrea.porta@suse.com>
References: <cover.1697614386.git.andrea.porta@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -2.85
X-Spamd-Result: default: False [-2.85 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-0.15)[68.94%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         REPLY(-4.00)[];
         RCPT_COUNT_FIVE(0.00)[6];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
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
ability to access 32bit syscalls. Such syscalls can be invoked by
using the svc instruction.

If Aarch32 emulation is disabled ensure that calling svc results
in the same behavior as if CONFIG_COMPAT has not been enabled (i.e.
a kernel panic).

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 arch/arm64/kernel/entry-common.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

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

