Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AA4765A05
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbjG0RT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbjG0RTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:19:17 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E359E97
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:18:47 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-686f090310dso1089973b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690478327; x=1691083127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ons1xxta0swGIAnIwdRLlCbALo+n6y3A/0xk7/m1SU=;
        b=SfokiBwgQnt8UhhbFv5I1shWcGM9J5SI1rMbCj0QJ2N2vqxr7Tuu5yR7oE6v9wwfuN
         kwvYkGnN6vSgNPVrTQay3TAFNLA7ADB8mEpmllzNsG0WBMqyL7x99KmN7i5/aymLM6JJ
         MLsBMjLADes2LL7Erjs0MpyU/roI0hC714rrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690478327; x=1691083127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ons1xxta0swGIAnIwdRLlCbALo+n6y3A/0xk7/m1SU=;
        b=Po3TyXUk6Srwl8UO+54dd92sjUZM5iNLH92Ev6pxIcyG1DlwOR4yrvC9rbhNuxuJmY
         7yITNCuzKU8tBnnyMMUwVJ5Ireq02v05+Oe/hI/E2zDAiulKxt2TxEwBM8kV6N9FuslY
         5aks7a1oP5Ft3XqS9NaLp01NW4O03Tz5BgxdJLQtpifc8zvT/TpP97pbsK02aTf87eFP
         llAM9YfCV7fUj5pTGK1EhXKUpTOxOT5SDuWlReakTOfww8sMgAqYBoANo/N1EzDP6JuL
         dYpT0CPWBmD994PzQICUcpGl3oSR/bzKJpnt/Ve/l0HrQljWOyCW5eEYsj6TTQrNjwEM
         PWjg==
X-Gm-Message-State: ABy/qLZnL/hdwOQfyJA/sg19BrQo3LjosAvBT9w69jnpfE92Re4fSXpr
        OLdvNDSl1StUZsugXwRudz6Oog==
X-Google-Smtp-Source: APBJJlHHAckGoYXUBhl1ZEzMAmGRJ4AfIdxiVA8Y5wTk4SQjjqdn/7SMOjcbUUpyB2//G6nG0U78BA==
X-Received: by 2002:a05:6300:8082:b0:120:1baf:e56e with SMTP id ap2-20020a056300808200b001201bafe56emr6349964pzc.19.1690478326828;
        Thu, 27 Jul 2023 10:18:46 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:2339:954b:b98f:611a])
        by smtp.gmail.com with ESMTPSA id 17-20020aa79111000000b0064f76992905sm1702524pfh.202.2023.07.27.10.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 10:18:46 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-arm-msm@vger.kernel.org,
        yangcong5@huaqin.corp-partner.google.com,
        devicetree@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        hsinyi@google.com, Chris Morgan <macroalpha82@gmail.com>,
        linux-input@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v4 07/11] HID: i2c-hid: Make suspend and resume into helper functions
Date:   Thu, 27 Jul 2023 10:16:34 -0700
Message-ID: <20230727101636.v4.7.I5c9894789b8b02f029bf266ae9b4f43c7907a173@changeid>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230727171750.633410-1-dianders@chromium.org>
References: <20230727171750.633410-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a future patch we'd like to be able to call the current i2c-hid
suspend and resume functions from times other than system
suspend. Move the functions higher up in the file and have them take a
"struct i2c_hid" to make this simpler. We'll then add tiny wrappers of
the functions for use with system suspend.

This change is expected to have no functional effect.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 drivers/hid/i2c-hid/i2c-hid-core.c | 98 +++++++++++++++++-------------
 1 file changed, 56 insertions(+), 42 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index d29e6421ecba..fa8a1ca43d7f 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -941,6 +941,57 @@ static void i2c_hid_core_shutdown_tail(struct i2c_hid *ihid)
 	ihid->ops->shutdown_tail(ihid->ops);
 }
 
+static int i2c_hid_core_suspend(struct i2c_hid *ihid)
+{
+	struct i2c_client *client = ihid->client;
+	struct hid_device *hid = ihid->hid;
+	int ret;
+
+	ret = hid_driver_suspend(hid, PMSG_SUSPEND);
+	if (ret < 0)
+		return ret;
+
+	/* Save some power */
+	i2c_hid_set_power(ihid, I2C_HID_PWR_SLEEP);
+
+	disable_irq(client->irq);
+
+	if (!device_may_wakeup(&client->dev))
+		i2c_hid_core_power_down(ihid);
+
+	return 0;
+}
+
+static int i2c_hid_core_resume(struct i2c_hid *ihid)
+{
+	struct i2c_client *client = ihid->client;
+	struct hid_device *hid = ihid->hid;
+	int ret;
+
+	if (!device_may_wakeup(&client->dev))
+		i2c_hid_core_power_up(ihid);
+
+	enable_irq(client->irq);
+
+	/* Instead of resetting device, simply powers the device on. This
+	 * solves "incomplete reports" on Raydium devices 2386:3118 and
+	 * 2386:4B33 and fixes various SIS touchscreens no longer sending
+	 * data after a suspend/resume.
+	 *
+	 * However some ALPS touchpads generate IRQ storm without reset, so
+	 * let's still reset them here.
+	 */
+	if (ihid->quirks & I2C_HID_QUIRK_RESET_ON_RESUME)
+		ret = i2c_hid_hwreset(ihid);
+	else
+		ret = i2c_hid_set_power(ihid, I2C_HID_PWR_ON);
+
+	if (ret)
+		return ret;
+
+	return hid_driver_reset_resume(hid);
+}
+
 /**
  * i2c_hid_core_initial_power_up() - First time power up of the i2c-hid device.
  * @ihid: The ihid object created during probe.
@@ -1115,61 +1166,24 @@ void i2c_hid_core_shutdown(struct i2c_client *client)
 }
 EXPORT_SYMBOL_GPL(i2c_hid_core_shutdown);
 
-static int i2c_hid_core_suspend(struct device *dev)
+static int i2c_hid_core_pm_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct i2c_hid *ihid = i2c_get_clientdata(client);
-	struct hid_device *hid = ihid->hid;
-	int ret;
-
-	ret = hid_driver_suspend(hid, PMSG_SUSPEND);
-	if (ret < 0)
-		return ret;
 
-	/* Save some power */
-	i2c_hid_set_power(ihid, I2C_HID_PWR_SLEEP);
-
-	disable_irq(client->irq);
-
-	if (!device_may_wakeup(&client->dev))
-		i2c_hid_core_power_down(ihid);
-
-	return 0;
+	return i2c_hid_core_suspend(ihid);
 }
 
-static int i2c_hid_core_resume(struct device *dev)
+static int i2c_hid_core_pm_resume(struct device *dev)
 {
-	int ret;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct i2c_hid *ihid = i2c_get_clientdata(client);
-	struct hid_device *hid = ihid->hid;
 
-	if (!device_may_wakeup(&client->dev))
-		i2c_hid_core_power_up(ihid);
-
-	enable_irq(client->irq);
-
-	/* Instead of resetting device, simply powers the device on. This
-	 * solves "incomplete reports" on Raydium devices 2386:3118 and
-	 * 2386:4B33 and fixes various SIS touchscreens no longer sending
-	 * data after a suspend/resume.
-	 *
-	 * However some ALPS touchpads generate IRQ storm without reset, so
-	 * let's still reset them here.
-	 */
-	if (ihid->quirks & I2C_HID_QUIRK_RESET_ON_RESUME)
-		ret = i2c_hid_hwreset(ihid);
-	else
-		ret = i2c_hid_set_power(ihid, I2C_HID_PWR_ON);
-
-	if (ret)
-		return ret;
-
-	return hid_driver_reset_resume(hid);
+	return i2c_hid_core_resume(ihid);
 }
 
 const struct dev_pm_ops i2c_hid_core_pm = {
-	SYSTEM_SLEEP_PM_OPS(i2c_hid_core_suspend, i2c_hid_core_resume)
+	SYSTEM_SLEEP_PM_OPS(i2c_hid_core_pm_suspend, i2c_hid_core_pm_resume)
 };
 EXPORT_SYMBOL_GPL(i2c_hid_core_pm);
 
-- 
2.41.0.487.g6d72f3e995-goog

