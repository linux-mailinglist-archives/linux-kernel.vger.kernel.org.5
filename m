Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA392788087
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 09:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243185AbjHYHDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 03:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242699AbjHYHCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 03:02:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BFAE6B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 00:02:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F451636D4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:02:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C5BC433C7;
        Fri, 25 Aug 2023 07:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692946931;
        bh=/LMUUmYy8woWUbMng0fqzBv0Si0zv45Y8zZTxKZ5pOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iJvHJ2OTIi2oOt2WsSwrjJBoymwe29m8+f+hpBV4qlfSRMgUQYFFHDu8TvPb+RVp/
         0+jD3kTlylP+nCYYsfG9vX70xttpFn0C/VnP4YEtpEXFI2T5WdZvJrhnu9zGbf0eiB
         mltisxHOhasCKo0D1eyWlqIvpcGTu3pL9jqDW/o1JtcCo5pvR2g1T7l42Q2HXd1tnz
         7jpviLAYhPJxWlE89/yKocoADsrxzMTfPI80RCfsUwdYlCbRdryPJVL49gmPERa8d8
         Yd+OW6czl4BPJUBQX7Be1xJI962Js6WqQ53ogRA0MueB/qQwMxA2aevCYrOmdC3VYy
         tFHHUJu/r7/1g==
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
Subject: [PATCH 15/23] x86/srso: Remove 'pred_cmd' label
Date:   Fri, 25 Aug 2023 00:01:46 -0700
Message-ID: <ec18b04787fc21874303f29746a49847751eddd6.1692919072.git.jpoimboe@kernel.org>
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

SBPB is only enabled in two distinct cases:

1) when SRSO has been disabled with srso=off

2) when SRSO has been fixed (in future HW)

Simplify the control flow by getting rid of the 'pred_cmd' label and
moving the SBPB enablement check to the two corresponding code sites.
This makes it more clear when exactly SBPB gets enabled.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kernel/cpu/bugs.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d883d1c38f7f..3c7f634b6148 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2410,13 +2410,21 @@ static void __init srso_select_mitigation(void)
 {
 	bool has_microcode = boot_cpu_has(X86_FEATURE_IBPB_BRTYPE);
 
-	if (!boot_cpu_has_bug(X86_BUG_SRSO) || cpu_mitigations_off())
-		goto pred_cmd;
+	if (cpu_mitigations_off())
+		return;
+
+	if (!boot_cpu_has_bug(X86_BUG_SRSO)) {
+		if (boot_cpu_has(X86_FEATURE_SBPB))
+			x86_pred_cmd = PRED_CMD_SBPB;
+		return;
+	}
 
 	if (has_microcode) {
 		/*
 		 * Zen1/2 with SMT off aren't vulnerable after the right
 		 * IBPB microcode has been applied.
+		 *
+		 * Zen1/2 don't have SBPB, no need to try to enable it here.
 		 */
 		if (boot_cpu_data.x86 < 0x19 && !cpu_smt_possible()) {
 			setup_force_cpu_cap(X86_FEATURE_SRSO_NO);
@@ -2439,7 +2447,9 @@ static void __init srso_select_mitigation(void)
 
 	switch (srso_cmd) {
 	case SRSO_CMD_OFF:
-		goto pred_cmd;
+		if (boot_cpu_has(X86_FEATURE_SBPB))
+			x86_pred_cmd = PRED_CMD_SBPB;
+		return;
 
 	case SRSO_CMD_MICROCODE:
 		if (has_microcode) {
@@ -2501,11 +2511,6 @@ static void __init srso_select_mitigation(void)
 
 out:
 	pr_info("%s%s\n", srso_strings[srso_mitigation], has_microcode ? "" : ", no microcode");
-
-pred_cmd:
-	if ((!boot_cpu_has_bug(X86_BUG_SRSO) || srso_cmd == SRSO_CMD_OFF) &&
-	     boot_cpu_has(X86_FEATURE_SBPB))
-		x86_pred_cmd = PRED_CMD_SBPB;
 }
 
 #undef pr_fmt
-- 
2.41.0

