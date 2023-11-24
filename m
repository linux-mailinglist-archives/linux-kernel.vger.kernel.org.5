Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F687F8607
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 23:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjKXWW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 17:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjKXWWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 17:22:20 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8C91BC7;
        Fri, 24 Nov 2023 14:22:00 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AOLVLxI017056;
        Fri, 24 Nov 2023 22:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=dzhYh7LrMvBp4kXy7q9UTgYwttlEksL+Qn973TCYLxA=;
 b=dVNS6Jyg3rH/RfJP2BDZnTTiCmcn6gBFHW0eCb3RMm7kMiDQJHtQtQ2rRA/ja9KS5A0m
 8jpN2sVvj/J/X8CT2U1baYv12wIVqrhEZtGafQrRRRe+2XdZrjKSoQOplrK36thlieiG
 6v7tMjHHXTPnKaaVMaDW1iyvf52EDdVIMvXWbGNW2EQOtzGoBoT7rjFaaQg/I9/og2/D
 68nGddAWL/OB2++snRzfSSHLR9SW0whg6W5YxhH2/iiIQBM3ojjp3xwdw3kuslXk8OG0
 D9QgUbWzIveN+vXMaCW1MpXMJJgyDYyXwf3ZVI8QKLtMEcw89qfEuAIsEoceqDAEUWSm Gg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ujhh4tjd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 22:21:40 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AOMLdts018614
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 22:21:39 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 24 Nov 2023 14:21:30 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <corbet@lwn.net>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <vigneshr@ti.com>, <nm@ti.com>, <matthias.bgg@gmail.com>,
        <kgene@kernel.org>, <alim.akhtar@samsung.com>, <bmasney@redhat.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <kernel@quicinc.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [Patch v6 10/12] pstore/ram: Add dynamic ramoops region support through commandline
Date:   Sat, 25 Nov 2023 03:49:53 +0530
Message-ID: <1700864395-1479-11-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1700864395-1479-1-git-send-email-quic_mojha@quicinc.com>
References: <1700864395-1479-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YnvGFjnTQMFwQ9tSAtnR_3ymn6TUt3_b
X-Proofpoint-ORIG-GUID: YnvGFjnTQMFwQ9tSAtnR_3ymn6TUt3_b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-24_09,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311240174
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reserved memory region for ramoops is assumed to be at a fixed
and known location when read from the devicetree. This may not be
required for something like Qualcomm's minidump which is interested
in knowing addresses of ramoops region but it does not put hard
requirement of address being fixed as most of it's SoC does not
support warm reset and does not use pstorefs at all instead it has
firmware way of collecting ramoops region if it gets to know the
address and register it with apss minidump table which is sitting
in shared memory region in DDR and firmware will have access to
these table during reset and collects it on crash of SoC.

So, add the support of reserving ramoops region to be dynamically
allocated early during boot if it is request through command line
via 'dyn_ramoops_size=<size>' and fill up reserved resource structure
and export the structure, so that it can be read by ramoops driver.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 Documentation/admin-guide/ramoops.rst |  7 ++++
 fs/pstore/Kconfig                     | 15 +++++++++
 fs/pstore/ram.c                       | 62 ++++++++++++++++++++++++++++++++---
 include/linux/pstore_ram.h            |  5 +++
 init/main.c                           |  2 ++
 5 files changed, 87 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/ramoops.rst b/Documentation/admin-guide/ramoops.rst
index e9f85142182d..af737adbf079 100644
--- a/Documentation/admin-guide/ramoops.rst
+++ b/Documentation/admin-guide/ramoops.rst
@@ -33,6 +33,13 @@ memory are implementation defined, and won't work on many ARMs such as omaps.
 Setting ``mem_type=2`` attempts to treat the memory region as normal memory,
 which enables full cache on it. This can improve the performance.
 
+Ramoops memory region can also be allocated dynamically for a special case where
+there is no requirement to access the logs from pstorefs on next boot instead there
+is separate backend mechanism like minidump present which has awareness about the
+dynamic ramoops region and can recover the logs. This is enabled via command line
+parameter ``dyn_ramoops_size=<size>`` and should not be used in absence of
+separate backend which knows how to recover this dynamic region.
+
 The memory area is divided into ``record_size`` chunks (also rounded down to
 power of two) and each kmesg dump writes a ``record_size`` chunk of
 information.
diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index 3acc38600cd1..e13e53d7a225 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -81,6 +81,21 @@ config PSTORE_RAM
 
 	  For more information, see Documentation/admin-guide/ramoops.rst.
 
+config PSTORE_DYNAMIC_RAMOOPS_REGION_RESERVATION
+	bool "Reserve ramoops region dynamically"
+	select PSTORE_RAM
+	help
+	  This enables the dynamic reservation of ramoops region for a special case
+	  where there is no requirement to access the logs from pstorefs on next boot
+	  instead there is separate backend mechanism like minidump present which has
+	  awareness about the dynamic ramoops region and can recover the logs. This is
+	  enabled via command line parameter dyn_ramoops_size=<size> and should not be
+	  used in absence of separate backend which knows how to recover this dynamic
+	  region.
+
+	  Note whenever this config is selected ramoops driver will be build statically
+	  into kernel.
+
 config PSTORE_ZONE
 	tristate
 	depends on PSTORE
diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 88b34fdbf759..a6c0da8cfdd4 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -20,6 +20,7 @@
 #include <linux/compiler.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/memblock.h>
 #include <linux/mm.h>
 
 #include "internal.h"
@@ -103,6 +104,55 @@ struct ramoops_context {
 };
 
 static struct platform_device *dummy;
+static int dyn_ramoops_size;
+/* Location of the reserved area for the dynamic ramoops */
+static struct resource dyn_ramoops_res = {
+	.name  = "ramoops",
+	.start = 0,
+	.end   = 0,
+	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
+	.desc  = IORES_DESC_NONE,
+};
+
+static int __init parse_dyn_ramoops_size(char *p)
+{
+	char *tmp;
+
+	dyn_ramoops_size = memparse(p, &tmp);
+	if (p == tmp) {
+		pr_err("ramoops: memory size expected\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+early_param("dyn_ramoops_size", parse_dyn_ramoops_size);
+
+#ifdef CONFIG_PSTORE_DYNAMIC_RAMOOPS_REGION_RESERVATION
+/*
+ * setup_dynamic_ramoops() - reserves memory for dynamic ramoops
+ *
+ * This enable dynamic reserve memory support for ramoops through
+ * command line.
+ */
+void __init setup_dynamic_ramoops(void)
+{
+	unsigned long long ramoops_base;
+	unsigned long long ramoops_size;
+
+	ramoops_base = memblock_phys_alloc_range(dyn_ramoops_size, SMP_CACHE_BYTES,
+						 0, MEMBLOCK_ALLOC_NOLEAKTRACE);
+	if (!ramoops_base) {
+		pr_err("cannot allocate ramoops dynamic memory (size:0x%llx).\n",
+			ramoops_size);
+		return;
+	}
+
+	dyn_ramoops_res.start = ramoops_base;
+	dyn_ramoops_res.end = ramoops_base + dyn_ramoops_size - 1;
+	insert_resource(&iomem_resource, &dyn_ramoops_res);
+}
+#endif
 
 static int ramoops_pstore_open(struct pstore_info *psi)
 {
@@ -915,14 +965,18 @@ static void __init ramoops_register_dummy(void)
 
 	/*
 	 * Prepare a dummy platform data structure to carry the module
-	 * parameters. If mem_size isn't set, then there are no module
-	 * parameters, and we can skip this.
+	 * parameters. If mem_size isn't set, check for dynamic ramoops
+	 * size and use if it is set.
 	 */
-	if (!mem_size)
+	if (!mem_size && !dyn_ramoops_size)
 		return;
 
-	pr_info("using module parameters\n");
+	if (dyn_ramoops_size) {
+		mem_size = dyn_ramoops_size;
+		mem_address = dyn_ramoops_res.start;
+	}
 
+	pr_info("using module parameters\n");
 	memset(&pdata, 0, sizeof(pdata));
 	pdata.mem_size = mem_size;
 	pdata.mem_address = mem_address;
diff --git a/include/linux/pstore_ram.h b/include/linux/pstore_ram.h
index 9d65ff94e216..b3537336c4e1 100644
--- a/include/linux/pstore_ram.h
+++ b/include/linux/pstore_ram.h
@@ -39,4 +39,9 @@ struct ramoops_platform_data {
 	struct persistent_ram_ecc_info ecc_info;
 };
 
+#ifdef CONFIG_PSTORE_DYNAMIC_RAMOOPS_REGION_RESERVATION
+void __init setup_dynamic_ramoops(void);
+#else
+static inline void __init setup_dynamic_ramoops(void) {}
+#endif
 #endif
diff --git a/init/main.c b/init/main.c
index e24b0780fdff..32c7d94558ec 100644
--- a/init/main.c
+++ b/init/main.c
@@ -99,6 +99,7 @@
 #include <linux/init_syscalls.h>
 #include <linux/stackdepot.h>
 #include <linux/randomize_kstack.h>
+#include <linux/pstore_ram.h>
 #include <net/net_namespace.h>
 
 #include <asm/io.h>
@@ -895,6 +896,7 @@ void start_kernel(void)
 	pr_notice("%s", linux_banner);
 	early_security_init();
 	setup_arch(&command_line);
+	setup_dynamic_ramoops();
 	setup_boot_config();
 	setup_command_line(command_line);
 	setup_nr_cpu_ids();
-- 
2.7.4

