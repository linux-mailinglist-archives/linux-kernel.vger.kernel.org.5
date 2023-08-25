Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5083178807E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 09:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242831AbjHYHCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 03:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242127AbjHYHCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 03:02:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6884BD3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 00:02:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 074C963D4D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:02:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D265C433CB;
        Fri, 25 Aug 2023 07:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692946926;
        bh=uU+4b7Nqd1JBSc45+s2BfgDjWrwt8fgPRmfD9p0UXWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j0taPDbXJy/3okWJZKyrzGQj3wFlK/9qMmcA/iCCYVFA04h3KLGvhdj7B+bwNENme
         IuwKTn9PdAZqbMjK+i8qq0iTYer38mvCp4OmPWcvZvcmV++fQYNrG1h7kkX28L8Og5
         yccmo+SBbz3IblZu8GIPvhNfofwFF2yDK9q8l3Laq/gTSQI6s6MM7Deou6fykK72Pf
         ZA+VUGR8/6m5UjvHZVndHc+3456QlzsHbISHKdE0YLZtK4E9gj3w/1T7zWLqarbUs9
         h6S6n69uziyhV+lGAFGXLJyPce91KYMWOLW7aI+n1NSkF30Ub16sQ2zonUUiQTkwvU
         o+Zc2qZKeYJMA==
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
Subject: [PATCH 07/23] x86/srso: Fix SBPB enablement for (possible) future fixed HW
Date:   Fri, 25 Aug 2023 00:01:38 -0700
Message-ID: <d04e617b39eefdb0221857d53858579acdc3f580.1692919072.git.jpoimboe@kernel.org>
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

Make the SBPB check more robust against the (possible) case where future
HW has SRSO fixed but doesn't have the SRSO_NO bit set.

Fixes: 1b5277c0ea0b ("x86/srso: Add SRSO_NO support")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kernel/cpu/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 10499bcd4e39..2859a54660a2 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2496,7 +2496,7 @@ static void __init srso_select_mitigation(void)
 	pr_info("%s%s\n", srso_strings[srso_mitigation], (has_microcode ? "" : ", no microcode"));
 
 pred_cmd:
-	if ((boot_cpu_has(X86_FEATURE_SRSO_NO) || srso_cmd == SRSO_CMD_OFF) &&
+	if ((!boot_cpu_has_bug(X86_BUG_SRSO) || srso_cmd == SRSO_CMD_OFF) &&
 	     boot_cpu_has(X86_FEATURE_SBPB))
 		x86_pred_cmd = PRED_CMD_SBPB;
 }
-- 
2.41.0

