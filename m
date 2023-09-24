Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678A77AC8DF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjIXNUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjIXNUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:20:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84B419A4;
        Sun, 24 Sep 2023 06:18:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF55C433CA;
        Sun, 24 Sep 2023 13:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561489;
        bh=QxZnc8EzRFkcg+u+gKSUpUbfO1/xf4un7IulmUfC7Lc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y4N2wLJLWmgaVRpzPzMCHgZElDzU92BYsLbAF/oQ2v+2oh9B4Ec0CLPo26YbPcD5Q
         O4We3LVBKuAewbMieMadLGGkIA5yjdVoiE6adKwIzBlvNzmws/N9/zeCBllUEUkEIp
         FjxQ9gJroU6RiUhjJemFdIschAMB0lk43WmaGrHkGYkTEXScocBkcSUgrpPD50R4i8
         luAGSkuFHFJTNKEHtzm+WeoqIakRvjgSbJCoq9tcJLIhupfh2Wd/cwmljX6Htq5Tar
         2Z3GYvT1uJXSHynzT3iNMEZF0fZ+F3Omgb4/2SbtQApIqWWrFLU1LD0VV8Bx/N1le1
         e1SPSBElBXubA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kiwoong Kim <kwmad.kim@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Chanwoo Lee <cw9316.lee@samsung.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, jejb@linux.ibm.com,
        bvanassche@acm.org, stanley.chu@mediatek.com,
        quic_cang@quicinc.com, beanhuo@micron.com,
        quic_asutoshd@quicinc.com, quic_nguyenb@quicinc.com,
        Arthur.Simchaev@wdc.com, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 08/28] scsi: ufs: core: Poll HCS.UCRDY before issuing a UIC command
Date:   Sun, 24 Sep 2023 09:17:25 -0400
Message-Id: <20230924131745.1275960-8-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131745.1275960-1-sashal@kernel.org>
References: <20230924131745.1275960-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.55
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

[ Upstream commit d32533d30e2119b0c0aa17596734f1f842f750df ]

With auto hibern8 enabled, UIC could be busy processing a hibern8 operation
and the HCI would reports UIC not ready for a short while through
HCS.UCRDY. The UFS driver doesn't currently handle this situation. The
UFSHCI spec specifies UCRDY like this: whether the host controller is ready
to process UIC COMMAND

The 'ready' could be seen as many different meanings. If the meaning
includes not processing any request from HCI, processing a hibern8
operation can be 'not ready'. In this situation, the driver needs to wait
until the operations is completed.

Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>
Link: https://lore.kernel.org/r/550484ffb66300bdcec63d3e304dfd55cb432f1f.1693790060.git.kwmad.kim@samsung.com
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Chanwoo Lee <cw9316.lee@samsung.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufshcd.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 135be6dd02523..b4e3f14b9a3d7 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sched/clock.h>
+#include <linux/iopoll.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_dbg.h>
 #include <scsi/scsi_driver.h>
@@ -2254,7 +2255,11 @@ static inline int ufshcd_hba_capabilities(struct ufs_hba *hba)
  */
 static inline bool ufshcd_ready_for_uic_cmd(struct ufs_hba *hba)
 {
-	return ufshcd_readl(hba, REG_CONTROLLER_STATUS) & UIC_COMMAND_READY;
+	u32 val;
+	int ret = read_poll_timeout(ufshcd_readl, val, val & UIC_COMMAND_READY,
+				    500, UIC_CMD_TIMEOUT * 1000, false, hba,
+				    REG_CONTROLLER_STATUS);
+	return ret == 0 ? true : false;
 }
 
 /**
-- 
2.40.1

