Return-Path: <linux-kernel+bounces-39947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEA483D7B5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D62129198A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3106D1C4;
	Fri, 26 Jan 2024 09:39:24 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B52C6BB3F;
	Fri, 26 Jan 2024 09:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706261964; cv=none; b=WY/Awyl8g41wnsjGEjNGj2wbk+1KtdeF9uE8K4Lk2J7mTjfFNGXy6QYtNPl/HrKyfjX4yAY/j2C0vZQ+GNprL5DGpQI0DGPvdp+8eIfDYAqSu1HGORHaR1lQIL47lQ8rc9VnDjuI7tr3ESdlwGBmRKejZjbyLStdfaF6YNFGie0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706261964; c=relaxed/simple;
	bh=hMPu5jhk9dmMRoZn4YMWKRNN1BOGHMTRanhtmEgePWM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V4n8/CyZaymCZD2UxvvM2nOMhnCOQdrl6ci5gwGumRjNYY0n4NwQb4QYq18ZUEuwwYGPn5KjTJ92KE86btlUh6HBSDYMB3OrPnr5Z2NrVGnR+qahqcElMzQwAM2A6Y9SH+ecvvCE75RIdHzXI7dFNs47CEi/TeQGkgBPdHvylV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4TLt0c4kdFz18M85;
	Fri, 26 Jan 2024 17:38:08 +0800 (CST)
Received: from dggpeml500001.china.huawei.com (unknown [7.185.36.227])
	by mail.maildlp.com (Postfix) with ESMTPS id E1547140136;
	Fri, 26 Jan 2024 17:39:13 +0800 (CST)
Received: from huawei.com (10.69.192.56) by dggpeml500001.china.huawei.com
 (7.185.36.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Jan
 2024 17:39:13 +0800
From: Qi Tao <taoqi10@huawei.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<liulongfang@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>
Subject: [PATCH v2 3/4] crypto: hisilicon/sec2 - fix some cleanup issues
Date: Fri, 26 Jan 2024 17:38:27 +0800
Message-ID: <20240126093828.14131-4-taoqi10@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240126093828.14131-1-taoqi10@huawei.com>
References: <20240126093828.14131-1-taoqi10@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500001.china.huawei.com (7.185.36.227)

This patch fixes following cleanup issues:
 - The return value of the function is
   inconsistent with the actual return type.
 - After the pointer type is directly converted
   to the `__le64` type, the program may crash
   or produce unexpected results.

Signed-off-by: Qi Tao <taoqi10@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index 692ba3213cc6..5d4facf62c86 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -118,7 +118,7 @@ struct sec_aead {
 };
 
 /* Get an en/de-cipher queue cyclically to balance load over queues of TFM */
-static inline int sec_alloc_queue_id(struct sec_ctx *ctx, struct sec_req *req)
+static inline u32 sec_alloc_queue_id(struct sec_ctx *ctx, struct sec_req *req)
 {
 	if (req->c_req.encrypt)
 		return (u32)atomic_inc_return(&ctx->enc_qcyclic) %
@@ -1371,7 +1371,7 @@ static int sec_skcipher_bd_fill_v3(struct sec_ctx *ctx, struct sec_req *req)
 	sec_sqe3->bd_param = cpu_to_le32(bd_param);
 
 	sec_sqe3->c_len_ivin |= cpu_to_le32(c_req->c_len);
-	sec_sqe3->tag = cpu_to_le64(req);
+	sec_sqe3->tag = cpu_to_le64((unsigned long)req);
 
 	return 0;
 }
-- 
2.33.0


