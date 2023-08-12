Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A57977A23D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 22:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjHLUAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 16:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjHLUAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 16:00:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189892694
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 13:00:12 -0700 (PDT)
Message-ID: <20230812195727.894165745@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691870326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=HkbGnsalnjpIVBAgAAwk1+ueDGPGU5QUbDMtasgxkkc=;
        b=3Wrbsk+vFhGxK+LHZPNwp3JtpGi4E+9ETLFpA1iCl8uy2i8oqjyW6//ubHKeOINGVCog/+
        2/jXUKJF8+o2jep/tiZZ+98pdnjx/3OkpsdkXgxr8Rlw/x2S0aUb+McOiaEFWyf/HOqrgC
        Bkqt9txXusOHpYJEJ+rm3j5BWbgU/QyPohX2UiHn4rZCl1ux6F0MQy5gvokQju4y84LMEh
        9kgqm0cvfxu3vT89AugYpsEmmHQJ+n2dA+FyV3P/lxniuZGSZqqYlvJBpuYF1PsWLLED+W
        AQXqouHDOqE3/sNxiq6TduRLcSTZZU83liNh2DeVXVPLXJwlO5jwc999DHdfjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691870326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=HkbGnsalnjpIVBAgAAwk1+ueDGPGU5QUbDMtasgxkkc=;
        b=R/VegE7EeRx1Vs4DStGliN0XCw4RTXbqLTxzErhqd2ace1KA8m+VztHHHquEgGYQymDEpL
        mBE6E7d+Ghy+a+Cw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V2 06/37] x86/microcode/intel: Rename get_datasize() since its
 used externally
References: <20230812194003.682298127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 12 Aug 2023 21:58:45 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ashok Raj <ashok.raj@intel.com>

Rename get_datasize() to intel_microcode_get_datasize() and make it an inline.

[ tglx: Make the argument typed and fix up the IFS code ]

Suggested-by: Boris Petkov <bp@alien8.de>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Make the argument typed
---
 arch/x86/include/asm/microcode_intel.h |    7 ++++---
 arch/x86/kernel/cpu/microcode/intel.c  |    8 ++++----
 drivers/platform/x86/intel/ifs/load.c  |    5 +++--
 3 files changed, 11 insertions(+), 9 deletions(-)
---
--- a/arch/x86/include/asm/microcode_intel.h
+++ b/arch/x86/include/asm/microcode_intel.h
@@ -26,9 +26,10 @@ struct microcode_intel {
 #define MC_HEADER_TYPE_IFS		2
 #define DEFAULT_UCODE_DATASIZE		(2000)
 
-#define get_datasize(mc) \
-	(((struct microcode_intel *)mc)->hdr.datasize ? \
-	 ((struct microcode_intel *)mc)->hdr.datasize : DEFAULT_UCODE_DATASIZE)
+static inline int intel_microcode_get_datasize(struct microcode_header_intel *hdr)
+{
+	return hdr->datasize ? : DEFAULT_UCODE_DATASIZE;
+}
 
 static inline u32 intel_get_microcode_revision(void)
 {
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -118,10 +118,10 @@ int intel_find_matching_signature(void *
 		return 1;
 
 	/* Look for ext. headers: */
-	if (get_totalsize(mc_hdr) <= get_datasize(mc_hdr) + MC_HEADER_SIZE)
+	if (get_totalsize(mc_hdr) <= intel_microcode_get_datasize(mc_hdr) + MC_HEADER_SIZE)
 		return 0;
 
-	ext_hdr = mc + get_datasize(mc_hdr) + MC_HEADER_SIZE;
+	ext_hdr = mc + intel_microcode_get_datasize(mc_hdr) + MC_HEADER_SIZE;
 	ext_sig = (void *)ext_hdr + EXT_HEADER_SIZE;
 
 	for (i = 0; i < ext_hdr->count; i++) {
@@ -156,7 +156,7 @@ int intel_microcode_sanity_check(void *m
 	struct extended_signature *ext_sig;
 
 	total_size = get_totalsize(mc_header);
-	data_size = get_datasize(mc_header);
+	data_size = intel_microcode_get_datasize(mc_header);
 
 	if (data_size + MC_HEADER_SIZE > total_size) {
 		if (print_err)
@@ -438,7 +438,7 @@ static void show_saved_mc(void)
 		date	= mc_saved_header->date;
 
 		total_size	= get_totalsize(mc_saved_header);
-		data_size	= get_datasize(mc_saved_header);
+		data_size	= intel_microcode_get_datasize(mc_saved_header);
 
 		pr_debug("mc_saved[%d]: sig=0x%x, pf=0x%x, rev=0x%x, total size=0x%x, date = %04x-%02x-%02x\n",
 			 i++, sig, pf, rev, total_size,
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -56,12 +56,13 @@ struct metadata_header {
 
 static struct metadata_header *find_meta_data(void *ucode, unsigned int meta_type)
 {
+	struct microcode_header_intel *hdr = &((struct microcode_intel *)ucode)->hdr;
 	struct metadata_header *meta_header;
 	unsigned long data_size, total_meta;
 	unsigned long meta_size = 0;
 
-	data_size = get_datasize(ucode);
-	total_meta = ((struct microcode_intel *)ucode)->hdr.metasize;
+	data_size = intel_microcode_get_datasize(hdr);
+	total_meta = hdr->metasize;
 	if (!total_meta)
 		return NULL;
 

