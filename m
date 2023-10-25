Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EBB7D6981
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbjJYKvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbjJYKvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:51:43 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238148F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 03:51:41 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id BEBA424002D
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 12:51:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1698231099; bh=Todilzex7SY38WlYbvcVBDp8UXS6ZQgCTD4taXoUATI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=JGX6rTQ5l/c+IsLYz+Fd6acI09fZ+QEBh6zBkFTylzWg+7Fl6j15+JNAZp6OlMG23
         s3oFVVd/G43XPTxGnbCTYHKyhfVab2CVTqr1i2FmAmzV0abFM2yLLgBNvZONgLOwUy
         ONB4wPjvc6CLTJn30Kp12vuPQT4H6yUdYcqEuOdQRNVrnWqn2EG8c/Ti6p4f1n3COk
         EauXS1ju/bKixX5MlKRJT3AUc5guC9OcFJk7aeEEOOyDwo/FL8JoO0+CVR28/Dw42+
         HjXBplrM/J7qIGW9hG/hgpm/LpLt3wLvWTnZHa4eZxTcw9XV+i58FiHBGz5uFNc53Y
         V6cel9BiM5AvQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4SFm2L1DMcz9rxN;
        Wed, 25 Oct 2023 12:51:38 +0200 (CEST)
From:   Mark O'Donovan <shiftee@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, kbusch@kernel.org, hare@suse.de,
        Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH v3 2/3] nvme-auth: add flag for bi-directional auth
Date:   Wed, 25 Oct 2023 10:51:24 +0000
Message-Id: <20231025105125.134443-3-shiftee@posteo.net>
In-Reply-To: <20231025105125.134443-1-shiftee@posteo.net>
References: <20231025105125.134443-1-shiftee@posteo.net>
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

Introduces an explicit variable for bi-directional auth.
The currently used variable chap->s2 is incorrectly zeroed for
uni-directional auth. That will be fixed in the next patch so this
needs to change to avoid sending unexpected success2 messages

Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/auth.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index e0fc33d41baa..8558a02865ac 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -28,6 +28,7 @@ struct nvme_dhchap_queue_context {
 	int error;
 	u32 s1;
 	u32 s2;
+	bool bi_directional;
 	u16 transaction;
 	u8 status;
 	u8 dhgroup_id;
@@ -312,6 +313,7 @@ static int nvme_auth_set_dhchap_reply_data(struct nvme_ctrl *ctrl,
 	data->dhvlen = cpu_to_le16(chap->host_key_len);
 	memcpy(data->rval, chap->response, chap->hash_len);
 	if (ctrl->ctrl_key) {
+		chap->bi_directional = true;
 		get_random_bytes(chap->c2, chap->hash_len);
 		data->cvalid = 1;
 		chap->s2 = nvme_auth_get_seqnum();
@@ -660,6 +662,7 @@ static void nvme_auth_reset_dhchap(struct nvme_dhchap_queue_context *chap)
 	chap->error = 0;
 	chap->s1 = 0;
 	chap->s2 = 0;
+	chap->bi_directional = false;
 	chap->transaction = 0;
 	memset(chap->c1, 0, sizeof(chap->c1));
 	memset(chap->c2, 0, sizeof(chap->c2));
@@ -822,7 +825,7 @@ static void nvme_queue_auth_work(struct work_struct *work)
 		goto fail2;
 	}
 
-	if (chap->s2) {
+	if (chap->bi_directional) {
 		/* DH-HMAC-CHAP Step 5: send success2 */
 		dev_dbg(ctrl->device, "%s: qid %d send success2\n",
 			__func__, chap->qid);
-- 
2.39.2

