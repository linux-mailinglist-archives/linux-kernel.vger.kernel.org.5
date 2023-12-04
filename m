Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304DF80401F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbjLDUiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbjLDUhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:37:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFD01FDA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:35:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B31C43397;
        Mon,  4 Dec 2023 20:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701722147;
        bh=Vg2WRlecHzYl6Wy/s/Zl7StswlBpuuA/P7jhlpQlIQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TWp698Y9Iyn/iV/Wqo4mheli1mqSaWTPjsdstMgGcd8ky/e5uWULnPJPRrdq8lNNx
         fpqrTfwxKMHf1vGrykMERe5aksOfMsvlE6CWBYGH22MJzo29F6nixd2FGCjvxwvqJU
         TlPADF04BrV0cvPqCClAeIfomzQd5VkId2YwuT+XzqOLAr66LzEmmOU9HqJ8Puf08S
         Hrtw/lRAoEL3yOZZJrwixE/y9625Eyg+0eNYnHmHyAwktz8Hrj02Wk9Vv6Ev5xsZEv
         8WzZts6kkIdyr4AiuaFk9VzAoah1H1stfxk5RAIA6RpJgLGl9RNCCVn0F+uwgzcQcX
         TiUZ2oWiHmICA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Maurizio Lombardi <mlombard@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Keith Busch <kbusch@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 12/17] nvme-core: fix a memory leak in nvme_ns_info_from_identify()
Date:   Mon,  4 Dec 2023 15:34:57 -0500
Message-ID: <20231204203514.2093855-12-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203514.2093855-1-sashal@kernel.org>
References: <20231204203514.2093855-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.65
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maurizio Lombardi <mlombard@redhat.com>

[ Upstream commit e3139cef8257fcab1725441e2fd5fd0ccb5481b1 ]

In case of error, free the nvme_id_ns structure that was allocated
by nvme_identify_ns().

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 25ddfabc58f73..0590c0b81fca9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1511,7 +1511,8 @@ static int nvme_ns_info_from_identify(struct nvme_ctrl *ctrl,
 	if (id->ncap == 0) {
 		/* namespace not allocated or attached */
 		info->is_removed = true;
-		return -ENODEV;
+		ret = -ENODEV;
+		goto error;
 	}
 
 	info->anagrpid = id->anagrpid;
@@ -1529,8 +1530,10 @@ static int nvme_ns_info_from_identify(struct nvme_ctrl *ctrl,
 		    !memchr_inv(ids->nguid, 0, sizeof(ids->nguid)))
 			memcpy(ids->nguid, id->nguid, sizeof(ids->nguid));
 	}
+
+error:
 	kfree(id);
-	return 0;
+	return ret;
 }
 
 static int nvme_ns_info_from_id_cs_indep(struct nvme_ctrl *ctrl,
-- 
2.42.0

