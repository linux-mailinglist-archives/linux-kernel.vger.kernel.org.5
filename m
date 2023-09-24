Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CD27AC83C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjIXNPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXNPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:15:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2FDFC;
        Sun, 24 Sep 2023 06:15:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA03DC433C8;
        Sun, 24 Sep 2023 13:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561332;
        bh=aymlam7ACzIinEbCzC1waHwHwJM/KoAe8yLW9ndF/G4=;
        h=From:To:Cc:Subject:Date:From;
        b=vI5MxRlJRZ8OTAimgC8jsYEzXDWCTWALsVY3jQfOM+XjoN9AfFW7Gb1vGGJ2/oziH
         RuvfO16zIFE5fMae5CJMeUWqjMKGrGCe0NfHzz+gYW2FCH+DVKlAaAw8EfpmE1ZwbY
         ox+64o85THgDIZnU5DeYd/WypUiy3/yeBELyTgCUZVdkMxjoyaoSpb36HOkw4F1xXf
         MXv9575m4glhPDF2LyoX79MIYx28C7ii6yup3L+Sso6D02Xl3g+afLZk9lYsyyCdu6
         h+NTwWXW6LvCHqWvx9eSKM0q5T6H6g3MaYPO2UyEiCfiGyURvWF8yeYkT8cvchbdY8
         c9jwFZxeOhVrg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nigel Kirkland <nkirkland2304@gmail.com>,
        James Smart <jsmart2021@gmail.com>,
        Keith Busch <kbusch@kernel.org>,
        Sasha Levin <sashal@kernel.org>, james.smart@broadcom.com,
        sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.5 01/41] nvme-fc: Prevent null pointer dereference in nvme_fc_io_getuuid()
Date:   Sun, 24 Sep 2023 09:14:49 -0400
Message-Id: <20230924131529.1275335-1-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nigel Kirkland <nkirkland2304@gmail.com>

[ Upstream commit 8ae5b3a685dc59a8cf7ccfe0e850999ba9727a3c ]

The nvme_fc_fcp_op structure describing an AEN operation is initialized with a
null request structure pointer. An FC LLDD may make a call to
nvme_fc_io_getuuid passing a pointer to an nvmefc_fcp_req for an AEN operation.

Add validation of the request structure pointer before dereference.

Signed-off-by: Nigel Kirkland <nkirkland2304@gmail.com>
Reviewed-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 1cd2bf82319a9..a15b37750d6e9 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1924,7 +1924,7 @@ char *nvme_fc_io_getuuid(struct nvmefc_fcp_req *req)
 	struct nvme_fc_fcp_op *op = fcp_req_to_fcp_op(req);
 	struct request *rq = op->rq;
 
-	if (!IS_ENABLED(CONFIG_BLK_CGROUP_FC_APPID) || !rq->bio)
+	if (!IS_ENABLED(CONFIG_BLK_CGROUP_FC_APPID) || !rq || !rq->bio)
 		return NULL;
 	return blkcg_get_fc_appid(rq->bio);
 }
-- 
2.40.1

