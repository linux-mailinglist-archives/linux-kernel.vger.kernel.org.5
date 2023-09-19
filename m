Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910EB7A5ED2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjISJyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjISJxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:53:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EB9183;
        Tue, 19 Sep 2023 02:53:18 -0700 (PDT)
Date:   Tue, 19 Sep 2023 09:53:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695117195;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Is+qu8RbO+Wd+22FzAaMcS21tow6QiAd21FvhIZTVU=;
        b=QDN4WGQ/csLTxVOXcnrirR+1wBkZZzy42wfCunhWSVIKVJFZo5IXMsotB/BOTXa6w5RVu/
        8TReb3brbrZfXAZtiqw0MOMtPJ9VGfhJ7sAfG+FCZvqDjfFUyQcELPypKkzmBKxZd8+URu
        t5D2hMqF4GGLChzrhqhl/uhPmLfqcQfN8iVFEFp3sLWuzg5CuTbRkySRegdz0Irke/ypBg
        VTfsvyZ2a0ilywF7mLRmvNwv8MXu9zLRo9pDOP0xb+vwVQ5bFNvAe/sbv+D6wpKhmcQJSd
        DKSYnp9P8HfQ+eQTMqhHwe3aEVHQwE+o6vZEEnddfSCjYfa5WJ8R/zFiVqyjoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695117195;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Is+qu8RbO+Wd+22FzAaMcS21tow6QiAd21FvhIZTVU=;
        b=ePwrhX/C48WtwzI3N02ljbx9ULLz4GEe6LgxVRB/LjZJJAtAoFCeSO7erf9pnI+BnCrxm1
        5bfneYYb3tYwR/Cg==
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
Message-ID: <169511719507.27769.11066410614523740718.tip-bot2@tip-bot2>
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

Commit-ID:     8d1af58569b6b8541c3d6574ba6ef36016a07edb
Gitweb:        https://git.kernel.org/tip/8d1af58569b6b8541c3d6574ba6ef36016a07edb
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 04 Sep 2023 22:04:50 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 19 Sep 2023 11:42:47 +02:00

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
 
