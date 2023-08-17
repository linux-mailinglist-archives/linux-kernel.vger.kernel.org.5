Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B3077F2C0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349291AbjHQJIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349311AbjHQJHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:07:43 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91D110C8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:07:41 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 85A2740E0197;
        Thu, 17 Aug 2023 09:07:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZhJFlBXWW3dx; Thu, 17 Aug 2023 09:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1692263256; bh=Ell1ypaMYGjxyAwvIbYxQkvjnnCi3BqtvuAeFjrHE2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iak+Znyr7MmErDT/5l69DBwaBgm0+SWi3WhpMGxnL/jaPxQgpSvQ0X6aBPBc5Ba9w
         wJXW6g1fsF77pFzg+5w2cBgjlpjfr6aqb10FqYecRxRJwn6qnlMpukJEovK6XNpzcK
         gc90adMKmocx0FSI8Z7tfRmfNSO9nlq409dFk6g6QHCePXajkusaI1QhdemLYb5qHb
         0QLrVoBTaqQhudMg2lJKHHmFa+kb7nbwNB7+70WCF/TLN/iGegiB+oW+yE1G019WB/
         dSXwUIMWT7WNvnYm2vYeo3A0zqAegjXmFhwnScAZHTYw9TIkxNYKjrMpkogJn7BqeT
         oWt5VBUCPchkunNGISVz8LuYO4YEXSx+NwPeKtNTw9U0Mf66B/Id7ZhYC4EsuafhLu
         7af1WjwA1lZrAQPdNTDt4kU+Zu9pY3Zyl+oHX7FtmgTS5VHxnGV2sowIPfLv7poiZ4
         tpMTJMbIt3IAhiDIYXIAkEdI3s86xvEAO+nH4OBUadtymE5Mdr+CIf7Y0eXwJWW9b2
         Mx6009qe9iUXFA0mK0UBy9ZDQ178iaOYKR1BdbXg2UfZWL1BE3obGYyxdy9cU9Qi6D
         rQCZ2Jmc/6xBo/QlTwpkW5VBFyVyJKo4UkQYuSQHVl0p3+VHH32L7a5Fhgy6Ii/Bxv
         yGooneRzFnbbhKBE+hQdd248=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9CD2940E00B0;
        Thu, 17 Aug 2023 09:07:31 +0000 (UTC)
Date:   Thu, 17 Aug 2023 11:07:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Nikolay Borisov <nik.borisov@suse.com>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/srso: Correct the mitigation status when SMT is
 disabled
Message-ID: <20230817090727.GBZN3jT0+gH2iTyeOF@fat_crate.local>
References: <20230814211727.GLZNqZ5+flxtyaDjMQ@fat_crate.local>
 <20230815095724.GBZNtMBPUJSEegviJN@fat_crate.local>
 <20230815195831.2opbgrznnpszaa32@treble>
 <20230815201753.GGZNvdcbPHXtEXn4As@fat_crate.local>
 <20230815212751.xhsyn7iwj2gwpuk5@treble>
 <20230816083057.GCZNyJQVARsxD3rNAm@fat_crate.local>
 <20230816160757.oegndrcnf2fvt7l3@treble>
 <20230816173531.GMZN0I40DEFE38Zxuz@fat_crate.local>
 <20230816182940.xw67h5xbilqpb5au@treble>
 <20230816185830.GOZN0cVl/pJcZUiPGY@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230816185830.GOZN0cVl/pJcZUiPGY@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Tue, 15 Aug 2023 11:53:13 +0200
Subject: [PATCH] x86/srso: Correct the mitigation status when SMT is disabled

Specify how is SRSO mitigated when SMT is disabled. Also, correct the
SMT check for that.

Fixes: e9fbc47b818b ("x86/srso: Disable the mitigation on unaffected configurations")
Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230814200813.p5czl47zssuej7nv@treble
---
 arch/x86/kernel/cpu/bugs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 9026e3fe9f6c..f081d26616ac 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2428,8 +2428,7 @@ static void __init srso_select_mitigation(void)
 		 * Zen1/2 with SMT off aren't vulnerable after the right
 		 * IBPB microcode has been applied.
 		 */
-		if ((boot_cpu_data.x86 < 0x19) &&
-		    (!cpu_smt_possible() || (cpu_smt_control == CPU_SMT_DISABLED))) {
+		if (boot_cpu_data.x86 < 0x19 && !cpu_smt_possible()) {
 			setup_force_cpu_cap(X86_FEATURE_SRSO_NO);
 			return;
 		}
@@ -2714,7 +2713,7 @@ static ssize_t retbleed_show_state(char *buf)
 static ssize_t srso_show_state(char *buf)
 {
 	if (boot_cpu_has(X86_FEATURE_SRSO_NO))
-		return sysfs_emit(buf, "Not affected\n");
+		return sysfs_emit(buf, "Mitigation: SMT disabled\n");
 
 	return sysfs_emit(buf, "%s%s\n",
 			  srso_strings[srso_mitigation],
-- 
2.42.0.rc0.25.ga82fb66fed25

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
