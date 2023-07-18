Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94F7757A53
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjGRLWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbjGRLV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:21:57 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8278EA;
        Tue, 18 Jul 2023 04:21:55 -0700 (PDT)
X-UUID: 4b65ac3a255d11ee9cb5633481061a41-20230718
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=KxwDmj9X8waLD1ymOgknd/mNl6ap37mlZ9CeBhasP2U=;
        b=N0KaOGYrSnsPVfCCFO23t3yWv2UWDosfb+h3eJJ2fU9ohgS48jmE0mPrvZHY5FHUnLpVaVNmRuhLSHsznGxtBz54mgWjosrh40rxfBYlMqPwXWd4rUailFuWu+uLwU5Z+af13o/OuHdnyWMitAAEGyCYBBITuSZzfLBqZIyk9Io=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:ba7b3c6c-a916-4494-8834-da9cffe38cb1,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:176cd25,CLOUDID:2104d84c-06c1-468b-847d-5b62d44dbb9b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4b65ac3a255d11ee9cb5633481061a41-20230718
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <william-tw.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1770147722; Tue, 18 Jul 2023 19:21:52 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 18 Jul 2023 19:21:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 18 Jul 2023 19:21:50 +0800
From:   William-tw Lin <william-tw.lin@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Kevin Hilman <khilman@kernel.org>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        William-tw Lin <william-tw.lin@mediatek.com>
Subject: [PATCH 1/3] soc: mediatek: mtk-socinfo: Add driver for getting chip information
Date:   Tue, 18 Jul 2023 19:21:41 +0800
Message-ID: <20230718112143.14036-2-william-tw.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230718112143.14036-1-william-tw.lin@mediatek.com>
References: <20230718112143.14036-1-william-tw.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for socinfo retrieval. This patch includes the following:
1. mtk-socinfo driver for chip info retrieval
2. Related changes to Makefile and Kconfig

Signed-off-by: William-tw Lin <william-tw.lin@mediatek.com>
---
 drivers/soc/mediatek/Kconfig       |  18 +++
 drivers/soc/mediatek/Makefile      |   1 +
 drivers/soc/mediatek/mtk-socinfo.c | 203 +++++++++++++++++++++++++++
 drivers/soc/mediatek/mtk-socinfo.h | 213 +++++++++++++++++++++++++++++
 4 files changed, 435 insertions(+)
 create mode 100644 drivers/soc/mediatek/mtk-socinfo.c
 create mode 100644 drivers/soc/mediatek/mtk-socinfo.h

diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
index a88cf04fc803..50bd9ec75ca5 100644
--- a/drivers/soc/mediatek/Kconfig
+++ b/drivers/soc/mediatek/Kconfig
@@ -91,4 +91,22 @@ config MTK_SVS
 	  chip process corner, temperatures and other factors. Then DVFS
 	  driver could apply SVS bank voltage to PMIC/Buck.
 
+config MTK_SOCINFO
+	tristate "MediaTek SOCINFO"
+	depends on MTK_EFUSE && NVMEM
+	help
+	  Say y here to enable mtk socinfo information.
+	  This enables a sysfs node which shows attributes of MTK soc info.
+	  Information of soc info includes the manufacturer, the marketing
+	  name, and the soc used.
+
+config MTK_SOCINFO_DEBUG
+	tristate "MediaTek SOCINFO debug"
+	depends on MTK_SOCINFO
+	help
+	  Say y here to enables a debug node which shows MTK SOC information.
+	  This enables a debug node that gives details on MTK soc info attributes.
+	  Information included in this debug node includes the manufacturer, the marketing
+	  name, the soc used, as well as the segment of the soc.
+
 endmenu
diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
index 8c0ddacbcde8..c900e5f13a35 100644
--- a/drivers/soc/mediatek/Makefile
+++ b/drivers/soc/mediatek/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_MTK_SCPSYS_PM_DOMAINS) += mtk-pm-domains.o
 obj-$(CONFIG_MTK_MMSYS) += mtk-mmsys.o
 obj-$(CONFIG_MTK_MMSYS) += mtk-mutex.o
 obj-$(CONFIG_MTK_SVS) += mtk-svs.o
+obj-$(CONFIG_MTK_SOCINFO) += mtk-socinfo.o
diff --git a/drivers/soc/mediatek/mtk-socinfo.c b/drivers/soc/mediatek/mtk-socinfo.c
new file mode 100644
index 000000000000..8c8964eb4670
--- /dev/null
+++ b/drivers/soc/mediatek/mtk-socinfo.c
@@ -0,0 +1,203 @@
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
+#include "mtk-socinfo.h"
+
+
+#if IS_ENABLED(CONFIG_MTK_SOCINFO_DEBUG)
+static int mtk_socinfo_socinfo_debug_show(struct seq_file *m, void *p)
+{
+	struct mtk_socinfo *mtk_socinfop = (struct mtk_socinfo *)m->private;
+
+	seq_printf(m, "SOC Manufacturer:   %s\n", soc_manufacturer);
+	seq_printf(m, "SOC Name:           %s\n", mtk_socinfop->name_data->soc_name);
+	seq_printf(m, "SOC segment Name:   %s\n", mtk_socinfop->name_data->soc_segment_name);
+	seq_printf(m, "Marketing Name:     %s\n", mtk_socinfop->name_data->marketing_name);
+
+	return 0;
+}
+DEBUG_FOPS_RO(socinfo);
+
+static int mtk_socinfo_create_debug_cmds(struct mtk_socinfo *mtk_socinfop)
+{
+	const char *d = "mtk-socinfo";
+
+	struct mtk_socinfo_dentry {
+		const char *name;
+		const struct file_operations *fops;
+	};
+
+	struct mtk_socinfo_dentry mtk_socinfo_entries[] = {
+		MTK_SOCINFO_DENTRY_DATA(socinfo),
+	};
+
+	mtk_socinfo_dir = debugfs_create_dir(d, NULL);
+	if (IS_ERR(mtk_socinfo_dir)) {
+		dev_err(mtk_socinfop->dev, "Cannot create %s\n", d);
+		return 0;
+	}
+
+	file_entry = debugfs_create_file(mtk_socinfo_entries[0].name, 0664,
+					mtk_socinfo_dir, mtk_socinfop,
+					mtk_socinfo_entries[0].fops);
+	if (IS_ERR(file_entry)) {
+		dev_err(mtk_socinfop->dev, "Cannot create %s/%s\n", d, mtk_socinfo_entries[0].name);
+		return PTR_ERR(file_entry);
+	}
+	return 0;
+}
+#endif
+
+static int mtk_socinfo_create_socinfo_node(struct mtk_socinfo *mtk_socinfop)
+{
+	struct soc_device_attribute *attrs;
+	static char machine[30] = {0};
+
+	attrs = devm_kzalloc(mtk_socinfop->dev, sizeof(*attrs), GFP_KERNEL);
+	if (!attrs) {
+		return -ENOMEM;
+	}
+
+	snprintf(machine, 30, "%s (%s)", mtk_socinfop->name_data->marketing_name,
+		mtk_socinfop->name_data->soc_name);
+	attrs->family = soc_manufacturer;
+	attrs->machine = machine;
+
+	soc_dev = soc_device_register(attrs);
+	if (IS_ERR(soc_dev)) {
+		dev_err(mtk_socinfop->dev, "Cannot create soc node, soc_device_register failed\n");
+		return PTR_ERR(soc_dev);
+	}
+
+	dev_info(mtk_socinfop->dev, "%s %s SoC detected.\n", MODULE_NAME, attrs->machine);
+	return 0;
+}
+
+static int mtk_socinfo_get_socinfo_data(struct mtk_socinfo *mtk_socinfop)
+{
+	struct efuse_data *soc_efuse_data_infop = mtk_socinfop->soc_data->efuse_data;
+	struct name_data *soc_name_data_infop = mtk_socinfop->soc_data->name_data;
+	unsigned int soc_efuse_data_count = mtk_socinfop->soc_data->efuse_data_count;
+	unsigned int soc_segment_count = mtk_socinfop->soc_data->efuse_segment_count;
+	unsigned int i = 0, j = 0;
+	struct efuse_data *temp_efuse_datap;
+	struct nvmem_cell *cell;
+	size_t efuse_bytes;
+	char *nvmem_cell_name = "";
+	u32 *efuse_temp_bufp;
+	int match_segment_index = -1;
+
+	for (i = 0; i < soc_segment_count; i++) {
+		bool match_segment = true;
+
+		for (j = 0; j < soc_efuse_data_count; j++) {
+			temp_efuse_datap = soc_efuse_data_infop + (i * soc_efuse_data_count + j);
+			nvmem_cell_name = temp_efuse_datap->nvmem_cell_name;
+			cell = nvmem_cell_get(mtk_socinfop->dev, nvmem_cell_name);
+			if (IS_ERR_OR_NULL(cell)) {
+				dev_err(mtk_socinfop->dev, "%s cell not found\n", nvmem_cell_name);
+				goto out;
+			}
+			efuse_temp_bufp = (u32 *)nvmem_cell_read(cell, &efuse_bytes);
+			nvmem_cell_put(cell);
+			if (*efuse_temp_bufp != temp_efuse_datap->efuse_data) {
+				match_segment = false;
+				break;
+			}
+		}
+		if (match_segment) {
+			match_segment_index = i;
+			mtk_socinfop->name_data = soc_name_data_infop + i;
+		}
+	}
+
+out:
+	kfree(efuse_temp_bufp);
+	return match_segment_index;
+}
+
+static const struct of_device_id mtk_socinfo_id_table[] = {
+	{ .compatible = "mediatek,mt8173-socinfo", .data = &socinfo_data_table[INDEX_MT8173]},
+	{ .compatible = "mediatek,mt8183-socinfo", .data = &socinfo_data_table[INDEX_MT8183]},
+	{ .compatible = "mediatek,mt8186-socinfo", .data = &socinfo_data_table[INDEX_MT8186]},
+	{ .compatible = "mediatek,mt8188-socinfo", .data = &socinfo_data_table[INDEX_MT8188]},
+	{ .compatible = "mediatek,mt8192-socinfo", .data = &socinfo_data_table[INDEX_MT8192]},
+	{ .compatible = "mediatek,mt8195-socinfo", .data = &socinfo_data_table[INDEX_MT8195]},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, mtk_socinfo_id_table);
+
+static int mtk_socinfo_probe(struct platform_device *pdev)
+{
+	struct mtk_socinfo *mtk_socinfop;
+	int ret = 0;
+
+	mtk_socinfop = devm_kzalloc(&pdev->dev, sizeof(*mtk_socinfop), GFP_KERNEL);
+	if (!mtk_socinfop)
+		return -ENOMEM;
+
+	mtk_socinfop->dev = &pdev->dev;
+	mtk_socinfop->soc_data = (struct socinfo_data *)of_device_get_match_data(mtk_socinfop->dev);
+	if (!mtk_socinfop->soc_data) {
+		dev_err(mtk_socinfop->dev, "No mtk-socinfo platform data found\n");
+		return -EPERM;
+	}
+
+	ret = mtk_socinfo_get_socinfo_data(mtk_socinfop);
+	if (ret < 0) {
+		dev_err(mtk_socinfop->dev, "Failed to get socinfo data (ret = %d)\n", ret);
+		return -EINVAL;
+	}
+
+	ret = mtk_socinfo_create_socinfo_node(mtk_socinfop);
+	if (ret != 0) {
+		dev_err(mtk_socinfop->dev, "Failed to create socinfo node (ret = %d)\n", ret);
+		return ret;
+	}
+
+#if IS_ENABLED(CONFIG_MTK_SOCINFO_DEBUG)
+	ret = mtk_socinfo_create_debug_cmds(mtk_socinfop);
+	if (ret != 0) {
+		dev_err(mtk_socinfop->dev, "Failed to create socinfo debug node (ret = %d)\n", ret);
+		return ret;
+	}
+#endif
+	return 0;
+}
+
+static int mtk_socinfo_remove(struct platform_device *pdev)
+{
+	if (soc_dev)
+		soc_device_unregister(soc_dev);
+#if IS_ENABLED(CONFIG_MTK_SOCINFO_DEBUG)
+	debugfs_remove(file_entry);
+#endif
+	return 0;
+}
+
+static struct platform_driver mtk_socinfo = {
+	.probe          = mtk_socinfo_probe,
+	.remove         = mtk_socinfo_remove,
+	.driver         = {
+		.name   = "mtk_socinfo",
+		.owner  = THIS_MODULE,
+		.of_match_table = mtk_socinfo_id_table,
+	},
+};
+module_platform_driver(mtk_socinfo);
+MODULE_AUTHOR("William-TW LIN <william-tw.lin@mediatek.com>");
+MODULE_DESCRIPTION("Mediatek socinfo driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/soc/mediatek/mtk-socinfo.h b/drivers/soc/mediatek/mtk-socinfo.h
new file mode 100644
index 000000000000..8fd490311c8b
--- /dev/null
+++ b/drivers/soc/mediatek/mtk-socinfo.h
@@ -0,0 +1,213 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#ifndef __MTK_SOCINFO_H__
+#define __MTK_SOCINFO_H__
+
+#define MODULE_NAME	"[mtk-socinfo]"
+
+#define DEBUG_FOPS_RO(name)						\
+	static int mtk_socinfo_##name##_debug_open(struct inode *inode,		\
+					   struct file *filp)		\
+	{								\
+		return single_open(filp, mtk_socinfo_##name##_debug_show,	\
+				   inode->i_private);			\
+	}								\
+	static const struct file_operations mtk_socinfo_##name##_debug_fops = {	\
+		.owner = THIS_MODULE,					\
+		.open = mtk_socinfo_##name##_debug_open,			\
+		.read = seq_read,					\
+		.llseek = seq_lseek,					\
+		.release = single_release,				\
+	}
+
+#define MTK_SOCINFO_DENTRY_DATA(name)	{__stringify(name), &mtk_socinfo_##name##_debug_fops}
+
+const char *soc_manufacturer = "MediaTek";
+
+struct soc_device *soc_dev;
+struct dentry *mtk_socinfo_dir, *file_entry;
+
+struct mtk_socinfo {
+	struct device *dev;
+	struct name_data *name_data;
+	struct socinfo_data *soc_data;
+};
+
+struct efuse_data {
+	char *nvmem_cell_name;
+	u32 efuse_data;
+};
+
+struct name_data {
+	char *soc_name;
+	char *soc_segment_name;
+	char *marketing_name;
+};
+
+struct socinfo_data {
+	char *soc_name;
+	struct efuse_data *efuse_data;
+	struct name_data *name_data;
+	unsigned int efuse_segment_count;
+	unsigned int efuse_data_count;
+};
+
+enum socinfo_data_index {
+	INDEX_MT8186 = 0,
+	INDEX_MT8188,
+	INDEX_MT8195,
+	INDEX_MT8192,
+	INDEX_MT8183,
+	INDEX_MT8173,
+	SOCINFO_DATA_LAST_INDEX
+};
+
+/* begin 8186 info */
+#define mtk_mt8186_EFUSE_DATA_COUNT 1
+static struct efuse_data mtk_mt8186_efuse_data_info[][mtk_mt8186_EFUSE_DATA_COUNT] = {
+	{{.nvmem_cell_name = "socinfo-data1", .efuse_data = 0x81861001}},
+	{{.nvmem_cell_name = "socinfo-data1", .efuse_data = 0x81862001}},
+};
+
+static struct name_data mtk_mt8186_name_data_info[] = {
+	{.soc_name = "MT8186",
+	 .soc_segment_name = "MT8186GV/AZA",
+	 .marketing_name = "Kompanio 520"},
+	{.soc_name = "MT8186T",
+	 .soc_segment_name = "MT8186TV/AZA",
+	 .marketing_name = "Kompanio 528"},
+};
+/* end 8186 info */
+
+/* begin 8188 info */
+#define mtk_mt8188_EFUSE_DATA_COUNT 2
+static struct efuse_data mtk_mt8188_efuse_data_info[][mtk_mt8188_EFUSE_DATA_COUNT] = {
+	{{.nvmem_cell_name = "socinfo-data1", .efuse_data = 0x81880000},
+	 {.nvmem_cell_name = "socinfo-data2", .efuse_data = 0x00000010}},
+	 {{.nvmem_cell_name = "socinfo-data1", .efuse_data = 0x81880000},
+	 {.nvmem_cell_name = "socinfo-data2", .efuse_data = 0x00000011}},
+};
+
+static struct name_data mtk_mt8188_name_data_info[] = {
+	{.soc_name = "MT8188",
+	 .soc_segment_name = "MT8188GV/AZA",
+	 .marketing_name = "Kompanio 830"},
+	{.soc_name = "MT8188",
+	 .soc_segment_name = "MT8188GV/HZA",
+	 .marketing_name = "Kompanio 830"},
+};
+/* end 8188 info */
+
+/* begin 8195 info */
+#define mtk_mt8195_EFUSE_DATA_COUNT 1
+static struct efuse_data mtk_mt8195_efuse_data_info[][mtk_mt8195_EFUSE_DATA_COUNT] = {
+	{{.nvmem_cell_name = "socinfo-data1", .efuse_data = 0x81950300}},
+	{{.nvmem_cell_name = "socinfo-data1", .efuse_data = 0x81950304}},
+	{{.nvmem_cell_name = "socinfo-data1", .efuse_data = 0x81950400}},
+	{{.nvmem_cell_name = "socinfo-data1", .efuse_data = 0x81950404}},
+};
+
+static struct name_data mtk_mt8195_name_data_info[] = {
+	{.soc_name = "MT8195",
+	 .soc_segment_name = "MT8195GV/EZA",
+	 .marketing_name = "Kompanio 1200"},
+	{.soc_name = "MT8195",
+	 .soc_segment_name = "MT8195GV/EHZA",
+	 .marketing_name = "Kompanio 1200"},
+	{.soc_name = "MT8195T",
+	 .soc_segment_name = "MT8195TV/EZA",
+	 .marketing_name = "Kompanio 1380"},
+	{.soc_name = "MT8195T",
+	 .soc_segment_name = "MT8195TV/EHZA",
+	 .marketing_name = "Kompanio 1380"},
+};
+/* end 8195 info */
+
+/* begin 8192 info */
+#define mtk_mt8192_EFUSE_DATA_COUNT 2
+static struct efuse_data mtk_mt8192_efuse_data_info[][mtk_mt8192_EFUSE_DATA_COUNT] = {
+	{{.nvmem_cell_name = "socinfo-data1", .efuse_data = 0x00001100},
+	 {.nvmem_cell_name = "socinfo-data2", .efuse_data = 0x00040080}},
+	 {{.nvmem_cell_name = "socinfo-data1", .efuse_data = 0x00000100},
+	 {.nvmem_cell_name = "socinfo-data2", .efuse_data = 0x000400C0}},
+};
+
+static struct name_data mtk_mt8192_name_data_info[] = {
+	{.soc_name = "MT8192",
+	 .soc_segment_name = "MT8192V/AZA",
+	 .marketing_name = "Kompanio 820"},
+	{.soc_name = "MT8192T",
+	 .soc_segment_name = "MT8192V/ATZA",
+	 .marketing_name = "Kompanio 828"},
+};
+/* end 8192 info */
+
+/* begin 8183 info */
+#define mtk_mt8183_EFUSE_DATA_COUNT 2
+static struct efuse_data mtk_mt8183_efuse_data_info[][mtk_mt8183_EFUSE_DATA_COUNT] = {
+	{{.nvmem_cell_name = "socinfo-data1", .efuse_data = 0x00010043},
+	 {.nvmem_cell_name = "socinfo-data2", .efuse_data = 0x00000840}},
+};
+
+static struct name_data mtk_mt8183_name_data_info[] = {
+	{.soc_name = "MT8183",
+	 .soc_segment_name = "MT8183V/AZA",
+	 .marketing_name = "Kompanio 500"},
+};
+/* end 8183 info */
+
+/* begin 8173 info */
+#define mtk_mt8173_EFUSE_DATA_COUNT 2
+static struct efuse_data mtk_mt8173_efuse_data_info[][mtk_mt8173_EFUSE_DATA_COUNT] = {
+	{{.nvmem_cell_name = "socinfo-data1", .efuse_data = 0x6CA20004},
+	 {.nvmem_cell_name = "socinfo-data2", .efuse_data = 0x10000000}},
+};
+
+static struct name_data mtk_mt8173_name_data_info[] = {
+	{.soc_name = "MT8173",
+	 .soc_segment_name = "MT8173V/AC",
+	 .marketing_name = "MT8173"},
+};
+/* end 8173 info */
+
+/* begin socinfo_data table */
+/* for get_soc_data lookup purposes */
+static struct socinfo_data socinfo_data_table[] = {
+	[INDEX_MT8186] = {.soc_name = "mt8186",
+			  .efuse_data = &(mtk_mt8186_efuse_data_info[0][0]),
+			  .name_data = mtk_mt8186_name_data_info,
+			  .efuse_segment_count = ARRAY_SIZE(mtk_mt8186_name_data_info),
+			  .efuse_data_count = mtk_mt8186_EFUSE_DATA_COUNT},
+	[INDEX_MT8188] = {.soc_name = "mt8188",
+			  .efuse_data = &(mtk_mt8188_efuse_data_info[0][0]),
+			  .name_data = mtk_mt8188_name_data_info,
+			  .efuse_segment_count = ARRAY_SIZE(mtk_mt8188_name_data_info),
+			  .efuse_data_count = mtk_mt8188_EFUSE_DATA_COUNT},
+	[INDEX_MT8195] = {.soc_name = "mt8195",
+			  .efuse_data = &(mtk_mt8195_efuse_data_info[0][0]),
+			  .name_data = mtk_mt8195_name_data_info,
+			  .efuse_segment_count = ARRAY_SIZE(mtk_mt8195_name_data_info),
+			  .efuse_data_count = mtk_mt8195_EFUSE_DATA_COUNT},
+	[INDEX_MT8192] = {.soc_name = "mt8192",
+			  .efuse_data = &(mtk_mt8192_efuse_data_info[0][0]),
+			  .name_data = mtk_mt8192_name_data_info,
+			  .efuse_segment_count = ARRAY_SIZE(mtk_mt8192_name_data_info),
+			  .efuse_data_count = mtk_mt8192_EFUSE_DATA_COUNT},
+	[INDEX_MT8183] = {.soc_name = "mt8183",
+			  .efuse_data = &(mtk_mt8183_efuse_data_info[0][0]),
+			  .name_data = mtk_mt8183_name_data_info,
+			  .efuse_segment_count = ARRAY_SIZE(mtk_mt8183_name_data_info),
+			  .efuse_data_count = mtk_mt8183_EFUSE_DATA_COUNT},
+	[INDEX_MT8173] = {.soc_name = "mt8173",
+			  .efuse_data = &(mtk_mt8173_efuse_data_info[0][0]),
+			  .name_data = mtk_mt8173_name_data_info,
+			  .efuse_segment_count = ARRAY_SIZE(mtk_mt8173_name_data_info),
+			  .efuse_data_count = mtk_mt8173_EFUSE_DATA_COUNT},
+};
+/* end socinfo_data table */
+
+
+#endif /* __MTK_SOCINFO_H__ */
-- 
2.18.0

