Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9E17D38B9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjJWOA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjJWOAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:00:21 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0D5D73
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:00:19 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id CB1E8240104
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 16:00:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1698069617; bh=zwCuyhVmMr+6W+Jc6uApqtn4VjGeJRlPp4FvHh/J5fE=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=U/K/JPNl04rAE19qY8DvRu5Br7MpMde5s1OJ5R3sxavfVW42n8At+nCx1j0iD0fVi
         4U/tn30rzk8OhC4sFUHEZWy+ZeeSauqtA7ctggg+9PFW+eH1uBLVI4fig4z0cubJTg
         niTI3XC2IfEO/WNXa5JmQyVLwe0Vtz/xe8NNNqDxSBctzymKUBeCZsbSjz05lano9w
         JpyHLkwzH2gs5Kn/0U6DAkzdQy4T4Rs75CHO1YUGZk2FuhbXJ2uF43iZf+Kr/XjWn2
         Rrr5q6Z712DILTvX2X8BmXz9Q9Uwcocj4B/M18P9FoDqPiA2bdO3P1xRzh/C5o8LX2
         L003NwS1i8arQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4SDcJw3V66z6tsB;
        Mon, 23 Oct 2023 16:00:16 +0200 (CEST)
From:   Mark O'Donovan <shiftee@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, kbusch@kernel.org, hare@suse.de,
        Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH v2 3/3] nvme-auth: always set valid seq_num in dhchap reply
Date:   Mon, 23 Oct 2023 14:00:03 +0000
Message-Id: <20231023140003.58019-4-shiftee@posteo.net>
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

Currently a seqnum of zero is sent during uni-directional
authentication. The zero value is reserved for the secure channel
feature which is not yet implemented.

Relevant extract from the spec:
The value 0h is used to indicate that bidirectional authentication
is not performed, but a challenge value C2 is carried in order to
generate a pre-shared key (PSK) for subsequent establishment of a
secure channel

Signed-off-by: Mark O'Donovan <shiftee@posteo.net>

---
v1: used incorrect prefix nvme-tcp
v2: added spec extract to commit message

 drivers/nvme/host/auth.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

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
-- 
2.39.2

