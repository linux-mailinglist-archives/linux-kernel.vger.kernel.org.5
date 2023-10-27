Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A467D9D0B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346302AbjJ0Pea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346277AbjJ0Pe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:34:28 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CCDAF
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:34:26 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 45F5A40E01AE;
        Fri, 27 Oct 2023 15:34:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ymeotQ_ZqnH0; Fri, 27 Oct 2023 15:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1698420863; bh=qXicR4KuTA+DKqRDXe/V2fOEtekkWUIMSlHj2hEo+g0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CIUcrpAiAES115DqGNWMLOSUY0sv7OoNxrZEy+rwY18/567CcyMOuNb+o+c3uQOaG
         TlVBLedP9QDyGxSfBPxAFDHZY1C1RrvYTjEsfYweSf0pH1QVfF0l6kkde7bLsdsQ2H
         AjD6nKSsFK7342OCyKSUycyY+VgKs7T2AP7bPzg4RA2q5QdFBR7z1pjfPnBtQTuQ/w
         kuZarL+Cq4dMKvJG1awniB7+NUWrJDjQjyaMjulWVvVQ7FH5zX5P6HHAvVtHDmoOrY
         rNy+SkUmORF+u5ef9uLa2r4BKKO7CpXtYKa3calmmLz3IIydnj42eLtk6+GBS07XMF
         65S+hOeSss0vMgxNz7JS5EOe/30/EvKJCqfVoy426Z7y8Ns8d79/qh4Llxd/S8UpEv
         k+4HfUwd7EPIHjMLk3utC3RUOVwI59t7jxEX23bYZcOuYBZzDq2AlmN8gOihLyxKOT
         0oYt4tRAeEvqKMuupW4oj7Q+uArWZtXVbzHCWqZ0XjtMyhknRT5FJD3tnna4JXO6Ox
         ykLl8xYwh+blwcFA+j8vTXo7B/imRB05Nb/MNxHrIRZkoZpIm1ZWL8A/rtwnrkc5ux
         SCNDJFgTKbm2gOzoi1/iYePTKI4svozwCJ8981tYXnTZ07jeDvfvZQbev3PlbfxCrO
         gee4GVuvfEkrvh2yitZ+XRk0=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2029140E01A3;
        Fri, 27 Oct 2023 15:34:19 +0000 (UTC)
Date:   Fri, 27 Oct 2023 17:34:18 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>,
        Kishon VijayAbraham <Kishon.VijayAbraham@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] x86/alternative: Add per-vendor patching
Message-ID: <20231027153418.GLZTvYejCkXb03rArO@fat_crate.local>
References: <20230622095212.20940-1-bp@alien8.de>
 <20230703125419.GJ4253@hirez.programming.kicks-ass.net>
 <20230704074631.GAZKPOV/9BfqP0aU8v@fat_crate.local>
 <20230704090132.GP4253@hirez.programming.kicks-ass.net>
 <20230704092222.GBZKPkzgdM8rbPe7zA@fat_crate.local>
 <20231027153327.GKZTvYR3qslaTUjtCT@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231027153327.GKZTvYR3qslaTUjtCT@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Fri, 27 Oct 2023 13:34:12 +0200

Add the capability to apply alternatives not based on a CPU feature but
on the current vendor the machine is running on.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/alternative.h |  7 ++++++-
 arch/x86/kernel/alternative.c      | 14 +++++++++-----
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 65f79092c9d9..76750f8b5aba 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -8,8 +8,13 @@
 
 #define ALT_FLAGS_SHIFT		16
 
-#define ALT_FLAG_NOT		(1 << 0)
+/* Negate the tested feature flag */
+#define ALT_FLAG_NOT		BIT(0)
+/* Check X86_VENDOR_* instead of a feature flag */
+#define	ALT_FLAG_VENDOR		BIT(1)
+
 #define ALT_NOT(feature)	((ALT_FLAG_NOT << ALT_FLAGS_SHIFT) | (feature))
+#define ALT_VENDOR(x86_vendor)	((ALT_FLAG_VENDOR << ALT_FLAGS_SHIFT) | (x86_vendor))
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 73be3931e4f0..8b67b5c6090e 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -433,19 +433,23 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 
 		/*
 		 * Patch if either:
+		 * - running on the respective x86 vendor
 		 * - feature is present
 		 * - feature not present but ALT_FLAG_NOT is set to mean,
 		 *   patch if feature is *NOT* present.
 		 */
-		if (!boot_cpu_has(a->cpuid) == !(a->flags & ALT_FLAG_NOT)) {
+		if (a->flags & ALT_FLAG_VENDOR) {
+			if (boot_cpu_data.x86_vendor != a->cpuid) {
+				optimize_nops(instr, a->instrlen);
+				continue;
+			}
+		} else if (!boot_cpu_has(a->cpuid) == !(a->flags & ALT_FLAG_NOT)) {
 			optimize_nops(instr, a->instrlen);
 			continue;
 		}
 
-		DPRINTK(ALT, "feat: %s%d*32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %d)",
-			(a->flags & ALT_FLAG_NOT) ? "!" : "",
-			a->cpuid >> 5,
-			a->cpuid & 0x1f,
+		DPRINTK(ALT, "feat: 0x%x, flags: 0x%x, old: (%pS (%px) len: %d), repl: (%px, len: %d)",
+			a->cpuid, a->flags,
 			instr, instr, a->instrlen,
 			replacement, a->replacementlen);
 
-- 
2.42.0.rc0.25.ga82fb66fed25


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
