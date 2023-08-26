Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4796C789880
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 19:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjHZRnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 13:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjHZRmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 13:42:40 -0400
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8757E7A
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 10:42:38 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id ZxInqYKe17qfuZxIzqGrR5; Sat, 26 Aug 2023 19:42:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1693071757;
        bh=QTIm/KtA3vhwN8cxnOOJvoO7+sH2uOIZpMI8GWwMiqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ZKLAgxe0jXbDOKq1GyiKn7ylNbFayEaNogLejRQcu90GaIae+cmlBqpnhTxhxDH7I
         Hx7irQUuQraeQcWUbRMUpuF6O8ds/gkCUS9kg6R2thfL+OugE57Yu1mrK9Ojn8PuFq
         OF35YKkp8QS8iTxNSC7B7MBQKA9fOQxXBuyfRnjnzMTIXRYObF+pZhOq5ePTYnEIw3
         KseeEd1dFmF8z2hC69YMFDooDN7Sm+WpHG5i4SsmOa6jOWdX2GULeGJPF4g/UTDoFk
         xNffvtVM8OqL9n9drabhnuBXyZhM2kRk7vLX43swB8Pnq/CEpGnf9Ry/a0SdRacB8j
         JzBaiqAd6A2tQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 26 Aug 2023 19:42:37 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     rrameshbabu@nvidia.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 3/3] HID: nvidia-shield: Introduce thunderstrike_destroy()
Date:   Sat, 26 Aug 2023 19:42:19 +0200
Message-Id: <4c9a8c7f6b4eb879dd7ef4d44bb6a80b3f126d25.1693070958.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1693070958.git.christophe.jaillet@wanadoo.fr>
References: <cover.1693070958.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to simplify some error handling paths, and avoid code duplication
introduce thunderstrike_destroy() which undoes thunderstrike_create().

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/hid/hid-nvidia-shield.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-nvidia-shield.c b/drivers/hid/hid-nvidia-shield.c
index 849b3f8409a0..4e39e7c1a2c3 100644
--- a/drivers/hid/hid-nvidia-shield.c
+++ b/drivers/hid/hid-nvidia-shield.c
@@ -915,6 +915,20 @@ static struct shield_device *thunderstrike_create(struct hid_device *hdev)
 	return ERR_PTR(ret);
 }
 
+static void thunderstrike_destroy(struct hid_device *hdev)
+{
+	struct shield_device *dev = hid_get_drvdata(hdev);
+	struct thunderstrike *ts;
+
+	ts = container_of(dev, struct thunderstrike, base);
+
+	power_supply_unregister(ts->base.battery_dev.psy);
+	if (ts->haptics_dev)
+		input_unregister_device(ts->haptics_dev);
+	led_classdev_unregister(&ts->led_dev);
+	ida_free(&thunderstrike_ida, ts->id);
+}
+
 static int android_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 				 struct hid_field *field,
 				 struct hid_usage *usage, unsigned long **bit,
@@ -1074,11 +1088,7 @@ static int shield_probe(struct hid_device *hdev, const struct hid_device_id *id)
 err_stop:
 	hid_hw_stop(hdev);
 err_haptics:
-	power_supply_unregister(ts->base.battery_dev.psy);
-	if (ts->haptics_dev)
-		input_unregister_device(ts->haptics_dev);
-	led_classdev_unregister(&ts->led_dev);
-	ida_free(&thunderstrike_ida, ts->id);
+	thunderstrike_destroy(hdev);
 	return ret;
 }
 
@@ -1090,11 +1100,7 @@ static void shield_remove(struct hid_device *hdev)
 	ts = container_of(dev, struct thunderstrike, base);
 
 	hid_hw_close(hdev);
-	power_supply_unregister(dev->battery_dev.psy);
-	if (ts->haptics_dev)
-		input_unregister_device(ts->haptics_dev);
-	led_classdev_unregister(&ts->led_dev);
-	ida_free(&thunderstrike_ida, ts->id);
+	thunderstrike_destroy(hdev);
 	del_timer_sync(&ts->psy_stats_timer);
 	cancel_work_sync(&ts->hostcmd_req_work);
 	hid_hw_stop(hdev);
-- 
2.34.1

