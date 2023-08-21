Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC4E782120
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 03:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjHUBTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 21:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjHUBTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 21:19:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3330A7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 18:19:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29F5E6262C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 01:19:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FF5C433C7;
        Mon, 21 Aug 2023 01:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692580772;
        bh=cKXSzs/GUEvs26+fpizGrJrw9SNStmp/8vwJrE4ZCdU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fDhgXkcUW+RwnhthW7e0QlBAsWoDwl4x02V7AbBr9W5iHbVqPx00zYESASaq82EUH
         /13iJ8fBI4vjnsnfi8X3SSr6AzPX1lNk2Z/zyMXigZQCJUvPzORWXa06P1UufDRImA
         wVmTNfqgbZ/ZgSwrrSt66e90CVUKRlKaCOCVMZSSwn6kSOhQw76TpGz63hjluZMaCr
         o6a7G7Z4l5BWcFZh8+750eRs2C15QeD9H+7vbKSPnqmS+cp8uszYEMQ3/4TTXcAcOZ
         pg7qE19QGOm8/YcRKg1+7T5e3BCmZH6kBdeymsJtkE/vlDDhO0LGqvV/jtijeHN9z/
         gfwTt4e9sFy+A==
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
Subject: [PATCH 09/22] x86/srso: Simplify exit paths
Date:   Sun, 20 Aug 2023 18:19:06 -0700
Message-ID: <7ca5ccd02ba4a6fcf95d34764be79ded4d88c1b9.1692580085.git.jpoimboe@kernel.org>
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

Send all function exit paths through the pred_cmd check to simplify the
control flow and make it more future-proof.

While at it, rename the 'pred_cmd' label to 'out' to make it clear that
it's the exit.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kernel/cpu/bugs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index e59e09babf8f..da480c089739 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2407,7 +2407,7 @@ static void __init srso_select_mitigation(void)
 	bool has_microcode = boot_cpu_has(X86_FEATURE_IBPB_BRTYPE);
 
 	if (!boot_cpu_has_bug(X86_BUG_SRSO) || cpu_mitigations_off())
-		goto pred_cmd;
+		goto out;
 
 	if (!has_microcode) {
 		pr_warn("IBPB-extending microcode not applied!\n");
@@ -2419,7 +2419,7 @@ static void __init srso_select_mitigation(void)
 		 */
 		if (boot_cpu_data.x86 < 0x19 && !cpu_smt_possible()) {
 			setup_force_cpu_cap(X86_FEATURE_SRSO_NO);
-			return;
+			goto out;
 		}
 	}
 
@@ -2427,13 +2427,13 @@ static void __init srso_select_mitigation(void)
 		if (has_microcode) {
 			pr_info("Retbleed IBPB mitigation enabled, using same for SRSO\n");
 			srso_mitigation = SRSO_MITIGATION_IBPB;
-			goto pred_cmd;
+			goto out;
 		}
 	}
 
 	switch (srso_cmd) {
 	case SRSO_CMD_OFF:
-		goto pred_cmd;
+		goto out;
 
 	case SRSO_CMD_MICROCODE:
 		if (has_microcode) {
@@ -2489,7 +2489,7 @@ static void __init srso_select_mitigation(void)
 
 	pr_info("%s%s\n", srso_strings[srso_mitigation], (has_microcode ? "" : ", no microcode"));
 
-pred_cmd:
+out:
 	if (boot_cpu_has(X86_FEATURE_SBPB) && srso_mitigation == SRSO_MITIGATION_NONE)
 		x86_pred_cmd = PRED_CMD_SBPB;
 }
-- 
2.41.0

