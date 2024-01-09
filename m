Return-Path: <linux-kernel+bounces-20629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4208282B2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17FD71F2376C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E0C29435;
	Tue,  9 Jan 2024 09:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXDIjDdd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C9629410;
	Tue,  9 Jan 2024 09:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF651C433F1;
	Tue,  9 Jan 2024 09:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704791241;
	bh=dSOcicXkDevstKESzuK8GI+KUchpjc7Y4JI1vu4BtEU=;
	h=From:To:Cc:Subject:Date:From;
	b=dXDIjDddKtKhlVJ1zo6hgzHmmHevF42ed2L6EuK9GEQpiV3/PvamCbvGMvNbN2LnF
	 feRMKlu20+MmGjZVhqqJ+sZRfSIryZxvFT+KM7cH5wUkBuHcN/1L3pMDlBnB1qn2Vf
	 68sor1/Pex+OjDtDCTdEk+h4MwikRscwXywxAl1MeON+WWtJ5hA8AConCrti22ocNU
	 7h3Tt8a/6GtX1q5QefqNWayy2yqH2FFu/FMcxQ8tHfhyaYK4buF/vDIh+adtXdLn+j
	 +Lp9ZkA29qVtz+Qsw+iFr+FzXByfS5PKBPc/5u5hVwEG6W3+xARtCM1/7iQDhFtxYa
	 p5aQ8hjU4Ii6g==
From: Arnd Bergmann <arnd@kernel.org>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Arnd Bergmann <arnd@arndb.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] leds: remove led_init_default_state_get() and devm_led_classdev_register_ext() stubs
Date: Tue,  9 Jan 2024 10:06:39 +0100
Message-Id: <20240109090715.982332-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

These two functions have stub implementations that are called when
NEW_LEDS and/or LEDS_CLASS are disabled, theorerically allowing drivers
to optionally use the LED subsystem.

However, this has never really worked because a built-in driver is
unable to link against these functions if the LED class is in a loadable
module. Heiner ran into this problem with a driver that newly gained
a LEDS_CLASS dependency and suggested using an IS_REACHABLE() check.

This is the reverse approach, removing the stub entirely to acknowledge
that it is pointless in its current form, and that not having it avoids
misleading developers into thinking that they can rely on it.

This survived around 1000 randconfig builds to validate that any callers
of the interface already have the correct Kconfig dependency already,
with the exception of the one that Heiner just added.

Cc: Heiner Kallweit <hkallweit1@gmail.com>
Link: https://lore.kernel.org/linux-leds/0f6f432b-c650-4bb8-a1b5-fe3372804d52@gmail.com/T/#u
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/leds.h | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/include/linux/leds.h b/include/linux/leds.h
index 4754b02d3a2c..7598d472903a 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -82,15 +82,7 @@ struct led_init_data {
 	bool devname_mandatory;
 };
 
-#if IS_ENABLED(CONFIG_NEW_LEDS)
 enum led_default_state led_init_default_state_get(struct fwnode_handle *fwnode);
-#else
-static inline enum led_default_state
-led_init_default_state_get(struct fwnode_handle *fwnode)
-{
-	return LEDS_DEFSTATE_OFF;
-}
-#endif
 
 struct led_hw_trigger_type {
 	int dummy;
@@ -279,20 +271,9 @@ static inline int led_classdev_register(struct device *parent,
 	return led_classdev_register_ext(parent, led_cdev, NULL);
 }
 
-#if IS_ENABLED(CONFIG_LEDS_CLASS)
 int devm_led_classdev_register_ext(struct device *parent,
 					  struct led_classdev *led_cdev,
 					  struct led_init_data *init_data);
-#else
-static inline int
-devm_led_classdev_register_ext(struct device *parent,
-			       struct led_classdev *led_cdev,
-			       struct led_init_data *init_data)
-{
-	return 0;
-}
-#endif
-
 static inline int devm_led_classdev_register(struct device *parent,
 					     struct led_classdev *led_cdev)
 {
-- 
2.39.2


