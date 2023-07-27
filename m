Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCE376556F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 15:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbjG0N6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 09:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjG0N6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 09:58:14 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F02E64
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 06:58:10 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id A5237240104
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 15:58:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1690466287; bh=AQUkhOUuCll+t4Bc33a3LEsUOgQSYv/ROCYEwaxRzJg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=WKTdjewtQYewNsFbPNhts/D5Lcwq2i5C5lR00wPqQqI1BmHAYrpoeamviQ+DEPKpo
         1lPGZ1JTnwMrUxT1UvKfSY+QxicKoDMU3IHFWSChTp7Fnxt32M9lBdmhwKs1Z2M5x0
         PrEA5QFX+NQGA90Z1Xg5hdce5jbI4M5qxYLo83S5Mzdb9k8eQhQIT001LVMrBf1FiY
         UMeNcGJ9FYb4RB37GzRxv6/mgtCZwd0cy/rmDz/y/6aTLhqaHIK/gNLHr7QbLwTa+L
         L5IbASTn2m8rCrxuLPJaddU59y6PuK3CvaKCBqEugcLRI5794sRzHxKmnEUDi+b6+h
         Wp+SvSxEaldVw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4RBXR15gqpz6tsb;
        Thu, 27 Jul 2023 15:58:05 +0200 (CEST)
From:   Mark O'Donovan <shiftee@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, kbusch@kernel.org, hare@suse.de,
        Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH 1/2] nvme-auth: unlock mutex in one place only
Date:   Thu, 27 Jul 2023 13:47:47 +0000
Message-Id: <20230727134748.4163796-1-shiftee@posteo.net>
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

Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
---
 drivers/nvme/host/auth.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index daf5d144a8ea..e1a98647c3a2 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -758,12 +758,11 @@ static void nvme_queue_auth_work(struct work_struct *work)
 		__func__, chap->qid);
 	mutex_lock(&ctrl->dhchap_auth_mutex);
 	ret = nvme_auth_dhchap_setup_host_response(ctrl, chap);
+	mutex_unlock(&ctrl->dhchap_auth_mutex);
 	if (ret) {
-		mutex_unlock(&ctrl->dhchap_auth_mutex);
 		chap->error = ret;
 		goto fail2;
 	}
-	mutex_unlock(&ctrl->dhchap_auth_mutex);
 
 	/* DH-HMAC-CHAP Step 3: send reply */
 	dev_dbg(ctrl->device, "%s: qid %d send reply\n",
-- 
2.39.2

