Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E29F7AC903
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjIXNVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjIXNVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:21:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21229FC;
        Sun, 24 Sep 2023 06:18:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1848C433CB;
        Sun, 24 Sep 2023 13:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561530;
        bh=vvF025XyAxaA1yeakCzrsqP9L10bHmrvpAdW0XLXiCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g9j54teUJEcG9qKLPwMjTsgLStleVtw5l1znmnQI1+hO4QUMy0tJHQcrsTkm4m6cw
         Ph8me49L6RLpivK1Pg76b/F/oDqVDAhHeKFkFhyAuKlfLzQKLoZaFkkEj5zmqzhJBd
         Cg3Uu+QM6eT3NWqK5fzw3aPZwD3KKcDq09H63JSXp8Ixz+FK9De5i3WbYLpHupZl21
         gTiYxOOOgb36LkXbRlTXM0ZAXjGdumopWg0UacY28Jp2oQY8qglNvKGM5RnwH1EMWP
         431ZSthEn14DCgGHa131DOLrr07SyJ4yNikKTzGWFSac19dHtlCalbWDVOfQfi51hQ
         zbLHk759wv5qg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michal Grzedzicki <mge@meta.com>, Jack Wang <jinpu.wang@ionos.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, jinpu.wang@cloud.ionos.com,
        jejb@linux.ibm.com, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 25/28] scsi: pm80xx: Use phy-specific SAS address when sending PHY_START command
Date:   Sun, 24 Sep 2023 09:17:42 -0400
Message-Id: <20230924131745.1275960-25-sashal@kernel.org>
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

From: Michal Grzedzicki <mge@meta.com>

[ Upstream commit 71996bb835aed58c7ec4967be1d05190a27339ec ]

Some cards have more than one SAS address. Using an incorrect address
causes communication issues with some devices like expanders.

Closes: https://lore.kernel.org/linux-kernel/A57AEA84-5CA0-403E-8053-106033C73C70@fb.com/
Signed-off-by: Michal Grzedzicki <mge@meta.com>
Link: https://lore.kernel.org/r/20230913155611.3183612-1-mge@meta.com
Acked-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/pm8001/pm8001_hwi.c | 2 +-
 drivers/scsi/pm8001/pm80xx_hwi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index 628b08ba6770b..e2c52c2d00b33 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -4313,7 +4313,7 @@ pm8001_chip_phy_start_req(struct pm8001_hba_info *pm8001_ha, u8 phy_id)
 	payload.sas_identify.dev_type = SAS_END_DEVICE;
 	payload.sas_identify.initiator_bits = SAS_PROTOCOL_ALL;
 	memcpy(payload.sas_identify.sas_addr,
-		pm8001_ha->sas_addr, SAS_ADDR_SIZE);
+		&pm8001_ha->phy[phy_id].dev_sas_addr, SAS_ADDR_SIZE);
 	payload.sas_identify.phy_id = phy_id;
 
 	return pm8001_mpi_build_cmd(pm8001_ha, 0, opcode, &payload,
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index f8b8624458f73..bcccea7c1244a 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -4803,7 +4803,7 @@ pm80xx_chip_phy_start_req(struct pm8001_hba_info *pm8001_ha, u8 phy_id)
 	payload.sas_identify.dev_type = SAS_END_DEVICE;
 	payload.sas_identify.initiator_bits = SAS_PROTOCOL_ALL;
 	memcpy(payload.sas_identify.sas_addr,
-	  &pm8001_ha->sas_addr, SAS_ADDR_SIZE);
+		&pm8001_ha->phy[phy_id].dev_sas_addr, SAS_ADDR_SIZE);
 	payload.sas_identify.phy_id = phy_id;
 
 	return pm8001_mpi_build_cmd(pm8001_ha, 0, opcode, &payload,
-- 
2.40.1

