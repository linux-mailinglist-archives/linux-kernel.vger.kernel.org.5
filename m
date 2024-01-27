Return-Path: <linux-kernel+bounces-41076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5F583EB63
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 07:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B0E81F23B60
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 06:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E11F14A9F;
	Sat, 27 Jan 2024 06:12:59 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057C811CAF;
	Sat, 27 Jan 2024 06:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706335978; cv=none; b=GlX6Gu3OnbEslqdpiMwI78TG0mLA6Xi3boi0Rb2bdreThaQPnfpJ0TqQH0KaC+2oZXGjPYmNslNKqzZpkp2DtlhqC+hoIA154NEK89z07lC1RH/XhWQm/H84ZRVikEF7MBVIfcFTRVNy1HInNGiBHV890Sz3sJMQBkkc00Swnfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706335978; c=relaxed/simple;
	bh=zsLMbN4rrmf2e1uZ1jmijWWUMOO1EeeZT0PwSCoPyqQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DdHj64QL7ZTjn4gt7fzPmjRJuKF7khekNKi2ydePhM3kZGKgnU1yaifWRwRqQ/fA6iwykgq3/U/ga9agOHIIyq0tfd0wYCfUVoJWV2s2Ajzwq7ioSlFHl8wIM9IQbXlg8201X+bihnIJFK+cAsw9p9Cw0FiNjX0qAspIUCr6W30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4TMPN04dBfz18MK6;
	Sat, 27 Jan 2024 14:11:44 +0800 (CST)
Received: from dggpemd200003.china.huawei.com (unknown [7.185.36.122])
	by mail.maildlp.com (Postfix) with ESMTPS id 0055818006D;
	Sat, 27 Jan 2024 14:12:51 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 dggpemd200003.china.huawei.com (7.185.36.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Sat, 27 Jan 2024 14:12:50 +0800
From: Chenghai Huang <huangchenghai2@huawei.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<shenyang39@huawei.com>
Subject: [PATCH] crypto: hisilicon/zip - Modify some data type and code cleanup
Date: Sat, 27 Jan 2024 14:08:50 +0800
Message-ID: <20240127060850.183186-1-huangchenghai2@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemd200003.china.huawei.com (7.185.36.122)

From: Yang Shen <shenyang39@huawei.com>

Improve some inappropriate variable types to make variable expression more
accurate.

Signed-off-by: Yang Shen <shenyang39@huawei.com>
Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
---
 drivers/crypto/hisilicon/zip/zip_main.c | 29 +++++++++++--------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 479ba8a1d6b5..b3e2b58ba7d7 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -809,21 +809,20 @@ DEFINE_SHOW_ATTRIBUTE(hisi_zip_regs);
 
 static int hisi_zip_core_debug_init(struct hisi_qm *qm)
 {
-	u32 zip_core_num, zip_comp_core_num;
+	u32 zip_core_num, zip_comp_core_num, i;
 	struct device *dev = &qm->pdev->dev;
 	struct debugfs_regset32 *regset;
 	struct dentry *tmp_d;
 	char buf[HZIP_BUF_SIZE];
-	int i;
 
 	zip_core_num = qm->cap_tables.dev_cap_table[ZIP_CORE_NUM_CAP_IDX].cap_val;
 	zip_comp_core_num = qm->cap_tables.dev_cap_table[ZIP_CLUSTER_COMP_NUM_CAP_IDX].cap_val;
 
 	for (i = 0; i < zip_core_num; i++) {
 		if (i < zip_comp_core_num)
-			scnprintf(buf, sizeof(buf), "comp_core%d", i);
+			scnprintf(buf, sizeof(buf), "comp_core%u", i);
 		else
-			scnprintf(buf, sizeof(buf), "decomp_core%d",
+			scnprintf(buf, sizeof(buf), "decomp_core%u",
 				  i - zip_comp_core_num);
 
 		regset = devm_kzalloc(dev, sizeof(*regset), GFP_KERNEL);
@@ -850,7 +849,7 @@ static void hisi_zip_dfx_debug_init(struct hisi_qm *qm)
 	struct hisi_zip_dfx *dfx = &zip->dfx;
 	struct dentry *tmp_dir;
 	void *data;
-	int i;
+	size_t i;
 
 	tmp_dir = debugfs_create_dir("zip_dfx", qm->debug.debug_root);
 	for (i = 0; i < ARRAY_SIZE(zip_dfx_files); i++) {
@@ -923,7 +922,7 @@ static int hisi_zip_debugfs_init(struct hisi_qm *qm)
 /* hisi_zip_debug_regs_clear() - clear the zip debug regs */
 static void hisi_zip_debug_regs_clear(struct hisi_qm *qm)
 {
-	int i, j;
+	size_t i, j;
 
 	/* enable register read_clear bit */
 	writel(HZIP_RD_CNT_CLR_CE_EN, qm->io_base + HZIP_SOFT_CTRL_CNT_CLR_CE);
@@ -952,12 +951,11 @@ static void hisi_zip_debugfs_exit(struct hisi_qm *qm)
 
 static int hisi_zip_show_last_regs_init(struct hisi_qm *qm)
 {
-	int core_dfx_regs_num =  ARRAY_SIZE(hzip_dump_dfx_regs);
-	int com_dfx_regs_num = ARRAY_SIZE(hzip_com_dfx_regs);
+	u32 core_dfx_regs_num =  ARRAY_SIZE(hzip_dump_dfx_regs);
+	u32 com_dfx_regs_num = ARRAY_SIZE(hzip_com_dfx_regs);
 	struct qm_debug *debug = &qm->debug;
+	u32 zip_core_num, i, j, idx;
 	void __iomem *io_base;
-	u32 zip_core_num;
-	int i, j, idx;
 
 	zip_core_num = qm->cap_tables.dev_cap_table[ZIP_CORE_NUM_CAP_IDX].cap_val;
 
@@ -996,14 +994,13 @@ static void hisi_zip_show_last_regs_uninit(struct hisi_qm *qm)
 
 static void hisi_zip_show_last_dfx_regs(struct hisi_qm *qm)
 {
-	int core_dfx_regs_num =  ARRAY_SIZE(hzip_dump_dfx_regs);
-	int com_dfx_regs_num = ARRAY_SIZE(hzip_com_dfx_regs);
+	u32 core_dfx_regs_num =  ARRAY_SIZE(hzip_dump_dfx_regs);
+	u32 com_dfx_regs_num = ARRAY_SIZE(hzip_com_dfx_regs);
 	u32 zip_core_num, zip_comp_core_num;
 	struct qm_debug *debug = &qm->debug;
 	char buf[HZIP_BUF_SIZE];
 	void __iomem *base;
-	int i, j, idx;
-	u32 val;
+	u32 i, j, idx, val;
 
 	if (qm->fun_type == QM_HW_VF || !debug->last_words)
 		return;
@@ -1020,9 +1017,9 @@ static void hisi_zip_show_last_dfx_regs(struct hisi_qm *qm)
 
 	for (i = 0; i < zip_core_num; i++) {
 		if (i < zip_comp_core_num)
-			scnprintf(buf, sizeof(buf), "Comp_core-%d", i);
+			scnprintf(buf, sizeof(buf), "Comp_core-%u", i);
 		else
-			scnprintf(buf, sizeof(buf), "Decomp_core-%d",
+			scnprintf(buf, sizeof(buf), "Decomp_core-%u",
 				  i - zip_comp_core_num);
 		base = qm->io_base + core_offsets[i];
 
-- 
2.30.0


