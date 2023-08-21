Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14949782112
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 03:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjHUBTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 21:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjHUBTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 21:19:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7396A0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 18:19:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E4C8625FD
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 01:19:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429C3C433C7;
        Mon, 21 Aug 2023 01:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692580767;
        bh=tZ4Q8jjAOGCCPRfVNc3rr+aMQROmytBONCwejjFqKCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oGTzd7iRf/KPOJw0aXefKaYcg8H6TV5xkkITQZwWCdz/IBieIjDZ3b9OcfkhMjGtZ
         V2abQsFrOYW+v8OYpnMkELoen6RT6Y/ZVwuRUqB6pfgrBvahjo7bnv/GlmDzX35LeG
         TJo55qbD7gekM5AiVxQqShYQQQ9KAUb+0EvgauRUThuSWDf/+cpsbAKu51VGOX131f
         2Vs09GZFnyadGVT/64GC3mY+Kqazu3ZiaYuiLQGwYUbofZ4REnhILiv4C2aBGL9CUx
         K9o/Swr+FjhmzO8+M6oL8VRF0i0YO2r6+IgjryOvdvraP1zIMV9GsBj+Hs146t2EAT
         ppu/1Da+Mflaw==
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
Subject: [PATCH 01/22] x86/srso: Fix srso_show_state() side effect
Date:   Sun, 20 Aug 2023 18:18:58 -0700
Message-ID: <fc64c4e5749d10b398c86b60902d6f9394eb5012.1692580085.git.jpoimboe@kernel.org>
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

Reading the 'spec_rstack_overflow' sysfs file can trigger an unnecessary
MSR write, and possibly even a (handled) exception if the microcode
hasn't been updated.

Avoid all that by just checking X86_FEATURE_IBPB_BRTYPE instead, which
gets set by srso_select_mitigation() if the updated microcode exists.

Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kernel/cpu/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index f081d26616ac..bdd3e296f72b 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2717,7 +2717,7 @@ static ssize_t srso_show_state(char *buf)
 
 	return sysfs_emit(buf, "%s%s\n",
 			  srso_strings[srso_mitigation],
-			  (cpu_has_ibpb_brtype_microcode() ? "" : ", no microcode"));
+			  boot_cpu_has(X86_FEATURE_IBPB_BRTYPE) ? "" : ", no microcode");
 }
 
 static ssize_t gds_show_state(char *buf)
-- 
2.41.0

