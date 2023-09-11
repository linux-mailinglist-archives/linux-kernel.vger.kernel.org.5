Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0571A79AF7F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241487AbjIKVHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238931AbjIKOHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:07:49 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8691ACF0;
        Mon, 11 Sep 2023 07:07:45 -0700 (PDT)
Received: from www.ideasonboard.com (unknown [103.238.109.17])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4009E2C95;
        Mon, 11 Sep 2023 16:06:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694441174;
        bh=UWp51F/lSxhMYaW0zUZOiG93KUaI+AO2LyKN9T4z790=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lLb4wBrpSzJ4QQrXH4jLAXJkpCRTslVUCNf9Bp0a2MS5xHYXiHjsvXsFuXj9Er4Fq
         jCBqNQnmEU9MCENzsMsinTXPinUufAoXsqQGGQB+ZLF/FARkTq0DLayCCWKvIL/+9h
         biRutRUnAhFCYmNr5SRGNSRzphO69mIIQ1PrTjPc=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     stefan.wahren@i2se.com, gregkh@linuxfoundation.org,
        f.fainelli@gmail.com, athierry@redhat.com, error27@gmail.com,
        kieran.bingham@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        dave.stevenson@raspberrypi.com,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v10 5/5] staging: vc04_services: vchiq_arm: Remove vchiq_register_child()
Date:   Mon, 11 Sep 2023 10:07:12 -0400
Message-ID: <20230911140712.180751-6-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911140712.180751-1-umang.jain@ideasonboard.com>
References: <20230911140712.180751-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 2da470740cda..5eccf5b277e5 100644
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
2.41.0

