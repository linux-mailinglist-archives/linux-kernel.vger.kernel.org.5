Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545E4782113
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 03:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbjHUBTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 21:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbjHUBTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 21:19:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7BF9C
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 18:19:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFAA762600
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 01:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC1BC433C8;
        Mon, 21 Aug 2023 01:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692580770;
        bh=1JVPtgGBWI8sOMGshKa4etXbpP/NdE2A1szA4ieQYNk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KFfuS7glWuB7Z2a4DrXLRwBdhw4LYC7XgZB020eMoUN/861t1bqyK8TDkfN4PfKfx
         0e3+jDBLlBLZlXKV00lAyvmGJSsyDlV0ix4cm467fYgNWHRwya23LDr56yvEYVJpBS
         kBAa0OZFOwwDMsoa9eTq9Pc+ErWD+utTnJQ5VfUngbeLk0S+eLucJkKEdjsRUvz7eZ
         j4zkjZ6tJQAxM7rOLtmTXMwPivQuI6hBBgMoTfzqKsl4CXeys1rUPpcUL5ZQoCsWED
         n+eorHqQLuSbYXV2IDzPggmRM8i7YBv1PPugTlNR2HlVd+XZSsCexu5fsDfZFAUp/7
         rQGyBL+YfS3vQ==
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
Subject: [PATCH 05/22] x86/srso: Fix SBPB enablement for mitigations=off
Date:   Sun, 20 Aug 2023 18:19:02 -0700
Message-ID: <141c92f20ab46cf0c028e86b946134cd702d0ea5.1692580085.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692580085.git.jpoimboe@kernel.org>
References: <cover.1692580085.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the user has requested no mitigations with mitigations=off, use the
lighter-weight SBPB instead of IBPB for other mitigations.

Note that even with mitigations=off, IBPB/SBPB may still be used for
Spectre v2 user <-> user protection.  Whether that makes sense is a
question for another day.

Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kernel/cpu/bugs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 10499bcd4e39..ff5bfe8f0ee9 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2496,8 +2496,7 @@ static void __init srso_select_mitigation(void)
 	pr_info("%s%s\n", srso_strings[srso_mitigation], (has_microcode ? "" : ", no microcode"));
 
 pred_cmd:
-	if ((boot_cpu_has(X86_FEATURE_SRSO_NO) || srso_cmd == SRSO_CMD_OFF) &&
-	     boot_cpu_has(X86_FEATURE_SBPB))
+	if (boot_cpu_has(X86_FEATURE_SBPB) && srso_mitigation == SRSO_MITIGATION_NONE)
 		x86_pred_cmd = PRED_CMD_SBPB;
 }
 
-- 
2.41.0

