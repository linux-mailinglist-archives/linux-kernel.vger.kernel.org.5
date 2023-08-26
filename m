Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70287789879
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 19:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjHZRnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 13:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjHZRmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 13:42:40 -0400
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D284CEE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 10:42:38 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id ZxInqYKe17qfuZxIyqGrQw; Sat, 26 Aug 2023 19:42:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1693071757;
        bh=J2IAazKwns7ngGWe0+roM1E+yKslkp7WaduYjND4iwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Da+Zq5dulkq/6u8ueEkQC7tVbRjzFcU14vepedq7lCPcgoiWXmpY7NWgggLDzBNwm
         fQcep7UXqbOXM7Ea8SYawTl9ubr+NnE5l0b6gjCi273ywxzL9ezxnPy/O6sdtkqGb5
         oXF+68yFPVAyfgoce4hIXb4Z2Wrseo5CiS0NS7cNPoCvRDVgRHrgwCtvWiwsloznZN
         IzCKKtxEW1LzjANK0t0lBOGyTmk+lLHkT5zLHPnH1ujmYHP6MV4Hb/nBDfQLij+4ZE
         6PfkLbsmk+3JkE/2LNtxL1FCi1dp5oy4ZcHRt0IYEzmstnPaD2W7+QXwRqeRO3RvWy
         TPRC0BO9aD2HA==
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
Subject: [PATCH 2/3] HID: nvidia-shield: Fix some missing function calls() in the probe error handling path
Date:   Sat, 26 Aug 2023 19:42:18 +0200
Message-Id: <443aef6a6d90011e8fffcd43e1a88cd9e98594ca.1693070958.git.christophe.jaillet@wanadoo.fr>
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

The commit in Fixes updated the error handling path of
thunderstrike_create() and the remove function but not the error handling
path of shield_probe(), should an error occur after a successful
thunderstrike_create() call.

Add the missing calls.

Fixes: 3ab196f88237 ("HID: nvidia-shield: Add battery support for Thunderstrike")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/hid/hid-nvidia-shield.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-nvidia-shield.c b/drivers/hid/hid-nvidia-shield.c
index 66a7478e2c9d..849b3f8409a0 100644
--- a/drivers/hid/hid-nvidia-shield.c
+++ b/drivers/hid/hid-nvidia-shield.c
@@ -1074,9 +1074,11 @@ static int shield_probe(struct hid_device *hdev, const struct hid_device_id *id)
 err_stop:
 	hid_hw_stop(hdev);
 err_haptics:
+	power_supply_unregister(ts->base.battery_dev.psy);
 	if (ts->haptics_dev)
 		input_unregister_device(ts->haptics_dev);
 	led_classdev_unregister(&ts->led_dev);
+	ida_free(&thunderstrike_ida, ts->id);
 	return ret;
 }
 
-- 
2.34.1

