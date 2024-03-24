Return-Path: <linux-kernel+bounces-112716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A79D887D47
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 16:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB38C1F21307
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 15:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D5A182DD;
	Sun, 24 Mar 2024 15:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q+QkUvgm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08087182D4
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 15:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711292519; cv=none; b=LTepgswDsRB1VnatkdvWs4HAhfFWKBIrz9lbs52bbhTXY7RxmOtF4ta8/amJcbSjGuaDBGSVbJ6ZUq4nHdm0ozpkSlKAeaKYgyqqOUv5Uf1gpvwS7P8fBxE+c8ES9k1n1x5q+47fk63Fb+DHtwJ/Aml/8Vl09AR3huFsAW2206I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711292519; c=relaxed/simple;
	bh=9kD5mYuA0ixrmsz/Nc+tYzQ3aOX+CXGxr7IZ5BHCiyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fBRhiaWls42BBUwC8t+UBE4VOmNtTYvriyewxQoFN9EVr/glTa6qqn5bwHT6iyiYgae3wUOiJWFWGJuAsoc/OeiOK2pmLSDlJJqimB8SQIvDQBQolcjr4AvvXWAu3096Ons24OduZKShAOKnJpHRk9+Ibx9Jgfd4UgcmklHRwtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q+QkUvgm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711292517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NrnaIDGD9GLPzpqf9XIs73N3ICvGrhKs7eQKU2DgFLQ=;
	b=Q+QkUvgmQV6MhR+1FPygy8ljzUOjfhbq8PWb36e+vF4nwLr6mXSjhTrn+/eUujTW+MfY6p
	WY3TE21Y4GCh4kj6o0XTk6Z/eC9f1g7R4YvGD6QtsTYCYd4zyqs5W3X5pAITJpSfWhesMO
	D9dFaKIkaEHbv94Peq7+1DUI9ij4TqQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-MMq404_uPTOF9T5j7TRl4A-1; Sun, 24 Mar 2024 11:01:53 -0400
X-MC-Unique: MMq404_uPTOF9T5j7TRl4A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DBA1D85A58C;
	Sun, 24 Mar 2024 15:01:52 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.75])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0C5CE40C6DAE;
	Sun, 24 Mar 2024 15:01:46 +0000 (UTC)
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
Subject: [PATCH v5 RESEND 0/6] KTD2026 indicator LED for X86 Xiaomi Pad2
Date: Sun, 24 Mar 2024 23:01:01 +0800
Message-ID: <20240324150107.976025-1-hpa@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

This patch added the support for Xiaomi Pad2 indicator LED. This work
included:
1. Added the KTD2026 swnode description to describe the LED controller.
2. Migrated the original driver to fwnode to support x86 platform.
3. Support for multi-color LED trigger event.
4. The LED will be red when charging and the LED will be green when the
   battery is full.

Moreover, the LED trigger is set to the new trigger, called
"bq27520-0-charging-red-full-green" for Xiaomi Pad2 so the LED will be
red when charging and the LED will be green when the battery is full.

The new LED API led_mc_trigger_event() can be found in the following
URL.
https://lore.kernel.org/linux-leds/f40a0b1a-ceac-e269-c2dd-0158c5b4a1ad@gmail.com/T/#t

--
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

Hans de Goede (2):
  leds: core: Add led_mc_set_brightness() function
  leds: trigger: Add led_mc_trigger_event() function

Kate Hsuan (4):
  platform: x86-android-tablets: other: Add swnode for Xiaomi pad2
    indicator LED
  leds: rgb: leds-ktd202x: Get device properties through fwnode to
    support ACPI
  power: supply: power-supply-leds: Add charging_red_full_green trigger
    for RGB LED
  platform: x86-android-tablets: others: Set the LED trigger to
    charging_red_full_green for Xiaomi pad2

 drivers/leds/led-class-multicolor.c           |  1 +
 drivers/leds/led-core.c                       | 31 +++++++
 drivers/leds/led-triggers.c                   | 20 +++++
 drivers/leds/rgb/Kconfig                      |  1 -
 drivers/leds/rgb/leds-ktd202x.c               | 75 ++++++++++-------
 .../platform/x86/x86-android-tablets/other.c  | 82 +++++++++++++++++++
 .../x86/x86-android-tablets/shared-psy-info.h |  2 +
 drivers/power/supply/power_supply_leds.c      | 25 ++++++
 include/linux/leds.h                          | 26 ++++++
 include/linux/power_supply.h                  |  2 +
 10 files changed, 235 insertions(+), 30 deletions(-)

-- 
2.44.0


