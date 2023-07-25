Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A3E761A7F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjGYNtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjGYNtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:49:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0915C1FD2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 06:49:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF27A61731
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:48:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BA9C433C7;
        Tue, 25 Jul 2023 13:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690292939;
        bh=KR4z8QRNi4pU35qpz87mdf60pT5ISebScYvNacq6P6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vE7vE6PJe7HILM6w/tgBd1IsUX2Xx7oEqB4YQ8IKOIcVIOTIhmuACww1CQj9PNcMq
         RLjheYQNOGg1H3Yl+pt8m2rAI5PZf5kNaYJqkO3ASg39hbLfYuUzURuNqnWtS9ytBj
         5Lc0azinLfILioCypLzIoq4Uhb8bR7KUqT2fRlntK1JsD/DjXBP/FetJeESNZ/DrXP
         a8vObFOA/vJ/Cv/yTPblLMCwpNHHtIkjnVVHbT/Yz0zk9mXs/cSBHXCm6MniKCTt1d
         bXWWw0ZNhxwjr7pXYJos2EDdgVyyIDyPmZGX5rYCEJK9MQELoxIBkGtgYv+rE5w/PL
         WyPb1SztVEhyA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 5/5] [RESEND] x86: alternative: add __alt_reloc_selftest prototype
Date:   Tue, 25 Jul 2023 15:48:37 +0200
Message-Id: <20230725134837.1534228-6-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230725134837.1534228-1-arnd@kernel.org>
References: <20230725134837.1534228-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The newly introduced selftest function causes a warning when -Wmissing-prototypes
is enabled:

arch/x86/kernel/alternative.c:1461:32: error: no previous prototype for '__alt_reloc_selftest' [-Werror=missing-prototypes]

Since it's only used locally, add the prototype directly in front of it.

Fixes: 270a69c4485d ("x86/alternative: Support relocations in alternatives")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/kernel/alternative.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 2dcf3a06af090..934c23f24a3f8 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1531,6 +1531,7 @@ static noinline void __init int3_selftest(void)
 
 static __initdata int __alt_reloc_selftest_addr;
 
+extern void __init __alt_reloc_selftest(void *arg);
 __visible noinline void __init __alt_reloc_selftest(void *arg)
 {
 	WARN_ON(arg != &__alt_reloc_selftest_addr);
-- 
2.39.2

