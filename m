Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25674803DD5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbjLDS4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjLDS4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:56:39 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCA5191;
        Mon,  4 Dec 2023 10:56:42 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4Dkais010539;
        Mon, 4 Dec 2023 18:54:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=yQL2YJJVy58jFgjIEOr/uJ8lGherBllTmSyKC9ZlwS4=;
 b=QLBjJVwmaK3Bm90z+qqLoSoyCsYPyf9MYPdnzDoKVLHAdZdXd5Bn+C3uFZ4njpiAR+iQ
 SD17Tf048kwd1v1odSJgZBg4AsEbeT5WGO8FFhYyyWNXsHgdPK2+S6/35jirDX2bEoTA
 oEEAxOvV58IMNG+IBUfdBH2Rpk7LekqJdr38fxw5Gepz6aV62yOLEq1yTA8ZKxIdcHbD
 0UX/0PD1YIEnOpbsMl2oAPPBAkglTeoY63UYEuCsOUyGA68h4NCvvIVjgSD7c+sQDJ8n
 IwDLdiLiIn2ePs6Xs5NU50IJSUQzBjnzDLSk+GWa77TTGl7L42UK8eR1ecJ5mh743sJa IQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3usdfwh8bq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 18:54:46 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B4Isjn6026189
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Dec 2023 18:54:45 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 4 Dec 2023 10:54:42 -0800
From:   Oreoluwa Babatunde <quic_obabatun@quicinc.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <dinguyen@kernel.org>,
        <chenhuacai@kernel.org>, <tsbogend@alpha.franken.de>,
        <jonas@southpole.se>, <stefan.kristiansson@saunalahti.fi>,
        <shorne@gmail.com>, <mpe@ellerman.id.au>,
        <ysato@users.sourceforge.jp>, <dalias@libc.org>,
        <glaubitz@physik.fu-berlin.de>, <richard@nod.at>,
        <anton.ivanov@cambridgegreys.com>, <johannes@sipsolutions.net>,
        <chris@zankel.net>, <jcmvbkbc@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>,
        Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Subject: [RFC PATCH v2 2/6] of: reserved_mem: Swicth call to unflatten_device_tree() to after paging_init()
Date:   Mon, 4 Dec 2023 10:54:05 -0800
Message-ID: <20231204185409.19615-3-quic_obabatun@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231204185409.19615-1-quic_obabatun@quicinc.com>
References: <20231204185409.19615-1-quic_obabatun@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RRJI60JTRuS8wb8roZNCA4Kt6_Xcb9J_
X-Proofpoint-ORIG-GUID: RRJI60JTRuS8wb8roZNCA4Kt6_Xcb9J_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_18,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=923 mlxscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040146
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch call to unflatten_device_tree() to after paging_init() on other
archs to follow new order in which the reserved_mem regions are
processed.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 arch/loongarch/kernel/setup.c      | 2 +-
 arch/mips/kernel/setup.c           | 3 ++-
 arch/nios2/kernel/setup.c          | 4 ++--
 arch/openrisc/kernel/setup.c       | 4 ++--
 arch/powerpc/kernel/setup-common.c | 3 +++
 arch/sh/kernel/setup.c             | 5 ++---
 arch/um/kernel/dtb.c               | 1 -
 arch/um/kernel/um_arch.c           | 2 ++
 arch/xtensa/kernel/setup.c         | 4 +++-
 9 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index d183a745fb85..a01051b0f9e0 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -366,7 +366,6 @@ void __init platform_init(void)
 	acpi_gbl_use_default_register_widths = false;
 	acpi_boot_table_init();
 #endif
-	unflatten_and_copy_device_tree();
 
 #ifdef CONFIG_NUMA
 	init_numa_memory();
@@ -626,6 +625,7 @@ void __init setup_arch(char **cmdline_p)
 
 	paging_init();
 
+	unflatten_and_copy_device_tree();
 #ifdef CONFIG_KASAN
 	kasan_init();
 #endif
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 2d2ca024bd47..d3b6c86a8037 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -667,7 +667,6 @@ static void __init arch_mem_init(char **cmdline_p)
 	mips_reserve_vmcore();
 
 	mips_parse_crashkernel();
-	device_tree_init();
 
 	/*
 	 * In order to reduce the possibility of kernel panic when failed to
@@ -798,6 +797,8 @@ void __init setup_arch(char **cmdline_p)
 	cpu_cache_init();
 	paging_init();
 
+	device_tree_init();
+
 	memblock_dump_all();
 
 	setup_rng_seed();
diff --git a/arch/nios2/kernel/setup.c b/arch/nios2/kernel/setup.c
index da122a5fa43b..6f1a4232b8f0 100644
--- a/arch/nios2/kernel/setup.c
+++ b/arch/nios2/kernel/setup.c
@@ -169,8 +169,6 @@ void __init setup_arch(char **cmdline_p)
 	early_init_fdt_reserve_self();
 	early_init_fdt_scan_reserved_mem();
 
-	unflatten_and_copy_device_tree();
-
 	setup_cpuinfo();
 
 	copy_exception_handler(cpuinfo.exception_addr);
@@ -189,4 +187,6 @@ void __init setup_arch(char **cmdline_p)
 	 * get kmalloc into gear
 	 */
 	paging_init();
+
+	unflatten_and_copy_device_tree();
 }
diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
index 9cf7fb60441f..fcda33bdca19 100644
--- a/arch/openrisc/kernel/setup.c
+++ b/arch/openrisc/kernel/setup.c
@@ -255,8 +255,6 @@ void calibrate_delay(void)
 
 void __init setup_arch(char **cmdline_p)
 {
-	unflatten_and_copy_device_tree();
-
 	setup_cpuinfo();
 
 #ifdef CONFIG_SMP
@@ -284,6 +282,8 @@ void __init setup_arch(char **cmdline_p)
 	/* paging_init() sets up the MMU and marks all pages as reserved */
 	paging_init();
 
+	unflatten_and_copy_device_tree();
+
 	*cmdline_p = boot_command_line;
 
 	printk(KERN_INFO "OpenRISC Linux -- http://openrisc.io\n");
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 9b142b9d5187..58da58d02652 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -986,6 +986,9 @@ void __init setup_arch(char **cmdline_p)
 
 	paging_init();
 
+	/* Unflatten the device-tree passed by prom_init or kexec */
+	unflatten_device_tree();
+
 	/* Initialize the MMU context management stuff. */
 	mmu_context_init();
 
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 3d80515298d2..2553696af21b 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -322,6 +322,8 @@ void __init setup_arch(char **cmdline_p)
 	/* Let earlyprintk output early console messages */
 	sh_early_platform_driver_probe("earlyprintk", 1, 1);
 
+	paging_init();
+
 #ifdef CONFIG_OF_EARLY_FLATTREE
 #ifdef CONFIG_USE_BUILTIN_DTB
 	unflatten_and_copy_device_tree();
@@ -329,9 +331,6 @@ void __init setup_arch(char **cmdline_p)
 	unflatten_device_tree();
 #endif
 #endif
-
-	paging_init();
-
 	/* Perform the machine specific initialisation */
 	if (likely(sh_mv.mv_setup))
 		sh_mv.mv_setup(cmdline_p);
diff --git a/arch/um/kernel/dtb.c b/arch/um/kernel/dtb.c
index 484141b06938..04b0ada3b929 100644
--- a/arch/um/kernel/dtb.c
+++ b/arch/um/kernel/dtb.c
@@ -26,7 +26,6 @@ void uml_dtb_init(void)
 	}
 
 	early_init_fdt_scan_reserved_mem();
-	unflatten_device_tree();
 }
 
 static int __init uml_dtb_setup(char *line, int *add)
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index b1bfed0c8528..fe6ecaa12ef2 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -7,6 +7,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/mm.h>
+#include <linux/of_fdt.h>
 #include <linux/ctype.h>
 #include <linux/module.h>
 #include <linux/panic_notifier.h>
@@ -421,6 +422,7 @@ void __init setup_arch(char **cmdline_p)
 	read_initrd();
 
 	paging_init();
+	unflatten_device_tree();
 	strscpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
 	*cmdline_p = command_line;
 	setup_hostinfo(host_info, sizeof host_info);
diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index bdec4a773af0..d20c56b4182e 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -355,13 +355,15 @@ void __init setup_arch(char **cmdline_p)
 	parse_early_param();
 	bootmem_init();
 	kasan_init();
-	unflatten_and_copy_device_tree();
 
 #ifdef CONFIG_SMP
 	smp_init_cpus();
 #endif
 
 	paging_init();
+
+	unflatten_and_copy_device_tree();
+
 	zones_init();
 
 #ifdef CONFIG_VT
-- 
2.17.1

