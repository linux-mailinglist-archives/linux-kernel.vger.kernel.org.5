Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E2D78C5D2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236194AbjH2NeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236249AbjH2Ndi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:33:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEC2CD3;
        Tue, 29 Aug 2023 06:33:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EF3962DB2;
        Tue, 29 Aug 2023 13:33:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B5FC433C8;
        Tue, 29 Aug 2023 13:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693316001;
        bh=2XBCnTdL++42AuoB1cN3zgLYSUQ7i1IlEPgTkcFQZes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XB7tBrTXAsv0hgKMObRdOdPUOYhJ256DVnGu9+RM0dMsLIoJUg9TP80i6K2V4xvSi
         TM5MXFTq7duZlCJ+x9c046oOmmRPPEBxinpylSLWlCBnJiMANU1EEDC2T7s5L2b4OZ
         b6Z+sp4yJlC6RWrlzEB+FawZI54s+o0pxc9v1tBZwazjBZ98nPevwDElWT7raiiqja
         eVhm9FBjwUUf2XrB5FNVu1Sqn5+6ps38kkEyKJV7fqBu5wlTHJk352qF1GazqsDsBw
         aDUo44Tzeak3VvawrEVcI/KM57Ocf93Cz9OnX6qp2vK8z5/Tc7p75No4eM4+KD4zsQ
         KPzAsabSsunpQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Christensen <drc@linux.vnet.ibm.com>,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, aelior@marvell.com,
        skalluru@marvell.com, manishc@marvell.com, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 2/9] bnx2x: fix page fault following EEH recovery
Date:   Tue, 29 Aug 2023 09:33:09 -0400
Message-Id: <20230829133316.520410-2-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230829133316.520410-1-sashal@kernel.org>
References: <20230829133316.520410-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.128
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Christensen <drc@linux.vnet.ibm.com>

[ Upstream commit 7ebe4eda4265642859507d1b3ca330d8c196cfe5 ]

In the last step of the EEH recovery process, the EEH driver calls into
bnx2x_io_resume() to re-initialize the NIC hardware via the function
bnx2x_nic_load().  If an error occurs during bnx2x_nic_load(), OS and
hardware resources are released and an error code is returned to the
caller.  When called from bnx2x_io_resume(), the return code is ignored
and the network interface is brought up unconditionally.  Later attempts
to send a packet via this interface result in a page fault due to a null
pointer reference.

This patch checks the return code of bnx2x_nic_load(), prints an error
message if necessary, and does not enable the interface.

Signed-off-by: David Christensen <drc@linux.vnet.ibm.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 553f3de939574..9c26c46771f5e 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -14317,11 +14317,16 @@ static void bnx2x_io_resume(struct pci_dev *pdev)
 	bp->fw_seq = SHMEM_RD(bp, func_mb[BP_FW_MB_IDX(bp)].drv_mb_header) &
 							DRV_MSG_SEQ_NUMBER_MASK;
 
-	if (netif_running(dev))
-		bnx2x_nic_load(bp, LOAD_NORMAL);
+	if (netif_running(dev)) {
+		if (bnx2x_nic_load(bp, LOAD_NORMAL)) {
+			netdev_err(bp->dev, "Error during driver initialization, try unloading/reloading the driver\n");
+			goto done;
+		}
+	}
 
 	netif_device_attach(dev);
 
+done:
 	rtnl_unlock();
 }
 
-- 
2.40.1

