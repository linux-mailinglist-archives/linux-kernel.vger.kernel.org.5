Return-Path: <linux-kernel+bounces-77003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 203E885FFE8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18B84B21DE8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC2C157E96;
	Thu, 22 Feb 2024 17:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="pprGmazZ"
Received: from smtp35.i.mail.ru (smtp35.i.mail.ru [95.163.41.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9D7157E6E;
	Thu, 22 Feb 2024 17:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.41.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708623789; cv=none; b=bKFs7Rl3gibwrww0v/Zven+zjRKS/tIqHyN5fl1CptuHB3ERMpxH76f5vYwFf8QLzPffWuzDOQZPsKEEU1LLZ4zvVGeE8iiSDsasWd/4apkCFgH7o9AUBS5Ln5+DlDrHvIwvsspZCexJoYPi0fMpJZQ7v+mDTULpKYYvoISvayE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708623789; c=relaxed/simple;
	bh=VtozDrxobgdtRIbd27xKm5b4LglT1PbMr7fieiFR0uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bji2uEMTpEgWIpxLZmN56iBIMBQnAyyQ+W77oDkPmnq+e0PNjs7VRztuqfKfEHrBPHWCfnWseO9mJfblBrMC+l2p+BauAmjCwY23qzshb2ODAPrhX1j2+SgecCPqXhEAkhVrb1kuhiZ5qs68eG1B7vRG6s6rl51adnCjHKzK7/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=pprGmazZ; arc=none smtp.client-ip=95.163.41.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=lFatSS226kf3ZShJ8GerGZZdtnynncQ+9d4cu4m45Dk=; t=1708623785; x=1708713785; 
	b=pprGmazZwGKbt0ywZ9ScwvCsT8DPNGw2C+bpAtDZcAoaV/vwtMRyCuXRq5zX+pp2iWiZ/HWWNwj
	uWHi1a5U2KgOyRLCSb6Tnd05CX0LSO8BLWEP72YquEfbRQkC567CB1nFttudHqh6Vv3/YNH/hdDQx
	CBaxJrhI0ggDAeHydpM=;
Received: by smtp35.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rdD60-0000000BMIH-3yBD; Thu, 22 Feb 2024 20:42:57 +0300
From: Danila Tikhonov <danila@jiaxyga.com>
To: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	djakov@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH v2 2/2] interconnect: qcom: Add SM7150 driver support
Date: Thu, 22 Feb 2024 20:42:50 +0300
Message-ID: <20240222174250.80493-3-danila@jiaxyga.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222174250.80493-1-danila@jiaxyga.com>
References: <20240222174250.80493-1-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp35.i.mail.ru; auth=pass smtp.auth=danila@jiaxyga.com smtp.mailfrom=danila@jiaxyga.com
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD90B4B6FE9E606E49608DAFE9E459E38989865A082B2C70E3E00894C459B0CD1B94D596CB753629C7DB43C08EBA11A768FDA92ADFB3C2F15DCA8C6E334B36864FEFA673BDF079014B0
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE76113262358FC6936EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006377F69ABDCCC31D2058638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D848483BBF759ACD28E3BE5448EA843F6257DB2591504804AECC7F00164DA146DAFE8445B8C89999728AA50765F79006375FFD5C25497261569FA2833FD35BB23D2EF20D2F80756B5F868A13BD56FB6657A471835C12D1D977725E5C173C3A84C37EF884183F8E4D67117882F4460429728AD0CFFFB425014E868A13BD56FB6657D81D268191BDAD3DC09775C1D3CA48CF1187D6212EC73B5EBA3038C0950A5D36C8A9BA7A39EFB766D91E3A1F190DE8FDBA3038C0950A5D36D5E8D9A59859A8B61AF6C331B05F503F76E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C2249D082881546D93491E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B61F2C8E835678F328089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A58EDDBE8F88802FFD5002B1117B3ED69636B62AD02DCDF7153E67C18142C611B7823CB91A9FED034534781492E4B8EEADEF0AF71940E62277C79554A2A72441328621D336A7BC284946AD531847A6065ACF36E64A7E3F8E58BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF85C7F1D2E5F1A6C413FB25FA4AE00169AE9B3B884AE5BCF85B3896B6C30E2866ACCA692FBCDC96C20C89D780EEF94DBE32787458B1542231DEAC876D50C401A661B6E0FAD97BBADCAF108DC32EA72A8402C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojjw0udeJQYBQu67C/pWFp2w==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C739498127757F9F4B56E408F6A6F50B1491C035FC41B719F86D24CA099D9F4A075280232C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

Add a driver that handles the different NoCs found on SM7150, based on the
downstream dtb.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 drivers/interconnect/qcom/Kconfig  |    9 +
 drivers/interconnect/qcom/Makefile |    2 +
 drivers/interconnect/qcom/sm7150.c | 1754 ++++++++++++++++++++++++++++
 drivers/interconnect/qcom/sm7150.h |  140 +++
 4 files changed, 1905 insertions(+)
 create mode 100644 drivers/interconnect/qcom/sm7150.c
 create mode 100644 drivers/interconnect/qcom/sm7150.h

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index 48b1d5434cd0..1446a839184e 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -218,6 +218,15 @@ config INTERCONNECT_QCOM_SM6350
 	  This is a driver for the Qualcomm Network-on-Chip on sm6350-based
 	  platforms.
 
+config INTERCONNECT_QCOM_SM7150
+	tristate "Qualcomm SM7150 interconnect driver"
+	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	select INTERCONNECT_QCOM_RPMH
+	select INTERCONNECT_QCOM_BCM_VOTER
+	help
+	  This is a driver for the Qualcomm Network-on-Chip on sm7150-based
+	  platforms.
+
 config INTERCONNECT_QCOM_SM8150
 	tristate "Qualcomm SM8150 interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
index 83a3c1fc8155..2ea3113d0a4d 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -27,6 +27,7 @@ qnoc-sdx65-objs				:= sdx65.o
 qnoc-sdx75-objs				:= sdx75.o
 qnoc-sm6115-objs			:= sm6115.o
 qnoc-sm6350-objs			:= sm6350.o
+qnoc-sm7150-objs			:= sm7150.o
 qnoc-sm8150-objs			:= sm8150.o
 qnoc-sm8250-objs			:= sm8250.o
 qnoc-sm8350-objs			:= sm8350.o
@@ -60,6 +61,7 @@ obj-$(CONFIG_INTERCONNECT_QCOM_SDX65) += qnoc-sdx65.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SDX75) += qnoc-sdx75.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SM6115) += qnoc-sm6115.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SM6350) += qnoc-sm6350.o
+obj-$(CONFIG_INTERCONNECT_QCOM_SM7150) += qnoc-sm7150.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SM8150) += qnoc-sm8150.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SM8250) += qnoc-sm8250.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SM8350) += qnoc-sm8350.o
diff --git a/drivers/interconnect/qcom/sm7150.c b/drivers/interconnect/qcom/sm7150.c
new file mode 100644
index 000000000000..dc0d1343f510
--- /dev/null
+++ b/drivers/interconnect/qcom/sm7150.c
@@ -0,0 +1,1754 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2024, Danila Tikhonov <danila@jiaxyga.com>
+ */
+
+#include <linux/device.h>
+#include <linux/interconnect.h>
+#include <linux/interconnect-provider.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <dt-bindings/interconnect/qcom,sm7150-rpmh.h>
+
+#include "bcm-voter.h"
+#include "icc-rpmh.h"
+#include "sm7150.h"
+
+static struct qcom_icc_node qhm_a1noc_cfg = {
+	.name = "qhm-a1noc-cfg",
+	.id = SM7150_MASTER_A1NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM7150_SLAVE_SERVICE_A1NOC },
+};
+
+static struct qcom_icc_node qhm_qup_center = {
+	.name = "qhm_qup_center",
+	.id = SM7150_MASTER_QUP_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM7150_A1NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node qhm_tsif = {
+	.name = "qhm_tsif",
+	.id = SM7150_MASTER_TSIF,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM7150_A1NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node xm_emmc = {
+	.name = "xm_emmc",
+	.id = SM7150_MASTER_EMMC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM7150_A1NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node xm_sdc2 = {
+	.name = "xm_sdc2",
+	.id = SM7150_MASTER_SDCC_2,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM7150_A1NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node xm_sdc4 = {
+	.name = "xm_sdc4",
+	.id = SM7150_MASTER_SDCC_4,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM7150_A1NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node xm_ufs_mem = {
+	.name = "xm_ufs_mem",
+	.id = SM7150_MASTER_UFS_MEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM7150_A1NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node qhm_a2noc_cfg = {
+	.name = "qhm_a2noc_cfg",
+	.id = SM7150_MASTER_A2NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM7150_SLAVE_SERVICE_A2NOC },
+};
+
+static struct qcom_icc_node qhm_qdss_bam = {
+	.name = "qhm_qdss_bam",
+	.id = SM7150_MASTER_QDSS_BAM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM7150_A2NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node qhm_qup_north = {
+	.name = "qhm_qup_north",
+	.id = SM7150_MASTER_QUP_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM7150_A2NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node qnm_cnoc = {
+	.name = "qnm_cnoc",
+	.id = SM7150_MASTER_CNOC_A2NOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM7150_A2NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node qxm_crypto = {
+	.name = "qxm_crypto",
+	.id = SM7150_MASTER_CRYPTO_CORE_0,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM7150_A2NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node qxm_ipa = {
+	.name = "qxm_ipa",
+	.id = SM7150_MASTER_IPA,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM7150_A2NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node xm_pcie3_0 = {
+	.name = "xm_pcie3_0",
+	.id = SM7150_MASTER_PCIE,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM7150_SLAVE_ANOC_PCIE_GEM_NOC },
+};
+
+static struct qcom_icc_node xm_qdss_etr = {
+	.name = "xm_qdss_etr",
+	.id = SM7150_MASTER_QDSS_ETR,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM7150_A2NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node xm_usb3_0 = {
+	.name = "xm_usb3_0",
+	.id = SM7150_MASTER_USB3,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM7150_A2NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node qxm_camnoc_hf0_uncomp = {
+	.name = "qxm_camnoc_hf0_uncomp",
+	.id = SM7150_MASTER_CAMNOC_HF0_UNCOMP,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM7150_SLAVE_CAMNOC_UNCOMP },
+};
+
+static struct qcom_icc_node qxm_camnoc_rt_uncomp = {
+	.name = "qxm_camnoc_rt_uncomp",
+	.id = SM7150_MASTER_CAMNOC_RT_UNCOMP,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM7150_SLAVE_CAMNOC_UNCOMP },
+};
+
+static struct qcom_icc_node qxm_camnoc_sf_uncomp = {
+	.name = "qxm_camnoc_sf_uncomp",
+	.id = SM7150_MASTER_CAMNOC_SF_UNCOMP,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM7150_SLAVE_CAMNOC_UNCOMP },
+};
+
+static struct qcom_icc_node qxm_camnoc_nrt_uncomp = {
+	.name = "qxm_camnoc_nrt_uncomp",
+	.id = SM7150_MASTER_CAMNOC_NRT_UNCOMP,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM7150_SLAVE_CAMNOC_UNCOMP },
+};
+
+static struct qcom_icc_node qnm_npu = {
+	.name = "qnm_npu",
+	.id = SM7150_MASTER_NPU,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM7150_SLAVE_CDSP_GEM_NOC },
+};
+
+static struct qcom_icc_node qhm_spdm = {
+	.name = "qhm_spdm",
+	.id = SM7150_MASTER_SPDM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM7150_SLAVE_CNOC_A2NOC },
+};
+
+static struct qcom_icc_node qnm_snoc = {
+	.name = "qnm_snoc",
+	.id = SM7150_SNOC_CNOC_MAS,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 47,
+	.links = { SM7150_SLAVE_TLMM_SOUTH,
+		   SM7150_SLAVE_CAMERA_CFG,
+		   SM7150_SLAVE_SDCC_4,
+		   SM7150_SLAVE_SDCC_2,
+		   SM7150_SLAVE_CNOC_MNOC_CFG,
+		   SM7150_SLAVE_UFS_MEM_CFG,
+		   SM7150_SLAVE_QUP_0,
+		   SM7150_SLAVE_GLM,
+		   SM7150_SLAVE_PDM,
+		   SM7150_SLAVE_CAMERA_NRT_THROTTLE_CFG,
+		   SM7150_SLAVE_A2NOC_CFG,
+		   SM7150_SLAVE_QDSS_CFG,
+		   SM7150_SLAVE_CAMERA_RT_THROTTLE_CFG,
+		   SM7150_SLAVE_DISPLAY_CFG,
+		   SM7150_SLAVE_PCIE_CFG,
+		   SM7150_SLAVE_DISPLAY_THROTTLE_CFG,
+		   SM7150_SLAVE_TCSR,
+		   SM7150_SLAVE_VENUS_CVP_THROTTLE_CFG,
+		   SM7150_SLAVE_CNOC_DDRSS,
+		   SM7150_SLAVE_AHB2PHY_NORTH,
+		   SM7150_SLAVE_SNOC_CFG,
+		   SM7150_SLAVE_GRAPHICS_3D_CFG,
+		   SM7150_SLAVE_VENUS_CFG,
+		   SM7150_SLAVE_TSIF,
+		   SM7150_SLAVE_CDSP_CFG,
+		   SM7150_SLAVE_CLK_CTL,
+		   SM7150_SLAVE_AOP,
+		   SM7150_SLAVE_QUP_1,
+		   SM7150_SLAVE_AHB2PHY_SOUTH,
+		   SM7150_SLAVE_SERVICE_CNOC,
+		   SM7150_SLAVE_AHB2PHY_WEST,
+		   SM7150_SLAVE_USB3,
+		   SM7150_SLAVE_VENUS_THROTTLE_CFG,
+		   SM7150_SLAVE_IPA_CFG,
+		   SM7150_SLAVE_RBCPR_CX_CFG,
+		   SM7150_SLAVE_TLMM_WEST,
+		   SM7150_SLAVE_A1NOC_CFG,
+		   SM7150_SLAVE_AOSS,
+		   SM7150_SLAVE_PRNG,
+		   SM7150_SLAVE_VSENSE_CTRL_CFG,
+		   SM7150_SLAVE_EMMC_CFG,
+		   SM7150_SLAVE_SPDM_WRAPPER,
+		   SM7150_SLAVE_CRYPTO_0_CFG,
+		   SM7150_SLAVE_PIMEM_CFG,
+		   SM7150_SLAVE_TLMM_NORTH,
+		   SM7150_SLAVE_RBCPR_MX_CFG,
+		   SM7150_SLAVE_IMEM_CFG
+	},
+};
+
+static struct qcom_icc_node xm_qdss_dap = {
+	.name = "xm_qdss_dap",
+	.id = SM7150_MASTER_QDSS_DAP,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 48,
+	.links = { SM7150_SLAVE_TLMM_SOUTH,
+		   SM7150_SLAVE_CAMERA_CFG,
+		   SM7150_SLAVE_SDCC_4,
+		   SM7150_SLAVE_SDCC_2,
+		   SM7150_SLAVE_CNOC_MNOC_CFG,
+		   SM7150_SLAVE_UFS_MEM_CFG,
+		   SM7150_SLAVE_QUP_0,
+		   SM7150_SLAVE_GLM,
+		   SM7150_SLAVE_PDM,
+		   SM7150_SLAVE_CAMERA_NRT_THROTTLE_CFG,
+		   SM7150_SLAVE_A2NOC_CFG,
+		   SM7150_SLAVE_QDSS_CFG,
+		   SM7150_SLAVE_CAMERA_RT_THROTTLE_CFG,
+		   SM7150_SLAVE_DISPLAY_CFG,
+		   SM7150_SLAVE_PCIE_CFG,
+		   SM7150_SLAVE_DISPLAY_THROTTLE_CFG,
+		   SM7150_SLAVE_TCSR,
+		   SM7150_SLAVE_VENUS_CVP_THROTTLE_CFG,
+		   SM7150_SLAVE_CNOC_DDRSS,
+		   SM7150_SLAVE_CNOC_A2NOC,
+		   SM7150_SLAVE_AHB2PHY_NORTH,
+		   SM7150_SLAVE_SNOC_CFG,
+		   SM7150_SLAVE_GRAPHICS_3D_CFG,
+		   SM7150_SLAVE_VENUS_CFG,
+		   SM7150_SLAVE_TSIF,
+		   SM7150_SLAVE_CDSP_CFG,
+		   SM7150_SLAVE_CLK_CTL,
+		   SM7150_SLAVE_AOP,
+		   SM7150_SLAVE_QUP_1,
+		   SM7150_SLAVE_AHB2PHY_SOUTH,
+		   SM7150_SLAVE_SERVICE_CNOC,
+		   SM7150_SLAVE_AHB2PHY_WEST,
+		   SM7150_SLAVE_USB3,
+		   SM7150_SLAVE_VENUS_THROTTLE_CFG,
+		   SM7150_SLAVE_IPA_CFG,
+		   SM7150_SLAVE_RBCPR_CX_CFG,
+		   SM7150_SLAVE_TLMM_WEST,
+		   SM7150_SLAVE_A1NOC_CFG,
+		   SM7150_SLAVE_AOSS,
+		   SM7150_SLAVE_PRNG,
+		   SM7150_SLAVE_VSENSE_CTRL_CFG,
+		   SM7150_SLAVE_EMMC_CFG,
+		   SM7150_SLAVE_SPDM_WRAPPER,
+		   SM7150_SLAVE_CRYPTO_0_CFG,
+		   SM7150_SLAVE_PIMEM_CFG,
+		   SM7150_SLAVE_TLMM_NORTH,
+		   SM7150_SLAVE_RBCPR_MX_CFG,
+		   SM7150_SLAVE_IMEM_CFG
+	},
+};
+
+static struct qcom_icc_node qhm_cnoc_dc_noc = {
+	.name = "qhm_cnoc_dc_noc",
+	.id = SM7150_MASTER_CNOC_DC_NOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 2,
+	.links = { SM7150_SLAVE_LLCC_CFG,
+		   SM7150_SLAVE_GEM_NOC_CFG
+	},
+};
+
+static struct qcom_icc_node acm_apps = {
+	.name = "acm_apps",
+	.id = SM7150_MASTER_AMPSS_M0,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 2,
+	.links = { SM7150_SLAVE_LLCC,
+		   SM7150_SLAVE_GEM_NOC_SNOC
+	},
+};
+
+static struct qcom_icc_node acm_sys_tcu = {
+	.name = "acm_sys_tcu",
+	.id = SM7150_MASTER_SYS_TCU,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SM7150_SLAVE_LLCC,
+		   SM7150_SLAVE_GEM_NOC_SNOC
+	},
+};
+
+static struct qcom_icc_node qhm_gemnoc_cfg = {
+	.name = "qhm_gemnoc_cfg",
+	.id = SM7150_MASTER_GEM_NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 2,
+	.links = { SM7150_SLAVE_SERVICE_GEM_NOC,
+		   SM7150_SLAVE_MSS_PROC_MS_MPU_CFG
+	},
+};
+
+static struct qcom_icc_node qnm_cmpnoc = {
+	.name = "qnm_cmpnoc",
+	.id = SM7150_MASTER_COMPUTE_NOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SM7150_SLAVE_LLCC,
+		   SM7150_SLAVE_GEM_NOC_SNOC
+	},
+};
+
+static struct qcom_icc_node qnm_mnoc_hf = {
+	.name = "qnm_mnoc_hf",
+	.id = SM7150_MASTER_MNOC_HF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM7150_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_mnoc_sf = {
+	.name = "qnm_mnoc_sf",
+	.id = SM7150_MASTER_MNOC_SF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SM7150_SLAVE_LLCC,
+		   SM7150_SLAVE_GEM_NOC_SNOC
+	},
+};
+
+static struct qcom_icc_node qnm_pcie = {
+	.name = "qnm_pcie",
+	.id = SM7150_MASTER_GEM_NOC_PCIE_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SM7150_SLAVE_LLCC,
+		   SM7150_SLAVE_GEM_NOC_SNOC
+	},
+};
+
+static struct qcom_icc_node qnm_snoc_gc = {
+	.name = "qnm_snoc_gc",
+	.id = SM7150_MASTER_SNOC_GC_MEM_NOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM7150_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_snoc_sf = {
+	.name = "qnm_snoc_sf",
+	.id = SM7150_MASTER_SNOC_SF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM7150_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qxm_gpu = {
+	.name = "qxm_gpu",
+	.id = SM7150_MASTER_GRAPHICS_3D,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SM7150_SLAVE_LLCC,
+		   SM7150_SLAVE_GEM_NOC_SNOC
+	},
+};
+
+static struct qcom_icc_node llcc_mc = {
+	.name = "llcc_mc",
+	.id = SM7150_MASTER_LLCC,
+	.channels = 2,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM7150_SLAVE_EBI_CH0 },
+};
+
+static struct qcom_icc_node qhm_mnoc_cfg = {
+	.name = "qhm_mnoc_cfg",
+	.id = SM7150_MASTER_CNOC_MNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM7150_SLAVE_SERVICE_MNOC },
+};
+
+static struct qcom_icc_node qxm_camnoc_hf = {
+	.name = "qxm_camnoc_hf",
+	.id = SM7150_MASTER_CAMNOC_HF0,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM7150_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_camnoc_nrt = {
+	.name = "qxm_camnoc_nrt",
+	.id = SM7150_MASTER_CAMNOC_NRT,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM7150_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_camnoc_rt = {
+	.name = "qxm_camnoc_rt",
+	.id = SM7150_MASTER_CAMNOC_RT,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM7150_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_camnoc_sf = {
+	.name = "qxm_camnoc_sf",
+	.id = SM7150_MASTER_CAMNOC_SF,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM7150_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_mdp0 = {
+	.name = "qxm_mdp0",
+	.id = SM7150_MASTER_MDP_PORT0,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM7150_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_mdp1 = {
+	.name = "qxm_mdp1",
+	.id = SM7150_MASTER_MDP_PORT1,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM7150_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_rot = {
+	.name = "qxm_rot",
+	.id = SM7150_MASTER_ROTATOR,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM7150_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_venus0 = {
+	.name = "qxm_venus0",
+	.id = SM7150_MASTER_VIDEO_P0,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM7150_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_venus1 = {
+	.name = "qxm_venus1",
+	.id = SM7150_MASTER_VIDEO_P1,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM7150_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_venus_arm9 = {
+	.name = "qxm_venus_arm9",
+	.id = SM7150_MASTER_VIDEO_PROC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM7150_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qhm_snoc_cfg = {
+	.name = "qhm_snoc_cfg",
+	.id = SM7150_MASTER_SNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM7150_SLAVE_SERVICE_SNOC },
+};
+
+static struct qcom_icc_node qnm_aggre1_noc = {
+	.name = "qnm_aggre1_noc",
+	.id = SM7150_A1NOC_SNOC_MAS,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 6,
+	.links = { SM7150_SLAVE_SNOC_GEM_NOC_SF,
+		   SM7150_SLAVE_PIMEM,
+		   SM7150_SLAVE_OCIMEM,
+		   SM7150_SLAVE_APPSS,
+		   SM7150_SNOC_CNOC_SLV,
+		   SM7150_SLAVE_QDSS_STM
+	},
+};
+
+static struct qcom_icc_node qnm_aggre2_noc = {
+	.name = "qnm_aggre2_noc",
+	.id = SM7150_A2NOC_SNOC_MAS,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 7,
+	.links = { SM7150_SLAVE_SNOC_GEM_NOC_SF,
+		   SM7150_SLAVE_PIMEM,
+		   SM7150_SLAVE_OCIMEM,
+		   SM7150_SLAVE_APPSS,
+		   SM7150_SNOC_CNOC_SLV,
+		   SM7150_SLAVE_TCU,
+		   SM7150_SLAVE_QDSS_STM
+	},
+};
+
+static struct qcom_icc_node qnm_gemnoc = {
+	.name = "qnm_gemnoc",
+	.id = SM7150_MASTER_GEM_NOC_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 6,
+	.links = { SM7150_SLAVE_PIMEM,
+		   SM7150_SLAVE_OCIMEM,
+		   SM7150_SLAVE_APPSS,
+		   SM7150_SNOC_CNOC_SLV,
+		   SM7150_SLAVE_TCU,
+		   SM7150_SLAVE_QDSS_STM
+	},
+};
+
+static struct qcom_icc_node qxm_pimem = {
+	.name = "qxm_pimem",
+	.id = SM7150_MASTER_PIMEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SM7150_SLAVE_SNOC_GEM_NOC_GC,
+		   SM7150_SLAVE_OCIMEM
+	},
+};
+
+static struct qcom_icc_node xm_gic = {
+	.name = "xm_gic",
+	.id = SM7150_MASTER_GIC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SM7150_SLAVE_SNOC_GEM_NOC_GC,
+		   SM7150_SLAVE_OCIMEM
+	},
+};
+
+static struct qcom_icc_node qns_a1noc_snoc = {
+	.name = "qns_a1noc_snoc",
+	.id = SM7150_A1NOC_SNOC_SLV,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM7150_A1NOC_SNOC_MAS },
+};
+
+static struct qcom_icc_node srvc_aggre1_noc = {
+	.name = "srvc_aggre1_noc",
+	.id = SM7150_SLAVE_SERVICE_A1NOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_a2noc_snoc = {
+	.name = "qns_a2noc_snoc",
+	.id = SM7150_A2NOC_SNOC_SLV,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM7150_A2NOC_SNOC_MAS },
+};
+
+static struct qcom_icc_node qns_pcie_gemnoc = {
+	.name = "qns_pcie_gemnoc",
+	.id = SM7150_SLAVE_ANOC_PCIE_GEM_NOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM7150_MASTER_GEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node srvc_aggre2_noc = {
+	.name = "srvc_aggre2_noc",
+	.id = SM7150_SLAVE_SERVICE_A2NOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_camnoc_uncomp = {
+	.name = "qns_camnoc_uncomp",
+	.id = SM7150_SLAVE_CAMNOC_UNCOMP,
+	.channels = 1,
+	.buswidth = 32,
+};
+
+static struct qcom_icc_node qns_cdsp_gemnoc = {
+	.name = "qns_cdsp_gemnoc",
+	.id = SM7150_SLAVE_CDSP_GEM_NOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM7150_MASTER_COMPUTE_NOC },
+};
+
+static struct qcom_icc_node qhs_a1_noc_cfg = {
+	.name = "qhs_a1_noc_cfg",
+	.id = SM7150_SLAVE_A1NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM7150_MASTER_A1NOC_CFG },
+};
+
+static struct qcom_icc_node qhs_a2_noc_cfg = {
+	.name = "qhs_a2_noc_cfg",
+	.id = SM7150_SLAVE_A2NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM7150_MASTER_A2NOC_CFG },
+};
+
+static struct qcom_icc_node qhs_ahb2phy_north = {
+	.name = "qhs_ahb2phy_north",
+	.id = SM7150_SLAVE_AHB2PHY_NORTH,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ahb2phy_south = {
+	.name = "qhs_ahb2phy_south",
+	.id = SM7150_SLAVE_AHB2PHY_SOUTH,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ahb2phy_west = {
+	.name = "qhs_ahb2phy_west",
+	.id = SM7150_SLAVE_AHB2PHY_WEST,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_aop = {
+	.name = "qhs_aop",
+	.id = SM7150_SLAVE_AOP,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_aoss = {
+	.name = "qhs_aoss",
+	.id = SM7150_SLAVE_AOSS,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_camera_cfg = {
+	.name = "qhs_camera_cfg",
+	.id = SM7150_SLAVE_CAMERA_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_camera_nrt_thrott_cfg = {
+	.name = "qhs_camera_nrt_thrott_cfg",
+	.id = SM7150_SLAVE_CAMERA_NRT_THROTTLE_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_camera_rt_throttle_cfg = {
+	.name = "qhs_camera_rt_throttle_cfg",
+	.id = SM7150_SLAVE_CAMERA_RT_THROTTLE_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_clk_ctl = {
+	.name = "qhs_clk_ctl",
+	.id = SM7150_SLAVE_CLK_CTL,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_compute_dsp_cfg = {
+	.name = "qhs_compute_dsp_cfg",
+	.id = SM7150_SLAVE_CDSP_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_cpr_cx = {
+	.name = "qhs_cpr_cx",
+	.id = SM7150_SLAVE_RBCPR_CX_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_cpr_mx = {
+	.name = "qhs_cpr_mx",
+	.id = SM7150_SLAVE_RBCPR_MX_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_crypto0_cfg = {
+	.name = "qhs_crypto0_cfg",
+	.id = SM7150_SLAVE_CRYPTO_0_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ddrss_cfg = {
+	.name = "qhs_ddrss_cfg",
+	.id = SM7150_SLAVE_CNOC_DDRSS,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM7150_MASTER_CNOC_DC_NOC },
+};
+
+static struct qcom_icc_node qhs_display_cfg = {
+	.name = "qhs_display_cfg",
+	.id = SM7150_SLAVE_DISPLAY_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_display_throttle_cfg = {
+	.name = "qhs_display_throttle_cfg",
+	.id = SM7150_SLAVE_DISPLAY_THROTTLE_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_emmc_cfg = {
+	.name = "qhs_emmc_cfg",
+	.id = SM7150_SLAVE_EMMC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_glm = {
+	.name = "qhs_glm",
+	.id = SM7150_SLAVE_GLM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_gpuss_cfg = {
+	.name = "qhs_gpuss_cfg",
+	.id = SM7150_SLAVE_GRAPHICS_3D_CFG,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qhs_imem_cfg = {
+	.name = "qhs_imem_cfg",
+	.id = SM7150_SLAVE_IMEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ipa = {
+	.name = "qhs_ipa",
+	.id = SM7150_SLAVE_IPA_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_mnoc_cfg = {
+	.name = "qhs_mnoc_cfg",
+	.id = SM7150_SLAVE_CNOC_MNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM7150_MASTER_CNOC_MNOC_CFG },
+};
+
+static struct qcom_icc_node qhs_pcie_cfg = {
+	.name = "qhs_pcie_cfg",
+	.id = SM7150_SLAVE_PCIE_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pdm = {
+	.name = "qhs_pdm",
+	.id = SM7150_SLAVE_PDM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pimem_cfg = {
+	.name = "qhs_pimem_cfg",
+	.id = SM7150_SLAVE_PIMEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_prng = {
+	.name = "qhs_prng",
+	.id = SM7150_SLAVE_PRNG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qdss_cfg = {
+	.name = "qhs_qdss_cfg",
+	.id = SM7150_SLAVE_QDSS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qupv3_center = {
+	.name = "qhs_qupv3_center",
+	.id = SM7150_SLAVE_QUP_0,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qupv3_north = {
+	.name = "qhs_qupv3_north",
+	.id = SM7150_SLAVE_QUP_1,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_sdc2 = {
+	.name = "qhs_sdc2",
+	.id = SM7150_SLAVE_SDCC_2,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_sdc4 = {
+	.name = "qhs_sdc4",
+	.id = SM7150_SLAVE_SDCC_4,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_snoc_cfg = {
+	.name = "qhs_snoc_cfg",
+	.id = SM7150_SLAVE_SNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM7150_MASTER_SNOC_CFG },
+};
+
+static struct qcom_icc_node qhs_spdm = {
+	.name = "qhs_spdm",
+	.id = SM7150_SLAVE_SPDM_WRAPPER,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tcsr = {
+	.name = "qhs_tcsr",
+	.id = SM7150_SLAVE_TCSR,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tlmm_north = {
+	.name = "qhs_tlmm_north",
+	.id = SM7150_SLAVE_TLMM_NORTH,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tlmm_south = {
+	.name = "qhs_tlmm_south",
+	.id = SM7150_SLAVE_TLMM_SOUTH,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tlmm_west = {
+	.name = "qhs_tlmm_west",
+	.id = SM7150_SLAVE_TLMM_WEST,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tsif = {
+	.name = "qhs_tsif",
+	.id = SM7150_SLAVE_TSIF,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ufs_mem_cfg = {
+	.name = "qhs_ufs_mem_cfg",
+	.id = SM7150_SLAVE_UFS_MEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_usb3_0 = {
+	.name = "qhs_usb3_0",
+	.id = SM7150_SLAVE_USB3,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_venus_cfg = {
+	.name = "qhs_venus_cfg",
+	.id = SM7150_SLAVE_VENUS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_venus_cvp_throttle_cfg = {
+	.name = "qhs_venus_cvp_throttle_cfg",
+	.id = SM7150_SLAVE_VENUS_CVP_THROTTLE_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_venus_throttle_cfg = {
+	.name = "qhs_venus_throttle_cfg",
+	.id = SM7150_SLAVE_VENUS_THROTTLE_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_vsense_ctrl_cfg = {
+	.name = "qhs_vsense_ctrl_cfg",
+	.id = SM7150_SLAVE_VSENSE_CTRL_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_cnoc_a2noc = {
+	.name = "qns_cnoc_a2noc",
+	.id = SM7150_SLAVE_CNOC_A2NOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM7150_MASTER_CNOC_A2NOC },
+};
+
+static struct qcom_icc_node srvc_cnoc = {
+	.name = "srvc_cnoc",
+	.id = SM7150_SLAVE_SERVICE_CNOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_gemnoc = {
+	.name = "qhs_gemnoc",
+	.id = SM7150_SLAVE_GEM_NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM7150_MASTER_GEM_NOC_CFG },
+};
+
+static struct qcom_icc_node qhs_llcc = {
+	.name = "qhs_llcc",
+	.id = SM7150_SLAVE_LLCC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_mdsp_ms_mpu_cfg = {
+	.name = "qhs_mdsp_ms_mpu_cfg",
+	.id = SM7150_SLAVE_MSS_PROC_MS_MPU_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_gem_noc_snoc = {
+	.name = "qns_gem_noc_snoc",
+	.id = SM7150_SLAVE_GEM_NOC_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM7150_MASTER_GEM_NOC_SNOC },
+};
+
+static struct qcom_icc_node qns_llcc = {
+	.name = "qns_llcc",
+	.id = SM7150_SLAVE_LLCC,
+	.channels = 2,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM7150_MASTER_LLCC },
+};
+
+static struct qcom_icc_node srvc_gemnoc = {
+	.name = "srvc_gemnoc",
+	.id = SM7150_SLAVE_SERVICE_GEM_NOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node ebi = {
+	.name = "ebi",
+	.id = SM7150_SLAVE_EBI_CH0,
+	.channels = 2,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns2_mem_noc = {
+	.name = "qns2_mem_noc",
+	.id = SM7150_SLAVE_MNOC_SF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM7150_MASTER_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qns_mem_noc_hf = {
+	.name = "qns_mem_noc_hf",
+	.id = SM7150_SLAVE_MNOC_HF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM7150_MASTER_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node srvc_mnoc = {
+	.name = "srvc_mnoc",
+	.id = SM7150_SLAVE_SERVICE_MNOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_apss = {
+	.name = "qhs_apss",
+	.id = SM7150_SLAVE_APPSS,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qns_cnoc = {
+	.name = "qns_cnoc",
+	.id = SM7150_SNOC_CNOC_SLV,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM7150_SNOC_CNOC_MAS },
+};
+
+static struct qcom_icc_node qns_gemnoc_gc = {
+	.name = "qns_gemnoc_gc",
+	.id = SM7150_SLAVE_SNOC_GEM_NOC_GC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM7150_MASTER_SNOC_GC_MEM_NOC },
+};
+
+static struct qcom_icc_node qns_gemnoc_sf = {
+	.name = "qns_gemnoc_sf",
+	.id = SM7150_SLAVE_SNOC_GEM_NOC_SF,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM7150_MASTER_SNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxs_imem = {
+	.name = "qxs_imem",
+	.id = SM7150_SLAVE_OCIMEM,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qxs_pimem = {
+	.name = "qxs_pimem",
+	.id = SM7150_SLAVE_PIMEM,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node srvc_snoc = {
+	.name = "srvc_snoc",
+	.id = SM7150_SLAVE_SERVICE_SNOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node xs_qdss_stm = {
+	.name = "xs_qdss_stm",
+	.id = SM7150_SLAVE_QDSS_STM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node xs_sys_tcu_cfg = {
+	.name = "xs_sys_tcu_cfg",
+	.id = SM7150_SLAVE_TCU,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_bcm bcm_acv = {
+	.name = "ACV",
+	.enable_mask = BIT(3),
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &ebi },
+};
+
+static struct qcom_icc_bcm bcm_mc0 = {
+	.name = "MC0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &ebi },
+};
+
+static struct qcom_icc_bcm bcm_sh0 = {
+	.name = "SH0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_llcc },
+};
+
+static struct qcom_icc_bcm bcm_mm0 = {
+	.name = "MM0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_mem_noc_hf },
+};
+
+static struct qcom_icc_bcm bcm_mm1 = {
+	.name = "MM1",
+	.keepalive = true,
+	.num_nodes = 8,
+	.nodes = { &qxm_camnoc_hf0_uncomp,
+		   &qxm_camnoc_rt_uncomp,
+		   &qxm_camnoc_sf_uncomp,
+		   &qxm_camnoc_nrt_uncomp,
+		   &qxm_camnoc_hf,
+		   &qxm_camnoc_rt,
+		   &qxm_mdp0,
+		   &qxm_mdp1
+	},
+};
+
+static struct qcom_icc_bcm bcm_sh2 = {
+	.name = "SH2",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qns_gem_noc_snoc },
+};
+
+static struct qcom_icc_bcm bcm_sh3 = {
+	.name = "SH3",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &acm_sys_tcu },
+};
+
+static struct qcom_icc_bcm bcm_mm2 = {
+	.name = "MM2",
+	.keepalive = false,
+	.num_nodes = 2,
+	.nodes = { &qxm_camnoc_nrt,
+		   &qns2_mem_noc
+	},
+};
+
+static struct qcom_icc_bcm bcm_mm3 = {
+	.name = "MM3",
+	.keepalive = false,
+	.num_nodes = 5,
+	.nodes = { &qxm_camnoc_sf,
+		   &qxm_rot,
+		   &qxm_venus0,
+		   &qxm_venus1,
+		   &qxm_venus_arm9
+	},
+};
+
+static struct qcom_icc_bcm bcm_sh5 = {
+	.name = "SH5",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &acm_apps },
+};
+
+static struct qcom_icc_bcm bcm_sn0 = {
+	.name = "SN0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_gemnoc_sf },
+};
+
+static struct qcom_icc_bcm bcm_sh8 = {
+	.name = "SH8",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qns_cdsp_gemnoc },
+};
+
+static struct qcom_icc_bcm bcm_sh10 = {
+	.name = "SH10",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qnm_npu },
+};
+
+static struct qcom_icc_bcm bcm_ce0 = {
+	.name = "CE0",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qxm_crypto },
+};
+
+static struct qcom_icc_bcm bcm_cn0 = {
+	.name = "CN0",
+	.keepalive = true,
+	.num_nodes = 54,
+	.nodes = { &qhm_tsif,
+		   &xm_emmc,
+		   &xm_sdc2,
+		   &xm_sdc4,
+		   &qhm_spdm,
+		   &qnm_snoc,
+		   &qhs_a1_noc_cfg,
+		   &qhs_a2_noc_cfg,
+		   &qhs_ahb2phy_north,
+		   &qhs_ahb2phy_south,
+		   &qhs_ahb2phy_west,
+		   &qhs_aop,
+		   &qhs_aoss,
+		   &qhs_camera_cfg,
+		   &qhs_camera_nrt_thrott_cfg,
+		   &qhs_camera_rt_throttle_cfg,
+		   &qhs_clk_ctl,
+		   &qhs_compute_dsp_cfg,
+		   &qhs_cpr_cx,
+		   &qhs_cpr_mx,
+		   &qhs_crypto0_cfg,
+		   &qhs_ddrss_cfg,
+		   &qhs_display_cfg,
+		   &qhs_display_throttle_cfg,
+		   &qhs_emmc_cfg,
+		   &qhs_glm,
+		   &qhs_gpuss_cfg,
+		   &qhs_imem_cfg,
+		   &qhs_ipa,
+		   &qhs_mnoc_cfg,
+		   &qhs_pcie_cfg,
+		   &qhs_pdm,
+		   &qhs_pimem_cfg,
+		   &qhs_prng,
+		   &qhs_qdss_cfg,
+		   &qhs_qupv3_center,
+		   &qhs_qupv3_north,
+		   &qhs_sdc2,
+		   &qhs_sdc4,
+		   &qhs_snoc_cfg,
+		   &qhs_spdm,
+		   &qhs_tcsr,
+		   &qhs_tlmm_north,
+		   &qhs_tlmm_south,
+		   &qhs_tlmm_west,
+		   &qhs_tsif,
+		   &qhs_ufs_mem_cfg,
+		   &qhs_usb3_0,
+		   &qhs_venus_cfg,
+		   &qhs_venus_cvp_throttle_cfg,
+		   &qhs_venus_throttle_cfg,
+		   &qhs_vsense_ctrl_cfg,
+		   &qns_cnoc_a2noc,
+		   &srvc_cnoc
+	},
+};
+
+static struct qcom_icc_bcm bcm_qup0 = {
+	.name = "QUP0",
+	.keepalive = false,
+	.num_nodes = 2,
+	.nodes = { &qhm_qup_center,
+		   &qhm_qup_north
+	},
+};
+
+static struct qcom_icc_bcm bcm_sn1 = {
+	.name = "SN1",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qxs_imem },
+};
+
+static struct qcom_icc_bcm bcm_sn2 = {
+	.name = "SN2",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qns_gemnoc_gc },
+};
+
+static struct qcom_icc_bcm bcm_sn4 = {
+	.name = "SN4",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qxs_pimem },
+};
+
+static struct qcom_icc_bcm bcm_sn9 = {
+	.name = "SN9",
+	.keepalive = false,
+	.num_nodes = 2,
+	.nodes = { &qnm_aggre1_noc,
+		   &qns_a1noc_snoc
+	},
+};
+
+static struct qcom_icc_bcm bcm_sn11 = {
+	.name = "SN11",
+	.keepalive = false,
+	.num_nodes = 2,
+	.nodes = { &qnm_aggre2_noc,
+		   &qns_a2noc_snoc
+	},
+};
+
+static struct qcom_icc_bcm bcm_sn12 = {
+	.name = "SN12",
+	.keepalive = false,
+	.num_nodes = 2,
+	.nodes = { &qxm_pimem,
+		   &xm_gic
+	},
+};
+
+static struct qcom_icc_bcm bcm_sn14 = {
+	.name = "SN14",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qns_pcie_gemnoc },
+};
+
+static struct qcom_icc_bcm bcm_sn15 = {
+	.name = "SN15",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qnm_gemnoc },
+};
+
+static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
+	&bcm_cn0,
+	&bcm_qup0,
+	&bcm_sn9,
+};
+
+static struct qcom_icc_node * const aggre1_noc_nodes[] = {
+	[MASTER_A1NOC_CFG] = &qhm_a1noc_cfg,
+	[MASTER_QUP_0] = &qhm_qup_center,
+	[MASTER_TSIF] = &qhm_tsif,
+	[MASTER_EMMC] = &xm_emmc,
+	[MASTER_SDCC_2] = &xm_sdc2,
+	[MASTER_SDCC_4] = &xm_sdc4,
+	[MASTER_UFS_MEM] = &xm_ufs_mem,
+	[A1NOC_SNOC_SLV] = &qns_a1noc_snoc,
+	[SLAVE_SERVICE_A1NOC] = &srvc_aggre1_noc,
+};
+
+static const struct qcom_icc_desc sm7150_aggre1_noc = {
+	.nodes = aggre1_noc_nodes,
+	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
+	.bcms = aggre1_noc_bcms,
+	.num_bcms = ARRAY_SIZE(aggre1_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const aggre2_noc_bcms[] = {
+	&bcm_ce0,
+	&bcm_qup0,
+	&bcm_sn11,
+	&bcm_sn14,
+};
+
+static struct qcom_icc_node * const aggre2_noc_nodes[] = {
+	[MASTER_A2NOC_CFG] = &qhm_a2noc_cfg,
+	[MASTER_QDSS_BAM] = &qhm_qdss_bam,
+	[MASTER_QUP_1] = &qhm_qup_north,
+	[MASTER_CNOC_A2NOC] = &qnm_cnoc,
+	[MASTER_CRYPTO_CORE_0] = &qxm_crypto,
+	[MASTER_IPA] = &qxm_ipa,
+	[MASTER_PCIE] = &xm_pcie3_0,
+	[MASTER_QDSS_ETR] = &xm_qdss_etr,
+	[MASTER_USB3] = &xm_usb3_0,
+	[A2NOC_SNOC_SLV] = &qns_a2noc_snoc,
+	[SLAVE_ANOC_PCIE_GEM_NOC] = &qns_pcie_gemnoc,
+	[SLAVE_SERVICE_A2NOC] = &srvc_aggre2_noc,
+};
+
+static const struct qcom_icc_desc sm7150_aggre2_noc = {
+	.nodes = aggre2_noc_nodes,
+	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
+	.bcms = aggre2_noc_bcms,
+	.num_bcms = ARRAY_SIZE(aggre2_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const camnoc_virt_bcms[] = {
+	&bcm_mm1,
+};
+
+static struct qcom_icc_node * const camnoc_virt_nodes[] = {
+	[MASTER_CAMNOC_HF0_UNCOMP] = &qxm_camnoc_hf0_uncomp,
+	[MASTER_CAMNOC_RT_UNCOMP] = &qxm_camnoc_rt_uncomp,
+	[MASTER_CAMNOC_SF_UNCOMP] = &qxm_camnoc_sf_uncomp,
+	[MASTER_CAMNOC_NRT_UNCOMP] = &qxm_camnoc_nrt_uncomp,
+	[SLAVE_CAMNOC_UNCOMP] = &qns_camnoc_uncomp,
+};
+
+static const struct qcom_icc_desc sm7150_camnoc_virt = {
+	.nodes = camnoc_virt_nodes,
+	.num_nodes = ARRAY_SIZE(camnoc_virt_nodes),
+	.bcms = camnoc_virt_bcms,
+	.num_bcms = ARRAY_SIZE(camnoc_virt_bcms),
+};
+
+static struct qcom_icc_bcm * const compute_noc_bcms[] = {
+	&bcm_sh10,
+	&bcm_sh8,
+};
+
+static struct qcom_icc_node * const compute_noc_nodes[] = {
+	[MASTER_NPU] = &qnm_npu,
+	[SLAVE_CDSP_GEM_NOC] = &qns_cdsp_gemnoc,
+};
+
+static const struct qcom_icc_desc sm7150_compute_noc = {
+	.nodes = compute_noc_nodes,
+	.num_nodes = ARRAY_SIZE(compute_noc_nodes),
+	.bcms = compute_noc_bcms,
+	.num_bcms = ARRAY_SIZE(compute_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const config_noc_bcms[] = {
+	&bcm_cn0,
+};
+
+static struct qcom_icc_node * const config_noc_nodes[] = {
+	[MASTER_SPDM] = &qhm_spdm,
+	[SNOC_CNOC_MAS] = &qnm_snoc,
+	[MASTER_QDSS_DAP] = &xm_qdss_dap,
+	[SLAVE_A1NOC_CFG] = &qhs_a1_noc_cfg,
+	[SLAVE_A2NOC_CFG] = &qhs_a2_noc_cfg,
+	[SLAVE_AHB2PHY_NORTH] = &qhs_ahb2phy_north,
+	[SLAVE_AHB2PHY_SOUTH] = &qhs_ahb2phy_south,
+	[SLAVE_AHB2PHY_WEST] = &qhs_ahb2phy_west,
+	[SLAVE_AOP] = &qhs_aop,
+	[SLAVE_AOSS] = &qhs_aoss,
+	[SLAVE_CAMERA_CFG] = &qhs_camera_cfg,
+	[SLAVE_CAMERA_NRT_THROTTLE_CFG] = &qhs_camera_nrt_thrott_cfg,
+	[SLAVE_CAMERA_RT_THROTTLE_CFG] = &qhs_camera_rt_throttle_cfg,
+	[SLAVE_CLK_CTL] = &qhs_clk_ctl,
+	[SLAVE_CDSP_CFG] = &qhs_compute_dsp_cfg,
+	[SLAVE_RBCPR_CX_CFG] = &qhs_cpr_cx,
+	[SLAVE_RBCPR_MX_CFG] = &qhs_cpr_mx,
+	[SLAVE_CRYPTO_0_CFG] = &qhs_crypto0_cfg,
+	[SLAVE_CNOC_DDRSS] = &qhs_ddrss_cfg,
+	[SLAVE_DISPLAY_CFG] = &qhs_display_cfg,
+	[SLAVE_DISPLAY_THROTTLE_CFG] = &qhs_display_throttle_cfg,
+	[SLAVE_EMMC_CFG] = &qhs_emmc_cfg,
+	[SLAVE_GLM] = &qhs_glm,
+	[SLAVE_GRAPHICS_3D_CFG] = &qhs_gpuss_cfg,
+	[SLAVE_IMEM_CFG] = &qhs_imem_cfg,
+	[SLAVE_IPA_CFG] = &qhs_ipa,
+	[SLAVE_CNOC_MNOC_CFG] = &qhs_mnoc_cfg,
+	[SLAVE_PCIE_CFG] = &qhs_pcie_cfg,
+	[SLAVE_PDM] = &qhs_pdm,
+	[SLAVE_PIMEM_CFG] = &qhs_pimem_cfg,
+	[SLAVE_PRNG] = &qhs_prng,
+	[SLAVE_QDSS_CFG] = &qhs_qdss_cfg,
+	[SLAVE_QUP_0] = &qhs_qupv3_center,
+	[SLAVE_QUP_1] = &qhs_qupv3_north,
+	[SLAVE_SDCC_2] = &qhs_sdc2,
+	[SLAVE_SDCC_4] = &qhs_sdc4,
+	[SLAVE_SNOC_CFG] = &qhs_snoc_cfg,
+	[SLAVE_SPDM_WRAPPER] = &qhs_spdm,
+	[SLAVE_TCSR] = &qhs_tcsr,
+	[SLAVE_TLMM_NORTH] = &qhs_tlmm_north,
+	[SLAVE_TLMM_SOUTH] = &qhs_tlmm_south,
+	[SLAVE_TLMM_WEST] = &qhs_tlmm_west,
+	[SLAVE_TSIF] = &qhs_tsif,
+	[SLAVE_UFS_MEM_CFG] = &qhs_ufs_mem_cfg,
+	[SLAVE_USB3] = &qhs_usb3_0,
+	[SLAVE_VENUS_CFG] = &qhs_venus_cfg,
+	[SLAVE_VENUS_CVP_THROTTLE_CFG] = &qhs_venus_cvp_throttle_cfg,
+	[SLAVE_VENUS_THROTTLE_CFG] = &qhs_venus_throttle_cfg,
+	[SLAVE_VSENSE_CTRL_CFG] = &qhs_vsense_ctrl_cfg,
+	[SLAVE_CNOC_A2NOC] = &qns_cnoc_a2noc,
+	[SLAVE_SERVICE_CNOC] = &srvc_cnoc,
+};
+
+static const struct qcom_icc_desc sm7150_config_noc = {
+	.nodes = config_noc_nodes,
+	.num_nodes = ARRAY_SIZE(config_noc_nodes),
+	.bcms = config_noc_bcms,
+	.num_bcms = ARRAY_SIZE(config_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const dc_noc_bcms[] = {
+};
+
+static struct qcom_icc_node * const dc_noc_nodes[] = {
+	[MASTER_CNOC_DC_NOC] = &qhm_cnoc_dc_noc,
+	[SLAVE_GEM_NOC_CFG] = &qhs_gemnoc,
+	[SLAVE_LLCC_CFG] = &qhs_llcc,
+};
+
+static const struct qcom_icc_desc sm7150_dc_noc = {
+	.nodes = dc_noc_nodes,
+	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
+	.bcms = dc_noc_bcms,
+	.num_bcms = ARRAY_SIZE(dc_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const gem_noc_bcms[] = {
+	&bcm_sh0,
+	&bcm_sh2,
+	&bcm_sh3,
+	&bcm_sh5,
+};
+
+static struct qcom_icc_node * const gem_noc_nodes[] = {
+	[MASTER_AMPSS_M0] = &acm_apps,
+	[MASTER_SYS_TCU] = &acm_sys_tcu,
+	[MASTER_GEM_NOC_CFG] = &qhm_gemnoc_cfg,
+	[MASTER_COMPUTE_NOC] = &qnm_cmpnoc,
+	[MASTER_MNOC_HF_MEM_NOC] = &qnm_mnoc_hf,
+	[MASTER_MNOC_SF_MEM_NOC] = &qnm_mnoc_sf,
+	[MASTER_GEM_NOC_PCIE_SNOC] = &qnm_pcie,
+	[MASTER_SNOC_GC_MEM_NOC] = &qnm_snoc_gc,
+	[MASTER_SNOC_SF_MEM_NOC] = &qnm_snoc_sf,
+	[MASTER_GRAPHICS_3D] = &qxm_gpu,
+	[SLAVE_MSS_PROC_MS_MPU_CFG] = &qhs_mdsp_ms_mpu_cfg,
+	[SLAVE_GEM_NOC_SNOC] = &qns_gem_noc_snoc,
+	[SLAVE_LLCC] = &qns_llcc,
+	[SLAVE_SERVICE_GEM_NOC] = &srvc_gemnoc,
+};
+
+static const struct qcom_icc_desc sm7150_gem_noc = {
+	.nodes = gem_noc_nodes,
+	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
+	.bcms = gem_noc_bcms,
+	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const mc_virt_bcms[] = {
+	&bcm_acv,
+	&bcm_mc0,
+};
+
+static struct qcom_icc_node * const mc_virt_nodes[] = {
+	[MASTER_LLCC] = &llcc_mc,
+	[SLAVE_EBI_CH0] = &ebi,
+};
+
+static const struct qcom_icc_desc sm7150_mc_virt = {
+	.nodes = mc_virt_nodes,
+	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
+	.bcms = mc_virt_bcms,
+	.num_bcms = ARRAY_SIZE(mc_virt_bcms),
+};
+
+static struct qcom_icc_bcm * const mmss_noc_bcms[] = {
+	&bcm_mm0,
+	&bcm_mm1,
+	&bcm_mm2,
+	&bcm_mm3,
+};
+
+static struct qcom_icc_node * const mmss_noc_nodes[] = {
+	[MASTER_CNOC_MNOC_CFG] = &qhm_mnoc_cfg,
+	[MASTER_CAMNOC_HF0] = &qxm_camnoc_hf,
+	[MASTER_CAMNOC_NRT] = &qxm_camnoc_nrt,
+	[MASTER_CAMNOC_RT] = &qxm_camnoc_rt,
+	[MASTER_CAMNOC_SF] = &qxm_camnoc_sf,
+	[MASTER_MDP_PORT0] = &qxm_mdp0,
+	[MASTER_MDP_PORT1] = &qxm_mdp1,
+	[MASTER_ROTATOR] = &qxm_rot,
+	[MASTER_VIDEO_P0] = &qxm_venus0,
+	[MASTER_VIDEO_P1] = &qxm_venus1,
+	[MASTER_VIDEO_PROC] = &qxm_venus_arm9,
+	[SLAVE_MNOC_SF_MEM_NOC] = &qns2_mem_noc,
+	[SLAVE_MNOC_HF_MEM_NOC] = &qns_mem_noc_hf,
+	[SLAVE_SERVICE_MNOC] = &srvc_mnoc,
+};
+
+static const struct qcom_icc_desc sm7150_mmss_noc = {
+	.nodes = mmss_noc_nodes,
+	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
+	.bcms = mmss_noc_bcms,
+	.num_bcms = ARRAY_SIZE(mmss_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const system_noc_bcms[] = {
+	&bcm_sn0,
+	&bcm_sn1,
+	&bcm_sn11,
+	&bcm_sn12,
+	&bcm_sn15,
+	&bcm_sn2,
+	&bcm_sn4,
+	&bcm_sn9,
+};
+
+static struct qcom_icc_node * const system_noc_nodes[] = {
+	[MASTER_SNOC_CFG] = &qhm_snoc_cfg,
+	[A1NOC_SNOC_MAS] = &qnm_aggre1_noc,
+	[A2NOC_SNOC_MAS] = &qnm_aggre2_noc,
+	[MASTER_GEM_NOC_SNOC] = &qnm_gemnoc,
+	[MASTER_PIMEM] = &qxm_pimem,
+	[MASTER_GIC] = &xm_gic,
+	[SLAVE_APPSS] = &qhs_apss,
+	[SNOC_CNOC_SLV] = &qns_cnoc,
+	[SLAVE_SNOC_GEM_NOC_GC] = &qns_gemnoc_gc,
+	[SLAVE_SNOC_GEM_NOC_SF] = &qns_gemnoc_sf,
+	[SLAVE_OCIMEM] = &qxs_imem,
+	[SLAVE_PIMEM] = &qxs_pimem,
+	[SLAVE_SERVICE_SNOC] = &srvc_snoc,
+	[SLAVE_QDSS_STM] = &xs_qdss_stm,
+	[SLAVE_TCU] = &xs_sys_tcu_cfg,
+};
+
+static const struct qcom_icc_desc sm7150_system_noc = {
+	.nodes = system_noc_nodes,
+	.num_nodes = ARRAY_SIZE(system_noc_nodes),
+	.bcms = system_noc_bcms,
+	.num_bcms = ARRAY_SIZE(system_noc_bcms),
+};
+
+static const struct of_device_id qnoc_of_match[] = {
+	{ .compatible = "qcom,sm7150-aggre1-noc", .data = &sm7150_aggre1_noc },
+	{ .compatible = "qcom,sm7150-aggre2-noc", .data = &sm7150_aggre2_noc },
+	{ .compatible = "qcom,sm7150-camnoc-virt", .data = &sm7150_camnoc_virt },
+	{ .compatible = "qcom,sm7150-compute-noc", .data = &sm7150_compute_noc },
+	{ .compatible = "qcom,sm7150-config-noc", .data = &sm7150_config_noc },
+	{ .compatible = "qcom,sm7150-dc-noc", .data = &sm7150_dc_noc },
+	{ .compatible = "qcom,sm7150-gem-noc", .data = &sm7150_gem_noc },
+	{ .compatible = "qcom,sm7150-mc-virt", .data = &sm7150_mc_virt },
+	{ .compatible = "qcom,sm7150-mmss-noc", .data = &sm7150_mmss_noc },
+	{ .compatible = "qcom,sm7150-system-noc", .data = &sm7150_system_noc },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, qnoc_of_match);
+
+static struct platform_driver qnoc_driver = {
+	.probe = qcom_icc_rpmh_probe,
+	.remove_new = qcom_icc_rpmh_remove,
+	.driver = {
+		.name = "qnoc-sm7150",
+		.of_match_table = qnoc_of_match,
+		.sync_state = icc_sync_state,
+	},
+};
+
+static int __init qnoc_driver_init(void)
+{
+	return platform_driver_register(&qnoc_driver);
+}
+core_initcall(qnoc_driver_init);
+
+static void __exit qnoc_driver_exit(void)
+{
+	platform_driver_unregister(&qnoc_driver);
+}
+module_exit(qnoc_driver_exit);
+
+MODULE_DESCRIPTION("Qualcomm SM7150 NoC driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/interconnect/qcom/sm7150.h b/drivers/interconnect/qcom/sm7150.h
new file mode 100644
index 000000000000..e00a9b0c1279
--- /dev/null
+++ b/drivers/interconnect/qcom/sm7150.h
@@ -0,0 +1,140 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Qualcomm #define SM7150 interconnect IDs
+ *
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2024, Danila Tikhonov <danila@jiaxyga.com>
+ */
+
+#ifndef __DRIVERS_INTERCONNECT_QCOM_SM7150_H
+#define __DRIVERS_INTERCONNECT_QCOM_SM7150_H
+
+#define SM7150_A1NOC_SNOC_MAS			0
+#define SM7150_A1NOC_SNOC_SLV			1
+#define SM7150_A2NOC_SNOC_MAS			2
+#define SM7150_A2NOC_SNOC_SLV			3
+#define SM7150_MASTER_A1NOC_CFG			4
+#define SM7150_MASTER_A2NOC_CFG			5
+#define SM7150_MASTER_AMPSS_M0			6
+#define SM7150_MASTER_CAMNOC_HF0		7
+#define SM7150_MASTER_CAMNOC_HF0_UNCOMP		8
+#define SM7150_MASTER_CAMNOC_NRT		9
+#define SM7150_MASTER_CAMNOC_NRT_UNCOMP		10
+#define SM7150_MASTER_CAMNOC_RT			11
+#define SM7150_MASTER_CAMNOC_RT_UNCOMP		12
+#define SM7150_MASTER_CAMNOC_SF			13
+#define SM7150_MASTER_CAMNOC_SF_UNCOMP		14
+#define SM7150_MASTER_CNOC_A2NOC		15
+#define SM7150_MASTER_CNOC_DC_NOC		16
+#define SM7150_MASTER_CNOC_MNOC_CFG		17
+#define SM7150_MASTER_COMPUTE_NOC		18
+#define SM7150_MASTER_CRYPTO_CORE_0		19
+#define SM7150_MASTER_EMMC			20
+#define SM7150_MASTER_GEM_NOC_CFG		21
+#define SM7150_MASTER_GEM_NOC_PCIE_SNOC		22
+#define SM7150_MASTER_GEM_NOC_SNOC		23
+#define SM7150_MASTER_GIC			24
+#define SM7150_MASTER_GRAPHICS_3D		25
+#define SM7150_MASTER_IPA			26
+#define SM7150_MASTER_LLCC			27
+#define SM7150_MASTER_MDP_PORT0			28
+#define SM7150_MASTER_MDP_PORT1			29
+#define SM7150_MASTER_MNOC_HF_MEM_NOC		30
+#define SM7150_MASTER_MNOC_SF_MEM_NOC		31
+#define SM7150_MASTER_NPU			32
+#define SM7150_MASTER_PCIE			33
+#define SM7150_MASTER_PIMEM			34
+#define SM7150_MASTER_QDSS_BAM			35
+#define SM7150_MASTER_QDSS_DAP			36
+#define SM7150_MASTER_QDSS_ETR			37
+#define SM7150_MASTER_QUP_0			38
+#define SM7150_MASTER_QUP_1			39
+#define SM7150_MASTER_ROTATOR			40
+#define SM7150_MASTER_SDCC_2			41
+#define SM7150_MASTER_SDCC_4			42
+#define SM7150_MASTER_SNOC_CFG			43
+#define SM7150_MASTER_SNOC_GC_MEM_NOC		44
+#define SM7150_MASTER_SNOC_SF_MEM_NOC		45
+#define SM7150_MASTER_SPDM			46
+#define SM7150_MASTER_SYS_TCU			47
+#define SM7150_MASTER_TSIF			48
+#define SM7150_MASTER_UFS_MEM			49
+#define SM7150_MASTER_USB3			50
+#define SM7150_MASTER_VIDEO_P0			51
+#define SM7150_MASTER_VIDEO_P1			52
+#define SM7150_MASTER_VIDEO_PROC		53
+#define SM7150_SLAVE_A1NOC_CFG			54
+#define SM7150_SLAVE_A2NOC_CFG			55
+#define SM7150_SLAVE_AHB2PHY_NORTH		56
+#define SM7150_SLAVE_AHB2PHY_SOUTH		57
+#define SM7150_SLAVE_AHB2PHY_WEST		58
+#define SM7150_SLAVE_ANOC_PCIE_GEM_NOC		59
+#define SM7150_SLAVE_AOP			60
+#define SM7150_SLAVE_AOSS			61
+#define SM7150_SLAVE_APPSS			62
+#define SM7150_SLAVE_CAMERA_CFG			63
+#define SM7150_SLAVE_CAMERA_NRT_THROTTLE_CFG	64
+#define SM7150_SLAVE_CAMERA_RT_THROTTLE_CFG	65
+#define SM7150_SLAVE_CAMNOC_UNCOMP		66
+#define SM7150_SLAVE_CDSP_CFG			67
+#define SM7150_SLAVE_CDSP_GEM_NOC		68
+#define SM7150_SLAVE_CLK_CTL			69
+#define SM7150_SLAVE_CNOC_A2NOC			70
+#define SM7150_SLAVE_CNOC_DDRSS			71
+#define SM7150_SLAVE_CNOC_MNOC_CFG		72
+#define SM7150_SLAVE_CRYPTO_0_CFG		73
+#define SM7150_SLAVE_DISPLAY_CFG		74
+#define SM7150_SLAVE_DISPLAY_THROTTLE_CFG	75
+#define SM7150_SLAVE_EBI_CH0			76
+#define SM7150_SLAVE_EMMC_CFG			77
+#define SM7150_SLAVE_GEM_NOC_CFG		78
+#define SM7150_SLAVE_GEM_NOC_SNOC		79
+#define SM7150_SLAVE_GLM			80
+#define SM7150_SLAVE_GRAPHICS_3D_CFG		81
+#define SM7150_SLAVE_IMEM_CFG			82
+#define SM7150_SLAVE_IPA_CFG			83
+#define SM7150_SLAVE_LLCC			84
+#define SM7150_SLAVE_LLCC_CFG			85
+#define SM7150_SLAVE_MNOC_HF_MEM_NOC		86
+#define SM7150_SLAVE_MNOC_SF_MEM_NOC		87
+#define SM7150_SLAVE_MSS_PROC_MS_MPU_CFG	88
+#define SM7150_SLAVE_OCIMEM			89
+#define SM7150_SLAVE_PCIE_CFG			90
+#define SM7150_SLAVE_PDM			91
+#define SM7150_SLAVE_PIMEM			92
+#define SM7150_SLAVE_PIMEM_CFG			93
+#define SM7150_SLAVE_PRNG			94
+#define SM7150_SLAVE_QDSS_CFG			95
+#define SM7150_SLAVE_QDSS_STM			96
+#define SM7150_SLAVE_QUP_0			97
+#define SM7150_SLAVE_QUP_1			98
+#define SM7150_SLAVE_RBCPR_CX_CFG		99
+#define SM7150_SLAVE_RBCPR_MX_CFG		100
+#define SM7150_SLAVE_SDCC_2			101
+#define SM7150_SLAVE_SDCC_4			102
+#define SM7150_SLAVE_SERVICE_A1NOC		103
+#define SM7150_SLAVE_SERVICE_A2NOC		104
+#define SM7150_SLAVE_SERVICE_CNOC		105
+#define SM7150_SLAVE_SERVICE_GEM_NOC		106
+#define SM7150_SLAVE_SERVICE_MNOC		107
+#define SM7150_SLAVE_SERVICE_SNOC		108
+#define SM7150_SLAVE_SNOC_CFG			109
+#define SM7150_SLAVE_SNOC_GEM_NOC_GC		110
+#define SM7150_SLAVE_SNOC_GEM_NOC_SF		111
+#define SM7150_SLAVE_SPDM_WRAPPER		112
+#define SM7150_SLAVE_TCSR			113
+#define SM7150_SLAVE_TCU			114
+#define SM7150_SLAVE_TLMM_NORTH			115
+#define SM7150_SLAVE_TLMM_SOUTH			116
+#define SM7150_SLAVE_TLMM_WEST			117
+#define SM7150_SLAVE_TSIF			118
+#define SM7150_SLAVE_UFS_MEM_CFG		119
+#define SM7150_SLAVE_USB3			120
+#define SM7150_SLAVE_VENUS_CFG			121
+#define SM7150_SLAVE_VENUS_CVP_THROTTLE_CFG	122
+#define SM7150_SLAVE_VENUS_THROTTLE_CFG		123
+#define SM7150_SLAVE_VSENSE_CTRL_CFG		124
+#define SM7150_SNOC_CNOC_MAS			125
+#define SM7150_SNOC_CNOC_SLV			126
+
+#endif
-- 
2.43.2


