Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35E07C701C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 16:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbjJLOLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 10:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbjJLOLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 10:11:05 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6784CD3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 07:11:01 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BD55840E01AF;
        Thu, 12 Oct 2023 14:10:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rN8O1BcOg_Cw; Thu, 12 Oct 2023 14:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1697119842; bh=GGIYY/lbvDlkxWXUY9/aSmZj3m7xg4UYirI2pYurq/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aYo5USI6ID2iJYwu5X5GS++ZtW56h+wF2Lb0+2n/SPEfOSMOzCYovidu3fh3/J1/B
         SS4uJgWOpprZyDXYmThMkRTnaCGOAMrztLZLInCDlPojF6W3+Wckgs5pCbZTCQoLxT
         RbcNAtfeXfo5cfg0phd3kWc6yoFPg2mMeNrRBNj3MWxP95edMokpi5eISBmqQgDeR8
         Jq5a2U2/ZJ+jKPM/BmNxeA+3EYFMl64DZPLAutBke262lIb939d9Zyb9HvEqusSx1R
         u6JIXMDZ7oruGfrepuVFwlM+uH9Ddi7NkGjwBudKDDQsMGODd6y/NZaskmEw78zmHo
         9t966F2fKs17XX950O8GV2Sd9GAcc+t7mVczmgISDpOMAnnCMKqjfYtizj4Xh3YQgh
         WaKH8KmQRpKPzs6N7ImN91MZpN8baLn050zyonNnwOgk3/39Ez9v71fGVf3a4+BsDi
         biPDEI/RUi/D8VWBL+r1e3PLYvzJAuTyHfCdPWsCa6U/0GU6SRsla2lZo5sdjMg/B5
         E6xnWe+KDw5tO1W+vyDLgvUXJkP0oG3ouCCIAVQwkqqrIRG/1qVDKnTsLnVYrm09kK
         ri0HFqPnmfq0jvgDcnZOM6hpkg4Gnof+mKM12kRiQ0wcJV9q66pWeSI0ri4tlv0+x1
         jASAbJCJA8zvnY1Lo/BQZDI8=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0D4FD40E01AA;
        Thu, 12 Oct 2023 14:10:37 +0000 (UTC)
Date:   Thu, 12 Oct 2023 16:10:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     "Kaplan, David" <David.Kaplan@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH -v2] x86/retpoline: Ensure default return thunk isn't used at
 runtime
Message-ID: <20231012141031.GHZSf+V1NjjUJTc9a9@fat_crate.local>
References: <20231010171020.462211-1-david.kaplan@amd.com>
 <20231010171020.462211-4-david.kaplan@amd.com>
 <20231010193643.su6iqjniuxqqke6d@treble>
 <SN6PR12MB2702315F5C39E5354D63E68E94CDA@SN6PR12MB2702.namprd12.prod.outlook.com>
 <20231010204119.76i7vwecmeo6ex6d@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231010204119.76i7vwecmeo6ex6d@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 01:41:19PM -0700, Josh Poimboeuf wrote:
> Even if it's not a security hole, I'd still view it as a major BUG() as
> it would directly contradict our understanding (and the comments above)
> and could cause performance or other correctness issues that would
> otherwise go unnoticed.
> 
> So I think an unconditional UD2 is warranted.

Before David's outlook mangles v2, lemme send it from a real mail
client :-P.

v2 uses X86_FEATURE_ALWAYS as Josh requested.

---
From: David Kaplan <david.kaplan@amd.com>
Date: Thu, 12 Oct 2023 08:52:32 -0500
Subject: [PATCH] x86/retpoline: Ensure default return thunk isn't used at runtime

All CPU bugs that require a return thunk define a special return thunk
to use (e.g., srso_return_thunk).  The default thunk,
__x86_return_thunk, should never be used after apply_returns()
completes.  Otherwise this could lead to potential speculation holes.

Enforce this by replacing this thunk with a ud2 when alternatives are
applied.  Alternative instructions are applied after apply_returns().

The default thunk is only used during kernel boot, it is not used during
module init since that occurs after apply_returns().

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/lib/retpoline.S | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index db813113e637..3f3a478b74dd 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -356,15 +356,17 @@ SYM_FUNC_END(call_depth_return_thunk)
  * This function name is magical and is used by -mfunction-return=thunk-extern
  * for the compiler to generate JMPs to it.
  *
- * This code is only used during kernel boot or module init.  All
+ * This code is only used during kernel boot.  All
  * 'JMP __x86_return_thunk' sites are changed to something else by
  * apply_returns().
+ *
+ * This thunk is turned into a ud2 to ensure it is never used at runtime.
+ * Alternative instructions are applied after apply_returns().
  */
 SYM_CODE_START(__x86_return_thunk)
 	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
-	ANNOTATE_UNRET_SAFE
-	ret
+	ALTERNATIVE __stringify(ANNOTATE_UNRET_SAFE;ret),"ud2", X86_FEATURE_ALWAYS
 	int3
 SYM_CODE_END(__x86_return_thunk)
 EXPORT_SYMBOL(__x86_return_thunk)
-- 
2.25.1

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
