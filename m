Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1B6762399
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjGYUhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjGYUhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:37:32 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4412724
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:37:17 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2682e33509bso1118614a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690317437; x=1690922237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwFg3zsWqs3v6aVHVxyVzqQhxIAjeJPLZHSa2wy+9Ws=;
        b=YEAWKLjWr/L+vjIF/bsCu89PM2D3kj1DnycpkaOmYXw/LwIxNJYxpJT5SL8xqbGgfh
         /blJGOH8ksO8YsSrNyYG9OCGGJzuY7bFfdwIwKg+FTXFyHptWrhtVCmkpQuWGGvzsS+H
         6AxQXIA/4EMMdpwOdUybjh0Pskkt21KKVgBgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690317437; x=1690922237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwFg3zsWqs3v6aVHVxyVzqQhxIAjeJPLZHSa2wy+9Ws=;
        b=XY7gz6fXcjPRq9xS0ZnvSFZcNurkJQfT1irDfsw/AH64bE0Z1lo6lCfFcF/dzZd69S
         7RpxI/ffMlrycX5TOGBiFu3bqMKaoYmfgVxoDBSnKAfBiKFbY8ElDXj8982wgnIm80VN
         aqLMF/bWFFcEgAyXMQjndwxcKjchupkAqKdT7DY6/i7TX4rnzeSeg0CwABF74DqA95TW
         oAHSJrWICFQj2Yb++6rAOk27wisJfk4lNgvQCyApmVuEw+V+QtE7/V0Hjw7x1DIChvdh
         dPWg9bnnYtTvVKQmjIZ1qePpfbc+ma5rAX9RfWE95vlbaBbzNbAEi94zWuS9jWemF18m
         pHmQ==
X-Gm-Message-State: ABy/qLZ4K6nX93yj24h4mDo4pjOM0Mg++gAGuDgiFyx13OPEJC65l7ln
        E82o/+iEM2kDAEuDQoCjeI/XsQ==
X-Google-Smtp-Source: APBJJlHdQjvaPQjzafgjxD6Hh0+jIBP031nwcf3BkzInMUar0z4GEhlrH8PgUSsjP88Dg5AcKCIMPA==
X-Received: by 2002:a17:90a:a406:b0:268:7eb:f599 with SMTP id y6-20020a17090aa40600b0026807ebf599mr232634pjp.30.1690317437028;
        Tue, 25 Jul 2023 13:37:17 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:c363:4681:f5b8:301])
        by smtp.gmail.com with ESMTPSA id bg1-20020a17090b0d8100b002676e961261sm1396951pjb.1.2023.07.25.13.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 13:37:16 -0700 (PDT)
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
Cc:     cros-qcom-dts-watchers@chromium.org,
        Chris Morgan <macroalpha82@gmail.com>,
        linux-input@vger.kernel.org, hsinyi@google.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        devicetree@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        yangcong5@huaqin.corp-partner.google.com,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v3 09/10] HID: i2c-hid: Do panel follower work on the system_wq
Date:   Tue, 25 Jul 2023 13:34:44 -0700
Message-ID: <20230725133443.v3.9.I962bb462ede779005341c49320740ed95810021d@changeid>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230725203545.2260506-1-dianders@chromium.org>
References: <20230725203545.2260506-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turning on an i2c-hid device can be a slow process. This is why
i2c-hid devices use PROBE_PREFER_ASYNCHRONOUS. Unfortunately, when
we're a panel follower the i2c-hid power up sequence now blocks the
power on of the panel. Let's fix that by scheduling the work on the
system_wq.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v2)

Changes in v2:
- ihid_core_panel_prepare_work() is now static.
- Improve documentation for smp_wmb().

 drivers/hid/i2c-hid/i2c-hid-core.c | 50 +++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index fa6d1f624342..6940e74d8acb 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -110,7 +110,9 @@ struct i2c_hid {
 
 	struct i2chid_ops	*ops;
 	struct drm_panel_follower panel_follower;
+	struct work_struct	panel_follower_prepare_work;
 	bool			is_panel_follower;
+	bool			prepare_work_finished;
 };
 
 static const struct i2c_hid_quirks {
@@ -1062,10 +1064,12 @@ static int i2c_hid_core_initial_power_up(struct i2c_hid *ihid)
 	return ret;
 }
 
-static int i2c_hid_core_panel_prepared(struct drm_panel_follower *follower)
+static void ihid_core_panel_prepare_work(struct work_struct *work)
 {
-	struct i2c_hid *ihid = container_of(follower, struct i2c_hid, panel_follower);
+	struct i2c_hid *ihid = container_of(work, struct i2c_hid,
+					    panel_follower_prepare_work);
 	struct hid_device *hid = ihid->hid;
+	int ret;
 
 	/*
 	 * hid->version is set on the first power up. If it's still zero then
@@ -1073,15 +1077,52 @@ static int i2c_hid_core_panel_prepared(struct drm_panel_follower *follower)
 	 * steps.
 	 */
 	if (!hid->version)
-		return i2c_hid_core_initial_power_up(ihid);
+		ret = i2c_hid_core_initial_power_up(ihid);
+	else
+		ret = i2c_hid_core_resume(ihid);
 
-	return i2c_hid_core_resume(ihid);
+	if (ret)
+		dev_warn(&ihid->client->dev, "Power on failed: %d\n", ret);
+	else
+		WRITE_ONCE(ihid->prepare_work_finished, true);
+
+	/*
+	 * The work APIs provide a number of memory ordering guarantees
+	 * including one that says that memory writes before schedule_work()
+	 * are always visible to the work function, but they don't appear to
+	 * guarantee that a write that happened in the work is visible after
+	 * cancel_work_sync(). We'll add a write memory barrier here to match
+	 * with i2c_hid_core_panel_unpreparing() to ensure that our write to
+	 * prepare_work_finished is visible there.
+	 */
+	smp_wmb();
+}
+
+static int i2c_hid_core_panel_prepared(struct drm_panel_follower *follower)
+{
+	struct i2c_hid *ihid = container_of(follower, struct i2c_hid, panel_follower);
+
+	/*
+	 * Powering on a touchscreen can be a slow process. Queue the work to
+	 * the system workqueue so we don't block the panel's power up.
+	 */
+	WRITE_ONCE(ihid->prepare_work_finished, false);
+	schedule_work(&ihid->panel_follower_prepare_work);
+
+	return 0;
 }
 
 static int i2c_hid_core_panel_unpreparing(struct drm_panel_follower *follower)
 {
 	struct i2c_hid *ihid = container_of(follower, struct i2c_hid, panel_follower);
 
+	cancel_work_sync(&ihid->panel_follower_prepare_work);
+
+	/* Match with ihid_core_panel_prepare_work() */
+	smp_rmb();
+	if (!READ_ONCE(ihid->prepare_work_finished))
+		return 0;
+
 	return i2c_hid_core_suspend(ihid);
 }
 
@@ -1149,6 +1190,7 @@ int i2c_hid_core_probe(struct i2c_client *client, struct i2chid_ops *ops,
 
 	init_waitqueue_head(&ihid->wait);
 	mutex_init(&ihid->reset_lock);
+	INIT_WORK(&ihid->panel_follower_prepare_work, ihid_core_panel_prepare_work);
 
 	/* we need to allocate the command buffer without knowing the maximum
 	 * size of the reports. Let's use HID_MIN_BUFFER_SIZE, then we do the
-- 
2.41.0.487.g6d72f3e995-goog

