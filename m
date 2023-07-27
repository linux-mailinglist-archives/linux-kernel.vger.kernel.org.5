Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9711476556E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 15:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbjG0N6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 09:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjG0N6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 09:58:14 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E41E62
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 06:58:10 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 85662240101
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 15:58:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1690466288; bh=wuGCYUOgNBYqBLJZagw6Q9jgYZ2fW49Hn985P9qL1/U=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=b/P7e0fUhM8lxcyY1nCPo6RL3aYe0Xd4s8qUtZonsbL/K2JxiUxyWrp0iKDDA4ozw
         6ylTysHxfa/aM3cjW+Seh+B3TLT32VbgEtlZEHCEtqwTztNGCJzkXRSVg0iHVQGkQp
         /1OipYVyiYtVVOR1frMEIq06XdL+lqHfXDJhnP2wneuFho5mYo40ohe2k0YStF/Pee
         A1N0zVb5NuH/HtcKWe2B+7YUW63Tg34HFRbSLSJIu8yILlyCJ54A2epLduz5rOOLVT
         9tj0e5ZpetiiiBeJ+IEDmyr6eHR4+id3ExmWuEY/DTUslqdGtHg+3A/TMr0XD6yCvY
         H7Ud2fQxKu5Ig==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4RBXR31sK4z6txb;
        Thu, 27 Jul 2023 15:58:07 +0200 (CEST)
From:   Mark O'Donovan <shiftee@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, kbusch@kernel.org, hare@suse.de,
        Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH 2/2] nvme-auth: set explanation code for failure2 msgs
Date:   Thu, 27 Jul 2023 13:47:48 +0000
Message-Id: <20230727134748.4163796-2-shiftee@posteo.net>
In-Reply-To: <20230727134748.4163796-1-shiftee@posteo.net>
References: <20230727134748.4163796-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These error cases were not setting an auth-failure-reason-code-explanation.
This means an AUTH_Failure2 message will be sent with an explanation value
of 0 which is a reserved value.

Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
---
 drivers/nvme/host/auth.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index e1a98647c3a2..094f37e11921 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -760,6 +760,7 @@ static void nvme_queue_auth_work(struct work_struct *work)
 	ret = nvme_auth_dhchap_setup_host_response(ctrl, chap);
 	mutex_unlock(&ctrl->dhchap_auth_mutex);
 	if (ret) {
+		chap->status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
 		chap->error = ret;
 		goto fail2;
 	}
@@ -776,6 +777,7 @@ static void nvme_queue_auth_work(struct work_struct *work)
 	tl = ret;
 	ret = nvme_auth_submit(ctrl, chap->qid, chap->buf, tl, true);
 	if (ret) {
+		chap->status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
 		chap->error = ret;
 		goto fail2;
 	}
@@ -811,6 +813,7 @@ static void nvme_queue_auth_work(struct work_struct *work)
 		ret = nvme_auth_dhchap_setup_ctrl_response(ctrl, chap);
 		if (ret) {
 			mutex_unlock(&ctrl->dhchap_auth_mutex);
+			chap->status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
 			chap->error = ret;
 			goto fail2;
 		}
@@ -830,8 +833,10 @@ static void nvme_queue_auth_work(struct work_struct *work)
 			__func__, chap->qid);
 		tl = nvme_auth_set_dhchap_success2_data(ctrl, chap);
 		ret = nvme_auth_submit(ctrl, chap->qid, chap->buf, tl, true);
-		if (ret)
+		if (ret) {
+			chap->status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
 			chap->error = ret;
+		}
 	}
 	if (!ret) {
 		chap->error = 0;
-- 
2.39.2

