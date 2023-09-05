Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2F2792A94
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243464AbjIEQjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351014AbjIEFFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 01:05:20 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0309FCD2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 22:05:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5DCCBCE10AF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 05:05:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E37C433CB;
        Tue,  5 Sep 2023 05:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693890313;
        bh=roaZa6DJKVHyMmMO2D1vNZ9eeHp8DbQmu8mMGYbUivE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F0Xi9J+qx2jWa/RxizWxGlmFAaslhM+YtPPtc+kgHqLYxiAaCE3lEL3ZDunANpx9H
         acyn6se1NiWuosv5KRpZIT6cE1y8OlKhUG1CK+BbxXx0xsxb5h/jSr1vdVKRetoZ5X
         CrVP+mRCWjL4KUXGF6Gz0mgn0fCbHEl066Y6LHqSz1m5Xm1m41yK2+Mqi1iFf6zc+i
         KrM2JjykS8YPXCP7oIGrX3ui45Pe2s21APSNneWG+Eip6ZhkjhI+VnZ6VesFFPi93U
         vcp1XW03Hv4ikMTJ9ojl9ffm8/9H6TyZGazGv88a1LdRGXZZizHmsKYuYWM/KcX4RQ
         nJd6FJG/iH9Kw==
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
Subject: [PATCH v3 11/20] x86/srso: Improve i-cache locality for alias mitigation
Date:   Mon,  4 Sep 2023 22:04:55 -0700
Message-ID: <eadaf5530b46a7ae8b936522da45ae555d2b3393.1693889988.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693889988.git.jpoimboe@kernel.org>
References: <cover.1693889988.git.jpoimboe@kernel.org>
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

