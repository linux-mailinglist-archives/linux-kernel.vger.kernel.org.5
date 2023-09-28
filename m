Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E997B157C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjI1IBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjI1IBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:01:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560D492;
        Thu, 28 Sep 2023 01:01:01 -0700 (PDT)
Date:   Thu, 28 Sep 2023 08:00:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695888059;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y8b9q38myYZXgEZ8xuimBDP6RUNofjH0Ic81MrIcnGE=;
        b=JtEx1TwmMZq11ZYN8Lhi08+7TqyGq/JC92AyNl1TJZF5cDd0Trly4sBV9O3qlg4EdzDe0h
        BE+z8TxbaFpFz0ADQV2SlXmVjudJvblbhla6kKRGMepPEd2U/FrdqKc1sulXI2VFjjzG4d
        Euw+tQLDtmTGdsSXQhTEKseBExvYTXJoyW0ZVqE8ClO0YemjpNKRPE0+fuoXW3erY/J50e
        v6lGF9BcLl5JXvT9f02WAId0UqIpYiNaWEcSETFYfX++48zPmtlWgaE9sPjydiLg7CQa4S
        WO72lYtE6y9NbTXINZV4goBCwxiRaVzUXtKKK3KJ4Y5WxDfDp9Ua5oEvzbtuIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695888059;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y8b9q38myYZXgEZ8xuimBDP6RUNofjH0Ic81MrIcnGE=;
        b=bsIj1MwN1I9uphbtoUNGV/CTJTryqfFfS7mnk99gQsJV6VBRhSYWM25FBMf7hU/0xLnwKR
        vohvaSsIrUdaTpDg==
From:   "tip-bot2 for Pu Wen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/srso: Add SRSO mitigation for Hygon processors
Cc:     Pu Wen <puwen@hygon.cn>, Ingo Molnar <mingo@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, <stable@vger.kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <tencent_4A14812842F104E93AA722EC939483CEFF05@qq.com>
References: <tencent_4A14812842F104E93AA722EC939483CEFF05@qq.com>
MIME-Version: 1.0
Message-ID: <169588805808.27769.603081620807141672.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     a5ef7d68cea1344cf524f04981c2b3f80bedbb0d
Gitweb:        https://git.kernel.org/tip/a5ef7d68cea1344cf524f04981c2b3f80bedbb0d
Author:        Pu Wen <puwen@hygon.cn>
AuthorDate:    Thu, 28 Sep 2023 14:59:16 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 28 Sep 2023 09:57:07 +02:00

x86/srso: Add SRSO mitigation for Hygon processors

Add mitigation for the speculative return stack overflow vulnerability
which exists on Hygon processors too.

Signed-off-by: Pu Wen <puwen@hygon.cn>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/tencent_4A14812842F104E93AA722EC939483CEFF05@qq.com
---
 arch/x86/kernel/cpu/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 382d4e6..4e5ffc8 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1303,7 +1303,7 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_AMD(0x15, RETBLEED),
 	VULNBL_AMD(0x16, RETBLEED),
 	VULNBL_AMD(0x17, RETBLEED | SMT_RSB | SRSO),
-	VULNBL_HYGON(0x18, RETBLEED | SMT_RSB),
+	VULNBL_HYGON(0x18, RETBLEED | SMT_RSB | SRSO),
 	VULNBL_AMD(0x19, SRSO),
 	{}
 };
