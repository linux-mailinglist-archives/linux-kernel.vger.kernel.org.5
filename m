Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D8A7CEE6C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 05:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjJSD1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 23:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJSD1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 23:27:35 -0400
X-Greylist: delayed 314 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 Oct 2023 20:27:32 PDT
Received: from out-201.mta1.migadu.com (out-201.mta1.migadu.com [IPv6:2001:41d0:203:375::c9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074C0121
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 20:27:31 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monoid.al; s=key1;
        t=1697685733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Tnl+EruaCha2otXKuR/FBsuzKY4Vfaq7M8pGpL8/h8k=;
        b=ev8txUR7RTEi4fTtLpzha2EqorV1lRrYzpFL1+RguOYeBIoKizJdmbd7vk7U9u16brHp1B
        Na/tjM8UeUjHPnIeC1XwTK5pP62tpj6pV5jqYvGtW+9hhx9fgeZW+aMmlJXrNpqJ0RC2HT
        lX286vA01PfDrAXWUqnDRqzez+03OJaY8X3dbPMXVqhz3eKML8radXpwERY3FfZ68sgQ/n
        WW4leN1uQ/9nbPiNbuhshRjaWQrI35erT1nwva+CnpZ/wVE4Q84lu04XO9IoJ8N4f8ism8
        LY8W43hCl+i2pNdaMDXM/8BFVITIL2u8EalzZJsJQnVkJtMK1auFIh0jcNqOMQ==
From:   Ellie Hermaszewska <kernel@monoid.al>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ellie Hermaszewska <kernel@monoid.al>
Subject: [PATCH] hwmon: (asus-ec-sensors) add ROG Crosshair X670E Gene.
Date:   Thu, 19 Oct 2023 11:21:22 +0800
Message-ID: <20231019032122.1594649-1-kernel@monoid.al>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only the temp sensors that I can verify are present. T_Sensor is the
temperature reading of a 10kΩ β=3435K NTC thermistor optionally
connected to the T_SENSOR header.

Signed-off-by: Ellie Hermaszewska <kernel@monoid.al>
---
 drivers/hwmon/asus-ec-sensors.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

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

