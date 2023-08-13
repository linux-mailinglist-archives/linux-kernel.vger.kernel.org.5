Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EFA77A7D0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 17:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjHMPu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 11:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbjHMPuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 11:50:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E39172E;
        Sun, 13 Aug 2023 08:50:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17A9D6308C;
        Sun, 13 Aug 2023 15:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8BFC433CB;
        Sun, 13 Aug 2023 15:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691941808;
        bh=DQCVMid+Kv3APLbJLaODg3sH5+RSUiuxHo5XmS285SI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jJxfL9olJlqRrZsyojKG9xFfucu14y1CYrq3azQcAXoZ0Fnu+s+pc+5Mo+B2C3/Sf
         VO32exSmzz+BiZ9X25Y8K1V8tuZT+/JqxpiKm5DKAt9ON1YepHFZYDpK+5vy7kJLeB
         5ia1WYnxxMc4J7qreUYD56VscWilEm6LAf9WNGX77dd/jWehxzw8/nGDyyZsTa1RMc
         9LFw/q6mKy94WUiLxizzkCBJZKDhWJKsBee02aIjeO+tJSFHO9AMt84/w3tNq7UAkB
         NvAAs0AwRX6Pu/ZoFLRUqMvLZc3mjg8Gvy8Q1kFhCL4fKUZON7RO3vC42OpUoUb9wV
         E8nWbMhBwlP3w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, rafael@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 18/54] thermal: core: constify params in thermal_zone_device_register
Date:   Sun, 13 Aug 2023 11:48:57 -0400
Message-Id: <20230813154934.1067569-18-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813154934.1067569-1-sashal@kernel.org>
References: <20230813154934.1067569-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.10
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ahmad Fatoum <a.fatoum@pengutronix.de>

[ Upstream commit 80ddce5f2dbd0e83eadc9f9d373439180d599fe5 ]

Since commit 3d439b1a2ad3 ("thermal/core: Alloc-copy-free the thermal zone
parameters structure"), thermal_zone_device_register() allocates a copy
of the tzp argument and callers need not explicitly manage its lifetime.

This means the function no longer cares about the parameter being
mutable, so constify it.

No functional change.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/thermal_core.c | 4 ++--
 include/linux/thermal.h        | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 842f678c1c3e1..cc2b5e81c6205 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1203,7 +1203,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_crit_temp);
 struct thermal_zone_device *
 thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *trips, int num_trips, int mask,
 					void *devdata, struct thermal_zone_device_ops *ops,
-					struct thermal_zone_params *tzp, int passive_delay,
+					const struct thermal_zone_params *tzp, int passive_delay,
 					int polling_delay)
 {
 	struct thermal_zone_device *tz;
@@ -1371,7 +1371,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_device_register_with_trips);
 
 struct thermal_zone_device *thermal_zone_device_register(const char *type, int ntrips, int mask,
 							 void *devdata, struct thermal_zone_device_ops *ops,
-							 struct thermal_zone_params *tzp, int passive_delay,
+							 const struct thermal_zone_params *tzp, int passive_delay,
 							 int polling_delay)
 {
 	return thermal_zone_device_register_with_trips(type, NULL, ntrips, mask,
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 87837094d549f..dee66ade89a03 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -301,14 +301,14 @@ int thermal_acpi_critical_trip_temp(struct acpi_device *adev, int *ret_temp);
 #ifdef CONFIG_THERMAL
 struct thermal_zone_device *thermal_zone_device_register(const char *, int, int,
 		void *, struct thermal_zone_device_ops *,
-		struct thermal_zone_params *, int, int);
+		const struct thermal_zone_params *, int, int);
 
 void thermal_zone_device_unregister(struct thermal_zone_device *);
 
 struct thermal_zone_device *
 thermal_zone_device_register_with_trips(const char *, struct thermal_trip *, int, int,
 					void *, struct thermal_zone_device_ops *,
-					struct thermal_zone_params *, int, int);
+					const struct thermal_zone_params *, int, int);
 
 void *thermal_zone_device_priv(struct thermal_zone_device *tzd);
 const char *thermal_zone_device_type(struct thermal_zone_device *tzd);
@@ -348,7 +348,7 @@ void thermal_zone_device_critical(struct thermal_zone_device *tz);
 static inline struct thermal_zone_device *thermal_zone_device_register(
 	const char *type, int trips, int mask, void *devdata,
 	struct thermal_zone_device_ops *ops,
-	struct thermal_zone_params *tzp,
+	const struct thermal_zone_params *tzp,
 	int passive_delay, int polling_delay)
 { return ERR_PTR(-ENODEV); }
 static inline void thermal_zone_device_unregister(
-- 
2.40.1

