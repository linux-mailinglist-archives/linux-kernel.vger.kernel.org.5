Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16CC801BAE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 10:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjLBJVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 04:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbjLBJUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 04:20:54 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769901A4;
        Sat,  2 Dec 2023 01:20:58 -0800 (PST)
Received: from dggpeml500005.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Sj47s56G1zsRZf;
        Sat,  2 Dec 2023 17:17:13 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 dggpeml500005.china.huawei.com (7.185.36.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 2 Dec 2023 17:20:56 +0800
From:   Zhiqi Song <songzhiqi1@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <fanghao11@huawei.com>,
        <liulongfang@huawei.com>, <qianweili@huawei.com>,
        <shenyang39@huawei.com>
Subject: [PATCH 2/5] crypto: hisilicon/qm - save capability registers in qm init process
Date:   Sat, 2 Dec 2023 17:17:19 +0800
Message-ID: <20231202091722.1974582-3-songzhiqi1@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231202091722.1974582-1-songzhiqi1@huawei.com>
References: <20231202091722.1974582-1-songzhiqi1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500005.china.huawei.com (7.185.36.59)
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

In previous capability register implementation, qm irq related values
were read from capability registers dynamically when needed. But in
abnormal scenario, e.g. the core is timeout and the device needs to
soft reset and reset failed after disabling the MSE, the device can
not be removed normally, causing the following call trace:

	| Call trace:
        |  pci_irq_vector+0xfc/0x140
        |  hisi_qm_uninit+0x278/0x3b0 [hisi_qm]
        |  hpre_remove+0x16c/0x1c0 [hisi_hpre]
        |  pci_device_remove+0x6c/0x264
        |  device_release_driver_internal+0x1ec/0x3e0
        |  device_release_driver+0x3c/0x60
        |  pci_stop_bus_device+0xfc/0x22c
        |  pci_stop_and_remove_bus_device+0x38/0x70
        |  pci_iov_remove_virtfn+0x108/0x1c0
        |  sriov_disable+0x7c/0x1e4
        |  pci_disable_sriov+0x4c/0x6c
        |  hisi_qm_sriov_disable+0x90/0x160 [hisi_qm]
        |  hpre_remove+0x1a8/0x1c0 [hisi_hpre]
        |  pci_device_remove+0x6c/0x264
        |  device_release_driver_internal+0x1ec/0x3e0
        |  driver_detach+0x168/0x2d0
        |  bus_remove_driver+0xc0/0x230
        |  driver_unregister+0x58/0xdc
        |  pci_unregister_driver+0x40/0x220
        |  hpre_exit+0x34/0x64 [hisi_hpre]
        |  __arm64_sys_delete_module+0x374/0x620
        [...]

        | Call trace:
        |  free_msi_irqs+0x25c/0x300
        |  pci_disable_msi+0x19c/0x264
        |  pci_free_irq_vectors+0x4c/0x70
        |  hisi_qm_pci_uninit+0x44/0x90 [hisi_qm]
        |  hisi_qm_uninit+0x28c/0x3b0 [hisi_qm]
        |  hpre_remove+0x16c/0x1c0 [hisi_hpre]
        |  pci_device_remove+0x6c/0x264
        [...]

The reason for this call trace is that when the MSE is disabled, the value
of capability registers in the BAR space become invalid. This will make the
subsequent unregister process get the wrong irq vector through capability
registers and get the wrong irq number by pci_irq_vector().

So add a capability table structure to pre-store the valid value of the irq
information capability register in qm init process, avoid obtaining invalid
capability register value after the MSE is disabled.

Fixes: 3536cc55cada ("crypto: hisilicon/qm - support get device irq information from hardware registers")
Signed-off-by: Zhiqi Song <songzhiqi1@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 62 +++++++++++++++++++++++++++++------
 include/linux/hisi_acc_qm.h   | 12 +++++++
 2 files changed, 64 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 4170c24c2ed1..d05ad2b16d0a 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -301,6 +301,13 @@ enum qm_basic_type {
 	QM_VF_IRQ_NUM_CAP,
 };
 
+enum qm_pre_store_cap_idx {
+	QM_EQ_IRQ_TYPE_CAP_IDX = 0x0,
+	QM_AEQ_IRQ_TYPE_CAP_IDX,
+	QM_ABN_IRQ_TYPE_CAP_IDX,
+	QM_PF2VF_IRQ_TYPE_CAP_IDX,
+};
+
 static const struct hisi_qm_cap_info qm_cap_info_comm[] = {
 	{QM_SUPPORT_DB_ISOLATION, 0x30,   0, BIT(0),  0x0, 0x0, 0x0},
 	{QM_SUPPORT_FUNC_QOS,     0x3100, 0, BIT(8),  0x0, 0x0, 0x1},
@@ -330,6 +337,13 @@ static const struct hisi_qm_cap_info qm_basic_info[] = {
 	{QM_VF_IRQ_NUM_CAP,     0x311c,   0,  GENMASK(15, 0), 0x1,       0x2,       0x3},
 };
 
+static const u32 qm_pre_store_caps[] = {
+	QM_EQ_IRQ_TYPE_CAP,
+	QM_AEQ_IRQ_TYPE_CAP,
+	QM_ABN_IRQ_TYPE_CAP,
+	QM_PF2VF_IRQ_TYPE_CAP,
+};
+
 struct qm_mailbox {
 	__le16 w0;
 	__le16 queue_num;
@@ -4774,7 +4788,7 @@ static void qm_unregister_abnormal_irq(struct hisi_qm *qm)
 	if (qm->fun_type == QM_HW_VF)
 		return;
 
-	val = hisi_qm_get_hw_info(qm, qm_basic_info, QM_ABN_IRQ_TYPE_CAP, qm->cap_ver);
+	val = qm->cap_tables.qm_cap_table[QM_ABN_IRQ_TYPE_CAP_IDX].cap_val;
 	if (!((val >> QM_IRQ_TYPE_SHIFT) & QM_ABN_IRQ_TYPE_MASK))
 		return;
 
@@ -4791,7 +4805,7 @@ static int qm_register_abnormal_irq(struct hisi_qm *qm)
 	if (qm->fun_type == QM_HW_VF)
 		return 0;
 
-	val = hisi_qm_get_hw_info(qm, qm_basic_info, QM_ABN_IRQ_TYPE_CAP, qm->cap_ver);
+	val = qm->cap_tables.qm_cap_table[QM_ABN_IRQ_TYPE_CAP_IDX].cap_val;
 	if (!((val >> QM_IRQ_TYPE_SHIFT) & QM_ABN_IRQ_TYPE_MASK))
 		return 0;
 
@@ -4808,7 +4822,7 @@ static void qm_unregister_mb_cmd_irq(struct hisi_qm *qm)
 	struct pci_dev *pdev = qm->pdev;
 	u32 irq_vector, val;
 
-	val = hisi_qm_get_hw_info(qm, qm_basic_info, QM_PF2VF_IRQ_TYPE_CAP, qm->cap_ver);
+	val = qm->cap_tables.qm_cap_table[QM_PF2VF_IRQ_TYPE_CAP_IDX].cap_val;
 	if (!((val >> QM_IRQ_TYPE_SHIFT) & QM_IRQ_TYPE_MASK))
 		return;
 
@@ -4822,7 +4836,7 @@ static int qm_register_mb_cmd_irq(struct hisi_qm *qm)
 	u32 irq_vector, val;
 	int ret;
 
-	val = hisi_qm_get_hw_info(qm, qm_basic_info, QM_PF2VF_IRQ_TYPE_CAP, qm->cap_ver);
+	val = qm->cap_tables.qm_cap_table[QM_PF2VF_IRQ_TYPE_CAP_IDX].cap_val;
 	if (!((val >> QM_IRQ_TYPE_SHIFT) & QM_IRQ_TYPE_MASK))
 		return 0;
 
@@ -4839,7 +4853,7 @@ static void qm_unregister_aeq_irq(struct hisi_qm *qm)
 	struct pci_dev *pdev = qm->pdev;
 	u32 irq_vector, val;
 
-	val = hisi_qm_get_hw_info(qm, qm_basic_info, QM_AEQ_IRQ_TYPE_CAP, qm->cap_ver);
+	val = qm->cap_tables.qm_cap_table[QM_AEQ_IRQ_TYPE_CAP_IDX].cap_val;
 	if (!((val >> QM_IRQ_TYPE_SHIFT) & QM_IRQ_TYPE_MASK))
 		return;
 
@@ -4853,7 +4867,7 @@ static int qm_register_aeq_irq(struct hisi_qm *qm)
 	u32 irq_vector, val;
 	int ret;
 
-	val = hisi_qm_get_hw_info(qm, qm_basic_info, QM_AEQ_IRQ_TYPE_CAP, qm->cap_ver);
+	val = qm->cap_tables.qm_cap_table[QM_AEQ_IRQ_TYPE_CAP_IDX].cap_val;
 	if (!((val >> QM_IRQ_TYPE_SHIFT) & QM_IRQ_TYPE_MASK))
 		return 0;
 
@@ -4871,7 +4885,7 @@ static void qm_unregister_eq_irq(struct hisi_qm *qm)
 	struct pci_dev *pdev = qm->pdev;
 	u32 irq_vector, val;
 
-	val = hisi_qm_get_hw_info(qm, qm_basic_info, QM_EQ_IRQ_TYPE_CAP, qm->cap_ver);
+	val = qm->cap_tables.qm_cap_table[QM_EQ_IRQ_TYPE_CAP_IDX].cap_val;
 	if (!((val >> QM_IRQ_TYPE_SHIFT) & QM_IRQ_TYPE_MASK))
 		return;
 
@@ -4885,7 +4899,7 @@ static int qm_register_eq_irq(struct hisi_qm *qm)
 	u32 irq_vector, val;
 	int ret;
 
-	val = hisi_qm_get_hw_info(qm, qm_basic_info, QM_EQ_IRQ_TYPE_CAP, qm->cap_ver);
+	val = qm->cap_tables.qm_cap_table[QM_EQ_IRQ_TYPE_CAP_IDX].cap_val;
 	if (!((val >> QM_IRQ_TYPE_SHIFT) & QM_IRQ_TYPE_MASK))
 		return 0;
 
@@ -4973,7 +4987,29 @@ static int qm_get_qp_num(struct hisi_qm *qm)
 	return 0;
 }
 
-static void qm_get_hw_caps(struct hisi_qm *qm)
+static int qm_pre_store_irq_type_caps(struct hisi_qm *qm)
+{
+	struct hisi_qm_cap_record *qm_cap;
+	struct pci_dev *pdev = qm->pdev;
+	size_t i, size;
+
+	size = ARRAY_SIZE(qm_pre_store_caps);
+	qm_cap = devm_kzalloc(&pdev->dev, sizeof(*qm_cap) * size, GFP_KERNEL);
+	if (!qm_cap)
+		return -ENOMEM;
+
+	for (i = 0; i < size; i++) {
+		qm_cap[i].type = qm_pre_store_caps[i];
+		qm_cap[i].cap_val = hisi_qm_get_hw_info(qm, qm_basic_info,
+							qm_pre_store_caps[i], qm->cap_ver);
+	}
+
+	qm->cap_tables.qm_cap_table = qm_cap;
+
+	return 0;
+}
+
+static int qm_get_hw_caps(struct hisi_qm *qm)
 {
 	const struct hisi_qm_cap_info *cap_info = qm->fun_type == QM_HW_PF ?
 						  qm_cap_info_pf : qm_cap_info_vf;
@@ -5004,6 +5040,9 @@ static void qm_get_hw_caps(struct hisi_qm *qm)
 		if (val)
 			set_bit(cap_info[i].type, &qm->caps);
 	}
+
+	/* Fetch and save the value of irq type related capability registers */
+	return qm_pre_store_irq_type_caps(qm);
 }
 
 static int qm_get_pci_res(struct hisi_qm *qm)
@@ -5025,7 +5064,10 @@ static int qm_get_pci_res(struct hisi_qm *qm)
 		goto err_request_mem_regions;
 	}
 
-	qm_get_hw_caps(qm);
+	ret = qm_get_hw_caps(qm);
+	if (ret)
+		goto err_ioremap;
+
 	if (test_bit(QM_SUPPORT_DB_ISOLATION, &qm->caps)) {
 		qm->db_interval = QM_QP_DB_INTERVAL;
 		qm->db_phys_base = pci_resource_start(pdev, PCI_BAR_4);
diff --git a/include/linux/hisi_acc_qm.h b/include/linux/hisi_acc_qm.h
index cdc979f66dba..5f4c74facf6a 100644
--- a/include/linux/hisi_acc_qm.h
+++ b/include/linux/hisi_acc_qm.h
@@ -266,6 +266,16 @@ struct hisi_qm_cap_info {
 	u32 v3_val;
 };
 
+struct hisi_qm_cap_record {
+	u32 type;
+	u32 cap_val;
+};
+
+struct hisi_qm_cap_tables {
+	struct hisi_qm_cap_record *qm_cap_table;
+	struct hisi_qm_cap_record *dev_cap_table;
+};
+
 struct hisi_qm_list {
 	struct mutex lock;
 	struct list_head list;
@@ -376,6 +386,8 @@ struct hisi_qm {
 	u32 mb_qos;
 	u32 type_rate;
 	struct qm_err_isolate isolate_data;
+
+	struct hisi_qm_cap_tables cap_tables;
 };
 
 struct hisi_qp_status {
-- 
2.30.0

