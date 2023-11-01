Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705DD7DDE94
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 10:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjKAJjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 05:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjKAJjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 05:39:46 -0400
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF8FF3
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 02:39:43 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id y7hOqJVASdj4Iy7hOqNV22; Wed, 01 Nov 2023 10:39:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1698831582;
        bh=Agd+7JRg0SYMOgT8/FQFavX9NvEOiLdyeBNbj4j9/Wk=;
        h=From:To:Cc:Subject:Date;
        b=iO35WINfQ9dNQH3zjqcQwXjwqASluxQOhG4v2UpWNHVAR8x8S3E/KocaHeDrAYdrx
         LltCP6l+BqS+2/90Hwt8df7OzjTZEJThWtn+l2oQntfg4JsdeczILqergFVROElnP8
         1up+F3NbCSaPfNwgeNoGz12/kkaElTwLyMqX85SAa0Air+3bVVqmnAkbG2nXwUrBVT
         Q+J+dfmWuDU2hoOAIkKtcBT2TYDhw2W5Fg12+Vz2yw9aZznYernLvrnoL52uCqfati
         Zr2fKFjH4qNWxMZB+A0tbK+XLMIRt1+d2ez3Esd8Z6PbRpW+KBBDO5/4LdlH85geCU
         sFOF8fvhCb6XQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 01 Nov 2023 10:39:42 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] HSI: omap_ssi: Remove usage of the deprecated ida_simple_xx() API
Date:   Wed,  1 Nov 2023 10:39:39 +0100
Message-Id: <d72106fc9de28ef8db2ed653febe366d141362a4.1698831563.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 drivers/hsi/controllers/omap_ssi_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hsi/controllers/omap_ssi_core.c b/drivers/hsi/controllers/omap_ssi_core.c
index 4c1a00f9929e..6802efb4d6cd 100644
--- a/drivers/hsi/controllers/omap_ssi_core.c
+++ b/drivers/hsi/controllers/omap_ssi_core.c
@@ -355,7 +355,7 @@ static int ssi_add_controller(struct hsi_controller *ssi,
 	if (!omap_ssi)
 		return -ENOMEM;
 
-	err = ida_simple_get(&platform_omap_ssi_ida, 0, 0, GFP_KERNEL);
+	err = ida_alloc(&platform_omap_ssi_ida, GFP_KERNEL);
 	if (err < 0)
 		return err;
 	ssi->id = err;
@@ -417,7 +417,7 @@ static int ssi_add_controller(struct hsi_controller *ssi,
 	return 0;
 
 out_err:
-	ida_simple_remove(&platform_omap_ssi_ida, ssi->id);
+	ida_free(&platform_omap_ssi_ida, ssi->id);
 	return err;
 }
 
@@ -451,7 +451,7 @@ static void ssi_remove_controller(struct hsi_controller *ssi)
 	tasklet_kill(&omap_ssi->gdd_tasklet);
 	hsi_unregister_controller(ssi);
 	clk_notifier_unregister(omap_ssi->fck, &omap_ssi->fck_nb);
-	ida_simple_remove(&platform_omap_ssi_ida, id);
+	ida_free(&platform_omap_ssi_ida, id);
 }
 
 static inline int ssi_of_get_available_ports_count(const struct device_node *np)
-- 
2.34.1

