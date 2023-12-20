Return-Path: <linux-kernel+bounces-6759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E375819D1C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3E1A2886B8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C896F225D6;
	Wed, 20 Dec 2023 10:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="F+z4toS6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A73722311;
	Wed, 20 Dec 2023 10:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0a1fb9469f2411eea5db2bebc7c28f94-20231220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=rAXaVDDN3GJbjJ+A+RI0E/Hku5aIiiTtLCoa0Akqi/A=;
	b=F+z4toS69u1Fddes7HlpEnIEVDGb08LrQK6u6t5ESitTxHBQkx0Iq/kNm3HQpp4OLmBGl+INNVWX2gl/vvL6ipW9K1hcTOFYZ4XXaOEyJZDHgmEOkIdBPef1PHvd5km3KitdqarpOXX9V0vJDdjRej2yUTvLeUt+DrZge/QtW1Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:43c0e905-13d1-411e-b960-e978b66ec39e,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:5d391d7,CLOUDID:cc8d7a7e-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0a1fb9469f2411eea5db2bebc7c28f94-20231220
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <william-tw.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 53193792; Wed, 20 Dec 2023 18:39:23 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Dec 2023 18:39:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Dec 2023 18:39:22 +0800
From: William-tw Lin <william-tw.lin@mediatek.com>
To: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	William-tw Lin <william-tw.lin@mediatek.com>
Subject: [PATCH v3 2/3] soc: mediatek: mtk-socinfo: Add driver for getting chip information
Date: Wed, 20 Dec 2023 18:39:00 +0800
Message-ID: <20231220103901.22180-3-william-tw.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231220103901.22180-1-william-tw.lin@mediatek.com>
References: <20231220103901.22180-1-william-tw.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Add driver for socinfo retrieval. This patch includes the following:
1. mtk-socinfo driver for chip info retrieval
2. Related changes to Makefile and Kconfig

Signed-off-by: William-tw Lin <william-tw.lin@mediatek.com>
---
 drivers/soc/mediatek/Kconfig       |   8 ++
 drivers/soc/mediatek/Makefile      |   1 +
 drivers/soc/mediatek/mtk-socinfo.c | 186 +++++++++++++++++++++++++++++
 3 files changed, 195 insertions(+)
 create mode 100644 drivers/soc/mediatek/mtk-socinfo.c

diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
index 0810b5b0c688..f34d93977ba6 100644
--- a/drivers/soc/mediatek/Kconfig
+++ b/drivers/soc/mediatek/Kconfig
@@ -68,4 +68,12 @@ config MTK_SVS
 	  chip process corner, temperatures and other factors. Then DVFS
 	  driver could apply SVS bank voltage to PMIC/Buck.
 
+config MTK_SOCINFO
+	tristate "MediaTek SoC Information"
+	default y
+	help
+	  The MediaTek SoC Information (mtk-socinfo) driver provides
+	  information about the SoC to the userspace including the
+	  manufacturer name, marketing name and soc name.
+
 endmenu
diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
index 9d3ce7878c5c..6830512848fd 100644
--- a/drivers/soc/mediatek/Makefile
+++ b/drivers/soc/mediatek/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_MTK_REGULATOR_COUPLER) += mtk-regulator-coupler.o
 obj-$(CONFIG_MTK_MMSYS) += mtk-mmsys.o
 obj-$(CONFIG_MTK_MMSYS) += mtk-mutex.o
 obj-$(CONFIG_MTK_SVS) += mtk-svs.o
+obj-$(CONFIG_MTK_SOCINFO) += mtk-socinfo.o
diff --git a/drivers/soc/mediatek/mtk-socinfo.c b/drivers/soc/mediatek/mtk-socinfo.c
new file mode 100644
index 000000000000..4a257b5c8eda
--- /dev/null
+++ b/drivers/soc/mediatek/mtk-socinfo.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/device.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#include <linux/string.h>
+#include <linux/sys_soc.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+
+#define MTK_SOCINFO_ENTRY(_soc_name, _segment_name, _marketing_name, _cell_data1, _cell_data2) {\
+	.soc_name = _soc_name,									\
+	.segment_name = _segment_name,								\
+	.marketing_name = _marketing_name,							\
+	.cell_data = {_cell_data1, _cell_data2}							\
+}
+#define CELL_NOT_USED (0xFFFFFFFF)
+#define MAX_CELLS (2)
+
+struct mtk_socinfo {
+	struct device *dev;
+	struct name_data *name_data;
+	struct socinfo_data *socinfo_data;
+	struct soc_device *soc_dev;
+};
+
+struct socinfo_data {
+	char *soc_name;
+	char *segment_name;
+	char *marketing_name;
+	u32 cell_data[MAX_CELLS];
+};
+
+static const char *cell_names[MAX_CELLS] = {"socinfo-data1", "socinfo-data2"};
+
+static struct socinfo_data socinfo_data_table[] = {
+	MTK_SOCINFO_ENTRY("MT8173", "MT8173V/AC", "MT8173", 0x6CA20004, 0x10000000),
+	MTK_SOCINFO_ENTRY("MT8183", "MT8183V/AZA", "Kompanio 500", 0x00010043, 0x00000840),
+	MTK_SOCINFO_ENTRY("MT8186", "MT8186GV/AZA", "Kompanio 520", 0x81861001, CELL_NOT_USED),
+	MTK_SOCINFO_ENTRY("MT8186T", "MT8186TV/AZA", "Kompanio 528", 0x81862001, CELL_NOT_USED),
+	MTK_SOCINFO_ENTRY("MT8188", "MT8188GV/AZA", "Kompanio 830", 0x81880000, 0x00000010),
+	MTK_SOCINFO_ENTRY("MT8188", "MT8188GV/HZA", "Kompanio 830", 0x81880000, 0x00000011),
+	MTK_SOCINFO_ENTRY("MT8192", "MT8192V/AZA", "Kompanio 820", 0x00001100, 0x00040080),
+	MTK_SOCINFO_ENTRY("MT8192T", "MT8192V/ATZA", "Kompanio 828", 0x00000100, 0x000400C0),
+	MTK_SOCINFO_ENTRY("MT8195", "MT8195GV/EZA", "Kompanio 1200", 0x81950300, CELL_NOT_USED),
+	MTK_SOCINFO_ENTRY("MT8195", "MT8195GV/EHZA", "Kompanio 1200", 0x81950304, CELL_NOT_USED),
+	MTK_SOCINFO_ENTRY("MT8195", "MT8195TV/EZA", "Kompanio 1380", 0x81950400, CELL_NOT_USED),
+	MTK_SOCINFO_ENTRY("MT8195", "MT8195TV/EHZA", "Kompanio 1380", 0x81950404, CELL_NOT_USED),
+};
+
+static int mtk_socinfo_create_socinfo_node(struct mtk_socinfo *mtk_socinfop)
+{
+	struct soc_device_attribute *attrs;
+	static char machine[30] = {0};
+	static const char *soc_manufacturer = "MediaTek";
+
+	attrs = devm_kzalloc(mtk_socinfop->dev, sizeof(*attrs), GFP_KERNEL);
+	if (!attrs)
+		return -ENOMEM;
+
+	snprintf(machine, sizeof(machine), "%s (%s)", mtk_socinfop->socinfo_data->marketing_name,
+		mtk_socinfop->socinfo_data->soc_name);
+	attrs->family = soc_manufacturer;
+	attrs->machine = machine;
+
+	mtk_socinfop->soc_dev = soc_device_register(attrs);
+	if (IS_ERR(mtk_socinfop->soc_dev))
+		return PTR_ERR(mtk_socinfop->soc_dev);
+
+	dev_info(mtk_socinfop->dev, "%s %s SoC detected.\n", soc_manufacturer, attrs->machine);
+	return 0;
+}
+
+static u32 mtk_socinfo_read_cell(struct device *dev, const char *name)
+{
+	struct nvmem_device *nvmemp;
+	struct device_node *np = dev->of_node;
+	u32 offset;
+	u32 cell_val = CELL_NOT_USED;
+
+	nvmemp = devm_nvmem_device_get(dev, "mtk-efuse0");
+	if (IS_ERR(nvmemp))
+		goto out;
+
+	np = of_find_node_by_name(NULL, name);
+	if (!np)
+		goto out;
+
+	if (of_property_read_u32_index(np, "reg", 0, &offset))
+		goto out;
+
+	nvmem_device_read(nvmemp, offset, sizeof(cell_val), &cell_val);
+
+	nvmem_device_put(nvmemp);
+
+out:
+	return cell_val;
+}
+
+static int mtk_socinfo_get_socinfo_data(struct mtk_socinfo *mtk_socinfop)
+{
+	unsigned int i, j;
+	unsigned int num_cell_data = 0;
+	u32 cell_data[MAX_CELLS] = {0};
+	bool match_socinfo;
+	int match_socinfo_index = -1;
+
+	for (i = 0; i < MAX_CELLS; i++) {
+		cell_data[i] = mtk_socinfo_read_cell(mtk_socinfop->dev, cell_names[i]);
+		if (cell_data[i] != CELL_NOT_USED)
+			num_cell_data++;
+		else
+			break;
+	}
+
+	if (!num_cell_data)
+		return -ENOENT;
+
+	for (i = 0; i < ARRAY_SIZE(socinfo_data_table); i++) {
+		match_socinfo = true;
+		for (j = 0; j < num_cell_data; j++) {
+			if (cell_data[j] != socinfo_data_table[i].cell_data[j]) {
+				match_socinfo = false;
+				break;
+			}
+		}
+		if (match_socinfo) {
+			mtk_socinfop->socinfo_data = &(socinfo_data_table[i]);
+			match_socinfo_index = i;
+			break;
+		}
+	}
+
+	return match_socinfo_index >= 0 ? match_socinfo_index : -ENOENT;
+}
+
+static int mtk_socinfo_probe(struct platform_device *pdev)
+{
+	struct mtk_socinfo *mtk_socinfop;
+	int ret;
+
+	mtk_socinfop = devm_kzalloc(&pdev->dev, sizeof(*mtk_socinfop), GFP_KERNEL);
+	if (!mtk_socinfop)
+		return -ENOMEM;
+
+	mtk_socinfop->dev = &pdev->dev;
+
+	ret = mtk_socinfo_get_socinfo_data(mtk_socinfop);
+	if (ret < 0)
+		return dev_err_probe(mtk_socinfop->dev, ret, "Failed to get socinfo data\n");
+
+	ret = mtk_socinfo_create_socinfo_node(mtk_socinfop);
+	if (ret)
+		return dev_err_probe(mtk_socinfop->dev, ret, "Cannot create node\n");
+
+	platform_set_drvdata(pdev, mtk_socinfop);
+	return 0;
+}
+
+static void mtk_socinfo_remove(struct platform_device *pdev)
+{
+	struct mtk_socinfo *mtk_socinfop = platform_get_drvdata(pdev);
+
+	soc_device_unregister(mtk_socinfop->soc_dev);
+}
+
+static struct platform_driver mtk_socinfo = {
+	.probe = mtk_socinfo_probe,
+	.remove_new = mtk_socinfo_remove,
+	.driver = {
+		.name = "mtk-socinfo",
+	},
+};
+builtin_platform_driver(mtk_socinfo);
+
+MODULE_AUTHOR("William-TW LIN <william-tw.lin@mediatek.com>");
+MODULE_DESCRIPTION("MediaTek socinfo driver");
+MODULE_LICENSE("GPL");
-- 
2.18.0


