Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5DB7FC8B9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346700AbjK1VHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346641AbjK1VGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:06:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F8C1BD5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:06:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4328EC433C8;
        Tue, 28 Nov 2023 21:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701205602;
        bh=J2EZoT5nf42IyT+2nOUc2PQyHkSw27y/9C6HWxKjDDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bLW2QL62+GM3PzvPxGZoNIVOCBC0lNRTZXSjl2Cch+21OQvi+JGdD+qdc3FjUlyqr
         9qmWfapct6SO2YY1oY0e6WDUbKhMw1RdbTCYsRZhzqAA68GUxzfC+eSwim09l6RE0d
         O0a+efKl/VuB0u/CjbiTevq9g73bUSVA1+awSJPooBN6/XkUQMtfCxaUVkxhP5kg5H
         4vpGnfFqV3cRZfFdGBuKNVMEZTXwZHNGYSNdkd7NQD5SrsMczEdI9A/ZylPGnuRLtL
         1i4hdPcT6/b6+rN+YtpiT/Yt6AosYp2OM/9L+melhdYSJkhzE3PIUbOfQ1JJimh9hZ
         wkKB2LtvLMXKg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mark O'Donovan <shiftee@posteo.net>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        Keith Busch <kbusch@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 14/40] nvme-auth: unlock mutex in one place only
Date:   Tue, 28 Nov 2023 16:05:20 -0500
Message-ID: <20231128210615.875085-14-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210615.875085-1-sashal@kernel.org>
References: <20231128210615.875085-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.3
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

From: Mark O'Donovan <shiftee@posteo.net>

[ Upstream commit 616add70bfdc0274a253e84fc78155c27aacde91 ]

Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/auth.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 064592a5d546a..cc02a95a50c9a 100644
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
2.42.0

