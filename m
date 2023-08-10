Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7372778062
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbjHJSiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235776AbjHJShw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:37:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5897A30E8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:37:44 -0700 (PDT)
Message-ID: <20230810160805.599721262@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691692662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=b/ELWliFBPnNte8vlpVCfRTqinp+om6shCPvsMqFYso=;
        b=tIDqRKtsAczC2vhSfOg9J4ElLqv9zAb4WvzrFXZc2m2+mDeV6zwRTyLHe4JzX1+htCAQKh
        sYGzX5kVQjNUTlUbppesPINgKiM1YjIHTLhmQp0grSO+69C7vk9/ESoA1Y1LhEaK1WGtGx
        aHJEZB6t3ZQMDhV2/HfUtF+940FPHXmdrvTawbP1rmc6Ve8RlcTIrK/quQ3uo3upARZPT3
        YFB1pM9V73Ni2m3XOUtHTH2BmxzjtawMMj2NTkIRY+5TNuIiC0N9BrvFE/Eb52DaC3cAMM
        kh09plQ4FVOdiY/5AgErzbWoVTlcYJxCGt9DsQ49Fu2/B/JfAAuMCZ4tyrlu4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691692662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=b/ELWliFBPnNte8vlpVCfRTqinp+om6shCPvsMqFYso=;
        b=kacb0RkVDEqsTXw8fDBnUowRs3bIY1HfbQ/cV7LDach52B1oymcv/xuKjcdZj0f5dCiG02
        ISP+yZuOoDBISLBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: [patch 11/30] x86/microcode/intel: Simplify scan_microcode()
References: <20230810153317.850017756@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 10 Aug 2023 20:37:42 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it readable and comprehensible.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/microcode/intel.c |   28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -247,22 +247,16 @@ static void save_microcode_patch(void *d
 		intel_ucode_patch = (struct microcode_intel *)p;
 }
 
-/*
- * Get microcode matching with BSP's model. Only CPUs with the same model as
- * BSP can stay in the platform.
- */
-static struct microcode_intel *
-scan_microcode(void *data, size_t size, struct ucode_cpu_info *uci, bool save)
+/* Scan CPIO for microcode matching the boot CPUs family, model, stepping */
+static struct microcode_intel *scan_microcode(void *data, size_t size,
+					      struct ucode_cpu_info *uci, bool save)
 {
 	struct microcode_header_intel *mc_header;
 	struct microcode_intel *patch = NULL;
 	u32 cur_rev = uci->cpu_sig.rev;
 	unsigned int mc_size;
 
-	while (size) {
-		if (size < sizeof(struct microcode_header_intel))
-			break;
-
+	for (; size >= sizeof(struct microcode_header_intel); size -= mc_size, data += mc_size) {
 		mc_header = (struct microcode_header_intel *)data;
 
 		mc_size = get_totalsize(mc_header);
@@ -270,27 +264,19 @@ scan_microcode(void *data, size_t size,
 		    intel_microcode_sanity_check(data, false, MC_HEADER_TYPE_MICROCODE) < 0)
 			break;
 
-		size -= mc_size;
-
-		if (!intel_find_matching_signature(data, uci->cpu_sig.sig,
-						   uci->cpu_sig.pf)) {
-			data += mc_size;
+		if (!intel_find_matching_signature(data, uci->cpu_sig.sig, uci->cpu_sig.pf))
 			continue;
-		}
 
 		/* BSP scan: Check whether there is newer microcode */
 		if (save && cur_rev >= mc_header->rev)
-			goto next;
+			continue;
 
 		/* Save scan: Check whether there is newer or matching microcode */
 		if (save && cur_rev != mc_header->rev)
-			goto next;
+			continue;
 
 		patch = data;
 		cur_rev = mc_header->rev;
-
-next:
-		data += mc_size;
 	}
 
 	if (size)

