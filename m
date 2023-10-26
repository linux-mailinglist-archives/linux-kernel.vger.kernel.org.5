Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2A67D8107
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 12:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjJZKoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 06:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjJZKoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 06:44:10 -0400
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F4A18D
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 03:44:08 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monoid.al; s=key1;
        t=1698317045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eejMsKVQmTdeCnFDIvmbidoqLiFeEJxUu7JLELUtPa0=;
        b=hsokOoR1og4Hss0rkcmft0ZlDGBVavls+hUlrusjrNg7RQ0V1HLWrNs19aA7o8dqVaLb/b
        cHI66O6dud8OM0K9Kvw3RoWS+1kXTZlyPkdczduvmFweo5/RwsNbeDs7CPiNv3S8Zb2sQs
        PZnO9mT387EebUGt0sd3AjXYAu4Ju39IXJELMv0tS7AByNSuTor/KNsWA5MPLQR4L2sqv6
        U9317AhPisf//nDWKg7inQZmfA5DD7v7v7rF7GzAXCSetgKKQzjMXfceZtygD+NjeatCfA
        aSzT0gzIamWaieKGSuz9CLaWKF75HRu4wn+nhNREF2+wnnpuMWvxmImtvztZQQ==
From:   Ellie Hermaszewska <kernel@monoid.al>
To:     kernel@monoid.al
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Eugene Shalygin <eugene.shalygin@gmail.com>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] hwmon: (asus-ec-sensors) add ROG Crosshair X670E Gene.
Date:   Thu, 26 Oct 2023 18:43:22 +0800
Message-ID: <20231026104332.906357-1-kernel@monoid.al>
In-Reply-To: <df22c0f4-671f-4108-85a0-d1667ec1da77@monoid.al>
References: <df22c0f4-671f-4108-85a0-d1667ec1da77@monoid.al>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,TO_EQ_FM_DIRECT_MX,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only the temp sensors that I can verify are present.

T_Sensor is the temperature reading of a 10kΩ β=3435K NTC thermistor
optionally connected to the T_SENSOR header.

The other sensors are as found on the X670E Hero.

Signed-off-by: Ellie Hermaszewska <kernel@monoid.al>
---
 Documentation/hwmon/asus_ec_sensors.rst |  1 +
 drivers/hwmon/asus-ec-sensors.c         | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
index 7e3cd5b6686f..0bf99ba406dd 100644
--- a/Documentation/hwmon/asus_ec_sensors.rst
+++ b/Documentation/hwmon/asus_ec_sensors.rst
@@ -15,6 +15,7 @@ Supported boards:
  * ROG CROSSHAIR VIII HERO
  * ROG CROSSHAIR VIII IMPACT
  * ROG CROSSHAIR X670E HERO
+ * ROG CROSSHAIR X670E GENE
  * ROG MAXIMUS XI HERO
  * ROG MAXIMUS XI HERO (WI-FI)
  * ROG STRIX B550-E GAMING
diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 51f9c2db403e..36f9e38000d5 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -244,6 +244,8 @@ static const struct ec_sensor_info sensors_family_amd_600[] = {
 	EC_SENSOR("Motherboard", hwmon_temp, 1, 0x00, 0x32),
 	[ec_sensor_temp_vrm] =
 		EC_SENSOR("VRM", hwmon_temp, 1, 0x00, 0x33),
+	[ec_sensor_temp_t_sensor] =
+		EC_SENSOR("T_Sensor", hwmon_temp, 1, 0x00, 0x36),
 	[ec_sensor_temp_water_in] =
 		EC_SENSOR("Water_In", hwmon_temp, 1, 0x01, 0x00),
 	[ec_sensor_temp_water_out] =
@@ -344,6 +346,14 @@ static const struct ec_board_info board_info_crosshair_x670e_hero = {
 	.family = family_amd_600_series,
 };
 
+static const struct ec_board_info board_info_crosshair_x670e_gene = {
+	.sensors = SENSOR_TEMP_CPU | SENSOR_TEMP_CPU_PACKAGE |
+		SENSOR_TEMP_T_SENSOR |
+		SENSOR_TEMP_MB | SENSOR_TEMP_VRM,
+	.mutex_path = ACPI_GLOBAL_LOCK_PSEUDO_PATH,
+	.family = family_amd_600_series,
+};
+
 static const struct ec_board_info board_info_crosshair_viii_dark_hero = {
 	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
 		SENSOR_TEMP_T_SENSOR |
@@ -490,6 +500,8 @@ static const struct dmi_system_id dmi_table[] = {
 					&board_info_crosshair_viii_hero),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR X670E HERO",
 					&board_info_crosshair_x670e_hero),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR X670E GENE",
+					&board_info_crosshair_x670e_gene),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG MAXIMUS XI HERO",
 					&board_info_maximus_xi_hero),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG MAXIMUS XI HERO (WI-FI)",
-- 
2.42.0

