Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D1678808E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 09:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243303AbjHYHDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 03:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241222AbjHYHCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 03:02:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D462D3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 00:02:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFE1366687
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:02:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65C2C433CA;
        Fri, 25 Aug 2023 07:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692946932;
        bh=hWAFzzHi0f8GJ8d/XqWNtBifyZV9et10joWelVvsYPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dkPreIy3HY7ZSyLURg3Hu+jdnXzNcHOwtX7KxbGMxh1fH1cpPzQk/YB9J81BRBAF0
         Tkixd119q+Ce+2h2RG6thAPTPNF9zPGG7RlZ3R3Q7BzGqJf/DNaxnxvU7xzny8cvIg
         YXkiMteTBHGdKuvqX5R52g8Dg0yZmANfmXfVJJxuhkSI+KZ7UnbGx8XWeAkNYN/OKz
         EqipkXjYuva1+3XkEPmF7danzSAkj/J8KqrA0idFUm2T843BYJhsVFECfLnlkyfgjc
         tiVZfHBw4QwF5+Poj1jjzpp3Jz0oijmZfdXbvvBP/gdVc1hrH/1aXdaUd6mck3auZx
         WE/rYZOHxn/Sw==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 17/23] x86/srso: Move retbleed IBPB check into existing 'has_microcode' code block
Date:   Fri, 25 Aug 2023 00:01:48 -0700
Message-ID: <c64b84b6df4e82423abe2441a1a088a8c7f1ae14.1692919072.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692919072.git.jpoimboe@kernel.org>
References: <cover.1692919072.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the code flow a bit by moving the retbleed IBPB check into the
existing 'has_microcode' block.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kernel/cpu/bugs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 06216159d7fc..b086fd46fa1b 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2430,10 +2430,8 @@ static void __init srso_select_mitigation(void)
 			setup_force_cpu_cap(X86_FEATURE_SRSO_NO);
 			return;
 		}
-	}
 
-	if (retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
-		if (has_microcode) {
+		if (retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
 			srso_mitigation = SRSO_MITIGATION_IBPB;
 			goto out;
 		}
-- 
2.41.0

