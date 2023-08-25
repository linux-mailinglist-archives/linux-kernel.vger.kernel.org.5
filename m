Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5266D7884BE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244446AbjHYKUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244401AbjHYKUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:20:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A41173F;
        Fri, 25 Aug 2023 03:19:51 -0700 (PDT)
Date:   Fri, 25 Aug 2023 10:19:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692958769;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UEIsgfutamma5TlnuNSAesz9wKsHpB1lGZiQMFApMdU=;
        b=OSpmoUFsr8LjDR64XwPAqamyJcc0X8df3xHY2DuRP9TpZsFroxFUEvvXl3iTcP25AHe7wk
        /FX8RTsA+PILAh1RrQg6gfx5XQIdERWsCZtf6x4XStSZgR89u8fSwR+52BvlzQvbKKD68C
        AB33zv8Vv6Upej5fqTk/K7LlZScXkFRyRAQazMsWmjuvfHTZHRs2nGC/11Tgq1VqRg0da3
        Yowsg4vZQDXcfqySJYs358JGKqlKXKvsvy4eMnaOw49D3XCTAK7GQnMq4dLP1XR7oiUyUz
        laN9p5ouR+XT3Qw9lpFSSz37aIQU9oy5QpMYZGxu/vwfc3pAWCzdwnKJY3uuNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692958769;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UEIsgfutamma5TlnuNSAesz9wKsHpB1lGZiQMFApMdU=;
        b=e2OBv/mZd+U0BMWE5bGzQqOJD5Ysp+x/XsaJ6GNZZGTBlyrZ+P2Mfl0F2fV2TSeLlCR4PY
        LbTlGBfPn5OqhUCg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/srso: Remove redundant X86_FEATURE_ENTRY_IBPB check
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <9b671422643939792afe05c625e93ef40d9b57b5.1692919072.git.jpoimboe@kernel.org>
References: <9b671422643939792afe05c625e93ef40d9b57b5.1692919072.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <169295876899.27769.15911339219433317921.tip-bot2@tip-bot2>
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

Commit-ID:     071fcf6c28adcee293addd7258097949b8b54819
Gitweb:        https://git.kernel.org/tip/071fcf6c28adcee293addd7258097949b8b54819
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Fri, 25 Aug 2023 00:01:49 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 25 Aug 2023 11:22:01 +02:00

x86/srso: Remove redundant X86_FEATURE_ENTRY_IBPB check

The X86_FEATURE_ENTRY_IBPB check is redundant here due to the above
RETBLEED_MITIGATION_IBPB check.  RETBLEED_MITIGATION_IBPB already
implies X86_FEATURE_ENTRY_IBPB.  So if we got here and 'has_microcode'
is true, it means X86_FEATURE_ENTRY_IBPB is not set.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/9b671422643939792afe05c625e93ef40d9b57b5.1692919072.git.jpoimboe@kernel.org
---
 arch/x86/kernel/cpu/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index b086fd4..563f09b 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2494,7 +2494,7 @@ static void __init srso_select_mitigation(void)
 
 	case SRSO_CMD_IBPB_ON_VMEXIT:
 		if (IS_ENABLED(CONFIG_CPU_SRSO)) {
-			if (!boot_cpu_has(X86_FEATURE_ENTRY_IBPB) && has_microcode) {
+			if (has_microcode) {
 				setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
 				srso_mitigation = SRSO_MITIGATION_IBPB_ON_VMEXIT;
 			}
