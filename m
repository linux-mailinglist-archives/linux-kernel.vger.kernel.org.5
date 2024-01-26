Return-Path: <linux-kernel+bounces-39943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DDC83D7AE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC271F2FD26
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FB76A35D;
	Fri, 26 Jan 2024 09:39:20 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0710A6A32C;
	Fri, 26 Jan 2024 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706261960; cv=none; b=GoiUGEb4GPGQCTyP5cr3lYxl36G8F7C60LqFYQQ1EhQoXDcihci/HalA8Sgh0Fwj+hOz0Vw30Yel4VSnmtbPJNWBBVX3ThqiAdirXcOkakTXc1QAgUgryAMnh5AV9P1VcHRJoE0CX/vMQCpYUn+/38ENHanw0zXaj7p+oJBjlZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706261960; c=relaxed/simple;
	bh=+PBd62Uy6Enf/+GClkZ0QPTz6bpsbkxzJUJyHuJx3ko=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kpen0EOlXD0pEMeXJyhnyuY4TwVhxuRX5ysx1axcmXF9mbtg/LJiWqR4SSPMEsVe2MDfMOUkE8zPLxy5MDdNdGzQ8QJnhYVFWuwHk0WUUyIWj201jWJqJeL7wCt7GFGZCXXPrP6Le+7KW09LNjNK4B33LdH946DX4R9nOYSMrHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TLt0Q3pDSzXgnW;
	Fri, 26 Jan 2024 17:37:58 +0800 (CST)
Received: from dggpeml500001.china.huawei.com (unknown [7.185.36.227])
	by mail.maildlp.com (Postfix) with ESMTPS id BD92818007D;
	Fri, 26 Jan 2024 17:39:13 +0800 (CST)
Received: from huawei.com (10.69.192.56) by dggpeml500001.china.huawei.com
 (7.185.36.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Jan
 2024 17:39:13 +0800
From: Qi Tao <taoqi10@huawei.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<liulongfang@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>
Subject: [PATCH v2 2/4] crypto: hisilicon/sec2 - modify nested macro call
Date: Fri, 26 Jan 2024 17:38:26 +0800
Message-ID: <20240126093828.14131-3-taoqi10@huawei.com>
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


