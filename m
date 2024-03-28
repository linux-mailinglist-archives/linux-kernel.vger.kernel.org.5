Return-Path: <linux-kernel+bounces-123503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BBA89099F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 845291C2DA2F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A84B139CF8;
	Thu, 28 Mar 2024 19:49:57 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AB27EF00;
	Thu, 28 Mar 2024 19:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655396; cv=none; b=CPDRBBcGgH/XLNO1e7R5a1JfxPb4Xmto98Y4miDTMiSHYlwCCEStTFozd+AZVgOLS2f15BPLwptGsLRPKZXDl+dcCldVXKDI/L04WMZNGHzw7JvvVTzggi1I7m3fDa7XvMT1Ev16ypCgtSNgVVqoDq+okcJUk3apjkdN1Jrduos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655396; c=relaxed/simple;
	bh=tpKvb2WpKtL2F2WNCvHRKcNrzS9sLlPv7e2EtZRo3D0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M+1T55MqsKCReWbRKCCSGT4Q9M7qir9AvUZ53FisWodKnPpN+7TI/k+xCMsgG6ghoA8VuIiaMjeLRKcJbAL6OeSTjv+1STiTwwuTFmkz1WqmJhhXMIcYnpj9oUvPH+lGadFbJ2EW0qtZbtnbqS2AhP0V5WPCEsg8VAszWY3+oOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D52C433A6;
	Thu, 28 Mar 2024 19:49:47 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 20:49:11 +0100
Subject: [PATCH v2 01/19] ACPI: store owner from modules with
 acpi_bus_register_driver()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-b4-module-owner-acpi-v2-1-1e5552c2c69f@linaro.org>
References: <20240328-b4-module-owner-acpi-v2-0-1e5552c2c69f@linaro.org>
In-Reply-To: <20240328-b4-module-owner-acpi-v2-0-1e5552c2c69f@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Corentin Chary <corentin.chary@gmail.com>, 
 "Luke D. Jones" <luke@ljones.dev>, Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Matan Ziv-Av <matan@svgalib.org>, Mattia Dongili <malattia@linux.it>, 
 Azael Avalos <coproscefalo@gmail.com>, Ajay Kaher <akaher@vmware.com>, 
 Alexey Makhalov <amakhalov@vmware.com>, 
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, 
 Richard Cochran <richardcochran@gmail.com>, Theodore Ts'o <tytso@mit.edu>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 acpica-devel@lists.linux.dev, linux-input@vger.kernel.org, 
 netdev@vger.kernel.org, chrome-platform@lists.linux.dev, 
 platform-driver-x86@vger.kernel.org, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2838;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=tpKvb2WpKtL2F2WNCvHRKcNrzS9sLlPv7e2EtZRo3D0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBcm/75CHfzjauSbERmtADmBfBhznS/UR7cdHP
 7RSIzEIjuqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXJvwAKCRDBN2bmhouD
 12kZD/wKOlbTJcRyBA4FiiG2tO7BfZ67V0INUdhmDGivj2/Ggl5gIwsgQxpvM0Km09hAXaPDRjj
 lyvAdF6rG2LBOIlP33IwbcAPFrA8fjnr5ltFUN1skrf+SDugMGrU1wtf3C1kf6/+xPkobyzjlQ4
 Isfqjvx2iysJaFE7Kpn1sA8m53l0y8brqihEWhfgSZ3TptyxCDX+exyoA8mQMFzVM0VNXuXrqSV
 LoGM50PnqYH9ndhsCftOZgg1TmWMRXe7Mdd57OBs6eHxBJ742SpMPoAHdLEagTqS7mPjz0j+kPc
 x6MkHs8/D5AVaukXcOY0ojZgxWCJfsf7tnki5Kwre+iW/sEigYZ70Hj92WRyycYbP7kJ2guCN0U
 hzSkW3RS3zIrWGWbjvXL+Byk8RdIbtZQy6+V/EryhSXR6Bv0z0EioRwVT7ski+bwKrkhLJkGEhe
 1v1NMiWCIXHq1MQCRm4Ry8WQ0RJmFdMblkXNLSeroIVu3Lh7kGDjA6H0MpPoatGxBY9vqJ1LxUV
 ADP4YQz6rN6Z4e1Eldu0DpGsspM70VVocPfy9v8ri0bevotCiQAAhK6l643bePl2W2PxPb6a8Rc
 8et0Wt3qsExffw1JbsNmWJgsSXsIDT+OZgetPTPsylHOtqn44KXrb/p9cAAb0SuCHoQeN0S8lR1
 wA98xZcpjAv6e1w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Modules registering driver with acpi_bus_register_driver() often forget to
set .owner field.  The field is used by some of other kernel parts for
reference counting (try_module_get()), so it is expected that drivers
will set it.

Solve the problem by moving this task away from the drivers to the core
ACPI bus code, just like we did for platform_driver in
commit 9447057eaff8 ("platform_device: use a macro instead of
platform_driver_register").

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/acpi/bus.c      | 9 +++++----
 include/acpi/acpi_bus.h | 7 ++++++-
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index d9fa730416f1..eda951032f3c 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -990,25 +990,26 @@ EXPORT_SYMBOL_GPL(acpi_driver_match_device);
    -------------------------------------------------------------------------- */
 
 /**
- * acpi_bus_register_driver - register a driver with the ACPI bus
+ * __acpi_bus_register_driver - register a driver with the ACPI bus
  * @driver: driver being registered
+ * @owner: owning module/driver
  *
  * Registers a driver with the ACPI bus.  Searches the namespace for all
  * devices that match the driver's criteria and binds.  Returns zero for
  * success or a negative error status for failure.
  */
-int acpi_bus_register_driver(struct acpi_driver *driver)
+int __acpi_bus_register_driver(struct acpi_driver *driver, struct module *owner)
 {
 	if (acpi_disabled)
 		return -ENODEV;
 	driver->drv.name = driver->name;
 	driver->drv.bus = &acpi_bus_type;
-	driver->drv.owner = driver->owner;
+	driver->drv.owner = owner;
 
 	return driver_register(&driver->drv);
 }
 
-EXPORT_SYMBOL(acpi_bus_register_driver);
+EXPORT_SYMBOL(__acpi_bus_register_driver);
 
 /**
  * acpi_bus_unregister_driver - unregisters a driver with the ACPI bus
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 5de954e2b18a..7453be56f855 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -656,7 +656,12 @@ void acpi_scan_lock_release(void);
 void acpi_lock_hp_context(void);
 void acpi_unlock_hp_context(void);
 int acpi_scan_add_handler(struct acpi_scan_handler *handler);
-int acpi_bus_register_driver(struct acpi_driver *driver);
+/*
+ * use a macro to avoid include chaining to get THIS_MODULE
+ */
+#define acpi_bus_register_driver(drv) \
+	__acpi_bus_register_driver(drv, THIS_MODULE)
+int __acpi_bus_register_driver(struct acpi_driver *driver, struct module *owner);
 void acpi_bus_unregister_driver(struct acpi_driver *driver);
 int acpi_bus_scan(acpi_handle handle);
 void acpi_bus_trim(struct acpi_device *start);

-- 
2.34.1


