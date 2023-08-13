Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D4777A873
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjHMQCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbjHMQCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:02:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A06C2694;
        Sun, 13 Aug 2023 09:01:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBF7D63512;
        Sun, 13 Aug 2023 16:01:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B205C433C9;
        Sun, 13 Aug 2023 16:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691942491;
        bh=1IQvXCc2XxngrZZ5LpFHbstwUHnokwcIkOEoeJcq/sc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u3sVQeZhmGzIdauSUdBafteVA+STMIbDw2CvfGGEqr64kdlymEK08nxcJfyPnseXL
         Vp8soKJZ5x/nJdduME6/aL5yK/WCLIIYpIpCXUsYpKvNe9k8auzPUq3pYBKY7lqifC
         6eIcn6ZEMiNGnFTXAlY4U40DzQZMiT27mCl/F+zPGC5eky+qrzjKGtiffNqOr6W16X
         glUyzgxAhMVfdx/eQxXEA+Vc7rip5s7nkLPr12+6O6sII/vVmVhpZEBf7Kd9aDhbBl
         lnkeBR9jH4MgYE+NwoqMFfTOK1DKfP+QynJ/6x35r5HP6hfx9Ga25uotcrqm36j0jU
         WLoog68dSm0HQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, rafael@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 16/47] thermal: core: constify params in thermal_zone_device_register
Date:   Sun, 13 Aug 2023 11:59:11 -0400
Message-Id: <20230813160006.1073695-16-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813160006.1073695-1-sashal@kernel.org>
References: <20230813160006.1073695-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.45
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index 1eae4ec719a8f..2d5085488733e 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1178,7 +1178,7 @@ static void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms
 struct thermal_zone_device *
 thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *trips, int num_trips, int mask,
 					void *devdata, struct thermal_zone_device_ops *ops,
-					struct thermal_zone_params *tzp, int passive_delay,
+					const struct thermal_zone_params *tzp, int passive_delay,
 					int polling_delay)
 {
 	struct thermal_zone_device *tz;
@@ -1335,7 +1335,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_device_register_with_trips);
 
 struct thermal_zone_device *thermal_zone_device_register(const char *type, int ntrips, int mask,
 							 void *devdata, struct thermal_zone_device_ops *ops,
-							 struct thermal_zone_params *tzp, int passive_delay,
+							 const struct thermal_zone_params *tzp, int passive_delay,
 							 int polling_delay)
 {
 	return thermal_zone_device_register_with_trips(type, NULL, ntrips, mask,
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 5e093602e8fcd..a339d3af9f9f4 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -337,14 +337,14 @@ static inline void devm_thermal_of_zone_unregister(struct device *dev,
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
 
 int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
 				     struct thermal_cooling_device *,
@@ -378,7 +378,7 @@ void thermal_zone_device_critical(struct thermal_zone_device *tz);
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

