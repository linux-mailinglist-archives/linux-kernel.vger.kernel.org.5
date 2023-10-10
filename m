Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB7C7BF3C2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 09:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442367AbjJJHID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 03:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377808AbjJJHIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:08:01 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B3A92;
        Tue, 10 Oct 2023 00:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1696921675; bh=4lNplERnI6yZsihONwZhR1SOQRzefzq61EbgYbT+Bl4=;
        h=From:To:Cc:Subject:Date:From;
        b=u9HA17p7oMjX7AEpQ9GGFvYeQ7rA7lsBRNbzq6/RpIbGCbQ2KQlco8lZ1vw3O/EGP
         b2BGQhYZEx5gRHcbg2QDf/VgPjNTUaB2+jby10JNMtqUDC5886z2UoC2MA22NHh0B8
         UwURBQ4Cf8MkSqwyXU9boo2KWNtYDH/pHBm3FU9A=
From:   =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To:     linux-rockchip@lists.infradead.org
Cc:     Ondrej Jirman <megi@xff.cz>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org (open list:OMNIVISION OV8858 SENSOR DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] media: i2c: ov8858: Don't set fwnode in the driver
Date:   Tue, 10 Oct 2023 09:07:44 +0200
Message-ID: <20231010070747.1781612-1-megi@xff.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megi@xff.cz>

This makes the driver work with the new check in
v4l2_async_register_subdev() that was introduced recently in 6.6-rc1.
Without this change, probe fails with:

ov8858 1-0036: Detected OV8858 sensor, revision 0xb2
ov8858 1-0036: sub-device fwnode is an endpoint!
ov8858 1-0036: v4l2 async register subdev failed
ov8858: probe of 1-0036 failed with error -22

This also simplifies the driver a bit.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
---
v2:
- call fwnode_handle_put earlier to avoid multiple calls to it in
  error code paths (suggested by Jacopo Mondi)

 drivers/media/i2c/ov8858.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/media/i2c/ov8858.c b/drivers/media/i2c/ov8858.c
index 3af6125a2eee..4d9fd76e2f60 100644
--- a/drivers/media/i2c/ov8858.c
+++ b/drivers/media/i2c/ov8858.c
@@ -1850,9 +1850,9 @@ static int ov8858_parse_of(struct ov8858 *ov8858)
 	}
 
 	ret = v4l2_fwnode_endpoint_parse(endpoint, &vep);
+	fwnode_handle_put(endpoint);
 	if (ret) {
 		dev_err(dev, "Failed to parse endpoint: %d\n", ret);
-		fwnode_handle_put(endpoint);
 		return ret;
 	}
 
@@ -1864,12 +1864,9 @@ static int ov8858_parse_of(struct ov8858 *ov8858)
 	default:
 		dev_err(dev, "Unsupported number of data lanes %u\n",
 			ov8858->num_lanes);
-		fwnode_handle_put(endpoint);
 		return -EINVAL;
 	}
 
-	ov8858->subdev.fwnode = endpoint;
-
 	return 0;
 }
 
@@ -1913,7 +1910,7 @@ static int ov8858_probe(struct i2c_client *client)
 
 	ret = ov8858_init_ctrls(ov8858);
 	if (ret)
-		goto err_put_fwnode;
+		return ret;
 
 	sd = &ov8858->subdev;
 	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE | V4L2_SUBDEV_FL_HAS_EVENTS;
@@ -1964,8 +1961,6 @@ static int ov8858_probe(struct i2c_client *client)
 	media_entity_cleanup(&sd->entity);
 err_free_handler:
 	v4l2_ctrl_handler_free(&ov8858->ctrl_handler);
-err_put_fwnode:
-	fwnode_handle_put(ov8858->subdev.fwnode);
 
 	return ret;
 }
@@ -1978,7 +1973,6 @@ static void ov8858_remove(struct i2c_client *client)
 	v4l2_async_unregister_subdev(sd);
 	media_entity_cleanup(&sd->entity);
 	v4l2_ctrl_handler_free(&ov8858->ctrl_handler);
-	fwnode_handle_put(ov8858->subdev.fwnode);
 
 	pm_runtime_disable(&client->dev);
 	if (!pm_runtime_status_suspended(&client->dev))
-- 
2.42.0

