Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC24790CDA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 18:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjICQEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 12:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239911AbjICQEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 12:04:08 -0400
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9E9FE
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 09:04:05 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id cpZyqw0SP3NA1cpZyqIn6j; Sun, 03 Sep 2023 18:04:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1693757043;
        bh=0Dvq01YC9MuzymMWpQIoP54YILXU0BzVCv3KM5F3VMM=;
        h=From:To:Cc:Subject:Date;
        b=Q4WMbVSZ36skZXQE9+/ctkGLhzX3XnlQK5RGd8F0vVgRmSZBmt50WwsrD+pHnRQ/H
         NmOZDTcUTuLjz7RgZ1zHg8Y3jqVtYi/GnOVZjkQyCrz8avQCXBPXDcGeHUyo1Gwl0I
         4EAZ40iXSvLGXvJEM5yr/WX54Wqtj4SvzOMlW0uMjHYkr2K9xByRewFAtdBccQSPUx
         lqNrlhrt+JoMy82W3h6af0RuLi3C1tiONTUF8tqb+yiv1zw9hDClp7TJdoptG3RF2v
         TFawHU2RKKyB2nQmKUQwGcWSCyOVyvfsRztgC8Dk0ozTsIHE2hvY/yLRT/3d4qfXDz
         3kGBGxcm3jg0w==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 03 Sep 2023 18:04:03 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Pascal Giard <pascal.giard@etsmtl.ca>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org
Subject: [PATCH] HID: sony: Fix a potential memory leak in sony_probe()
Date:   Sun,  3 Sep 2023 18:04:00 +0200
Message-Id: <db06095c912d6bc56bed6b7e4663c7994072a2ce.1693757011.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an error occurs after a successful usb_alloc_urb() call, usb_free_urb()
should be called.

Fixes: fb1a79a6b6e1 ("HID: sony: fix freeze when inserting ghlive ps3/wii dongles")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
The NULL check is not needed, but I think that it is more informative
written this way.
---
 drivers/hid/hid-sony.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index dd942061fd77..a02046a78b2d 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -2155,6 +2155,9 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	return ret;
 
 err:
+	if (sc->ghl_urb)
+		usb_free_urb(sc->ghl_urb);
+
 	hid_hw_stop(hdev);
 	return ret;
 }
-- 
2.34.1

