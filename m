Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC5177805C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235713AbjHJShn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235651AbjHJShh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:37:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8386271F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:37:36 -0700 (PDT)
Message-ID: <20230810160805.306362600@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691692655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=kRzAe5D8Ty6sdUSFrz8caC1tS6s07rg/biNnW6lm4Xo=;
        b=tAbFx+gV3dAAHxeTR4TlThnMhnMCtMRpsn3cXur0T2ngyjccq37C4jGQQdrYuIwGLCZh8W
        ddoIABweZs4SvBK4oR/eqeu/sgu/TbLBFeaDL1+8cyXxxfsmwchApYHYcpDBSkFpUT7dwn
        UrYmUxQSGIsYnGWGKzGOQG82+85si91fdMKvdYJj8pq6MvGX0JVQEO4jca3qqVdbWdDhmz
        fmQGXOK0n0H04HB4eHdaBXzZFZdKR+WkWAHPxHP1N563Ia2ZaiFhMBpr/V2yCCUS0xhNMM
        1vFgKQLyJPR0JZ3b9ruqSkzCbxOzrGa0z7AOI1EFh9E70i8SZFCOKy0OfIfobQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691692655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=kRzAe5D8Ty6sdUSFrz8caC1tS6s07rg/biNnW6lm4Xo=;
        b=JfQwejENl+HSQeeJLCgU887lBpSDkBcpEegiD5ON07Jd+md53E4XWRrZiBI/NCbLX+vyTF
        eCAnbKDJU2wW1bCw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: [patch 06/30] x86/microcode/intel: Rename get_datasize() since its
 used externally
References: <20230810153317.850017756@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 10 Aug 2023 20:37:35 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ashok Raj <ashok.raj@intel.com>

Rename get_datasize() to intel_microcode_get_datasize() and make it an inline.

Suggested-by: Boris Petkov <bp@alien8.de>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/include/asm/microcode_intel.h |    9 ++++++---
 arch/x86/kernel/cpu/microcode/intel.c  |    8 ++++----
 drivers/platform/x86/intel/ifs/load.c  |    2 +-
 3 files changed, 11 insertions(+), 8 deletions(-)
---
--- a/arch/x86/include/asm/microcode_intel.h
+++ b/arch/x86/include/asm/microcode_intel.h
@@ -48,9 +48,12 @@ struct extended_sigtable {
 	 ((struct microcode_intel *)mc)->hdr.totalsize : \
 	 DEFAULT_UCODE_TOTALSIZE)
 
-#define get_datasize(mc) \
-	(((struct microcode_intel *)mc)->hdr.datasize ? \
-	 ((struct microcode_intel *)mc)->hdr.datasize : DEFAULT_UCODE_DATASIZE)
+static inline int intel_microcode_get_datasize(void *data)
+{
+	struct microcode_intel *mc = data;
+
+	return mc->hdr.datasize ? : DEFAULT_UCODE_DATASIZE;
+}
 
 #define exttable_size(et) ((et)->count * EXT_SIGNATURE_SIZE + EXT_HEADER_SIZE)
 
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -90,10 +90,10 @@ int intel_find_matching_signature(void *
 		return 1;
 
 	/* Look for ext. headers: */
-	if (get_totalsize(mc_hdr) <= get_datasize(mc_hdr) + MC_HEADER_SIZE)
+	if (get_totalsize(mc_hdr) <= intel_microcode_get_datasize(mc_hdr) + MC_HEADER_SIZE)
 		return 0;
 
-	ext_hdr = mc + get_datasize(mc_hdr) + MC_HEADER_SIZE;
+	ext_hdr = mc + intel_microcode_get_datasize(mc_hdr) + MC_HEADER_SIZE;
 	ext_sig = (void *)ext_hdr + EXT_HEADER_SIZE;
 
 	for (i = 0; i < ext_hdr->count; i++) {
@@ -128,7 +128,7 @@ int intel_microcode_sanity_check(void *m
 	struct extended_signature *ext_sig;
 
 	total_size = get_totalsize(mc_header);
-	data_size = get_datasize(mc_header);
+	data_size = intel_microcode_get_datasize(mc_header);
 
 	if (data_size + MC_HEADER_SIZE > total_size) {
 		if (print_err)
@@ -410,7 +410,7 @@ static void show_saved_mc(void)
 		date	= mc_saved_header->date;
 
 		total_size	= get_totalsize(mc_saved_header);
-		data_size	= get_datasize(mc_saved_header);
+		data_size	= intel_microcode_get_datasize(mc_saved_header);
 
 		pr_debug("mc_saved[%d]: sig=0x%x, pf=0x%x, rev=0x%x, total size=0x%x, date = %04x-%02x-%02x\n",
 			 i++, sig, pf, rev, total_size,
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -60,7 +60,7 @@ static struct metadata_header *find_meta
 	unsigned long data_size, total_meta;
 	unsigned long meta_size = 0;
 
-	data_size = get_datasize(ucode);
+	data_size = intel_microcode_get_datasize(ucode);
 	total_meta = ((struct microcode_intel *)ucode)->hdr.metasize;
 	if (!total_meta)
 		return NULL;

