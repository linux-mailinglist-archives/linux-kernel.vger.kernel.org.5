Return-Path: <linux-kernel+bounces-134236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 787CE89AF5D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19C2E1F21D39
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC251D558;
	Sun,  7 Apr 2024 08:04:36 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487741097B;
	Sun,  7 Apr 2024 08:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712477076; cv=none; b=pz1R4LOFQdWfcVWNwLzTiO50qNMfhpE4O8Bh1FQLP1RG9p85O6FWrz/UYaTaao33Q4JE1rpU0QI8J3w6e2CGdJbyq7bgXxVZ691Wm3+IyrAzVcp5uYqbnCgqsmtqKGRGL6uDxynPP+mUoUl5PgCCFYKAXLfH3wSie/9SkUGCmyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712477076; c=relaxed/simple;
	bh=MGF1c7hP756vbZB6s7mhJ9xaU9LW9VFYD7JABjDB6bQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IuuVB3kfFi4dfikBIjXODfkKSMqemNEWyuYvKt/ak1IWkRwioV/GxU/1GCBQmfh/6ioz05s3r+TLCDTfgi9YZamVOfDjWG2kcCzBler/ZwNIiklqOlhNiQgPUPvR65NscLl1IU9lQvSr3d+8caMNKh/N8KWwJyzhM/gRKFsXTik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VC4S654NFz1h4Kl;
	Sun,  7 Apr 2024 16:01:42 +0800 (CST)
Received: from kwepemi500025.china.huawei.com (unknown [7.221.188.170])
	by mail.maildlp.com (Postfix) with ESMTPS id A71191A016C;
	Sun,  7 Apr 2024 16:04:31 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500025.china.huawei.com (7.221.188.170) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Apr 2024 16:04:30 +0800
From: Chenghai Huang <huangchenghai2@huawei.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<fanghao11@huawei.com>, <liulongfang@huawei.com>, <shenyang39@huawei.com>,
	<songzhiqi1@huawei.com>, <qianweili@huawei.com>, <liushangbin@hisilicon.com>,
	<linwenkai6@hisilicon.com>, <taoqi10@huawei.com>, <wangzhou1@hisilicon.com>,
	<huangchenghai2@huawei.com>
Subject: [PATCH v2 5/9] crypto: hisilicon/qm - Add the default processing branch
Date: Sun, 7 Apr 2024 15:59:56 +0800
Message-ID: <20240407080000.673435-6-huangchenghai2@huawei.com>
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

The cmd type can be extended. Currently, only four types of cmd
can be processed. Therefor, add the default processing branch
to intercept incorrect parameter input.

Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 92f0a1d9b4a6..cedb3af1fc1a 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -645,6 +645,9 @@ int qm_set_and_get_xqc(struct hisi_qm *qm, u8 cmd, void *xqc, u32 qp_id, bool op
 		tmp_xqc = qm->xqc_buf.aeqc;
 		xqc_dma = qm->xqc_buf.aeqc_dma;
 		break;
+	default:
+		dev_err(&qm->pdev->dev, "unknown mailbox cmd %u\n", cmd);
+		return -EINVAL;
 	}
 
 	/* Setting xqc will fail if master OOO is blocked. */
-- 
2.30.0


