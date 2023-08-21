Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D888782114
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 03:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjHUBTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 21:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjHUBTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 21:19:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B60A1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 18:19:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 270FB6260A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 01:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11528C433C9;
        Mon, 21 Aug 2023 01:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692580769;
        bh=wseebdWJGAG73aEf4oxCFFQ8XYhFMGqIJFkJEq0d3CE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DFLMKfTyvmgfnWU15SexbYLc/zp8Rh6RZFrJdG+wh44jKu8nu78reOnXMBf7S6R6x
         DVDvl5Gz+FfL0AOjtsglr9Y41+A/T43NvyF8QSXAv8ohejPea4faN4Z5cRnIhBCLkU
         x0505HAbqP/g5Ix1OFB2gF+nDzA9nkatLKU2JfT/4/6YOVh5Z5LfwTd6kKVPZYPpNb
         4uCY30PcXeTd9OvxSsMLbvb1hkvyY99OKK/7Qqqvlcz440trlJslhgwtcpLZOjdLI0
         Gv5bm6F4zk5ri6h3dLHs9YS4PTNf58Szah9G497rkCJrxag92CPZkjMPa0hlBni9he
         i98CohRGFBX3g==
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
Subject: [PATCH 04/22] x86/srso: Fix SBPB enablement for spec_rstack_overflow=off
Date:   Sun, 20 Aug 2023 18:19:01 -0700
Message-ID: <23a121e309d5e880eb35c441d9bdfa642d6d59f4.1692580085.git.jpoimboe@kernel.org>
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

