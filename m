Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E847884D4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239415AbjHYKVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244437AbjHYKUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:20:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AAB212B;
        Fri, 25 Aug 2023 03:20:08 -0700 (PDT)
Date:   Fri, 25 Aug 2023 10:19:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692958774;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bT0k7KYVQRIuCbkueUNPUADuqr9cG91KK20SG3zGcC8=;
        b=SKq0VpKkZ0SXOVcbNmoSw6JyqjYbg43aGjTB4T8HKl+XYTK+B8Xj72Dnxi0/LYZ5oP3GDD
        xToZ6UroEIE3xbVfX0uMzWNZ0HWgQcN24X8C5DGyxNWWBY8k2Aga2kW4MYtl05wMtKNVIb
        pn5fjXw3+a4brk0e9owfmU53MR3+R3pcseeb8rOoSkeYW79HzKc1wRKP3bSQ1CvIlFh+RU
        JLtly9dO+vQHzH7do1YlDNOulH9ky2XLr1hBPOkzC0dIvdJNKR//SoUSIQijoJMYag79Dd
        +N5qFHKUnoFCn402Snvs8Y/HCk1V/O4/9QUerhm7uHmfR7Yo2peMxLNI+x7VlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692958774;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bT0k7KYVQRIuCbkueUNPUADuqr9cG91KK20SG3zGcC8=;
        b=E8KSKyPU+kWjQOb6u+aK+qqWNmwQJTyufFZ4FXRptvCcSU+FomI2ALCsLEFU1Yxwf2ODkN
        BZycuKaUTBQaesDA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/srso: Print actual mitigation if requested
 mitigation isn't possible
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <0f8b03be6b785efdc4a3d37feca0b25ef850e011.1692919072.git.jpoimboe@kernel.org>
References: <0f8b03be6b785efdc4a3d37feca0b25ef850e011.1692919072.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <169295877343.27769.6620178797623760558.tip-bot2@tip-bot2>
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

Commit-ID:     60b65d71d58153e1d3a2a87052c7b3e252008b91
Gitweb:        https://git.kernel.org/tip/60b65d71d58153e1d3a2a87052c7b3e252008b91
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Fri, 25 Aug 2023 00:01:39 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 25 Aug 2023 11:21:59 +02:00

x86/srso: Print actual mitigation if requested mitigation isn't possible

If the kernel wasn't compiled to support the requested option, print the
actual option that ends up getting used.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/0f8b03be6b785efdc4a3d37feca0b25ef850e011.1692919072.git.jpoimboe@kernel.org
---
 arch/x86/kernel/cpu/bugs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 2859a54..235c0e0 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2461,7 +2461,6 @@ static void __init srso_select_mitigation(void)
 			srso_mitigation = SRSO_MITIGATION_SAFE_RET;
 		} else {
 			pr_err("WARNING: kernel not compiled with CPU_SRSO.\n");
-			goto pred_cmd;
 		}
 		break;
 
@@ -2473,7 +2472,6 @@ static void __init srso_select_mitigation(void)
 			}
 		} else {
 			pr_err("WARNING: kernel not compiled with CPU_IBPB_ENTRY.\n");
-			goto pred_cmd;
 		}
 		break;
 
@@ -2485,7 +2483,6 @@ static void __init srso_select_mitigation(void)
 			}
 		} else {
 			pr_err("WARNING: kernel not compiled with CPU_SRSO.\n");
-			goto pred_cmd;
                 }
 		break;
 
