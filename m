Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840107BDC04
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376415AbjJIMbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376479AbjJIMaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:30:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2D0E4;
        Mon,  9 Oct 2023 05:29:57 -0700 (PDT)
Date:   Mon, 09 Oct 2023 12:29:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696854595;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bhfqCckWvnV/j5byneENoHX8ZYayJ0wGsSvFwyrW12Y=;
        b=zvqGo0u+eKQsDfGt3QyAOyt5dyWHdNA6HzMrL70qwb9bD6mKMumJZ+rXnUAgVCGxBzHQXL
        dyJh/QWaQ+Py/2+mF9YS/60x20iZxUMBiV8h99R7542aLCvwZu2xTJ2Xd6EG+ZNQQ9EKvL
        ETYyycbHDRq9wkqdgR+JRklVAx1Zpm0LNuviOaPvZDlxubQLgo+ZGn8q8DENRoh0yS4Wvf
        SWv+5WclVQyA+kmI+9Lk9pWD47m24faU0BeIxM5Y7C77P7cdoprBocwgmqZwQplQeNgt//
        sR11V2TvnA0HG9c+bUyMgqhbfa5amBLksBz0mFEMJz7eYTy861ZryjGRLDcJOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696854595;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bhfqCckWvnV/j5byneENoHX8ZYayJ0wGsSvFwyrW12Y=;
        b=GaQn+Owa4Ys+BdrKBWkJHNnBNc9wBjyNEkWEKRxKS7hazkurNKDkBZM3cN8QD5ESYAIuHB
        W55hN8jol8VWWqDQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/intel: Simplify scan_microcode()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231002115902.271940980@linutronix.de>
References: <20231002115902.271940980@linutronix.de>
MIME-Version: 1.0
Message-ID: <169685459534.3135.9973581340812617063.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     6a92484124b21e24aaa04be33fc4938f42d56733
Gitweb:        https://git.kernel.org/tip/6a92484124b21e24aaa04be33fc4938f42d56733
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 02 Oct 2023 13:59:39 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 02 Oct 2023 18:30:44 +02:00

x86/microcode/intel: Simplify scan_microcode()

Make it readable and comprehensible.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231002115902.271940980@linutronix.de
---
 arch/x86/kernel/cpu/microcode/intel.c | 28 ++++++--------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 1f45f5c..24dd483 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -268,22 +268,16 @@ static void save_microcode_patch(void *data, unsigned int size)
 	intel_ucode_patch = (struct microcode_intel *)p;
 }
 
-/*
- * Get microcode matching with BSP's model. Only CPUs with the same model as
- * BSP can stay in the platform.
- */
-static struct microcode_intel *
-scan_microcode(void *data, size_t size, struct ucode_cpu_info *uci, bool save)
+/* Scan CPIO for microcode matching the boot CPU's family, model, stepping */
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
@@ -291,27 +285,19 @@ scan_microcode(void *data, size_t size, struct ucode_cpu_info *uci, bool save)
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
 		if (!save && cur_rev >= mc_header->rev)
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
