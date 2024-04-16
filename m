Return-Path: <linux-kernel+bounces-146279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8DC8A6327
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 553F12833A8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8043FB9D;
	Tue, 16 Apr 2024 05:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FxarOxV1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206953BB23
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 05:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713246017; cv=none; b=OitIvEeKB5VRq/uy/qLdTCXZnMKRlCi10Po0RsAMN+WuC4KG7dEFRICV3b7TC643orxbUtckiEGyxif6vmgC+UX7E5B0k8qP3myFEt0q8/RmeTTuxXOqZ3uTBrVAEd/3uM88NuXnFvgJO6bq7fQqf3fQmrx30dmFNdUxPbu07Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713246017; c=relaxed/simple;
	bh=BPy9w6pvQJsx2dsHgKCy7OcSZSb24S8ZkQbbQcYva3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nzeVrkgCpfCPfTmSD5S+MhFelYVrVHJMtjyCy6HjF2aOtO0jJC2bocALSKLjTTSa54iy3DG/TNgPj0VlPJu3oyII2Id3hEz5WVOiGx93PO2FX8C4vgtrcqffvmfAqfDks55xi8SaWpkdA+YteDv+dZMXM5K7LLh0iH9LVWzwneE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FxarOxV1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713246013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jQZxld0dHvX8vI/R3vTz99PXylCe6DhIyDcpOixp/JU=;
	b=FxarOxV11EhqFM0Xe9oPDx6xa/XVwbpErsLk3y4xHpM2sZg8WoNnshne45wQX0/19K/D3S
	z3Dbjnagwfgw4aVCtdq7jBrpvGV7SXs+EUFE1rOKCPxyoW61CY7PCUYRU4pV6POFvi6y8I
	5GrLhOvCYL35Rjw6JyNOzGr62yrz10A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-c3js6w0sPkGPKK8O7wKslw-1; Tue,
 16 Apr 2024 01:40:10 -0400
X-MC-Unique: c3js6w0sPkGPKK8O7wKslw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96F07380390E;
	Tue, 16 Apr 2024 05:40:09 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D754851EF;
	Tue, 16 Apr 2024 05:40:03 +0000 (UTC)
From: Kate Hsuan <hpa@redhat.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	linux-leds@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Kate Hsuan <hpa@redhat.com>
Subject: [PATCH v6 4/5] power: supply: power-supply-leds: Add charging_orange_full_green trigger for RGB LED
Date: Tue, 16 Apr 2024 13:39:08 +0800
Message-ID: <20240416053909.256319-5-hpa@redhat.com>
In-Reply-To: <20240416053909.256319-1-hpa@redhat.com>
References: <20240416053909.256319-1-hpa@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Add a charging_orange_full_green LED trigger and the trigger is based on
led_mc_trigger_event() which can set an RGB LED when the trigger is
triggered. The LED will show orange when the battery status is charging.
The LED will show green when the battery status is full.

Link: https://lore.kernel.org/linux-leds/f40a0b1a-ceac-e269-c2dd-0158c5b4a1ad@gmail.com/

Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
 drivers/power/supply/power_supply_leds.c | 26 ++++++++++++++++++++++++
 include/linux/power_supply.h             |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/drivers/power/supply/power_supply_leds.c b/drivers/power/supply/power_supply_leds.c
index c7db29d5fcb8..8dd99199c65b 100644
--- a/drivers/power/supply/power_supply_leds.c
+++ b/drivers/power/supply/power_supply_leds.c
@@ -22,6 +22,9 @@
 static void power_supply_update_bat_leds(struct power_supply *psy)
 {
 	union power_supply_propval status;
+	unsigned int intensity_green[3] = {255, 0, 0};
+	unsigned int intensity_orange[3] = {128, 0, 255};
+	unsigned int intensity_red[3] = {0, 0, 255};
 
 	if (power_supply_get_property(psy, POWER_SUPPLY_PROP_STATUS, &status))
 		return;
@@ -36,12 +39,20 @@ static void power_supply_update_bat_leds(struct power_supply *psy)
 		/* Going from blink to LED on requires a LED_OFF event to stop blink */
 		led_trigger_event(psy->charging_blink_full_solid_trig, LED_OFF);
 		led_trigger_event(psy->charging_blink_full_solid_trig, LED_FULL);
+		led_mc_trigger_event(psy->charging_orange_full_green_trig,
+				     intensity_green,
+				     ARRAY_SIZE(intensity_green),
+				     LED_FULL);
 		break;
 	case POWER_SUPPLY_STATUS_CHARGING:
 		led_trigger_event(psy->charging_full_trig, LED_FULL);
 		led_trigger_event(psy->charging_trig, LED_FULL);
 		led_trigger_event(psy->full_trig, LED_OFF);
 		led_trigger_blink(psy->charging_blink_full_solid_trig, 0, 0);
+		led_mc_trigger_event(psy->charging_orange_full_green_trig,
+				     intensity_orange,
+				     ARRAY_SIZE(intensity_orange),
+				     LED_FULL);
 		break;
 	default:
 		led_trigger_event(psy->charging_full_trig, LED_OFF);
@@ -49,6 +60,10 @@ static void power_supply_update_bat_leds(struct power_supply *psy)
 		led_trigger_event(psy->full_trig, LED_OFF);
 		led_trigger_event(psy->charging_blink_full_solid_trig,
 			LED_OFF);
+		led_mc_trigger_event(psy->charging_orange_full_green_trig,
+				     intensity_red,
+				     ARRAY_SIZE(intensity_red),
+				     LED_OFF);
 		break;
 	}
 }
@@ -74,6 +89,11 @@ static int power_supply_create_bat_triggers(struct power_supply *psy)
 	if (!psy->charging_blink_full_solid_trig_name)
 		goto charging_blink_full_solid_failed;
 
+	psy->charging_orange_full_green_trig_name = kasprintf(GFP_KERNEL,
+		"%s-charging-orange-full-green", psy->desc->name);
+	if (!psy->charging_orange_full_green_trig_name)
+		goto charging_red_full_green_failed;
+
 	led_trigger_register_simple(psy->charging_full_trig_name,
 				    &psy->charging_full_trig);
 	led_trigger_register_simple(psy->charging_trig_name,
@@ -82,9 +102,13 @@ static int power_supply_create_bat_triggers(struct power_supply *psy)
 				    &psy->full_trig);
 	led_trigger_register_simple(psy->charging_blink_full_solid_trig_name,
 				    &psy->charging_blink_full_solid_trig);
+	led_trigger_register_simple(psy->charging_orange_full_green_trig_name,
+				    &psy->charging_orange_full_green_trig);
 
 	return 0;
 
+charging_red_full_green_failed:
+	kfree(psy->charging_blink_full_solid_trig_name);
 charging_blink_full_solid_failed:
 	kfree(psy->full_trig_name);
 full_failed:
@@ -101,10 +125,12 @@ static void power_supply_remove_bat_triggers(struct power_supply *psy)
 	led_trigger_unregister_simple(psy->charging_trig);
 	led_trigger_unregister_simple(psy->full_trig);
 	led_trigger_unregister_simple(psy->charging_blink_full_solid_trig);
+	led_trigger_unregister_simple(psy->charging_orange_full_green_trig);
 	kfree(psy->charging_blink_full_solid_trig_name);
 	kfree(psy->full_trig_name);
 	kfree(psy->charging_trig_name);
 	kfree(psy->charging_full_trig_name);
+	kfree(psy->charging_orange_full_green_trig_name);
 }
 
 /* Generated power specific LEDs triggers. */
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index c0992a77feea..9b6898085224 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -318,6 +318,8 @@ struct power_supply {
 	char *online_trig_name;
 	struct led_trigger *charging_blink_full_solid_trig;
 	char *charging_blink_full_solid_trig_name;
+	struct led_trigger *charging_orange_full_green_trig;
+	char *charging_orange_full_green_trig_name;
 #endif
 };
 
-- 
2.44.0


