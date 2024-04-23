Return-Path: <linux-kernel+bounces-154388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E218ADB82
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B410B21F38
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A09FF9D4;
	Tue, 23 Apr 2024 01:24:05 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1D212B82;
	Tue, 23 Apr 2024 01:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713835445; cv=none; b=ssKPiH1Mq8fycmQZ4/E0zRp313GvOwAbt4YkBH9B5rYQ1aXlepyr7xPDQw/DzzJApVJ40PrN7F4my5nMsB3xLKIRp8XTzh243zdSwLXiKTB+8jPkQhhwjZ19U8kAJ86mF+BzkrzDzdysfcPmlI5JyU8HrIFwRmFhPs88epj0v0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713835445; c=relaxed/simple;
	bh=EPeQVeK7bGlQ7W4VlNc6Sf1jdRM/ppfdISOYr2PyEe8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uz5OtgBlC7SMwjPP5A0f+O09j8tFDzdvdCDPZreTaadUbeWQMvSfxewJYIjWDXM4bOXB3v6WsUotKNmvTvUu82KoqwGGkpd3B6H7sQ7OtdDmLSMEkFhb+jkA8+8jIPtMF0IuiO+yfd42IeLxNHB5p6MN3RDXObp6d60naNkc5SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4VNkpH1vYTz1RCjh;
	Tue, 23 Apr 2024 09:20:55 +0800 (CST)
Received: from kwepemi500025.china.huawei.com (unknown [7.221.188.170])
	by mail.maildlp.com (Postfix) with ESMTPS id 9458F14011F;
	Tue, 23 Apr 2024 09:23:58 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500025.china.huawei.com (7.221.188.170) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 09:23:57 +0800
From: Chenghai Huang <huangchenghai2@huawei.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<fanghao11@huawei.com>, <liulongfang@huawei.com>, <shenyang39@huawei.com>,
	<songzhiqi1@huawei.com>, <qianweili@huawei.com>, <liushangbin@hisilicon.com>,
	<linwenkai6@hisilicon.com>, <taoqi10@huawei.com>, <wangzhou1@hisilicon.com>,
	<huangchenghai2@huawei.com>
Subject: [PATCH 1/2] crypto: hisilicon/debugfs - mask the unnecessary info from the dump
Date: Tue, 23 Apr 2024 09:19:21 +0800
Message-ID: <20240423011922.770693-2-huangchenghai2@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240423011922.770693-1-huangchenghai2@huawei.com>
References: <20240423011922.770693-1-huangchenghai2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500025.china.huawei.com (7.221.188.170)

Some information showed by the dump function is invalid. Mask
the unnecessary information from the dump file.

Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
---
 drivers/crypto/hisilicon/debugfs.c        | 29 +++++++++++++++--------
 drivers/crypto/hisilicon/hpre/hpre_main.c |  2 +-
 drivers/crypto/hisilicon/sec2/sec_main.c  |  4 ++--
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/crypto/hisilicon/debugfs.c b/drivers/crypto/hisilicon/debugfs.c
index 8e7dfdc5b989..1b9b7bccdeff 100644
--- a/drivers/crypto/hisilicon/debugfs.c
+++ b/drivers/crypto/hisilicon/debugfs.c
@@ -13,6 +13,7 @@
 #define QM_DFX_COMMON_LEN		0xC3
 #define QM_DFX_REGS_LEN			4UL
 #define QM_DBG_TMP_BUF_LEN		22
+#define QM_XQC_ADDR_MASK		GENMASK(31, 0)
 #define CURRENT_FUN_MASK		GENMASK(5, 0)
 #define CURRENT_Q_MASK			GENMASK(31, 16)
 #define QM_SQE_ADDR_MASK		GENMASK(7, 0)
@@ -167,7 +168,6 @@ static void dump_show(struct hisi_qm *qm, void *info,
 static int qm_sqc_dump(struct hisi_qm *qm, char *s, char *name)
 {
 	struct device *dev = &qm->pdev->dev;
-	struct qm_sqc *sqc_curr;
 	struct qm_sqc sqc;
 	u32 qp_id;
 	int ret;
@@ -183,6 +183,8 @@ static int qm_sqc_dump(struct hisi_qm *qm, char *s, char *name)
 
 	ret = qm_set_and_get_xqc(qm, QM_MB_CMD_SQC, &sqc, qp_id, 1);
 	if (!ret) {
+		sqc.base_h = cpu_to_le32(QM_XQC_ADDR_MASK);
+		sqc.base_l = cpu_to_le32(QM_XQC_ADDR_MASK);
 		dump_show(qm, &sqc, sizeof(struct qm_sqc), name);
 
 		return 0;
@@ -190,9 +192,10 @@ static int qm_sqc_dump(struct hisi_qm *qm, char *s, char *name)
 
 	down_read(&qm->qps_lock);
 	if (qm->sqc) {
-		sqc_curr = qm->sqc + qp_id;
-
-		dump_show(qm, sqc_curr, sizeof(*sqc_curr), "SOFT SQC");
+		memcpy(&sqc, qm->sqc + qp_id * sizeof(struct qm_sqc), sizeof(struct qm_sqc));
+		sqc.base_h = cpu_to_le32(QM_XQC_ADDR_MASK);
+		sqc.base_l = cpu_to_le32(QM_XQC_ADDR_MASK);
+		dump_show(qm, &sqc, sizeof(struct qm_sqc), "SOFT SQC");
 	}
 	up_read(&qm->qps_lock);
 
@@ -202,7 +205,6 @@ static int qm_sqc_dump(struct hisi_qm *qm, char *s, char *name)
 static int qm_cqc_dump(struct hisi_qm *qm, char *s, char *name)
 {
 	struct device *dev = &qm->pdev->dev;
-	struct qm_cqc *cqc_curr;
 	struct qm_cqc cqc;
 	u32 qp_id;
 	int ret;
@@ -218,6 +220,8 @@ static int qm_cqc_dump(struct hisi_qm *qm, char *s, char *name)
 
 	ret = qm_set_and_get_xqc(qm, QM_MB_CMD_CQC, &cqc, qp_id, 1);
 	if (!ret) {
+		cqc.base_h = cpu_to_le32(QM_XQC_ADDR_MASK);
+		cqc.base_l = cpu_to_le32(QM_XQC_ADDR_MASK);
 		dump_show(qm, &cqc, sizeof(struct qm_cqc), name);
 
 		return 0;
@@ -225,9 +229,10 @@ static int qm_cqc_dump(struct hisi_qm *qm, char *s, char *name)
 
 	down_read(&qm->qps_lock);
 	if (qm->cqc) {
-		cqc_curr = qm->cqc + qp_id;
-
-		dump_show(qm, cqc_curr, sizeof(*cqc_curr), "SOFT CQC");
+		memcpy(&cqc, qm->cqc + qp_id * sizeof(struct qm_cqc), sizeof(struct qm_cqc));
+		cqc.base_h = cpu_to_le32(QM_XQC_ADDR_MASK);
+		cqc.base_l = cpu_to_le32(QM_XQC_ADDR_MASK);
+		dump_show(qm, &cqc, sizeof(struct qm_cqc), "SOFT CQC");
 	}
 	up_read(&qm->qps_lock);
 
@@ -263,6 +268,10 @@ static int qm_eqc_aeqc_dump(struct hisi_qm *qm, char *s, char *name)
 	if (ret)
 		return ret;
 
+	aeqc.base_h = cpu_to_le32(QM_XQC_ADDR_MASK);
+	aeqc.base_l = cpu_to_le32(QM_XQC_ADDR_MASK);
+	eqc.base_h = cpu_to_le32(QM_XQC_ADDR_MASK);
+	eqc.base_l = cpu_to_le32(QM_XQC_ADDR_MASK);
 	dump_show(qm, xeqc, size, name);
 
 	return ret;
@@ -310,10 +319,10 @@ static int q_dump_param_parse(struct hisi_qm *qm, char *s,
 
 static int qm_sq_dump(struct hisi_qm *qm, char *s, char *name)
 {
-	u16 sq_depth = qm->qp_array->cq_depth;
-	void *sqe;
+	u16 sq_depth = qm->qp_array->sq_depth;
 	struct hisi_qp *qp;
 	u32 qp_id, sqe_id;
+	void *sqe;
 	int ret;
 
 	ret = q_dump_param_parse(qm, s, &sqe_id, &qp_id, sq_depth);
diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index 25b44416da45..10aa4da93323 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -106,7 +106,7 @@
 #define HPRE_SHAPER_TYPE_RATE		640
 #define HPRE_VIA_MSI_DSM		1
 #define HPRE_SQE_MASK_OFFSET		8
-#define HPRE_SQE_MASK_LEN		24
+#define HPRE_SQE_MASK_LEN		44
 #define HPRE_CTX_Q_NUM_DEF		1
 
 #define HPRE_DFX_BASE		0x301000
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 853b1cb85016..6eba1f22720f 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -99,8 +99,8 @@
 #define SEC_DBGFS_VAL_MAX_LEN		20
 #define SEC_SINGLE_PORT_MAX_TRANS	0x2060
 
-#define SEC_SQE_MASK_OFFSET		64
-#define SEC_SQE_MASK_LEN		48
+#define SEC_SQE_MASK_OFFSET		16
+#define SEC_SQE_MASK_LEN		108
 #define SEC_SHAPER_TYPE_RATE		400
 
 #define SEC_DFX_BASE		0x301000
-- 
2.30.0


