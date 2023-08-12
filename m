Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A49377A23B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 22:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjHLUAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 16:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjHLUAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 16:00:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5641FE6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 13:00:18 -0700 (PDT)
Message-ID: <20230812195728.188483733@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691870334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=UL/mdoYp2YOPutZME2dSUHU8tUoO072JwJbw3jCdJRc=;
        b=k196Gikce4bNi5roHHck82eFjbXLl9qvTM21pyAwgSV1PGVZpP68bSXUquAaTlo45GKi3b
        0D5+H5Upb40rc6ezn73UIpYOgu/M/gDP4JoYj0G4dN81V0dc6mwuIAG0uy6VYsvE4PRWok
        YtU2rUe4OA5EcN5lBn4YpodKCU6WWgxKUcMggfWKFjyPwAGQHd72WZlgJp2eOvIecTOBzi
        xET5TmbObUsnQlOd8HDXhVC8UlDymZm8Yy8I4rEjAnpqGMC8HUuXsGjOFuYokLWvIzRQmN
        KvbMjTNo4ijiWVxIkHFJ3Ac2egSkCcSnT5jW/UI4H2clluMxBvqF2oc+XcXIBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691870334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=UL/mdoYp2YOPutZME2dSUHU8tUoO072JwJbw3jCdJRc=;
        b=wYMXV8LdRz0zsOeaxUoMbnhf8qyYqy8Dpx2tC+1KmIkxAQI2AvQetjwn2uLa0ioUSVfAtW
        IxKPuVssEC4/bBCQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V2 11/37] x86/microcode/intel: Simplify scan_microcode()
References: <20230812194003.682298127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 12 Aug 2023 21:58:53 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it readable and comprehensible.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/microcode/intel.c |   28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -275,22 +275,16 @@ static void save_microcode_patch(void *d
 		intel_ucode_patch = (struct microcode_intel *)p;
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
@@ -298,27 +292,19 @@ scan_microcode(void *data, size_t size,
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

