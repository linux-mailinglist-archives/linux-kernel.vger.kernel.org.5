Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6547BC7E5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 15:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343940AbjJGNAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 09:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343741AbjJGNAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 09:00:20 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849A6AB
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 06:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1696683613; bh=1Jri4c0dUWUEhbh0nohF7eCG2g72tCMR2ODPWB7oQMk=;
        h=From:To:Cc:Subject:Date:From;
        b=Sa/rhZmZW0rIafmQjpxwClLK5cJmPYNc+zI1PaA7cRbnhzpYyqFl1ztVgOvUTeNyU
         k+FcqpYJvKtNXP9BR8Jrg+WJeBVCsC7PTMizxCZU5eEPKKnhbSZvzAadmLBsR/4i3U
         rAXEzs/iKvS6a73pFdLQA1X/NZbp36u2Xn8k8lak=
From:   =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To:     linux-rockchip@lists.infradead.org
Cc:     Ondrej Jirman <megi@xff.cz>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org (open list:V4L2 CAMERA SENSOR DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] media: i2c: ov8858: Don't set fwnode in the driver
Date:   Sat,  7 Oct 2023 15:00:00 +0200
Message-ID: <20231007130004.942369-1-megi@xff.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/media/i2c/ov8858.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/ov8858.c b/drivers/media/i2c/ov8858.c
index 3af6125a2eee..b862dc9604cc 100644
--- a/drivers/media/i2c/ov8858.c
+++ b/drivers/media/i2c/ov8858.c
@@ -1868,7 +1868,7 @@ static int ov8858_parse_of(struct ov8858 *ov8858)
 		return -EINVAL;
 	}
 
-	ov8858->subdev.fwnode = endpoint;
+	fwnode_handle_put(endpoint);
 
 	return 0;
 }
@@ -1913,7 +1913,7 @@ static int ov8858_probe(struct i2c_client *client)
 
 	ret = ov8858_init_ctrls(ov8858);
 	if (ret)
-		goto err_put_fwnode;
+		return ret;
 
 	sd = &ov8858->subdev;
 	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE | V4L2_SUBDEV_FL_HAS_EVENTS;
@@ -1964,8 +1964,6 @@ static int ov8858_probe(struct i2c_client *client)
 	media_entity_cleanup(&sd->entity);
 err_free_handler:
 	v4l2_ctrl_handler_free(&ov8858->ctrl_handler);
-err_put_fwnode:
-	fwnode_handle_put(ov8858->subdev.fwnode);
 
 	return ret;
 }
@@ -1978,7 +1976,6 @@ static void ov8858_remove(struct i2c_client *client)
 	v4l2_async_unregister_subdev(sd);
 	media_entity_cleanup(&sd->entity);
 	v4l2_ctrl_handler_free(&ov8858->ctrl_handler);
-	fwnode_handle_put(ov8858->subdev.fwnode);
 
 	pm_runtime_disable(&client->dev);
 	if (!pm_runtime_status_suspended(&client->dev))
-- 
2.42.0

