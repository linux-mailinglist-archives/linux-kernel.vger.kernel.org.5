Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821EF7DE181
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 14:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344054AbjKANOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 09:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343851AbjKANON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 09:14:13 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2FFF4;
        Wed,  1 Nov 2023 06:14:07 -0700 (PDT)
Received: from Monstersaurus.local (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1AF14E52;
        Wed,  1 Nov 2023 14:13:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1698844424;
        bh=cqUYU2q4hDhZpxo1Fi1Ix4DPuhuP0paFGsY1V5zSNXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HSM+abDc4nh4X1w6CkN20KztnDROtn/zTk28cdU2ACq5iJhBOF9BDE5xnWJpaCI6O
         7cbMhav8/xZw6XUmxLt7GHeMCjSTRjKbWIf4o6RASH/JEdejrN9Avjj3UZRkGqmE+w
         f38jTHAVGLWJDqUqEpiB9qmZEB/YEJe1JlPhljdE=
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
To:     devicetree@vger.kernel.org, linux-media@vger.kernel.org
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Umang Jain <umang.jain@ideasonboard.com>,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/6] media: i2c: imx335: Improve configuration error reporting
Date:   Wed,  1 Nov 2023 13:13:51 +0000
Message-Id: <20231101131354.2333498-4-kieran.bingham@ideasonboard.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101131354.2333498-1-kieran.bingham@ideasonboard.com>
References: <20231101131354.2333498-1-kieran.bingham@ideasonboard.com>
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

The existing imx335_parse_hw_config function has two paths
that can be taken without reporting to the user the reason
for failing to accept the hardware configuration.

Extend the error reporting paths to identify failures when
probing the device.

Reviewed-by: Umang Jain <umang.jain@ideasonboard.com>
Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

---
v2:
 - Fix line endings

Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
---
 drivers/media/i2c/imx335.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
index cbabef968e21..31c612c6bdd8 100644
--- a/drivers/media/i2c/imx335.c
+++ b/drivers/media/i2c/imx335.c
@@ -795,8 +795,10 @@ static int imx335_parse_hw_config(struct imx335 *imx335)
 	}
 
 	ep = fwnode_graph_get_next_endpoint(fwnode, NULL);
-	if (!ep)
+	if (!ep) {
+		dev_err(imx335->dev, "Failed to get next endpoint\n");
 		return -ENXIO;
+	}
 
 	ret = v4l2_fwnode_endpoint_alloc_parse(ep, &bus_cfg);
 	fwnode_handle_put(ep);
@@ -821,6 +823,8 @@ static int imx335_parse_hw_config(struct imx335 *imx335)
 		if (bus_cfg.link_frequencies[i] == IMX335_LINK_FREQ)
 			goto done_endpoint_free;
 
+	dev_err(imx335->dev, "no compatible link frequencies found\n");
+
 	ret = -EINVAL;
 
 done_endpoint_free:
-- 
2.34.1

