Return-Path: <linux-kernel+bounces-146275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A68E48A6317
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E046AB20FB9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EA03B78B;
	Tue, 16 Apr 2024 05:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ym3MFEHL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2311B3A1BF
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 05:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713245980; cv=none; b=nAE7SHcEjfHk1Tmpmfkyi/0YlDftMybcVrXvwuNuLamvydEF/mgKcIjOA91H4Zraxcg+W1UYgmAMXkbwWpNycP/yPJw56+iAm3bDThW/e9YC2LaY2D1ne9h0Lfwz09LqekOs9ZfsZXS0Ht6RzYOJNe/gMHnwjKYpgzuQxsdyg10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713245980; c=relaxed/simple;
	bh=K8CWsGrSvjlor4XOvpsr5xcvDhGAFvw/vbJ8MGvqIds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lbqUpXtNkBET5pCngogzpN+vTmzrjc4Wa/76WzKlo6Nsz+9K681pB0l7ZHeE1QW9CbszgKdCwmtOT6jD8p0edup8WQq/QYfww2gMBBMTgsC1fpg2efvmZbi7rbuwhH5WQ6aFFQYqIalfA0ujjfhsH1qs/ROWYuKeBOEZTDmReyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ym3MFEHL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713245977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0+Hc2p+jT5Q4vVgv9O18REk/mQYHW8ZTSMxALLmVm0w=;
	b=Ym3MFEHL+IbCd3cXMTHFbyrhLqLxYynZajnG19suSutIxckUb7mfr8txmX8KO0N8SJ8wQX
	jNPIi+as+Y20lm2HM0S4hI50sNh1XI3JLOKTZDRNNAeH0QGZ92DDRXsgDjnEtMfk+v7OKz
	GfUnFYql0lVJdQ6QeIsHwiIHyiK2Pqo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-JAle0uHGO3-I45bfo7nj6A-1; Tue,
 16 Apr 2024 01:39:33 -0400
X-MC-Unique: JAle0uHGO3-I45bfo7nj6A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4547929AA3B7;
	Tue, 16 Apr 2024 05:39:33 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 67FCC51EF;
	Tue, 16 Apr 2024 05:39:26 +0000 (UTC)
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
Subject: [PATCH v6 0/5] KTD2026 indicator LED for X86 Xiaomi Pad2
Date: Tue, 16 Apr 2024 13:39:04 +0800
Message-ID: <20240416053909.256319-1-hpa@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

This patch added the support for Xiaomi Pad2 indicator LED. This work
included:
1. Added the KTD2026 swnode description to describe the LED controller.
2. Migrated the original driver to fwnode to support x86 platform.
3. Support for multi-color LED trigger event.
4. The LED shows orange  when charging and the LED shows green when the
   battery is full.

Moreover, the LED trigger is set to the new trigger, called
"bq27520-0-charging-orange-full-green" for Xiaomi Pad2 so the LED shows
orange when charging and the LED shows green when the battery is full.

The new LED API led_mc_trigger_event() can be found in the following
URL.
https://lore.kernel.org/linux-leds/f40a0b1a-ceac-e269-c2dd-0158c5b4a1ad@gmail.com/

--
Changes in v6:
1. The I2C ID table was moved to a separate patch.
2. The LED shows orange when charging.
3. The trigger name was renamed to charging-orange-full-green.
4. The default trigger of Xiaomi Pad2 is
   "bq27520-0-charging-orange-full-green".

Changes in v5:
1. Fix swnode LED color settings.
2. Improve the driver based on the comments.
3. Introduce a LED new API- led_mc_trigger_event() to make the LED
   color can be changed according to the trigger.
4. Introduced a new trigger "charging-red-full-green". The LED will be
   red when charging and the the LED will be green when the battery is
   full.
5. Set the default trigger to "bq27520-0-charging-red-full-green" for
   Xiaomi Pad2.

Changes in v4:
1. Fix double casting.
2. Since force casting a pointer value to int will trigger a compiler
   warning, the type of num_leds was changed to unsigned long.

Changes in v3:
1. Drop the patch "leds-ktd202x: Skip regulator settings for Xiaomi
   pad2"

Changes in v2:
1. Typo and style fixes.
2. The patch 0003 skips all the regulator setup for Xiaomi pad2 since
   KTD2026 on Xiaomi pad2 is already powered by BP25890RTWR. So, the
   sleep can be removed when removing the module.


Kate Hsuan (5):
  platform: x86-android-tablets: other: Add swnode for Xiaomi pad2
    indicator LED
  leds: rgb: leds-ktd202x: Get device properties through fwnode to
    support ACPI
  leds: rgb: leds-ktd202x: I2C ID tables for KTD2026 and 2027
  power: supply: power-supply-leds: Add charging_orange_full_green
    trigger for RGB LED
  platform: x86-android-tablets: others: Set the LED trigger to
    charging_orange_full_green for Xiaomi pad2

 drivers/leds/rgb/Kconfig                      |  1 -
 drivers/leds/rgb/leds-ktd202x.c               | 73 ++++++++++-------
 .../platform/x86/x86-android-tablets/other.c  | 82 +++++++++++++++++++
 .../x86/x86-android-tablets/shared-psy-info.h |  2 +
 drivers/power/supply/power_supply_leds.c      | 26 ++++++
 include/linux/power_supply.h                  |  2 +
 6 files changed, 156 insertions(+), 30 deletions(-)

-- 
2.44.0


