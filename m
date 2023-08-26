Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171C67894A4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 10:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjHZIFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 04:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbjHZIFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 04:05:21 -0400
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42D5213D
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 01:05:14 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id ZoIAqIrNMOQiUZoIAqOb6j; Sat, 26 Aug 2023 10:05:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1693037113;
        bh=1Gj5BE4925dZFZIgp6qeJNN2Uh0t4RwmAE2vfWPWlHg=;
        h=From:To:Cc:Subject:Date;
        b=Mtc9wkbD2Qb8iaLZJqRusvwUfBsgZTlNj8sxJfPvYTXbiaFLTh6bJj15oKxTBvlgL
         TFu0tT6abzOIl5F3NdyJlvMd0NJ7GnAA6WcKavJec/bMe/i0+kXhxOxnmv5Zm8xQ0s
         R1wb24yQFsg8tEw2VpWL3dZAyFmsOA5SxDzfrbbuzc3V3dF7eP59f33eq6wm1KgMqA
         kGtTriSrJfCA8EGGGFjePAYk6JaCCh/tfyrXrzFD1iJx/13e3hZosTewFqufuriEzs
         2ljWaf6jsM8O0GGLZ2UDTPJYXM12jfEiQaF0qoYz4Oeo7HXKPJF7eEIKNkrVoTrQYh
         GGl8ek4DCIstA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 26 Aug 2023 10:05:13 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-media@vger.kernel.org
Subject: [PATCH] media: i2c: rdacm2: Remove an incorrect fwnode_handle_put() call
Date:   Sat, 26 Aug 2023 10:05:06 +0200
Message-Id: <d9230082aefcb7bab6363c51c08598eb5ab62cfc.1693037086.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit in Fixes has removed an fwnode_handle_put() call in the error
handling path of the probe.

Remove the same call from the remove function.

Fixes: 1029939b3782 ("media: v4l: async: Simplify async sub-device fwnode matching")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
/!\   This patch is highly speculative. Review with care.   /!\

If it is correct, it is likely that other similar issue lurk in commit
1029939b3782. I've not looked in detail and my cocci script did not
trigger on them but drivers/media/i2c/max9286.c also looks like a
similar candidate.
---
 drivers/media/i2c/rdacm21.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/i2c/rdacm21.c b/drivers/media/i2c/rdacm21.c
index a36a709243fd..3e22df36354f 100644
--- a/drivers/media/i2c/rdacm21.c
+++ b/drivers/media/i2c/rdacm21.c
@@ -608,7 +608,6 @@ static void rdacm21_remove(struct i2c_client *client)
 	v4l2_async_unregister_subdev(&dev->sd);
 	v4l2_ctrl_handler_free(&dev->ctrls);
 	i2c_unregister_device(dev->isp);
-	fwnode_handle_put(dev->sd.fwnode);
 }
 
 static const struct of_device_id rdacm21_of_ids[] = {
-- 
2.34.1

