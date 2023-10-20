Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7247D0EAA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377194AbjJTLiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377209AbjJTLh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:37:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC99D68;
        Fri, 20 Oct 2023 04:37:24 -0700 (PDT)
Date:   Fri, 20 Oct 2023 11:37:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697801843;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VZnpPAqbrmv02HdC2w4Y3PtXSM3mmPBUz8+kcQ5+Adw=;
        b=h6O1zJr8vYsDscJEJhPrBRGFLx56y452Arg7XKtxFxRIL5LUsLi+TnIw/7263kFIkBDViA
        3WuRVQSGis148MyNEEC8A9M+MTONIA5QICQ47bdsWq1+2+egTkXWSFPFlHbYjLocgaJ/0c
        YFLrnwRrFwLkuC6z2A3H1SjMxKSJHqnbd2RWTC5+91f1jkbAU/y+ZT1wgoEM1SST0CKKQn
        fMJXyTjGNVNWS8MovGTK0OVTcCIDc1MJyVlgsyNMq+654/ZX/8rbG3o+wJNKG/FzzA12ra
        VNwS869PwnBqszEIGDmkZuvO8yKGfdtux4muj7aewL6x8UG4Oqw6hp+UyNsUuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697801843;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VZnpPAqbrmv02HdC2w4Y3PtXSM3mmPBUz8+kcQ5+Adw=;
        b=fVwOEpHuuk2FN8H5FSfdFlwZ7xCsBqCPNpqQedq9F127TeoS7e5KlqPMv2/Vs8N+ZWhvCC
        7mwLTbXMO2Y+NYDQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/srso: Print mitigation for retbleed IBPB case
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <ec3af919e267773d896c240faf30bfc6a1fd6304.1693889988.git.jpoimboe@kernel.org>
References: <ec3af919e267773d896c240faf30bfc6a1fd6304.1693889988.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <169780184235.3135.8762098632049050879.tip-bot2@tip-bot2>
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

Commit-ID:     de9f5f7b06a5b7adbfdd8016f011120a4e928add
Gitweb:        https://git.kernel.org/tip/de9f5f7b06a5b7adbfdd8016f011120a4e928add
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 04 Sep 2023 22:04:51 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 20 Oct 2023 11:45:24 +02:00

x86/srso: Print mitigation for retbleed IBPB case

When overriding the requested mitigation with IBPB due to retbleed=ibpb,
print the mitigation in the usual format instead of a custom error
message.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/ec3af919e267773d896c240faf30bfc6a1fd6304.1693889988.git.jpoimboe@kernel.org
---
 arch/x86/kernel/cpu/bugs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 235c0e0..6c47f37 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2425,9 +2425,8 @@ static void __init srso_select_mitigation(void)
 
 	if (retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
 		if (has_microcode) {
-			pr_err("Retbleed IBPB mitigation enabled, using same for SRSO\n");
 			srso_mitigation = SRSO_MITIGATION_IBPB;
-			goto pred_cmd;
+			goto out;
 		}
 	}
 
@@ -2490,7 +2489,8 @@ static void __init srso_select_mitigation(void)
 		break;
 	}
 
-	pr_info("%s%s\n", srso_strings[srso_mitigation], (has_microcode ? "" : ", no microcode"));
+out:
+	pr_info("%s%s\n", srso_strings[srso_mitigation], has_microcode ? "" : ", no microcode");
 
 pred_cmd:
 	if ((!boot_cpu_has_bug(X86_BUG_SRSO) || srso_cmd == SRSO_CMD_OFF) &&
