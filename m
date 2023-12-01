Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD84801148
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378410AbjLAQjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjLAQjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:39:52 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647A2171C
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 08:39:43 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0EEBA40E025A;
        Fri,  1 Dec 2023 16:39:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SFJO8VbsFTpj; Fri,  1 Dec 2023 16:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701448777; bh=j1mkGY7BiHBR9Q1zCLyXvvovOXYQxD+zJvQOSgscW88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IB+IARNZwlDJriFT6Pm0+u+Ka4dB/Ut3KbdIvCFq7T12rKB8mzQnDWqjdmFpL3JzX
         Ln5tcFatsCzDt94AiAQ23mvWHqsQCse8KMP/02tPp6i0835vv0nLFECN/shvts3gwk
         OuOvlZdASXsqhhu8lpRRHwRMdktsace0mQGn1uHzPp103qOdyBmJdK8eT90cxVAR82
         Fnm80nUeen/ezqHe4quKebUed+VSCLm54Fl4S1EuAX19CTHsA07N5biRb8ppTPi2ex
         edInBc1o/pRL1v339JbQAgRRVMzglBHGONjmuxhenE6hBY1EMCuhzi2GFkt7cm491+
         Bh8Xy5rYCfQm8cxPGDXCpdB3oVJuKq8UhTDx8SZThcO/FvhV/AcnUNppnIR+7VEb3F
         Izkrv803E2w204Aez6uJBeTHLKZ5l/HciBGw9cULGYSSVmAzPhNWRDNam6iv3K369X
         L03hbAvTLqLBH3KccYVOrkDpS6SrZ1tjlRtNcb3UQ5LQQE3YIpTWpcoeekOOb/YuOx
         A72gyXEy27P4I7MDUa4VeLURO/x5oWwkR7AmuGpiA8p67/lPHBk1bT4yl7qkcNsYWu
         nHbYznMq9Uk5q1+UuH9EwbjQvbRp5ZQwCsL3VA1GYXV73GTnSFr4+HtPRY1lPKuJ3B
         UWWJcz2y9ww0wdDVbi5fW8K4=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C2FAC40E024E;
        Fri,  1 Dec 2023 16:39:33 +0000 (UTC)
Date:   Fri, 1 Dec 2023 17:39:28 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] x86/microcode: Rework early revisions reporting
Message-ID: <20231201163928.GCZWoMQNAAQSA9U12D@fat_crate.local>
References: <20231115210212.9981-1-bp@alien8.de>
 <20231115210212.9981-3-bp@alien8.de>
 <ZWjVt5dNRjbcvlzR@a4bf019067fa.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZWjVt5dNRjbcvlzR@a4bf019067fa.jf.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 10:34:31AM -0800, Ashok Raj wrote:
> new_rev is always assigned even if there was no microcode to apply.

That is wrong.

In my defence, I don't have an Intel machine which has up-to-date
microcode in the BIOS and the blob has the same microcode revision. All
my Intel test boxes do update microcode.

> - On AMD, the ucode is loaded even if the current revision matches what is
>   being loaded.

From the commit message of the patch you're replying to:

"What is also missing on the AMD side - something which people have
requested before - is showing the microcode revision the CPU had
*before* the early update."

The logic is, we want to dump before-after everytime there was
a successful early upload.

> Currently, it's displayed as below:
> 
> [  113.395868] microcode: Current revision: 0x21000170
> [  113.404244] microcode: Updated early from: 0x21000170

There's something else weird going on though. I would expect that that
machine should not update microcode if it cannot find newer. Maybe the
scan_microcode() logic is a bit weird still.

Please run this debug + fix patch and send me full dmesg from that
machine.

Thx.

---

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 070426b9895f..41d1a86287e6 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -267,10 +267,15 @@ static __init struct microcode_intel *scan_microcode(void *data, size_t size,
 	u32 cur_rev = uci->cpu_sig.rev;
 	unsigned int mc_size;
 
+	uc_dbg("cur_rev: 0x%x", cur_rev);
+
 	for (; size >= sizeof(struct microcode_header_intel); size -= mc_size, data += mc_size) {
 		mc_header = (struct microcode_header_intel *)data;
 
 		mc_size = get_totalsize(mc_header);
+
+		uc_dbg("mc_size: %d, size: %ld", mc_size, size);
+
 		if (!mc_size || mc_size > size ||
 		    intel_microcode_sanity_check(data, false, MC_HEADER_TYPE_MICROCODE) < 0)
 			break;
@@ -278,6 +283,8 @@ static __init struct microcode_intel *scan_microcode(void *data, size_t size,
 		if (!intel_find_matching_signature(data, &uci->cpu_sig))
 			continue;
 
+		uc_dbg("save: %d, mc_header->rev: 0x%x", save, mc_header->rev);
+
 		/*
 		 * For saving the early microcode, find the matching revision which
 		 * was loaded on the BSP.
@@ -296,6 +303,8 @@ static __init struct microcode_intel *scan_microcode(void *data, size_t size,
 		cur_rev = mc_header->rev;
 	}
 
+	uc_dbg("ret, size: %ld, patch: 0x%px", size, patch);
+
 	return size ? NULL : patch;
 }
 
@@ -370,13 +379,15 @@ static __init struct microcode_intel *get_microcode_blob(struct ucode_cpu_info *
 {
 	struct cpio_data cp;
 
+	intel_collect_cpu_info(&uci->cpu_sig);
+
 	if (!load_builtin_intel_microcode(&cp))
 		cp = find_microcode_in_initrd(ucode_path);
 
 	if (!(cp.data && cp.size))
 		return NULL;
-
-	intel_collect_cpu_info(&uci->cpu_sig);
+	else
+		uc_dbg("found cp");
 
 	return scan_microcode(cp.data, cp.size, uci, save);
 }
@@ -410,13 +421,19 @@ void __init load_ucode_intel_bsp(struct early_load_data *ed)
 {
 	struct ucode_cpu_info uci;
 
-	ed->old_rev = intel_get_microcode_revision();
-
 	uci.mc = get_microcode_blob(&uci, false);
-	if (uci.mc && apply_microcode_early(&uci) == UCODE_UPDATED)
+	ed->old_rev = uci.cpu_sig.rev;
+
+	uc_dbg("old_rev: 0x%x", ed->old_rev);
+
+	if (uci.mc && apply_microcode_early(&uci) == UCODE_UPDATED) {
 		ucode_patch_va = UCODE_BSP_LOADED;
+		ed->new_rev = uci.cpu_sig.rev;
+
+		uc_dbg("updated, new_rev: 0x%x", ed->new_rev);
+	}
 
-	ed->new_rev = uci.cpu_sig.rev;
+	uc_dbg("done");
 }
 
 void load_ucode_intel_ap(void)
diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
index 21776c529fa9..338607da51ec 100644
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -42,6 +42,9 @@ struct early_load_data {
 	u32 new_rev;
 };
 
+#define uc_dbg(fmt, args...)	\
+	pr_info("%s: " fmt "\n", __func__, ##args)
+
 extern struct early_load_data early_data;
 extern struct ucode_cpu_info ucode_cpu_info[];
 struct cpio_data find_microcode_in_initrd(const char *path);


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
