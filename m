Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A6E762393
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjGYUhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjGYUhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:37:31 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAF22706
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:37:15 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-56341268f2fso3071303a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690317434; x=1690922234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLU4GaCp6ltBfg0ajT8nW3f7rOZfzJGhG7FU81YHMIc=;
        b=StVSDcWMfA7TJ+Wp3D7IahafFoAoSFplzVN3xvyQE3lKGASTqWpuH7liiDVdA661//
         WuvraSDsXCp7t3Br6Kq5LtSw/2aZc6JKry7bt58S2lBkYmUsVT/WKJ8Mb07wK+vzu5w/
         vsG0HJJ0OrAU9h8RTO+aWvKhNSPxWSxcQrrdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690317434; x=1690922234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pLU4GaCp6ltBfg0ajT8nW3f7rOZfzJGhG7FU81YHMIc=;
        b=IgkT0yD6KKvb82GuqIJs/x7bfLiXweJwpTRIKGmnlQ+MARay9Nu0hhzVHCCrj3djHU
         abhGYLD0D10WKtDEdUo+NG4tr5Us+0z1HcriWE3RrZcszQljXk4Dog/rrqkyh+vU58cH
         traNyChRUD9JrDZiNLGFb6MBW3TcnCnocjZX3uwJIjN7+e5R5wm2mPfGWLCPqdgWBHLm
         1+IeSl5faoJUWsOFpp9oLIWj8FtjyeozQf2WslFmERs72u/VZ2vxenrELyuw9clqDSql
         Dj4io1qH6O8b8+UynugZX+A3I3pvHWUkHaevJk0wwR5zGmaMNB4DMqbqleUYjovyE4f7
         3gjg==
X-Gm-Message-State: ABy/qLZKlTxT2UhBFpny9UQD8ThUooIvKRfLY6aOgHv3geBJcYAbOGzA
        ZyWny2iysa+82/146PfC0xdY5Q==
X-Google-Smtp-Source: APBJJlEfktDwpmXEzqrjjxC7Zx3JDhTxoTfUhGnVB/nI7JJ8QBFQehaWlH32omPSIBQuWifk0WXkYg==
X-Received: by 2002:a17:90a:c08:b0:267:6ea5:61dd with SMTP id 8-20020a17090a0c0800b002676ea561ddmr222775pjs.15.1690317434661;
        Tue, 25 Jul 2023 13:37:14 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:c363:4681:f5b8:301])
        by smtp.gmail.com with ESMTPSA id bg1-20020a17090b0d8100b002676e961261sm1396951pjb.1.2023.07.25.13.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 13:37:14 -0700 (PDT)
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
Subject: [PATCH v3 08/10] HID: i2c-hid: Support being a panel follower
Date:   Tue, 25 Jul 2023 13:34:43 -0700
Message-ID: <20230725133443.v3.8.Ib1a98309c455cd7e26b931c69993d4fba33bbe15@changeid>
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

As talked about in the patch ("drm/panel: Add a way for other devices
to follow panel state"), we really want to keep the power states of a
touchscreen and the panel it's attached to in sync with each other. In
that spirit, add support to i2c-hid to be a panel follower. This will
let the i2c-hid driver get informed when the panel is powered on and
off. From there we can match the i2c-hid device's power state to that
of the panel.

NOTE: this patch specifically _doesn't_ use pm_runtime to keep track
of / manage the power state of the i2c-hid device, even though my
first instinct said that would be the way to go. Specific problems
with using pm_runtime():
* The initial power up couldn't happen in a runtime resume function
  since it create sub-devices and, apparently, that's not good to do
  in your resume function.
* Managing our power state with pm_runtime meant fighting to make the
  right thing happen at system suspend to prevent the system from
  trying to resume us only to suspend us again. While this might be
  able to be solved, it added complexity.
Overall the code without pm_runtime() ended up being smaller and
easier to understand.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- Add "depends on DRM || !DRM" to Kconfig to avoid randconfig error.
- Split more of the panel follower code out of the core.

Changes in v2:
- i2c_hid_core_panel_prepared() and ..._unpreparing() are now static.

 drivers/hid/i2c-hid/Kconfig        |  2 +
 drivers/hid/i2c-hid/i2c-hid-core.c | 82 +++++++++++++++++++++++++++++-
 2 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/i2c-hid/Kconfig b/drivers/hid/i2c-hid/Kconfig
index 3be17109301a..2bdb55203104 100644
--- a/drivers/hid/i2c-hid/Kconfig
+++ b/drivers/hid/i2c-hid/Kconfig
@@ -70,5 +70,7 @@ config I2C_HID_OF_GOODIX
 
 config I2C_HID_CORE
 	tristate
+	# We need to call into panel code so if DRM=m, this can't be 'y'
+	depends on DRM || !DRM
 endif
 
diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index fa8a1ca43d7f..fa6d1f624342 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -38,6 +38,8 @@
 #include <linux/mutex.h>
 #include <asm/unaligned.h>
 
+#include <drm/drm_panel.h>
+
 #include "../hid-ids.h"
 #include "i2c-hid.h"
 
@@ -107,6 +109,8 @@ struct i2c_hid {
 	struct mutex		reset_lock;
 
 	struct i2chid_ops	*ops;
+	struct drm_panel_follower panel_follower;
+	bool			is_panel_follower;
 };
 
 static const struct i2c_hid_quirks {
@@ -1058,6 +1062,59 @@ static int i2c_hid_core_initial_power_up(struct i2c_hid *ihid)
 	return ret;
 }
 
+static int i2c_hid_core_panel_prepared(struct drm_panel_follower *follower)
+{
+	struct i2c_hid *ihid = container_of(follower, struct i2c_hid, panel_follower);
+	struct hid_device *hid = ihid->hid;
+
+	/*
+	 * hid->version is set on the first power up. If it's still zero then
+	 * this is the first power on so we should perform initial power up
+	 * steps.
+	 */
+	if (!hid->version)
+		return i2c_hid_core_initial_power_up(ihid);
+
+	return i2c_hid_core_resume(ihid);
+}
+
+static int i2c_hid_core_panel_unpreparing(struct drm_panel_follower *follower)
+{
+	struct i2c_hid *ihid = container_of(follower, struct i2c_hid, panel_follower);
+
+	return i2c_hid_core_suspend(ihid);
+}
+
+static const struct drm_panel_follower_funcs i2c_hid_core_panel_follower_funcs = {
+	.panel_prepared = i2c_hid_core_panel_prepared,
+	.panel_unpreparing = i2c_hid_core_panel_unpreparing,
+};
+
+static int i2c_hid_core_register_panel_follower(struct i2c_hid *ihid)
+{
+	struct device *dev = &ihid->client->dev;
+	int ret;
+
+	ihid->is_panel_follower = true;
+	ihid->panel_follower.funcs = &i2c_hid_core_panel_follower_funcs;
+
+	/*
+	 * If we're not in control of our own power up/power down then we can't
+	 * do the logic to manage wakeups. Give a warning if a user thought
+	 * that was possible then force the capability off.
+	 */
+	if (device_can_wakeup(dev)) {
+		dev_warn(dev, "Can't wakeup if following panel\n");
+		device_set_wakeup_capable(dev, false);
+	}
+
+	ret = drm_panel_add_follower(dev, &ihid->panel_follower);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 int i2c_hid_core_probe(struct i2c_client *client, struct i2chid_ops *ops,
 		       u16 hid_descriptor_address, u32 quirks)
 {
@@ -1119,7 +1176,15 @@ int i2c_hid_core_probe(struct i2c_client *client, struct i2chid_ops *ops,
 	hid->bus = BUS_I2C;
 	hid->initial_quirks = quirks;
 
-	ret = i2c_hid_core_initial_power_up(ihid);
+	/*
+	 * If we're a panel follower, we'll register and do our initial power
+	 * up when the panel turns on; otherwise we do it right away.
+	 */
+	if (drm_is_panel_follower(&client->dev))
+		ret = i2c_hid_core_register_panel_follower(ihid);
+	else
+		ret = i2c_hid_core_initial_power_up(ihid);
+
 	if (ret)
 		goto err_mem_free;
 
@@ -1143,7 +1208,14 @@ void i2c_hid_core_remove(struct i2c_client *client)
 	struct i2c_hid *ihid = i2c_get_clientdata(client);
 	struct hid_device *hid;
 
-	i2c_hid_core_power_down(ihid);
+	/*
+	 * If we're a follower, the act of unfollowing will cause us to be
+	 * powered down. Otherwise we need to manually do it.
+	 */
+	if (ihid->is_panel_follower)
+		drm_panel_remove_follower(&ihid->panel_follower);
+	else
+		i2c_hid_core_power_down(ihid);
 
 	hid = ihid->hid;
 	hid_destroy_device(hid);
@@ -1171,6 +1243,9 @@ static int i2c_hid_core_pm_suspend(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct i2c_hid *ihid = i2c_get_clientdata(client);
 
+	if (ihid->is_panel_follower)
+		return 0;
+
 	return i2c_hid_core_suspend(ihid);
 }
 
@@ -1179,6 +1254,9 @@ static int i2c_hid_core_pm_resume(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct i2c_hid *ihid = i2c_get_clientdata(client);
 
+	if (ihid->is_panel_follower)
+		return 0;
+
 	return i2c_hid_core_resume(ihid);
 }
 
-- 
2.41.0.487.g6d72f3e995-goog

