Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36347AC8BC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjIXNTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjIXNS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:18:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13636CEF;
        Sun, 24 Sep 2023 06:17:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1147C433C8;
        Sun, 24 Sep 2023 13:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561458;
        bh=cMW5zTy6aNyHx2Y7UtVwoul7q2Uj2VRha8J787j6oeY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rhwn1BifCClfL0bMkzugPMK9OnszZLovQZ2CsrnpqmFFRfVaqfew4NcjxmRcHwZSc
         MNXmWjn3kl3vEbk2jch2Iok/aFh3ZdbjmgP2k8LM9uFYDabgXKAeXG6pK9nVtSJl1P
         yDagSM/YXBqVFeHQp2Koe3/iXp20CGZTR9fXNoYopIaUZb9IjSviooj85aBDoFlEmB
         EUbf3MlWl8eoZBeyk8iiMIQfoN/zx5ZFr27Ekb5bm2CQKs7gCySg3zzf0TxZgPUSb4
         KPJnD5PZkNKERTmN25O2oiQ2y6xLx/Jyd43xTzggGB6Ell5nrUfBQgJkVuAX5gc86a
         F5x+n3VWtxUag==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michal Grzedzicki <mge@meta.com>, Jack Wang <jinpu.wang@ionos.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, jinpu.wang@cloud.ionos.com,
        jejb@linux.ibm.com, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 38/41] scsi: pm80xx: Avoid leaking tags when processing OPC_INB_SET_CONTROLLER_CONFIG command
Date:   Sun, 24 Sep 2023 09:15:26 -0400
Message-Id: <20230924131529.1275335-38-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131529.1275335-1-sashal@kernel.org>
References: <20230924131529.1275335-1-sashal@kernel.org>
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

From: Michal Grzedzicki <mge@meta.com>

[ Upstream commit c13e7331745852d0dd7c35eabbe181cbd5b01172 ]

Tags allocated for OPC_INB_SET_CONTROLLER_CONFIG command need to be freed
when we receive the response.

Signed-off-by: Michal Grzedzicki <mge@meta.com>
Link: https://lore.kernel.org/r/20230911170340.699533-2-mge@meta.com
Acked-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/pm8001/pm80xx_hwi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index 9689fb830a5fb..e543bc36c84df 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -3671,10 +3671,12 @@ static int mpi_set_controller_config_resp(struct pm8001_hba_info *pm8001_ha,
 			(struct set_ctrl_cfg_resp *)(piomb + 4);
 	u32 status = le32_to_cpu(pPayload->status);
 	u32 err_qlfr_pgcd = le32_to_cpu(pPayload->err_qlfr_pgcd);
+	u32 tag = le32_to_cpu(pPayload->tag);
 
 	pm8001_dbg(pm8001_ha, MSG,
 		   "SET CONTROLLER RESP: status 0x%x qlfr_pgcd 0x%x\n",
 		   status, err_qlfr_pgcd);
+	pm8001_tag_free(pm8001_ha, tag);
 
 	return 0;
 }
-- 
2.40.1

