Return-Path: <linux-kernel+bounces-156410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BB58B027B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ECA4B22B80
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0F5157A42;
	Wed, 24 Apr 2024 06:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iSBZCu7n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF60156F21
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713941597; cv=none; b=SuFbfdG3lfmTGqyZQ/1ziT+HMPUPj/oDkm3vxqAg/XvG7eBDS0jdo83mz+3jii23asnW2V5qNh7T3pOoVQ32fsMYywIbSjiPMiC46quD5o7ykgTr9kvn8RIRLf7PRse7uXuS5ZQuaw1UzVWHKqbSn1w7Xlnfh/B0mvf82cBZoJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713941597; c=relaxed/simple;
	bh=kE6ujwyCxDJ3wnj3LmnUncuzn1h+gS9jTvaCIsXf/Xo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AQvDPyTcxBdkoppnT1kZBI7qLMDewpW4/nEK3TBnyRVsenpYOI2XJ0Z/zijLC3oCFUyUEBZwwiqc0DbHWEMyKhjbgT+ujxkWQkyoVLX0UMNl45yv1JmcxMzxQ44ASTrXq4YjZ4xxytXBXuMG0FlPQPJ7VBL2dzSCCICzaLg0CHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iSBZCu7n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713941594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Hyxx3rdoKtkVIC3dpNxTEvu2bQJBAWkkgUSYJDIUqbc=;
	b=iSBZCu7nbCXfzxft82Eio9eqA4d0b+fdkBHDcggo02bAntMCXl0UZ4U/ggatq3joLsw+fQ
	WlRZfhMwxvnqusnJa0Ou3sINPIUQYXh/UMVWH8BjMnclV7pO2lt7hKK6VeKeebhSEYu6od
	pM0y/lKqXS0xgRdF7+wuSBJ1NaagI4U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-n9IxvPLSOne6_cJI1CrQQg-1; Wed, 24 Apr 2024 02:53:10 -0400
X-MC-Unique: n9IxvPLSOne6_cJI1CrQQg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AA3F880021A;
	Wed, 24 Apr 2024 06:53:09 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.73])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C86DCC01595;
	Wed, 24 Apr 2024 06:53:03 +0000 (UTC)
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
Subject: [PATCH v7 0/6] KTD2026 indicator LED for X86 Xiaomi Pad2
Date: Wed, 24 Apr 2024 14:52:06 +0800
Message-ID: <20240424065212.263784-1-hpa@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

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

--
Changes in v7:
1. Platform: x86-android-tablets: other: Add swnode for Xiaomi pad2
   indicator LED was included in Hans' branch.
2. Included the tags from the previous version in the commit message.
3. Fixed the comma issue for the structure initialiser.

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


Hans de Goede (2):
  leds: core: Add led_mc_set_brightness() function
  leds: trigger: Add led_mc_trigger_event() function

Kate Hsuan (4):
  leds: rgb: leds-ktd202x: Get device properties through fwnode to
    support ACPI
  leds: rgb: leds-ktd202x: I2C ID tables for KTD2026 and 2027
  power: supply: power-supply-leds: Add charging_orange_full_green
    trigger for RGB LED
  platform: x86-android-tablets: others: Set the LED trigger to
    charging_orange_full_green for Xiaomi pad2

 drivers/leds/led-class-multicolor.c           |  1 +
 drivers/leds/led-core.c                       | 31 ++++++++
 drivers/leds/led-triggers.c                   | 20 ++++++
 drivers/leds/rgb/Kconfig                      |  1 -
 drivers/leds/rgb/leds-ktd202x.c               | 72 +++++++++++--------
 .../platform/x86/x86-android-tablets/other.c  |  2 +-
 drivers/power/supply/power_supply_leds.c      | 26 +++++++
 include/linux/leds.h                          | 26 +++++++
 include/linux/power_supply.h                  |  2 +
 9 files changed, 149 insertions(+), 32 deletions(-)

-- 
2.44.0


