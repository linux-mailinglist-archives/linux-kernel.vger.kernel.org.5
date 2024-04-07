Return-Path: <linux-kernel+bounces-134240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E95BC89AF64
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A54CE282878
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3830A25619;
	Sun,  7 Apr 2024 08:04:38 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CD41773D;
	Sun,  7 Apr 2024 08:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712477077; cv=none; b=eLe/eDNlGW7jutYziiISXDHLohp8sV6z9dwAV8Yr6veMeUGW1BKmJeqzairN5NBTBmL6Jnge3FgFh7Srv8uOe2Eu8sbGqcwXKFMyvYcdsRtC6ek5JheGoOY1qL+hUtyzoSOj1W8Q8aZIcV3vtmip+zw5QMKbFosyrTKW7hv53V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712477077; c=relaxed/simple;
	bh=dvbfpA6FOFOiowMEUJ7Jq5GAffLnt23ziTlRQGWW3Zk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q5POU230F6riUtX/4V+azMh/cPqb+nfzS3apErtnD//qpoBuzfDDSL2LF3z3a3gsjYq+bEUSbrtg7BMgPI8hF3GS1z/qkR4PwpWe1RT+N6ILytp7aSEO9CHx/tKJG/R7FTgaPFSYblLrWEjGidWqzFhc7tsGsGE5k0u3aWTpkkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VC4S82H8Gz29dNV;
	Sun,  7 Apr 2024 16:01:44 +0800 (CST)
Received: from kwepemi500025.china.huawei.com (unknown [7.221.188.170])
	by mail.maildlp.com (Postfix) with ESMTPS id 761911A0172;
	Sun,  7 Apr 2024 16:04:33 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500025.china.huawei.com (7.221.188.170) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Apr 2024 16:04:32 +0800
From: Chenghai Huang <huangchenghai2@huawei.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<fanghao11@huawei.com>, <liulongfang@huawei.com>, <shenyang39@huawei.com>,
	<songzhiqi1@huawei.com>, <qianweili@huawei.com>, <liushangbin@hisilicon.com>,
	<linwenkai6@hisilicon.com>, <taoqi10@huawei.com>, <wangzhou1@hisilicon.com>,
	<huangchenghai2@huawei.com>
Subject: [PATCH v2 8/9] crypto: hisilicon/debugfs - Resolve the problem of applying for redundant space in sq dump
Date: Sun, 7 Apr 2024 15:59:59 +0800
Message-ID: <20240407080000.673435-9-huangchenghai2@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240407080000.673435-1-huangchenghai2@huawei.com>
References: <20240407080000.673435-1-huangchenghai2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500025.china.huawei.com (7.221.188.170)

When dumping SQ, only the corresponding ID's SQE needs to be
dumped, and there is no need to apply for the entire SQE
memory. This is because excessive dump operations can lead to
memory resource waste.

Therefor apply for the space corresponding to sqe_id separately
to avoid space waste.

Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
---
v1 -> v2
- fixed codecheck warnings about unused variable
  | Reported-by: kernel test robot <lkp@intel.com>
  | Closes: https://lore.kernel.org/oe-kbuild-all/202404040616.cF0Pvb9M-lkp@intel.com/
---
 drivers/crypto/hisilicon/debugfs.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/hisilicon/debugfs.c b/drivers/crypto/hisilicon/debugfs.c
index e9fa42381242..8e7dfdc5b989 100644
--- a/drivers/crypto/hisilicon/debugfs.c
+++ b/drivers/crypto/hisilicon/debugfs.c
@@ -311,7 +311,7 @@ static int q_dump_param_parse(struct hisi_qm *qm, char *s,
 static int qm_sq_dump(struct hisi_qm *qm, char *s, char *name)
 {
 	u16 sq_depth = qm->qp_array->cq_depth;
-	void *sqe, *sqe_curr;
+	void *sqe;
 	struct hisi_qp *qp;
 	u32 qp_id, sqe_id;
 	int ret;
@@ -320,17 +320,16 @@ static int qm_sq_dump(struct hisi_qm *qm, char *s, char *name)
 	if (ret)
 		return ret;
 
-	sqe = kzalloc(qm->sqe_size * sq_depth, GFP_KERNEL);
+	sqe = kzalloc(qm->sqe_size, GFP_KERNEL);
 	if (!sqe)
 		return -ENOMEM;
 
 	qp = &qm->qp_array[qp_id];
-	memcpy(sqe, qp->sqe, qm->sqe_size * sq_depth);
-	sqe_curr = sqe + (u32)(sqe_id * qm->sqe_size);
-	memset(sqe_curr + qm->debug.sqe_mask_offset, QM_SQE_ADDR_MASK,
+	memcpy(sqe, qp->sqe + sqe_id * qm->sqe_size, qm->sqe_size);
+	memset(sqe + qm->debug.sqe_mask_offset, QM_SQE_ADDR_MASK,
 	       qm->debug.sqe_mask_len);
 
-	dump_show(qm, sqe_curr, qm->sqe_size, name);
+	dump_show(qm, sqe, qm->sqe_size, name);
 
 	kfree(sqe);
 
-- 
2.30.0


