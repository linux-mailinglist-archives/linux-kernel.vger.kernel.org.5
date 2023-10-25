Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8AB7D6982
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbjJYKvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYKvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:51:44 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C25AC
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 03:51:41 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 95331240106
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 12:51:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1698231098; bh=jTnT/chsOtzfuw6NmZuyV4Fm9a93YfuqFYlLWZRZY3Q=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=fzzKsHIsQKX/JSmLFfIJeoRn8YWtpU7rmdb4t43E50CthymzErREjllwxUr7GDapJ
         L1O5yv8kPfS1KCMDdfvOLNeCmiYnabQ69zM3uHpF2MAxMPWO4/KGmBMcV08n1z6c1H
         E5CytkHMvHIXBBiq8eu5zExYkJZsciwAczgZsCfe6ccS2yxeJE4iLJ+JtxqeDvWJYB
         LLGOJPQxXHl7IIbY5bR+/PuwpQ/W2CMfm29BnkgfnPgJ0H6Raib5xTAxommQpy7H2u
         yY6bTq1sCK2iGyUf57eP9v0XYKBdXUqj3qdJsUEBwLLvfBWejwR+29PKdyGb6/N902
         9jfmsaRsqLZfA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4SFm2J70n8z9rxH;
        Wed, 25 Oct 2023 12:51:36 +0200 (CEST)
From:   Mark O'Donovan <shiftee@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, kbusch@kernel.org, hare@suse.de,
        Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH v3 1/3] nvme-auth: auth success1 msg always includes resp
Date:   Wed, 25 Oct 2023 10:51:23 +0000
Message-Id: <20231025105125.134443-2-shiftee@posteo.net>
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

In cases where RVALID is false, the response is still transmitted,
but is cleared to zero.

Relevant extract from the spec:
Response R2, if valid (i.e., if the RVALID field is set to 01h),
cleared to 0h otherwise

Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>

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

