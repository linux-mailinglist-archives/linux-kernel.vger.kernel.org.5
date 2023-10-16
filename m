Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6417CB6CC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 01:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbjJPXAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 19:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjJPXAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 19:00:00 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D2BAC
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 15:59:58 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 358BE240105
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 00:59:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1697497197; bh=HAdzU0up7R6jFB/6QiUAp2Zvie9qM6pmoMBSC5nkdz0=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=XOzt2uybwjqRufkhDrjRkVhq3FXIKouvhv5h3DR/SE36569YBsI8DLr0EP1NrE3re
         z6QC5tWaAIJmr1XSFSOBvUhM6jrvy6uUpw80OM1E2xS76EajXyw0LuG6NEnnarmj4v
         Ln+vTFb4LXpzeuDzklYOAxrvu5G4KmkMWeHDeR5u5NrmxitAHzs/cqpeNYwBAde8Yr
         j5eSV2mXi3XxyZ4OxHqgdbJymFk6YXxAqlfiP748XXC9RXR1is/M+P0LyG8oMF4Rnr
         d5wIx8TXriE/6kXRgktxug34T67i6hDbECbm5a8f2fgA05N1gNMq7GCXtmBMxn2vn6
         Rk0etAiWUyksA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4S8Xcq5CBlz9rxH;
        Tue, 17 Oct 2023 00:59:55 +0200 (CEST)
From:   Mark O'Donovan <shiftee@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, kbusch@kernel.org, hare@suse.de,
        Mark O'Donovan <shiftee@posteo.net>,
        Akash Appaiah <Akash.Appaiah@dell.com>
Subject: [PATCH v3 2/3] nvme-auth: use transformed key size to create resp
Date:   Mon, 16 Oct 2023 22:58:56 +0000
Message-Id: <20231016225857.3085234-3-shiftee@posteo.net>
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

This does not change current behaviour as the driver currently
verifies that the secret size is the same size as the length of
the transformation hash.

Co-developed-by: Akash Appaiah <Akash.Appaiah@dell.com>
Signed-off-by: Akash Appaiah <Akash.Appaiah@dell.com>
Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
---
V1 -> V2: support target implementation and controller secrets also
V2 -> V3: return key from nvme_auth_transform_key

 drivers/nvme/common/auth.c | 18 ++++++++++--------
 drivers/nvme/host/auth.c   | 30 +++++++++++++++---------------
 drivers/nvme/target/auth.c | 30 ++++++++++++++++--------------
 include/linux/nvme-auth.h  |  2 +-
 4 files changed, 42 insertions(+), 38 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 225fc474e34a..647931acc1ba 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -233,20 +233,21 @@ void nvme_auth_free_key(struct nvme_dhchap_key *key)
 }
 EXPORT_SYMBOL_GPL(nvme_auth_free_key);
 
-u8 *nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn)
+struct nvme_dhchap_key *nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn)
 {
 	const char *hmac_name;
 	struct crypto_shash *key_tfm;
 	struct shash_desc *shash;
-	u8 *transformed_key;
-	int ret;
+	struct nvme_dhchap_key *transformed_key;
+	int ret, key_len;
 
 	if (!key || !key->key) {
 		pr_warn("No key specified\n");
 		return ERR_PTR(-ENOKEY);
 	}
 	if (key->hash == 0) {
-		transformed_key = kmemdup(key->key, key->len, GFP_KERNEL);
+		key_len = sizeof(*key) + key->len;
+		transformed_key = kmemdup(key, key_len, GFP_KERNEL);
 		return transformed_key ? transformed_key : ERR_PTR(-ENOMEM);
 	}
 	hmac_name = nvme_auth_hmac_name(key->hash);
@@ -257,7 +258,7 @@ u8 *nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn)
 
 	key_tfm = crypto_alloc_shash(hmac_name, 0, 0);
 	if (IS_ERR(key_tfm))
-		return (u8 *)key_tfm;
+		return (void *)key_tfm;
 
 	shash = kmalloc(sizeof(struct shash_desc) +
 			crypto_shash_descsize(key_tfm),
@@ -267,7 +268,8 @@ u8 *nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn)
 		goto out_free_key;
 	}
 
-	transformed_key = kzalloc(crypto_shash_digestsize(key_tfm), GFP_KERNEL);
+	key_len = crypto_shash_digestsize(key_tfm);
+	transformed_key = nvme_auth_alloc_key(key_len, key->hash);
 	if (!transformed_key) {
 		ret = -ENOMEM;
 		goto out_free_shash;
@@ -286,7 +288,7 @@ u8 *nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn)
 	ret = crypto_shash_update(shash, "NVMe-over-Fabrics", 17);
 	if (ret < 0)
 		goto out_free_transformed_key;
-	ret = crypto_shash_final(shash, transformed_key);
+	ret = crypto_shash_final(shash, transformed_key->key);
 	if (ret < 0)
 		goto out_free_transformed_key;
 
@@ -296,7 +298,7 @@ u8 *nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn)
 	return transformed_key;
 
 out_free_transformed_key:
-	kfree_sensitive(transformed_key);
+	nvme_auth_free_key(transformed_key);
 out_free_shash:
 	kfree(shash);
 out_free_key:
diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index daf5d144a8ea..de1390d705dc 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -23,6 +23,7 @@ struct nvme_dhchap_queue_context {
 	struct nvme_ctrl *ctrl;
 	struct crypto_shash *shash_tfm;
 	struct crypto_kpp *dh_tfm;
+	struct nvme_dhchap_key *transformed_key;
 	void *buf;
 	int qid;
 	int error;
@@ -36,7 +37,6 @@ struct nvme_dhchap_queue_context {
 	u8 c1[64];
 	u8 c2[64];
 	u8 response[64];
-	u8 *host_response;
 	u8 *ctrl_key;
 	u8 *host_key;
 	u8 *sess_key;
@@ -428,12 +428,12 @@ static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
 	dev_dbg(ctrl->device, "%s: qid %d host response seq %u transaction %d\n",
 		__func__, chap->qid, chap->s1, chap->transaction);
 
-	if (!chap->host_response) {
-		chap->host_response = nvme_auth_transform_key(ctrl->host_key,
+	if (!chap->transformed_key) {
+		chap->transformed_key = nvme_auth_transform_key(ctrl->host_key,
 						ctrl->opts->host->nqn);
-		if (IS_ERR(chap->host_response)) {
-			ret = PTR_ERR(chap->host_response);
-			chap->host_response = NULL;
+		if (IS_ERR(chap->transformed_key)) {
+			ret = PTR_ERR(chap->transformed_key);
+			chap->transformed_key = NULL;
 			return ret;
 		}
 	} else {
@@ -442,7 +442,7 @@ static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
 	}
 
 	ret = crypto_shash_setkey(chap->shash_tfm,
-			chap->host_response, ctrl->host_key->len);
+			chap->transformed_key->key, chap->transformed_key->len);
 	if (ret) {
 		dev_warn(ctrl->device, "qid %d: failed to set key, error %d\n",
 			 chap->qid, ret);
@@ -508,19 +508,19 @@ static int nvme_auth_dhchap_setup_ctrl_response(struct nvme_ctrl *ctrl,
 		struct nvme_dhchap_queue_context *chap)
 {
 	SHASH_DESC_ON_STACK(shash, chap->shash_tfm);
-	u8 *ctrl_response;
+	struct nvme_dhchap_key *transformed_key;
 	u8 buf[4], *challenge = chap->c2;
 	int ret;
 
-	ctrl_response = nvme_auth_transform_key(ctrl->ctrl_key,
+	transformed_key = nvme_auth_transform_key(ctrl->ctrl_key,
 				ctrl->opts->subsysnqn);
-	if (IS_ERR(ctrl_response)) {
-		ret = PTR_ERR(ctrl_response);
+	if (IS_ERR(transformed_key)) {
+		ret = PTR_ERR(transformed_key);
 		return ret;
 	}
 
 	ret = crypto_shash_setkey(chap->shash_tfm,
-			ctrl_response, ctrl->ctrl_key->len);
+			transformed_key->key, transformed_key->len);
 	if (ret) {
 		dev_warn(ctrl->device, "qid %d: failed to set key, error %d\n",
 			 chap->qid, ret);
@@ -586,7 +586,7 @@ static int nvme_auth_dhchap_setup_ctrl_response(struct nvme_ctrl *ctrl,
 out:
 	if (challenge != chap->c2)
 		kfree(challenge);
-	kfree(ctrl_response);
+	nvme_auth_free_key(transformed_key);
 	return ret;
 }
 
@@ -648,8 +648,8 @@ static int nvme_auth_dhchap_exponential(struct nvme_ctrl *ctrl,
 
 static void nvme_auth_reset_dhchap(struct nvme_dhchap_queue_context *chap)
 {
-	kfree_sensitive(chap->host_response);
-	chap->host_response = NULL;
+	nvme_auth_free_key(chap->transformed_key);
+	chap->transformed_key = NULL;
 	kfree_sensitive(chap->host_key);
 	chap->host_key = NULL;
 	chap->host_key_len = 0;
diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 4dcddcf95279..84f3ab1f9d02 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -267,7 +267,8 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 	struct shash_desc *shash;
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	const char *hash_name;
-	u8 *challenge = req->sq->dhchap_c1, *host_response;
+	u8 *challenge = req->sq->dhchap_c1;
+	struct nvme_dhchap_key *transformed_key;
 	u8 buf[4];
 	int ret;
 
@@ -291,14 +292,14 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 		goto out_free_tfm;
 	}
 
-	host_response = nvme_auth_transform_key(ctrl->host_key, ctrl->hostnqn);
-	if (IS_ERR(host_response)) {
-		ret = PTR_ERR(host_response);
+	transformed_key = nvme_auth_transform_key(ctrl->host_key, ctrl->hostnqn);
+	if (IS_ERR(transformed_key)) {
+		ret = PTR_ERR(transformed_key);
 		goto out_free_tfm;
 	}
 
-	ret = crypto_shash_setkey(shash_tfm, host_response,
-				  ctrl->host_key->len);
+	ret = crypto_shash_setkey(shash_tfm, transformed_key->key,
+				  transformed_key->len);
 	if (ret)
 		goto out_free_response;
 
@@ -365,7 +366,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 		kfree(challenge);
 	kfree(shash);
 out_free_response:
-	kfree_sensitive(host_response);
+	nvme_auth_free_key(transformed_key);
 out_free_tfm:
 	crypto_free_shash(shash_tfm);
 	return 0;
@@ -378,7 +379,8 @@ int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
 	struct shash_desc *shash;
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	const char *hash_name;
-	u8 *challenge = req->sq->dhchap_c2, *ctrl_response;
+	u8 *challenge = req->sq->dhchap_c2;
+	struct nvme_dhchap_key *transformed_key;
 	u8 buf[4];
 	int ret;
 
@@ -402,15 +404,15 @@ int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
 		goto out_free_tfm;
 	}
 
-	ctrl_response = nvme_auth_transform_key(ctrl->ctrl_key,
+	transformed_key = nvme_auth_transform_key(ctrl->ctrl_key,
 						ctrl->subsysnqn);
-	if (IS_ERR(ctrl_response)) {
-		ret = PTR_ERR(ctrl_response);
+	if (IS_ERR(transformed_key)) {
+		ret = PTR_ERR(transformed_key);
 		goto out_free_tfm;
 	}
 
-	ret = crypto_shash_setkey(shash_tfm, ctrl_response,
-				  ctrl->ctrl_key->len);
+	ret = crypto_shash_setkey(shash_tfm, transformed_key->key,
+				  transformed_key->len);
 	if (ret)
 		goto out_free_response;
 
@@ -474,7 +476,7 @@ int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
 		kfree(challenge);
 	kfree(shash);
 out_free_response:
-	kfree_sensitive(ctrl_response);
+	nvme_auth_free_key(transformed_key);
 out_free_tfm:
 	crypto_free_shash(shash_tfm);
 	return 0;
diff --git a/include/linux/nvme-auth.h b/include/linux/nvme-auth.h
index df96940be930..fd8f69183d55 100644
--- a/include/linux/nvme-auth.h
+++ b/include/linux/nvme-auth.h
@@ -28,7 +28,7 @@ struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
 					      u8 key_hash);
 void nvme_auth_free_key(struct nvme_dhchap_key *key);
 struct nvme_dhchap_key *nvme_auth_alloc_key(u32 len, u8 hash);
-u8 *nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn);
+struct nvme_dhchap_key *nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn);
 int nvme_auth_generate_key(u8 *secret, struct nvme_dhchap_key **ret_key);
 int nvme_auth_augmented_challenge(u8 hmac_id, u8 *skey, size_t skey_len,
 				  u8 *challenge, u8 *aug, size_t hlen);
-- 
2.39.2

