Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E4A79A2FF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 07:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbjIKFpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 01:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjIKFpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 01:45:00 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A227A1B9;
        Sun, 10 Sep 2023 22:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1694411084;
        bh=HzQvLUQwMKRJOGwaKIdUdtJzzIIHyVPa8y2c1AfBN3s=;
        h=From:Date:Subject:To:Cc:From;
        b=AnWVzpt9O/StzyRMMt6av2FDQ8F1kJoTgVsc9pGwkKh8uStIM8vyEtwv5KwPv/FQ+
         OQu56p1UATOAHDmzufuIbF7gUUKvokidxNM3q1sslo2WfkZ8j6Ll1hUMREVyFjhPjG
         3D5eCYG8QIMlwXSR5AL1mqj13ejdaRrMRupiuSpY=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Mon, 11 Sep 2023 07:44:42 +0200
Subject: [PATCH] hwmon: powerz: add support for ChargerLAB KM002C
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230911-powerz-km002c-v1-1-898bd79b9bae@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAEmp/mQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDS0ND3YL88tSiKt3sXAMDo2RdS5PEtCSTFOMUMxNTJaCegqLUtMwKsHn
 RsbW1AGHvg/VfAAAA
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Gilbert <dgilbert@interlog.com>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694411082; l=1216;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=HzQvLUQwMKRJOGwaKIdUdtJzzIIHyVPa8y2c1AfBN3s=;
 b=khnT8josulM1Hj9pQSr9R4fpFEf1NPwW4bbk1zSa6hfk0FfQ/M6RvkXBDEKKNmGuE53Hk57ue
 tWUigKj/NqqDFMfs1Ghlg5Bw0iyljOjnUkRndMKPCmel906DZFcNyFP
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KM002C is similar to the KM003C and seems to use the same
protocol and firmware.

Reported-by: Douglas Gilbert <dgilbert@interlog.com>
Closes: https://lore.kernel.org/lkml/290ebce4-54f0-8ac1-2a13-cbc806d80d64@interlog.com/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---

This patch is based on hwmon-next,
commit 80369d9e1f2f ("hwmon: (sch5627) Document behaviour of limit registers").

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/hwmon/powerz.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/powerz.c b/drivers/hwmon/powerz.c
index 2b9693aee6f6..cfb635f94d66 100644
--- a/drivers/hwmon/powerz.c
+++ b/drivers/hwmon/powerz.c
@@ -254,6 +254,7 @@ static void powerz_disconnect(struct usb_interface *intf)
 }
 
 static const struct usb_device_id powerz_id_table[] = {
+	{ USB_DEVICE_INTERFACE_NUMBER(0x5FC9, 0x0061, 0x00) },	/* ChargerLAB POWER-Z KM002C */
 	{ USB_DEVICE_INTERFACE_NUMBER(0x5FC9, 0x0063, 0x00) },	/* ChargerLAB POWER-Z KM003C */
 	{ }
 };

---
base-commit: 80369d9e1f2f16993ae6d148553c37bf65a209e4
change-id: 20230911-powerz-km002c-94afb4d3d645

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

