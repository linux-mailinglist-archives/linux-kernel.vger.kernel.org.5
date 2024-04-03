Return-Path: <linux-kernel+bounces-129499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F32896BA2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 133B21C2696D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C592F13DDC7;
	Wed,  3 Apr 2024 10:05:55 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE8513666C;
	Wed,  3 Apr 2024 10:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712138755; cv=none; b=q749H9rnIGQClnA9djefcE2umHrZZsW0styM1G1An0gtWPdx12P94yU8/1C46AY3smY5q0Ub2A4oXxxeQe1gvDrvDe2guUfH+bJeYXrcL/kuPeDlrBBVFP/Jpo2NeDFtArxwaQPRbOXxzd/MXcW6joRsxY+9bOqT2GQrfPbLWTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712138755; c=relaxed/simple;
	bh=6juDJaoMe0wdCGTDP0uluhcWqVlklCQTZZ0GR81b9kU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uv2Cfwzu/TvUmws6aQC1/IevLgCZSyxTF8uUaPWQGumQp6kq9vz/290Gqm0u8tUaaVfpKZYydwNsFRYYUoQsv4etFbMJCaLxWeztchABJhqjYFYWI/t8512SXy4kgc+Ii4b6IH/DmE9KKhbmVYscC2IcfPNrUDjeTiAH971Treo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4V8gKM1lP5zXkcR;
	Wed,  3 Apr 2024 18:02:31 +0800 (CST)
Received: from dggpemd200003.china.huawei.com (unknown [7.185.36.122])
	by mail.maildlp.com (Postfix) with ESMTPS id DA9B6140F81;
	Wed,  3 Apr 2024 18:05:28 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 dggpemd200003.china.huawei.com (7.185.36.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 3 Apr 2024 18:05:28 +0800
From: Chenghai Huang <huangchenghai2@huawei.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<fanghao11@huawei.com>, <liulongfang@huawei.com>, <shenyang39@huawei.com>,
	<songzhiqi1@huawei.com>, <qianweili@huawei.com>, <liushangbin@hisilicon.com>,
	<linwenkai6@hisilicon.com>, <taoqi10@huawei.com>, <wangzhou1@hisilicon.com>,
	<huangchenghai2@huawei.com>
Subject: [PATCH 8/9] crypto: hisilicon/debugfs - Resolve the problem of applying for redundant space in sq dump
Date: Wed, 3 Apr 2024 18:01:01 +0800
Message-ID: <20240403100102.2735306-9-huangchenghai2@huawei.com>
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

When dumping SQ, only the corresponding ID's SQE needs to be
dumped, and there is no need to apply for the entire SQE
memory. This is because excessive dump operations can lead to
memory resource waste.

Therefor apply for the space corresponding to sqe_id separately
to avoid space waste.

Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
---
 drivers/crypto/hisilicon/debugfs.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/hisilicon/debugfs.c b/drivers/crypto/hisilicon/debugfs.c
index e9fa42381242..8e259ed4aecd 100644
--- a/drivers/crypto/hisilicon/debugfs.c
+++ b/drivers/crypto/hisilicon/debugfs.c
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


