Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1EE77CADD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 11:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbjHOJ6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 05:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236318AbjHOJ5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:57:40 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A530798
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 02:57:38 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8DEE740E0196;
        Tue, 15 Aug 2023 09:57:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yXjmY7c9nlce; Tue, 15 Aug 2023 09:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1692093453; bh=sWzihh14qpIYZO0AJpRvQPWjHG8asEBhr7jBthLgdlw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hf5wJVnPJoB9bbD6jD9VX0RpUaLbFBmpmOv2AoynQuvqRO380e58M3G7C8EgTMt/R
         nauriXY4cOxzoGUZOCHK26sOQKoYO8cYUwjR9RvyZdp9DF9+QSYFdfCDtCyCM27K5n
         olg6PdXeD5dG08yM5Ye7Td0+Dzh3USh5noBxJDd5CCCkVQBIn92opiTRkZxi6edyQ0
         /QQQi2RIZxaExSdK9CFL4JZWvC/Bs7pJIii5w/SOUfE9KIxRIqH+ZNGqMaiOLE5NfO
         z1dWd7qs51pXVADWguVkLwUlSkyScDkqaNEvH1P45Sp3/sgYsr3VFpJNdYKt6adsBx
         PAbsqLDKxGOpkQCGT8yMca86xSIiiFvWZZ2L770G6YIqP+bhw0XwD4hzdVmRlSfdiX
         vUg9UUfUFCTcyNT848JD7A+jXKI2q1RIvbFQOSCYzz/lhOQJuVw8Xb3pgn9WElxsZC
         8Z9wsbl5gq/OZFRIR6kccXEB4sCoth9WOB/aTsE5ohHBst+Cyo2Ycpno+7fB/13s9s
         x0j8yZoykohr6hEIOAQIBod9Bwo6E4Lc9RVK4T31fciAxXZTcCQDArfLH46ME93+YX
         R1lDdfT/gpk+4JuLgvwogeOjIxiuJuKluo4XjKcmE5i5e/rtzRvCs74Z5O1mZSlYd6
         MjNuxo7cfnccvod6HQ349C9o=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4DEED40E0194;
        Tue, 15 Aug 2023 09:57:28 +0000 (UTC)
Date:   Tue, 15 Aug 2023 11:57:24 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Nikolay Borisov <nik.borisov@suse.com>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/srso: Correct the mitigation status when SMT is disabled
Message-ID: <20230815095724.GBZNtMBPUJSEegviJN@fat_crate.local>
References: <20230813104517.3346-1-bp@alien8.de>
 <1588ed00-be11-ff9d-e4c2-12db78cca06f@suse.com>
 <20230814200813.p5czl47zssuej7nv@treble>
 <20230814202545.GKZNqNybUnKv+xyrtP@fat_crate.local>
 <20230814205300.krikym7jeckehqik@treble>
 <20230814211727.GLZNqZ5+flxtyaDjMQ@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230814211727.GLZNqZ5+flxtyaDjMQ@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 11:17:27PM +0200, Borislav Petkov wrote:
> Lemme see how ugly it becomes tomorrow.

Not too bad, considering bugs.c's ugliness.

From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Tue, 15 Aug 2023 11:53:13 +0200
Subject: [PATCH] x86/srso: Correct the mitigation status when SMT is disabled

Specify how is SRSO mitigated when SMT is disabled. Also, correct the
SMT check for that.

Fixes: e9fbc47b818b ("x86/srso: Disable the mitigation on unaffected configurations")
Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/bugs.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 6c04aef4b63b..dc8f874fdd63 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2417,8 +2417,7 @@ static void __init srso_select_mitigation(void)
 		 * Zen1/2 with SMT off aren't vulnerable after the right
 		 * IBPB microcode has been applied.
 		 */
-		if ((boot_cpu_data.x86 < 0x19) &&
-		    (!cpu_smt_possible() || (cpu_smt_control == CPU_SMT_DISABLED))) {
+		if (boot_cpu_data.x86 < 0x19 && !cpu_smt_possible()) {
 			setup_force_cpu_cap(X86_FEATURE_SRSO_NO);
 			return;
 		}
@@ -2698,8 +2697,12 @@ static ssize_t retbleed_show_state(char *buf)
 
 static ssize_t srso_show_state(char *buf)
 {
-	if (boot_cpu_has(X86_FEATURE_SRSO_NO))
-		return sysfs_emit(buf, "Not affected\n");
+	if (boot_cpu_has(X86_FEATURE_SRSO_NO)) {
+		if (sched_smt_active())
+			return sysfs_emit(buf, "Not affected\n");
+		else
+			return sysfs_emit(buf, "Mitigation: SMT disabled\n");
+	}
 
 	return sysfs_emit(buf, "%s%s\n",
 			  srso_strings[srso_mitigation],
-- 
2.42.0.rc0.25.ga82fb66fed25

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
