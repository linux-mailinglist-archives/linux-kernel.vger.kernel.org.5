Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136247DE44F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343663AbjKAP6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbjKAP6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:58:10 -0400
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20621BD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 08:58:08 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id yDbZq0T7ydFbKyDbaqoC18; Wed, 01 Nov 2023 16:58:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1698854286;
        bh=i21kCUborbDIm4AbDPL2tQN3AqBRzOGB4lpH+Cd5dY8=;
        h=From:To:Cc:Subject:Date;
        b=dOSSpP4vQt0MNdHx9PyLyIAn38jj8YspPHjD2QCCUf9Uxsof8mzZ3pfM3ULTChpMu
         0IjIVsFBWuzWIjTIBOIOCp/PW9+q1UKBOgNU4UTcdyhrrxRz7zD3BB9+kBk+NCtMPu
         mK3Re2YadiLmgBGIKlren4V71eaOizgHLuf/z2ZMKEI+m3fnoSWWoTbXYPFOUkGPT0
         J+Ks83hInGhi5lEtFbAQal/dujHm6jAcqZSxpJ0+yM5Lh7CdKR1ZoaM8PPEzsuMxOM
         gnMYGrfHWx+H9mNmaTQ68TbutnjMeC9hDytjv3V1RbedSFaznZYXFwgLAE7LpRIqt1
         2VdzsVliFMI6w==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 01 Nov 2023 16:58:06 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-phy@lists.infradead.org
Subject: [PATCH] phy: core: Remove usage of the deprecated ida_simple_xx() API
Date:   Wed,  1 Nov 2023 16:57:57 +0100
Message-Id: <d2323636c6cd2ec22f73a0ae6c2d34ac99b4abd5.1698854255.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

This is less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/phy/phy-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 96a0b1e111f3..d9be6a4d5383 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -959,7 +959,7 @@ struct phy *phy_create(struct device *dev, struct device_node *node,
 	if (!phy)
 		return ERR_PTR(-ENOMEM);
 
-	id = ida_simple_get(&phy_ida, 0, 0, GFP_KERNEL);
+	id = ida_alloc(&phy_ida, GFP_KERNEL);
 	if (id < 0) {
 		dev_err(dev, "unable to get id\n");
 		ret = id;
@@ -1232,7 +1232,7 @@ static void phy_release(struct device *dev)
 	dev_vdbg(dev, "releasing '%s'\n", dev_name(dev));
 	debugfs_remove_recursive(phy->debugfs);
 	regulator_put(phy->pwr);
-	ida_simple_remove(&phy_ida, phy->id);
+	ida_free(&phy_ida, phy->id);
 	kfree(phy);
 }
 
-- 
2.34.1

