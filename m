Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1840A7CC98A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 19:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343923AbjJQRJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 13:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343878AbjJQRJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 13:09:41 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA61DBA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 10:09:38 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 5BF20240105
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 19:09:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1697562577; bh=NF1r+NLg51G1dFzc0PzoVKjUyD6Riw2yYir+JcEjJhY=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=QIzeHAFnXABFpH8xmay3ntYWPKL4KEEv1raICjR7XjnQQSqakku+vsK1tRjHEOUXL
         xunTwLUqdm0GmvFjZOJykA+J/jH8YvQYEiW/obveAemRFCnfevfxSgqVeeQEWC3SAe
         pPat4vWUmhXORM/4RqlUhswGVxetZ8uHoPHF1ffAW0aSpnnD1kwnhwnrcq+WcjUdO+
         DN7kFuiDGfMOW3wSXuNB9NMOa4UytiLbEMNoYUDTjZxfmAIPFD5WCZVJdLXOKSumhT
         JB4L0MVN47rvFS7g/bv2y7nFr59JF71VTVA6EFxRrldaxySXzgvep+2EtzbH1MAmgC
         zcJGQQJhY/H5g==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4S90p76xy3z9rxb;
        Tue, 17 Oct 2023 19:09:35 +0200 (CEST)
From:   Mark O'Donovan <shiftee@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, kbusch@kernel.org, hare@suse.de,
        Mark O'Donovan <shiftee@posteo.net>,
        Akash Appaiah <Akash.Appaiah@dell.com>
Subject: [PATCH v5 1/3] nvme-auth: alloc nvme_dhchap_key as single buffer
Date:   Tue, 17 Oct 2023 17:09:17 +0000
Message-Id: <20231017170919.30358-2-shiftee@posteo.net>
In-Reply-To: <20231017170919.30358-1-shiftee@posteo.net>
References: <20231017170919.30358-1-shiftee@posteo.net>
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
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
V2 -> V3: initial version

V3 -> V4: added function to get size of key struct

V4 -> V5: removed newly redundant check found by kernel test robot

 drivers/nvme/common/auth.c | 37 +++++++++++++++++++++++++------------
 include/linux/nvme-auth.h  |  4 +++-
 2 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index d90e4f0c08b7..16a071448d54 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -150,6 +150,14 @@ size_t nvme_auth_hmac_hash_len(u8 hmac_id)
 }
 EXPORT_SYMBOL_GPL(nvme_auth_hmac_hash_len);
 
+u32 nvme_auth_key_struct_size(u32 key_len)
+{
+	struct nvme_dhchap_key key;
+
+	return struct_size(&key, key, key_len);
+}
+EXPORT_SYMBOL_GPL(nvme_auth_key_struct_size);
+
 struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
 					      u8 key_hash)
 {
@@ -163,14 +171,9 @@ struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
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
@@ -213,19 +216,29 @@ struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
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
+	u32 num_bytes = nvme_auth_key_struct_size(len);
+	struct nvme_dhchap_key *key = kzalloc(num_bytes, GFP_KERNEL);
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
 
@@ -237,7 +250,7 @@ u8 *nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn)
 	u8 *transformed_key;
 	int ret;
 
-	if (!key || !key->key) {
+	if (!key) {
 		pr_warn("No key specified\n");
 		return ERR_PTR(-ENOKEY);
 	}
diff --git a/include/linux/nvme-auth.h b/include/linux/nvme-auth.h
index dcb8030062dd..a5ae9abe1ef6 100644
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
@@ -24,9 +24,11 @@ const char *nvme_auth_digest_name(u8 hmac_id);
 size_t nvme_auth_hmac_hash_len(u8 hmac_id);
 u8 nvme_auth_hmac_id(const char *hmac_name);
 
+u32 nvme_auth_key_struct_size(u32 key_len);
 struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
 					      u8 key_hash);
 void nvme_auth_free_key(struct nvme_dhchap_key *key);
+struct nvme_dhchap_key *nvme_auth_alloc_key(u32 len, u8 hash);
 u8 *nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn);
 int nvme_auth_generate_key(u8 *secret, struct nvme_dhchap_key **ret_key);
 int nvme_auth_augmented_challenge(u8 hmac_id, u8 *skey, size_t skey_len,
-- 
2.39.2

