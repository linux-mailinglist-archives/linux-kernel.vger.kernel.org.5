Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D49E77A247
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 22:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjHLUAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 16:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjHLUAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 16:00:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED321998
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 13:00:13 -0700 (PDT)
Message-ID: <20230812195728.010895747@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691870329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=YMAsfYDkN/xyrOxScaRWZ72+V8OIVPbdwOmS7O9PF88=;
        b=FnwPzHlDjX8J6q6NC1rBCx2LHxi8MVSsf34AGjtxF7M4h0ndwkVseyWcRAzSejqzV+RsDM
        C1mbUZFE6+2JU9EDF4mtmkjDW595bjZR1YydQXUc3yQkN1HaINg1oNqZSyzTgUVM2b1xpR
        ldWED9X7LhnRFK5nokgtjYjre0JRLSdpFIUnLKnlJsbJX1G8T8VA9faqBtx9qIRMrEnYtn
        LT0zsD9ice8CdIYB1TKP3H6CCE5h133tWX/XmgCIj2twzCH50ce3gEUq2RCWFk+FTtlSHH
        4EnohddD19W0KrT8VYBn78OTtE79dtARbiz1Xa4SHXVtj7LX9kpVQPJ28we/1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691870329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=YMAsfYDkN/xyrOxScaRWZ72+V8OIVPbdwOmS7O9PF88=;
        b=m+3BwOa4D7AR1iptyHgfLAv/RkhXWwj3E+UBhzbBF/Zrw8VMbv7SAGxq5vH2XvomhSIjTR
        QGa4zVjeiMatZjBA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V2 08/37] x86/microcode/intel: Remove debug code
References: <20230812194003.682298127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 12 Aug 2023 21:58:49 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

This is really of dubious value.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Reordered in the series - Nikolay
---
 arch/x86/kernel/cpu/microcode/intel.c |   75 ----------------------------------
 1 file changed, 75 deletions(-)
---
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -10,15 +10,7 @@
  * Copyright (C) 2012 Fenghua Yu <fenghua.yu@intel.com>
  *		      H Peter Anvin" <hpa@zytor.com>
  */
-
-/*
- * This needs to be before all headers so that pr_debug in printk.h doesn't turn
- * printk calls into no_printk().
- *
- *#define DEBUG
- */
 #define pr_fmt(fmt) "microcode: " fmt
-
 #include <linux/earlycpio.h>
 #include <linux/firmware.h>
 #include <linux/uaccess.h>
@@ -405,69 +397,6 @@ scan_microcode(void *data, size_t size,
 	return patch;
 }
 
-static void show_saved_mc(void)
-{
-#ifdef DEBUG
-	int i = 0, j;
-	unsigned int sig, pf, rev, total_size, data_size, date;
-	struct ucode_cpu_info uci;
-	struct ucode_patch *p;
-
-	if (list_empty(&microcode_cache)) {
-		pr_debug("no microcode data saved.\n");
-		return;
-	}
-
-	intel_cpu_collect_info(&uci);
-
-	sig	= uci.cpu_sig.sig;
-	pf	= uci.cpu_sig.pf;
-	rev	= uci.cpu_sig.rev;
-	pr_debug("CPU: sig=0x%x, pf=0x%x, rev=0x%x\n", sig, pf, rev);
-
-	list_for_each_entry(p, &microcode_cache, plist) {
-		struct microcode_header_intel *mc_saved_header;
-		struct extended_sigtable *ext_header;
-		struct extended_signature *ext_sig;
-		int ext_sigcount;
-
-		mc_saved_header = (struct microcode_header_intel *)p->data;
-
-		sig	= mc_saved_header->sig;
-		pf	= mc_saved_header->pf;
-		rev	= mc_saved_header->rev;
-		date	= mc_saved_header->date;
-
-		total_size	= get_totalsize(mc_saved_header);
-		data_size	= intel_microcode_get_datasize(mc_saved_header);
-
-		pr_debug("mc_saved[%d]: sig=0x%x, pf=0x%x, rev=0x%x, total size=0x%x, date = %04x-%02x-%02x\n",
-			 i++, sig, pf, rev, total_size,
-			 date & 0xffff,
-			 date >> 24,
-			 (date >> 16) & 0xff);
-
-		/* Look for ext. headers: */
-		if (total_size <= data_size + MC_HEADER_SIZE)
-			continue;
-
-		ext_header = (void *)mc_saved_header + data_size + MC_HEADER_SIZE;
-		ext_sigcount = ext_header->count;
-		ext_sig = (void *)ext_header + EXT_HEADER_SIZE;
-
-		for (j = 0; j < ext_sigcount; j++) {
-			sig = ext_sig->sig;
-			pf = ext_sig->pf;
-
-			pr_debug("\tExtended[%d]: sig=0x%x, pf=0x%x\n",
-				 j, sig, pf);
-
-			ext_sig++;
-		}
-	}
-#endif
-}
-
 /*
  * Save this microcode patch. It will be loaded early when a CPU is
  * hot-added or resumes.
@@ -480,7 +409,6 @@ static void save_mc_for_early(struct uco
 	mutex_lock(&x86_cpu_microcode_mutex);
 
 	save_microcode_patch(uci, mc, size);
-	show_saved_mc();
 
 	mutex_unlock(&x86_cpu_microcode_mutex);
 }
@@ -631,9 +559,6 @@ int __init save_microcode_in_initrd_inte
 	intel_cpu_collect_info(&uci);
 
 	scan_microcode(cp.data, cp.size, &uci, true);
-
-	show_saved_mc();
-
 	return 0;
 }
 

