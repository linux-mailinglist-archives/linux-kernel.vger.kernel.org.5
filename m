Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAC478808D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 09:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243128AbjHYHDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 03:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242712AbjHYHCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 03:02:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DE0199E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 00:02:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65BF0666F8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:02:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A2BC433CB;
        Fri, 25 Aug 2023 07:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692946932;
        bh=1jMNU8kkyCvXNPKUDKEGQ9C2EpveOGmoBxllKHP+AdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u8L+xkJxVgmcms5VpI5x2bGJIR/9Pud7uTbxIsKECyP0ngHUJrdxhU+b5Onngva5K
         d1lUbvKlzn3JY8vDAj/bOI1uj+vygB5zmlVcb1rduJdqVILoGU1v6yo/x/JfXK4ojo
         lyzU4gQCEGas+Wuk5fuoHKFVlqBmu3kSYSK0D0xt/yVe7rCxZTqUU4SwXa6sI55LsB
         4b2RBqB96fffqWCEwqBlbGqDZUAQnxaEQ1vjDE9Dv2MShDSBR4k9yrOBGxPkke0OeV
         C7wAaYavfvMoFJOoYmW1rQLHPFQAzCts6lJUcYJfcHZBydPkOj2260vgyjh2sDReOH
         r4iaolVVRTHSA==
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
Subject: [PATCH 18/23] x86/srso: Remove redundant X86_FEATURE_ENTRY_IBPB check
Date:   Fri, 25 Aug 2023 00:01:49 -0700
Message-ID: <9b671422643939792afe05c625e93ef40d9b57b5.1692919072.git.jpoimboe@kernel.org>
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

The X86_FEATURE_ENTRY_IBPB check is redundant here due to the above
RETBLEED_MITIGATION_IBPB check.  RETBLEED_MITIGATION_IBPB already
implies X86_FEATURE_ENTRY_IBPB.  So if we got here and 'has_microcode'
is true, it means X86_FEATURE_ENTRY_IBPB is not set.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kernel/cpu/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index b086fd46fa1b..563f09ba6446 100644
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
-- 
2.41.0

