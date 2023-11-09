Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CDD7E6E66
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbjKIQPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234617AbjKIQPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:15:06 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 632583588;
        Thu,  9 Nov 2023 08:15:03 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1112)
        id 909A820B74C0; Thu,  9 Nov 2023 08:15:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 909A820B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1699546502;
        bh=TODuuixcRLtErqip8qybtbJ+d9Czo7e1uLIBPHVy8TQ=;
        h=From:To:Cc:Subject:Date:From;
        b=EbH0kTsKFErwQ4gtiA3IOIQQBjpes92qMHSU1zZjXoJrLQs45sUfgAoQm8FsVgh31
         xzpgR0xXT54AtG9TZrq49fL9GmkSzfFCEi4x0UxNxprEzSpmWgXxlb4WK2lY4ORMDW
         UH54N3QvpvKuLxTaFSyLI4FohPfV/TRUVoFUAXPQ=
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        Michael Kelley <mhklinux@outlook.com>,
        Dexuan Cui <decui@microsoft.com>
Cc:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        linux-hyperv@vger.kernel.org, stefan.bader@canonical.com,
        tim.gardner@canonical.com, roxana.nicolescu@canonical.com,
        cascardo@canonical.com, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, kirill.shutemov@linux.intel.com,
        sashal@kernel.org
Subject: [PATCH] x86/mm: Check cc_vendor when printing memory encryption info
Date:   Thu,  9 Nov 2023 08:14:49 -0800
Message-Id: <1699546489-4606-1-git-send-email-jpiotrowski@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check the value of cc_vendor to see if we're in an Intel TDX protected VM
instead of checking for the TDX_GUEST CPU feature. The rest of the function
already uses the abstractions available in cc_platform.h to check for
confidential computing features. For Intel, cc_vendor is set from
tdx_early_init() or hv_vtom_init(), so the new code correctly handles both
cases. The previous check relied on the Linux-controlled TDX_GUEST CPU feature
which is only set in tdx_early_init().

Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
---
 arch/x86/mm/mem_encrypt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index c290c55b632b..d3bd39aad8b6 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -44,7 +44,7 @@ static void print_mem_encrypt_feature_info(void)
 {
 	pr_info("Memory Encryption Features active:");
 
-	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
+	if (cc_vendor == CC_VENDOR_INTEL) {
 		pr_cont(" Intel TDX\n");
 		return;
 	}
-- 
2.39.2

