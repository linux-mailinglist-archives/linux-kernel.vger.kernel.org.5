Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A849676EEDF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237279AbjHCP7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbjHCP7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:59:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B46F11F;
        Thu,  3 Aug 2023 08:59:15 -0700 (PDT)
Date:   Thu, 03 Aug 2023 15:59:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691078354;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8roA7YqrbXNK1Oco/Q8gJvVYSq/5quxwD8UmRyfAEZY=;
        b=zZDQsMPUMcYDRlea/6iCvit1yAocz2P/2rmrybsgLLDyDPa0ld4EwEk40WS6UOxTqeA0Yt
        VYBhjZAcOyRjfdKmJJBNfHkOt2yA8L1bJkoRoGFZJDTNtsLZg4r3Br8pDgtimFCsFJ0bp6
        3tugYW2VtN14iUwEkTUwSopQjS0CxzPeDHdr6XWzHhOc95g0AhGkVmt9KFUQQdk3cfxfIF
        rQTsUv1wbG7Lpnb6aVU/1TzJLhsWNU/8/oDqJ0lLuUsMRJAi5iaOd0zxC5umnYQVGeov+t
        h85yR7XKV5pn9K/7U/v+iNJpG+d4BRqJn5V4TshZF3X/cxBA0nAoqGnTnz+uDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691078354;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8roA7YqrbXNK1Oco/Q8gJvVYSq/5quxwD8UmRyfAEZY=;
        b=hgiYzWSKGksy1zkLOipRTdnzbTVJpuyvcnZuObi6qy+g3ucJo3Ls6ptXva4SILcJhZYOPg
        FsppeITN4ObZNaCQ==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/alternative: Add a __alt_reloc_selftest() prototype
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230803082619.1369127-6-arnd@kernel.org>
References: <20230803082619.1369127-6-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <169107835389.28540.5714032870565906912.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     1a3e4b4da39bbf540a379e21869faa74bb19d16f
Gitweb:        https://git.kernel.org/tip/1a3e4b4da39bbf540a379e21869faa74bb19d16f
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Thu, 03 Aug 2023 10:26:17 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 03 Aug 2023 16:40:50 +02:00

x86/alternative: Add a __alt_reloc_selftest() prototype

The newly introduced selftest function causes a warning when -Wmissing-prototypes
is enabled:

  arch/x86/kernel/alternative.c:1461:32: error: no previous prototype for '__alt_reloc_selftest' [-Werror=missing-prototypes]

Since it's only used locally, add the prototype directly in front of it.

Fixes: 270a69c4485d ("x86/alternative: Support relocations in alternatives")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230803082619.1369127-6-arnd@kernel.org
---
 arch/x86/kernel/alternative.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 2dcf3a0..934c23f 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1531,6 +1531,7 @@ static noinline void __init int3_selftest(void)
 
 static __initdata int __alt_reloc_selftest_addr;
 
+extern void __init __alt_reloc_selftest(void *arg);
 __visible noinline void __init __alt_reloc_selftest(void *arg)
 {
 	WARN_ON(arg != &__alt_reloc_selftest_addr);
