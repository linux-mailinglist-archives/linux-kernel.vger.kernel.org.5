Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C437AC1EF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 14:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjIWMVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 08:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjIWMU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 08:20:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EE01B3;
        Sat, 23 Sep 2023 05:20:14 -0700 (PDT)
Date:   Sat, 23 Sep 2023 12:20:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695471613;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7WhUjWOTYtXHh/5KhjL7Q0CvVvEnG8Xg2ak54ziNto8=;
        b=Tr8u3MAM+IBgtbsOF014ujH90WT/L5x01937BGxmkOQTkkA0QHgE7x9byEUmy29SBwtYZ3
        wUWWSoNSv0VKJhPFU1wTH7tBWPg5Em5RPzZn5iagxH2yKjlrcUMa9tM1bekzbqMasC3WIO
        FnbBGe1/HmnBEHiSr3s5yJJHqQtpqvOhU8LaroacFNcVVLz6OmW6TVlMr9UQRn1SsPWHb1
        JJGytv7bw5drOXz5SRL8+2GOY04q8LIu3Vohb4uqNUJ/CW7QrJBUAPBxGJ5kYS55Rn4jMR
        rMK4Mxe8jSCC9uFtg1e4cZDgbMJDOJ9fBHZdkbczhcTcRQExTXCDPkVRKtTaAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695471613;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7WhUjWOTYtXHh/5KhjL7Q0CvVvEnG8Xg2ak54ziNto8=;
        b=udgNR4OcwMV9Vi8yceYxkgr4FRJAJttzgg4jA8LSKox4DCJE9eujGS26ORa97rqTZAbscM
        maUT3OVROUe3MbDA==
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
In-Reply-To: <7e7a12ea9d85a9f76ca16a3efb71f262dee46ab1.1693889988.git.jpoimboe@kernel.org>
References: <7e7a12ea9d85a9f76ca16a3efb71f262dee46ab1.1693889988.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <169547161243.27769.14468505492181595370.tip-bot2@tip-bot2>
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

Commit-ID:     f9548addc12d02ee731ccd4a91ae55657e819d7d
Gitweb:        https://git.kernel.org/tip/f9548addc12d02ee731ccd4a91ae55657e819d7d
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 04 Sep 2023 22:04:50 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 23 Sep 2023 14:13:02 +02:00

x86/srso: Print actual mitigation if requested mitigation isn't possible

If the kernel wasn't compiled to support the requested option, print the
actual option that ends up getting used.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/7e7a12ea9d85a9f76ca16a3efb71f262dee46ab1.1693889988.git.jpoimboe@kernel.org
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
 
