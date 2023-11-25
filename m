Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10EC7F8A57
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 12:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjKYLuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 06:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbjKYLuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 06:50:08 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6A710EB;
        Sat, 25 Nov 2023 03:50:12 -0800 (PST)
Received: from kwepemm000009.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Scqs30W1QzvQvp;
        Sat, 25 Nov 2023 19:49:43 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm000009.china.huawei.com (7.193.23.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 25 Nov 2023 19:50:10 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liulongfang@huawei.com>
Subject: [PATCH 2/3] crypto: hisilicon/qm - simplify the status of qm
Date:   Sat, 25 Nov 2023 19:50:10 +0800
Message-ID: <20231125115011.22519-3-qianweili@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231125115011.22519-1-qianweili@huawei.com>
References: <20231125115011.22519-1-qianweili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000009.china.huawei.com (7.193.23.227)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'QM_INIT' and 'QM_CLOSE' status of qm and 'QP_INIT'
and 'QP_CLOSE' status of queue are not actually used. Currently,
driver only needs to switch status when the device or queue
is enabled or stopped, Therefore, remove unneeded status to
simplify driver. In addition, rename'QM_START to'QM_WORK' for
ease to understand.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 Documentation/ABI/testing/debugfs-hisi-hpre |   2 +-
 Documentation/ABI/testing/debugfs-hisi-sec  |   2 +-
 Documentation/ABI/testing/debugfs-hisi-zip  |   2 +-
 drivers/crypto/hisilicon/debugfs.c          |   4 +
 drivers/crypto/hisilicon/qm.c               | 130 +++-----------------
 drivers/crypto/hisilicon/qm_common.h        |   4 -
 include/linux/hisi_acc_qm.h                 |   8 +-
 7 files changed, 25 insertions(+), 127 deletions(-)

diff --git a/Documentation/ABI/testing/debugfs-hisi-hpre b/Documentation/ABI/testing/debugfs-hisi-hpre
index 82abf92df429..8e8de49c5cc6 100644
--- a/Documentation/ABI/testing/debugfs-hisi-hpre
+++ b/Documentation/ABI/testing/debugfs-hisi-hpre
@@ -101,7 +101,7 @@ What:		/sys/kernel/debug/hisi_hpre/<bdf>/qm/status
 Date:		Apr 2020
 Contact:	linux-crypto@vger.kernel.org
 Description:	Dump the status of the QM.
-		Four states: initiated, started, stopped and closed.
+		Two states: work, stop.
 		Available for both PF and VF, and take no other effect on HPRE.
 
 What:		/sys/kernel/debug/hisi_hpre/<bdf>/qm/diff_regs
diff --git a/Documentation/ABI/testing/debugfs-hisi-sec b/Documentation/ABI/testing/debugfs-hisi-sec
index 93c530d1bf0f..deeefe2c735e 100644
--- a/Documentation/ABI/testing/debugfs-hisi-sec
+++ b/Documentation/ABI/testing/debugfs-hisi-sec
@@ -81,7 +81,7 @@ What:		/sys/kernel/debug/hisi_sec2/<bdf>/qm/status
 Date:		Apr 2020
 Contact:	linux-crypto@vger.kernel.org
 Description:	Dump the status of the QM.
-		Four states: initiated, started, stopped and closed.
+		Two states: work, stop.
 		Available for both PF and VF, and take no other effect on SEC.
 
 What:		/sys/kernel/debug/hisi_sec2/<bdf>/qm/diff_regs
diff --git a/Documentation/ABI/testing/debugfs-hisi-zip b/Documentation/ABI/testing/debugfs-hisi-zip
index fd3f314cf8d1..593714afaed2 100644
--- a/Documentation/ABI/testing/debugfs-hisi-zip
+++ b/Documentation/ABI/testing/debugfs-hisi-zip
@@ -94,7 +94,7 @@ What:		/sys/kernel/debug/hisi_zip/<bdf>/qm/status
 Date:		Apr 2020
 Contact:	linux-crypto@vger.kernel.org
 Description:	Dump the status of the QM.
-		Four states: initiated, started, stopped and closed.
+		Two states: work, stop.
 		Available for both PF and VF, and take no other effect on ZIP.
 
 What:		/sys/kernel/debug/hisi_zip/<bdf>/qm/diff_regs
diff --git a/drivers/crypto/hisilicon/debugfs.c b/drivers/crypto/hisilicon/debugfs.c
index 415139b4abc1..80ed4b2d209c 100644
--- a/drivers/crypto/hisilicon/debugfs.c
+++ b/drivers/crypto/hisilicon/debugfs.c
@@ -31,6 +31,10 @@ static const char * const qm_debug_file_name[] = {
 	[CLEAR_ENABLE] = "clear_enable",
 };
 
+static const char * const qm_s[] = {
+	"work", "stop",
+};
+
 struct qm_dfx_item {
 	const char *name;
 	u32 offset;
diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 4d91a249be74..7d22412774ba 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -402,10 +402,6 @@ static const char * const qm_fifo_overflow[] = {
 	"cq", "eq", "aeq",
 };
 
-static const char * const qp_s[] = {
-	"none", "init", "start", "stop", "close",
-};
-
 struct qm_typical_qos_table {
 	u32 start;
 	u32 end;
@@ -433,85 +429,6 @@ static struct qm_typical_qos_table shaper_cbs_s[] = {
 
 static void qm_irqs_unregister(struct hisi_qm *qm);
 
-static bool qm_avail_state(struct hisi_qm *qm, enum qm_state new)
-{
-	enum qm_state curr = atomic_read(&qm->status.flags);
-	bool avail = false;
-
-	switch (curr) {
-	case QM_INIT:
-		if (new == QM_START || new == QM_CLOSE)
-			avail = true;
-		break;
-	case QM_START:
-		if (new == QM_STOP)
-			avail = true;
-		break;
-	case QM_STOP:
-		if (new == QM_CLOSE || new == QM_START)
-			avail = true;
-		break;
-	default:
-		break;
-	}
-
-	dev_dbg(&qm->pdev->dev, "change qm state from %s to %s\n",
-		qm_s[curr], qm_s[new]);
-
-	if (!avail)
-		dev_warn(&qm->pdev->dev, "Can not change qm state from %s to %s\n",
-			 qm_s[curr], qm_s[new]);
-
-	return avail;
-}
-
-static bool qm_qp_avail_state(struct hisi_qm *qm, struct hisi_qp *qp,
-			      enum qp_state new)
-{
-	enum qm_state qm_curr = atomic_read(&qm->status.flags);
-	enum qp_state qp_curr = 0;
-	bool avail = false;
-
-	if (qp)
-		qp_curr = atomic_read(&qp->qp_status.flags);
-
-	switch (new) {
-	case QP_INIT:
-		if (qm_curr == QM_START || qm_curr == QM_INIT)
-			avail = true;
-		break;
-	case QP_START:
-		if ((qm_curr == QM_START && qp_curr == QP_INIT) ||
-		    (qm_curr == QM_START && qp_curr == QP_STOP))
-			avail = true;
-		break;
-	case QP_STOP:
-		if ((qm_curr == QM_START && qp_curr == QP_START) ||
-		    (qp_curr == QP_INIT))
-			avail = true;
-		break;
-	case QP_CLOSE:
-		if ((qm_curr == QM_START && qp_curr == QP_INIT) ||
-		    (qm_curr == QM_START && qp_curr == QP_STOP) ||
-		    (qm_curr == QM_STOP && qp_curr == QP_STOP)  ||
-		    (qm_curr == QM_STOP && qp_curr == QP_INIT))
-			avail = true;
-		break;
-	default:
-		break;
-	}
-
-	dev_dbg(&qm->pdev->dev, "change qp state from %s to %s in QM %s\n",
-		qp_s[qp_curr], qp_s[new], qm_s[qm_curr]);
-
-	if (!avail)
-		dev_warn(&qm->pdev->dev,
-			 "Can not change qp state from %s to %s in QM %s\n",
-			 qp_s[qp_curr], qp_s[new], qm_s[qm_curr]);
-
-	return avail;
-}
-
 static u32 qm_get_hw_error_status(struct hisi_qm *qm)
 {
 	return readl(qm->io_base + QM_ABNORMAL_INT_STATUS);
@@ -1853,8 +1770,10 @@ static struct hisi_qp *qm_create_qp_nolock(struct hisi_qm *qm, u8 alg_type)
 	struct hisi_qp *qp;
 	int qp_id;
 
-	if (!qm_qp_avail_state(qm, NULL, QP_INIT))
+	if (atomic_read(&qm->status.flags) == QM_STOP) {
+		dev_info_ratelimited(dev, "failed to create qp as qm is stop!\n");
 		return ERR_PTR(-EPERM);
+	}
 
 	if (qm->qp_in_used == qm->qp_num) {
 		dev_info_ratelimited(dev, "All %u queues of QM are busy!\n",
@@ -1881,7 +1800,6 @@ static struct hisi_qp *qm_create_qp_nolock(struct hisi_qm *qm, u8 alg_type)
 	qp->alg_type = alg_type;
 	qp->is_in_kernel = true;
 	qm->qp_in_used++;
-	atomic_set(&qp->qp_status.flags, QP_INIT);
 
 	return qp;
 }
@@ -1924,11 +1842,6 @@ static void hisi_qm_release_qp(struct hisi_qp *qp)
 
 	down_write(&qm->qps_lock);
 
-	if (!qm_qp_avail_state(qm, qp, QP_CLOSE)) {
-		up_write(&qm->qps_lock);
-		return;
-	}
-
 	qm->qp_in_used--;
 	idr_remove(&qm->qp_idr, qp->qp_id);
 
@@ -2008,8 +1921,10 @@ static int qm_start_qp_nolock(struct hisi_qp *qp, unsigned long arg)
 	u32 pasid = arg;
 	int ret;
 
-	if (!qm_qp_avail_state(qm, qp, QP_START))
+	if (atomic_read(&qm->status.flags) == QM_STOP) {
+		dev_info_ratelimited(dev, "failed to start qp as qm is stop!\n");
 		return -EPERM;
+	}
 
 	ret = qm_qp_ctx_cfg(qp, qp_id, pasid);
 	if (ret)
@@ -2131,21 +2046,17 @@ static int qm_stop_qp_nolock(struct hisi_qp *qp)
 	 * is_resetting flag should be set negative so that this qp will not
 	 * be restarted after reset.
 	 */
-	if (atomic_read(&qp->qp_status.flags) == QP_STOP) {
+	if (atomic_read(&qp->qp_status.flags) != QP_START) {
 		qp->is_resetting = false;
 		return 0;
 	}
 
-	if (!qm_qp_avail_state(qp->qm, qp, QP_STOP))
-		return -EPERM;
-
 	atomic_set(&qp->qp_status.flags, QP_STOP);
 
 	ret = qm_drain_qp(qp);
 	if (ret)
 		dev_err(dev, "Failed to drain out data for stopping!\n");
 
-
 	flush_workqueue(qp->qm->wq);
 	if (unlikely(qp->is_resetting && atomic_read(&qp->qp_status.used)))
 		qp_stop_fail_cb(qp);
@@ -2865,13 +2776,8 @@ void hisi_qm_uninit(struct hisi_qm *qm)
 {
 	qm_cmd_uninit(qm);
 	hisi_qm_unint_work(qm);
-	down_write(&qm->qps_lock);
-
-	if (!qm_avail_state(qm, QM_CLOSE)) {
-		up_write(&qm->qps_lock);
-		return;
-	}
 
+	down_write(&qm->qps_lock);
 	hisi_qm_memory_uninit(qm);
 	hisi_qm_set_state(qm, QM_NOT_READY);
 	up_write(&qm->qps_lock);
@@ -3045,11 +2951,6 @@ int hisi_qm_start(struct hisi_qm *qm)
 
 	down_write(&qm->qps_lock);
 
-	if (!qm_avail_state(qm, QM_START)) {
-		up_write(&qm->qps_lock);
-		return -EPERM;
-	}
-
 	dev_dbg(dev, "qm start with %u queue pairs\n", qm->qp_num);
 
 	if (!qm->qp_num) {
@@ -3059,10 +2960,12 @@ int hisi_qm_start(struct hisi_qm *qm)
 	}
 
 	ret = __hisi_qm_start(qm);
-	if (!ret)
-		atomic_set(&qm->status.flags, QM_START);
+	if (ret)
+		goto err_unlock;
 
+	atomic_set(&qm->status.flags, QM_WORK);
 	hisi_qm_set_state(qm, QM_READY);
+
 err_unlock:
 	up_write(&qm->qps_lock);
 	return ret;
@@ -3159,10 +3062,11 @@ int hisi_qm_stop(struct hisi_qm *qm, enum qm_stop_reason r)
 	down_write(&qm->qps_lock);
 
 	qm->status.stop_reason = r;
-	if (!qm_avail_state(qm, QM_STOP)) {
-		ret = -EPERM;
+	if (atomic_read(&qm->status.flags) == QM_STOP)
 		goto err_unlock;
-	}
+
+	/* Stop all the request sending at first. */
+	atomic_set(&qm->status.flags, QM_STOP);
 
 	if (qm->status.stop_reason == QM_SOFT_RESET ||
 	    qm->status.stop_reason == QM_DOWN) {
@@ -3186,7 +3090,6 @@ int hisi_qm_stop(struct hisi_qm *qm, enum qm_stop_reason r)
 	}
 
 	qm_clear_queues(qm);
-	atomic_set(&qm->status.flags, QM_STOP);
 
 err_unlock:
 	up_write(&qm->qps_lock);
@@ -5350,7 +5253,6 @@ int hisi_qm_init(struct hisi_qm *qm)
 		goto err_free_qm_memory;
 
 	qm_cmd_init(qm);
-	atomic_set(&qm->status.flags, QM_INIT);
 
 	return 0;
 
diff --git a/drivers/crypto/hisilicon/qm_common.h b/drivers/crypto/hisilicon/qm_common.h
index 7b0b15c83ec1..0760bf55f13e 100644
--- a/drivers/crypto/hisilicon/qm_common.h
+++ b/drivers/crypto/hisilicon/qm_common.h
@@ -72,10 +72,6 @@ struct qm_aeqc {
 	__le32 dw6;
 };
 
-static const char * const qm_s[] = {
-	"init", "start", "close", "stop",
-};
-
 int qm_set_and_get_xqc(struct hisi_qm *qm, u8 cmd, void *xqc, u32 qp_id, bool op);
 void hisi_qm_show_last_dfx_regs(struct hisi_qm *qm);
 void hisi_qm_set_algqos_init(struct hisi_qm *qm);
diff --git a/include/linux/hisi_acc_qm.h b/include/linux/hisi_acc_qm.h
index ddc7ebb70523..e3c0a1297b2c 100644
--- a/include/linux/hisi_acc_qm.h
+++ b/include/linux/hisi_acc_qm.h
@@ -108,17 +108,13 @@ enum qm_stop_reason {
 };
 
 enum qm_state {
-	QM_INIT = 0,
-	QM_START,
-	QM_CLOSE,
+	QM_WORK = 0,
 	QM_STOP,
 };
 
 enum qp_state {
-	QP_INIT = 1,
-	QP_START,
+	QP_START = 1,
 	QP_STOP,
-	QP_CLOSE,
 };
 
 enum qm_hw_ver {
-- 
2.33.0

