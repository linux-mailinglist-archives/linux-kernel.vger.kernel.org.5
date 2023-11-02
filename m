Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2319C7DEB29
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 04:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346751AbjKBDJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 23:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347265AbjKBDJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 23:09:34 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F409F;
        Wed,  1 Nov 2023 20:09:32 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9c3aec5f326so311392866b.1;
        Wed, 01 Nov 2023 20:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698894570; x=1699499370; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3Ws5cIdqhbDjyHMeqOLI87dAIVT3SXF9kKQ0h2q3cUw=;
        b=STUw6btNTuZQ25gfQDNmqhEvQpFF81DZhTirFbU8F0GOW9YiT4OZFGBNItMnHbXG79
         dV8qztqc4mNAKJqneKNgjkrrKO7+FLULvT9Ugvjp8D8E3+yq2WUGRsKuaucP/r12Oc+F
         IPFcjzz1/uskoUj5p+BJwSpzzK6NIdTDJD/aaD+SRTUdLxrgSVNI6a2Duw7nzDfDdAIF
         9At/VB+VUV244lVL5sXrqAtbg51zUzGTOR2Ckwai0+8bJxg8an+Cfc2OSYAvuVcJJFxT
         kyD0rzG59XpxvVJkcA9NRD1pSUtVR/bI83jQ2aDvR0hGp4mhwaOPKdmS7AB5WaHKYxOS
         QpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698894570; x=1699499370;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Ws5cIdqhbDjyHMeqOLI87dAIVT3SXF9kKQ0h2q3cUw=;
        b=FS6jPiD9ruMo2F1bBR6OWVujwrhzCxGRFLfJ9lcAG7iJ/cSvXp6MsPnSNvb8NOcmVi
         e5EvNTTyiez72jpLHdfcYKmi9hetIaL9vUuzRwHkb80kcqb7Bw9jchF0K/tUiFiRpy9R
         J3bWmgx6jpTOXPf8KndzgVmW1DrkiHESPG8sa0bxJmkY/I4ZD7unexBG4joxzL2ylAIK
         ViO3INJ8DRMKY8GoTS/Q3wHfNZdUR4tgKrAtNJTezy1FyEIuUdCLEunJg2ThoTdvo26v
         mkZzBljRtRWjbZ1tddtjvVogswzev/8hI/4wulVRsUkSy3v4XtZmlhTv7LW0Fn2QWYLg
         VtEw==
X-Gm-Message-State: AOJu0YxEGFdZHPA1kJpkxOvJtm/MOmDCfPGlkFIR3pogIljdbh8v7QI2
        eB1YXzle2XwJ+ZRVDDnSj9yfYNJqEAsjYWR9vQY=
X-Google-Smtp-Source: AGHT+IFAtl+rLYtejtLai72vFFnNvc5TovGXtJmqRU+tQdEzKZe5Vm43nbzb/yHXv0fz4InrCD418r/OL1G6d6rWDgM=
X-Received: by 2002:a17:906:248e:b0:9db:6437:ef42 with SMTP id
 e14-20020a170906248e00b009db6437ef42mr751502ejb.18.1698894570207; Wed, 01 Nov
 2023 20:09:30 -0700 (PDT)
MIME-Version: 1.0
From:   sean yang <seanyang230@gmail.com>
Date:   Thu, 2 Nov 2023 11:09:18 +0800
Message-ID: <CADGqjFLEJ8WK+_DHJo4APfJGkDf8PLNRR0JboEVk2TL2oC2iog@mail.gmail.com>
Subject: [PATCH] driver: thermal: simplify the traverse of sensor in thermal_zone.
To:     xinglong.yang@cixtech.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The number of sensor in a thermal zone needs to be greater than zero
and equal to one. Add the opinion when the number of sensor is greater
than one in a thermal zone.

There is also no need to traverse the sensor in the thermal zone,
because there is only one sensor on one thermal zone.

Signed-off-by: xinglong.yang <xinglong.yang@cixtech.com>
---
 drivers/thermal/thermal_of.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index e615f735f4c0..a405754c42cd 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -186,6 +186,7 @@ static struct device_node
*of_thermal_zone_find(struct device_node *sensor, int
  for_each_available_child_of_node(np, tz) {

  int count, i;
+ int ret;

  count = of_count_phandle_with_args(tz, "thermal-sensors",
     "#thermal-sensor-cells");
@@ -193,26 +194,25 @@ static struct device_node
*of_thermal_zone_find(struct device_node *sensor, int
  pr_err("%pOFn: missing thermal sensor\n", tz);
  tz = ERR_PTR(-EINVAL);
  goto out;
+ } else if (count > 1) {
+ pr_err("%pOFn: number of thermal sensor greater than one\n", tz);
+ tz = ERR_PTR(-EINVAL);
+ goto out;
  }

- for (i = 0; i < count; i++) {
-
- int ret;
-
- ret = of_parse_phandle_with_args(tz, "thermal-sensors",
- "#thermal-sensor-cells",
- i, &sensor_specs);
- if (ret < 0) {
- pr_err("%pOFn: Failed to read thermal-sensors cells: %d\n", tz, ret);
- tz = ERR_PTR(ret);
- goto out;
- }
+ ret = of_parse_phandle_with_args(tz, "thermal-sensors",
+ "#thermal-sensor-cells",
+ 0, &sensor_specs);
+ if (ret < 0) {
+ pr_err("%pOFn: Failed to read thermal-sensors cells: %d\n", tz, ret);
+ tz = ERR_PTR(ret);
+ goto out;
+ }

- if ((sensor == sensor_specs.np) && id == (sensor_specs.args_count ?
-   sensor_specs.args[0] : 0)) {
- pr_debug("sensor %pOFn id=%d belongs to %pOFn\n", sensor, id, tz);
- goto out;
- }
+ if ((sensor == sensor_specs.np) && id == (sensor_specs.args_count ?
+   sensor_specs.args[0] : 0)) {
+ pr_debug("sensor %pOFn id=%d belongs to %pOFn\n", sensor, id, tz);
+ goto out;
  }
  }
  tz = ERR_PTR(-ENODEV);
-- 
2.42.0
