Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D026A778061
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235816AbjHJSiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235806AbjHJSht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:37:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D2130D3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:37:42 -0700 (PDT)
Message-ID: <20230810160805.542014725@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691692661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=22EAgAQ5hctFTD7Flcc/WpTEDSRyz3fGpB62K9c30Ls=;
        b=ZV9uKay54yhb+9jIfG7Z6HNyXcv5qd9JYLRkb0SZnvwjK9U8FWtdKsZgRAgKqSe5KoGj2W
        4TDaWbPzeykcWTnBx7VTRsYqr0Xlr4zhCsmyEXoXhxmKnWiqqux6FRm7wqvAeIUIOcVrEV
        5Zb+m5F6DLXfYQJFv35lGL2SevYQ4xGfMQ7BUeUx+0WVh0q3OK9UjrPAMKllnziHzzRjJl
        vS43ogRGB/jjJvnCdsli1zmRna5wbVgDlM0mGoK3/O8YdoE0f1GV5uZ/607Mjy+5TK51+P
        elpCIgICbP2yEcpZmUciZfjGHv4iwfBWUhJ0qKDKOs84mBjeoAL/d35nIdP+pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691692661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=22EAgAQ5hctFTD7Flcc/WpTEDSRyz3fGpB62K9c30Ls=;
        b=p5TOZc1N8+e8kOwKjz5EtKtYSgEvfYpIeO2GibjgHyZ4whSptQAaIv+JanCbaGSCule4nb
        lzaogf0zP3m5gZDA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: [patch 10/30] x86/microcode: Remove pointless mutex
References: <20230810153317.850017756@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 10 Aug 2023 20:37:40 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

There is no concurreny.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/kernel/cpu/microcode/intel.c |   24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)
---
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -302,22 +302,6 @@ scan_microcode(void *data, size_t size,
 	return patch;
 }
 
-/*
- * Save this microcode patch. It will be loaded early when a CPU is
- * hot-added or resumes.
- */
-static void save_mc_for_early(struct ucode_cpu_info *uci, u8 *mc, unsigned int size)
-{
-	/* Synchronization during CPU hotplug. */
-	static DEFINE_MUTEX(x86_cpu_microcode_mutex);
-
-	mutex_lock(&x86_cpu_microcode_mutex);
-
-	save_microcode_patch(mc, size);
-
-	mutex_unlock(&x86_cpu_microcode_mutex);
-}
-
 static bool load_builtin_intel_microcode(struct cpio_data *cp)
 {
 	unsigned int eax = 1, ebx, ecx = 0, edx;
@@ -718,12 +702,8 @@ static enum ucode_state generic_load_mic
 	vfree(uci->mc);
 	uci->mc = (struct microcode_intel *)new_mc;
 
-	/*
-	 * If early loading microcode is supported, save this mc into
-	 * permanent memory. So it will be loaded early when a CPU is hot added
-	 * or resumes.
-	 */
-	save_mc_for_early(uci, new_mc, new_mc_size);
+	/* Save for CPU hotplug */
+	save_microcode_patch(new_mc, new_mc_size);
 
 	pr_debug("CPU%d found a matching microcode update with version 0x%x (current=0x%x)\n",
 		 cpu, new_rev, uci->cpu_sig.rev);

