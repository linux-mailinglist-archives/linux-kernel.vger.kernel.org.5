Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322FC79C8D7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjILH6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbjILH55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:57:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5241110C7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:57:53 -0700 (PDT)
Message-ID: <20230912065501.070512232@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694505471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=CN2QFAx6JB0LSmuYjwWY54K/mbyCNDPxFixGJ6298Ak=;
        b=uAr8WVy1xauXNH5nuhSyal+A8QHgW32mnXLnA8qqj9qnC/tW9q7qyPd+kr64cS8xNJF9pO
        SdClBiuM/6yKRIXuoqQpL37qxmzZ3PRxQKEqrn9873CQUSPZA/UOcjbqF2PbvZ+3eUUny7
        YhPFv6ByF/mMmiklzweM+2SaiQsewpJ6Srb6g0uSjovyiOXxU22nkAC6ojDxf0UDJB3flZ
        hwiuOqfqe+eIBAMRbjJ71EETLbzn9PmmB/fd81uPfCrp1XKXkb3UD8ryBxq8L7XG2baqkW
        KXqKfSE/9l5J+kzo1KI5m2jy72nZwN9S17rZUN9h/DJDqMg+ZuEQhz7UA3IDGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694505471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=CN2QFAx6JB0LSmuYjwWY54K/mbyCNDPxFixGJ6298Ak=;
        b=6nRRBNKGK0sJ+MDapmUWy//UBZFo5Reef+ccpmE7+rXMuOYlFA9VWYhObWgDhqNvxqSnBA
        kr4oMi2/mD8HJTCA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V3 05/30] x86/microcode/intel: Simplify and rename
 generic_load_microcode()
References: <20230912065249.695681286@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 12 Sep 2023 09:57:51 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

so it becomes less obfuscated and rename it because there is nothing
generic about it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: Rename to parse_microcode_blobs() - Borislav
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
@@ -561,14 +548,12 @@ static enum ucode_state apply_microcode_
 	return ret;
 }
 
-static enum ucode_state generic_load_microcode(int cpu, struct iov_iter *iter)
+static enum ucode_state parse_microcode_blobs(int cpu, struct iov_iter *iter)
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
@@ -585,6 +570,7 @@ static enum ucode_state generic_load_mic
 			pr_err("error! Bad data in microcode data file (totalsize too small)\n");
 			break;
 		}
+
 		data_size = mc_size - sizeof(mc_header);
 		if (data_size > iov_iter_count(iter)) {
 			pr_err("error! Bad data in microcode data file (truncated file?)\n");
@@ -607,16 +593,17 @@ static enum ucode_state generic_load_mic
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
@@ -636,9 +623,9 @@ static enum ucode_state generic_load_mic
 	save_microcode_patch(new_mc, new_mc_size);
 
 	pr_debug("CPU%d found a matching microcode update with version 0x%x (current=0x%x)\n",
-		 cpu, new_rev, uci->cpu_sig.rev);
+		 cpu, cur_rev, uci->cpu_sig.rev);
 
-	return ret;
+	return UCODE_NEW;
 }
 
 static bool is_blacklisted(unsigned int cpu)
@@ -687,7 +674,7 @@ static enum ucode_state request_microcod
 	kvec.iov_base = (void *)firmware->data;
 	kvec.iov_len = firmware->size;
 	iov_iter_kvec(&iter, ITER_SOURCE, &kvec, 1, firmware->size);
-	ret = generic_load_microcode(cpu, &iter);
+	ret = parse_microcode_blobs(cpu, &iter);
 
 	release_firmware(firmware);
 

