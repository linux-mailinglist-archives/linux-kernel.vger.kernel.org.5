Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B52877DB7D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 09:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242599AbjHPHzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 03:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242628AbjHPHzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 03:55:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D35326A8;
        Wed, 16 Aug 2023 00:55:22 -0700 (PDT)
Date:   Wed, 16 Aug 2023 07:55:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692172519;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KQPfE97g0UNnnM0Fm/x1VtePc4ovWpzKh2QMyhaW4n8=;
        b=U1etg2LFdhPl581oxF8quvl6HjXh7O6kHSJ5Chao3RJZyhTynKvIJ3iPu55BBTa1JOSckU
        GvGBTJcTeQ0oU2GQJNxdzZQaCqtzE7Vroi4yNjyVbVzD45rbzbNkEaS7vBeoGqFdHc2YuR
        P2t8p08K3KXSXCZcFHvF2PxouaJ9Si+vFAT/9cXZ+3KsGnY2qCvpBWsrSY4aHJr7d4HWyY
        9sjMBG95En3WRzsMCxv+6oKlMXz5HKWvCmZqSaafagwKmvk8khYa/tEtHIXvWZP+VqHLyd
        yCxd//Id6pIZnsAY2Y9GUqS7UpRHKNaHippVvHFQW2xwAKsf5OtOOJLXgctp6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692172519;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KQPfE97g0UNnnM0Fm/x1VtePc4ovWpzKh2QMyhaW4n8=;
        b=8lOTFVrN0FTeFRUFR9gajlIVsrvnIk55d3R9pkNlJeTjNd+1J9/nTJ0wu2BGNt2H8ch3DX
        SQNurTvqgV5T9sCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu: Fix __x86_return_thunk symbol type
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230814121148.571027074@infradead.org>
References: <20230814121148.571027074@infradead.org>
MIME-Version: 1.0
Message-ID: <169217251853.27769.4820136640557863860.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     77f67119004296a9b2503b377d610e08b08afc2a
Gitweb:        https://git.kernel.org/tip/77f67119004296a9b2503b377d610e08b08afc2a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 14 Aug 2023 13:44:27 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 16 Aug 2023 09:39:16 +02:00

x86/cpu: Fix __x86_return_thunk symbol type

Commit

  fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")

reimplemented __x86_return_thunk with a mix of SYM_FUNC_START and
SYM_CODE_END, this is not a sane combination.

Since nothing should ever actually 'CALL' this, make it consistently
CODE.

Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230814121148.571027074@infradead.org
---
 arch/x86/lib/retpoline.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 8db74d8..9427480 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -263,7 +263,9 @@ SYM_CODE_END(srso_safe_ret)
 SYM_FUNC_END(srso_untrain_ret)
 __EXPORT_THUNK(srso_untrain_ret)
 
-SYM_FUNC_START(__x86_return_thunk)
+SYM_CODE_START(__x86_return_thunk)
+	UNWIND_HINT_FUNC
+	ANNOTATE_NOENDBR
 	ALTERNATIVE_2 "jmp __ret", "call srso_safe_ret", X86_FEATURE_SRSO, \
 			"call srso_safe_ret_alias", X86_FEATURE_SRSO_ALIAS
 	int3
