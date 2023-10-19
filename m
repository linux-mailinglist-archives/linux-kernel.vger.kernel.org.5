Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5927CF42F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345019AbjJSJkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjJSJks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:40:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC0E106;
        Thu, 19 Oct 2023 02:40:46 -0700 (PDT)
Date:   Thu, 19 Oct 2023 09:40:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697708444;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oVvf4IZfAG/kVntUqjLXAm4xY2Be5dfXjuNFxnML5Eo=;
        b=bT4zmeB3ff6jv54U6GrVtsRadIxzg1As6Ply5BYKa1gTCSutgK83f9nVyodHIxO6x+OarV
        rqI+ss6sgMlGmYTkf9WQNP67WN+Xc52YlIolE2vffdJzVhQOcPmnZu+kW+B3w6LV6XbBRR
        QyNJGOVWUvC+Ks1PkiTvUYD6ainEbOMFcfTeTXoKF6WX7f7gUY/QdY8ZJF1nAoJnhlUTuz
        Tqamh6olyIEF12UEzUZ89hz4imKaxsJ69hetVYiJql2SCUCdfAf4v/Rq0yWUWIX5npKjo3
        amDSVHb2ZAV/4V6PXuS/wUuskf+EoWpPM1JvJIGUrRLVLtzqF1ABts/VD4sCSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697708444;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oVvf4IZfAG/kVntUqjLXAm4xY2Be5dfXjuNFxnML5Eo=;
        b=hq52O4YsMZP/S2cgmTJitAsPWwQXZpQSMttdBbpHFwgptSxmFyZwM9FTXDd/0NvyD2UMF/
        MN1gdg13qOUmsCDg==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] Revert "x86/retpoline: Ensure default return thunk
 isn't used at runtime"
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        David Kaplan <david.kaplan@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231018175531.GEZTAcE2p92U1AuVp1@fat_crate.local>
References: <20231018175531.GEZTAcE2p92U1AuVp1@fat_crate.local>
MIME-Version: 1.0
Message-ID: <169770844376.3135.9436969789797102205.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     08ec7e82c1e3ebcd79ab8d2d0d11faad0f07e71c
Gitweb:        https://git.kernel.org/tip/08ec7e82c1e3ebcd79ab8d2d0d11faad0f07e71c
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Thu, 19 Oct 2023 11:04:27 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 19 Oct 2023 11:08:22 +02:00

Revert "x86/retpoline: Ensure default return thunk isn't used at runtime"

This reverts commit 91174087dcc7565d8bf0d576544e42d5b1de6f39.

It turns out that raising an undefined opcode exception due to unpatched
return thunks is not visible to users in every possible scenario (not
being able to catch dmesg, slow console, etc.).

Thus, it is not very friendly to them when the box explodes without even
saying why.

Revert for now until a better solution has been devised.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: David Kaplan <david.kaplan@amd.com>
Link: https://lore.kernel.org/r/20231018175531.GEZTAcE2p92U1AuVp1@fat_crate.local
---
 arch/x86/lib/retpoline.S | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index fe05c13..6376d01 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -356,17 +356,15 @@ SYM_FUNC_END(call_depth_return_thunk)
  * This function name is magical and is used by -mfunction-return=thunk-extern
  * for the compiler to generate JMPs to it.
  *
- * This code is only used during kernel boot.  All
+ * This code is only used during kernel boot or module init.  All
  * 'JMP __x86_return_thunk' sites are changed to something else by
  * apply_returns().
- *
- * This thunk is turned into a ud2 to ensure it is never used at runtime.
- * Alternative instructions are applied after apply_returns().
  */
 SYM_CODE_START(__x86_return_thunk)
 	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
-	ALTERNATIVE __stringify(ANNOTATE_UNRET_SAFE;ret),"ud2", X86_FEATURE_ALWAYS
+	ANNOTATE_UNRET_SAFE
+	ret
 	int3
 SYM_CODE_END(__x86_return_thunk)
 EXPORT_SYMBOL(__x86_return_thunk)
