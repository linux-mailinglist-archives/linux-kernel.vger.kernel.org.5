Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5FA7926B6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238858AbjIEQG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354204AbjIEKJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:09:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E3F1B7;
        Tue,  5 Sep 2023 03:09:41 -0700 (PDT)
Date:   Tue, 05 Sep 2023 10:09:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693908579;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ofQf6W5VihTb3si8aXKClcOKoeSL6r+EV5ypcCEIJbQ=;
        b=0l2sbP5fnoNfGuRoJw9CzbZlpI75QMvTZYhFEfOWN6s/kEnfdgKVmui81D4d+ClxLt2bW1
        zpA0QX6/wWFzzO2K8S/5EHFjBF6AlRpDLHl9X73PiCqxBNGi9bOcN3+z84TkXvam/HjZxi
        xmYyOYLbF27OBsn6dfwmIIXeplG7orn1MYnRSmVdlRuVmkdhnjJrL74dBrRM1y7krpvbHE
        rYr3WSgUcoDYJMi9fqzwQlKIvjCe/o+Mov7W4Ib08lauYSUBBvCsAidM8hUNoaiBTEiREV
        4ZZGYull/zkxZ4UEbnZ/mzBaRIuwH15r8f0bZByObK65tEFNnehLaFUz97uiow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693908579;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ofQf6W5VihTb3si8aXKClcOKoeSL6r+EV5ypcCEIJbQ=;
        b=GUQRWo545jNUZaIX0e1Cq8F9L/ePLvLWidqtyR1spTTVl/kciVegZDdAsuZfx1h8ahC9G1
        C8zVX0I/tapnUoAg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/srso: Fix SBPB enablement for (possible) future fixed HW
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <cee5050db750b391c9f35f5334f8ff40e66c01b9.1693889988.git.jpoimboe@kernel.org>
References: <cee5050db750b391c9f35f5334f8ff40e66c01b9.1693889988.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <169390857919.27769.4882082606268599167.tip-bot2@tip-bot2>
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

Commit-ID:     94e07e94c7ea53757995b8702171f4cd1936fb8c
Gitweb:        https://git.kernel.org/tip/94e07e94c7ea53757995b8702171f4cd1936fb8c
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 04 Sep 2023 22:04:49 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 05 Sep 2023 12:05:06 +02:00

x86/srso: Fix SBPB enablement for (possible) future fixed HW

Make the SBPB check more robust against the (possible) case where future
HW has SRSO fixed but doesn't have the SRSO_NO bit set.

Fixes: 1b5277c0ea0b ("x86/srso: Add SRSO_NO support")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/cee5050db750b391c9f35f5334f8ff40e66c01b9.1693889988.git.jpoimboe@kernel.org
---
 arch/x86/kernel/cpu/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 10499bc..2859a54 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2496,7 +2496,7 @@ static void __init srso_select_mitigation(void)
 	pr_info("%s%s\n", srso_strings[srso_mitigation], (has_microcode ? "" : ", no microcode"));
 
 pred_cmd:
-	if ((boot_cpu_has(X86_FEATURE_SRSO_NO) || srso_cmd == SRSO_CMD_OFF) &&
+	if ((!boot_cpu_has_bug(X86_BUG_SRSO) || srso_cmd == SRSO_CMD_OFF) &&
 	     boot_cpu_has(X86_FEATURE_SBPB))
 		x86_pred_cmd = PRED_CMD_SBPB;
 }
