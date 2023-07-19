Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11960759B45
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjGSQpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjGSQpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:45:10 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32865135;
        Wed, 19 Jul 2023 09:45:03 -0700 (PDT)
Received: from umang.jainideasonboard.com (unknown [103.86.18.219])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B3F7A3382;
        Wed, 19 Jul 2023 18:44:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1689785047;
        bh=LOGzH69wKz4mW0XwcNxrfPFY1YNzGADoi/QhGY3s8Qc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SSThdzySp0pK6IXyo2UpqQuUuFLTcbbLCwnTLwtL9bgLVApWhFAroSsXuWDEZ7gF7
         XpPCpGcs33T7HiguQuLpHfI/W+i7oDY/6WvEZAMhXJZp+SczNfHgs+ZpdKeGnNfjVa
         tnCzwpE/GQ3kWa1zlOt1H16bYZRX1zRLBBmiGRpg=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     stefan.wahren@i2se.com, gregkh@linuxfoundation.org,
        f.fainelli@gmail.com, athierry@redhat.com, error27@gmail.com,
        dave.stevenson@raspberrypi.com, kieran.bingham@ideasonboard.com,
        laurent.pinchart@ideasonboard.com,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v9 5/5] staging: vc04_services: vchiq_arm: Remove vchiq_register_child()
Date:   Wed, 19 Jul 2023 22:14:27 +0530
Message-Id: <20230719164427.1383646-6-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230719164427.1383646-1-umang.jain@ideasonboard.com>
References: <20230719164427.1383646-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vchiq_register_child() is used to registered child devices as platform
devices. Now that the child devices are migrated to use the
vchiq_bus_type instead, they will be registered to that. Hence, drop
vchiq_register_child() as it is no more required.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
---
 .../interface/vchiq_arm/vchiq_arm.c           | 22 -------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index f7c2dce5ab09..f18f0ebee60b 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -1776,28 +1776,6 @@ static const struct of_device_id vchiq_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, vchiq_of_match);
 
-static struct platform_device *
-vchiq_register_child(struct platform_device *pdev, const char *name)
-{
-	struct platform_device_info pdevinfo;
-	struct platform_device *child;
-
-	memset(&pdevinfo, 0, sizeof(pdevinfo));
-
-	pdevinfo.parent = &pdev->dev;
-	pdevinfo.name = name;
-	pdevinfo.id = PLATFORM_DEVID_NONE;
-	pdevinfo.dma_mask = DMA_BIT_MASK(32);
-
-	child = platform_device_register_full(&pdevinfo);
-	if (IS_ERR(child)) {
-		dev_warn(&pdev->dev, "%s not registered\n", name);
-		child = NULL;
-	}
-
-	return child;
-}
-
 static int vchiq_probe(struct platform_device *pdev)
 {
 	struct device_node *fw_node;
-- 
2.39.1

