Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A58F792B76
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240533AbjIEQxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351018AbjIEFFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 01:05:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B4B18C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 22:05:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E23A3B810AF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 05:05:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29106C433C9;
        Tue,  5 Sep 2023 05:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693890315;
        bh=ze2yNnGkWnKe6M0KCNjylk/VDkj/AaoQbnmCXJNlCHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bDIKjPIfx4+OooTzPqnXC8DkO/lDgFSu62PUu7ZIaPs+AB3gh21PXKd9Wdi01AU2Y
         iSfvaSf8/k7NZaqeZ4ImOflmDkBo+6X3+yHuNTgNOCj6yh9EQYjehemTyv0cGdh4vK
         yo7jwdCs+8ZaOmoAV84M7693SbyG7SmCxz/sn4vzbw3HIRvRGa5EPdDjO2Of5wUNh1
         i3bYKLuT4LF85yJCamueGyEfGDr+rbC95N3MO+4caN01DCeJ7VW81/v+AtOCZ0qEVF
         5ZnsdMVDJy6rqvYkj6mVseDvbTZ0w/TEXZQv0KKI2RIbG5AEITguhQ8FUPAtswfpPz
         gh6h80V+mffEQ==
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
Subject: [PATCH v3 14/20] x86/bugs: Remove default case for fully switched enums
Date:   Mon,  4 Sep 2023 22:04:58 -0700
Message-ID: <fcf6feefab991b72e411c2aed688b18e65e06aed.1693889988.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693889988.git.jpoimboe@kernel.org>
References: <cover.1693889988.git.jpoimboe@kernel.org>
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

For enum switch statements which handle all possible cases, remove the
default case so a compiler warning gets printed if one of the enums gets
accidentally omitted from the switch statement.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kernel/cpu/bugs.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 4f1ad2350f49..941ac94ad0d4 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1019,7 +1019,6 @@ static void __init retbleed_select_mitigation(void)
 
 do_cmd_auto:
 	case RETBLEED_CMD_AUTO:
-	default:
 		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
 		    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
 			if (IS_ENABLED(CONFIG_CPU_UNRET_ENTRY))
@@ -1290,6 +1289,8 @@ spectre_v2_user_select_mitigation(void)
 
 		spectre_v2_user_ibpb = mode;
 		switch (cmd) {
+		case SPECTRE_V2_USER_CMD_NONE:
+			break;
 		case SPECTRE_V2_USER_CMD_FORCE:
 		case SPECTRE_V2_USER_CMD_PRCTL_IBPB:
 		case SPECTRE_V2_USER_CMD_SECCOMP_IBPB:
@@ -1301,8 +1302,6 @@ spectre_v2_user_select_mitigation(void)
 		case SPECTRE_V2_USER_CMD_SECCOMP:
 			static_branch_enable(&switch_mm_cond_ibpb);
 			break;
-		default:
-			break;
 		}
 
 		pr_info("mitigation: Enabling %s Indirect Branch Prediction Barrier\n",
@@ -2160,6 +2159,10 @@ static int l1d_flush_prctl_get(struct task_struct *task)
 static int ssb_prctl_get(struct task_struct *task)
 {
 	switch (ssb_mode) {
+	case SPEC_STORE_BYPASS_NONE:
+		if (boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS))
+			return PR_SPEC_ENABLE;
+		return PR_SPEC_NOT_AFFECTED;
 	case SPEC_STORE_BYPASS_DISABLE:
 		return PR_SPEC_DISABLE;
 	case SPEC_STORE_BYPASS_SECCOMP:
@@ -2171,11 +2174,8 @@ static int ssb_prctl_get(struct task_struct *task)
 		if (task_spec_ssb_disable(task))
 			return PR_SPEC_PRCTL | PR_SPEC_DISABLE;
 		return PR_SPEC_PRCTL | PR_SPEC_ENABLE;
-	default:
-		if (boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS))
-			return PR_SPEC_ENABLE;
-		return PR_SPEC_NOT_AFFECTED;
 	}
+	BUG();
 }
 
 static int ib_prctl_get(struct task_struct *task)
@@ -2504,9 +2504,6 @@ static void __init srso_select_mitigation(void)
 			pr_err("WARNING: kernel not compiled with CPU_SRSO.\n");
                 }
 		break;
-
-	default:
-		break;
 	}
 
 out:
-- 
2.41.0

