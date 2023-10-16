Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05677CB6CB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 01:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbjJPXAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 19:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjJPW77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 18:59:59 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BBD9B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 15:59:57 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id F2EA8240029
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 00:59:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1697497196; bh=rnbADe6m90A07GERJn789AJyLmRj2m+LZ1+95wztGA4=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=Jh5UDJJDwz543riptIZiaIlXKxwqO2SN1Q1V4cGEbYu1Agz/0ga4sKyIegpitZdnN
         MQZXCjVcZans1EzSX9QLZ1MyhbX8wrfGn5qEUOI+BXTvthMCFdCEJVEPx6F0nH8J5z
         udKowcI8GDPfQNUGyMw8jULBGKNijrF2IP6wvMFMKrBZpRjd9kDu8zYP9ZWPnhiMYi
         TziYQT8sxADAQxTxE6Htmcn/+B6MKcwE9QUH/VNRJHyiczu0CD5ooOaSrryBvpz0PA
         cQnJJq+VVGBlSM/r3sAKexhOHeoEE3QOSAA18pFDxz7i4CBJUiLW4WlH8xgJZDiHc5
         HF4qQjPO3j60g==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4S8Xcp34TVz9rxK;
        Tue, 17 Oct 2023 00:59:54 +0200 (CEST)
From:   Mark O'Donovan <shiftee@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, kbusch@kernel.org, hare@suse.de,
        Mark O'Donovan <shiftee@posteo.net>,
        Akash Appaiah <Akash.Appaiah@dell.com>
Subject: [PATCH v3 1/3] nvme-auth: alloc nvme_dhchap_key as single buffer
Date:   Mon, 16 Oct 2023 22:58:55 +0000
Message-Id: <20231016225857.3085234-2-shiftee@posteo.net>
In-Reply-To: <20231016225857.3085234-1-shiftee@posteo.net>
References: <20231016225857.3085234-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Co-developed-by: Akash Appaiah <Akash.Appaiah@dell.com>
Signed-off-by: Akash Appaiah <Akash.Appaiah@dell.com>
Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
---
 drivers/nvme/common/auth.c | 26 +++++++++++++++-----------
 include/linux/nvme-auth.h  |  3 ++-
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index d90e4f0c08b7..225fc474e34a 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -163,14 +163,9 @@ struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
 	p = strrchr(secret, ':');
 	if (p)
 		allocated_len = p - secret;
-	key = kzalloc(sizeof(*key), GFP_KERNEL);
+	key = nvme_auth_alloc_key(allocated_len, 0);
 	if (!key)
 		return ERR_PTR(-ENOMEM);
-	key->key = kzalloc(allocated_len, GFP_KERNEL);
-	if (!key->key) {
-		ret = -ENOMEM;
-		goto out_free_key;
-	}
 
 	key_len = base64_decode(secret, allocated_len, key->key);
 	if (key_len < 0) {
@@ -213,19 +208,28 @@ struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
 	key->hash = key_hash;
 	return key;
 out_free_secret:
-	kfree_sensitive(key->key);
-out_free_key:
-	kfree(key);
+	nvme_auth_free_key(key);
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(nvme_auth_extract_key);
 
+struct nvme_dhchap_key *nvme_auth_alloc_key(u32 len, u8 hash)
+{
+	struct nvme_dhchap_key *key = kzalloc(len + sizeof(*key), GFP_KERNEL);
+
+	if (key) {
+		key->len = len;
+		key->hash = hash;
+	}
+	return key;
+}
+EXPORT_SYMBOL_GPL(nvme_auth_alloc_key);
+
 void nvme_auth_free_key(struct nvme_dhchap_key *key)
 {
 	if (!key)
 		return;
-	kfree_sensitive(key->key);
-	kfree(key);
+	kfree_sensitive(key);
 }
 EXPORT_SYMBOL_GPL(nvme_auth_free_key);
 
diff --git a/include/linux/nvme-auth.h b/include/linux/nvme-auth.h
index dcb8030062dd..df96940be930 100644
--- a/include/linux/nvme-auth.h
+++ b/include/linux/nvme-auth.h
@@ -9,9 +9,9 @@
 #include <crypto/kpp.h>
 
 struct nvme_dhchap_key {
-	u8 *key;
 	size_t len;
 	u8 hash;
+	u8 key[];
 };
 
 u32 nvme_auth_get_seqnum(void);
@@ -27,6 +27,7 @@ u8 nvme_auth_hmac_id(const char *hmac_name);
 struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
 					      u8 key_hash);
 void nvme_auth_free_key(struct nvme_dhchap_key *key);
+struct nvme_dhchap_key *nvme_auth_alloc_key(u32 len, u8 hash);
 u8 *nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn);
 int nvme_auth_generate_key(u8 *secret, struct nvme_dhchap_key **ret_key);
 int nvme_auth_augmented_challenge(u8 hmac_id, u8 *skey, size_t skey_len,
-- 
2.39.2

