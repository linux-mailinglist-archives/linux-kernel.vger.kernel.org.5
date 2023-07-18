Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1556757B68
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjGRMHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjGRMHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:07:15 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784F61BC1;
        Tue, 18 Jul 2023 05:06:46 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36IAMOOE025063;
        Tue, 18 Jul 2023 12:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=4mpY7MglWexXHRzxib7w2FZtJqa0v8ih6exKdd406Rs=;
 b=SzqXnn+Zz+Iy/Ok5adsEYuD88Fq9qzp72GiOzldPXO+50I9T9GEVG8W/SCL8dkmJUvNQ
 t9dFVL9sbPMhFsaphv7o/9PoYjnKn676mPuwGWCNgmIGNUuXbLq/YcfLE4XpGMDLG1yh
 5IftF31FPNwPofMhO3SwnIZCSDmP4Wtx7gtXN5UeXbZw7miSatZe+vaZGaue3IdWuZnj
 HUOWapgfwVa2FEqO+JOuSqYwbA5k87Xcn6R1Ytag7D9v4kA9ueJgNZmjMYqtDQMlpabp
 7YLa0U8pvf6fG4D1goiyaeHkhGd3cOYw6PFhmp6lF8nYaXfqlXRzvuW6+O8p4hKNQFkt vw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rwn908t7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 12:06:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36IC6W2V007019
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 12:06:32 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 18 Jul 2023 05:06:25 -0700
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_eberman@quicinc.com>, <kvalo@kernel.org>,
        <quic_mmanikan@quicinc.com>, <loic.poulain@linaro.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>
Subject: [V3,09/11] remoteproc: qcom: Add Hexagon based multipd rproc driver
Date:   Tue, 18 Jul 2023 17:34:59 +0530
Message-ID: <20230718120501.3205661-10-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230718120501.3205661-1-quic_mmanikan@quicinc.com>
References: <20230718120501.3205661-1-quic_mmanikan@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 621e2Ar8vQGe_DNiVEevrj4vQphcQbYN
X-Proofpoint-ORIG-GUID: 621e2Ar8vQGe_DNiVEevrj4vQphcQbYN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_09,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180110
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It adds support to bring up remoteproc's on multipd model.
Pd means protection domain. It's similar to process in Linux.
Here QDSP6 processor runs each wifi radio functionality on a
separate process. One process can't access other process
resources, so this is termed as PD i.e protection domain.

Here we have two pd's called root and user pd. We can correlate
Root pd as root and user pd as user in linux. Root pd has more
privileges than user pd. Root will provide services to user pd.

From remoteproc driver perspective, root pd corresponds to QDSP6
processor bring up and user pd corresponds to Wifi radio (WCSS)
bring up.

Here WCSS(user) PD is dependent on Q6(root) PD, so first
q6 pd should be up before wcss pd. After wcss pd goes down,
q6 pd should be turned off.

 APPS				QDSP6
-------                      -------------
|     |	 Crash notification  |		|	------
|     |<---------------------|----------|-------|User|
|     |			     |		|    |->|PD1 |
|     |			     |	-------	|    |	------
|     |			     |	|     |	|    |
|Root |	 Start/stop  Q6	     |	|  R  | |    |
|PD   |<---------------------|->|     | |    |
|rproc|  Crash notification  |	|  O  | |    |
|     |			     |	|     |	|    |
|User |Start/stop UserPD1    |  |  O  | |    |
|PD1  |----------------------|->|     |-|----|
|rproc|			     |	|  T  |	|    |
|     |			     |	|     | |    |
|User |Start/stop UserPD2    |	|  P  | |    |
|PD2  |----------------------|->|     |-|----|
|rproc|			     |	|  D  |	|    |
|     |			     |	-------	|    |	------
|     |	Crash notification   |		|    |->|User|
|     |<---------------------|----------|-------|PD2 |
-------			     |		|	------
                             ------------

IPQ5332, IPQ9574 supports multipd remoteproc driver.

Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
Changes in V3:
	- Fixed all comments and rebased for TOT.
	- Removed WCSS userpd compatibles.
	- Removed AHB/PCIE terms from driver.
	- Removed logic to get ASID from DT node, instead computed
	  from UserPD spawn bit no.
	- IPQ5018 support is dropped because it's base port patches not
	  yet merged so added IPQ5332 support.
	- Added msa lock, unlock scm calls for WCSS user pd up/down.
	- Added bootinfo support to share userpd load-address & size to
	  QDSP6 root pd.
		
Changes in V2:
	- Common functionalities moved to seperate patches
	- qcom_get_pd_asid() moved to mpd driver
	- Last DMA block alone memset to zero
	- Added diagram to show how userpd data is organized and sent to
	  trustzone
	- Rewritten commit message since most of the content available
	  in cover page
	- Removed 'remote_id' becuase it's not required for bring up.

 drivers/remoteproc/Kconfig         |  19 +
 drivers/remoteproc/Makefile        |   1 +
 drivers/remoteproc/qcom_q6v5_mpd.c | 851 +++++++++++++++++++++++++++++
 3 files changed, 871 insertions(+)
 create mode 100644 drivers/remoteproc/qcom_q6v5_mpd.c

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 48845dc8fa85..f5592e91c1a2 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -234,6 +234,25 @@ config QCOM_Q6V5_PAS
 	  CDSP (Compute DSP), MPSS (Modem Peripheral SubSystem), and
 	  SLPI (Sensor Low Power Island).
 
+config QCOM_Q6V5_MPD
+	tristate "Qualcomm Hexagon based MPD model Peripheral Image Loader"
+	depends on OF && ARCH_QCOM
+	depends on QCOM_SMEM
+	depends on RPMSG_QCOM_SMD || RPMSG_QCOM_SMD=n
+	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
+	depends on QCOM_SYSMON || QCOM_SYSMON=n
+	depends on RPMSG_QCOM_GLINK || RPMSG_QCOM_GLINK=n
+	depends on QCOM_AOSS_QMP || QCOM_AOSS_QMP=n
+	select QCOM_MDT_LOADER
+	select QCOM_PIL_INFO
+	select QCOM_Q6V5_COMMON
+	select QCOM_RPROC_COMMON
+	select QCOM_SCM
+	help
+	  Say y here to support the Qualcomm Secure Peripheral Image Loader
+	  for the Hexagon based MultiPD model remote processors on e.g. IPQ5018.
+	  This is trustZone wireless subsystem.
+
 config QCOM_Q6V5_WCSS
 	tristate "Qualcomm Hexagon based WCSS Peripheral Image Loader"
 	depends on OF && ARCH_QCOM
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index 91314a9b43ce..b64051080ec1 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_QCOM_PIL_INFO)		+= qcom_pil_info.o
 obj-$(CONFIG_QCOM_RPROC_COMMON)		+= qcom_common.o
 obj-$(CONFIG_QCOM_Q6V5_COMMON)		+= qcom_q6v5.o
 obj-$(CONFIG_QCOM_Q6V5_ADSP)		+= qcom_q6v5_adsp.o
+obj-$(CONFIG_QCOM_Q6V5_MPD)		+= qcom_q6v5_mpd.o
 obj-$(CONFIG_QCOM_Q6V5_MSS)		+= qcom_q6v5_mss.o
 obj-$(CONFIG_QCOM_Q6V5_PAS)		+= qcom_q6v5_pas.o
 obj-$(CONFIG_QCOM_Q6V5_WCSS)		+= qcom_q6v5_wcss.o
diff --git a/drivers/remoteproc/qcom_q6v5_mpd.c b/drivers/remoteproc/qcom_q6v5_mpd.c
new file mode 100644
index 000000000000..655fe29230cd
--- /dev/null
+++ b/drivers/remoteproc/qcom_q6v5_mpd.c
@@ -0,0 +1,851 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2016-2018 Linaro Ltd.
+ * Copyright (C) 2014 Sony Mobile Communications AB
+ * Copyright (c) 2012-2018, 2021 The Linux Foundation. All rights reserved.
+ */
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/firmware/qcom/qcom_scm.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/soc/qcom/mdt_loader.h>
+#include <linux/soc/qcom/smem.h>
+#include <linux/soc/qcom/smem_state.h>
+#include "qcom_common.h"
+#include "qcom_q6v5.h"
+
+#include "remoteproc_internal.h"
+
+#define WCSS_CRASH_REASON		421
+#define WCSS_SMEM_HOST			1
+
+#define WCNSS_PAS_ID			6
+#define MPD_WCNSS_PAS_ID        0xD
+
+#define BUF_SIZE			35
+
+#define MAX_FIRMWARE			3
+
+#define RPD_SWID		MPD_WCNSS_PAS_ID
+#define UPD_SWID		0x12
+#define REMOTE_PID			1
+#define UPD_BOOT_INFO_SMEM_SIZE		4096
+#define UPD_BOOT_INFO_HEADER_TYPE	0x2
+#define UPD_BOOT_INFO_SMEM_ID		507
+#define VERSION2			2
+
+enum {
+	Q6_IPQ,
+	WCSS_AHB_IPQ,
+	WCSS_PCIE_IPQ,
+};
+
+/**
+ * struct userpd_boot_info_header - header of user pd bootinfo
+ * @type:		type of bootinfo passing over smem
+ * @length:		length of header in bytes
+ */
+struct userpd_boot_info_header {
+	u8 type;
+	u8 length;
+};
+
+/**
+ * struct userpd_boot_info - holds info required to boot user pd
+ * @header:		pointer to header
+ * @pid:		unique id represents each user pd process
+ * @bootaddr:		load address of user pd firmware
+ * @data_size:		user pd firmware memory size
+ */
+struct userpd_boot_info {
+	struct userpd_boot_info_header header;
+	u8 pid;
+	u32 bootaddr;
+	u32 data_size;
+} __packed;
+
+struct q6_wcss {
+	struct device *dev;
+	struct qcom_rproc_glink glink_subdev;
+	struct qcom_rproc_ssr ssr_subdev;
+	struct qcom_q6v5 q6;
+	phys_addr_t mem_phys;
+	phys_addr_t mem_reloc;
+	void *mem_region;
+	size_t mem_size;
+	int crash_reason_smem;
+	u8 pd_asid;
+	const struct wcss_data *desc;
+	const char **firmware;
+};
+
+struct wcss_data {
+	int (*init_irq)(struct qcom_q6v5 *q6, struct platform_device *pdev,
+			struct rproc *rproc, int crash_reason,
+			const char *load_state,
+			void (*handover)(struct qcom_q6v5 *q6));
+	int crash_reason_smem;
+	u32 version;
+	const char *ssr_name;
+	const struct rproc_ops *ops;
+	bool glink_subdev_required;
+	bool reset_seq;
+	u32 pasid;
+	bool share_upd_info_to_q6;
+};
+
+/**
+ * qcom_get_pd_asid() - get the pd asid number from PD spawn bit
+ * @rproc:	rproc handle
+ *
+ * Returns asid on success
+ */
+u8 qcom_get_pd_asid(struct rproc *rproc)
+{
+	struct q6_wcss *wcss = rproc->priv;
+	u8 bit = wcss->q6.spawn_bit;
+
+	return bit / 8;
+}
+
+static int q6_wcss_start(struct rproc *rproc)
+{
+	struct q6_wcss *wcss = rproc->priv;
+	int ret;
+	const struct wcss_data *desc = wcss->desc;
+
+	qcom_q6v5_prepare(&wcss->q6);
+
+	ret = qcom_scm_pas_auth_and_reset(desc->pasid);
+	if (ret) {
+		dev_err(wcss->dev, "wcss_reset failed\n");
+		return ret;
+	}
+
+	ret = qcom_q6v5_wait_for_start(&wcss->q6, 5 * HZ);
+	if (ret == -ETIMEDOUT)
+		dev_err(wcss->dev, "start timed out\n");
+
+	return ret;
+}
+
+static int q6_wcss_spawn_pd(struct rproc *rproc)
+{
+	int ret;
+	struct q6_wcss *wcss = rproc->priv;
+
+	ret = qcom_q6v5_request_spawn(&wcss->q6);
+	if (ret == -ETIMEDOUT) {
+		dev_err(wcss->dev, "%s spawn timedout\n", rproc->name);
+		return ret;
+	}
+
+	ret = qcom_q6v5_wait_for_start(&wcss->q6, msecs_to_jiffies(10000));
+	if (ret == -ETIMEDOUT) {
+		dev_err(wcss->dev, "%s start timedout\n", rproc->name);
+		wcss->q6.running = false;
+		return ret;
+	}
+	wcss->q6.running = true;
+	return ret;
+}
+
+static int wcss_pd_start(struct rproc *rproc)
+{
+	struct q6_wcss *wcss = rproc->priv;
+	u32 pasid = (wcss->pd_asid << 8) | UPD_SWID;
+	int ret;
+
+	ret = qcom_scm_msa_lock(pasid);
+	if (ret) {
+		dev_err(wcss->dev, "failed to power up pd\n");
+		return ret;
+	}
+
+	if (wcss->q6.spawn_bit) {
+		ret = q6_wcss_spawn_pd(rproc);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
+static int q6_wcss_stop(struct rproc *rproc)
+{
+	struct q6_wcss *wcss = rproc->priv;
+	const struct wcss_data *desc = wcss->desc;
+	int ret;
+
+	ret = qcom_scm_pas_shutdown(desc->pasid);
+	if (ret) {
+		dev_err(wcss->dev, "not able to shutdown\n");
+		return ret;
+	}
+	qcom_q6v5_unprepare(&wcss->q6);
+
+	return 0;
+}
+
+/**
+ * wcss_pd_stop() - Stop WCSS user pd
+ * @rproc:	rproc handle
+ *
+ * Stop root pd after user pd down. Root pd
+ * is used to provide services to user pd, so
+ * keeping root pd alive when user pd is down
+ * is invalid.
+ * ---------------------------------------------
+ *
+ *				-----------
+ *		     |-------->| User PD1 |
+ *		     |		-----------
+ *		     |
+ *		     |
+ *	-----	     |		-----------
+ *	| Q6 |---------------->| User Pd2 |
+ *	-----	     |		-----------
+ *		     |
+ *		     |
+ *		     |		-----------
+ *		     |--------->| User Pd3 |
+ *				-----------
+ * ----------------------------------------------
+ */
+static int wcss_pd_stop(struct rproc *rproc)
+{
+	struct q6_wcss *wcss = rproc->priv;
+	struct rproc *rpd_rproc = dev_get_drvdata(wcss->dev->parent);
+	u32 pasid = (wcss->pd_asid << 8) | UPD_SWID;
+	int ret;
+
+	if (rproc->state != RPROC_CRASHED && wcss->q6.stop_bit) {
+		ret = qcom_q6v5_request_stop(&wcss->q6, NULL);
+		if (ret) {
+			dev_err(&rproc->dev, "pd not stopped\n");
+			return ret;
+		}
+	}
+
+	ret = qcom_scm_msa_unlock(pasid);
+	if (ret) {
+		dev_err(wcss->dev, "failed to power down pd\n");
+		return ret;
+	}
+
+	rproc_shutdown(rpd_rproc);
+
+	return 0;
+}
+
+static void *q6_wcss_da_to_va(struct rproc *rproc, u64 da, size_t len,
+			      bool *is_iomem)
+{
+	struct q6_wcss *wcss = rproc->priv;
+	int offset;
+
+	offset = da - wcss->mem_reloc;
+	if (offset < 0 || offset + len > wcss->mem_size)
+		return NULL;
+
+	return wcss->mem_region + offset;
+}
+
+/**
+ * share_upd_bootinfo_to_q6() - Share userpd boot info to Q6 root pd
+ * @rproc:	rproc handle
+ *
+ * Q6 needs user pd parameters like loadaddress and
+ * PIL size to authenticate user pd with underlying
+ * security software. If authenticatoin success then
+ * only Q6 spawns user pd and sends spawn ack to rproc
+ * driver. This API is passing userpd boot info to Q6
+ * over SMEM.
+ *
+ * User pd boot-info format mentioned below
+ * <Version> <No of elements passing over smem> <Header type> <Header Length>
+ * <Process Id> <Load address> <firmware mem Size>
+ *
+ * Returns 0 on success else negative value on failure.
+ */
+static int share_upd_bootinfo_to_q6(struct rproc *rproc)
+{
+	int ret;
+	size_t size;
+	u16 cnt = 0, version;
+	void *ptr;
+	struct q6_wcss *wcss = rproc->priv, *upd_wcss;
+	struct device_node *upd_np;
+	struct platform_device *upd_pdev;
+	struct rproc *upd_rproc;
+	struct userpd_boot_info upd_bootinfo = {0};
+	const struct firmware *fw;
+
+	ret = qcom_smem_alloc(REMOTE_PID, UPD_BOOT_INFO_SMEM_ID,
+			      UPD_BOOT_INFO_SMEM_SIZE);
+	if (ret && ret != -EEXIST) {
+		dev_err(wcss->dev,
+			"failed to allocate q6 bootinfo smem segment\n");
+		return ret;
+	}
+
+	ptr = qcom_smem_get(REMOTE_PID, UPD_BOOT_INFO_SMEM_ID, &size);
+	if (IS_ERR(ptr) || size != UPD_BOOT_INFO_SMEM_SIZE) {
+		dev_err(wcss->dev,
+			"Unable to acquire smp2p item(%d) ret:%ld\n",
+			UPD_BOOT_INFO_SMEM_ID, PTR_ERR(ptr));
+		return PTR_ERR(ptr);
+	}
+
+	/* print physical address */
+	dev_info(wcss->dev,
+		 "smem phyiscal address:0x%lX\n",
+		 (uintptr_t)qcom_smem_virt_to_phys(ptr));
+
+	/*Version*/
+	version = VERSION2;
+	memcpy_toio(ptr, &version, sizeof(version));
+	ptr += sizeof(version);
+
+	for_each_available_child_of_node(wcss->dev->of_node, upd_np) {
+		upd_pdev = of_find_device_by_node(upd_np);
+		if (!upd_pdev)
+			continue;
+		cnt++;
+	}
+
+	/* No of elements */
+	cnt = (sizeof(upd_bootinfo) * cnt);
+	memcpy_toio(ptr, &cnt, sizeof(u16));
+	ptr += sizeof(u16);
+
+	for_each_available_child_of_node(wcss->dev->of_node, upd_np) {
+		upd_pdev = of_find_device_by_node(upd_np);
+		if (!upd_pdev)
+			continue;
+
+		upd_rproc = platform_get_drvdata(upd_pdev);
+		upd_wcss = upd_rproc->priv;
+
+		/* TYPE */
+		upd_bootinfo.header.type = UPD_BOOT_INFO_HEADER_TYPE;
+
+		/* LENGTH */
+		upd_bootinfo.header.length =
+			sizeof(upd_bootinfo) - sizeof(upd_bootinfo.header);
+
+		/* Process ID */
+		upd_bootinfo.pid = upd_wcss->pd_asid + 1;
+
+		ret = request_firmware(&fw, upd_rproc->firmware, upd_wcss->dev);
+		if (ret < 0) {
+			dev_err(upd_wcss->dev, "request_firmware failed: %d\n",	ret);
+			return ret;
+		}
+
+		/* Load address */
+		upd_bootinfo.bootaddr = rproc_get_boot_addr(upd_rproc, fw);
+
+		/* Firmware mem size */
+		upd_bootinfo.data_size = qcom_mdt_get_size(fw);
+
+		release_firmware(fw);
+
+		/* copy into smem */
+		memcpy_toio(ptr, &upd_bootinfo, sizeof(upd_bootinfo));
+		ptr += sizeof(upd_bootinfo);
+	}
+	return 0;
+}
+
+static int q6_wcss_load(struct rproc *rproc, const struct firmware *fw)
+{
+	struct q6_wcss *wcss = rproc->priv;
+	const struct firmware *fw_hdl;
+	int ret;
+	const struct wcss_data *desc = wcss->desc;
+	int loop;
+
+	/* Share user pd boot info to Q6 remote processor */
+	if (desc->share_upd_info_to_q6) {
+		ret = share_upd_bootinfo_to_q6(rproc);
+		if (ret) {
+			dev_err(wcss->dev,
+				"user pd boot info sharing with q6 failed %d\n",
+				ret);
+			return ret;
+		}
+	}
+
+	ret = qcom_mdt_load(wcss->dev, fw, rproc->firmware,
+			    desc->pasid, wcss->mem_region,
+			    wcss->mem_phys, wcss->mem_size,
+			    &wcss->mem_reloc);
+	if (ret)
+		return ret;
+
+	for (loop = 1; loop < MAX_FIRMWARE; loop++) {
+		if (!wcss->firmware[loop])
+			continue;
+
+		ret = request_firmware(&fw_hdl, wcss->firmware[loop],
+				       wcss->dev);
+		if (ret)
+			continue;
+
+		ret = qcom_mdt_load_no_init(wcss->dev, fw_hdl,
+					    wcss->firmware[loop], 0,
+					    wcss->mem_region,
+					    wcss->mem_phys,
+					    wcss->mem_size,
+					    &wcss->mem_reloc);
+
+		release_firmware(fw_hdl);
+
+		if (ret) {
+			dev_err(wcss->dev,
+				"can't load %s ret:%d\n", wcss->firmware[loop], ret);
+			return ret;
+		}
+	}
+	return 0;
+}
+
+/**
+ * wcss_pd_load() - Load WCSS user pd firmware
+ * @rproc:	rproc handle
+ * @fw:		firmware handle
+ *
+ * User pd get services from root pd. So first
+ * bring up root pd and then load userpd firmware.
+ * ---------------------------------------------
+ *
+ *				-----------
+ *		     |-------->| User PD1 |
+ *		     |		-----------
+ *		     |
+ *		     |
+ *	-----	     |		-----------
+ *	| Q6 |---------------->| User Pd2 |
+ *	-----	     |		-----------
+ *		     |
+ *		     |
+ *		     |		-----------
+ *		     |--------->| User Pd3 |
+ *				-----------
+ * ----------------------------------------------
+ *
+ */
+static int wcss_pd_load(struct rproc *rproc, const struct firmware *fw)
+{
+	struct q6_wcss *wcss = rproc->priv;
+	struct rproc *rpd_rproc = dev_get_drvdata(wcss->dev->parent);
+	u32 pasid = (wcss->pd_asid << 8) | UPD_SWID;
+	int ret;
+
+	ret = rproc_boot(rpd_rproc);
+	if (ret)
+		return ret;
+
+	return qcom_mdt_load(wcss->dev, fw, rproc->firmware,
+			     pasid, wcss->mem_region,
+			     wcss->mem_phys, wcss->mem_size,
+			     &wcss->mem_reloc);
+}
+
+static unsigned long q6_wcss_panic(struct rproc *rproc)
+{
+	struct q6_wcss *wcss = rproc->priv;
+
+	return qcom_q6v5_panic(&wcss->q6);
+}
+
+static const struct rproc_ops wcss_ops = {
+	.start = wcss_pd_start,
+	.stop = wcss_pd_stop,
+	.load = wcss_pd_load,
+	.get_boot_addr = rproc_elf_get_boot_addr,
+};
+
+static const struct rproc_ops q6_wcss_ops = {
+	.start = q6_wcss_start,
+	.stop = q6_wcss_stop,
+	.da_to_va = q6_wcss_da_to_va,
+	.load = q6_wcss_load,
+	.get_boot_addr = rproc_elf_get_boot_addr,
+	.panic = q6_wcss_panic,
+};
+
+static int q6_alloc_memory_region(struct q6_wcss *wcss)
+{
+	struct reserved_mem *rmem = NULL;
+	struct device_node *node;
+	struct device *dev = wcss->dev;
+	const struct wcss_data *desc = wcss->desc;
+
+	if (desc && desc->version == Q6_IPQ) {
+		node = of_parse_phandle(dev->of_node, "memory-region", 0);
+		if (node)
+			rmem = of_reserved_mem_lookup(node);
+
+		of_node_put(node);
+
+		if (!rmem) {
+			dev_err(dev, "unable to acquire memory-region\n");
+			return -EINVAL;
+		}
+	} else {
+		struct rproc *rpd_rproc = dev_get_drvdata(dev->parent);
+		struct q6_wcss *rpd_wcss = rpd_rproc->priv;
+
+		wcss->mem_phys = rpd_wcss->mem_phys;
+		wcss->mem_reloc = rpd_wcss->mem_reloc;
+		wcss->mem_size = rpd_wcss->mem_size;
+		wcss->mem_region = rpd_wcss->mem_region;
+		return 0;
+	}
+
+	wcss->mem_phys = rmem->base;
+	wcss->mem_reloc = rmem->base;
+	wcss->mem_size = rmem->size;
+	wcss->mem_region = devm_ioremap_wc(dev, wcss->mem_phys, wcss->mem_size);
+	if (!wcss->mem_region) {
+		dev_err(dev, "unable to map memory region: %pa+%pa\n",
+			&rmem->base, &rmem->size);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int q6_get_inbound_irq(struct qcom_q6v5 *q6,
+			      struct platform_device *pdev,
+			      const char *int_name,
+			      int index, int *pirq,
+			      irqreturn_t (*handler)(int irq, void *data))
+{
+	int ret, irq;
+	char *interrupt, *tmp = (char *)int_name;
+	struct q6_wcss *wcss = q6->rproc->priv;
+
+	irq = platform_get_irq(pdev, index);
+	if (irq < 0) {
+		if (irq != -EPROBE_DEFER)
+			dev_err_probe(&pdev->dev, irq,
+				      "failed to retrieve %s IRQ: %d\n",
+				      int_name, irq);
+		return irq;
+	}
+
+	*pirq = irq;
+
+	interrupt = devm_kzalloc(&pdev->dev, BUF_SIZE, GFP_KERNEL);
+	if (!interrupt)
+		return -ENOMEM;
+
+	snprintf(interrupt, BUF_SIZE, "q6v5_wcss_userpd%d_%s", wcss->pd_asid, tmp);
+
+	ret = devm_request_threaded_irq(&pdev->dev, *pirq,
+					NULL, handler,
+					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+					interrupt, q6);
+	if (ret) {
+		dev_err_probe(&pdev->dev, ret,
+			      "failed to acquire %s irq\n", interrupt);
+		return ret;
+	}
+	return 0;
+}
+
+static int q6_get_outbound_irq(struct qcom_q6v5 *q6,
+			       struct platform_device *pdev,
+			       const char *int_name)
+{
+	struct qcom_smem_state *tmp_state;
+	unsigned  bit;
+
+	tmp_state = qcom_smem_state_get(&pdev->dev, int_name, &bit);
+	if (IS_ERR(tmp_state)) {
+		dev_err_probe(&pdev->dev, IS_ERR(tmp_state),
+			      "failed to acquire %s state\n", int_name);
+		return PTR_ERR(tmp_state);
+	}
+
+	if (!strcmp(int_name, "stop")) {
+		q6->state = tmp_state;
+		q6->stop_bit = bit;
+	} else if (!strcmp(int_name, "spawn")) {
+		q6->spawn_state = tmp_state;
+		q6->spawn_bit = bit;
+	}
+
+	return 0;
+}
+
+static int init_irq(struct qcom_q6v5 *q6,
+		    struct platform_device *pdev, struct rproc *rproc,
+		    int crash_reason, const char *load_state,
+		    void (*handover)(struct qcom_q6v5 *q6))
+{
+	int ret;
+	struct q6_wcss *wcss = rproc->priv;
+
+	q6->rproc = rproc;
+	q6->dev = &pdev->dev;
+	q6->crash_reason = crash_reason;
+	q6->handover = handover;
+
+	init_completion(&q6->start_done);
+	init_completion(&q6->stop_done);
+	init_completion(&q6->spawn_done);
+
+	ret = q6_get_outbound_irq(q6, pdev, "stop");
+	if (ret)
+		return ret;
+
+	ret = q6_get_outbound_irq(q6, pdev, "spawn");
+	if (ret)
+		return ret;
+
+	/* Get pd_asid to prepare interrupt names */
+	wcss->pd_asid = qcom_get_pd_asid(rproc);
+
+	ret = q6_get_inbound_irq(q6, pdev, "fatal", 0, &q6->fatal_irq,
+				 q6v5_fatal_interrupt);
+	if (ret)
+		return ret;
+
+	ret = q6_get_inbound_irq(q6, pdev, "ready", 1, &q6->ready_irq,
+				 q6v5_ready_interrupt);
+	if (ret)
+		return ret;
+
+	ret = q6_get_inbound_irq(q6, pdev, "stop-ack", 3, &q6->stop_irq,
+				 q6v5_stop_interrupt);
+	if (ret)
+		return ret;
+
+	ret = q6_get_inbound_irq(q6, pdev, "spawn-ack", 2, &q6->spawn_irq,
+				 q6v5_spawn_interrupt);
+	if (ret)
+		return ret;
+	return 0;
+}
+
+static void q6_release_resources(struct platform_device *pdev)
+{
+	struct rproc *upd_rproc;
+	struct device_node *upd_np;
+	struct platform_device *upd_pdev;
+
+	/* Release userpd resources */
+	for_each_available_child_of_node(pdev->dev.of_node, upd_np) {
+		upd_pdev = of_find_device_by_node(upd_np);
+		if (!upd_pdev)
+			continue;
+
+		upd_rproc = platform_get_drvdata(upd_pdev);
+		if (!upd_rproc) {
+			platform_device_unregister(upd_pdev);
+			continue;
+		}
+
+		rproc_del(upd_rproc);
+		rproc_free(upd_rproc);
+	}
+}
+
+static int q6_register_userpd(struct platform_device *pdev)
+{
+	struct q6_wcss *wcss;
+	struct rproc *rproc = NULL;
+	int ret;
+	struct device_node *userpd_np;
+	struct platform_device *userpd_pdev;
+	const char *firmware_name = NULL;
+
+	for_each_available_child_of_node(pdev->dev.of_node, userpd_np) {
+		ret = of_property_read_string(userpd_np, "firmware-name",
+					      &firmware_name);
+		if (ret < 0)
+			continue;
+
+		dev_info(&pdev->dev, "%s node found\n", userpd_np->name);
+
+		userpd_pdev = of_platform_device_create(userpd_np,
+							userpd_np->name,
+							&pdev->dev);
+		if (!userpd_pdev) {
+			ret = -ENODEV;
+			dev_err_probe(&pdev->dev, ret,
+				      "failed to create %s platform device\n",
+				      userpd_np->name);
+			goto release_resource;
+		}
+		userpd_pdev->dev.driver = pdev->dev.driver;
+		rproc = rproc_alloc(&userpd_pdev->dev, userpd_pdev->name,
+				    &wcss_ops, firmware_name,
+				    sizeof(*wcss));
+		if (!rproc) {
+			ret = -ENOMEM;
+			goto release_resource;
+		}
+
+		wcss = rproc->priv;
+		wcss->dev = &userpd_pdev->dev;
+
+		ret = q6_alloc_memory_region(wcss);
+		if (ret)
+			goto release_resource;
+
+		ret = init_irq(&wcss->q6, userpd_pdev, rproc,
+			       WCSS_CRASH_REASON, NULL, NULL);
+		if (ret)
+			goto release_resource;
+
+		rproc->auto_boot = false;
+		ret = rproc_add(rproc);
+		if (ret)
+			goto release_resource;
+
+		platform_set_drvdata(userpd_pdev, rproc);
+		qcom_add_ssr_subdev(rproc, &wcss->ssr_subdev, userpd_pdev->name);
+	}
+	return 0;
+
+release_resource:
+	q6_release_resources(pdev);
+	return ret;
+}
+
+static int q6_wcss_probe(struct platform_device *pdev)
+{
+	const struct wcss_data *desc;
+	struct q6_wcss *wcss;
+	struct rproc *rproc;
+	int ret;
+	char *subdev_name;
+	const char **firmware;
+
+	desc = of_device_get_match_data(&pdev->dev);
+	if (!desc)
+		return -EINVAL;
+
+	firmware = devm_kcalloc(&pdev->dev, MAX_FIRMWARE,
+				sizeof(*firmware), GFP_KERNEL);
+	if (!firmware)
+		return -ENOMEM;
+
+	ret = of_property_read_string_array(pdev->dev.of_node, "firmware-name",
+					    firmware, MAX_FIRMWARE);
+	if (ret < 0)
+		return ret;
+
+	rproc = rproc_alloc(&pdev->dev, pdev->name, desc->ops,
+			    firmware[0], sizeof(*wcss));
+	if (!rproc)
+		return -ENOMEM;
+
+	wcss = rproc->priv;
+	wcss->dev = &pdev->dev;
+	wcss->desc = desc;
+	wcss->firmware = firmware;
+
+	ret = q6_alloc_memory_region(wcss);
+	if (ret)
+		goto free_rproc;
+
+	ret = desc->init_irq(&wcss->q6, pdev, rproc,
+			     desc->crash_reason_smem, NULL, NULL);
+	if (ret)
+		goto free_rproc;
+
+	if (desc->glink_subdev_required)
+		qcom_add_glink_subdev(rproc, &wcss->glink_subdev, desc->ssr_name);
+
+	subdev_name = (char *)(desc->ssr_name ? desc->ssr_name : pdev->name);
+	qcom_add_ssr_subdev(rproc, &wcss->ssr_subdev, subdev_name);
+
+	rproc->auto_boot = false;
+	ret = rproc_add(rproc);
+	if (ret)
+		goto free_rproc;
+
+	platform_set_drvdata(pdev, rproc);
+
+	ret = q6_register_userpd(pdev);
+	if (ret) {
+		dev_err_probe(&pdev->dev, ret, "Failed to register userpd\n");
+		return ret;
+	}
+
+	return 0;
+
+free_rproc:
+	rproc_free(rproc);
+
+	return ret;
+}
+
+static int q6_wcss_remove(struct platform_device *pdev)
+{
+	struct rproc *rproc = platform_get_drvdata(pdev);
+	struct q6_wcss *wcss = rproc->priv;
+
+	qcom_q6v5_deinit(&wcss->q6);
+
+	rproc_del(rproc);
+	rproc_free(rproc);
+
+	return 0;
+}
+
+static const struct wcss_data q6_ipq5332_res_init = {
+	.init_irq = qcom_q6v5_init,
+	.crash_reason_smem = WCSS_CRASH_REASON,
+	.ssr_name = "q6wcss",
+	.ops = &q6_wcss_ops,
+	.version = Q6_IPQ,
+	.glink_subdev_required = true,
+	.pasid = MPD_WCNSS_PAS_ID,
+	.share_upd_info_to_q6 = true,
+};
+
+static const struct wcss_data q6_ipq9574_res_init = {
+	.init_irq = qcom_q6v5_init,
+	.crash_reason_smem = WCSS_CRASH_REASON,
+	.ssr_name = "q6wcss",
+	.ops = &q6_wcss_ops,
+	.version = Q6_IPQ,
+	.glink_subdev_required = true,
+	.pasid = WCNSS_PAS_ID,
+};
+
+static const struct of_device_id q6_wcss_of_match[] = {
+	{ .compatible = "qcom,ipq5332-q6-mpd", .data = &q6_ipq5332_res_init },
+	{ .compatible = "qcom,ipq9574-q6-mpd", .data = &q6_ipq9574_res_init },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, q6_wcss_of_match);
+
+static struct platform_driver q6_wcss_driver = {
+	.probe = q6_wcss_probe,
+	.remove = q6_wcss_remove,
+	.driver = {
+		.name = "qcom-q6-mpd",
+		.of_match_table = q6_wcss_of_match,
+	},
+};
+module_platform_driver(q6_wcss_driver);
+
+MODULE_DESCRIPTION("Hexagon WCSS Multipd Peripheral Image Loader");
+MODULE_LICENSE("GPL v2");
-- 
2.34.1

