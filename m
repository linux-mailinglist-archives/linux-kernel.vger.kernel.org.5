Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34D77D38B7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjJWOAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjJWOAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:00:18 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1710D73
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:00:16 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 609DC240029
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 16:00:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1698069615; bh=Fig6sNGtNPtLEqdibiKwrPwhe4ldPvHG+L+Zwf6xQc0=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=qpGm7DQ7F5jjomuPr+/Fq4TA4UceNKtt5zNG8KACUt/gWWCQh5ca7oRofj833f3ns
         1HcLzNJTLA36h4OiLeGfZrMxFSS1JrGY/EM4Hom0Y93KKvUANBnV+B8AlZYG0/Nyq7
         R6bAdpqL6ZfKMCbQhsj3RUkaFR6M/q+B/lKgFElW/AkZ/W6uPvp/CA1BGxG9hpLfpG
         c2JHS8QGRKILvD5891iRTr37j8dE0OoihV0den5o1fu1xVbBpZ2RGG1GeFzRiI3p2m
         5s1cg8cGfKOKfCh2mke5k0YJ6cMdeawc8rq3XHZc55qgeoqU6ExdQ4OJOA9uJALo/7
         BA+8zCZTEQ2Iw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4SDcJt0HvNz6tsB;
        Mon, 23 Oct 2023 16:00:13 +0200 (CEST)
From:   Mark O'Donovan <shiftee@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, kbusch@kernel.org, hare@suse.de,
        Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH v2 1/3] nvme-auth: auth success1 msg always includes resp
Date:   Mon, 23 Oct 2023 14:00:01 +0000
Message-Id: <20231023140003.58019-2-shiftee@posteo.net>
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

In cases where RVALID is false, the response is still transmitted,
but is cleared to zero.

Relevant extract from the spec:
Response R2, if valid (i.e., if the RVALID field is set to 01h),
cleared to 0h otherwise

Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

---
v1: used incorrect prefix nvme-tcp
v2: rebase on latest git

 drivers/nvme/host/auth.c | 5 +----
 include/linux/nvme.h     | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 064592a5d546..e0fc33d41baa 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -339,10 +339,7 @@ static int nvme_auth_process_dhchap_success1(struct nvme_ctrl *ctrl,
 		struct nvme_dhchap_queue_context *chap)
 {
 	struct nvmf_auth_dhchap_success1_data *data = chap->buf;
-	size_t size = sizeof(*data);
-
-	if (chap->s2)
-		size += chap->hash_len;
+	size_t size = sizeof(*data) + chap->hash_len;
 
 	if (size > CHAP_BUF_SIZE) {
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 26dd3f859d9d..8d8df9c15b74 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1722,7 +1722,7 @@ struct nvmf_auth_dhchap_success1_data {
 	__u8		rsvd2;
 	__u8		rvalid;
 	__u8		rsvd3[7];
-	/* 'hl' bytes of response value if 'rvalid' is set */
+	/* 'hl' bytes of response value */
 	__u8		rval[];
 };
 
-- 
2.39.2

