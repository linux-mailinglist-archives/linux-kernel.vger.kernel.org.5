Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E7A79C8D6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjILH6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjILH5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:57:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895B910CB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:57:51 -0700 (PDT)
Message-ID: <20230912065501.009527288@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694505470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=sOJ+sRQt3nfyL5UePtEvx89xEa11XaUFA1X2Va9tGj4=;
        b=VC+m64f1NSEghCidAPnUeMhh72xF1UtXYpCyT9SE1Bo0ntnBG1TqEFhierCGKqxcyj+51j
        UTntDrbqA0yBnyI7+bKdDSCVdGGLWOOgGAq5kg+ru4MPIRVga1rFgl+r+kn1xF2DKoXPdB
        CTeSfFDbTzdBgUL7Anet+F24sHVUft7mfyiuAjHZxF1eFBKYLpfhrSf4LY82IdWK4CesNc
        7P+ueJ4JvJD/s2xZYAIFYOxZTcaQLIlWcUT3sxCWSXVWQmlWbowe7tNZMQ4+u8iVkHb/HW
        BF73iMkVYZyR4/El/5obBGSF9zlj4PiOVqfpq/dupV19+gMLmEa9A9HtpeL5PQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694505470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=sOJ+sRQt3nfyL5UePtEvx89xEa11XaUFA1X2Va9tGj4=;
        b=OLeVeCJtmnPOW04+SrRKrohKMyDny6DsczrcxlMaK4d8/78mD/GpeRwU53uQeB1Uq9tf9Q
        vbXz5SrLR0ZfKYBA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V3 04/30] x86/microcode/intel: Simplify scan_microcode()
References: <20230912065249.695681286@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 12 Sep 2023 09:57:49 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it readable and comprehensible.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/microcode/intel.c |   30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -265,25 +265,19 @@ static void save_microcode_patch(void *d
 		return;
 
 	/* Save for early loading */
-	intel_ucode_patch = (struct microcode_intel *)p;
+		intel_ucode_patch = (struct microcode_intel *)p;
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
@@ -291,27 +285,19 @@ scan_microcode(void *data, size_t size,
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

