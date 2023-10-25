Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14E27D6983
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbjJYKv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbjJYKvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:51:44 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3644EC1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 03:51:42 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id D0E65240028
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 12:51:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1698231100; bh=YFBxTR0zvXLVBvSBdoAtunK27N4nE0w7KBv3zsHx+dg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=G8WLzTYnOQwb7L+Iv+qxQD7cF8gI3zQa/zQtvHCVopa5UOWp9r25c4qNwV1PCbo6t
         xLPFuZbjtcV+DZYqzuoigK6kvE1K3DF1aijVZw1lTMMKj1ws4eCl47jJo0wBaCiiyG
         XG2tgjwqvWJAEi2Aakg/8T2gYwmycF/AXHn9mVOM+8VQANW1zUWNG6WTGegs8JaWl5
         ZwpM8jY69Uyy8BJFSmF51482P7BrruWNJPx9HY1RFqEshKuwrCRnAtSCt1c3kWEDDr
         GRrbhRcKeeAXyso/8YSJlhraX2gHHivkvZxhXOrb3eTzKWferG+Am/ZcchZz4dMbPb
         IsZ5TbDbFYsEA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4SFm2M3kRBz9rxL;
        Wed, 25 Oct 2023 12:51:39 +0200 (CEST)
From:   Mark O'Donovan <shiftee@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, kbusch@kernel.org, hare@suse.de,
        Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH v3 3/3] nvme-auth: always set valid seq_num in dhchap reply
Date:   Wed, 25 Oct 2023 10:51:25 +0000
Message-Id: <20231025105125.134443-4-shiftee@posteo.net>
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

Currently a seqnum of zero is sent during uni-directional
authentication. The zero value is reserved for the secure channel
feature which is not yet implemented.

Relevant extract from the spec:
The value 0h is used to indicate that bidirectional authentication
is not performed, but a challenge value C2 is carried in order to
generate a pre-shared key (PSK) for subsequent establishment of a
secure channel

Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
Reviewed-by: Christoph Hellwig <hch@lst.de>

---
v1: used incorrect prefix nvme-tcp
v2: added spec extract to commit message
v3: read the seq-num in nvme-target code

 drivers/nvme/host/auth.c               | 3 +--
 drivers/nvme/target/fabrics-cmd-auth.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 8558a02865ac..7f6b2e99a78c 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -316,15 +316,14 @@ static int nvme_auth_set_dhchap_reply_data(struct nvme_ctrl *ctrl,
 		chap->bi_directional = true;
 		get_random_bytes(chap->c2, chap->hash_len);
 		data->cvalid = 1;
-		chap->s2 = nvme_auth_get_seqnum();
 		memcpy(data->rval + chap->hash_len, chap->c2,
 		       chap->hash_len);
 		dev_dbg(ctrl->device, "%s: qid %d ctrl challenge %*ph\n",
 			__func__, chap->qid, (int)chap->hash_len, chap->c2);
 	} else {
 		memset(chap->c2, 0, chap->hash_len);
-		chap->s2 = 0;
 	}
+	chap->s2 = nvme_auth_get_seqnum();
 	data->seqnum = cpu_to_le32(chap->s2);
 	if (chap->host_key_len) {
 		dev_dbg(ctrl->device, "%s: qid %d host public key %*ph\n",
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 1d9854484e2e..eb7785be0ca7 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -163,11 +163,11 @@ static u16 nvmet_auth_reply(struct nvmet_req *req, void *d)
 		pr_debug("%s: ctrl %d qid %d challenge %*ph\n",
 			 __func__, ctrl->cntlid, req->sq->qid, data->hl,
 			 req->sq->dhchap_c2);
-		req->sq->dhchap_s2 = le32_to_cpu(data->seqnum);
 	} else {
 		req->sq->authenticated = true;
 		req->sq->dhchap_c2 = NULL;
 	}
+	req->sq->dhchap_s2 = le32_to_cpu(data->seqnum);
 
 	return 0;
 }
-- 
2.39.2

