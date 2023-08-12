Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9306777A245
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 22:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjHLUAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 16:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjHLUAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 16:00:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175CC199A
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 13:00:20 -0700 (PDT)
Message-ID: <20230812195728.246048244@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691870335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=f+UFwCEFZREA8XDdgjvWrupo4jQM3/zWUCG1oemkcwo=;
        b=tBHDKY+tOBlIDxBRXfTvn6gRLVPE+1zyPSKMD2HK6zaIDGqQ/UMDTZaUiQtzKoFZyMo7Yi
        JfzA0W78akWOqNIfyeRP4F+s1NQYbswnEVoJgADs3y/Ecmrm78E75ZLW3Ubqz7QzrOiljy
        iHVKprQ7RTYebqS5DjifrVzrhISJFUMLFVPJ/JSYg4I7MbjglGgtKglM5hOCZijx3J2dzz
        vMAG/v+pMgWIbtMAtJClQ5+bJGuwllJgAiTxDdoousGTsee2LkUQg4TrGIXiEnYVNosvlS
        k0ehEETEeCPoXpdlPHWAqjRddQ3ASW/RnEFtpfCyEJA6YvIp1CRDel8UI7955Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691870335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=f+UFwCEFZREA8XDdgjvWrupo4jQM3/zWUCG1oemkcwo=;
        b=8ITEq0BJT9vucr6VcxMCsL2vDO7dLp6zXiylsFC202BUMsn2qdTiZemMBuZPqHzp9gLVgp
        V0c/NdwFDaSoktCw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V2 12/37] x86/microcode/intel: Simplify and rename
 generic_load_microcode()
References: <20230812194003.682298127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 12 Aug 2023 21:58:55 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

so it becomes less obfuscated and rename it because there is nothing
generic about it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/microcode/intel.c |   47 ++++++++++++----------------------
 1 file changed, 17 insertions(+), 30 deletions(-)

--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -240,19 +240,6 @@ int intel_microcode_sanity_check(void *m
 }
 EXPORT_SYMBOL_GPL(intel_microcode_sanity_check);
 
-/*
- * Returns 1 if update has been found, 0 otherwise.
- */
-static int has_newer_microcode(void *mc, unsigned int csig, int cpf, int new_rev)
-{
-	struct microcode_header_intel *mc_hdr = mc;
-
-	if (mc_hdr->rev <= new_rev)
-		return 0;
-
-	return intel_find_matching_signature(mc, csig, cpf);
-}
-
 static void save_microcode_patch(void *data, unsigned int size)
 {
 	struct microcode_header_intel *p;
@@ -645,14 +632,12 @@ static enum ucode_state apply_microcode_
 	return ret;
 }
 
-static enum ucode_state generic_load_microcode(int cpu, struct iov_iter *iter)
+static enum ucode_state read_ucode_intel(int cpu, struct iov_iter *iter)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 	unsigned int curr_mc_size = 0, new_mc_size = 0;
-	enum ucode_state ret = UCODE_OK;
-	int new_rev = uci->cpu_sig.rev;
+	int cur_rev = uci->cpu_sig.rev;
 	u8 *new_mc = NULL, *mc = NULL;
-	unsigned int csig, cpf;
 
 	while (iov_iter_count(iter)) {
 		struct microcode_header_intel mc_header;
@@ -669,6 +654,7 @@ static enum ucode_state generic_load_mic
 			pr_err("error! Bad data in microcode data file (totalsize too small)\n");
 			break;
 		}
+
 		data_size = mc_size - sizeof(mc_header);
 		if (data_size > iov_iter_count(iter)) {
 			pr_err("error! Bad data in microcode data file (truncated file?)\n");
@@ -691,16 +677,17 @@ static enum ucode_state generic_load_mic
 			break;
 		}
 
-		csig = uci->cpu_sig.sig;
-		cpf = uci->cpu_sig.pf;
-		if (has_newer_microcode(mc, csig, cpf, new_rev)) {
-			vfree(new_mc);
-			new_rev = mc_header.rev;
-			new_mc  = mc;
-			new_mc_size = mc_size;
-			mc = NULL;	/* trigger new vmalloc */
-			ret = UCODE_NEW;
-		}
+		if (cur_rev >= mc_header.rev)
+			continue;
+
+		if (!intel_find_matching_signature(mc, uci->cpu_sig.sig, uci->cpu_sig.pf))
+			continue;
+
+		vfree(new_mc);
+		cur_rev = mc_header.rev;
+		new_mc  = mc;
+		new_mc_size = mc_size;
+		mc = NULL;
 	}
 
 	vfree(mc);
@@ -720,9 +707,9 @@ static enum ucode_state generic_load_mic
 	save_microcode_patch(new_mc, new_mc_size);
 
 	pr_debug("CPU%d found a matching microcode update with version 0x%x (current=0x%x)\n",
-		 cpu, new_rev, uci->cpu_sig.rev);
+		 cpu, cur_rev, uci->cpu_sig.rev);
 
-	return ret;
+	return UCODE_NEW;
 }
 
 static bool is_blacklisted(unsigned int cpu)
@@ -771,7 +758,7 @@ static enum ucode_state request_microcod
 	kvec.iov_base = (void *)firmware->data;
 	kvec.iov_len = firmware->size;
 	iov_iter_kvec(&iter, ITER_SOURCE, &kvec, 1, firmware->size);
-	ret = generic_load_microcode(cpu, &iter);
+	ret = read_ucode_intel(cpu, &iter);
 
 	release_firmware(firmware);
 

