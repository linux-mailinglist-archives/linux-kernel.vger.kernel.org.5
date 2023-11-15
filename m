Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1AD7EC8CF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjKOQj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjKOQjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:39:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893A8AB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:39:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED0CC433C8;
        Wed, 15 Nov 2023 16:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700066360;
        bh=diI9h96MMsr8an2MYVnN2Z42kQPggaGEHH/n5mgX6Q4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UXvWV165zKWxS9koxbLHt6+oJBIVlM3FymNxwckh4dFcNysCimVu71/Fx20C2PfSX
         fHOImhDq2KujxGRmu2e9gXy9KgARgcBzu8pwjjaO+LnuXHhGHbydN0AlEvVTR8kV3P
         ggi5OpbbNy3Qd9VrY4cA69gqOlcuakaOlPtBbVbqYo9kEVhjM4M9W+pcG0ouMYnssi
         z2MuCO2aJNtpVCA9mjUg6R+0q86XNx8NznJT1uNyjd8KeV4dyFVMciYxotvwlaoskk
         SxQfwzrx5H8il70GeeWjxzwHSif6FxzUT5Vc14se6CO5o2WhYwZE9UkS1iXs0SLov5
         75PkEOmzQ2fkA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Farah Kassabri <fkassabri@habana.ai>
Subject: [PATCH 02/10] accel/habanalabs: add log when eq event is not received
Date:   Wed, 15 Nov 2023 18:39:04 +0200
Message-Id: <20231115163912.1243175-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231115163912.1243175-1-ogabbay@kernel.org>
References: <20231115163912.1243175-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Farah Kassabri <fkassabri@habana.ai>

Add error log when no eq event is received from FW,
to cover a scenario when FW is stuck for some reason.
In such case driver will not receive neither the eq error interrupt
or the eq heartbeat event, and will just initiate a reset without
indication in the dmesg about the reason.

Signed-off-by: Farah Kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/common/device.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index 9711e8fc979d..d95a981b2906 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -1049,10 +1049,12 @@ static void hl_device_eq_heartbeat(struct hl_device *hdev)
 	if (!prop->cpucp_info.eq_health_check_supported)
 		return;
 
-	if (hdev->eq_heartbeat_received)
+	if (hdev->eq_heartbeat_received) {
 		hdev->eq_heartbeat_received = false;
-	else
+	} else {
+		dev_err(hdev->dev, "EQ heartbeat event was not received!\n");
 		hl_device_cond_reset(hdev, HL_DRV_RESET_HARD, event_mask);
+	}
 }
 
 static void hl_device_heartbeat(struct work_struct *work)
-- 
2.34.1

