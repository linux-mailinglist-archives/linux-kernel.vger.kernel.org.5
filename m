Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA2F7884CE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244571AbjHYKVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244410AbjHYKUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:20:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777E6199A;
        Fri, 25 Aug 2023 03:19:51 -0700 (PDT)
Date:   Fri, 25 Aug 2023 10:19:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692958771;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a5XOPphOM5Z7nCmar87MS+xzffdqij++O8ZPwFonnwQ=;
        b=1jpEpHvAva3JNjDyXzsY4/rZW57TCIoKKKL2mZXJ5FjJ2YzaivChUTf8lgDbYH1xNhYxij
        sOt9FDu/V9vNB8V8fPJGzBDn/vOiL2CxkM+4vGfvAV6YLKa6a7dDJTLSPYLW2XXl7aDaJ8
        OQDb4tjmGAGzNvBwIJSqPnAKfoo0EtJZar4R1FIRlqvYdTw/32XJLmFkObd2Hu8I9U2gss
        XhMzKgvcTpe92apTEOmhhw4DMZJLQ9HKSUQF+5/Yc6W3fC0dVT8ehehNpxhGaswZry/v0D
        QG7/+QhFEZ6jaA/QZiSY6kbeKNzg7eK1Mv4J+HLpGzP6oVHjEatRL728p5F3Yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692958771;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a5XOPphOM5Z7nCmar87MS+xzffdqij++O8ZPwFonnwQ=;
        b=jLQS65V0YHMnQMi7RK+lv67QHWt1DaudCUhepaY3f/k9K8BOjtHmBRJe1k0okA3S6Zgg7N
        yEnz1oZOYJc3VYBA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/srso: Improve i-cache locality for alias mitigation
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <4f975cf178ab641d3720362f244694408d85ecca.1692919072.git.jpoimboe@kernel.org>
References: <4f975cf178ab641d3720362f244694408d85ecca.1692919072.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <169295877114.27769.14263128082058843579.tip-bot2@tip-bot2>
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

Commit-ID:     3033c66da13ca363ad2f10dcd858c994e2f4bd00
Gitweb:        https://git.kernel.org/tip/3033c66da13ca363ad2f10dcd858c994e2f4bd00
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Fri, 25 Aug 2023 00:01:44 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 25 Aug 2023 11:22:00 +02:00

x86/srso: Improve i-cache locality for alias mitigation

Move srso_alias_return_thunk() to the same section as
srso_alias_safe_ret() so they can share a cache line.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/4f975cf178ab641d3720362f244694408d85ecca.1692919072.git.jpoimboe@kernel.org
---
 arch/x86/lib/retpoline.S | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index cd86aeb..9ab634f 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -177,15 +177,14 @@ SYM_START(srso_alias_safe_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	int3
 SYM_FUNC_END(srso_alias_safe_ret)
 
-	.section .text..__x86.return_thunk
-
-SYM_CODE_START(srso_alias_return_thunk)
+SYM_CODE_START_NOALIGN(srso_alias_return_thunk)
 	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
 	call srso_alias_safe_ret
 	ud2
 SYM_CODE_END(srso_alias_return_thunk)
 
+	.section .text..__x86.return_thunk
 /*
  * Some generic notes on the untraining sequences:
  *
