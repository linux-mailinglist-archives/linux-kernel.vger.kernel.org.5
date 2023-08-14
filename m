Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB74977B5A3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 11:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbjHNJih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 05:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235740AbjHNJiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 05:38:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CD119B9;
        Mon, 14 Aug 2023 02:37:40 -0700 (PDT)
Date:   Mon, 14 Aug 2023 09:37:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692005858;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F5gFe4yCE9PlQUdWkfqkyDI/QSw/oTR7ipx5+16LFuk=;
        b=SDcqvwM0nJdzuPZwCIYo4Vx53axKtU+eN6M46ftDGJD/15T/g7RxdzzCD1my4GVA1B9yEq
        V1vBlLC+yRFk5mLX/Z2ll87hjurnliu7HOm+RXFycKtJhfSkUBPOmSzSdTvXkksCXtPJRB
        HzC3TFSx42iLxlzlhl65hzAQw2TjJLLvPT+o3BMtr0gSLlthqwxucnfyonGt/fiBjpMA+m
        DPHuB1OK6/ziwthtSYSr1DyT8kNa/krPpVAldZ0dLXMKpJ5b8bxUjJMfwy9g43Sb2g6IFR
        /ai9SJT8+SrrSk+Az6YmXXCpNxdJBzEICFyyR8Fbn8vVo9Ihmrs+xmq6vJU1CA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692005858;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F5gFe4yCE9PlQUdWkfqkyDI/QSw/oTR7ipx5+16LFuk=;
        b=/LbkhOR8Iwun/rVB9ATlahASQGa4NEiuhXYZrcVwxQytHfb/Iqt7ExT7Hb9ad6uiQc1DCE
        bhDn5cXsN5Di8GBw==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/srso: Disable the mitigation on unaffected
 configurations
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230813104517.3346-1-bp@alien8.de>
References: <20230813104517.3346-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <169200585787.27769.13062428559701196926.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     e9fbc47b818b964ddff5df5b2d5c0f5f32f4a147
Gitweb:        https://git.kernel.org/tip/e9fbc47b818b964ddff5df5b2d5c0f5f32f4a147
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Sun, 13 Aug 2023 12:39:34 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 14 Aug 2023 11:28:51 +02:00

x86/srso: Disable the mitigation on unaffected configurations

Skip the srso cmd line parsing which is not needed on Zen1/2 with SMT
disabled and with the proper microcode applied (latter should be the
case anyway) as those are not affected.

Fixes: 5a15d8348881 ("x86/srso: Tie SBPB bit setting to microcode patch detection")
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230813104517.3346-1-bp@alien8.de
---
 arch/x86/kernel/cpu/bugs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d02f73c..6c04aef 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2418,8 +2418,10 @@ static void __init srso_select_mitigation(void)
 		 * IBPB microcode has been applied.
 		 */
 		if ((boot_cpu_data.x86 < 0x19) &&
-		    (!cpu_smt_possible() || (cpu_smt_control == CPU_SMT_DISABLED)))
+		    (!cpu_smt_possible() || (cpu_smt_control == CPU_SMT_DISABLED))) {
 			setup_force_cpu_cap(X86_FEATURE_SRSO_NO);
+			return;
+		}
 	}
 
 	if (retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
@@ -2696,6 +2698,9 @@ static ssize_t retbleed_show_state(char *buf)
 
 static ssize_t srso_show_state(char *buf)
 {
+	if (boot_cpu_has(X86_FEATURE_SRSO_NO))
+		return sysfs_emit(buf, "Not affected\n");
+
 	return sysfs_emit(buf, "%s%s\n",
 			  srso_strings[srso_mitigation],
 			  (cpu_has_ibpb_brtype_microcode() ? "" : ", no microcode"));
