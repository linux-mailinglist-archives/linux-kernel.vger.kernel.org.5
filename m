Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0710B778BAC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbjHKKPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbjHKKPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:15:32 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C54F3A84
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 03:15:08 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AB14740E0185;
        Fri, 11 Aug 2023 10:15:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CnFUoGN2bxY4; Fri, 11 Aug 2023 10:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691748904; bh=gVGvrZC2v7aO0AiUD4xf5LLLhTgBHF/b0+ZfmDGpgbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QDQJ+ayCdrTw2CKbAjmT12MuKTHha5FRzQy5hi+BG8YWub6oyVJvyo2WEXqxpAeIi
         d2ziPVA3UIAD67z8kM/zoOhVyujiHJqCcRD1CTOFSdnUGd7Y+KWbznmh9Dp4t40kJC
         KozJ+9lOFrhJC2ZZl8qhLjCHNoz6q8nakGYhfX0K7t32U55MXg5i+cBHHn/sdKd2Ag
         zUPul810V8v3J/srKOVkEu/EpiLg9s9CWpj0qyll9GawrDgM9mlkHfNu9dG1VKbZ8x
         FzVnndEVIBr4i6vgnYhL7QxEjSaczzcDFG6CY9DBTwRTmJgKmBiVkIu+U6YS/YxjqS
         sbMDmkNIn5BomiN9GJu6P21bDTRUCUbQ9OpQLvZIO4/BC1zRtrcdQimaHOaYK4k8e/
         ykYOxN9fPEhhEJWnxjfk+uAyETiMnl9gIN/fiSG0y1Lly0XwAzDdlKSe4GOQOwK9iF
         ohovDuybCJQss9C9CEl34qZkn43hYvmRMt5rqRnwkqS35ACOSz2xw+MP/wb90qB8oZ
         1y5jWNi3eNa2OOaoBghS6KeQcI9T18n82vA1zf6ZWKJM3f0tXNCS7lVJj0zaQmB5em
         qnT49+wlkRCXxkPfBUJQBV+NxYv8kCOcP5JruXdQjDCS5Ts1G7d2fpjKXUgzVExZri
         Yf/0qNskiDmjlihH24cEUTxI=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A8FD340E01A1;
        Fri, 11 Aug 2023 10:15:00 +0000 (UTC)
Date:   Fri, 11 Aug 2023 12:14:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: Hang when booting guest kernels compiled with clang after SRSO
 mitigations
Message-ID: <20230811101456.GDZNYKIHs1k7ri8hrI@fat_crate.local>
References: <20230810101649.GA1795474@dev-arch.thelio-3990X>
 <20230810125122.GIZNTdSuFvA3Cjfexq@fat_crate.local>
 <20230810132706.GA3805855@dev-arch.thelio-3990X>
 <20230810133216.GKZNTm4KpohRR4gVsT@fat_crate.local>
 <20230810134056.GA130730@dev-arch.thelio-3990X>
 <20230810144344.GLZNT3oM6MLVdzGlyd@fat_crate.local>
 <20230810150706.GA42856@dev-arch.thelio-3990X>
 <20230810151410.GNZNT+wn/cLBWiU6dO@fat_crate.local>
 <20230810154831.GA38495@dev-arch.thelio-3990X>
 <20230810161414.GA4000@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230810161414.GA4000@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 09:14:14AM -0700, Nathan Chancellor wrote:
> Not sure how helpful that will be...

Yeah, not really. More wild guesses: if you uncomment the UNTRAIN_RET in
__svm_vcpu_run() on the host, does that have any effect? Diff below.

Also, can you send me the host and guest .configs and the compilers
you've used so that I can try to reproduce here exactly what you have?

Thx.

---
diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
index 265452fc9ebe..b5871259a973 100644
--- a/arch/x86/kvm/svm/vmenter.S
+++ b/arch/x86/kvm/svm/vmenter.S
@@ -222,7 +222,7 @@ SYM_FUNC_START(__svm_vcpu_run)
 	 * because interrupt handlers won't sanitize 'ret' if the return is
 	 * from the kernel.
 	 */
-	UNTRAIN_RET
+//	UNTRAIN_RET
 
 	/* SRSO */
 	ALTERNATIVE "", "call entry_ibpb", X86_FEATURE_IBPB_ON_VMEXIT


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
