Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D425380A69F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574192AbjLHPIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574160AbjLHPIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:08:06 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732FB122;
        Fri,  8 Dec 2023 07:08:12 -0800 (PST)
Received: from umang.jain (unknown [103.251.226.108])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B5801EBA;
        Fri,  8 Dec 2023 16:07:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1702048049;
        bh=nrEAdhHZwA2L0AvxJ6FGfgqEfXwThQSUE+QCVNTuuhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gAuvzIPLzZbXJAQOVLdFaCDYd4M7E8B4M6iDC4DeTXNdPI1Mc+WFc8omlFcUDmeeJ
         tuvNgP8E5C3mjtX+vsWmKDvyeLDlRNgHMXfzonSj+Zgw/A+PqS3K7h9oV6LV01NEDb
         YZaGhlOkwcvLOpu60KBkOgFrLjqmZtzQw+y4W6zc=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     devicetree@vger.kernel.org, linux-media@vger.kernel.org
Cc:     "Paul J . Murphy" <paul.j.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Umang Jain <umang.jain@ideasonboard.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 3/8] media: i2c: imx335: Improve configuration error reporting
Date:   Fri,  8 Dec 2023 20:37:49 +0530
Message-ID: <20231208150756.124720-4-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231208150756.124720-1-umang.jain@ideasonboard.com>
References: <20231208150756.124720-1-umang.jain@ideasonboard.com>
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

From: Kieran Bingham <kieran.bingham@ideasonboard.com>

The existing imx335_parse_hw_config function has two paths
that can be taken without reporting to the user the reason
for failing to accept the hardware configuration.

Extend the error reporting paths to identify failures when
probing the device.

Reviewed-by: Umang Jain <umang.jain@ideasonboard.com>
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
2.41.0

