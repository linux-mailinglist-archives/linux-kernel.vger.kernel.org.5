Return-Path: <linux-kernel+bounces-110912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7660886594
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 04:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB4D01C21A6D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 03:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFB1BA37;
	Fri, 22 Mar 2024 03:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="im2xGGgZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D0E12E7D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 03:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711078742; cv=none; b=koIOTwzKF4I7efFxlt2bTw7XXmLREKJX9AsrAAVoA9V20DAONRbouVD3jia82RGZt58yXUjJ2E7XBUiwVPfCQ7jDCE3l3B0GeLEazYfyU8sfiqYMg+W/fFoEkkZr1bDriFZl7d+0nTX8zKNr9kYyq9dfx+x3r3/uysnz9eVGSNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711078742; c=relaxed/simple;
	bh=dIniFlLXgncFuChWdqCQcamcoShrJUnDq2s6kqoi4Gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJ/xQE9wrvfAWob6vC/CLvxp3Y9hc4HO4mxP+DHeDyAL8XYMUEMuj6Jf8LvjTNgyYFzJWBSjTQcszGNiNRAa91M9aL75pOH05deogtDfsaOZVRRHkJ+oRPsQ3UVTuCH3uASmzLBUec5AcsR3HR7lIwuBji7Oe1UhGSJBB+P60Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=im2xGGgZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711078740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SFRC3KFOBfrVw1UPcts1Uq3y+FPq0+2ryL6PXXYRdMY=;
	b=im2xGGgZrWQ/HAvLrkRK2XZxKBdlQd94acEhr4xCa9yt+6l+yarh8STOchRM8FmA14a5+G
	djYP8BFIOd3t9ykzII/FI2d4bztJLm3ZfzUxGX47ko7F7Mtxcx2JVT72IzPZ0SZ13XXjjC
	38fPeIQZQUoPdfFOIqNxov/TsFXaqKE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-LuU-5TRZOxO2lJuNTSBdiA-1; Thu,
 21 Mar 2024 23:38:57 -0400
X-MC-Unique: LuU-5TRZOxO2lJuNTSBdiA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C9293C02760;
	Fri, 22 Mar 2024 03:38:56 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.34])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 29EF0200E1AD;
	Fri, 22 Mar 2024 03:38:50 +0000 (UTC)
From: Kate Hsuan <hpa@redhat.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	linux-leds@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Kate Hsuan <hpa@redhat.com>
Subject: [PATCH v5 5/6] power: supply: power-supply-leds: Add charging_red_full_green trigger for RGB LED
Date: Fri, 22 Mar 2024 11:37:35 +0800
Message-ID: <20240322033736.9344-6-hpa@redhat.com>
In-Reply-To: <20240322033736.9344-1-hpa@redhat.com>
References: <20240322033736.9344-1-hpa@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Add a charging_red_full_green LED trigger and the trigger is based on
led_mc_trigger_event() which can set an RGB LED when the trigger is
triggered. The LED will show red when the battery status is charging.
The LED will show green when the battery status is full.

Link: https://lore.kernel.org/linux-leds/f40a0b1a-ceac-e269-c2dd-0158c5b4a1ad@gmail.com/T/#t
Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
 drivers/power/supply/power_supply_leds.c | 25 ++++++++++++++++++++++++
 include/linux/power_supply.h             |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/drivers/power/supply/power_supply_leds.c b/drivers/power/supply/power_supply_leds.c
index c7db29d5fcb8..bd9c8fec5870 100644
--- a/drivers/power/supply/power_supply_leds.c
+++ b/drivers/power/supply/power_supply_leds.c
@@ -22,6 +22,8 @@
 static void power_supply_update_bat_leds(struct power_supply *psy)
 {
 	union power_supply_propval status;
+	unsigned int intensity_green[3] = {255, 0, 0};
+	unsigned int intensity_red[3] = {0, 0, 255};
 
 	if (power_supply_get_property(psy, POWER_SUPPLY_PROP_STATUS, &status))
 		return;
@@ -36,12 +38,20 @@ static void power_supply_update_bat_leds(struct power_supply *psy)
 		/* Going from blink to LED on requires a LED_OFF event to stop blink */
 		led_trigger_event(psy->charging_blink_full_solid_trig, LED_OFF);
 		led_trigger_event(psy->charging_blink_full_solid_trig, LED_FULL);
+		led_mc_trigger_event(psy->charging_red_full_green_trig,
+				     intensity_green,
+				     3,
+				     LED_FULL);
 		break;
 	case POWER_SUPPLY_STATUS_CHARGING:
 		led_trigger_event(psy->charging_full_trig, LED_FULL);
 		led_trigger_event(psy->charging_trig, LED_FULL);
 		led_trigger_event(psy->full_trig, LED_OFF);
 		led_trigger_blink(psy->charging_blink_full_solid_trig, 0, 0);
+		led_mc_trigger_event(psy->charging_red_full_green_trig,
+				     intensity_red,
+				     3,
+				     LED_FULL);
 		break;
 	default:
 		led_trigger_event(psy->charging_full_trig, LED_OFF);
@@ -49,6 +59,10 @@ static void power_supply_update_bat_leds(struct power_supply *psy)
 		led_trigger_event(psy->full_trig, LED_OFF);
 		led_trigger_event(psy->charging_blink_full_solid_trig,
 			LED_OFF);
+		led_mc_trigger_event(psy->charging_red_full_green_trig,
+				     intensity_red,
+				     3,
+				     LED_OFF);
 		break;
 	}
 }
@@ -74,6 +88,11 @@ static int power_supply_create_bat_triggers(struct power_supply *psy)
 	if (!psy->charging_blink_full_solid_trig_name)
 		goto charging_blink_full_solid_failed;
 
+	psy->charging_red_full_green_trig_name = kasprintf(GFP_KERNEL,
+		"%s-charging-red-full-green", psy->desc->name);
+	if (!psy->charging_red_full_green_trig_name)
+		goto charging_red_full_green_failed;
+
 	led_trigger_register_simple(psy->charging_full_trig_name,
 				    &psy->charging_full_trig);
 	led_trigger_register_simple(psy->charging_trig_name,
@@ -82,9 +101,13 @@ static int power_supply_create_bat_triggers(struct power_supply *psy)
 				    &psy->full_trig);
 	led_trigger_register_simple(psy->charging_blink_full_solid_trig_name,
 				    &psy->charging_blink_full_solid_trig);
+	led_trigger_register_simple(psy->charging_red_full_green_trig_name,
+				    &psy->charging_red_full_green_trig);
 
 	return 0;
 
+charging_red_full_green_failed:
+	kfree(psy->charging_blink_full_solid_trig_name);
 charging_blink_full_solid_failed:
 	kfree(psy->full_trig_name);
 full_failed:
@@ -101,10 +124,12 @@ static void power_supply_remove_bat_triggers(struct power_supply *psy)
 	led_trigger_unregister_simple(psy->charging_trig);
 	led_trigger_unregister_simple(psy->full_trig);
 	led_trigger_unregister_simple(psy->charging_blink_full_solid_trig);
+	led_trigger_unregister_simple(psy->charging_red_full_green_trig);
 	kfree(psy->charging_blink_full_solid_trig_name);
 	kfree(psy->full_trig_name);
 	kfree(psy->charging_trig_name);
 	kfree(psy->charging_full_trig_name);
+	kfree(psy->charging_red_full_green_trig_name);
 }
 
 /* Generated power specific LEDs triggers. */
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index c0992a77feea..1d7c0b43070f 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -318,6 +318,8 @@ struct power_supply {
 	char *online_trig_name;
 	struct led_trigger *charging_blink_full_solid_trig;
 	char *charging_blink_full_solid_trig_name;
+	struct led_trigger *charging_red_full_green_trig;
+	char *charging_red_full_green_trig_name;
 #endif
 };
 
-- 
2.44.0


