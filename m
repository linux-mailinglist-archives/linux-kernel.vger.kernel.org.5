Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D420788078
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 09:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242702AbjHYHCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 03:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241222AbjHYHCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 03:02:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A6A199E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 00:02:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CD5E63D4D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:02:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C18C433C9;
        Fri, 25 Aug 2023 07:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692946922;
        bh=Rf7azYzBuF/8w9Rf8KpcVWynps2sflW/2Bm2YEq1sPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U/9kFJ+DR6ATAbQjeiuz+sfLe9LIhkf5E9HD9toKfDz1tD1l59MH1UqrqcCPqbrav
         jQBIScMZD4ullWb5m9vRBD1lz9+BSI9750tQDXVvlg69Atb1+qVIS8FwI7MhwFcZ0i
         O5JOREOGnpDlxQYAfkV6H8N2qtaErIy/9RWCXSI0cn/+gCkLSXlpdx3K6eDkNWJvkL
         8RTDCPDa9e9wWktwAfxicKLFpiYXED7b+hYj7lebCD5h6VFawsJzVGAny6SdOc1VWt
         cp8/nJJe9l5ta33spM/vTmkHwe5K5kvnBBIXx12tFPHsXERpdQ+lwW0k7soMZ1r/ck
         NnqFNC/XlR2NA==
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
Subject: [PATCH 01/23] x86/srso: Fix srso_show_state() side effect
Date:   Fri, 25 Aug 2023 00:01:32 -0700
Message-ID: <40b2e6af3a94d2c6eb9a3afaa63f34ee910a17d0.1692919072.git.jpoimboe@kernel.org>
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

Reading the 'spec_rstack_overflow' sysfs file can trigger an unnecessary
MSR write, and possibly even a (handled) exception if the microcode
hasn't been updated.

Avoid all that by just checking X86_FEATURE_IBPB_BRTYPE instead, which
gets set by srso_select_mitigation() if the updated microcode exists.

Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
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

