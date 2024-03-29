Return-Path: <linux-kernel+bounces-124846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D82CC891D13
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E01F28C3DC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CBC1BD5FF;
	Fri, 29 Mar 2024 12:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7wz5DVq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618B91BD5EC;
	Fri, 29 Mar 2024 12:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716280; cv=none; b=aYOo0BIpTq7tOLB4dTCBtqdUT99fP6+C3JPGaP9L3NpZBIZgunr1pvXzkFI9DlsWGJoXnypFbaSRyZMR1XFXgSQzCxzGOY39giRI+rHntnQq6oXiuzgOhMMqhT/fPDBLdTUOnRcrifWUXgXwScQG6hFzvHFeSqHkr3jYCcAjncI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716280; c=relaxed/simple;
	bh=XooxLjpXXfGU922eAkYTNAx+aBe681fCNba+85D9r94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRFJjnovOesoIDF9H9eYZtCDhsUEXSNei0oo+NNDHUXXoWs74IDp+1W1BIxSgI7hDmh03NV+eqUGuoH+QCME3n0NhEyyAXdnBwwBx0HmDdi0vQdjUhOvjAch0NjytgrkKUR9YML8ZBc1vy66+zQpM9E6jjQzN05+Z8egdapAsno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7wz5DVq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2983C433F1;
	Fri, 29 Mar 2024 12:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716280;
	bh=XooxLjpXXfGU922eAkYTNAx+aBe681fCNba+85D9r94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m7wz5DVq/ByDOAeLW9Bh17rAXtTd0Iisahi8LQWAFddUYk0DJ1y23ZTWiVLQ8nUzi
	 Nsuxx8YQG2qxm3D/fFkqFuIfZOvJ4NT8q+28Dt13c8JLZGpyfsUr9zv6ppviTKXlJG
	 hP60rWnrd33iarJf2sVhWRUP/KNPk0k8Wt8C3PbG4+cVVhhtFL4g+BCN4rvrRJR13m
	 O2TxjqTYGUa8h1vaidMHxfm9x2TdezwR/8I1lJvGOuK1yskeHCIjwO0oHzap3LB377
	 /XZaCabBVO6VKa6BBAlJ3uMj+rB8Cb77xVBj3fGaZrnN/zEkMV9DqyahwbVA+HArCn
	 Jac4V0TNLMs0A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	robert.moore@intel.com,
	michal.wilczynski@intel.com,
	mario.limonciello@amd.com,
	raag.jadav@intel.com,
	mail@mariushoch.de,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 37/75] ACPI: x86: Move acpi_quirk_skip_serdev_enumeration() out of CONFIG_X86_ANDROID_TABLETS
Date: Fri, 29 Mar 2024 08:42:18 -0400
Message-ID: <20240329124330.3089520-37-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
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


