Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D087377A249
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 22:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjHLUAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 16:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjHLUAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 16:00:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A067D19B1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 13:00:12 -0700 (PDT)
Message-ID: <20230812195727.834943153@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691870324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=0JPnaj3cEEDg9kfAdYzRsElPoyj/8+m1dAg/elVKOy0=;
        b=Cpy7aC46miOVTHIsx8AMnGaz4vl9e31PYlTHNUwmUrtp1PL8lAMkPR/xbqeBIlqVH3gyq4
        hBfcA96ShVOwRls8eNNGZq9YGHGkCEvsZ4oGkWspXmQBXrhpyaK6eBi/maHZfI73OgSGgp
        xRO/gole9NdyF3azRYIz63rP4CURwFPhvSYzybuVazmyq1vGPq9jBT6EX4wEPSDcFJvsT7
        YePJkwu2RZnPI12/ZAHSxfZBxlJF35vOHKUgUes/4I//FmbmfC6jchc24tnGBVf7dBVJ3N
        8BSmfJ1ss7UNiJGg6qglJ3p0YGJH8DVnLBUCmxjDa3BwndKGniMAVPh5VtG7SQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691870324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=0JPnaj3cEEDg9kfAdYzRsElPoyj/8+m1dAg/elVKOy0=;
        b=tUiD6WHEtqk3fwz0Ew5KFRxAVreg9Q8aa84y+XILH30l9uYgqOHKCxaTO9CE5OXQdiwjYX
        8RkxvSVw5NpSBfAA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V2 05/37] x86/microcode: Make reload_early_microcode() static
References: <20230812194003.682298127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 12 Aug 2023 21:58:44 +0200 (CEST)
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

fe055896c040 ("x86/microcode: Merge the early microcode loader") left this
needlessly public. Git archaeology provided by Borislav.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/include/asm/microcode.h     |    2 --
 arch/x86/kernel/cpu/microcode/core.c |    2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)
---
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -128,13 +128,11 @@ static inline unsigned int x86_cpuid_fam
 #ifdef CONFIG_MICROCODE
 extern void __init load_ucode_bsp(void);
 extern void load_ucode_ap(void);
-void reload_early_microcode(unsigned int cpu);
 extern bool initrd_gone;
 void microcode_bsp_resume(void);
 #else
 static inline void __init load_ucode_bsp(void)			{ }
 static inline void load_ucode_ap(void)				{ }
-static inline void reload_early_microcode(unsigned int cpu)	{ }
 static inline void microcode_bsp_resume(void)			{ }
 #endif
 
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -293,7 +293,7 @@ struct cpio_data find_microcode_in_initr
 #endif
 }
 
-void reload_early_microcode(unsigned int cpu)
+static void reload_early_microcode(unsigned int cpu)
 {
 	int vendor, family;
 

