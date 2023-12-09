Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1689B80B2B8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 08:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbjLIHFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 02:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbjLIHFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 02:05:30 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033D810E7;
        Fri,  8 Dec 2023 23:05:36 -0800 (PST)
Received: from dggpemd200003.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SnJtG2T2Sz14LyK;
        Sat,  9 Dec 2023 15:05:10 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 dggpemd200003.china.huawei.com (7.185.36.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Sat, 9 Dec 2023 15:05:13 +0800
From:   Chenghai Huang <huangchenghai2@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <shenyang39@huawei.com>, <liulongfang@huawei.com>,
        <qianweili@huawei.com>
Subject: [PATCH 2/2] crypto: hisilicon/sec2 - optimize the error return process
Date:   Sat, 9 Dec 2023 15:01:35 +0800
Message-ID: <20231209070135.555110-3-huangchenghai2@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231209070135.555110-1-huangchenghai2@huawei.com>
References: <20231209070135.555110-1-huangchenghai2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemd200003.china.huawei.com (7.185.36.122)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the printf of an error message and optimized the handling
process of ret.

Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index c760f3a8af4d..f028dcfd0ead 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -850,6 +850,7 @@ static int sec_skcipher_setkey(struct crypto_skcipher *tfm, const u8 *key,
 		ret = sec_skcipher_aes_sm4_setkey(c_ctx, keylen, c_mode);
 		break;
 	default:
+		dev_err(dev, "sec c_alg err!\n");
 		return -EINVAL;
 	}
 
@@ -1172,7 +1173,8 @@ static int sec_aead_setkey(struct crypto_aead *tfm, const u8 *key,
 		return 0;
 	}
 
-	if (crypto_authenc_extractkeys(&keys, key, keylen))
+	ret = crypto_authenc_extractkeys(&keys, key, keylen);
+	if (ret)
 		goto bad_key;
 
 	ret = sec_aead_aes_set_key(c_ctx, &keys);
@@ -1189,6 +1191,7 @@ static int sec_aead_setkey(struct crypto_aead *tfm, const u8 *key,
 
 	if ((ctx->a_ctx.mac_len & SEC_SQE_LEN_RATE_MASK)  ||
 	    (ctx->a_ctx.a_key_len & SEC_SQE_LEN_RATE_MASK)) {
+		ret = -EINVAL;
 		dev_err(dev, "MAC or AUTH key length error!\n");
 		goto bad_key;
 	}
@@ -1197,7 +1200,7 @@ static int sec_aead_setkey(struct crypto_aead *tfm, const u8 *key,
 
 bad_key:
 	memzero_explicit(&keys, sizeof(struct crypto_authenc_keys));
-	return -EINVAL;
+	return ret;
 }
 
 
-- 
2.30.0

