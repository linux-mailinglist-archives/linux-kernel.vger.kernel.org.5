Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DF17D38BA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjJWOAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjJWOAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:00:21 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5DFD78
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:00:18 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id CCC40240104
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 16:00:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1698069616; bh=0vrbnyHS0xkur/iRrIzIOiA16As3+vBu5X3xM21fRts=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=Jp4DwJ0n/3HJyx1M1Cy4sqSqnwAeHCRGXdighjLLYWiMVt2CW01aYRTixUJYKY85s
         beLaZwHZRUJmncMUIpKY527kFUCsBa3Zg1dmjMHrLYzUnLd+wh0peRc13tTrbmRomV
         1iacZUce7jT2Bmjq7JDv+H+578cTqy9SWs2FIT7V9+KK3DGX9BAITFsmK2hxr9xrXL
         5zP6GFxRgdUmvlKoS+y9aee8pDZ9Nz4ySMvWKKN4ELGwQhZ0jvnL+M/cpHADRboeTM
         PJ5KbxdUHz4xJ0ugSYeds2sycm84Y11kcs3SDij0gIt/d10JgRH71Yz2bQfW4vxMhl
         46Mr0pEXMJHAw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4SDcJv279xz6txG;
        Mon, 23 Oct 2023 16:00:15 +0200 (CEST)
From:   Mark O'Donovan <shiftee@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, kbusch@kernel.org, hare@suse.de,
        Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH v2 2/3] nvme-auth: add flag for bi-directional auth
Date:   Mon, 23 Oct 2023 14:00:02 +0000
Message-Id: <20231023140003.58019-3-shiftee@posteo.net>
In-Reply-To: <20231023140003.58019-1-shiftee@posteo.net>
References: <20231023140003.58019-1-shiftee@posteo.net>
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

