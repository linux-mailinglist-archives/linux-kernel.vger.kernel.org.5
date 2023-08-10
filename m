Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19509778060
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbjHJShz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235787AbjHJShs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:37:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C41E2D74
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:37:41 -0700 (PDT)
Message-ID: <20230810160805.480445927@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691692660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=NsQEXkcNoNxuKUz2vKM5ZkcygdUDo7qIvKrLGQRgzVQ=;
        b=loD3QjkxFRu/+68gQq0qnRAFfiF/7/WtzFxddoQlYwKp2TJv4BgHzP5xqzBebCn8NgkHJK
        HRdxd70jF12cMdXDJbEBMBAHpw/EnJizI7YJiEqo4oCOJRsXbXzGi4HLggZSHm42H6x8GU
        U0QuRim/Rhbj3M3Pd9EVTyYh1Tyn6YOYfDNpZ+y4J3IwMoxRQcuH316DdtJcsdIKSZSptw
        C122HfUkrVRE1eEbMtCO1xuBz2nIt82appMeqZuonf6cPpiPQDP6uZinJnsB8soJwDqOYC
        p269BO0Y9/B5ze1jwtzAQkuMWwYpUBrxwmJOlAz722njuZT0V9d631rjFQMsHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691692660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=NsQEXkcNoNxuKUz2vKM5ZkcygdUDo7qIvKrLGQRgzVQ=;
        b=txu9Rkoxph7z7u0csOyKi5Xxe8/LjbPvjEbvfU10II2kuvLO/+8ySpX/4kjr8bDzewJk9a
        23UmxMmT/9DdHmDg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: [patch 09/30] x86/microcode/intel: Remove debug code
References: <20230810153317.850017756@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 10 Aug 2023 20:37:39 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

This is really of dubious value.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/kernel/cpu/microcode/intel.c |   65 ----------------------------------
 1 file changed, 65 deletions(-)
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
@@ -310,59 +302,6 @@ scan_microcode(void *data, size_t size,
 	return patch;
 }
 
-static void show_saved_mc(void)
-{
-#ifdef DEBUG
-	unsigned int sig, pf, rev, total_size, data_size, date;
-	struct extended_sigtable *ext_header;
-	struct extended_signature *ext_sig;
-	struct ucode_cpu_info uci;
-	int j, ext_sigcount;
-
-	if (!intel_ucode_patch) {
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
-	sig	= intel_ucode_patch->hdr.sig;
-	pf	= intel_ucode_patch->hdr.pf;
-	rev	= intel_ucode_patch->hdr.rev;
-	date	= intel_ucode_patch->hdr.date;
-
-	total_size	= get_totalsize(mc_saved_header);
-	data_size	= intel_microcode_get_datasize(mc_saved_header);
-
-	pr_debug("mc_saved: sig=0x%x, pf=0x%x, rev=0x%x, total size=0x%x, date = %04x-%02x-%02x\n",
-		 sig, pf, rev, total_size, date & 0xffff,
-		 date >> 24, (date >> 16) & 0xff);
-
-	/* Look for ext. headers: */
-	if (total_size <= data_size + MC_HEADER_SIZE)
-		return;
-
-	ext_header = (void *)intel_ucode_patch + data_size + MC_HEADER_SIZE;
-	ext_sigcount = ext_header->count;
-	ext_sig = (void *)ext_header + EXT_HEADER_SIZE;
-
-	for (j = 0; j < ext_sigcount; j++) {
-		sig = ext_sig->sig;
-		pf = ext_sig->pf;
-
-		pr_debug("\tExtended[%d]: sig=0x%x, pf=0x%x\n",
-			 j, sig, pf);
-
-		ext_sig++;
-	}
-#endif
-}
-
 /*
  * Save this microcode patch. It will be loaded early when a CPU is
  * hot-added or resumes.
@@ -375,7 +314,6 @@ static void save_mc_for_early(struct uco
 	mutex_lock(&x86_cpu_microcode_mutex);
 
 	save_microcode_patch(mc, size);
-	show_saved_mc();
 
 	mutex_unlock(&x86_cpu_microcode_mutex);
 }
@@ -526,9 +464,6 @@ int __init save_microcode_in_initrd_inte
 	intel_cpu_collect_info(&uci);
 
 	scan_microcode(cp.data, cp.size, &uci, true);
-
-	show_saved_mc();
-
 	return 0;
 }
 

