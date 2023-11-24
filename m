Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009287F84FB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 20:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjKXT5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 14:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjKXT5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 14:57:46 -0500
X-Greylist: delayed 193 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Nov 2023 11:57:52 PST
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C721710F6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 11:57:52 -0800 (PST)
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 469591FE89;
        Fri, 24 Nov 2023 19:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1700855871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:  in-reply-to:in-reply-to;
        bh=W/fT1pLSNri41feNsUCmL949IgVkjP0z0mkUiKdBhCw=;
        b=GyCU9aqNKGMA1KdMC57xu14BtLdrUQSTPKe20/CvTYCk74TbAQZKm2diGqUl6kJ9uoh+AZ
        0lPJzJFYCZ3VJ7qTMZOELCbZXaXNqheKH5/m6F1L6oKEqYo0NwYUPE7VTrCJLrG33lvYI/
        wY5KvEnmClnS0SQ5rRRy2kZGlm5RaSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1700855871;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:  in-reply-to:in-reply-to;
        bh=W/fT1pLSNri41feNsUCmL949IgVkjP0z0mkUiKdBhCw=;
        b=BquKKDNfVhyNnLh2p64LgZzw/GK7mILivQI74biCSPeKBsjmm4iDFIjwm+C7BHkVOBXLLw
        m/2XTBZVbZDkqIAQ==
Received: from localhost (dwarf.suse.cz [10.100.12.32])
        by relay2.suse.de (Postfix) with ESMTP id 700D72C145;
        Fri, 24 Nov 2023 19:57:49 +0000 (UTC)
Date:   Fri, 24 Nov 2023 20:57:49 +0100
From:   Jiri Bohac <jbohac@suse.cz>
To:     Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.cz
Subject: [PATCH 1/4] kdump: add crashkernel cma suffix
Message-ID: <ZWEAPXiCCgAf1WrY@dwarf.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWD_fAPqEWkFlEkM@dwarf.suse.cz>
X-Spamd-Bar: ++++++++++++++++++
X-Spam-Score: 18.59
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: 469591FE89
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        dmarc=none;
        spf=pass (smtp-out2.suse.de: domain of jbohac@suse.cz designates 149.44.160.134 as permitted sender) smtp.mailfrom=jbohac@suse.cz
X-Spamd-Result: default: False [18.59 / 50.00];
         RDNS_NONE(1.00)[];
         BAYES_SPAM(5.10)[100.00%];
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

Add a new optional ",cma" suffix to the crashkernel= command line option.

Add a new cma_size parameter to parse_crashkernel().
When not NULL, call __parse_crashkernel to parse the CMA
reservation size from "crashkernel=size,cma" and store it 
in cma_size.

Set cma_size to NULL in all calls to parse_crashkernel().

Signed-off-by: Jiri Bohac <jbohac@suse.cz>
---
 arch/arm/kernel/setup.c              |  2 +-
 arch/arm64/mm/init.c                 |  2 +-
 arch/loongarch/kernel/setup.c        |  2 +-
 arch/mips/kernel/setup.c             |  2 +-
 arch/powerpc/kernel/fadump.c         |  2 +-
 arch/powerpc/kexec/core.c            |  2 +-
 arch/powerpc/mm/nohash/kaslr_booke.c |  2 +-
 arch/riscv/mm/init.c                 |  2 +-
 arch/s390/kernel/setup.c             |  2 +-
 arch/sh/kernel/machine_kexec.c       |  2 +-
 arch/x86/kernel/setup.c              |  2 +-
 include/linux/crash_core.h           |  3 ++-
 kernel/crash_core.c                  | 20 ++++++++++++++++----
 13 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index ff2299ce1ad7..cb940553c757 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1010,7 +1010,7 @@ static void __init reserve_crashkernel(void)
 	total_mem = get_total_mem();
 	ret = parse_crashkernel(boot_command_line, total_mem,
 				&crash_size, &crash_base,
-				NULL, NULL);
+				NULL, NULL, NULL);
 	/* invalid value specified or crashkernel=0 */
 	if (ret || !crash_size)
 		return;
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 74c1db8ce271..819b8979584c 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -105,7 +105,7 @@ static void __init arch_reserve_crashkernel(void)
 
 	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
 				&crash_size, &crash_base,
-				&low_size, &high);
+				&low_size, NULL, &high);
 	if (ret)
 		return;
 
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index d183a745fb85..0489c8188b83 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -266,7 +266,7 @@ static void __init arch_parse_crashkernel(void)
 	total_mem = memblock_phys_mem_size();
 	ret = parse_crashkernel(boot_command_line, total_mem,
 				&crash_size, &crash_base,
-				NULL, NULL);
+				NULL, NULL, NULL);
 	if (ret < 0 || crash_size <= 0)
 		return;
 
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 2d2ca024bd47..98afa80ec002 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -456,7 +456,7 @@ static void __init mips_parse_crashkernel(void)
 	total_mem = memblock_phys_mem_size();
 	ret = parse_crashkernel(boot_command_line, total_mem,
 				&crash_size, &crash_base,
-				NULL, NULL);
+				NULL, NULL, NULL);
 	if (ret != 0 || crash_size <= 0)
 		return;
 
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index d14eda1e8589..6fa5ab01f4e8 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -313,7 +313,7 @@ static __init u64 fadump_calculate_reserve_size(void)
 	 * memory at a predefined offset.
 	 */
 	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
-				&size, &base, NULL, NULL);
+				&size, &base, NULL, NULL, NULL);
 	if (ret == 0 && size > 0) {
 		unsigned long max_size;
 
diff --git a/arch/powerpc/kexec/core.c b/arch/powerpc/kexec/core.c
index 85846cadb9b5..c1e0afd94c90 100644
--- a/arch/powerpc/kexec/core.c
+++ b/arch/powerpc/kexec/core.c
@@ -112,7 +112,7 @@ void __init reserve_crashkernel(void)
 	total_mem_sz = memory_limit ? memory_limit : memblock_phys_mem_size();
 	/* use common parsing */
 	ret = parse_crashkernel(boot_command_line, total_mem_sz,
-			&crash_size, &crash_base, NULL, NULL);
+			&crash_size, &crash_base, NULL, NULL, NULL);
 	if (ret == 0 && crash_size > 0) {
 		crashk_res.start = crash_base;
 		crashk_res.end = crash_base + crash_size - 1;
diff --git a/arch/powerpc/mm/nohash/kaslr_booke.c b/arch/powerpc/mm/nohash/kaslr_booke.c
index b4f2786a7d2b..df083fe158b6 100644
--- a/arch/powerpc/mm/nohash/kaslr_booke.c
+++ b/arch/powerpc/mm/nohash/kaslr_booke.c
@@ -178,7 +178,7 @@ static void __init get_crash_kernel(void *fdt, unsigned long size)
 	int ret;
 
 	ret = parse_crashkernel(boot_command_line, size, &crash_size,
-				&crash_base, NULL, NULL);
+				&crash_base, NULL, NULL, NULL);
 	if (ret != 0 || crash_size == 0)
 		return;
 	if (crash_base == 0)
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 2e011cbddf3a..d0bae97c9a7a 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1355,7 +1355,7 @@ static void __init arch_reserve_crashkernel(void)
 
 	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
 				&crash_size, &crash_base,
-				&low_size, &high);
+				&low_size, NULL, &high);
 	if (ret)
 		return;
 
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 5701356f4f33..4d18b6b8f5ca 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -619,7 +619,7 @@ static void __init reserve_crashkernel(void)
 	int rc;
 
 	rc = parse_crashkernel(boot_command_line, ident_map_size,
-			       &crash_size, &crash_base, NULL, NULL);
+			       &crash_size, &crash_base, NULL, NULL, NULL);
 
 	crash_base = ALIGN(crash_base, KEXEC_CRASH_MEM_ALIGN);
 	crash_size = ALIGN(crash_size, KEXEC_CRASH_MEM_ALIGN);
diff --git a/arch/sh/kernel/machine_kexec.c b/arch/sh/kernel/machine_kexec.c
index fa3a7b36190a..e754860a7236 100644
--- a/arch/sh/kernel/machine_kexec.c
+++ b/arch/sh/kernel/machine_kexec.c
@@ -154,7 +154,7 @@ void __init reserve_crashkernel(void)
 	int ret;
 
 	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
-			&crash_size, &crash_base, NULL, NULL);
+			&crash_size, &crash_base, NULL, NULL, NULL);
 	if (ret == 0 && crash_size > 0) {
 		crashk_res.start = crash_base;
 		crashk_res.end = crash_base + crash_size - 1;
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 1526747bedf2..f271b2cc3054 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -478,7 +478,7 @@ static void __init arch_reserve_crashkernel(void)
 
 	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
 				&crash_size, &crash_base,
-				&low_size, &high);
+				&low_size, NULL, &high);
 	if (ret)
 		return;
 
diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 5126a4fecb44..f1edefcf7377 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -95,7 +95,8 @@ void final_note(Elf_Word *buf);
 
 int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base,
-		unsigned long long *low_size, bool *high);
+		unsigned long long *low_size, unsigned long long *cma_size,
+		bool *high);
 
 #ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
 #ifndef DEFAULT_CRASH_KERNEL_LOW_SIZE
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index efe87d501c8c..1e952d2e451b 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -184,11 +184,13 @@ static int __init parse_crashkernel_simple(char *cmdline,
 
 #define SUFFIX_HIGH 0
 #define SUFFIX_LOW  1
-#define SUFFIX_NULL 2
+#define SUFFIX_CMA  2
+#define SUFFIX_NULL 3
 static __initdata char *suffix_tbl[] = {
-	[SUFFIX_HIGH] = ",high",
-	[SUFFIX_LOW]  = ",low",
-	[SUFFIX_NULL] = NULL,
+	[SUFFIX_HIGH]	= ",high",
+	[SUFFIX_LOW]	= ",low",
+	[SUFFIX_CMA]	= ",cma",
+	[SUFFIX_NULL]	= NULL,
 };
 
 /*
@@ -310,9 +312,11 @@ int __init parse_crashkernel(char *cmdline,
 			     unsigned long long *crash_size,
 			     unsigned long long *crash_base,
 			     unsigned long long *low_size,
+			     unsigned long long *cma_size,
 			     bool *high)
 {
 	int ret;
+	unsigned long long cma_base;
 
 	/* crashkernel=X[@offset] */
 	ret = __parse_crashkernel(cmdline, system_ram, crash_size,
@@ -343,6 +347,14 @@ int __init parse_crashkernel(char *cmdline,
 
 		*high = true;
 	}
+
+	/*
+	* optional CMA reservation
+	* cma_base is ignored
+	*/
+	if (cma_size)
+		__parse_crashkernel(cmdline, 0, cma_size,
+			&cma_base, suffix_tbl[SUFFIX_CMA]);
 #endif
 	if (!*crash_size)
 		ret = -EINVAL;

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia

