Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADE778211D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 03:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjHUBTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 21:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbjHUBTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 21:19:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B51AB
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 18:19:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B918962625
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 01:19:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17D4C433D9;
        Mon, 21 Aug 2023 01:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692580773;
        bh=sQtvE37xPNADIY4OH0L1Ahw3y/Y1U2QJcyLmdprUEYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K7nvPO6QyQ4FnLPVo6C33788s2jlyehOdGQ6J5bjIlgOiRPV7F8CeVEr0gKiLAgsz
         gqICzXsnPAXNcI4gj1XgJ7qlLHlo2+IiLEETpaE1WzTa2dT1QW7iuY6F5vMy5mMcTp
         rwagEeKPpgA2jmVtKmvW5xOQmcrb+zfdLKN/towjobDAjqXkFIpu7ymmY20lVhH4Se
         SJxWoe3l+sHJYmnk3m+2O5GHmmUJY7N/0talOUh0o3ObGMQuvK9nVaOYye8BoAMzpX
         HQJb3FJ0HctEp5I6qN7NoKCw10XiV/akk7XUFApKBw424thH8PHsg5W2m/q9YLo4rc
         PK3vcoIUaHITA==
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
Subject: [PATCH 10/22] x86/srso: Print mitigation for retbleed IBPB case
Date:   Sun, 20 Aug 2023 18:19:07 -0700
Message-ID: <3836b2e27c9537d95ecce2a1e33e53315176ebc1.1692580085.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692580085.git.jpoimboe@kernel.org>
References: <cover.1692580085.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When overriding the requested mitigation with IBPB due to retbleed=ibpb,
print the actual mitigation.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kernel/cpu/bugs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index da480c089739..4e332707a343 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2427,7 +2427,7 @@ static void __init srso_select_mitigation(void)
 		if (has_microcode) {
 			pr_info("Retbleed IBPB mitigation enabled, using same for SRSO\n");
 			srso_mitigation = SRSO_MITIGATION_IBPB;
-			goto out;
+			goto out_print;
 		}
 	}
 
@@ -2487,7 +2487,8 @@ static void __init srso_select_mitigation(void)
 		break;
 	}
 
-	pr_info("%s%s\n", srso_strings[srso_mitigation], (has_microcode ? "" : ", no microcode"));
+out_print:
+	pr_info("%s%s\n", srso_strings[srso_mitigation], has_microcode ? "" : ", no microcode");
 
 out:
 	if (boot_cpu_has(X86_FEATURE_SBPB) && srso_mitigation == SRSO_MITIGATION_NONE)
-- 
2.41.0

