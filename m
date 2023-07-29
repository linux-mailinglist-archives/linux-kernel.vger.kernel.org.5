Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820D7767F4D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 14:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjG2Mzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 08:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjG2Mzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 08:55:31 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089D930C0;
        Sat, 29 Jul 2023 05:55:29 -0700 (PDT)
Received: from kwepemm600009.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RCkvw3dZqzVjlp;
        Sat, 29 Jul 2023 20:53:48 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 29 Jul 2023 20:55:26 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <liulongfang@huawei.com>, Weili Qian <qianweili@huawei.com>
Subject: [PATCH 4/7] crypto: hisilicon/qm - check function qp num before alg register
Date:   Sat, 29 Jul 2023 20:52:36 +0800
Message-ID: <20230729125239.25337-5-qianweili@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230729125239.25337-1-qianweili@huawei.com>
References: <20230729125239.25337-1-qianweili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the Kunpeng accelerator executes tasks such as encryption
and decryption have minimum requirements on the number of device
queues. If the number of queues does not meet the requirement,
the process initialization will fail. Therefore, the driver checks
the number of queues on the device before registering the algorithm.
If the number does not meet the requirements, the driver does not register
the algorithm to crypto subsystem.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_crypto.c | 25 ++++++++++-
 drivers/crypto/hisilicon/hpre/hpre_main.c   | 14 +++---
 drivers/crypto/hisilicon/qm.c               | 47 +++++++--------------
 drivers/crypto/hisilicon/sec2/sec_crypto.c  | 31 ++++++++++++--
 drivers/crypto/hisilicon/sec2/sec_main.c    | 24 +++++------
 drivers/crypto/hisilicon/zip/zip_crypto.c   | 29 ++++++++++++-
 drivers/crypto/hisilicon/zip/zip_main.c     | 10 +++--
 include/linux/hisi_acc_qm.h                 | 18 +++++++-
 8 files changed, 136 insertions(+), 62 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_crypto.c b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
index 9a1c61be32cc..764532a6ca82 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_crypto.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
@@ -57,6 +57,9 @@ struct hpre_ctx;
 #define HPRE_DRV_ECDH_MASK_CAP		BIT(2)
 #define HPRE_DRV_X25519_MASK_CAP	BIT(5)
 
+static DEFINE_MUTEX(hpre_algs_lock);
+static unsigned int hpre_available_devs;
+
 typedef void (*hpre_cb)(struct hpre_ctx *ctx, void *sqe);
 
 struct hpre_rsa_ctx {
@@ -2202,11 +2205,17 @@ static void hpre_unregister_x25519(struct hisi_qm *qm)
 
 int hpre_algs_register(struct hisi_qm *qm)
 {
-	int ret;
+	int ret = 0;
+
+	mutex_lock(&hpre_algs_lock);
+	if (hpre_available_devs) {
+		hpre_available_devs++;
+		goto unlock;
+	}
 
 	ret = hpre_register_rsa(qm);
 	if (ret)
-		return ret;
+		goto unlock;
 
 	ret = hpre_register_dh(qm);
 	if (ret)
@@ -2220,6 +2229,9 @@ int hpre_algs_register(struct hisi_qm *qm)
 	if (ret)
 		goto unreg_ecdh;
 
+	hpre_available_devs++;
+	mutex_unlock(&hpre_algs_lock);
+
 	return ret;
 
 unreg_ecdh:
@@ -2228,13 +2240,22 @@ int hpre_algs_register(struct hisi_qm *qm)
 	hpre_unregister_dh(qm);
 unreg_rsa:
 	hpre_unregister_rsa(qm);
+unlock:
+	mutex_unlock(&hpre_algs_lock);
 	return ret;
 }
 
 void hpre_algs_unregister(struct hisi_qm *qm)
 {
+	mutex_lock(&hpre_algs_lock);
+	if (--hpre_available_devs)
+		goto unlock;
+
 	hpre_unregister_x25519(qm);
 	hpre_unregister_ecdh(qm);
 	hpre_unregister_dh(qm);
 	hpre_unregister_rsa(qm);
+
+unlock:
+	mutex_unlock(&hpre_algs_lock);
 }
diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index 1709e649f0d1..b02fdd5b2df8 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -107,6 +107,7 @@
 #define HPRE_VIA_MSI_DSM		1
 #define HPRE_SQE_MASK_OFFSET		8
 #define HPRE_SQE_MASK_LEN		24
+#define HPRE_CTX_Q_NUM_DEF		1
 
 #define HPRE_DFX_BASE		0x301000
 #define HPRE_DFX_COMMON1		0x301400
@@ -1399,10 +1400,11 @@ static int hpre_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (ret)
 		dev_warn(&pdev->dev, "init debugfs fail!\n");
 
-	ret = hisi_qm_alg_register(qm, &hpre_devices);
+	hisi_qm_add_list(qm, &hpre_devices);
+	ret = hisi_qm_alg_register(qm, &hpre_devices, HPRE_CTX_Q_NUM_DEF);
 	if (ret < 0) {
 		pci_err(pdev, "fail to register algs to crypto!\n");
-		goto err_with_qm_start;
+		goto err_qm_del_list;
 	}
 
 	if (qm->uacce) {
@@ -1424,9 +1426,10 @@ static int hpre_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 err_with_alg_register:
-	hisi_qm_alg_unregister(qm, &hpre_devices);
+	hisi_qm_alg_unregister(qm, &hpre_devices, HPRE_CTX_Q_NUM_DEF);
 
-err_with_qm_start:
+err_qm_del_list:
+	hisi_qm_del_list(qm, &hpre_devices);
 	hpre_debugfs_exit(qm);
 	hisi_qm_stop(qm, QM_NORMAL);
 
@@ -1446,7 +1449,8 @@ static void hpre_remove(struct pci_dev *pdev)
 
 	hisi_qm_pm_uninit(qm);
 	hisi_qm_wait_task_finish(qm, &hpre_devices);
-	hisi_qm_alg_unregister(qm, &hpre_devices);
+	hisi_qm_alg_unregister(qm, &hpre_devices, HPRE_CTX_Q_NUM_DEF);
+	hisi_qm_del_list(qm, &hpre_devices);
 	if (qm->fun_type == QM_HW_PF && qm->vfs_num)
 		hisi_qm_sriov_disable(pdev, true);
 
diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index a114114228a5..2d0080b546e8 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -4834,63 +4834,48 @@ static void qm_cmd_process(struct work_struct *cmd_process)
 }
 
 /**
- * hisi_qm_alg_register() - Register alg to crypto and add qm to qm_list.
+ * hisi_qm_alg_register() - Register alg to crypto.
  * @qm: The qm needs add.
  * @qm_list: The qm list.
+ * @guard: Guard of qp_num.
  *
- * This function adds qm to qm list, and will register algorithm to
- * crypto when the qm list is empty.
+ * Register algorithm to crypto when the device is satisfy guard.
  */
-int hisi_qm_alg_register(struct hisi_qm *qm, struct hisi_qm_list *qm_list)
+int hisi_qm_alg_register(struct hisi_qm *qm, struct hisi_qm_list *qm_list, int guard)
 {
 	struct device *dev = &qm->pdev->dev;
-	int flag = 0;
-	int ret = 0;
-
-	mutex_lock(&qm_list->lock);
-	if (list_empty(&qm_list->list))
-		flag = 1;
-	list_add_tail(&qm->list, &qm_list->list);
-	mutex_unlock(&qm_list->lock);
 
 	if (qm->ver <= QM_HW_V2 && qm->use_sva) {
 		dev_info(dev, "HW V2 not both use uacce sva mode and hardware crypto algs.\n");
 		return 0;
 	}
 
-	if (flag) {
-		ret = qm_list->register_to_crypto(qm);
-		if (ret) {
-			mutex_lock(&qm_list->lock);
-			list_del(&qm->list);
-			mutex_unlock(&qm_list->lock);
-		}
+	if (qm->qp_num < guard) {
+		dev_info(dev, "qp_num is less than task need.\n");
+		return 0;
 	}
 
-	return ret;
+	return qm_list->register_to_crypto(qm);
 }
 EXPORT_SYMBOL_GPL(hisi_qm_alg_register);
 
 /**
- * hisi_qm_alg_unregister() - Unregister alg from crypto and delete qm from
- * qm list.
+ * hisi_qm_alg_unregister() - Unregister alg from crypto.
  * @qm: The qm needs delete.
  * @qm_list: The qm list.
+ * @guard: Guard of qp_num.
  *
- * This function deletes qm from qm list, and will unregister algorithm
- * from crypto when the qm list is empty.
+ * Unregister algorithm from crypto when the last function is satisfy guard.
  */
-void hisi_qm_alg_unregister(struct hisi_qm *qm, struct hisi_qm_list *qm_list)
+void hisi_qm_alg_unregister(struct hisi_qm *qm, struct hisi_qm_list *qm_list, int guard)
 {
-	mutex_lock(&qm_list->lock);
-	list_del(&qm->list);
-	mutex_unlock(&qm_list->lock);
-
 	if (qm->ver <= QM_HW_V2 && qm->use_sva)
 		return;
 
-	if (list_empty(&qm_list->list))
-		qm_list->unregister_from_crypto(qm);
+	if (qm->qp_num < guard)
+		return;
+
+	qm_list->unregister_from_crypto(qm);
 }
 EXPORT_SYMBOL_GPL(hisi_qm_alg_unregister);
 
diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index 074e50ef512c..99a28a132f8a 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -104,6 +104,9 @@
 #define IV_CTR_INIT		0x1
 #define IV_BYTE_OFFSET		0x8
 
+static DEFINE_MUTEX(sec_algs_lock);
+static unsigned int sec_available_devs;
+
 struct sec_skcipher {
 	u64 alg_msk;
 	struct skcipher_alg alg;
@@ -2544,16 +2547,31 @@ static int sec_register_aead(u64 alg_mask)
 int sec_register_to_crypto(struct hisi_qm *qm)
 {
 	u64 alg_mask = sec_get_alg_bitmap(qm, SEC_DRV_ALG_BITMAP_HIGH, SEC_DRV_ALG_BITMAP_LOW);
-	int ret;
+	int ret = 0;
+
+	mutex_lock(&sec_algs_lock);
+	if (sec_available_devs) {
+		sec_available_devs++;
+		goto unlock;
+	}
 
 	ret = sec_register_skcipher(alg_mask);
 	if (ret)
-		return ret;
+		goto unlock;
 
 	ret = sec_register_aead(alg_mask);
 	if (ret)
-		sec_unregister_skcipher(alg_mask, ARRAY_SIZE(sec_skciphers));
+		goto unreg_skcipher;
 
+	sec_available_devs++;
+	mutex_unlock(&sec_algs_lock);
+
+	return 0;
+
+unreg_skcipher:
+	sec_unregister_skcipher(alg_mask, ARRAY_SIZE(sec_skciphers));
+unlock:
+	mutex_unlock(&sec_algs_lock);
 	return ret;
 }
 
@@ -2561,6 +2579,13 @@ void sec_unregister_from_crypto(struct hisi_qm *qm)
 {
 	u64 alg_mask = sec_get_alg_bitmap(qm, SEC_DRV_ALG_BITMAP_HIGH, SEC_DRV_ALG_BITMAP_LOW);
 
+	mutex_lock(&sec_algs_lock);
+	if (--sec_available_devs)
+		goto unlock;
+
 	sec_unregister_aead(alg_mask, ARRAY_SIZE(sec_aeads));
 	sec_unregister_skcipher(alg_mask, ARRAY_SIZE(sec_skciphers));
+
+unlock:
+	mutex_unlock(&sec_algs_lock);
 }
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 62bd8936a915..0e56a47eb862 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -1234,15 +1234,11 @@ static int sec_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (ret)
 		pci_warn(pdev, "Failed to init debugfs!\n");
 
-	if (qm->qp_num >= ctx_q_num) {
-		ret = hisi_qm_alg_register(qm, &sec_devices);
-		if (ret < 0) {
-			pr_err("Failed to register driver to crypto.\n");
-			goto err_qm_stop;
-		}
-	} else {
-		pci_warn(qm->pdev,
-			"Failed to use kernel mode, qp not enough!\n");
+	hisi_qm_add_list(qm, &sec_devices);
+	ret = hisi_qm_alg_register(qm, &sec_devices, ctx_q_num);
+	if (ret < 0) {
+		pr_err("Failed to register driver to crypto.\n");
+		goto err_qm_del_list;
 	}
 
 	if (qm->uacce) {
@@ -1264,9 +1260,9 @@ static int sec_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 err_alg_unregister:
-	if (qm->qp_num >= ctx_q_num)
-		hisi_qm_alg_unregister(qm, &sec_devices);
-err_qm_stop:
+	hisi_qm_alg_unregister(qm, &sec_devices, ctx_q_num);
+err_qm_del_list:
+	hisi_qm_del_list(qm, &sec_devices);
 	sec_debugfs_exit(qm);
 	hisi_qm_stop(qm, QM_NORMAL);
 err_probe_uninit:
@@ -1283,8 +1279,8 @@ static void sec_remove(struct pci_dev *pdev)
 
 	hisi_qm_pm_uninit(qm);
 	hisi_qm_wait_task_finish(qm, &sec_devices);
-	if (qm->qp_num >= ctx_q_num)
-		hisi_qm_alg_unregister(qm, &sec_devices);
+	hisi_qm_alg_unregister(qm, &sec_devices, ctx_q_num);
+	hisi_qm_del_list(qm, &sec_devices);
 
 	if (qm->fun_type == QM_HW_PF && qm->vfs_num)
 		hisi_qm_sriov_disable(pdev, true);
diff --git a/drivers/crypto/hisilicon/zip/zip_crypto.c b/drivers/crypto/hisilicon/zip/zip_crypto.c
index 6608971d10cd..0443205cd45c 100644
--- a/drivers/crypto/hisilicon/zip/zip_crypto.c
+++ b/drivers/crypto/hisilicon/zip/zip_crypto.c
@@ -42,6 +42,9 @@
 #define HZIP_ALG_ZLIB				GENMASK(1, 0)
 #define HZIP_ALG_GZIP				GENMASK(3, 2)
 
+static DEFINE_MUTEX(zip_algs_lock);
+static unsigned int zip_available_devs;
+
 static const u8 zlib_head[HZIP_ZLIB_HEAD_SIZE] = {0x78, 0x9c};
 static const u8 gzip_head[HZIP_GZIP_HEAD_SIZE] = {
 	0x1f, 0x8b, 0x08, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x03
@@ -821,19 +824,41 @@ int hisi_zip_register_to_crypto(struct hisi_qm *qm)
 {
 	int ret = 0;
 
+	mutex_lock(&zip_algs_lock);
+	if (zip_available_devs) {
+		zip_available_devs++;
+		goto unlock;
+	}
+
 	ret = hisi_zip_register_zlib(qm);
 	if (ret)
-		return ret;
+		goto unlock;
 
 	ret = hisi_zip_register_gzip(qm);
 	if (ret)
-		hisi_zip_unregister_zlib(qm);
+		goto unreg_zlib;
+
+	zip_available_devs++;
+	mutex_unlock(&zip_algs_lock);
 
+	return 0;
+
+unreg_zlib:
+	hisi_zip_unregister_zlib(qm);
+unlock:
+	mutex_unlock(&zip_algs_lock);
 	return ret;
 }
 
 void hisi_zip_unregister_from_crypto(struct hisi_qm *qm)
 {
+	mutex_lock(&zip_algs_lock);
+	if (--zip_available_devs)
+		goto unlock;
+
 	hisi_zip_unregister_zlib(qm);
 	hisi_zip_unregister_gzip(qm);
+
+unlock:
+	mutex_unlock(&zip_algs_lock);
 }
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 84dbaeb07ea8..73e9d91ca716 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -66,6 +66,7 @@
 #define HZIP_SQE_SIZE			128
 #define HZIP_PF_DEF_Q_NUM		64
 #define HZIP_PF_DEF_Q_BASE		0
+#define HZIP_CTX_Q_NUM_DEF		2
 
 #define HZIP_SOFT_CTRL_CNT_CLR_CE	0x301000
 #define HZIP_SOFT_CTRL_CNT_CLR_CE_BIT	BIT(0)
@@ -1231,7 +1232,8 @@ static int hisi_zip_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (ret)
 		pci_err(pdev, "failed to init debugfs (%d)!\n", ret);
 
-	ret = hisi_qm_alg_register(qm, &zip_devices);
+	hisi_qm_add_list(qm, &zip_devices);
+	ret = hisi_qm_alg_register(qm, &zip_devices, HZIP_CTX_Q_NUM_DEF);
 	if (ret < 0) {
 		pci_err(pdev, "failed to register driver to crypto!\n");
 		goto err_qm_stop;
@@ -1256,9 +1258,10 @@ static int hisi_zip_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 err_qm_alg_unregister:
-	hisi_qm_alg_unregister(qm, &zip_devices);
+	hisi_qm_alg_unregister(qm, &zip_devices, HZIP_CTX_Q_NUM_DEF);
 
 err_qm_stop:
+	hisi_qm_del_list(qm, &zip_devices);
 	hisi_zip_debugfs_exit(qm);
 	hisi_qm_stop(qm, QM_NORMAL);
 
@@ -1278,7 +1281,8 @@ static void hisi_zip_remove(struct pci_dev *pdev)
 
 	hisi_qm_pm_uninit(qm);
 	hisi_qm_wait_task_finish(qm, &zip_devices);
-	hisi_qm_alg_unregister(qm, &zip_devices);
+	hisi_qm_alg_unregister(qm, &zip_devices, HZIP_CTX_Q_NUM_DEF);
+	hisi_qm_del_list(qm, &zip_devices);
 
 	if (qm->fun_type == QM_HW_PF && qm->vfs_num)
 		hisi_qm_sriov_disable(pdev, true);
diff --git a/include/linux/hisi_acc_qm.h b/include/linux/hisi_acc_qm.h
index 576a0601c72e..1b5082ed48d9 100644
--- a/include/linux/hisi_acc_qm.h
+++ b/include/linux/hisi_acc_qm.h
@@ -490,6 +490,20 @@ static inline void hisi_qm_init_list(struct hisi_qm_list *qm_list)
 	mutex_init(&qm_list->lock);
 }
 
+static inline void hisi_qm_add_list(struct hisi_qm *qm, struct hisi_qm_list *qm_list)
+{
+	mutex_lock(&qm_list->lock);
+	list_add_tail(&qm->list, &qm_list->list);
+	mutex_unlock(&qm_list->lock);
+}
+
+static inline void hisi_qm_del_list(struct hisi_qm *qm, struct hisi_qm_list *qm_list)
+{
+	mutex_lock(&qm_list->lock);
+	list_del(&qm->list);
+	mutex_unlock(&qm_list->lock);
+}
+
 int hisi_qm_init(struct hisi_qm *qm);
 void hisi_qm_uninit(struct hisi_qm *qm);
 int hisi_qm_start(struct hisi_qm *qm);
@@ -535,8 +549,8 @@ int hisi_qm_alloc_qps_node(struct hisi_qm_list *qm_list, int qp_num,
 void hisi_qm_free_qps(struct hisi_qp **qps, int qp_num);
 void hisi_qm_dev_shutdown(struct pci_dev *pdev);
 void hisi_qm_wait_task_finish(struct hisi_qm *qm, struct hisi_qm_list *qm_list);
-int hisi_qm_alg_register(struct hisi_qm *qm, struct hisi_qm_list *qm_list);
-void hisi_qm_alg_unregister(struct hisi_qm *qm, struct hisi_qm_list *qm_list);
+int hisi_qm_alg_register(struct hisi_qm *qm, struct hisi_qm_list *qm_list, int guard);
+void hisi_qm_alg_unregister(struct hisi_qm *qm, struct hisi_qm_list *qm_list, int guard);
 int hisi_qm_resume(struct device *dev);
 int hisi_qm_suspend(struct device *dev);
 void hisi_qm_pm_uninit(struct hisi_qm *qm);
-- 
2.33.0

