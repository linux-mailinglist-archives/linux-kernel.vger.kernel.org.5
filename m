Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54A17D0EAE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377288AbjJTLiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377159AbjJTLh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:37:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F006D5E;
        Fri, 20 Oct 2023 04:37:23 -0700 (PDT)
Date:   Fri, 20 Oct 2023 11:37:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697801841;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4MDUK7liIbBHakljKlJh+tNiTWzLiecpqWQOUGcxgGM=;
        b=gVnL7xZLyLXsuOzbHlznv/nGu+IRslKX0ZvIIUaxFwcroIe7RGj0aKMu7HhOOW+phFMmG5
        uChrpxb2TQTyYlAIlxICNZ0hx668O8n/jUpknWwHygapnhcefc3SxnLg7NWlRKFfKSL3cK
        t+VKLn8A1NMCe/CLU6Z0Y9legumPYb6xGaYXBCx83JNA5lCeuY2ykh4t/pr3+wPfLQ61N6
        TEmAzvknl0lDKbF1b/IQroFSJ744zOp92LuYpy0HP/dWfE/pNrKsz7cU0a9jue2EZMlqWr
        sf7X3+cMk8889r9aJkx7/eNzuEiGRmcJZoXXm/ouDgHyuDHUGmVzyc/WPXM2TQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697801841;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4MDUK7liIbBHakljKlJh+tNiTWzLiecpqWQOUGcxgGM=;
        b=7/2tY9uNPri68giKzyYpcsVTgpPd6mn87ZxbbAsfup6bcJJP5Q5jlpGITRoQETs7HvVHNA
        /8npkclzq5dYe+DQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/srso: Improve i-cache locality for alias mitigation
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <eadaf5530b46a7ae8b936522da45ae555d2b3393.1693889988.git.jpoimboe@kernel.org>
References: <eadaf5530b46a7ae8b936522da45ae555d2b3393.1693889988.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <169780184083.3135.315755126931045324.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     aa730cff0c26244e88066b5b461a9f5fbac13823
Gitweb:        https://git.kernel.org/tip/aa730cff0c26244e88066b5b461a9f5fbac13823
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 04 Sep 2023 22:04:55 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 20 Oct 2023 12:04:18 +02:00

x86/srso: Improve i-cache locality for alias mitigation

Move srso_alias_return_thunk() to the same section as
srso_alias_safe_ret() so they can share a cache line.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/eadaf5530b46a7ae8b936522da45ae555d2b3393.1693889988.git.jpoimboe@kernel.org
---
 arch/x86/lib/retpoline.S | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index cd86aeb..9ab634f 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -177,15 +177,14 @@ SYM_START(srso_alias_safe_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	int3
 SYM_FUNC_END(srso_alias_safe_ret)
 
-	.section .text..__x86.return_thunk
-
-SYM_CODE_START(srso_alias_return_thunk)
+SYM_CODE_START_NOALIGN(srso_alias_return_thunk)
 	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
 	call srso_alias_safe_ret
 	ud2
 SYM_CODE_END(srso_alias_return_thunk)
 
+	.section .text..__x86.return_thunk
 /*
  * Some generic notes on the untraining sequences:
  *
