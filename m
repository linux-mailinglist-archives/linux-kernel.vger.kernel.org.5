Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE867D0B3D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376615AbjJTJOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376523AbjJTJOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:14:40 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 73B6D106;
        Fri, 20 Oct 2023 02:14:38 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 3D205604AABDF;
        Fri, 20 Oct 2023 17:14:34 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     vkoul@kernel.org, kishon@kernel.org
Cc:     Su Hui <suhui@nfschina.com>, u.kleine-koenig@pengutronix.de,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 1/2] phy: mapphone-mdm6600: fix an error code problem in phy_mdm6600_device_power_on
Date:   Fri, 20 Oct 2023 17:14:13 +0800
Message-Id: <20231020091413.205743-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When wait_for_completion_timeout() failed, error is assigned
'-ETIMEDOUT'. But this error code is never used. Return '-ETIMEDOUT'
directly to fix this problem.

Signed-off-by: Su Hui <suhui@nfschina.com>
---

I'm not sure that return directly is true or not, maybe need some 
process before return directly.

 drivers/phy/motorola/phy-mapphone-mdm6600.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/motorola/phy-mapphone-mdm6600.c
index 1d567604b650..e84e3390bff0 100644
--- a/drivers/phy/motorola/phy-mapphone-mdm6600.c
+++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
@@ -421,8 +421,8 @@ static int phy_mdm6600_device_power_on(struct phy_mdm6600 *ddata)
 			dev_info(ddata->dev, "Powered up OK\n");
 	} else {
 		ddata->enabled = false;
-		error = -ETIMEDOUT;
 		dev_err(ddata->dev, "Timed out powering up\n");
+		return -ETIMEDOUT;
 	}
 
 	/* Reconfigure mode1 GPIO as input for OOB wake */
-- 
2.30.2

