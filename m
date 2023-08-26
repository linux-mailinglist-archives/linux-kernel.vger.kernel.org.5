Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759BF789878
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 19:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjHZRnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 13:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjHZRmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 13:42:40 -0400
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0A6B6
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 10:42:37 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id ZxInqYKe17qfuZxIyqGrQm; Sat, 26 Aug 2023 19:42:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1693071756;
        bh=7y+p/DCWdTxhVS6H8ySh3peTTL6wMdtAAIrdbcIWb4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=frMIY+U3jYd67SIhM2sjs9OvrU/cK1usM8XRDY1Flt9vM7MSmKz1+ErUOPXRuNT/s
         Djks6HowBBl0Fr4RrprVqoivZ4eigj6txYAl1mLOLpCG7DoiWON4J+DFTV5yLk9zRx
         IUb4k5D4BuEh4NFfBZaZop1ZglbdAEoE5jbiCldwOBrhWwLlYdVUqel94cCL4oq2J7
         LbKwbWG/hB2gnnj4X8xLcm+nsURLr0VNC8PqEjySYyOlgSmW2Lrbv8F1CvDG3KVXFT
         lLuDGQiGSYPtgB3XPrtENT5CibTJLs6bFnFTMOZ3WXuPiuvVWkFLHNKuZjv831hCK5
         Lvp8arqXjblxA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 26 Aug 2023 19:42:36 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     rrameshbabu@nvidia.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/3] HID: nvidia-shield: Fix a missing led_classdev_unregister() in the probe error handling path
Date:   Sat, 26 Aug 2023 19:42:17 +0200
Message-Id: <bf19356b4ccd6446245570bf526d6940cac25c09.1693070958.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1693070958.git.christophe.jaillet@wanadoo.fr>
References: <cover.1693070958.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit in Fixes updated the error handling path of
thunderstrike_create() and the remove function but not the error handling
path of shield_probe(), should an error occur after a successful
thunderstrike_create() call.

Add the missing call.

Fixes: f88af60e74a5 ("HID: nvidia-shield: Support LED functionality for Thunderstrike")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/hid/hid-nvidia-shield.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-nvidia-shield.c b/drivers/hid/hid-nvidia-shield.c
index 9a3576dbf421..66a7478e2c9d 100644
--- a/drivers/hid/hid-nvidia-shield.c
+++ b/drivers/hid/hid-nvidia-shield.c
@@ -1076,6 +1076,7 @@ static int shield_probe(struct hid_device *hdev, const struct hid_device_id *id)
 err_haptics:
 	if (ts->haptics_dev)
 		input_unregister_device(ts->haptics_dev);
+	led_classdev_unregister(&ts->led_dev);
 	return ret;
 }
 
-- 
2.34.1

