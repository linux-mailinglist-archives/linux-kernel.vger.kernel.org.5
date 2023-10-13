Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FC17C8E5D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 22:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjJMU3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 16:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjJMU3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 16:29:11 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F9D83
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 13:29:08 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 200D724002A
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 22:29:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1697228947; bh=wCPxNhXED6Xa4hXVL029+O8olAaVDn+KVg7XUvMNVA4=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=JIVIcEgvumkdb/aKU3G+lxzED3XX7aoaZ5ReEFljmhfXYoziONBFN6WVshOp5r2Mk
         973rUH53cYgKyGvHCnzIMrQ58aU1FsT4ZguVtMwSgdxz6LKzaS7WAtFgs/KhA9ErgM
         U1i+0lKq5XiTFLfhVkiACL096l8IAr/HmC2TLehwU3GKoBw6ZTCHpfaq1BvKXuAXnf
         FDLbTjxXMuB1/iV1ivg2qfz7+903zzy4D5jG5cKSpMCi1QOnpY0pYrK+XP0YXocpib
         cwGNal6t9YdcgIeU3mF7KmXU+7v9FwX/vCXgKeMNDu2TgZpI/73mkF+XX6DFe6vuMT
         AR+UqFw/9k/hQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4S6dQ93TzBz9rxM;
        Fri, 13 Oct 2023 22:29:05 +0200 (CEST)
From:   Mark O'Donovan <shiftee@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, kbusch@kernel.org, hare@suse.de,
        Mark O'Donovan <shiftee@posteo.net>,
        Akash Appaiah <Akash.Appaiah@dell.com>
Subject: [PATCH 1/2] nvme-auth: use transformed key size to create resp
Date:   Fri, 13 Oct 2023 20:28:26 +0000
Message-Id: <20231013202827.2262708-2-shiftee@posteo.net>
In-Reply-To: <20231013202827.2262708-1-shiftee@posteo.net>
References: <20231013202827.2262708-1-shiftee@posteo.net>
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
 drivers/nvme/host/auth.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index daf5d144a8ea..e7d478d17b06 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -418,6 +418,14 @@ static int nvme_auth_set_dhchap_failure2_data(struct nvme_ctrl *ctrl,
 	return size;
 }
 
+static int nvme_auth_dhchap_transformed_key_len(struct nvme_dhchap_key *key)
+{
+	if (key->hash)
+		return nvme_auth_hmac_hash_len(key->hash);
+
+	return key->len;
+}
+
 static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
 		struct nvme_dhchap_queue_context *chap)
 {
@@ -442,7 +450,8 @@ static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
 	}
 
 	ret = crypto_shash_setkey(chap->shash_tfm,
-			chap->host_response, ctrl->host_key->len);
+			chap->host_response,
+			nvme_auth_dhchap_transformed_key_len(ctrl->host_key));
 	if (ret) {
 		dev_warn(ctrl->device, "qid %d: failed to set key, error %d\n",
 			 chap->qid, ret);
-- 
2.39.2

