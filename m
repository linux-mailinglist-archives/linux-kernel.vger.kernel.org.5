Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1105C7A9DC5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjIUTrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjIUTrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:47:08 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3727EA08
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:50:47 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2B3A540E01AE;
        Thu, 21 Sep 2023 10:42:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6GwleSayMBz7; Thu, 21 Sep 2023 10:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1695292951; bh=u6FU53sJ2hGaVLFhit7xtBFpz6lRLfRAwQHq1iMCwrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L1+0H3CZN/T2b2bu8c9Db/P7fuUfXSBhWOTjlHsulPdMMw4fuin/ZT1merfMPLD5K
         pwkbTIZ7c6AoSK+2AVKp8XON2s6WJBz/F6GW0/Gi33gumGUjiGbpkqyZKCI+atNFGs
         LPL56Sc+Cm7mF7TaJszmftbb05t3pDLJarUBZ4sISXhaRM7O3gIuHVaNyPm/CWN7ty
         KtccIKqbD4sKBk3U3dDAhcrOsSQkDcgp3p7gtb0cFqz4FfgFzwVOUE2pEe4Ykt1nfg
         uePVGReF5uvCG02K4h+XjonyyOvVhjBqTWnWhHI8S2U2o5WIdgd3QfxW2Ovq/LA0eu
         vYfPk3qHJ2Z6JFj84N2K+hpj8V3xyuJOK6q2mbEa3N230XMku29hfV2+pUNMJIqjGd
         peAbpZ1MQJ8D9IVRmzx4HJGd2IBe7B6Uo5IiroT6YZaZzMgtpND9iSWthnzvFRBZbs
         SyQevqKNujQHLQ9BGZ19Aqg4NNHk35sA6rKNLPWejrPZ9XzuUPXXwvzRdll6ZBnxuV
         Cyu5lPlJUei5/vKHwZ55yjk7aMOJNX0pwWhSexcLwwWJX1n3CvKTMiyb9q3c0qTej+
         ZWNI6BVuTJMaNnOCpxvNEskxOgcGPLKmWbuK3zeEdTKx9BGMiQ4O2mSVKokgolQTjs
         D7LFXb8TeMe2tQEK0NhdEN1k=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BA5B940E00B3;
        Thu, 21 Sep 2023 10:42:25 +0000 (UTC)
Date:   Thu, 21 Sep 2023 12:42:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [patch V3 12/30] x86/microcode/intel: Reuse
 intel_cpu_collect_info()
Message-ID: <20230921104220.GHZQweDKyaJmkYdt4f@fat_crate.local>
References: <20230912065249.695681286@linutronix.de>
 <20230912065501.530637507@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230912065501.530637507@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 09:58:02AM +0200, Thomas Gleixner wrote:
>  static int collect_cpu_info(int cpu_num, struct cpu_signature *csig)

You can get rid of that silly wrapper too and use
intel_collect_cpu_info() in the function pointer assignment directly.

Diff ontop:

---

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 4066dd3734ba..581ecfbaf134 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -75,7 +75,7 @@ extern __noendbr void cet_disable(void);
 
 struct cpu_signature;
 
-void intel_collect_cpu_info(struct cpu_signature *sig);
+void intel_collect_cpu_info(int unused, struct cpu_signature *sig);
 
 static inline bool intel_cpu_signatures_match(unsigned int s1, unsigned int p1,
 					      unsigned int s2, unsigned int p2)
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 6c3b10e6b214..ebf0908fd91a 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -652,7 +652,7 @@ void reload_ucode_amd(unsigned int cpu)
 	}
 }
 
-static int collect_cpu_info_amd(int cpu, struct cpu_signature *csig)
+static void collect_cpu_info_amd(int cpu, struct cpu_signature *csig)
 {
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
@@ -670,8 +670,6 @@ static int collect_cpu_info_amd(int cpu, struct cpu_signature *csig)
 		uci->mc = p->data;
 
 	pr_info("CPU%d: patch_level=0x%08x\n", cpu, csig->rev);
-
-	return 0;
 }
 
 static enum ucode_state apply_microcode_amd(int cpu)
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 6d67b92d7252..77e4120de641 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -66,7 +66,7 @@ static inline unsigned int exttable_size(struct extended_sigtable *et)
 	return et->count * EXT_SIGNATURE_SIZE + EXT_HEADER_SIZE;
 }
 
-void intel_collect_cpu_info(struct cpu_signature *sig)
+void intel_collect_cpu_info(int unused, struct cpu_signature *sig)
 {
 	sig->sig = cpuid_eax(1);
 	sig->pf = 0;
@@ -362,7 +362,7 @@ static __init struct microcode_intel *get_ucode_from_cpio(struct ucode_cpu_info
 	if (!(cp.data && cp.size))
 		return NULL;
 
-	intel_collect_cpu_info(&uci->cpu_sig);
+	intel_collect_cpu_info(0, &uci->cpu_sig);
 
 	return scan_microcode(cp.data, cp.size, uci);
 }
@@ -423,12 +423,6 @@ void reload_ucode_intel(void)
 		apply_microcode_early(&uci, false);
 }
 
-static int collect_cpu_info(int cpu_num, struct cpu_signature *csig)
-{
-	intel_collect_cpu_info(csig);
-	return 0;
-}
-
 static enum ucode_state apply_microcode_late(int cpu)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
@@ -591,7 +585,7 @@ static void finalize_late_load(int result)
 
 static struct microcode_ops microcode_intel_ops = {
 	.request_microcode_fw	= request_microcode_fw,
-	.collect_cpu_info	= collect_cpu_info,
+	.collect_cpu_info	= intel_collect_cpu_info,
 	.apply_microcode	= apply_microcode_late,
 	.finalize_late_load	= finalize_late_load,
 };
diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
index 051b7956d4fd..b3753025cd4a 100644
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -30,7 +30,7 @@ struct microcode_ops {
 	 * See also the "Synchronization" section in microcode_core.c.
 	 */
 	enum ucode_state (*apply_microcode)(int cpu);
-	int (*collect_cpu_info)(int cpu, struct cpu_signature *csig);
+	void (*collect_cpu_info)(int cpu, struct cpu_signature *csig);
 	void (*finalize_late_load)(int result);
 };
 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
