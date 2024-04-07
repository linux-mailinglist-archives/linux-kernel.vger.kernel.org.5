Return-Path: <linux-kernel+bounces-134235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1DF89AF5A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F275282051
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C19D12B7F;
	Sun,  7 Apr 2024 08:04:35 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90701101EC;
	Sun,  7 Apr 2024 08:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712477074; cv=none; b=HOL7uaWpTS6Wr5EYe8yBikoBTXbxDry2kGA+QENGPLSaXDiF5qADtKpiMiY9IXZmzcahHtNBr4xyK61MAyVuZZo+nmrZjDvb4eP5iGzzlqXwDtUnK5iOfQq7BtKRz3TfXNwCejp9dWI54dTGXQCcpab137E+86xbGRf0TKsveSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712477074; c=relaxed/simple;
	bh=IWmag/TML6Tv6Hu6G9U6MPtnz9M6+9Xlreue3sMUpMQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TNF9yxWIJ8NXqGWgulOi9MWbNozzhN6sAyIC57wFYJhRjHvs0mGZVuNSJqDDwLu4W323Ru0vn537A8LIs56OOTA/pqAiuBMsinGmh+cM/ziKcBeT/J2OlYDqAglQqbYicdHc8d3RceYbZ82k4v2CVE2hwJNhqjO1hOcRvPJjBow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VC4VF50J3zbfPh;
	Sun,  7 Apr 2024 16:03:33 +0800 (CST)
Received: from kwepemi500025.china.huawei.com (unknown [7.221.188.170])
	by mail.maildlp.com (Postfix) with ESMTPS id 71D4C140154;
	Sun,  7 Apr 2024 16:04:30 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500025.china.huawei.com (7.221.188.170) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Apr 2024 16:04:29 +0800
From: Chenghai Huang <huangchenghai2@huawei.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<fanghao11@huawei.com>, <liulongfang@huawei.com>, <shenyang39@huawei.com>,
	<songzhiqi1@huawei.com>, <qianweili@huawei.com>, <liushangbin@hisilicon.com>,
	<linwenkai6@hisilicon.com>, <taoqi10@huawei.com>, <wangzhou1@hisilicon.com>,
	<huangchenghai2@huawei.com>
Subject: [PATCH v2 3/9] crypto: hisilicon/sgl - Delete redundant parameter verification
Date: Sun, 7 Apr 2024 15:59:54 +0800
Message-ID: <20240407080000.673435-4-huangchenghai2@huawei.com>
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

The input parameter check in acc_get_sgl is redundant. The
caller has been verified once. When the check is performed for
multiple times, the performance deteriorates.

So the redundant parameter verification is deleted, and the
index verification is changed to the module entry function for
verification.

Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
---
 drivers/crypto/hisilicon/sgl.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/crypto/hisilicon/sgl.c b/drivers/crypto/hisilicon/sgl.c
index 0beca257c20b..568acd0aee3f 100644
--- a/drivers/crypto/hisilicon/sgl.c
+++ b/drivers/crypto/hisilicon/sgl.c
@@ -161,9 +161,6 @@ static struct hisi_acc_hw_sgl *acc_get_sgl(struct hisi_acc_sgl_pool *pool,
 	struct mem_block *block;
 	u32 block_index, offset;
 
-	if (!pool || !hw_sgl_dma || index >= pool->count)
-		return ERR_PTR(-EINVAL);
-
 	block = pool->mem_block;
 	block_index = index / pool->sgl_num_per_block;
 	offset = index % pool->sgl_num_per_block;
@@ -230,7 +227,7 @@ hisi_acc_sg_buf_map_to_hw_sgl(struct device *dev,
 	struct scatterlist *sg;
 	int sg_n;
 
-	if (!dev || !sgl || !pool || !hw_sgl_dma)
+	if (!dev || !sgl || !pool || !hw_sgl_dma || index >= pool->count)
 		return ERR_PTR(-EINVAL);
 
 	sg_n = sg_nents(sgl);
-- 
2.30.0


