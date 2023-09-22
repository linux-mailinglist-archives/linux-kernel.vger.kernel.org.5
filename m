Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9347ABA06
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 21:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbjIVT1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 15:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjIVT1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 15:27:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707CFB9;
        Fri, 22 Sep 2023 12:27:31 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7B85266072E7;
        Fri, 22 Sep 2023 20:27:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695410850;
        bh=8fJ99vinwBbNMB5vLrS3phKoWaPj8xZQRk/04iAxlp4=;
        h=From:To:Cc:Subject:Date:From;
        b=BPMLsU9twchJaE3d7Ibqqx6sffOiNGT3NtYP8/dNH/bGOQzjmP2UE8nj1rL2V1tGt
         uv37haffS2nQb3Wzt/ksDAQ3N9EmRF1RvJkXgBb5Umro+xq+JtPJ//aVwpuN1jBgYT
         s45Xuc6v0ofSrJRi22dMN2kl9xi2ah7QnPBBmcIMNQ9TPKX3tZNkM8xvQ13osV5VdF
         v/p5qrjjI0cwjxwJPZBHJyXqY/2ixy6UJmC3GO/RCKNmRWVaurMus5wtYYZf4AqG8g
         ZRuXUDezBbC+7gvznJnAxFAlqTLsc42huaAJxNWTtwM3o2IAWHA4suHfns1QW9qZRh
         xQKiRH+ZmBHRg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH] thermal: core: Check correct temperature for thermal trip notification
Date:   Fri, 22 Sep 2023 15:27:18 -0400
Message-ID: <20230922192724.295129-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal trip down notification should be triggered when the
temperature goes below the trip temperature minus the hysteresis. But
while the temperature is correctly checked against that, the last
temperature is instead compared against the trip point temperature. The
end result is that the notification won't always be triggered, only when
the temperature happens to drop quick enough so that the last
temperature was still above the trip point temperature.

Fix the incorrect check.

Fixes: 55cdf0a283b8 ("thermal: core: Add notifications call in the framework")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 drivers/thermal/thermal_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 58533ea75cd9..120fcf23b8e5 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -361,7 +361,7 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip_id)
 		    tz->temperature >= trip.temperature)
 			thermal_notify_tz_trip_up(tz->id, trip_id,
 						  tz->temperature);
-		if (tz->last_temperature >= trip.temperature &&
+		if (tz->last_temperature >= (trip.temperature - trip.hysteresis) &&
 		    tz->temperature < (trip.temperature - trip.hysteresis))
 			thermal_notify_tz_trip_down(tz->id, trip_id,
 						    tz->temperature);
-- 
2.42.0

