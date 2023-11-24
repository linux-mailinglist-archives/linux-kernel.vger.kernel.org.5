Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176AC7F6BD5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 06:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjKXFwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 00:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXFww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 00:52:52 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB9FD6C;
        Thu, 23 Nov 2023 21:52:56 -0800 (PST)
Received: from dggpemd200003.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Sc3zJ32g9zvR7Q;
        Fri, 24 Nov 2023 13:52:28 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 dggpemd200003.china.huawei.com (7.185.36.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Fri, 24 Nov 2023 13:52:54 +0800
From:   Chenghai Huang <huangchenghai2@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <shenyang39@huawei.com>
Subject: [PATCH v2] crypto: hisilicon/zip - add zip comp high perf mode configuration
Date:   Fri, 24 Nov 2023 13:49:24 +0800
Message-ID: <20231124054924.3964946-1-huangchenghai2@huawei.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemd200003.china.huawei.com (7.185.36.122)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To meet specific application scenarios, the function of switching between
the high performance mode and the high compression mode is added.

Use the perf_mode=0/1 configuration to set the compression high perf mode,
0(default, high compression mode), 1(high performance mode). These two
modes only apply to the compression direction and are compatible with
software algorithm in both directions.

Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
---
 drivers/crypto/hisilicon/zip/zip_main.c | 65 +++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index d6672b777efc..07ab61c113ab 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -107,6 +107,14 @@
 #define HZIP_CLOCK_GATED_EN		(HZIP_CORE_GATED_EN | \
 					 HZIP_CORE_GATED_OOO_EN)
 
+/* zip comp high performance */
+#define HZIP_HIGH_PERF_OFFSET		0x301208
+
+enum {
+	HZIP_HIGH_COMP_RATE,
+	HZIP_HIGH_COMP_PERF,
+};
+
 static const char hisi_zip_name[] = "hisi_zip";
 static struct dentry *hzip_debugfs_root;
 
@@ -352,6 +360,37 @@ static int hzip_diff_regs_show(struct seq_file *s, void *unused)
 	return 0;
 }
 DEFINE_SHOW_ATTRIBUTE(hzip_diff_regs);
+
+static int perf_mode_set(const char *val, const struct kernel_param *kp)
+{
+	int ret;
+	u32 n;
+
+	if (!val)
+		return -EINVAL;
+
+	ret = kstrtou32(val, 10, &n);
+	if (ret != 0 || (n != HZIP_HIGH_COMP_PERF &&
+			 n != HZIP_HIGH_COMP_RATE))
+		return -EINVAL;
+
+	return param_set_int(val, kp);
+}
+
+static const struct kernel_param_ops zip_com_perf_ops = {
+	.set = perf_mode_set,
+	.get = param_get_int,
+};
+
+/*
+ * perf_mode = 0 means enable high compression rate mode,
+ * perf_mode = 1 means enable high compression performance mode.
+ * These two modes only apply to the compression direction.
+ */
+static u32 perf_mode = HZIP_HIGH_COMP_RATE;
+module_param_cb(perf_mode, &zip_com_perf_ops, &perf_mode, 0444);
+MODULE_PARM_DESC(perf_mode, "ZIP high perf mode 0(default), 1(enable)");
+
 static const struct kernel_param_ops zip_uacce_mode_ops = {
 	.set = uacce_mode_set,
 	.get = param_get_int,
@@ -417,6 +456,28 @@ bool hisi_zip_alg_support(struct hisi_qm *qm, u32 alg)
 	return false;
 }
 
+static int hisi_zip_set_high_perf(struct hisi_qm *qm)
+{
+	u32 val;
+	int ret;
+
+	val = readl_relaxed(qm->io_base + HZIP_HIGH_PERF_OFFSET);
+	if (perf_mode == HZIP_HIGH_COMP_PERF)
+		val |= HZIP_HIGH_COMP_PERF;
+	else
+		val &= ~HZIP_HIGH_COMP_PERF;
+
+	/* Set perf mode */
+	writel(val, qm->io_base + HZIP_HIGH_PERF_OFFSET);
+	ret = readl_relaxed_poll_timeout(qm->io_base + HZIP_HIGH_PERF_OFFSET,
+					 val, val == perf_mode, HZIP_DELAY_1_US,
+					 HZIP_POLL_TIMEOUT_US);
+	if (ret)
+		pci_err(qm->pdev, "failed to set perf mode\n");
+
+	return ret;
+}
+
 static int hisi_zip_set_qm_algs(struct hisi_qm *qm)
 {
 	struct device *dev = &qm->pdev->dev;
@@ -1115,6 +1176,10 @@ static int hisi_zip_pf_probe_init(struct hisi_zip *hisi_zip)
 	if (ret)
 		return ret;
 
+	ret = hisi_zip_set_high_perf(qm);
+	if (ret)
+		return ret;
+
 	hisi_zip_open_sva_prefetch(qm);
 	hisi_qm_dev_err_init(qm);
 	hisi_zip_debug_regs_clear(qm);
-- 
2.30.0

