Return-Path: <linux-kernel+bounces-21076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8DE828968
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BAF7B25365
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AF93C08D;
	Tue,  9 Jan 2024 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QyYIjM0g"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DD43BB4D;
	Tue,  9 Jan 2024 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409Er2tg000860;
	Tue, 9 Jan 2024 15:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=liHucfX2xMzQKqbz5UJBmDnlLnI/IKgbK0PiZ9KXaXw=; b=Qy
	YIjM0gxsfFsJBG7LrBhgKmAZL6DFvq8jv9JptWS1iamyZRnsPJJiyXM/qrq9WPHc
	mHHKgIzyJj/yHnYffTAbZxAk76lEAh3MrzjQ3NEIVJdxrD63jsKyTzvygftwB1Ja
	knSkZ//hxyPOqva9Nb2dkY4MwV03dbLxPwY4Q2cjFfaVJXvJmn3e8bP+nGDIgB+8
	TjBVHIl5xOTeC+FjHeSc/711zbx7O/btGDjwUHCTxBhyW7COPyVbvzbn4taenmj5
	9XxkLZHnut+y7UdDLXU3Wih6hj6s9zFBrVmMlCbJ4utfZXkGbeF903lVpYNvwRQD
	SFDIUH4D4HQv64xy6ttg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh3me0nwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 15:49:23 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 409FnMUm002592
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 15:49:22 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 07:49:17 -0800
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <corbet@lwn.net>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>, <vigneshr@ti.com>,
        <nm@ti.com>, <matthias.bgg@gmail.com>, <kgene@kernel.org>,
        <alim.akhtar@samsung.com>, <bmasney@redhat.com>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mukesh Ojha
	<quic_mojha@quicinc.com>
Subject: [PATCH v7 08/12] pstore/ram: Add dynamic ramoops region support through commandline
Date: Tue, 9 Jan 2024 21:01:56 +0530
Message-ID: <20240109153200.12848-9-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.43.0.254.ga26002b62827
In-Reply-To: <20240109153200.12848-1-quic_mojha@quicinc.com>
References: <20240109153200.12848-1-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BI1su_t4u_jaBjZDhL9SBdoZbjVXvq7R
X-Proofpoint-GUID: BI1su_t4u_jaBjZDhL9SBdoZbjVXvq7R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090128

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
 Documentation/admin-guide/ramoops.rst | 23 +++++++++-
 fs/pstore/Kconfig                     | 15 ++++++
 fs/pstore/ram.c                       | 66 +++++++++++++++++++++++++--
 include/linux/pstore_ram.h            |  5 ++
 init/main.c                           |  2 +
 5 files changed, 107 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/ramoops.rst b/Documentation/admin-guide/ramoops.rst
index e9f85142182d..517b00981e99 100644
--- a/Documentation/admin-guide/ramoops.rst
+++ b/Documentation/admin-guide/ramoops.rst
@@ -33,6 +33,13 @@ memory are implementation defined, and won't work on many ARMs such as omaps.
 Setting ``mem_type=2`` attempts to treat the memory region as normal memory,
 which enables full cache on it. This can improve the performance.
 
+Ramoops supports its memory to be allocated dynamically during early boot
+for plaforms that does not have support for warm boot i.e., no assurance
+of Ram content will be preserved across boot and for these platform
+giving static Ramoops memory is not necessary as it has separate backend
+mechanism to retrieve ramoops content on system failure. More about
+how to enable Dynamic ramoops in ``Setting the parameters`` A.b section.
+
 The memory area is divided into ``record_size`` chunks (also rounded down to
 power of two) and each kmesg dump writes a ``record_size`` chunk of
 information.
@@ -59,7 +66,7 @@ Setting the parameters
 
 Setting the ramoops parameters can be done in several different manners:
 
- A. Use the module parameters (which have the names of the variables described
+ A.a  Use the module parameters (which have the names of the variables described
  as before). For quick debugging, you can also reserve parts of memory during
  boot and then use the reserved memory for ramoops. For example, assuming a
  machine with > 128 MB of memory, the following kernel command line will tell
@@ -68,6 +75,20 @@ Setting the ramoops parameters can be done in several different manners:
 
 	mem=128M ramoops.mem_address=0x8000000 ramoops.ecc=1
 
+ A.b  Ramoops memory can be also be dynamically reserve by Kernel and in such
+ scenario ``mem_address`` i.e, Ramoops base address can be anywhere in the RAM
+ instead of being fixed and predefined. A separate command line option
+ ``dyn_ramoops_size=<size>`` and kernel config CONFIG_PSTORE_DYNAMIC_RAMOOPS
+ is provided to facilitate Dynamic Ramoops memory reservation during early boot.
+ The command line option and the config should only be used in the presence of
+ separate backend which knows how to recover Dynamic Ramoops region otherwise
+ regular ramoops functionality will be impacted.
+ ``mem_size`` should not be used if Dynamic Ramoops support is requested and if
+ both are given ``mem_size`` value is overwritten with ``dyn_ramoops_size`` value
+ i.e, Dynamic Ramoops takes precedence::
+
+	dyn_ramoops_size=2M ramoops.console_size=2097152
+
  B. Use Device Tree bindings, as described in
  ``Documentation/devicetree/bindings/reserved-memory/ramoops.yaml``.
  For example::
diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index 3acc38600cd1..2f2bb483fd85 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -81,6 +81,21 @@ config PSTORE_RAM
 
 	  For more information, see Documentation/admin-guide/ramoops.rst.
 
+config PSTORE_DYNAMIC_RAMOOPS
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
index 88b34fdbf759..795a8300631e 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -20,6 +20,7 @@
 #include <linux/compiler.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/memblock.h>
 #include <linux/mm.h>
 
 #include "internal.h"
@@ -103,6 +104,59 @@ struct ramoops_context {
 };
 
 static struct platform_device *dummy;
+static struct resource dyn_ramoops_res = {
+	.name  = "ramoops",
+	.start = 0,
+	.end   = 0,
+	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
+	.desc  = IORES_DESC_NONE,
+};
+static int dyn_ramoops_size;
+
+#ifdef CONFIG_PSTORE_DYNAMIC_RAMOOPS
+static int __init parse_dyn_ramoops_size(char *p)
+{
+	char *tmp;
+
+	dyn_ramoops_size = memparse(p, &tmp);
+	if (p == tmp) {
+		pr_err("ramoops: memory size expected\n");
+		dyn_ramoops_size = 0;
+		return -EINVAL;
+	}
+
+	return 0;
+}
+early_param("dyn_ramoops_size", parse_dyn_ramoops_size);
+
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
+	if (!dyn_ramoops_size)
+		return;
+
+	ramoops_base = memblock_phys_alloc_range(dyn_ramoops_size, SMP_CACHE_BYTES,
+						 0, MEMBLOCK_ALLOC_NOLEAKTRACE);
+	if (!ramoops_base) {
+		pr_err("cannot allocate ramoops dynamic memory (size:0x%llx).\n",
+			ramoops_size);
+		dyn_ramoops_size = 0;
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
@@ -915,13 +969,19 @@ static void __init ramoops_register_dummy(void)
 
 	/*
 	 * Prepare a dummy platform data structure to carry the module
-	 * parameters. If mem_size isn't set, then there are no module
-	 * parameters, and we can skip this.
+	 * parameters.
+	 *
+	 * dyn_ramoops_size takes precedence over mem_size if it is
+	 * enabled and valid.
 	 */
-	if (!mem_size)
+	if (!dyn_ramoops_size && !mem_size)
 		return;
 
 	pr_info("using module parameters\n");
+	if (dyn_ramoops_size) {
+		mem_size = dyn_ramoops_size;
+		mem_address = dyn_ramoops_res.start;
+	}
 
 	memset(&pdata, 0, sizeof(pdata));
 	pdata.mem_size = mem_size;
diff --git a/include/linux/pstore_ram.h b/include/linux/pstore_ram.h
index 9d65ff94e216..1efff7a38333 100644
--- a/include/linux/pstore_ram.h
+++ b/include/linux/pstore_ram.h
@@ -39,4 +39,9 @@ struct ramoops_platform_data {
 	struct persistent_ram_ecc_info ecc_info;
 };
 
+#ifdef CONFIG_PSTORE_DYNAMIC_RAMOOPS
+void __init setup_dynamic_ramoops(void);
+#else
+static inline void __init setup_dynamic_ramoops(void) {}
+#endif
 #endif
diff --git a/init/main.c b/init/main.c
index f0b7e21ac67f..9d9fb27a2176 100644
--- a/init/main.c
+++ b/init/main.c
@@ -100,6 +100,7 @@
 #include <linux/stackdepot.h>
 #include <linux/randomize_kstack.h>
 #include <linux/moduleloader.h>
+#include <linux/pstore_ram.h>
 #include <net/net_namespace.h>
 
 #include <asm/io.h>
@@ -896,6 +897,7 @@ void start_kernel(void)
 	pr_notice("%s", linux_banner);
 	early_security_init();
 	setup_arch(&command_line);
+	setup_dynamic_ramoops();
 	setup_boot_config();
 	setup_command_line(command_line);
 	setup_nr_cpu_ids();
-- 
2.43.0.254.ga26002b62827


