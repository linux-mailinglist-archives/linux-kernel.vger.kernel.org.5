Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59B37D51A8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbjJXNXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234631AbjJXNWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:22:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B204119B2;
        Tue, 24 Oct 2023 06:21:08 -0700 (PDT)
Date:   Tue, 24 Oct 2023 13:21:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698153666;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vl2iqR/DQDtoMfEPN92JF37RP3wgC1B+K/xj/z9NzNY=;
        b=eo6qhSGY4zNGWRhhc1bSZ6jKzz44MNxYcucFZx+pKAm/LxG7hb7A3Ii4vVhTmqS+hGm42n
        7M8sFNNyD+pBDhzbQ5pEVGLWpvDNP3fPYyPGPpBI4kk/sWSZvpKCBNaNkIL/nVpSfY/ap+
        YE7JkLkDc2oIa8O4rAefg92i8zNZSS9chcmh+i7h8mnHJoUMf8kMybL/bFiUIUGpFvWQTA
        SSbi2AJW1BEJeiXKwSPYHggJe8mNiBkbcUvbLY3rSXp3kXosUquau+oxpS3vxyvw5l/d5y
        QJjIX/YdNfl6oKAorDA3rhpk+mo/l8N/sZLZT6wIsYzxxv67NqOR2hQd5one2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698153666;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vl2iqR/DQDtoMfEPN92JF37RP3wgC1B+K/xj/z9NzNY=;
        b=kJZ/qGxz+HZhQ7GyK6J9UbImEOGQUlHNmbdk5BSo1G68bP1H6ZKLWUHc9E1oJyi6UW2Afw
        TBjFuD291MdZEEBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/intel: Rework intel_cpu_collect_info()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231017211722.851573238@linutronix.de>
References: <20231017211722.851573238@linutronix.de>
MIME-Version: 1.0
Message-ID: <169815366596.3135.17179486205996306334.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     164aa1ca537238c46923ccacd8995b4265aee47b
Gitweb:        https://git.kernel.org/tip/164aa1ca537238c46923ccacd8995b4265aee47b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 17 Oct 2023 23:23:45 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 24 Oct 2023 15:05:53 +02:00

x86/microcode/intel: Rework intel_cpu_collect_info()

Nothing needs struct ucode_cpu_info. Make it take struct cpu_signature,
let it return a boolean and simplify the implementation. Rename it now
that the silly name clash with collect_cpu_info() is gone.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231017211722.851573238@linutronix.de
---
 arch/x86/include/asm/cpu.h            |  4 +--
 arch/x86/kernel/cpu/microcode/intel.c | 33 +++++++-------------------
 drivers/platform/x86/intel/ifs/load.c |  8 ++----
 3 files changed, 14 insertions(+), 31 deletions(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 25050d9..068a07e 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -71,9 +71,9 @@ static inline void init_ia32_feat_ctl(struct cpuinfo_x86 *c) {}
 
 extern __noendbr void cet_disable(void);
 
-struct ucode_cpu_info;
+struct cpu_signature;
 
-int intel_cpu_collect_info(struct ucode_cpu_info *uci);
+void intel_collect_cpu_info(struct cpu_signature *sig);
 
 static inline bool intel_cpu_signatures_match(unsigned int s1, unsigned int p1,
 					      unsigned int s2, unsigned int p2)
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 4235c95..5aa7f5e 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -68,36 +68,21 @@ static inline unsigned int exttable_size(struct extended_sigtable *et)
 	return et->count * EXT_SIGNATURE_SIZE + EXT_HEADER_SIZE;
 }
 
-int intel_cpu_collect_info(struct ucode_cpu_info *uci)
+void intel_collect_cpu_info(struct cpu_signature *sig)
 {
-	unsigned int val[2];
-	unsigned int family, model;
-	struct cpu_signature csig = { 0 };
-	unsigned int eax, ebx, ecx, edx;
-
-	memset(uci, 0, sizeof(*uci));
-
-	eax = 0x00000001;
-	ecx = 0;
-	native_cpuid(&eax, &ebx, &ecx, &edx);
-	csig.sig = eax;
+	sig->sig = cpuid_eax(1);
+	sig->pf = 0;
+	sig->rev = intel_get_microcode_revision();
 
-	family = x86_family(eax);
-	model  = x86_model(eax);
+	if (x86_model(sig->sig) >= 5 || x86_family(sig->sig) > 6) {
+		unsigned int val[2];
 
-	if (model >= 5 || family > 6) {
 		/* get processor flags from MSR 0x17 */
 		native_rdmsr(MSR_IA32_PLATFORM_ID, val[0], val[1]);
-		csig.pf = 1 << ((val[1] >> 18) & 7);
+		sig->pf = 1 << ((val[1] >> 18) & 7);
 	}
-
-	csig.rev = intel_get_microcode_revision();
-
-	uci->cpu_sig = csig;
-
-	return 0;
 }
-EXPORT_SYMBOL_GPL(intel_cpu_collect_info);
+EXPORT_SYMBOL_GPL(intel_collect_cpu_info);
 
 /*
  * Returns 1 if update has been found, 0 otherwise.
@@ -391,7 +376,7 @@ static __init struct microcode_intel *get_microcode_blob(struct ucode_cpu_info *
 	if (!(cp.data && cp.size))
 		return NULL;
 
-	intel_cpu_collect_info(uci);
+	intel_collect_cpu_info(&uci->cpu_sig);
 
 	return scan_microcode(cp.data, cp.size, uci, save);
 }
diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index cefd0d8..61174bd 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -227,7 +227,7 @@ out:
 
 static int image_sanity_check(struct device *dev, const struct microcode_header_intel *data)
 {
-	struct ucode_cpu_info uci;
+	struct cpu_signature sig;
 
 	/* Provide a specific error message when loading an older/unsupported image */
 	if (data->hdrver != MC_HEADER_TYPE_IFS) {
@@ -240,11 +240,9 @@ static int image_sanity_check(struct device *dev, const struct microcode_header_
 		return -EINVAL;
 	}
 
-	intel_cpu_collect_info(&uci);
+	intel_collect_cpu_info(&sig);
 
-	if (!intel_find_matching_signature((void *)data,
-					   uci.cpu_sig.sig,
-					   uci.cpu_sig.pf)) {
+	if (!intel_find_matching_signature((void *)data, sig.sig, sig.pf)) {
 		dev_err(dev, "cpu signature, processor flags not matching\n");
 		return -EINVAL;
 	}
