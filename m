Return-Path: <linux-kernel+bounces-124762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E60E891C3D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDCA628B1F4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2923181315;
	Fri, 29 Mar 2024 12:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAI0V5vS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE13180A9A;
	Fri, 29 Mar 2024 12:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716099; cv=none; b=oAz2NxhS/Yg0bgSXyoxYWbMWNlL0rvi0rhiY81bJcjIDAfu3oIypZUmm/aDAHEtHESZlqXDcx++jzotqAzTW0bCE+Vb3UeRFXdDLA8UfsVxlDwcLs1jpqESFqDQnJAqH5YUaZ8ndJ/VLW3l+abG++Zt5hThIfsin/mdqwy82A/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716099; c=relaxed/simple;
	bh=6BB67VKYQcGGM39DP5isCx0F37YiOyTglODRH4ADdI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IsDJW/Q4vlyKsB30efXIv2ZV3JrKkAwTVNyZNHdfGHKLu5NaMpy3+LNl5Yc/GeYFnB3hDwxhjjBqZeoDxl4LHxumOTheCiPGZzZo8SfbmfxNYkvM7foWogRCSBGbKmuJfH/OGXj92Yszk4mlToqKBdbKIe8yGd4i0P17xm8pFoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAI0V5vS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64AD9C433F1;
	Fri, 29 Mar 2024 12:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716098;
	bh=6BB67VKYQcGGM39DP5isCx0F37YiOyTglODRH4ADdI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XAI0V5vSGY63cWGH5PmYi9yrfrM4UPTxnn4toWN2+UU0ZxjguAdtLNxWWtrob9Kcd
	 ldb/Yn7u/zZR3q1rPYZf6/maJJKXG+Uk4tIxQxkK+jdAF40R7pYawnQBpHzObIUvRa
	 kD0D8bPTNiFuBFCCugdAbwZJ9kzuabysYk4XrMNZiqzoHysgQRFE3Rt9PZKyLY5JJo
	 Plq1PFORFDPC7FMBQaKwXHcn7ioK+pTBHxDGor47y2cJQ5bpbSS5z951wv2DhHMkAF
	 Fbktahis0qmo4vn53LJ6Dko7hMbs8vejXlFxrPORRY6w4xp1tFsvjAL3jZv2wK0sq4
	 j7UIfardCtMbQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	mika.westerberg@linux.intel.com,
	mario.limonciello@amd.com,
	michal.wilczynski@intel.com,
	raag.jadav@intel.com,
	mail@mariushoch.de,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 53/98] ACPI: x86: Add DELL0501 handling to acpi_quirk_skip_serdev_enumeration()
Date: Fri, 29 Mar 2024 08:37:24 -0400
Message-ID: <20240329123919.3087149-53-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
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

[ Upstream commit 99b572e6136eab69a8c91d72cf8595b256e304b5 ]

Some recent(ish) Dell AIO devices have a backlight controller board
connected to an UART.

This UART has a DELL0501 HID with CID set to PNP0501 so that the UART is
still handled by 8250_pnp.c. Unfortunately there is no separate ACPI device
with an UartSerialBusV2() resource to model the backlight-controller.
This causes the kernel to create a /dev/ttyS0 char-device for the UART
instead of creating an in kernel serdev-controller + serdev-device pair
for a kernel backlight driver.

Use the existing acpi_quirk_skip_serdev_enumeration() mechanism to work
around this by returning skip=true for tty-ctrl parents with a HID
of DELL0501.

Like other cases where the UartSerialBusV2() resource is missing or broken
this will only create the serdev-controller device and the serdev-device
itself will need to be instantiated by platform code.

Unfortunately in this case there is no device for the platform-code
instantiating the serdev-device to bind to. So also create
a platform_device for this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/x86/utils.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 8829a907eee02..90c3d2eab9e99 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -484,8 +484,28 @@ static int acpi_dmi_skip_serdev_enumeration(struct device *controller_parent, bo
 
 int acpi_quirk_skip_serdev_enumeration(struct device *controller_parent, bool *skip)
 {
+	struct acpi_device *adev = ACPI_COMPANION(controller_parent);
+
 	*skip = false;
 
+	/*
+	 * The DELL0501 ACPI HID represents an UART (CID is set to PNP0501) with
+	 * a backlight-controller attached. There is no separate ACPI device with
+	 * an UartSerialBusV2() resource to model the backlight-controller.
+	 * Set skip to true so that the tty core creates a serdev ctrl device.
+	 * The backlight driver will manually create the serdev client device.
+	 */
+	if (acpi_dev_hid_match(adev, "DELL0501")) {
+		*skip = true;
+		/*
+		 * Create a platform dev for dell-uart-backlight to bind to.
+		 * This is a static device, so no need to store the result.
+		 */
+		platform_device_register_simple("dell-uart-backlight", PLATFORM_DEVID_NONE,
+						NULL, 0);
+		return 0;
+	}
+
 	return acpi_dmi_skip_serdev_enumeration(controller_parent, skip);
 }
 EXPORT_SYMBOL_GPL(acpi_quirk_skip_serdev_enumeration);
-- 
2.43.0


