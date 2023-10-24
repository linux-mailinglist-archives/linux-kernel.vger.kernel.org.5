Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADEE7D51A2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343573AbjJXNXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234588AbjJXNWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:22:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A88319AC;
        Tue, 24 Oct 2023 06:21:07 -0700 (PDT)
Date:   Tue, 24 Oct 2023 13:21:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698153666;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Os9nervEGesNBnaCxZVF2pLXxPzyMz+w9LD3FtcxP28=;
        b=OOeUeWTAhiQfa41rfwqXRRoSlpgtBCxhcqKCustsSpSoNYx1HcuBy8FqILDyxa1lxNKGgE
        dLXJJFkCrS7xMb+5B6vdvajFErfMEIZWGn9+VnG27upoAYZOt5yDZQ/QStG9GrTPXdDD/a
        qkavxHaaSMd9xPkl0HHvG7qBWsUgn6dDNn6NsACapiURebrJ2HbnDuFPQhSN3U0J2L4/2Z
        E1PVcRZUzqKTd66BAY3pjS/5z9sAF8uHf/8qwsWgvAcj9ybNsZcWp9JPMuKrk3Bz2VMsYO
        cjz2O1z7NxmUuaPxUkNaQJBZe0DIZcBxxmdYsr4dJfkshMuyPvXOItQvPIpGGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698153666;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Os9nervEGesNBnaCxZVF2pLXxPzyMz+w9LD3FtcxP28=;
        b=etDfPrBfb3hDAj64/q+Bq6QA7foOedLlGSkng7P2aPq1Aj/MSSbwZprVkrFO6HYb+oRSPO
        FgCtXQMO5htVTaBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/intel: Reuse intel_cpu_collect_info()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231002115902.741173606@linutronix.de>
References: <20231002115902.741173606@linutronix.de>
MIME-Version: 1.0
Message-ID: <169815366539.3135.421513578622495350.tip-bot2@tip-bot2>
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

Commit-ID:     11f96ac4c21e701650c7d8349b252973185ac6ce
Gitweb:        https://git.kernel.org/tip/11f96ac4c21e701650c7d8349b252973185ac6ce
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 02 Oct 2023 13:59:49 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 24 Oct 2023 15:05:54 +02:00

x86/microcode/intel: Reuse intel_cpu_collect_info()

No point for an almost duplicate function.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231002115902.741173606@linutronix.de
---
 arch/x86/kernel/cpu/microcode/intel.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 5aa7f5e..47a96c0 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -435,21 +435,7 @@ void reload_ucode_intel(void)
 
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
 
