Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E177F84FE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 20:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346124AbjKXT6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 14:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbjKXT6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 14:58:15 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EC410F6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 11:58:19 -0800 (PST)
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7AC9E1FE92;
        Fri, 24 Nov 2023 19:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1700855897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:  in-reply-to:in-reply-to;
        bh=DjYte/Mctgmrrgkn7xRs0TNg9KtN5CCgmihnS5E7cF0=;
        b=x3vw6TRKweflrN4jq3gzp3J9Tztzz4CQziwkjFOyLDOcJMkJCYreg4s0xWi6VQBNZeKtQ/
        /y26yDCppJ10wNdUceaJ2b8ActKsmL0moHrpyWywvWA/YiBLe7qp5YVzYxMJXvA0Ctjnrd
        CSXJSi/gSxWqbPoJN0SthoNqDQJ47M4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1700855897;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:  in-reply-to:in-reply-to;
        bh=DjYte/Mctgmrrgkn7xRs0TNg9KtN5CCgmihnS5E7cF0=;
        b=Ck8OiKFWRsiMDMq2mcW+F9tuCIjeoPI8IvWNGjGnlf1WtSRe2LqBreR/KPm80RPA57LvsH
        I+m8Wr0EkGTW1UDw==
Received: from localhost (dwarf.suse.cz [10.100.12.32])
        by relay2.suse.de (Postfix) with ESMTP id 8DC052C145;
        Fri, 24 Nov 2023 19:58:16 +0000 (UTC)
Date:   Fri, 24 Nov 2023 20:58:16 +0100
From:   Jiri Bohac <jbohac@suse.cz>
To:     Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.cz
Subject: [PATCH 3/4] kdump, x86: implement crashkernel CMA reservation
Message-ID: <ZWEAWMJtesa3O9M5@dwarf.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWD_fAPqEWkFlEkM@dwarf.suse.cz>
X-Spamd-Bar: +++++++++++++
X-Spam-Score: 13.49
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: 7AC9E1FE92
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        dmarc=none;
        spf=pass (smtp-out2.suse.de: domain of jbohac@suse.cz designates 149.44.160.134 as permitted sender) smtp.mailfrom=jbohac@suse.cz
X-Spamd-Result: default: False [13.49 / 50.00];
         RDNS_NONE(1.00)[];
         SPAMHAUS_XBL(0.00)[149.44.160.134:from];
         TO_DN_SOME(0.00)[];
         R_SPF_ALLOW(-0.20)[+ip4:149.44.0.0/16:c];
         RWL_MAILSPIKE_GOOD(-1.00)[149.44.160.134:from];
         HFILTER_HELO_IP_A(1.00)[relay2.suse.de];
         HFILTER_HELO_NORES_A_OR_MX(0.30)[relay2.suse.de];
         RCPT_COUNT_FIVE(0.00)[6];
         MID_RHS_MATCH_FROMTLD(0.00)[];
         MX_GOOD(-0.01)[];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         RDNS_DNSFAIL(0.00)[];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         NEURAL_SPAM_SHORT(3.00)[1.000];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(1.20)[suse.cz];
         TO_MATCH_ENVRCPT_SOME(0.00)[];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_SPAM_LONG(3.50)[1.000];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         RCVD_COUNT_TWO(0.00)[2];
         HFILTER_HOSTNAME_UNKNOWN(2.50)[]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the crashkernel CMA reservation for x86:
- enable parsing of the cma suffix by parse_crashkernel()
- reserve memory with reserve_crashkernel_cma()
- add the CMA-reserved ranges to the e820 map for the crash kernel
- exclude the CMA-reserved ranges from vmcore

Signed-off-by: Jiri Bohac <jbohac@suse.cz>

---
 arch/x86/kernel/crash.c | 26 ++++++++++++++++++++++----
 arch/x86/kernel/setup.c |  5 +++--
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index c92d88680dbf..f27d09386157 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -147,10 +147,10 @@ static struct crash_mem *fill_up_crash_elf_data(void)
 		return NULL;
 
 	/*
-	 * Exclusion of crash region and/or crashk_low_res may cause
-	 * another range split. So add extra two slots here.
+	 * Exclusion of crash region, crashk_low_res and/or crashk_cma_ranges
+	 * may cause range splits. So add extra slots here.
 	 */
-	nr_ranges += 2;
+	nr_ranges += 2 + crashk_cma_cnt;
 	cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
 	if (!cmem)
 		return NULL;
@@ -168,6 +168,7 @@ static struct crash_mem *fill_up_crash_elf_data(void)
 static int elf_header_exclude_ranges(struct crash_mem *cmem)
 {
 	int ret = 0;
+	int i;
 
 	/* Exclude the low 1M because it is always reserved */
 	ret = crash_exclude_mem_range(cmem, 0, (1<<20)-1);
@@ -182,8 +183,17 @@ static int elf_header_exclude_ranges(struct crash_mem *cmem)
 	if (crashk_low_res.end)
 		ret = crash_exclude_mem_range(cmem, crashk_low_res.start,
 					      crashk_low_res.end);
+	if (ret)
+		return ret;
 
-	return ret;
+	for (i = 0; i < crashk_cma_cnt; ++i) {
+		ret = crash_exclude_mem_range(cmem, crashk_cma_ranges[i].start,
+					      crashk_cma_ranges[i].end);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
@@ -336,6 +346,14 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 		add_e820_entry(params, &ei);
 	}
 
+	for (i = 0; i < crashk_cma_cnt; ++i) {
+		ei.addr = crashk_cma_ranges[i].start;
+		ei.size = crashk_cma_ranges[i].end -
+			  crashk_cma_ranges[i].start + 1;
+		ei.type = E820_TYPE_RAM;
+		add_e820_entry(params, &ei);
+	}
+
 out:
 	vfree(cmem);
 	return ret;
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index f271b2cc3054..5994d18fd2a0 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -468,7 +468,7 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 
 static void __init arch_reserve_crashkernel(void)
 {
-	unsigned long long crash_base, crash_size, low_size = 0;
+	unsigned long long crash_base, crash_size, low_size = 0, cma_size = 0;
 	char *cmdline = boot_command_line;
 	bool high = false;
 	int ret;
@@ -478,7 +478,7 @@ static void __init arch_reserve_crashkernel(void)
 
 	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
 				&crash_size, &crash_base,
-				&low_size, NULL, &high);
+				&low_size, &cma_size, &high);
 	if (ret)
 		return;
 
@@ -489,6 +489,7 @@ static void __init arch_reserve_crashkernel(void)
 
 	reserve_crashkernel_generic(cmdline, crash_size, crash_base,
 				    low_size, high);
+	reserve_crashkernel_cma(cma_size);
 }
 
 static struct resource standard_io_resources[] = {

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia

