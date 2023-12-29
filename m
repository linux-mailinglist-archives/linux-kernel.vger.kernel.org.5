Return-Path: <linux-kernel+bounces-12959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 289BE81FD57
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 07:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88647282B1C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 06:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B7F2F30;
	Fri, 29 Dec 2023 06:45:17 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94A723A1;
	Fri, 29 Dec 2023 06:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4T1bTR0FLtz1wpkX;
	Fri, 29 Dec 2023 14:44:43 +0800 (CST)
Received: from dggpeml500001.china.huawei.com (unknown [7.185.36.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 314891A0192;
	Fri, 29 Dec 2023 14:44:52 +0800 (CST)
Received: from huawei.com (10.69.192.56) by dggpeml500001.china.huawei.com
 (7.185.36.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 29 Dec
 2023 14:44:51 +0800
From: Qi Tao <taoqi10@huawei.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<liulongfang@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>
Subject: [PATCH 3/4] crypto: hisilicon/sec2 - fix some cleanup issues
Date: Fri, 29 Dec 2023 14:44:20 +0800
Message-ID: <20231229064421.16981-4-taoqi10@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231229064421.16981-1-taoqi10@huawei.com>
References: <20231229064421.16981-1-taoqi10@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500001.china.huawei.com (7.185.36.227)

This patch fixes following cleanup issues:
 - The return value of the function is
   inconsistent with the actual return type.
 - After the pointer type is directly converted
   to the '__le64' type, the program may crash
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
+	sec_sqe3->tag = cpu_to_le64((unsigned long)(uintptr_t)req);
 
 	return 0;
 }
-- 
2.33.0


