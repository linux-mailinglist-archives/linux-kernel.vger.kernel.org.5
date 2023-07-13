Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F047527AC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjGMPsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbjGMPrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:47:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740A0270D;
        Thu, 13 Jul 2023 08:47:52 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 990CB6607048;
        Thu, 13 Jul 2023 16:47:48 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689263270;
        bh=NmZWSJBtJogmZ1XmFkqp7N/SRJ1aRoSmIrbWDGiL4Yo=;
        h=From:To:Cc:Subject:Date:From;
        b=TZMD09Y3AycsOcBdEma+Wp2v2dnejJbZ/jERjnsTI/rEa0iyRmq4hPzm4atzRgWxd
         4HQWF+/xlBagQDvhN5/5cWQxxuoYvSmZwG5YAh4fEHmA8xdB7Zbx+uEi8AanCl0QhT
         z4WOQ3o0UCE/l0weymA1twrCVYiDzDkST3X7HXNBV6yBxJP9ILH41reEcLC0gZ7UJs
         r4szl5NTX/NAOBTuld9nrf0onxW5NsxvjZlybR9O1/p8c4ue1SgjIcwN22fUZrqT6l
         GoURnubugZo2c62BYcniSpmDY/+m+LK5t0CerzDnDYd1tmbxegBch9dJtvcLwj0B42
         SoZo5oDDxcFkQ==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Amit Kucheria <amitk@kernel.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yangtao Li <frank.li@vivo.com>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH v2] thermal/drivers/mediatek/lvts_thermal: Make readings valid in filtered mode
Date:   Thu, 13 Jul 2023 11:42:37 -0400
Message-ID: <20230713154743.611870-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when a controller is configured to use filtered mode, thermal
readings are valid only about 30% of the time.

Upon testing, it was noticed that lowering any of the interval settings
resulted in an improved rate of valid data. The same was observed when
decreasing the number of samples for each sensor (which also results in
quicker measurements).

Retrying the read with a timeout longer than the time it takes to
resample (about 344us with these settings and 4 sensors) also improves
the rate.

Lower all timing settings to the minimum, configure the filtering to
single sample, and poll the measurement register for at least one period
to improve the data validity on filtered mode.  With these changes in
place, out of 100000 reads, a single one failed, ie 99.999% of the data
was valid.

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

Changes in v2:
- Added macros for the wait and timeout times (and in the process made the wait
  200us instead of 240us, just to simplify, gives the same result)
- Rebased on thermal/bleeding-edge (since the
  "thermal/drivers/mediatek/lvts_thermal: Fixes to the interrupt handling"
  series was merged)

 drivers/thermal/mediatek/lvts_thermal.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index ea89b29ffe5f..1a3cb118ff32 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -58,11 +58,11 @@
 #define LVTS_PROTTC(__base)		(__base + 0x00CC)
 #define LVTS_CLKEN(__base)		(__base + 0x00E4)
 
-#define LVTS_PERIOD_UNIT			((118 * 1000) / (256 * 38))
-#define LVTS_GROUP_INTERVAL			1
-#define LVTS_FILTER_INTERVAL		1
-#define LVTS_SENSOR_INTERVAL		1
-#define LVTS_HW_FILTER				0x2
+#define LVTS_PERIOD_UNIT			0
+#define LVTS_GROUP_INTERVAL			0
+#define LVTS_FILTER_INTERVAL		0
+#define LVTS_SENSOR_INTERVAL		0
+#define LVTS_HW_FILTER				0x0
 #define LVTS_TSSEL_CONF				0x13121110
 #define LVTS_CALSCALE_CONF			0x300
 #define LVTS_MONINT_CONF			0x8300318C
@@ -86,6 +86,9 @@
 #define LVTS_MSR_IMMEDIATE_MODE		0
 #define LVTS_MSR_FILTERED_MODE		1
 
+#define LVTS_MSR_READ_TIMEOUT_US	400
+#define LVTS_MSR_READ_WAIT_US		(LVTS_MSR_READ_TIMEOUT_US / 2)
+
 #define LVTS_HW_SHUTDOWN_MT8195		105000
 
 #define LVTS_MINIMUM_THRESHOLD		20000
@@ -268,6 +271,7 @@ static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
 	struct lvts_sensor *lvts_sensor = thermal_zone_device_priv(tz);
 	void __iomem *msr = lvts_sensor->msr;
 	u32 value;
+	int rc;
 
 	/*
 	 * Measurement registers:
@@ -280,7 +284,8 @@ static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
 	 * 16	: Valid temperature
 	 * 15-0	: Raw temperature
 	 */
-	value = readl(msr);
+	rc = readl_poll_timeout(msr, value, value & BIT(16),
+				LVTS_MSR_READ_WAIT_US, LVTS_MSR_READ_TIMEOUT_US);
 
 	/*
 	 * As the thermal zone temperature will read before the
@@ -293,7 +298,7 @@ static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
 	 * functionning temperature and directly jump to a system
 	 * shutdown.
 	 */
-	if (!(value & BIT(16)))
+	if (rc)
 		return -EAGAIN;
 
 	*temp = lvts_raw_to_temp(value & 0xFFFF);
-- 
2.41.0

