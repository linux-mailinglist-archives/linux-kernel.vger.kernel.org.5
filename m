Return-Path: <linux-kernel+bounces-134242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F99A89AF68
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F5FAB224AC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FF510A22;
	Sun,  7 Apr 2024 08:04:45 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882472D607;
	Sun,  7 Apr 2024 08:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712477085; cv=none; b=RlZ6cYRp49H/dncuhWN2nuiApW4foPukQEtgt4q+qE/gkwnpzcYBr83DzkVunNGPhziIcjsVnErxxwu4LGz2VclOYlAgQ1EY8ndaeP5bgaSm9oknBCxGh56enfIRlJEVqzIeiiGN7/ceWQfOK3CbhtX9JGvyCPg0OlmQgFAC38s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712477085; c=relaxed/simple;
	bh=CdhX2Ap1YEFlm/vZA7QzJ/ST39fvUSFJOa1MFzbeuBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QIPJzHrKq/5lBppGwDB4kD2PYvYpezabyGCe+UAs0ohhodR/6yR6IVWCgx18HnMHiBgJFJVo6tk2+2B9O2XX+uGNIEEr24pPgLp8KdpewCZdw1ZVlzKq50D34WY8LtO9R/hk7fVvo7ssLv4Y7MWIoj23Q2W4MkGACGwsH7aAxpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VC4SK3N5GztRtx;
	Sun,  7 Apr 2024 16:01:53 +0800 (CST)
Received: from kwepemi500025.china.huawei.com (unknown [7.221.188.170])
	by mail.maildlp.com (Postfix) with ESMTPS id D586A14010C;
	Sun,  7 Apr 2024 16:04:32 +0800 (CST)
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
Subject: [PATCH v2 7/9] crypto: hisilicon/sec - Fix memory leak for sec resource release
Date: Sun, 7 Apr 2024 15:59:58 +0800
Message-ID: <20240407080000.673435-8-huangchenghai2@huawei.com>
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

The AIV is one of the SEC resources. When releasing resources,
it need to release the AIV resources at the same time.
Otherwise, memory leakage occurs.

The aiv resource release is added to the sec resource release
function.

Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index 93a972fcbf63..0558f98e221f 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -481,8 +481,10 @@ static void sec_alg_resource_free(struct sec_ctx *ctx,
 
 	if (ctx->pbuf_supported)
 		sec_free_pbuf_resource(dev, qp_ctx->res);
-	if (ctx->alg_type == SEC_AEAD)
+	if (ctx->alg_type == SEC_AEAD) {
 		sec_free_mac_resource(dev, qp_ctx->res);
+		sec_free_aiv_resource(dev, qp_ctx->res);
+	}
 }
 
 static int sec_alloc_qp_ctx_resource(struct sec_ctx *ctx, struct sec_qp_ctx *qp_ctx)
-- 
2.30.0


