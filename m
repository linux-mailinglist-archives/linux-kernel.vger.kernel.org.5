Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF65788084
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 09:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243018AbjHYHCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 03:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242559AbjHYHCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 03:02:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADCFE6B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 00:02:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D06B66658
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:02:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1FEC433C7;
        Fri, 25 Aug 2023 07:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692946929;
        bh=roaZa6DJKVHyMmMO2D1vNZ9eeHp8DbQmu8mMGYbUivE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fQSeisApm+/NTyGDFfw0K/xsyeWWEA1z/wN09Pm6UMQ8eZl0o25/nwqpRPXpgSnbl
         zrPdrqyVPGxxYX72AvCVY1VQFHovnwDhHE7vU5reAqi8ZphVghCUQIdN5mn1IZY9Z4
         IRVDW+WbunxZBBEOzVyzpwIldC0SDZ3Kv0h3jsUI6CIcuy92diG/KlsBzia/Bpw3/O
         bmoHj9poMa8KtLNGH4vjDAcD8fNzzX27u/Ix6KlhadGyjMpJjVI5CY3S3I8nXjhC4h
         glwoVCCAIalqq4lhoQApGbbjsFemfJ1FiA4GgMuS8mXdF/1Bhej0OcTHaJ2g2KiTzG
         YtFmKgu/la65A==
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
Subject: [PATCH 13/23] x86/srso: Improve i-cache locality for alias mitigation
Date:   Fri, 25 Aug 2023 00:01:44 -0700
Message-ID: <4f975cf178ab641d3720362f244694408d85ecca.1692919072.git.jpoimboe@kernel.org>
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

Move srso_alias_return_thunk() to the same section as
srso_alias_safe_ret() so they can share a cache line.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/lib/retpoline.S | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index cd86aeb5fdd3..9ab634f0b5d2 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -177,15 +177,14 @@ SYM_START(srso_alias_safe_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	int3
 SYM_FUNC_END(srso_alias_safe_ret)
 
-	.section .text..__x86.return_thunk
-
-SYM_CODE_START(srso_alias_return_thunk)
+SYM_CODE_START_NOALIGN(srso_alias_return_thunk)
 	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
 	call srso_alias_safe_ret
 	ud2
 SYM_CODE_END(srso_alias_return_thunk)
 
+	.section .text..__x86.return_thunk
 /*
  * Some generic notes on the untraining sequences:
  *
-- 
2.41.0

