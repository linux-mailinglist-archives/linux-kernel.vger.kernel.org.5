Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685837D0E63
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377091AbjJTL3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377053AbjJTL3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:29:00 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A6991
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 04:28:58 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 602B740E0196;
        Fri, 20 Oct 2023 11:28:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XZblKcWG3bFf; Fri, 20 Oct 2023 11:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1697801334; bh=RPwiG2OS9U7D49CvSl48CZBuAaYsCnuLO0DjiNynFZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h/1/QSn6XWM2sglklNiPvziowHcbXGdDj7TZt6AMJN3uMWtHKknKgQ+Zj1vscQYgK
         BuguGdOJ9GwBSBRzYOhzK5NLIg+N0h/80GrPEhDFYRK4QCsKjWqJB9j4Of4eDrlF/O
         3QisHlsSjvu3ti0g7p11c6IfXZmcW/bi7rZZ1LagwJ0rLJhyJbqJcWMgFJmk/qL/EB
         TgfGidKGx7KZHdT9Ia7PvlxWHtXWqv4g4G+DtoaaTssA3gOZZ86JV9kg4j2KQ/NWO3
         22aC7nYne3QBr26gCAknAy9V+fkFIQ0L/XKGVTiTHoHFNVW3CvHhHq8DxLZNYTZS+V
         hYaJU1Q62NM+W91/1IEnjM0cgvLWxXQMNk6ofw+U8gtGMoL/rmvURih+tBM3j18jrb
         WqsdB/ZDDLrlTepMSP+xM1BKJNPC4pnXZSAFhKqlZORiJCfvEwkeoFn57Y6/gjY12P
         uZThvfVqBCGWCkHYXV0WotFksmn8Gym9RKnRPFOViBF4PoVAb93siLl92UBGyX/Adv
         FIDzuq0j3OL2E97kWrb/94DHay6p8DnTBIlLDp8kU9AAd/7LdtHLwedjXZPFcNAdTm
         8Fyr9Cz1d6MMX6DTgP9/QQAcThnaUd5ktxwVrTdp+qyP6yHmob1NOZ865X57Bj/6lB
         Q8dLxhKlbJD6m1zwgC3K2xuk=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0431940E0187;
        Fri, 20 Oct 2023 11:28:48 +0000 (UTC)
Date:   Fri, 20 Oct 2023 13:28:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     David Kaplan <david.kaplan@amd.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, luto@kernel.org, linux-kernel@vger.kernel.org
Subject: Subject: [PATCH] x86/retpoline: Document some thunk handling aspects
 (was: Re: [PATCH 0/3] Ensure default return thunk isn't used at runtime)
Message-ID: <20231020112843.GEZTJkax6LRw+x8qZj@fat_crate.local>
References: <20231010171020.462211-1-david.kaplan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231010171020.462211-1-david.kaplan@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 12:10:17PM -0500, David Kaplan wrote:
> Several CPU side-channel mitigations require the use of a special return thunk.
> The necessary return thunk is installed at runtime via apply_returns(), after
> which point the default return thunk (__x86_return_thunk) should never be used.

Ok, mingo was right when suggesting that reverting those commits is not
really the right thing to do because it would break bisection if the
bisection point lands before the reverts. Yeah, yeah, it is unlikely but
better safe than sorry. So I went and rebased the whole tip:x86/bugs
branch into a clean state.

I've left, I hope enough, breadcrumbs in there for future improvements
in the form of the following patch:

---
From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Fri, 20 Oct 2023 13:17:14 +0200
Subject: [PATCH] x86/retpoline: Document some thunk handling aspects

After a lot of experimenting (see thread Link points to) document for
now the issues and requirements for future improvements to the thunk
handling and potential issuing of a diagnostic when the default thunk
hasn't been patched out.

This documentation is only temporary and that close before the merge
window it is only a placeholder for those future improvements.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231010171020.462211-1-david.kaplan@amd.com
---
 arch/x86/lib/retpoline.S | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index d410abacbf88..a48077c5ca61 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -129,6 +129,13 @@ SYM_CODE_END(__x86_indirect_jump_thunk_array)
 
 #ifdef CONFIG_RETHUNK
 
+/*
+ * Be careful here: that label cannot really be removed because in
+ * some configurations and toolchains, the JMP __x86_return_thunk the
+ * compiler issues is either a short one or the compiler doesn't use
+ * relocations for same-section JMPs and that breaks the returns
+ * detection logic in apply_returns() and in objtool.
+ */
 	.section .text..__x86.return_thunk
 
 #ifdef CONFIG_CPU_SRSO
@@ -361,6 +368,14 @@ SYM_FUNC_END(call_depth_return_thunk)
  * This code is only used during kernel boot or module init.  All
  * 'JMP __x86_return_thunk' sites are changed to something else by
  * apply_returns().
+ *
+ * This should be converted eventually to call a warning function which
+ * should scream loudly when the default return thunk is called after
+ * alternatives have been applied.
+ *
+ * That warning function cannot BUG() because the bug splat cannot be
+ * displayed in all possible configurations, leading to users not really
+ * knowing why the machine froze.
  */
 SYM_CODE_START(__x86_return_thunk)
 	UNWIND_HINT_FUNC
-- 
2.42.0.rc0.25.ga82fb66fed25

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
