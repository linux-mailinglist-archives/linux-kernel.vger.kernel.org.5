Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E288F782118
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 03:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjHUBTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 21:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjHUBTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 21:19:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F78A4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 18:19:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D27562615
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 01:19:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C6BC433CA;
        Mon, 21 Aug 2023 01:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692580772;
        bh=NTl9fdPPfPDx8+1IGrlnxPkd/+/wfToU8TRoq+9rVe8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m99+o8lR6uGYFUrOy2rSvW7qagnSCow80eFcsbu5nVPZ7aLr1uZIZ4ywNY9BfB4gl
         B9qkfLjMb6OutWgdviC/DMtHPZyvEmLC5MVOUPYgvdaJZWx2e9dWPjJ2eeDCHPMMAU
         LAWjELmOXaoWSZuCZ92HIIlhb7qiyBpo+KiVjhVGzVtpT1b/v8EvaGB/kzPSei/NKA
         h1zmB9T9c/9k46ruYuu3oy1+LzyEm7QDS6ijFT0U6jdFylDk1V28ve3INlZIvQngjA
         E5yEcWtlGd7c74NaWtG9XhGhRsGutRZyAbXzNJkRfDc0AxSndPXKH20jAO4LiRqRZA
         hKT8QRUQQQd5w==
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
Subject: [PATCH 08/22] x86/srso: Downgrade retbleed IBPB warning to informational message
Date:   Sun, 20 Aug 2023 18:19:05 -0700
Message-ID: <49b321ad997bce6068c694a6cd0ecdcd5cd2a1e4.1692580085.git.jpoimboe@kernel.org>
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

This warning is nothing to get excited over.  Downgrade to pr_info().

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kernel/cpu/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index cda4b5e6a362..e59e09babf8f 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2425,7 +2425,7 @@ static void __init srso_select_mitigation(void)
 
 	if (retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
 		if (has_microcode) {
-			pr_err("Retbleed IBPB mitigation enabled, using same for SRSO\n");
+			pr_info("Retbleed IBPB mitigation enabled, using same for SRSO\n");
 			srso_mitigation = SRSO_MITIGATION_IBPB;
 			goto pred_cmd;
 		}
-- 
2.41.0

