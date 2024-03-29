Return-Path: <linux-kernel+bounces-124526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC0789195B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C2ABB24E04
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D95146D4C;
	Fri, 29 Mar 2024 12:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIK4Gvi0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F55146A98;
	Fri, 29 Mar 2024 12:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715310; cv=none; b=IkctuSuaHFGTBkuUuyYAAYuaW4O/Ow9Kdplh4So94dfM4i3JmyGEnakiGL9+UcXBlsKTwbw64XqT9Zi7cEnlVDKLQII7rvbJVjuD+dsOSfN4X86CKp5Y2xjDldEAEbE+bq4TKNlHSLXr0ceC7lYPx+Mm3TfG8PnqLu/Gqa8tVjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715310; c=relaxed/simple;
	bh=QPLVn594emU0I3NOpLawSQgMidgeuHWuB6usbt5H/qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mY72b9SXh7bDeqpOecs2KD6IjuM7mqNXl5BHXgnDUc02bBbdNVnJgdnWT3uuVi5hh9ohAzOayjZvaMYC72Mk+Z1nt4bpWxiwoym2940BI7PCheavDgCkNXdztH6KFnKizYPrs4UgrmoEJmc28Ns1oPp6nQb7Ddt5JCCHB4ESZIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIK4Gvi0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219C0C433F1;
	Fri, 29 Mar 2024 12:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715309;
	bh=QPLVn594emU0I3NOpLawSQgMidgeuHWuB6usbt5H/qc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dIK4Gvi0GCva8H0c9wYcUb6yTUdudzPp9jp1KoSqTb4a1j4jrnnjIxVo0mBEyZLC4
	 7CID+WlABBg5A0wtcykooGcCxZcmct/LzQXu5aYmJyUuiY8CHl/FMNp8czSNgE36VB
	 fpRK3DNhQBwoDBweQg/fqY0Ew0E0EAPhsgOGP8cPSgyCax6Id3/GVuDaIZ2i6uMPmb
	 XwhYQmLOCl2NjHNtg+mHaN4k3tOXPrNi1xnmJmUZYn1qEkhkf6xTrSacg89RGp9IyX
	 PI6YL4hdTmIs7z4Y33zzUFq58ehJBidx+SzQzQRPHzWtHtZtxU4mbizF6eT6AwWUEh
	 /i4mRKS1tfyUw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	robert.moore@intel.com,
	mario.limonciello@amd.com,
	mika.westerberg@linux.intel.com,
	michal.wilczynski@intel.com,
	raag.jadav@intel.com,
	mail@mariushoch.de,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH AUTOSEL 6.8 45/68] ACPI: x86: Move acpi_quirk_skip_serdev_enumeration() out of CONFIG_X86_ANDROID_TABLETS
Date: Fri, 29 Mar 2024 08:25:41 -0400
Message-ID: <20240329122652.3082296-45-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 7c86e17455de1a442ec906d3449148b5e9a218a4 ]

Some recent(ish) Dell AIO devices have a backlight controller board
connected to an UART.

This UART has a DELL0501 HID with CID set to PNP0501 so that the UART is
still handled by 8250_pnp.c. Unfortunately there is no separate ACPI device
with an UartSerialBusV2() resource to model the backlight-controller.

The next patch in this series will use acpi_quirk_skip_serdev_enumeration()
to still create a serdev for this for a backlight driver to bind to
instead of creating a /dev/ttyS0.

This new acpi_quirk_skip_serdev_enumeration() use is not limited to Android
X86 tablets, so move it out of the ifdef CONFIG_X86_ANDROID_TABLETS block.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/x86/utils.c | 18 ++++++++++++++----
 include/acpi/acpi_bus.h  | 14 +++++++-------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index bc65ebfcdf767..8829a907eee02 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -428,7 +428,7 @@ bool acpi_quirk_skip_i2c_client_enumeration(struct acpi_device *adev)
 }
 EXPORT_SYMBOL_GPL(acpi_quirk_skip_i2c_client_enumeration);
 
-int acpi_quirk_skip_serdev_enumeration(struct device *controller_parent, bool *skip)
+static int acpi_dmi_skip_serdev_enumeration(struct device *controller_parent, bool *skip)
 {
 	struct acpi_device *adev = ACPI_COMPANION(controller_parent);
 	const struct dmi_system_id *dmi_id;
@@ -436,8 +436,6 @@ int acpi_quirk_skip_serdev_enumeration(struct device *controller_parent, bool *s
 	u64 uid;
 	int ret;
 
-	*skip = false;
-
 	ret = acpi_dev_uid_to_integer(adev, &uid);
 	if (ret)
 		return 0;
@@ -463,7 +461,6 @@ int acpi_quirk_skip_serdev_enumeration(struct device *controller_parent, bool *s
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(acpi_quirk_skip_serdev_enumeration);
 
 bool acpi_quirk_skip_gpio_event_handlers(void)
 {
@@ -478,8 +475,21 @@ bool acpi_quirk_skip_gpio_event_handlers(void)
 	return (quirks & ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS);
 }
 EXPORT_SYMBOL_GPL(acpi_quirk_skip_gpio_event_handlers);
+#else
+static int acpi_dmi_skip_serdev_enumeration(struct device *controller_parent, bool *skip)
+{
+	return 0;
+}
 #endif
 
+int acpi_quirk_skip_serdev_enumeration(struct device *controller_parent, bool *skip)
+{
+	*skip = false;
+
+	return acpi_dmi_skip_serdev_enumeration(controller_parent, skip);
+}
+EXPORT_SYMBOL_GPL(acpi_quirk_skip_serdev_enumeration);
+
 /* Lists of PMIC ACPI HIDs with an (often better) native charger driver */
 static const struct {
 	const char *hid;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index e4d24d3f9abb5..446225aada50d 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -749,6 +749,7 @@ bool acpi_device_override_status(struct acpi_device *adev, unsigned long long *s
 bool acpi_quirk_skip_acpi_ac_and_battery(void);
 int acpi_install_cmos_rtc_space_handler(acpi_handle handle);
 void acpi_remove_cmos_rtc_space_handler(acpi_handle handle);
+int acpi_quirk_skip_serdev_enumeration(struct device *controller_parent, bool *skip);
 #else
 static inline bool acpi_device_override_status(struct acpi_device *adev,
 					       unsigned long long *status)
@@ -766,23 +767,22 @@ static inline int acpi_install_cmos_rtc_space_handler(acpi_handle handle)
 static inline void acpi_remove_cmos_rtc_space_handler(acpi_handle handle)
 {
 }
+static inline int
+acpi_quirk_skip_serdev_enumeration(struct device *controller_parent, bool *skip)
+{
+	*skip = false;
+	return 0;
+}
 #endif
 
 #if IS_ENABLED(CONFIG_X86_ANDROID_TABLETS)
 bool acpi_quirk_skip_i2c_client_enumeration(struct acpi_device *adev);
-int acpi_quirk_skip_serdev_enumeration(struct device *controller_parent, bool *skip);
 bool acpi_quirk_skip_gpio_event_handlers(void);
 #else
 static inline bool acpi_quirk_skip_i2c_client_enumeration(struct acpi_device *adev)
 {
 	return false;
 }
-static inline int
-acpi_quirk_skip_serdev_enumeration(struct device *controller_parent, bool *skip)
-{
-	*skip = false;
-	return 0;
-}
 static inline bool acpi_quirk_skip_gpio_event_handlers(void)
 {
 	return false;
-- 
2.43.0


