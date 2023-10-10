Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52867BF635
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjJJIkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjJJIkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:40:11 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9747211D
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:40:08 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5434140E014B;
        Tue, 10 Oct 2023 08:40:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3Me0YP-jJVoj; Tue, 10 Oct 2023 08:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1696927204; bh=9walowOI8kaX/dL4Mftiv56c3vMqZAoEx0m2sBLeKfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RpBDNjp1lFmWVnl5E+20pnbbvXbD+G8OwSWCdcXUMPFpiuqNEswaPBhDRpOqDVCwK
         TSm6P63jP5aSSzN12A2H2XDw2Y2Zq4ucsICb4E6h978/epY7qWYAzYEJPMvpIz/Rq/
         RtLbYoLLHrmW0Tn2NScPnpIhOqLUpLrCfnSlwkg/MEIsSf1JBGiWvIhby6Fs35OTRb
         ahPxao16IMYqC+ja7V4Hsucma7asTVsBYYy3rsuUBkVTZIGzGFGkQ1+5ZKXa0H02cL
         Uwozj8ibMi8SE4BDqbUHuRHUUTD32YDQD+Qy+vRugz7NfD2asnPXRvOd59IiQVyX2r
         u2p4aFDajDMCmVst/sYosa/+zMsqul5WHVyQ7L9XMOEwazG50fu0gdEMLxJOaU8r8M
         8qLOC30YMR2dtPFyAsLVFrMsq5bjdisiR6xkvmjOmW4YEywa6yswQaA4Jk9CrRDeaV
         wpPMxz20H8gVI80cWaTrxzcgorSyMKTJQkFwvVAm0ZuG8ssOCEBUqgXLPtxZX4CYE5
         z5XvXvAERxUrsLGYA4qC7G5G1bEFILrQSjdFjWhOEI57g+UKA6oDeHTo9PC0IImTjo
         ko/SjE8IpwGDOILwhxKvhkjOULrSdiB2zBGjGd66Sx9F4NF8w79Urfjbl9xPjr6g4Z
         wJRkDBCFyTxqK9n/GWWzzLL8=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4047540E01AA;
        Tue, 10 Oct 2023 08:40:01 +0000 (UTC)
Date:   Tue, 10 Oct 2023 10:39:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     =?utf-8?B?UmVuw6k=?= Rebe <rene@exactcode.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC] AMD Zen4 CPU bug? Spurious SMT Sibling Invalid Opcode
 Speculation
Message-ID: <20231010083956.GEZSUN3OKuYSyU182V@fat_crate.local>
References: <D99589F4-BC5D-430B-87B2-72C20370CF57@exactcode.com>
 <20231004222511.GHZR3mR/oNFZuJGB9P@fat_crate.local>
 <797F7A00-541E-4333-B653-1120DF5C56B1@exactcode.com>
 <20231006093244.GAZR/UPJidkn7GIGeL@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231006093244.GAZR/UPJidkn7GIGeL@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 11:32:44AM +0200, Borislav Petkov wrote:
> I'm still working on it and I'll have something soon.

Ok, try this below and see whether it fixes your reproducer.

Thx.

---
From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Sat, 7 Oct 2023 12:57:02 +0200
Subject: [PATCH] x86/cpu: Fix AMD erratum #1485 on Zen4-based CPUs

Fix erratum #1485 on Zen4 parts where running with STIBP disabled can
cause an #UD exception. The performance impact of the fix is negligible.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@kernel.org>
---
 arch/x86/include/asm/msr-index.h | 9 +++++++--
 arch/x86/kernel/cpu/amd.c        | 8 ++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 1d111350197f..b37abb55e948 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -637,12 +637,17 @@
 /* AMD Last Branch Record MSRs */
 #define MSR_AMD64_LBR_SELECT			0xc000010e
 
-/* Fam 17h MSRs */
-#define MSR_F17H_IRPERF			0xc00000e9
+/* Zen4 */
+#define MSR_ZEN4_BP_CFG			0xc001102e
+#define MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT 5
 
+/* Zen 2 */
 #define MSR_ZEN2_SPECTRAL_CHICKEN	0xc00110e3
 #define MSR_ZEN2_SPECTRAL_CHICKEN_BIT	BIT_ULL(1)
 
+/* Fam 17h MSRs */
+#define MSR_F17H_IRPERF			0xc00000e9
+
 /* Fam 16h MSRs */
 #define MSR_F16H_L2I_PERF_CTL		0xc0010230
 #define MSR_F16H_L2I_PERF_CTR		0xc0010231
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 03ef962a6992..ece2b5b7b0fe 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -80,6 +80,10 @@ static const int amd_div0[] =
 	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x17, 0x00, 0x0, 0x2f, 0xf),
 			   AMD_MODEL_RANGE(0x17, 0x50, 0x0, 0x5f, 0xf));
 
+static const int amd_erratum_1485[] =
+	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x19, 0x10, 0x0, 0x1f, 0xf),
+			   AMD_MODEL_RANGE(0x19, 0x60, 0x0, 0xaf, 0xf));
+
 static bool cpu_has_amd_erratum(struct cpuinfo_x86 *cpu, const int *erratum)
 {
 	int osvw_id = *erratum++;
@@ -1149,6 +1153,10 @@ static void init_amd(struct cpuinfo_x86 *c)
 		pr_notice_once("AMD Zen1 DIV0 bug detected. Disable SMT for full protection.\n");
 		setup_force_cpu_bug(X86_BUG_DIV0);
 	}
+
+	if (!cpu_has(c, X86_FEATURE_HYPERVISOR) &&
+	     cpu_has_amd_erratum(c, amd_erratum_1485))
+		msr_set_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT);
 }
 
 #ifdef CONFIG_X86_32
-- 
2.42.0.rc0.25.ga82fb66fed25

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
