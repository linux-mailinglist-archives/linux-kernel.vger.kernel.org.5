Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130EB78807A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 09:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242730AbjHYHCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 03:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241784AbjHYHCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 03:02:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A2819AC
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 00:02:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7282064B51
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:02:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6B2C433CA;
        Fri, 25 Aug 2023 07:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692946925;
        bh=wseebdWJGAG73aEf4oxCFFQ8XYhFMGqIJFkJEq0d3CE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z2LrM29aakLBo+Q0t4HA//gIgNz0uDTlsDHprcNdBIcZmE1TlwdX7b1c+fBuDrjPH
         ExK+8I/Qt7Mlqlx/6uVxfQi4pPcllQP829Qmi1LFAf8f4vqai/djWmEu+aXa0gxe0R
         vcmHeBFUnn+S2/E0std2EkgoTyfxi6EiozmU0IhkYOjPmBDshjF4QTbeFSZW8xda5j
         6QkFC8CIg5kN3ioi+wnM4kJLpC582F4V6aq7Vl+WEdBbldQgYsXA3m6e0x3CCzsS9F
         IBD2pvW3xEgP/lpnlzMBFRGwFU0wjjSBYpB3gTXIiJ/aZjB8yJ1KH6D7hYbf+0hCbO
         NFgwowMSkLk+w==
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
Subject: [PATCH 06/23] x86/srso: Fix SBPB enablement for spec_rstack_overflow=off
Date:   Fri, 25 Aug 2023 00:01:37 -0700
Message-ID: <d025b558e451325db3a2c76f3daafe26a0928789.1692919072.git.jpoimboe@kernel.org>
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

If the user has requested no SRSO mitigation, other mitigations can use
the lighter-weight SBPB instead of IBPB.

Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kernel/cpu/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index b0ae985aa6a4..10499bcd4e39 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2433,7 +2433,7 @@ static void __init srso_select_mitigation(void)
 
 	switch (srso_cmd) {
 	case SRSO_CMD_OFF:
-		return;
+		goto pred_cmd;
 
 	case SRSO_CMD_MICROCODE:
 		if (has_microcode) {
-- 
2.41.0

