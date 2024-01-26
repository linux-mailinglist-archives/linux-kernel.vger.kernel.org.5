Return-Path: <linux-kernel+bounces-39909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C0483D74E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D340A1F26A8B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A3C1C296;
	Fri, 26 Jan 2024 09:22:15 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3981BF41;
	Fri, 26 Jan 2024 09:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706260935; cv=none; b=kU6zagwGe6cmgM+opuFOY8pxvYDLZfOwgCF0KBxOvO2me7JG6DeW+DN6WPWLPxSKyQBezWQjzvDeqXLVsRV9yRGgpNDX+/3dtSHEFAFlD8VCA8X0ofPPRm3sArCGOA5twR85cjiAinQlXQjCpmGsOdrsBe59BmFoCjd8ZRNaS7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706260935; c=relaxed/simple;
	bh=hMPu5jhk9dmMRoZn4YMWKRNN1BOGHMTRanhtmEgePWM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TXnlI+fL1cRJudMqQsxB409X31mTQgs0t7lMbIDm15H8oX+lqQcgRqDXvkSzKLLBqP1ymp4UN/UC+3FT7yiNpOzjUb75iMrbkubkRzSHcEfmZmkf9YydOlETQcMjnho3QJCRwyJK485SQG98cvh8Zk54pDbeRwaXw8qWcsMmDpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TLsd86Stmz1xmhw;
	Fri, 26 Jan 2024 17:21:16 +0800 (CST)
Received: from dggpeml500001.china.huawei.com (unknown [7.185.36.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 6AB28140416;
	Fri, 26 Jan 2024 17:22:11 +0800 (CST)
Received: from huawei.com (10.69.192.56) by dggpeml500001.china.huawei.com
 (7.185.36.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Jan
 2024 17:22:11 +0800
From: Qi Tao <taoqi10@huawei.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<liulongfang@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>
Subject: [PATCH v2 3/4] crypto: hisilicon/sec2 - fix some cleanup issues
Date: Fri, 26 Jan 2024 17:21:23 +0800
Message-ID: <20240126092124.14055-4-taoqi10@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240126092124.14055-1-taoqi10@huawei.com>
References: <20240126092124.14055-1-taoqi10@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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


