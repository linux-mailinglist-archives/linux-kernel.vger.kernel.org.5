Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764987FC845
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376432AbjK1VKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346892AbjK1VJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:09:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A93F8F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:08:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AE2C433B9;
        Tue, 28 Nov 2023 21:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701205691;
        bh=ou5g1vYpCVBpRbsuoAPA3/wFNIfrgr0OMicmp/bNh8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q+bavc+nSrWU+EdUaCtphpTgDYhVaFsC3RNm2dsUW4FcWgcGcZYhghz8DhjkkfNpK
         gMtFPhZGCDO6kg1NGazqsh6LIuWJeBr+z42yT7r7OutNUCKF2aqXRIjfsMYsk0iaED
         sQJAolt7KpM8xR016mXF6nz55ismspOQp00v4jmjE8D/NxaqHeMVUxxbLyEWVXPTAj
         yWtueMO1/Ep5e5dD7CCI8wQ+4xBnzVud49qXWo0tQV/1UEv+l51pLiFogTNApgkNtm
         CRNQjaJ5CizOOEn1giZ+5+9ig+22luoEeua+fJqPf5tnZPExD6c/mYCD+rU2FUcdM8
         hmNH+3BHYdHFw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mark O'Donovan <shiftee@posteo.net>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        Keith Busch <kbusch@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 11/25] nvme-auth: unlock mutex in one place only
Date:   Tue, 28 Nov 2023 16:07:27 -0500
Message-ID: <20231128210750.875945-11-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210750.875945-1-sashal@kernel.org>
References: <20231128210750.875945-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.64
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
 drivers/nvme/host/auth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 9dfd3d0293054..7c9dfb420c464 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -758,6 +758,7 @@ static void nvme_queue_auth_work(struct work_struct *work)
 	dev_dbg(ctrl->device, "%s: qid %d host response\n",
 		__func__, chap->qid);
 	ret = nvme_auth_dhchap_setup_host_response(ctrl, chap);
+	mutex_unlock(&ctrl->dhchap_auth_mutex);
 	if (ret) {
 		chap->error = ret;
 		goto fail2;
-- 
2.42.0

