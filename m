Return-Path: <linux-kernel+bounces-24591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2AF82BE96
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 11:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22CB528981B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322075FF0A;
	Fri, 12 Jan 2024 10:26:34 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3360B42057;
	Fri, 12 Jan 2024 10:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TBHj30Mfqz29dNY;
	Fri, 12 Jan 2024 18:24:55 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (unknown [7.193.23.164])
	by mail.maildlp.com (Postfix) with ESMTPS id BB9B41A0172;
	Fri, 12 Jan 2024 18:26:28 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Jan 2024 18:26:28 +0800
From: Weili Qian <qianweili@huawei.com>
To: <herbert@gondor.apana.org.au>
CC: <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liulongfang@huawei.com>, Weili Qian <qianweili@huawei.com>
Subject: [PATCH 1/2] crypto: hisilicon/qm - support get device state
Date: Fri, 12 Jan 2024 18:25:45 +0800
Message-ID: <20240112102546.2213-2-qianweili@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240112102546.2213-1-qianweili@huawei.com>
References: <20240112102546.2213-1-qianweili@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)

Support get device current state. The value 0 indicates that
the device is busy, and the value 1 indicates that the
device is idle. When the device is in suspended, 1 is returned.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 Documentation/ABI/testing/debugfs-hisi-hpre |  7 +++++
 Documentation/ABI/testing/debugfs-hisi-sec  |  7 +++++
 Documentation/ABI/testing/debugfs-hisi-zip  |  7 +++++
 drivers/crypto/hisilicon/debugfs.c          | 29 +++++++++++++++++++++
 4 files changed, 50 insertions(+)

diff --git a/Documentation/ABI/testing/debugfs-hisi-hpre b/Documentation/ABI/testing/debugfs-hisi-hpre
index 8e8de49c5cc6..6ed9258605c7 100644
--- a/Documentation/ABI/testing/debugfs-hisi-hpre
+++ b/Documentation/ABI/testing/debugfs-hisi-hpre
@@ -111,6 +111,13 @@ Description:	QM debug registers(regs) read hardware register value. This
 		node is used to show the change of the qm register values. This
 		node can be help users to check the change of register values.
 
+What:		/sys/kernel/debug/hisi_hpre/<bdf>/qm/qm_state
+Date:		Jan 2024
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump the state of the device.
+		0: busy, 1: idle.
+		Only available for PF, and take no other effect on HPRE.
+
 What:		/sys/kernel/debug/hisi_hpre/<bdf>/hpre_dfx/diff_regs
 Date:		Mar 2022
 Contact:	linux-crypto@vger.kernel.org
diff --git a/Documentation/ABI/testing/debugfs-hisi-sec b/Documentation/ABI/testing/debugfs-hisi-sec
index deeefe2c735e..403f5de96318 100644
--- a/Documentation/ABI/testing/debugfs-hisi-sec
+++ b/Documentation/ABI/testing/debugfs-hisi-sec
@@ -91,6 +91,13 @@ Description:	QM debug registers(regs) read hardware register value. This
 		node is used to show the change of the qm register values. This
 		node can be help users to check the change of register values.
 
+What:		/sys/kernel/debug/hisi_sec2/<bdf>/qm/qm_state
+Date:		Jan 2024
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump the state of the device.
+		0: busy, 1: idle.
+		Only available for PF, and take no other effect on SEC.
+
 What:		/sys/kernel/debug/hisi_sec2/<bdf>/sec_dfx/diff_regs
 Date:		Mar 2022
 Contact:	linux-crypto@vger.kernel.org
diff --git a/Documentation/ABI/testing/debugfs-hisi-zip b/Documentation/ABI/testing/debugfs-hisi-zip
index 593714afaed2..2394e6a3cfe2 100644
--- a/Documentation/ABI/testing/debugfs-hisi-zip
+++ b/Documentation/ABI/testing/debugfs-hisi-zip
@@ -104,6 +104,13 @@ Description:	QM debug registers(regs) read hardware register value. This
 		node is used to show the change of the qm registers value. This
 		node can be help users to check the change of register values.
 
+What:		/sys/kernel/debug/hisi_zip/<bdf>/qm/qm_state
+Date:		Jan 2024
+Contact:	linux-crypto@vger.kernel.org
+Description:	Dump the state of the device.
+		0: busy, 1: idle.
+		Only available for PF, and take no other effect on ZIP.
+
 What:		/sys/kernel/debug/hisi_zip/<bdf>/zip_dfx/diff_regs
 Date:		Mar 2022
 Contact:	linux-crypto@vger.kernel.org
diff --git a/drivers/crypto/hisilicon/debugfs.c b/drivers/crypto/hisilicon/debugfs.c
index 80ed4b2d209c..615c8e18d8b0 100644
--- a/drivers/crypto/hisilicon/debugfs.c
+++ b/drivers/crypto/hisilicon/debugfs.c
@@ -24,6 +24,8 @@
 #define QM_DFX_QN_SHIFT			16
 #define QM_DFX_CNT_CLR_CE		0x100118
 #define QM_DBG_WRITE_LEN		1024
+#define QM_IN_IDLE_ST_REG		0x1040e4
+#define QM_IN_IDLE_STATE		0x1
 
 static const char * const qm_debug_file_name[] = {
 	[CURRENT_QM]   = "current_qm",
@@ -1001,6 +1003,30 @@ static int qm_diff_regs_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(qm_diff_regs);
 
+static int qm_state_show(struct seq_file *s, void *unused)
+{
+	struct hisi_qm *qm = s->private;
+	u32 val;
+	int ret;
+
+	/* If device is in suspended, directly return the idle state. */
+	ret = hisi_qm_get_dfx_access(qm);
+	if (!ret) {
+		val = readl(qm->io_base + QM_IN_IDLE_ST_REG);
+		hisi_qm_put_dfx_access(qm);
+	} else if (ret == -EAGAIN) {
+		val = QM_IN_IDLE_STATE;
+	} else {
+		return ret;
+	}
+
+	seq_printf(s, "%u\n", val);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(qm_state);
+
 static ssize_t qm_status_read(struct file *filp, char __user *buffer,
 			      size_t count, loff_t *pos)
 {
@@ -1072,6 +1098,9 @@ void hisi_qm_debug_init(struct hisi_qm *qm)
 
 	/* only show this in PF */
 	if (qm->fun_type == QM_HW_PF) {
+		debugfs_create_file("qm_state", 0444, qm->debug.qm_d,
+					qm, &qm_state_fops);
+
 		qm_create_debugfs_file(qm, qm->debug.debug_root, CURRENT_QM);
 		for (i = CURRENT_Q; i < DEBUG_FILE_NUM; i++)
 			qm_create_debugfs_file(qm, qm->debug.qm_d, i);
-- 
2.33.0


