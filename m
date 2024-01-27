Return-Path: <linux-kernel+bounces-41193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE9683ED38
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 14:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AAB2282E3B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 13:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95380286B2;
	Sat, 27 Jan 2024 13:16:19 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF5125576;
	Sat, 27 Jan 2024 13:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706361379; cv=none; b=CGS7O/CJV7f7jl+O0m6PT/PVQoLw44bqcmHgM6O0zCWilpI4wG/gcvx+5vfvBtutQtiEL/CBR392bqJSSKTV5NeSc0Z3yRFjuwDqp9OFCBTu+CJLFtMP0La5nvocFp+b70/x+qnon/tgkRlvlmJVaUTnwzBtgHmXApz8wt4c6rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706361379; c=relaxed/simple;
	bh=adMdrd33BWAncTlu9FqQSrWBDalVJlLFUuqtc5QT7uo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rCpzS5eX8dQfVdnAQCdmr/ySzHdXC2McepcHiqXI3F9s0tEOTIFsjt9BbcQixSOVwXpQHtpbBN4oTAJL31YxiuQ4M1li9sUP2TG6SJPdWsAkfgcs1ni9pzUB3XZbfx3wvU4biXJYeS77FaVMvckdDN0wYSdguyAPrMhCgqrJtLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4TMZmh5VRzzNlX3;
	Sat, 27 Jan 2024 21:15:16 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (unknown [7.193.23.164])
	by mail.maildlp.com (Postfix) with ESMTPS id ED18518001C;
	Sat, 27 Jan 2024 21:16:12 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 27 Jan 2024 21:16:12 +0800
From: Weili Qian <qianweili@huawei.com>
To: <herbert@gondor.apana.org.au>
CC: <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liulongfang@huawei.com>
Subject: [PATCH 1/3] crypto: hisilicon/qm - add stop function by hardware
Date: Sat, 27 Jan 2024 21:15:28 +0800
Message-ID: <20240127131530.64617-2-qianweili@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240127131530.64617-1-qianweili@huawei.com>
References: <20240127131530.64617-1-qianweili@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)

Hardware V3 could be able to drain function by sending mailbox
to hardware which will trigger tasks in device to be flushed out.
When the function is reset, the function can be stopped by this way.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 40 ++++++++++++++++++++++++++++-------
 include/linux/hisi_acc_qm.h   |  2 ++
 2 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 4b20b94e6371..3b015482b4e6 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -312,6 +312,7 @@ static const struct hisi_qm_cap_info qm_cap_info_comm[] = {
 	{QM_SUPPORT_DB_ISOLATION, 0x30,   0, BIT(0),  0x0, 0x0, 0x0},
 	{QM_SUPPORT_FUNC_QOS,     0x3100, 0, BIT(8),  0x0, 0x0, 0x1},
 	{QM_SUPPORT_STOP_QP,      0x3100, 0, BIT(9),  0x0, 0x0, 0x1},
+	{QM_SUPPORT_STOP_FUNC,     0x3100, 0, BIT(10), 0x0, 0x0, 0x1},
 	{QM_SUPPORT_MB_COMMAND,   0x3100, 0, BIT(11), 0x0, 0x0, 0x1},
 	{QM_SUPPORT_SVA_PREFETCH, 0x3100, 0, BIT(14), 0x0, 0x0, 0x1},
 };
@@ -1674,6 +1675,11 @@ static int qm_ping_pf(struct hisi_qm *qm, u64 cmd)
 	return ret;
 }
 
+static int qm_drain_qm(struct hisi_qm *qm)
+{
+	return hisi_qm_mb(qm, QM_MB_CMD_FLUSH_QM, 0, 0, 0);
+}
+
 static int qm_stop_qp(struct hisi_qp *qp)
 {
 	return hisi_qm_mb(qp->qm, QM_MB_CMD_STOP_QP, 0, qp->qp_id, 0);
@@ -2088,7 +2094,8 @@ static int qm_drain_qp(struct hisi_qp *qp)
 
 static int qm_stop_qp_nolock(struct hisi_qp *qp)
 {
-	struct device *dev = &qp->qm->pdev->dev;
+	struct hisi_qm *qm = qp->qm;
+	struct device *dev = &qm->pdev->dev;
 	int ret;
 
 	/*
@@ -2104,11 +2111,14 @@ static int qm_stop_qp_nolock(struct hisi_qp *qp)
 
 	atomic_set(&qp->qp_status.flags, QP_STOP);
 
-	ret = qm_drain_qp(qp);
-	if (ret)
-		dev_err(dev, "Failed to drain out data for stopping!\n");
+	/* V3 supports direct stop function when FLR prepare */
+	if (qm->ver < QM_HW_V3 || qm->status.stop_reason == QM_NORMAL) {
+		ret = qm_drain_qp(qp);
+		if (ret)
+			dev_err(dev, "Failed to drain out data for stopping qp(%u)!\n", qp->qp_id);
+	}
 
-	flush_workqueue(qp->qm->wq);
+	flush_workqueue(qm->wq);
 	if (unlikely(qp->is_resetting && atomic_read(&qp->qp_status.used)))
 		qp_stop_fail_cb(qp);
 
@@ -3112,16 +3122,29 @@ int hisi_qm_stop(struct hisi_qm *qm, enum qm_stop_reason r)
 
 	down_write(&qm->qps_lock);
 
-	qm->status.stop_reason = r;
 	if (atomic_read(&qm->status.flags) == QM_STOP)
 		goto err_unlock;
 
 	/* Stop all the request sending at first. */
 	atomic_set(&qm->status.flags, QM_STOP);
+	qm->status.stop_reason = r;
 
-	if (qm->status.stop_reason == QM_SOFT_RESET ||
-	    qm->status.stop_reason == QM_DOWN) {
+	if (qm->status.stop_reason != QM_NORMAL) {
 		hisi_qm_set_hw_reset(qm, QM_RESET_STOP_TX_OFFSET);
+		/*
+		 * When performing soft reset, the hardware will no longer
+		 * do tasks, and the tasks in the device will be flushed
+		 * out directly since the master ooo is closed.
+		 */
+		if (test_bit(QM_SUPPORT_STOP_FUNC, &qm->caps) &&
+		    r != QM_SOFT_RESET) {
+			ret = qm_drain_qm(qm);
+			if (ret) {
+				dev_err(dev, "failed to drain qm!\n");
+				goto err_unlock;
+			}
+		}
+
 		ret = qm_stop_started_qp(qm);
 		if (ret < 0) {
 			dev_err(dev, "Failed to stop started qp!\n");
@@ -3141,6 +3164,7 @@ int hisi_qm_stop(struct hisi_qm *qm, enum qm_stop_reason r)
 	}
 
 	qm_clear_queues(qm);
+	qm->status.stop_reason = QM_NORMAL;
 
 err_unlock:
 	up_write(&qm->qps_lock);
diff --git a/include/linux/hisi_acc_qm.h b/include/linux/hisi_acc_qm.h
index 5f4c74facf6a..720f10874a66 100644
--- a/include/linux/hisi_acc_qm.h
+++ b/include/linux/hisi_acc_qm.h
@@ -43,6 +43,7 @@
 #define QM_MB_CMD_CQC_BT                0x5
 #define QM_MB_CMD_SQC_VFT_V2            0x6
 #define QM_MB_CMD_STOP_QP               0x8
+#define QM_MB_CMD_FLUSH_QM		0x9
 #define QM_MB_CMD_SRC                   0xc
 #define QM_MB_CMD_DST                   0xd
 
@@ -151,6 +152,7 @@ enum qm_cap_bits {
 	QM_SUPPORT_DB_ISOLATION = 0x0,
 	QM_SUPPORT_FUNC_QOS,
 	QM_SUPPORT_STOP_QP,
+	QM_SUPPORT_STOP_FUNC,
 	QM_SUPPORT_MB_COMMAND,
 	QM_SUPPORT_SVA_PREFETCH,
 	QM_SUPPORT_RPM,
-- 
2.33.0


