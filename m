Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4D27CA2E9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbjJPI5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbjJPI51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:57:27 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D2795
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 01:57:25 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 39042240105
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 10:57:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1697446644; bh=kv0HETudyLnK7zerm9neLvpDVJtlAcnFf3yrw1VeEJU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=fl7cKXtKqgMoo+wm4CW5MibIn+9AP5TAEM+bUCfIFsikcsqq0zlIpFLLEMwrkkGU7
         MqvGf107aMkBI3j4y7GOthQmbkYuntjHWmaHHZJnMezHHR5Da7ZJIQvlufzzJZJNn0
         4irEZBPwawFDf29amh26/1rekW71at6oFz9wkszJtGJZHkxAqOnaHkNKOlT2POSLpC
         nm3B99HsSTmzoubvKH2l+bTAbi1RoelQDSHIhAU1x7xsUza2EU2mM5wFQlVSK0+E7n
         4CB6Vasig2VvGnYIodopcXpxCUqh9fvYiwczGez/vgPV7pWhd9lGkb+XU+All+BhzM
         YDy61XdIgSfzg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4S89wf3nYFz9rxd;
        Mon, 16 Oct 2023 10:57:22 +0200 (CEST)
From:   Mark O'Donovan <shiftee@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, kbusch@kernel.org, hare@suse.de,
        Mark O'Donovan <shiftee@posteo.net>,
        Akash Appaiah <Akash.Appaiah@dell.com>
Subject: [PATCH v2 1/2] nvme-auth: use transformed key size to create resp
Date:   Mon, 16 Oct 2023 08:57:14 +0000
Message-Id: <20231016085715.3068974-2-shiftee@posteo.net>
In-Reply-To: <20231016085715.3068974-1-shiftee@posteo.net>
References: <20231016085715.3068974-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

 drivers/nvme/common/auth.c | 6 +++++-
 drivers/nvme/host/auth.c   | 4 ++--
 drivers/nvme/target/auth.c | 4 ++--
 include/linux/nvme-auth.h  | 3 ++-
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index d90e4f0c08b7..26a7fbdf4d55 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -243,6 +243,8 @@ u8 *nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn)
 	}
 	if (key->hash == 0) {
 		transformed_key = kmemdup(key->key, key->len, GFP_KERNEL);
+		if (transformed_key)
+			key->transformed_len = key->len;
 		return transformed_key ? transformed_key : ERR_PTR(-ENOMEM);
 	}
 	hmac_name = nvme_auth_hmac_name(key->hash);
@@ -263,7 +265,8 @@ u8 *nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn)
 		goto out_free_key;
 	}
 
-	transformed_key = kzalloc(crypto_shash_digestsize(key_tfm), GFP_KERNEL);
+	key->transformed_len = crypto_shash_digestsize(key_tfm);
+	transformed_key = kzalloc(key->transformed_len, GFP_KERNEL);
 	if (!transformed_key) {
 		ret = -ENOMEM;
 		goto out_free_shash;
@@ -297,6 +300,7 @@ u8 *nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn)
 	kfree(shash);
 out_free_key:
 	crypto_free_shash(key_tfm);
+	key->transformed_len = 0;
 
 	return ERR_PTR(ret);
 }
diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index daf5d144a8ea..89293da3210e 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -442,7 +442,7 @@ static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
 	}
 
 	ret = crypto_shash_setkey(chap->shash_tfm,
-			chap->host_response, ctrl->host_key->len);
+			chap->host_response, ctrl->host_key->transformed_len);
 	if (ret) {
 		dev_warn(ctrl->device, "qid %d: failed to set key, error %d\n",
 			 chap->qid, ret);
@@ -520,7 +520,7 @@ static int nvme_auth_dhchap_setup_ctrl_response(struct nvme_ctrl *ctrl,
 	}
 
 	ret = crypto_shash_setkey(chap->shash_tfm,
-			ctrl_response, ctrl->ctrl_key->len);
+			ctrl_response, ctrl->ctrl_key->transformed_len);
 	if (ret) {
 		dev_warn(ctrl->device, "qid %d: failed to set key, error %d\n",
 			 chap->qid, ret);
diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 4dcddcf95279..c46473b383b1 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -298,7 +298,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 	}
 
 	ret = crypto_shash_setkey(shash_tfm, host_response,
-				  ctrl->host_key->len);
+				  ctrl->host_key->transformed_len);
 	if (ret)
 		goto out_free_response;
 
@@ -410,7 +410,7 @@ int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
 	}
 
 	ret = crypto_shash_setkey(shash_tfm, ctrl_response,
-				  ctrl->ctrl_key->len);
+				  ctrl->ctrl_key->transformed_len);
 	if (ret)
 		goto out_free_response;
 
diff --git a/include/linux/nvme-auth.h b/include/linux/nvme-auth.h
index dcb8030062dd..cf24d885dfd9 100644
--- a/include/linux/nvme-auth.h
+++ b/include/linux/nvme-auth.h
@@ -10,8 +10,9 @@
 
 struct nvme_dhchap_key {
 	u8 *key;
-	size_t len;
 	u8 hash;
+	size_t len;
+	size_t transformed_len;
 };
 
 u32 nvme_auth_get_seqnum(void);
-- 
2.39.2

