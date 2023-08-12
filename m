Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172D177A24E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 22:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjHLUG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 16:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjHLUG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 16:06:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EBB1BD8
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 13:05:59 -0700 (PDT)
Message-ID: <20230812195728.649375687@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691870346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=GDewIFngkCI+5WnVcXevrKcgDXFsMW2Rc1mq3io3ymU=;
        b=SzDZ/hMvJh/0Z3hzYNfiQofVDznOJ5EAz6wODCsS0ZcL/xbh6IACQFM76wJCpxEnFQ5UyQ
        KTH+DdnzGOJwklFpJP65q1JGtdf46PYLUpIht4rT4dpfyayX7zEHSsicsN6mUzQS0XJuk+
        HqCDXjtUnAk+9xvIsbcPLlvXlj9aqTrLudUH+wecGyS5Sg306WPEJqlYLPO24J3kr7d3ug
        HhT8IEokz3ovZAefQ5hdSk4LvVoVED7CC0XyrcUr1ofkQjnbb7ZQzxbExkxD5p/AJMO6ee
        YEaWIUPQmvEjv6SQbQZkc9eF3EWjbNDTkfHfqDWbm3ddTaCKaElfDMF9v9EJ4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691870346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=GDewIFngkCI+5WnVcXevrKcgDXFsMW2Rc1mq3io3ymU=;
        b=ADY0IDxh4OJy63obIP9ZvEn7D3GClq2W+0PU7mXfrmB4c1RyipkAOEEk9C/ysDaeDchW+1
        OdSJmMPhi432vgCg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V2 19/37] x86/microcode/intel: Reuse intel_cpu_collect_info()
References: <20230812194003.682298127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 12 Aug 2023 21:59:06 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No point for an almost duplicate function.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/kernel/cpu/microcode/intel.c |   16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -506,21 +506,7 @@ void reload_ucode_intel(void)
 
 static int collect_cpu_info(int cpu_num, struct cpu_signature *csig)
 {
-	struct cpuinfo_x86 *c = &cpu_data(cpu_num);
-	unsigned int val[2];
-
-	memset(csig, 0, sizeof(*csig));
-
-	csig->sig = cpuid_eax(0x00000001);
-
-	if ((c->x86_model >= 5) || (c->x86 > 6)) {
-		/* get processor flags from MSR 0x17 */
-		rdmsr(MSR_IA32_PLATFORM_ID, val[0], val[1]);
-		csig->pf = 1 << ((val[1] >> 18) & 7);
-	}
-
-	csig->rev = c->microcode;
-
+	intel_collect_cpu_info(csig);
 	return 0;
 }
 

