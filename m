Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1969878C415
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbjH2MRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235324AbjH2MRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:17:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3D41AE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693311391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ejt6UDOFUHGL55tryxt5Pp+JnjRx6OBIlOhKS/KA2Bw=;
        b=SnPbtn5yKGMlTKuGAHvgG4P/ClGx1dQ4pRBzNnhNJeKJdRFCWTRL6jcvL8fiy8MpcSUEGw
        bLzb0knGGKRtYnZUkxopR2/udLRi2bJCqBeIW3iz3w/E9P6C8GJyOeklzO9+JCGMulNM2D
        LgPB6pbEfBF9tVPFGxx76KqjnuWtSSE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-iK9SBfUhMym74xjbgtrGtw-1; Tue, 29 Aug 2023 08:16:28 -0400
X-MC-Unique: iK9SBfUhMym74xjbgtrGtw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D18883394A;
        Tue, 29 Aug 2023 12:16:28 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D69606B2AD;
        Tue, 29 Aug 2023 12:16:23 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        thunder.leizhen@huawei.com, dyoung@redhat.com, prudo@redhat.com,
        samuel.holland@sifive.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 2/8] crash_core: change the prototype of function parse_crashkernel()
Date:   Tue, 29 Aug 2023 20:16:04 +0800
Message-ID: <20230829121610.138107-3-bhe@redhat.com>
In-Reply-To: <20230829121610.138107-1-bhe@redhat.com>
References: <20230829121610.138107-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two parameters 'low_size' and 'high' to function parse_crashkernel(),
later crashkernel=,high|low parsing will be added. Make adjustments in all
call sites of parse_crashkernel() in arch.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/arm/kernel/setup.c              |  3 ++-
 arch/arm64/mm/init.c                 |  2 +-
 arch/ia64/kernel/setup.c             |  2 +-
 arch/loongarch/kernel/setup.c        |  4 +++-
 arch/mips/kernel/setup.c             |  3 ++-
 arch/powerpc/kernel/fadump.c         |  2 +-
 arch/powerpc/kexec/core.c            |  2 +-
 arch/powerpc/mm/nohash/kaslr_booke.c |  2 +-
 arch/riscv/mm/init.c                 |  2 +-
 arch/s390/kernel/setup.c             |  4 ++--
 arch/sh/kernel/machine_kexec.c       |  2 +-
 arch/x86/kernel/setup.c              |  3 ++-
 include/linux/crash_core.h           |  3 ++-
 kernel/crash_core.c                  | 15 ++++++++++++---
 14 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index c66b560562b3..e2bb7afd0683 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1010,7 +1010,8 @@ static void __init reserve_crashkernel(void)
 
 	total_mem = get_total_mem();
 	ret = parse_crashkernel(boot_command_line, total_mem,
-				&crash_size, &crash_base);
+				&crash_size, &crash_base,
+				NULL, NULL);
 	/* invalid value specified or crashkernel=0 */
 	if (ret || !crash_size)
 		return;
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 4fcb88a445ef..4ad637508b75 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -142,7 +142,7 @@ static void __init reserve_crashkernel(void)
 
 	/* crashkernel=X[@offset] */
 	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
-				&crash_size, &crash_base);
+				&crash_size, &crash_base, NULL, NULL);
 	if (ret == -ENOENT) {
 		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
 		if (ret || !crash_size)
diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
index 5a55ac82c13a..4faea2d2cf07 100644
--- a/arch/ia64/kernel/setup.c
+++ b/arch/ia64/kernel/setup.c
@@ -277,7 +277,7 @@ static void __init setup_crashkernel(unsigned long total, int *n)
 	int ret;
 
 	ret = parse_crashkernel(boot_command_line, total,
-			&size, &base);
+			&size, &base, NULL, NULL);
 	if (ret == 0 && size > 0) {
 		if (!base) {
 			sort_regions(rsvd_region, *n);
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 9d830ab4e302..776a068d8718 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -267,7 +267,9 @@ static void __init arch_parse_crashkernel(void)
 	unsigned long long crash_base, crash_size;
 
 	total_mem = memblock_phys_mem_size();
-	ret = parse_crashkernel(boot_command_line, total_mem, &crash_size, &crash_base);
+	ret = parse_crashkernel(boot_command_line, total_mem,
+				&crash_size, &crash_base,
+				NULL, NULL);
 	if (ret < 0 || crash_size <= 0)
 		return;
 
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index cb871eb784a7..08321c945ac4 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -460,7 +460,8 @@ static void __init mips_parse_crashkernel(void)
 
 	total_mem = memblock_phys_mem_size();
 	ret = parse_crashkernel(boot_command_line, total_mem,
-				&crash_size, &crash_base);
+				&crash_size, &crash_base,
+				NULL, NULL);
 	if (ret != 0 || crash_size <= 0)
 		return;
 
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index ea0a073abd96..7dbdeba56e74 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -313,7 +313,7 @@ static __init u64 fadump_calculate_reserve_size(void)
 	 * memory at a predefined offset.
 	 */
 	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
-				&size, &base);
+				&size, &base, NULL, NULL);
 	if (ret == 0 && size > 0) {
 		unsigned long max_size;
 
diff --git a/arch/powerpc/kexec/core.c b/arch/powerpc/kexec/core.c
index de64c7962991..9346c960b296 100644
--- a/arch/powerpc/kexec/core.c
+++ b/arch/powerpc/kexec/core.c
@@ -109,7 +109,7 @@ void __init reserve_crashkernel(void)
 	total_mem_sz = memory_limit ? memory_limit : memblock_phys_mem_size();
 	/* use common parsing */
 	ret = parse_crashkernel(boot_command_line, total_mem_sz,
-			&crash_size, &crash_base);
+			&crash_size, &crash_base, NULL, NULL);
 	if (ret == 0 && crash_size > 0) {
 		crashk_res.start = crash_base;
 		crashk_res.end = crash_base + crash_size - 1;
diff --git a/arch/powerpc/mm/nohash/kaslr_booke.c b/arch/powerpc/mm/nohash/kaslr_booke.c
index 2fb3edafe9ab..b4f2786a7d2b 100644
--- a/arch/powerpc/mm/nohash/kaslr_booke.c
+++ b/arch/powerpc/mm/nohash/kaslr_booke.c
@@ -178,7 +178,7 @@ static void __init get_crash_kernel(void *fdt, unsigned long size)
 	int ret;
 
 	ret = parse_crashkernel(boot_command_line, size, &crash_size,
-				&crash_base);
+				&crash_base, NULL, NULL);
 	if (ret != 0 || crash_size == 0)
 		return;
 	if (crash_base == 0)
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index e4c35ac2357f..a9ef0824f905 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1332,7 +1332,7 @@ static void __init reserve_crashkernel(void)
 	}
 
 	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
-				&crash_size, &crash_base);
+				&crash_size, &crash_base, NULL, NULL);
 	if (ret || !crash_size)
 		return;
 
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index c744104e4a9c..98204a5f62b1 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -626,8 +626,8 @@ static void __init reserve_crashkernel(void)
 	phys_addr_t low, high;
 	int rc;
 
-	rc = parse_crashkernel(boot_command_line, ident_map_size, &crash_size,
-			       &crash_base);
+	rc = parse_crashkernel(boot_command_line, ident_map_size,
+			       &crash_size, &crash_base, NULL, NULL);
 
 	crash_base = ALIGN(crash_base, KEXEC_CRASH_MEM_ALIGN);
 	crash_size = ALIGN(crash_size, KEXEC_CRASH_MEM_ALIGN);
diff --git a/arch/sh/kernel/machine_kexec.c b/arch/sh/kernel/machine_kexec.c
index 223c14f44af7..fa3a7b36190a 100644
--- a/arch/sh/kernel/machine_kexec.c
+++ b/arch/sh/kernel/machine_kexec.c
@@ -154,7 +154,7 @@ void __init reserve_crashkernel(void)
 	int ret;
 
 	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
-			&crash_size, &crash_base);
+			&crash_size, &crash_base, NULL, NULL);
 	if (ret == 0 && crash_size > 0) {
 		crashk_res.start = crash_base;
 		crashk_res.end = crash_base + crash_size - 1;
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index fd975a4a5200..382c66d2cf71 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -558,7 +558,8 @@ static void __init reserve_crashkernel(void)
 	total_mem = memblock_phys_mem_size();
 
 	/* crashkernel=XM */
-	ret = parse_crashkernel(boot_command_line, total_mem, &crash_size, &crash_base);
+	ret = parse_crashkernel(boot_command_line, total_mem,
+				&crash_size, &crash_base, NULL, NULL);
 	if (ret != 0 || crash_size <= 0) {
 		/* crashkernel=X,high */
 		ret = parse_crashkernel_high(boot_command_line, total_mem,
diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index de62a722431e..2e76289699ff 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -78,7 +78,8 @@ Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 void final_note(Elf_Word *buf);
 
 int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
-		unsigned long long *crash_size, unsigned long long *crash_base);
+		unsigned long long *crash_size, unsigned long long *crash_base,
+		unsigned long long *low_size, bool *high);
 int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
 int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index f27b4e45d410..f6a5c219e2e1 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -280,10 +280,19 @@ static int __init __parse_crashkernel(char *cmdline,
 int __init parse_crashkernel(char *cmdline,
 			     unsigned long long system_ram,
 			     unsigned long long *crash_size,
-			     unsigned long long *crash_base)
+			     unsigned long long *crash_base,
+			     unsigned long long *low_size,
+			     bool *high)
 {
-	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
-				NULL);
+	int ret;
+
+	/* crashkernel=X[@offset] */
+	ret = __parse_crashkernel(cmdline, system_ram, crash_size,
+				crash_base, NULL);
+	if (!high)
+		return ret;
+
+	return 0;
 }
 
 int __init parse_crashkernel_high(char *cmdline,
-- 
2.41.0

