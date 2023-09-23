Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B817AC1EE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 14:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjIWMU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 08:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbjIWMU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 08:20:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72B51B1;
        Sat, 23 Sep 2023 05:20:13 -0700 (PDT)
Date:   Sat, 23 Sep 2023 12:20:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695471612;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wUHBMA9vy8RdqlVkVInBTvLqhO6QzlRxLsLW64rgEYE=;
        b=XvMZDSc02TvLhacFQMcwteZCNhXhdKRvYBD7EOJXT0JKTl3qG5IMfK97eRef48PzzehokD
        /jEeBfLWlRlOo5o1ZV6ObYpjrdKvWByOQ1ZVNrxPwkjVSXBY9gxqrCx4vSSXEptWomQ9tf
        KsHyJ5/HyOSKqi8OFql0F1nZKyrsgIUzSAfWJEhA1bRj0G54UzvcgUwEOAMVBzc3Lha09l
        /N/oWZd6bty/gPWvE6TvvQits4gK07XJQO+diaiorRJrU5B7+JvLyFKeysdNzQ3bpP0svq
        YF0u/7Z0adIPwivgcuIzBGiIoqXCpSsFKDyqQMdimvbpnbN9jEiIDkAP+4P1rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695471612;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wUHBMA9vy8RdqlVkVInBTvLqhO6QzlRxLsLW64rgEYE=;
        b=QIgP5va3clsSmm34MgsESxgDCnlT4jAzK3pw9ekaVCxz8ejXSgJu+DMge1RAvB0eW1Lxgw
        dYMvjyJB8I7CziCg==
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
Message-ID: <169547161190.27769.8155574985586985475.tip-bot2@tip-bot2>
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

Commit-ID:     8e7f2ef76ed2360dabe3ccd253042f9f9054db65
Gitweb:        https://git.kernel.org/tip/8e7f2ef76ed2360dabe3ccd253042f9f9054db65
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 04 Sep 2023 22:04:51 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 23 Sep 2023 14:13:02 +02:00

x86/srso: Print mitigation for retbleed IBPB case

When overriding the requested mitigation with IBPB due to retbleed=ibpb,
print the mitigation in the usual format instead of a custom error
message.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
