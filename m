Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662FE764B54
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 10:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjG0IOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 04:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbjG0INn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:13:43 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8AEF065A0;
        Thu, 27 Jul 2023 01:09:03 -0700 (PDT)
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
        by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwCHClxrJcJkzK62BQ--.24861S2;
        Thu, 27 Jul 2023 16:06:03 +0800 (CST)
Received: from phytium.com.cn (unknown [60.27.159.40])
        by mail (Coremail) with SMTP id AQAAfwCHsgRoJcJkvl0AAA--.2811S3;
        Thu, 27 Jul 2023 16:06:01 +0800 (CST)
From:   Zhang Yiqun <zhangyiqun@phytium.com.cn>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Yiqun <zhangyiqun@phytium.com.cn>
Subject: [PATCH] crypto: all - alloc and init all req alloc as zero
Date:   Thu, 27 Jul 2023 16:05:48 +0800
Message-Id: <20230727080548.8666-1-zhangyiqun@phytium.com.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: AQAAfwCHsgRoJcJkvl0AAA--.2811S3
X-CM-SenderInfo: x2kd0wp1lt30o6sk53xlxphulrpou0/
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=zhangyiqun
        @phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7AFy7WF1rJrWktw1xAw4Dtwb_yoW8KryfpF
        sIka92yFW5XFyvkr18uF93tr95Ww48u3W3t348Ww1xAr4agryvqrZxArW8ZF1UAFZ5GrW8
        CFZFgw15Xw1DWFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
        UUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to change all req struct alloc function from kmalloc
to kzalloc. Sometimes, it will incur some errors without initialized
zero.

Signed-off-by: Zhang Yiqun <zhangyiqun@phytium.com.cn>
---
 include/crypto/akcipher.h | 2 +-
 include/crypto/hash.h     | 2 +-
 include/crypto/kpp.h      | 2 +-
 include/crypto/skcipher.h | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/crypto/akcipher.h b/include/crypto/akcipher.h
index 670508f1dca1..b6f2121fcb85 100644
--- a/include/crypto/akcipher.h
+++ b/include/crypto/akcipher.h
@@ -223,7 +223,7 @@ static inline struct akcipher_request *akcipher_request_alloc(
 {
 	struct akcipher_request *req;
 
-	req = kmalloc(sizeof(*req) + crypto_akcipher_reqsize(tfm), gfp);
+	req = kzalloc(sizeof(*req) + crypto_akcipher_reqsize(tfm), gfp);
 	if (likely(req))
 		akcipher_request_set_tfm(req, tfm);
 
diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index f7c2a22cd776..38429fb7bbf7 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -651,7 +651,7 @@ static inline struct ahash_request *ahash_request_alloc(
 {
 	struct ahash_request *req;
 
-	req = kmalloc(sizeof(struct ahash_request) +
+	req = kzalloc(sizeof(struct ahash_request) +
 		      crypto_ahash_reqsize(tfm), gfp);
 
 	if (likely(req))
diff --git a/include/crypto/kpp.h b/include/crypto/kpp.h
index 1988e24a0d1d..b4622bb747f9 100644
--- a/include/crypto/kpp.h
+++ b/include/crypto/kpp.h
@@ -201,7 +201,7 @@ static inline struct kpp_request *kpp_request_alloc(struct crypto_kpp *tfm,
 {
 	struct kpp_request *req;
 
-	req = kmalloc(sizeof(*req) + crypto_kpp_reqsize(tfm), gfp);
+	req = kzalloc(sizeof(*req) + crypto_kpp_reqsize(tfm), gfp);
 	if (likely(req))
 		kpp_request_set_tfm(req, tfm);
 
diff --git a/include/crypto/skcipher.h b/include/crypto/skcipher.h
index 080d1ba3611d..a35e6e6221e1 100644
--- a/include/crypto/skcipher.h
+++ b/include/crypto/skcipher.h
@@ -521,7 +521,7 @@ static inline struct skcipher_request *skcipher_request_alloc(
 {
 	struct skcipher_request *req;
 
-	req = kmalloc(sizeof(struct skcipher_request) +
+	req = kzalloc(sizeof(struct skcipher_request) +
 		      crypto_skcipher_reqsize(tfm), gfp);
 
 	if (likely(req))
-- 
2.17.1

