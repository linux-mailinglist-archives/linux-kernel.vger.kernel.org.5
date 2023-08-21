Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D46782125
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 03:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjHUBUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 21:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbjHUBTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 21:19:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDC2CF
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 18:19:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1753A6260C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 01:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16867C433C9;
        Mon, 21 Aug 2023 01:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692580778;
        bh=jFyALynF3no3jKDUUWb3xTWvMt/cZ/Q1OkgRNreEts4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gjPPfc3XNmsWXQoOsImxTwxJ0V9KL6VY2R1rcLaKSZOwhtsVSlHY7V3W8pFcTHEqT
         fMNH2oTZGJNLJeqwgwtPmGaRRedLI2HS6p0hWDLEqqlpc1Qjn7iUFI4RNhFZEeCDvv
         HrdimRMey1UBdvSAHdgbpr+9rDYI5Bt6hiZDv60hzIjDWIc2MqRaNuxXuiiccGZq50
         9iEYGEDzT7+2P5Xek1nPvOvZFdNBPnun14M4Hv7tym1Ae6tqmD9mjqbmD48u1W9YMi
         pz5D8VizwoyapGSZYBcOhQ/sveapLkb88so7us2k3aJr0S5MRqpUcoj1Bn1EPjvuyc
         4YEYlXDcbt9Gw==
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
Subject: [PATCH 19/22] x86/srso: Improve i-cache locality for alias mitigation
Date:   Sun, 20 Aug 2023 18:19:16 -0700
Message-ID: <61b4147837d1e0273d094f3d11384fcdcf9b637f.1692580085.git.jpoimboe@kernel.org>
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

Move srso_alias_return_thunk() to the same section as
srso_alias_safe_ret() so they can share a cache line.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/lib/retpoline.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index af3c1f0e4fb8..415521dbe15e 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -166,14 +166,14 @@ SYM_CODE_START_NOALIGN(srso_alias_safe_ret)
 	ret
 	int3
 SYM_FUNC_END(srso_alias_safe_ret)
-	.popsection
 
-SYM_CODE_START(srso_alias_return_thunk)
+SYM_CODE_START_NOALIGN(srso_alias_return_thunk)
 	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
 	call srso_alias_safe_ret
 	ud2
 SYM_CODE_END(srso_alias_return_thunk)
+	.popsection
 
 /*
  * SRSO untraining sequence for Zen1/2, similar to retbleed_untrain_ret()
-- 
2.41.0

