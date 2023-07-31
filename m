Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6140D769A42
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbjGaPAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjGaPAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:00:45 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A863A120
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 08:00:41 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 57E70240101
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 17:00:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1690815638; bh=IvLmPEmw9kMuEQzvbUm2FqmKdi2Hp7a+u6Dag9e2cQM=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=b2rJAhH7XN+U2h1IPMof9q8aYTETIZR8JWHE47jm5imuVvyCscpcIfhTAfCKl5heH
         scCYFDGhWc9xmvUBdulpsNHCSSwapO94odN/aORyNToc3hk8bXYd4Kujr+ZWyUxCnc
         UqUszWhAL/4pPS08fWp3At5vYzgqmzhCtEU3vmFUP0wHd6Tabvhg6axLykF7OY3cNq
         EIvvioF2ivlt26z7jerets5aHY1V+ONjaxeIMQ9DmmwFH7a5fQ6viHKnNsw34NdZma
         sTzD8Iw7V+qbptsC9wuDGeNYXSp3flcTtgK7pfEXtwVS7yFfXGTCGlV9NH+g3d/56Y
         SOoT1hEJgpv6Q==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4RF1dK2GsRz9sDs;
        Mon, 31 Jul 2023 17:00:37 +0200 (CEST)
From:   Mark O'Donovan <shiftee@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, axboe@kernel.dk, kbusch@kernel.org,
        hare@suse.de, Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH v2 2/2] nvme-auth: set explanation code for failure2 msgs
Date:   Mon, 31 Jul 2023 14:51:06 +0000
Message-Id: <20230731145106.917526-2-shiftee@posteo.net>
In-Reply-To: <20230731145106.917526-1-shiftee@posteo.net>
References: <20230731145106.917526-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some error cases were not setting an auth-failure-reason-code-explanation.
This means an AUTH_Failure2 message will be sent with an explanation value
of 0 which is a reserved value.

Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
---
v1->v2: Set failure explanation in a single place if the error handling
code has not already done so.

 drivers/nvme/host/auth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index e1a98647c3a2..9556cfc4f5f3 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -839,6 +839,8 @@ static void nvme_queue_auth_work(struct work_struct *work)
 	}
 
 fail2:
+	if (chap->status == 0)
+		chap->status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
 	dev_dbg(ctrl->device, "%s: qid %d send failure2, status %x\n",
 		__func__, chap->qid, chap->status);
 	tl = nvme_auth_set_dhchap_failure2_data(ctrl, chap);
-- 
2.39.2

