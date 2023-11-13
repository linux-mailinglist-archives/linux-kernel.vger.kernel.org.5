Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1557E9E29
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjKMOIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjKMOIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:08:12 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704B1D59;
        Mon, 13 Nov 2023 06:08:09 -0800 (PST)
Received: from umang.jain (unknown [103.86.18.179])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 615B429A;
        Mon, 13 Nov 2023 15:07:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1699884462;
        bh=0lpguXFbz+BKP5/xOg3wKVbLHMvejhbyqPq3tWfOpfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vw8320/h6jsPmLMJaAydytdZvVXuYaR/TGM5BFP5aAcaHF2GVxAPsBNFBwSk65OoD
         H2c6K3n7ZzcJ9HgTa30mR4JrkQB9cCHtl+HGCLtVMSdLosVIBXglhXXHlXM6ZkQz7c
         E8um6fIzYKEZNvgfksMTt8Wxl6LNxiVkBZalm7/g=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-media@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Ricardo B . Marliere" <ricardo@marliere.net>,
        Dan Carpenter <error27@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH] fixup! staging: vc04_services: bcm2835-isp: Add a more complex ISP processing component
Date:   Mon, 13 Nov 2023 09:07:55 -0500
Message-ID: <20231113140755.425365-1-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109210309.638594-11-umang.jain@ideasonboard.com>
References: <20231109210309.638594-11-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setup DMA Mask
---
I realised while (re)creating the test branches (sent in reply to the cover
letter), I missed to squash this hunk in
"staging: vc04_services: bcm2835-isp: Add a more complex ISP processing component"
before sending out the series.

Sending it as a fixup! for now. 
---
 .../staging/vc04_services/bcm2835-isp/bcm2835-v4l2-isp.c    | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/staging/vc04_services/bcm2835-isp/bcm2835-v4l2-isp.c b/drivers/staging/vc04_services/bcm2835-isp/bcm2835-v4l2-isp.c
index 316d35d5f19d..4a23f9feb6e4 100644
--- a/drivers/staging/vc04_services/bcm2835-isp/bcm2835-v4l2-isp.c
+++ b/drivers/staging/vc04_services/bcm2835-isp/bcm2835-v4l2-isp.c
@@ -1774,6 +1774,12 @@ static int bcm2835_isp_probe(struct vchiq_device *device)
 	unsigned int i;
 	int ret;
 
+	ret = dma_set_mask_and_coherent(&device->dev, DMA_BIT_MASK(32));
+	if (ret) {
+		dev_err(&device->dev, "dma_set_mask_and_coherent failed: %d\n", ret);
+		return ret;
+	}
+
 	bcm2835_isp_instances = devm_kzalloc(&device->dev,
 					     sizeof(bcm2835_isp_instances) *
 						      BCM2835_ISP_NUM_INSTANCES,
-- 
2.41.0

