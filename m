Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F437AC947
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjIXN3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjIXN3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:29:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A483C07;
        Sun, 24 Sep 2023 06:19:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F12C43391;
        Sun, 24 Sep 2023 13:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561552;
        bh=k/Dudfj2dCzdKgm5lxdRhsSh5iXATRaanZEV504qKT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fP8fsZji5pQc63HA204X18/B2GcwP49e2Vf82dEkH9Ebj6JMYXJIOykB/qSAsS58F
         8jECR8dbWUy0Vf7RW2Rp6p0gQ57bTXuYH6lvBtN4AEax13ZN77k0TdU7bPfZC/8Lz3
         HcOXAtEiDfW/36+0j8odfbaqw+cEhrqKdUw+w7fHGM3+GXdsoSY1O4xC0ubN4RW9Ch
         2hkYezJerbWR/QxzPqMRiDNPdI242r+AP8HKz9sIqM9ASlu5UbQUeNAHgt/hft2XHk
         u9zBErNg64Il8bC8v81pmsi20cDfqT1F3OR28o8LqikY2WgnEHMHPMZ07rnHfaAa9M
         ODXxyRpyOR2eA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kiwoong Kim <kwmad.kim@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Chanwoo Lee <cw9316.lee@samsung.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 06/18] scsi: ufs: core: Move __ufshcd_send_uic_cmd() outside host_lock
Date:   Sun, 24 Sep 2023 09:18:43 -0400
Message-Id: <20230924131857.1276330-6-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131857.1276330-1-sashal@kernel.org>
References: <20230924131857.1276330-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.133
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

From: Kiwoong Kim <kwmad.kim@samsung.com>

[ Upstream commit 2d3f59cf868b4a2dd678a96cd49bdd91411bd59f ]

__ufshcd_send_uic_cmd() is wrapped by uic_cmd_mutex and its related
contexts are accessed within the section wrapped by uic_cmd_mutex. Thus,
wrapping with host_lock is redundant.

Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>
Link: https://lore.kernel.org/r/782ba5f26f0a96e58d85dff50751787d2d2a6b2b.1693790060.git.kwmad.kim@samsung.com
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Chanwoo Lee <cw9316.lee@samsung.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ufs/ufshcd.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index d00d263705e15..f48036f09eab5 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -2309,7 +2309,6 @@ __ufshcd_send_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd,
 		      bool completion)
 {
 	lockdep_assert_held(&hba->uic_cmd_mutex);
-	lockdep_assert_held(hba->host->host_lock);
 
 	if (!ufshcd_ready_for_uic_cmd(hba)) {
 		dev_err(hba->dev,
@@ -2336,15 +2335,12 @@ __ufshcd_send_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd,
 int ufshcd_send_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd)
 {
 	int ret;
-	unsigned long flags;
 
 	ufshcd_hold(hba, false);
 	mutex_lock(&hba->uic_cmd_mutex);
 	ufshcd_add_delay_before_dme_cmd(hba);
 
-	spin_lock_irqsave(hba->host->host_lock, flags);
 	ret = __ufshcd_send_uic_cmd(hba, uic_cmd, true);
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
 	if (!ret)
 		ret = ufshcd_wait_for_uic_cmd(hba, uic_cmd);
 
@@ -3967,8 +3963,8 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
 		wmb();
 		reenable_intr = true;
 	}
-	ret = __ufshcd_send_uic_cmd(hba, cmd, false);
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
+	ret = __ufshcd_send_uic_cmd(hba, cmd, false);
 	if (ret) {
 		dev_err(hba->dev,
 			"pwr ctrl cmd 0x%x with mode 0x%x uic error %d\n",
-- 
2.40.1

