Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C09A78E296
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343837AbjH3Wtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243869AbjH3Wth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:49:37 -0400
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09817E6E
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:49:18 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id bSOGqx2PaDlJebSOGqE9lA; Wed, 30 Aug 2023 23:06:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1693429580;
        bh=RzybfU0boxWYJNuGa1CY2Ynec75IhyC3G31hAEGouPc=;
        h=From:To:Cc:Subject:Date;
        b=mPrO5hn5GG5LU77t1k7/5WO5l+CvjJ29N7m9UBTflaCTVNouFpmoUL4y4lf3E3h8m
         ovmhshCs/5nFfv+13c172HABJvt+Mycl8lymXklGe4kDwQZbwx7GhsuNVENRtPpJCi
         s+UjqoGzWyHK+pAqfhfhP/VMgN0NZDYoMZEGUaZ+pi0N25nLmnsi+JLOVY1A5Uyiy+
         Loj8GV28MUlbOiOJ55JPXeS0v/lrF/NC83cg82rQbBA92VoZYCfwrBVL+xBpstl8/t
         NSC1RCgTCI2l66yzce+gpfX+5v/nGoRQqZl9rfjnrHHjdAqd0AR2WYxTPo2UBp5wpt
         oz9s9SiN9iAvA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 30 Aug 2023 23:06:20 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Rui Miguel Silva <rmfrfs@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Martin Kepplinger <martink@posteo.de>,
        Purism Kernel Team <kernel@puri.sm>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: imx-mipi-csis: Remove an incorrect fwnode_handle_put() call
Date:   Wed, 30 Aug 2023 23:06:14 +0200
Message-Id: <dd5b741f496d074d342958f14baff5bae8c71531.1693429556.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit in Fixes has removed an fwnode_graph_get_endpoint_by_id() call
in mipi_csis_subdev_init().
So the reference that was taken should not be released anymore in the
error handling path of the probe and in the remove function.

Remove the now incorrect fwnode_handle_put() calls.

Fixes: 1029939b3782 ("media: v4l: async: Simplify async sub-device fwnode matching")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/media/platform/nxp/imx-mipi-csis.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-mipi-csis.c b/drivers/media/platform/nxp/imx-mipi-csis.c
index 16f19a640130..5f93712bf485 100644
--- a/drivers/media/platform/nxp/imx-mipi-csis.c
+++ b/drivers/media/platform/nxp/imx-mipi-csis.c
@@ -1490,7 +1490,6 @@ static int mipi_csis_probe(struct platform_device *pdev)
 	v4l2_async_unregister_subdev(&csis->sd);
 err_disable_clock:
 	mipi_csis_clk_disable(csis);
-	fwnode_handle_put(csis->sd.fwnode);
 
 	return ret;
 }
@@ -1510,7 +1509,6 @@ static void mipi_csis_remove(struct platform_device *pdev)
 	mipi_csis_clk_disable(csis);
 	v4l2_subdev_cleanup(&csis->sd);
 	media_entity_cleanup(&csis->sd.entity);
-	fwnode_handle_put(csis->sd.fwnode);
 	pm_runtime_set_suspended(&pdev->dev);
 }
 
-- 
2.34.1

