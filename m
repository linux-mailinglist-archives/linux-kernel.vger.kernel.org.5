Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE793782121
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 03:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbjHUBTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 21:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbjHUBTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 21:19:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17B99C
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 18:19:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8182B6263B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 01:19:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD81C433C9;
        Mon, 21 Aug 2023 01:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692580774;
        bh=+kH/vW1/0PRsTr3iUIGO8h94X0Xqn63vyQGLo/1oKrk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MaW4jMTE1TxgyOxgMgG/ogBAE0BrWr62wcLtNyv7r9dPJQ7Xa7riO00u1LJ+g/Vio
         ycBm0dQ657gT18X/tBSbqcdWWmIUrXSsZTTYDeHDxgkdAQ8WqiiM+djSb9sc78LA8E
         +xhxVIuZ2NDO3YFlVFDV16ZJKtVrJunznSkTEneQmN++NSvU6SLKhb3h+MLwGff8/2
         PHK6F+0kMSJsIJwRGKFQpZxcJAv8fPR8ahHdx8THq+NOL5TR0wGSYMmYbSD5pThRph
         n8S0FIYNQaM1v6FaME8qKcpmIsLhIOdpZqmVoc6yNmvbTie7LZbvM1vga9bY/rKf/Y
         MUmMpgZNKT84Q==
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
Subject: [PATCH 12/22] x86/srso: Remove redundant X86_FEATURE_ENTRY_IBPB check
Date:   Sun, 20 Aug 2023 18:19:09 -0700
Message-ID: <bb018289827a8709d11b22f28345690753597fa5.1692580085.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692580085.git.jpoimboe@kernel.org>
References: <cover.1692580085.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index b27aeb86ed7a..aeddd5ce9f34 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2475,7 +2475,7 @@ static void __init srso_select_mitigation(void)
 
 	case SRSO_CMD_IBPB_ON_VMEXIT:
 		if (IS_ENABLED(CONFIG_CPU_SRSO)) {
-			if (!boot_cpu_has(X86_FEATURE_ENTRY_IBPB) && has_microcode) {
+			if (has_microcode) {
 				setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
 				srso_mitigation = SRSO_MITIGATION_IBPB_ON_VMEXIT;
 			}
-- 
2.41.0

