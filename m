Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2E9792534
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbjIEQBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350935AbjIEFFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 01:05:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB3BCCF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 22:05:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F13A56135B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 05:05:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF117C433C9;
        Tue,  5 Sep 2023 05:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693890309;
        bh=wseebdWJGAG73aEf4oxCFFQ8XYhFMGqIJFkJEq0d3CE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pwwmtiYoC1irDfZTJ9mINZvsHSB7Ro72ninK4N1SlBi++3vBV6BEJJEe267PHQR46
         DG2+DwJUNBq9aB56sVDKxbGTjeZMC2JPdlbmc49SuV3jMy4cir0UrodE9jg0up6jlj
         2smFHgOk1J4NBCXLYDky8HiPrX7mbelGkOPrUjAOgYF+lzFa+NgKhDR80OYm0ecQq8
         +I+NAU15nMATFj+9aWTjx799g9txmgJB09RsD/tYF6QbCFhOMb1lN8ecGVrKcKGcON
         t8fKR2z+Tme5xHXl35f1EKq5aVVFQbMaiHncbNhwF5lrC+56LPtrYDUgqHJBYk2/Fo
         kGyG1Occ/5ggA==
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
Subject: [PATCH v3 04/20] x86/srso: Fix SBPB enablement for spec_rstack_overflow=off
Date:   Mon,  4 Sep 2023 22:04:48 -0700
Message-ID: <b20820c3cfd1003171135ec8d762a0b957348497.1693889988.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693889988.git.jpoimboe@kernel.org>
References: <cover.1693889988.git.jpoimboe@kernel.org>
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

