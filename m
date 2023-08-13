Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7391177A7F2
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 17:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjHMPwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 11:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjHMPwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 11:52:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1E42123;
        Sun, 13 Aug 2023 08:51:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26C06632DE;
        Sun, 13 Aug 2023 15:51:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C159C433C9;
        Sun, 13 Aug 2023 15:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691941909;
        bh=ycF+1MpYLV72vAgLpj05djCAc8L1xc6HcwrON1MCUow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PlavyK5ObkfzxVMyYZJux3dZCL8VsRM/qCLLZO7NkVifdvHSy6SShXzsCSBojifYh
         ZXPjsBoCumUfoQ0hTs7WY80HLfY1SwD1O1kfugfZC/onafZ/WhdGrNWVioFI5TkGiQ
         GRZjVJ3pS2gSMfN+QYjHm9mjTT72j6OynJif43obudpng8reWahr5MR9TfZ1fY1+SV
         2RsW0tf+I2dTaLB7H6TNHsgUjMai6SA4y8MmPuN4TcAElzPIkNUTZyI3NbIgGDg/n4
         b0ewkZsS4LGS5MBmNli+6ebNrCbkqm2VvqHxF4wlXKVeyeE/25N6V21F67/eiTOAcQ
         OSRK9hYpy5tMQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Maxim Mikityanskiy <maxtram95@gmail.com>,
        Sasha Levin <sashal@kernel.org>, alexhung@gmail.com,
        markgross@kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 37/54] platform/x86: intel: hid: Always call BTNL ACPI method
Date:   Sun, 13 Aug 2023 11:49:16 -0400
Message-Id: <20230813154934.1067569-37-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813154934.1067569-1-sashal@kernel.org>
References: <20230813154934.1067569-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.10
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit e3ab18de2b09361d6f0e4aafb9cfd6d002ce43a1 ]

On a HP Elite Dragonfly G2 the 0xcc and 0xcd events for SW_TABLET_MODE
are only send after the BTNL ACPI method has been called.

Likely more devices need this, so make the BTNL ACPI method unconditional
instead of only doing it on devices with a 5 button array.

Note this also makes the intel_button_array_enable() call in probe()
unconditional, that function does its own priv->array check. This makes
the intel_button_array_enable() call in probe() consistent with the calls
done on suspend/resume which also rely on the priv->array check inside
the function.

Reported-by: Maxim Mikityanskiy <maxtram95@gmail.com>
Closes: https://lore.kernel.org/platform-driver-x86/20230712175023.31651-1-maxtram95@gmail.com/
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20230715181516.5173-1-hdegoede@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/hid.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/intel/hid.c
index 5632bd3c534a3..641f2797406e1 100644
--- a/drivers/platform/x86/intel/hid.c
+++ b/drivers/platform/x86/intel/hid.c
@@ -620,7 +620,7 @@ static bool button_array_present(struct platform_device *device)
 static int intel_hid_probe(struct platform_device *device)
 {
 	acpi_handle handle = ACPI_HANDLE(&device->dev);
-	unsigned long long mode;
+	unsigned long long mode, dummy;
 	struct intel_hid_priv *priv;
 	acpi_status status;
 	int err;
@@ -692,18 +692,15 @@ static int intel_hid_probe(struct platform_device *device)
 	if (err)
 		goto err_remove_notify;
 
-	if (priv->array) {
-		unsigned long long dummy;
+	intel_button_array_enable(&device->dev, true);
 
-		intel_button_array_enable(&device->dev, true);
-
-		/* Call button load method to enable HID power button */
-		if (!intel_hid_evaluate_method(handle, INTEL_HID_DSM_BTNL_FN,
-					       &dummy)) {
-			dev_warn(&device->dev,
-				 "failed to enable HID power button\n");
-		}
-	}
+	/*
+	 * Call button load method to enable HID power button
+	 * Always do this since it activates events on some devices without
+	 * a button array too.
+	 */
+	if (!intel_hid_evaluate_method(handle, INTEL_HID_DSM_BTNL_FN, &dummy))
+		dev_warn(&device->dev, "failed to enable HID power button\n");
 
 	device_init_wakeup(&device->dev, true);
 	/*
-- 
2.40.1

