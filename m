Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9EF79C369
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240944AbjILC5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240885AbjILC5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:57:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7CD8687;
        Mon, 11 Sep 2023 19:27:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B6DC116D3;
        Mon, 11 Sep 2023 23:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694476309;
        bh=O51TPHPv0vx9Va2ahIAKgXHju3NJ2XLpNP3C/snr7LI=;
        h=From:Date:Subject:To:Cc:From;
        b=X4DmisIv6DcHzbP3vH5WlTFYs1wN8/p5DZnPcRWp/5s5FRFNUNTAyHNzT8mwNgzdd
         p2C8M+GIzcqnbNBrI/GCohmuPkkvEBSxtFQqjj+sPkAs66hTzu3saLBZgay7HqheNn
         7oQRuiHaMxJgSRJW/cwLylCnQDTu5/5Zcr+wBp+zG6Vorv+tjEk5xzcea6x7mUDhsb
         pp3whpY1kemWx0icdosrGg9RmxMKFmGK1CQVHzupxuDmfUGZTM6zRI8yR2Z1bPdDvw
         LxKe16n8GvCQ/M6/ydCmoZiM1O6gt+9ok9wiYk1/gsEUq59OBo9y/SFZf1qCBrKbnQ
         GtRMKLqAV5DZQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 12 Sep 2023 00:51:31 +0100
Subject: [PATCH v2] thermal/drivers/sun8i: Don't fail probe due to zone
 registration failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-thermal-sun8i-registration-v2-1-077230107768@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAKo/2QC/42NQQ6CMBBFr0Jm7ZiWqqAr72FYlDLARGzNFImG9
 O5WTuDy/fz//gqRhCnCpVhBaOHIwWcodwW40fqBkLvMUKrSqErXOI8kDzthfPmaUWjgOIud8wy
 73lhtTs7Z3kIWPIV6fm/yW5N5zNUgn+1r0b/0L+2iUaM7H1vdqkqZg7reSTxN+yADNCmlL+0zn
 lDFAAAA
To:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Hugh Dickins <hughd@google.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2897; i=broonie@kernel.org;
 h=from:subject:message-id; bh=O51TPHPv0vx9Va2ahIAKgXHju3NJ2XLpNP3C/snr7LI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBk/6gQEtpSKlDmTGduA8wY6QsbTwt1arXoB0wF0
 79/7Zyn05uJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZP+oEAAKCRAk1otyXVSH
 0BaVB/9WtYVIg1ZP3KyPiDQfBXZ3V7+rCO9TPW4BwQY/t5SItapzsT/Bex46sy1RyRGkRGjgIX9
 rPl9HJ39X+fPoSnQgejUs87LZ9UdvNrop3BedW5GWdZ/HS5Apu2mc7P8T07j6Gc6zEJhdCR8SeE
 kzC01H5zRq3swmUNuXm8fsm3pnaCjzob36wCl2l6DkPdJ/OrfqGUkT0gBNZdYnqbAq3WuOHteLE
 uaA4gMphJbUCGZuIvn4uZtDMXBjc7FWLsxQJMP7z7DNMJGrXpKu5kce46Vxe/PITSvHo4dBvr2X
 LEvJ/rRe0cDZiLipBNQ9YypCoJx9G1bII625iu3ut+zL8llZ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the sun8i thermal driver will fail to probe if any of the
thermal zones it is registering fails to register with the thermal core.
Since we currently do not define any trip points for the GPU thermal
zones on at least A64 or H5 this means that we have no thermal support
on these platforms:

[    1.698703] thermal_sys: Failed to find 'trips' node
[    1.698707] thermal_sys: Failed to find trip points for thermal-sensor id=1

even though the main CPU thermal zone on both SoCs is fully configured.
This does not seem ideal, while we may not be able to use all the zones
it seems better to have those zones which are usable be operational.
Instead just carry on registering zones if we get any non-deferral
error, allowing use of those zones which are usable.

This means that we also need to update the interrupt handler to not
attempt to notify the core for events on zones which we have not
registered, I didn't see an ability to mask individual interrupts and
I would expect that interrupts would still be indicated in the ISR even
if they were masked.

Reviewed-by: Vasily Khoruzhick <anarsoul@gmail.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Rebase onto v6.6-rc1.
- Link to v1: https://lore.kernel.org/r/20230718-thermal-sun8i-registration-v1-1-c95b1b070340@kernel.org
---
 drivers/thermal/sun8i_thermal.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index f989b55a8aa8..14ff0346584b 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -188,6 +188,9 @@ static irqreturn_t sun8i_irq_thread(int irq, void *data)
 	int i;
 
 	for_each_set_bit(i, &irq_bitmap, tmdev->chip->sensor_num) {
+		/* We allow some zones to not register. */
+		if (IS_ERR(tmdev->sensor[i].tzd))
+			continue;
 		thermal_zone_device_update(tmdev->sensor[i].tzd,
 					   THERMAL_EVENT_UNSPECIFIED);
 	}
@@ -465,8 +468,17 @@ static int sun8i_ths_register(struct ths_device *tmdev)
 						      i,
 						      &tmdev->sensor[i],
 						      &ths_ops);
-		if (IS_ERR(tmdev->sensor[i].tzd))
-			return PTR_ERR(tmdev->sensor[i].tzd);
+
+		/*
+		 * If an individual zone fails to register for reasons
+		 * other than probe deferral (eg, a bad DT) then carry
+		 * on, other zones might register successfully.
+		 */
+		if (IS_ERR(tmdev->sensor[i].tzd)) {
+			if (PTR_ERR(tmdev->sensor[i].tzd) == -EPROBE_DEFER)
+				return PTR_ERR(tmdev->sensor[i].tzd);
+			continue;
+		}
 
 		devm_thermal_add_hwmon_sysfs(tmdev->dev, tmdev->sensor[i].tzd);
 	}

---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230718-thermal-sun8i-registration-df3a136ccafa

Best regards,
-- 
Mark Brown <broonie@kernel.org>

