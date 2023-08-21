Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4F578211A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 03:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjHUBTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 21:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbjHUBTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 21:19:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21741A3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 18:19:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E1996262F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 01:19:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF0EC433C7;
        Mon, 21 Aug 2023 01:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692580773;
        bh=EpkqZFYNSyZGV6nHO1Oxkdk31qPtS0UZWhnMgeIshmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UNSLVO+xGzJj5z8TBvOnbkzLRAMDktwW0uiqRJk9thQ66Jp94Rxj+8+sixXrk91Sd
         hOSDngcwsz2qZqilN/1LVTOb/8pAQrde6MUx4/VCg/dhbnxGNwpmQuxp2I96PsD0sH
         tkWdQHEzYrz0ksUmegxHV9/xpT2KcpKB1FrwAe1HmlwiFEBmk0DM0Ms0oEHFcEq3NB
         2vHxly6VIaIou6QKCkfldr4VmbFRtRW3bNGFINpUw6dUmZSO0n8tS0wcGrhvvVbRzf
         Y0nh7RlNCzqnqhaRLhwYSGEPrVcgrC2c/TuvzhSVPo3HSsgq7e36VskWuPLASDQ3X5
         bWRUhXtHbG6EA==
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
Subject: [PATCH 11/22] x86/srso: Slight simplification
Date:   Sun, 20 Aug 2023 18:19:08 -0700
Message-ID: <18b18b8709b72625b60156545a705b052646667c.1692580085.git.jpoimboe@kernel.org>
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

Simplify the code flow a bit by moving the retbleed IBPB check into the
existing 'has_microcode' block.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kernel/cpu/bugs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 4e332707a343..b27aeb86ed7a 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2421,10 +2421,8 @@ static void __init srso_select_mitigation(void)
 			setup_force_cpu_cap(X86_FEATURE_SRSO_NO);
 			goto out;
 		}
-	}
 
-	if (retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
-		if (has_microcode) {
+		if (retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
 			pr_info("Retbleed IBPB mitigation enabled, using same for SRSO\n");
 			srso_mitigation = SRSO_MITIGATION_IBPB;
 			goto out_print;
-- 
2.41.0

