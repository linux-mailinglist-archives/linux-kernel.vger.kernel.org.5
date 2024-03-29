Return-Path: <linux-kernel+bounces-124583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E928891A3C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D34DEB23D57
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4B7156C7D;
	Fri, 29 Mar 2024 12:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBr4qt8a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE52C156C5E;
	Fri, 29 Mar 2024 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715468; cv=none; b=IEZjPlFoWzTvdmUprp3dOsHd1D9UnmaWrTIIpvCmH8X3tbaS5s1H1/Jipyars2Bl9YglQBFRsPW7hFE5iK3x3gmA5j3x2yfmX7W++Z7/NdOEXgoxEMoCohEXCVZdBLHhODmfUmVFmMtScWSACHve1bMnkThsp1akt9p7WU8ziRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715468; c=relaxed/simple;
	bh=XooxLjpXXfGU922eAkYTNAx+aBe681fCNba+85D9r94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9vtSCJ0ESb1duAeRI4h6cpyDSZEoGm39qy/zyuYYa1g2C0sTSCSlPvDMLSI6p5dz8nYtf0ocFi9EbrK31Gwez/iQGlk2UbROYZJoYnPJ8/w5TttpfLesByjBfaoMxUyKTs69yPOM+2CxQqwcNaGzVj76UUBR4e865PHrq+HAL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBr4qt8a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CBEAC433F1;
	Fri, 29 Mar 2024 12:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715467;
	bh=XooxLjpXXfGU922eAkYTNAx+aBe681fCNba+85D9r94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BBr4qt8aMTJrW17WZfecMJKN+rANAMvR2VmxD3l2Z2DQ3I2Z9VuYFx5sA6KuPi+S2
	 erOPJUzzgLyo2afvJGVUCsQwZ7YUolT5NOvVjSKLlZYOdknyuqZ+xFPlItG2f5rqkP
	 8bosAl8NRBR9OosR9/hB1Eu2fD8/FW72SDnSuMxEGkHq6dc4AFFpKrONSeOoYgq4fJ
	 967WpLrOTaoKVN9EYfOrt/a9jZijUpq1epGecJWtkwjEdEHwgdXaW5HXWKsShnhm5D
	 +RSaC20BtXwk1hKaJlAG9ujN67UNUpFmSwREOa5vJ7FiY1DJQ9OTsAq226LgEGr+SJ
	 hMq4pmn6l1c/Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	robert.moore@intel.com,
	raag.jadav@intel.com,
	mika.westerberg@linux.intel.com,
	mail@mariushoch.de,
	michal.wilczynski@intel.com,
	mario.limonciello@amd.com,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 32/52] ACPI: x86: Move acpi_quirk_skip_serdev_enumeration() out of CONFIG_X86_ANDROID_TABLETS
Date: Fri, 29 Mar 2024 08:29:02 -0400
Message-ID: <20240329122956.3083859-32-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122956.3083859-1-sashal@kernel.org>
References: <20240329122956.3083859-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
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
index 63d834dd38112..c708524576df4 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -429,7 +429,7 @@ bool acpi_quirk_skip_i2c_client_enumeration(struct acpi_device *adev)
 }
 EXPORT_SYMBOL_GPL(acpi_quirk_skip_i2c_client_enumeration);
 
-int acpi_quirk_skip_serdev_enumeration(struct device *controller_parent, bool *skip)
+static int acpi_dmi_skip_serdev_enumeration(struct device *controller_parent, bool *skip)
 {
 	struct acpi_device *adev = ACPI_COMPANION(controller_parent);
 	const struct dmi_system_id *dmi_id;
@@ -437,8 +437,6 @@ int acpi_quirk_skip_serdev_enumeration(struct device *controller_parent, bool *s
 	u64 uid;
 	int ret;
 
-	*skip = false;
-
 	ret = acpi_dev_uid_to_integer(adev, &uid);
 	if (ret)
 		return 0;
@@ -464,7 +462,6 @@ int acpi_quirk_skip_serdev_enumeration(struct device *controller_parent, bool *s
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(acpi_quirk_skip_serdev_enumeration);
 
 bool acpi_quirk_skip_gpio_event_handlers(void)
 {
@@ -479,8 +476,21 @@ bool acpi_quirk_skip_gpio_event_handlers(void)
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
index 0b7eab0ef7d7f..d9c20ae23b632 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -652,6 +652,7 @@ bool acpi_device_override_status(struct acpi_device *adev, unsigned long long *s
 bool acpi_quirk_skip_acpi_ac_and_battery(void);
 int acpi_install_cmos_rtc_space_handler(acpi_handle handle);
 void acpi_remove_cmos_rtc_space_handler(acpi_handle handle);
+int acpi_quirk_skip_serdev_enumeration(struct device *controller_parent, bool *skip);
 #else
 static inline bool acpi_device_override_status(struct acpi_device *adev,
 					       unsigned long long *status)
@@ -669,23 +670,22 @@ static inline int acpi_install_cmos_rtc_space_handler(acpi_handle handle)
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


