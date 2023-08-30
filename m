Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6A978E114
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240653AbjH3U7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240618AbjH3U7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:59:23 -0400
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr [80.12.242.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656C2A1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:58:49 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id bSFuqpu30bNd0bSFuqT1NL; Wed, 30 Aug 2023 22:57:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1693429061;
        bh=AMW7RcTNB2xicBX3OHcLvhBYaIQQ+INP0gPrx6N+OEQ=;
        h=From:To:Cc:Subject:Date;
        b=g6Kfl60gOlQzYEUaGXwmQotJTETbzMD0nNBaJLnRMfNXFsG7dXkzPD12r4bFQ0MmR
         14eD+X1gHyc5CP6ZUt32a6FkCMeWRndiSRgeVHaIRcobcxfKj+lDF3wpBgbtmQBzmq
         LS2YdKKL6IKZrG51rMwKPLGNJ+KAALUHkR9h+h38DXOxpYwejMxOBar5td2pWQoUSk
         sQc6yAxTbDvpY0EOda476Ly7SK261Chp+TYdxEVKJirq+vh8P/DZZKDcmmG315Ff0V
         hKGcQWQqLSbERIHFbnwV33mbhwAIyNvz1VPPWAMx/TZ1a1vKsmj1xH1CYSFJm8gKE2
         1dSWNsIeu5s6A==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 30 Aug 2023 22:57:41 +0200
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
Subject: [PATCH] media: i2c: max9286: Remove an incorrect fwnode_handle_put() call
Date:   Wed, 30 Aug 2023 22:57:36 +0200
Message-Id: <26387273c902ce938a25647b6ccd9b8584284096.1693428894.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit in Fixes has removed an fwnode_handle_put() call in the error
handling path of max9286_v4l2_register().

Remove the same call from max9286_v4l2_unregister().

Fixes: 1029939b3782 ("media: v4l: async: Simplify async sub-device fwnode matching")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/media/i2c/max9286.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/i2c/max9286.c b/drivers/media/i2c/max9286.c
index f27a69b1b727..fc1cf196ef01 100644
--- a/drivers/media/i2c/max9286.c
+++ b/drivers/media/i2c/max9286.c
@@ -1110,7 +1110,6 @@ static int max9286_v4l2_register(struct max9286_priv *priv)
 
 static void max9286_v4l2_unregister(struct max9286_priv *priv)
 {
-	fwnode_handle_put(priv->sd.fwnode);
 	v4l2_ctrl_handler_free(&priv->ctrls);
 	v4l2_async_unregister_subdev(&priv->sd);
 	max9286_v4l2_notifier_unregister(priv);
-- 
2.34.1

