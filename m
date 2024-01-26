Return-Path: <linux-kernel+bounces-39913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 563C883D751
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E77861F2A8A8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925E81CFB5;
	Fri, 26 Jan 2024 09:22:16 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBCB1BF36;
	Fri, 26 Jan 2024 09:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706260936; cv=none; b=gHk5eRSZ+sVtCPeb5dc62sp3zGmvmQhX7BzuexxlwAWVhltov11crTXspG8XWASqwmws3933SGE7U8gcwfnHTFhJYAO1gveJn9SIMOqRWycKSYfSVtkK4Wuq3H1gl2lBrVLP6k9t0HqVMVnYoZuZzC3h9Gg2RQWcykWtohjmLiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706260936; c=relaxed/simple;
	bh=+PBd62Uy6Enf/+GClkZ0QPTz6bpsbkxzJUJyHuJx3ko=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NC+7Uii9UtiGf1wyIHScSQ2EHVzaOseeyhcYSSo7z8tsXpwx6/cTu/GFLHK3t3hFUt1M8aGF0GtuKKCnGyVU3Hs3nJa9DqZsFzns4SCil76zjhBZLR/nl8gsLANJhptWBktYFDtl9XT1TEuM5XrWgA/jWT1x2X7Ntzy5sYLtHKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4TLsd82Q9WzNlb4;
	Fri, 26 Jan 2024 17:21:16 +0800 (CST)
Received: from dggpeml500001.china.huawei.com (unknown [7.185.36.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 4580E140499;
	Fri, 26 Jan 2024 17:22:11 +0800 (CST)
Received: from huawei.com (10.69.192.56) by dggpeml500001.china.huawei.com
 (7.185.36.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Jan
 2024 17:22:11 +0800
From: Qi Tao <taoqi10@huawei.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<liulongfang@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>
Subject: [PATCH v2 2/4] crypto: hisilicon/sec2 - modify nested macro call
Date: Fri, 26 Jan 2024 17:21:22 +0800
Message-ID: <20240126092124.14055-3-taoqi10@huawei.com>
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

Nested macros are integrated into a single macro,
making the code simpler.

Signed-off-by: Qi Tao <taoqi10@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index f028dcfd0ead..692ba3213cc6 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -2145,8 +2145,8 @@ static int sec_skcipher_decrypt(struct skcipher_request *sk_req)
 	return sec_skcipher_crypto(sk_req, false);
 }
 
-#define SEC_SKCIPHER_GEN_ALG(sec_cra_name, sec_set_key, sec_min_key_size, \
-	sec_max_key_size, ctx_init, ctx_exit, blk_size, iv_size)\
+#define SEC_SKCIPHER_ALG(sec_cra_name, sec_set_key, \
+	sec_min_key_size, sec_max_key_size, blk_size, iv_size)\
 {\
 	.base = {\
 		.cra_name = sec_cra_name,\
@@ -2158,8 +2158,8 @@ static int sec_skcipher_decrypt(struct skcipher_request *sk_req)
 		.cra_ctxsize = sizeof(struct sec_ctx),\
 		.cra_module = THIS_MODULE,\
 	},\
-	.init = ctx_init,\
-	.exit = ctx_exit,\
+	.init = sec_skcipher_ctx_init,\
+	.exit = sec_skcipher_ctx_exit,\
 	.setkey = sec_set_key,\
 	.decrypt = sec_skcipher_decrypt,\
 	.encrypt = sec_skcipher_encrypt,\
@@ -2168,11 +2168,6 @@ static int sec_skcipher_decrypt(struct skcipher_request *sk_req)
 	.ivsize = iv_size,\
 }
 
-#define SEC_SKCIPHER_ALG(name, key_func, min_key_size, \
-	max_key_size, blk_size, iv_size) \
-	SEC_SKCIPHER_GEN_ALG(name, key_func, min_key_size, max_key_size, \
-	sec_skcipher_ctx_init, sec_skcipher_ctx_exit, blk_size, iv_size)
-
 static struct sec_skcipher sec_skciphers[] = {
 	{
 		.alg_msk = BIT(0),
-- 
2.33.0


