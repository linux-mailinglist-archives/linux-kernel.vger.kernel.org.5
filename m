Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32335792AAE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343771AbjIEQlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354195AbjIEKJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:09:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C080B90;
        Tue,  5 Sep 2023 03:09:37 -0700 (PDT)
Date:   Tue, 05 Sep 2023 10:09:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693908575;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s0LnLYJv1Oti7ETUkO3cyWs4GHvRslHGkJnP3ySmzGc=;
        b=S9ekXuYSd2CVkRhbXdUfREgrzwye4n0R2BiPTQHNnjlm5GLdCpfvlJctSuBLO3H6OOn8gp
        KOqlfQIRfC+3XV/4QrLQpJ/sxB4pGDNcZmS7qJU8DrBroNsKM9bSHiKvSTwRQIhdHcI9B6
        fVR+wDtP0zMlwb1sPj7fu+Jjmp3K7TZ4+IO/4+416ac3G2p4PBSDT9cqRqJZfEMcJR2nIg
        lkZ583HrwoLnyjjwlxfg62csihPZofXsxh73IY5rygpWYS1ZJIGRnhAd5jFbXE/IE4J0FO
        YrY+YcId6kJX8q530AHX1CyeIrDBF7c6KufIAT3dwd+sGaA/TVPXXEs/xW38xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693908575;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s0LnLYJv1Oti7ETUkO3cyWs4GHvRslHGkJnP3ySmzGc=;
        b=l4OHHZC3MplylMIHUSKuXicBRAwj4TS0eJp+VQbcCLDhaGf5oJOBpZPeVsRSd1UHL7Xpg8
        efk/1s6jyemtxvDg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/srso: Move retbleed IBPB check into existing
 'has_microcode' code block
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <0a22b86b1f6b07f9046a9ab763fc0e0d1b7a91d4.1693889988.git.jpoimboe@kernel.org>
References: <0a22b86b1f6b07f9046a9ab763fc0e0d1b7a91d4.1693889988.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <169390857467.27769.14405035149732767972.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     a94be9ae24d2e1580cf68fb58e14369ae6a4846b
Gitweb:        https://git.kernel.org/tip/a94be9ae24d2e1580cf68fb58e14369ae6a4846b
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 04 Sep 2023 22:04:59 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 05 Sep 2023 12:05:07 +02:00

x86/srso: Move retbleed IBPB check into existing 'has_microcode' code block

Simplify the code flow a bit by moving the retbleed IBPB check into the
existing 'has_microcode' block.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/0a22b86b1f6b07f9046a9ab763fc0e0d1b7a91d4.1693889988.git.jpoimboe@kernel.org
---
 arch/x86/kernel/cpu/bugs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 941ac94..6b443f0 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2430,10 +2430,8 @@ static void __init srso_select_mitigation(void)
 			setup_force_cpu_cap(X86_FEATURE_SRSO_NO);
 			return;
 		}
-	}
 
-	if (retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
-		if (has_microcode) {
+		if (retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
 			srso_mitigation = SRSO_MITIGATION_IBPB;
 			goto out;
 		}
