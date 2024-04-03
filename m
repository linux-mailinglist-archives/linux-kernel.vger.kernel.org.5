Return-Path: <linux-kernel+bounces-129491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 621F7896B8F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16ED71F2ADD1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0598113A25E;
	Wed,  3 Apr 2024 10:05:33 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0E5135A58;
	Wed,  3 Apr 2024 10:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712138732; cv=none; b=ox4VF7Au0yMVzjhKnMGcXvh1kjX9P6svaMD1GY4TWa4b8jQyXQAJHZvhWiGrdgTKkO/QQn0VwaWRQPfWN4SF3V9IAgUbcen6s4u6bzEHFLVJYtiHYSlnM+bsFxxAK9uoqeduTrwKXnLeSAiL2fFkEGZ4zkievwHOCcorjZaeN/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712138732; c=relaxed/simple;
	bh=4X7bb0ikerFe5yNJkCqO9owSgxH9ZYXoE8odVRPTh8M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=er/2FgTim2aQ8+rQNXqtLFmtnlgDmf2Fpgp6EH3wJ4zjw222WvHEoq8okXieyGkA3WhnpKTymTzTYgi9HivcSEH5ajTKETrS/AREmFNZUzHC+KRoJCak2QVI3xn2TdSgix/S2Sjf8u2wQCicccQ6N73j4gd+TWNyimmR3ohFDkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4V8gKn4J1qz1Q8qr;
	Wed,  3 Apr 2024 18:02:53 +0800 (CST)
Received: from dggpemd200003.china.huawei.com (unknown [7.185.36.122])
	by mail.maildlp.com (Postfix) with ESMTPS id B9B4318007F;
	Wed,  3 Apr 2024 18:05:27 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 dggpemd200003.china.huawei.com (7.185.36.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 3 Apr 2024 18:05:27 +0800
From: Chenghai Huang <huangchenghai2@huawei.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<fanghao11@huawei.com>, <liulongfang@huawei.com>, <shenyang39@huawei.com>,
	<songzhiqi1@huawei.com>, <qianweili@huawei.com>, <liushangbin@hisilicon.com>,
	<linwenkai6@hisilicon.com>, <taoqi10@huawei.com>, <wangzhou1@hisilicon.com>,
	<huangchenghai2@huawei.com>
Subject: [PATCH 2/9] crypto: hisilicon/debugfs - Fix debugfs uninit process issue
Date: Wed, 3 Apr 2024 18:00:55 +0800
Message-ID: <20240403100102.2735306-3-huangchenghai2@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240403100102.2735306-1-huangchenghai2@huawei.com>
References: <20240403100102.2735306-1-huangchenghai2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemd200003.china.huawei.com (7.185.36.122)

During the zip probe process, the debugfs failure does not stop
the probe. When debugfs initialization fails, jumping to the
error branch will also release regs, in addition to its own
rollback operation.

As a result, it may be released repeatedly during the regs
uninit process. Therefore, the null check needs to be added to
the regs uninit process.

Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
---
 drivers/crypto/hisilicon/debugfs.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/hisilicon/debugfs.c b/drivers/crypto/hisilicon/debugfs.c
index cd67fa348ca7..6351a452878d 100644
--- a/drivers/crypto/hisilicon/debugfs.c
+++ b/drivers/crypto/hisilicon/debugfs.c
@@ -809,8 +809,14 @@ static void dfx_regs_uninit(struct hisi_qm *qm,
 {
 	int i;
 
+	if (!dregs)
+		return;
+
 	/* Setting the pointer is NULL to prevent double free */
 	for (i = 0; i < reg_len; i++) {
+		if (!dregs[i].regs)
+			continue;
+
 		kfree(dregs[i].regs);
 		dregs[i].regs = NULL;
 	}
@@ -860,14 +866,21 @@ static struct dfx_diff_registers *dfx_regs_init(struct hisi_qm *qm,
 static int qm_diff_regs_init(struct hisi_qm *qm,
 		struct dfx_diff_registers *dregs, u32 reg_len)
 {
+	int ret;
+
 	qm->debug.qm_diff_regs = dfx_regs_init(qm, qm_diff_regs, ARRAY_SIZE(qm_diff_regs));
-	if (IS_ERR(qm->debug.qm_diff_regs))
-		return PTR_ERR(qm->debug.qm_diff_regs);
+	if (IS_ERR(qm->debug.qm_diff_regs)) {
+		ret = PTR_ERR(qm->debug.qm_diff_regs);
+		qm->debug.qm_diff_regs = NULL;
+		return ret;
+	}
 
 	qm->debug.acc_diff_regs = dfx_regs_init(qm, dregs, reg_len);
 	if (IS_ERR(qm->debug.acc_diff_regs)) {
 		dfx_regs_uninit(qm, qm->debug.qm_diff_regs, ARRAY_SIZE(qm_diff_regs));
-		return PTR_ERR(qm->debug.acc_diff_regs);
+		ret = PTR_ERR(qm->debug.acc_diff_regs);
+		qm->debug.acc_diff_regs = NULL;
+		return ret;
 	}
 
 	return 0;
@@ -908,7 +921,9 @@ static int qm_last_regs_init(struct hisi_qm *qm)
 static void qm_diff_regs_uninit(struct hisi_qm *qm, u32 reg_len)
 {
 	dfx_regs_uninit(qm, qm->debug.acc_diff_regs, reg_len);
+	qm->debug.acc_diff_regs = NULL;
 	dfx_regs_uninit(qm, qm->debug.qm_diff_regs, ARRAY_SIZE(qm_diff_regs));
+	qm->debug.qm_diff_regs = NULL;
 }
 
 /**
-- 
2.30.0


