Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671CA7B6B24
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238695AbjJCOPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbjJCOPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:15:00 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C5D95
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:14:56 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A67A640E019B;
        Tue,  3 Oct 2023 14:14:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UxSJC3wcviSH; Tue,  3 Oct 2023 14:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1696342491; bh=cWe+9EKpu/IN0/8UdlEVGZJ0GpnN/C82QwDQgHFbvcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RfQAPci9N4WQy7gnVO6ykw9TcEB2JbjTjbndCKR6IQiikvkkRElx0el1YxIFAzepU
         ktjaqrDifUAVPMnw6StKOUavHvuyO6Hcnhe3TjMPPdsZB0SvBv4cENyGKKHRUDBbTF
         uMIBKp2+H+QQetPWSXDp7bIygQ7xjMMkkvMFJMKnOx25XdLgwxMiyoYM3CkR278myT
         pq29cbbo/2GZkveossdZ7DVB3wQMx/ZHRp6tjyYOXSVPCQszoum3GqVJpWhnys8XHz
         kmuUHVGsDWi3XMTI4nOmg4iT1mMXuZDIdm0GtZzuovQOHmYYouGclMuM4f8N6S4u7R
         JwztXlEjwIGA/QyIbxtG0RhZEoGAxTm6iGN+4zEoJiNHd024aSndUAj1m5ViqASUOW
         qMiLsYL0v5ZgM6RTkJAwggUaS7KsSORJKP6itF75uUTfjnY7iW8s/vCIYgbzYEZHRe
         t4Qij0r/ZUExdF5pdRssSi8tlmPykR2854exPdcv7h9IzLoTYSs1frp0Y7/76qxOoh
         B/QSUUE7IG/v2hpwtElvOwCmaQXZyEWpn3snYYyOr8hlLuMLisCjpfPaDrHVMXT7OV
         SMz9Ajo+2bsLvMykckqHCeqTX3rDA7nn4x8QeZ2gO5xzLD/0QBgpaBBxj+7dzx2t2L
         M2y87aCP7jIK0k0mOvhSGvsM=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9A7C340E01A2;
        Tue,  3 Oct 2023 14:14:45 +0000 (UTC)
Date:   Tue, 3 Oct 2023 16:14:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [patch V3 12/30] x86/microcode/intel: Reuse
 intel_cpu_collect_info()
Message-ID: <20231003141439.GAZRwhz63IqTB+uNOM@fat_crate.local>
References: <20230912065249.695681286@linutronix.de>
 <20230912065501.530637507@linutronix.de>
 <20230921104220.GHZQweDKyaJmkYdt4f@fat_crate.local>
 <87zg1afs23.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zg1afs23.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 12:47:16PM +0200, Thomas Gleixner wrote:
> Eew. That's a function exposed to code outside of microcode and just
> grows that unused argument for no value and you obviously forgot to
> fixup the extern callsite :)

It's used on AMD. Adding the below to the pile.

---
From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Tue, 3 Oct 2023 16:12:01 +0200
Subject: [PATCH] x86/microcode: Make microcode_ops.collect_cpu_info() return
 void

Simplify code flow a bit more in the process.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230921104220.GHZQweDKyaJmkYdt4f@fat_crate.local
---
 arch/x86/include/asm/cpu.h               |  2 +-
 arch/x86/kernel/cpu/microcode/amd.c      |  4 +---
 arch/x86/kernel/cpu/microcode/intel.c    | 12 +++---------
 arch/x86/kernel/cpu/microcode/internal.h |  2 +-
 4 files changed, 6 insertions(+), 14 deletions(-)

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
index 0f15e82a536c..5d1c2a716456 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -632,7 +632,7 @@ void reload_ucode_amd(unsigned int cpu)
 	}
 }
 
-static int collect_cpu_info_amd(int cpu, struct cpu_signature *csig)
+static void collect_cpu_info_amd(int cpu, struct cpu_signature *csig)
 {
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
@@ -650,8 +650,6 @@ static int collect_cpu_info_amd(int cpu, struct cpu_signature *csig)
 		uci->mc = p->data;
 
 	pr_info("CPU%d: patch_level=0x%08x\n", cpu, csig->rev);
-
-	return 0;
 }
 
 static enum ucode_state apply_microcode_amd(int cpu)
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 3817bb2ad6ac..0eff86a5ab8f 100644
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
@@ -363,7 +363,7 @@ static __init struct microcode_intel *get_microcode_blob(struct ucode_cpu_info *
 	if (!(cp.data && cp.size))
 		return NULL;
 
-	intel_collect_cpu_info(&uci->cpu_sig);
+	intel_collect_cpu_info(0, &uci->cpu_sig);
 
 	return scan_microcode(cp.data, cp.size, uci);
 }
@@ -424,12 +424,6 @@ void reload_ucode_intel(void)
 		apply_microcode_early(&uci);
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
@@ -592,7 +586,7 @@ static void finalize_late_load(int result)
 
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
2.42.0.rc0.25.ga82fb66fed25


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
