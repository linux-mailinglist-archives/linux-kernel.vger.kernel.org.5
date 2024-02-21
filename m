Return-Path: <linux-kernel+bounces-75444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C40E985E8C3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E75721C212E6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06BB86AE3;
	Wed, 21 Feb 2024 20:04:47 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC7D85C52;
	Wed, 21 Feb 2024 20:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708545887; cv=none; b=pUAolk9hsaO2AePQE0CorQ8332DKd2l4WF7nfDQzLVCECh0MJlM9JaIX2B2KrE+2wSL60EAgEcS3HfEynNvUZHQPFQcgduVASAWHf19jeDgLOsmNNSa28OUCAc4wz3KmqNimrWBNieNsVjGp0Y5kWRFVVlw/5gq02BQTuh7epaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708545887; c=relaxed/simple;
	bh=XCeQqPrzLM1Q/X1k44hyO1nlx52uelheaiY8eSQfYxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qUcWNkdmoH2gBX3Fz9VSK3WdQPT3kiW6NGZNeT8E7waqJtKUHj1uF4+MeQNqUggizxL5IrUhJgPszftg5ct/uhrcFbLu16xxrNSckHmJ8vNWV7Mqd6duOwcdZnygvn4xJ66DOIE/sKalaP5Pt+ub3DMd2wE0tbilRNPQdL/itjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 4363d43caa6d8b51; Wed, 21 Feb 2024 21:04:37 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 6EDE266A243;
	Wed, 21 Feb 2024 21:04:36 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>
Subject:
 [PATCH v1 3/4] ACPI: scan: Rework Device Check and Bus Check notification
 handling
Date: Wed, 21 Feb 2024 21:02:33 +0100
Message-ID: <2939512.e9J7NaK4W3@kreacher>
In-Reply-To: <4562925.LvFx2qVVIh@kreacher>
References: <4562925.LvFx2qVVIh@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgddufedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepkedtvdevieejkeevkedvffeiffehiedtheekkeefieehffekgfeltdehleehvddunecuffhomhgrihhnpehuvghfihdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhonhgrthhhrghnrdgtrghmvghrohhnsehhuhgrfigvihdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhkrgdrfigvshht
 vghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhk
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The underlying problem is the handling of the enabled bit in device
status (bit 1 of _STA return value) which is required by the ACPI
specification to be observed in addition to the present bit (bit 0
of _STA return value) [1], but Linux does not observe it.

Since Linux has not looked at that bit for a long time, it is generally
risky to start obseving it in all device enumeration cases, especially
at the system initialization time, but it can be observed when the
kernel receives a Bus Check or Device Check notification indicating a
change in device configuration.  In those cases, seeing the enabled bit
clear may be regarded as an indication that the device at hand should
not be used any more.

For this reason, rework the handling of Device Check and Bus Check
notifications in the ACPI core device enumeration code in the
following way:

 1. Make acpi_bus_trim_one() check device status if its second argument
    is not NULL, in which case it will only detach scan handlers or ACPI
    drivers from devices whose _STA returns the enabled bit clear.

 2. Make acpi_scan_device_check() and acpi_scan_bus_check() invoke
    acpi_bus_trim_one() with a non-NULL second argument unconditionally,
    so scan handlers and ACPI drivers are detached from the target
    device and its ancestors if their _STA returns the enabled bit
    clear.

 3. Make acpi_scan_device_check() skip the bus rescan if _STA for the
    target device return the enabled bit clear, which is allowed by the
    ACPI specification in the Device Check case. [2]

In addition to the above:

 4. Make sure that the bus rescan that needs to be triggered in the case
    when a new device has appeared is carried out in the same way in
    both the Device Check and Bus Check cases.

 5. In the Device Check case, start the bus rescan mentioned above from
    the target device's parent, as per the specification. [2]

Link: https://uefi.org/specs/ACPI/6.5/06_Device_Configuration.html#sta-device-status # [1]
Link: https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#device-object-notification-values # [2]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/internal.h |    1 
 drivers/acpi/scan.c     |  109 +++++++++++++++++++++++++++---------------------
 2 files changed, 64 insertions(+), 46 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -244,11 +244,27 @@ static int acpi_scan_try_to_offline(stru
 	return 0;
 }
 
-static int acpi_bus_trim_one(struct acpi_device *adev, void *not_used)
+static int acpi_bus_trim_one(struct acpi_device *adev, void *check_status)
 {
 	struct acpi_scan_handler *handler = adev->handler;
 
-	acpi_dev_for_each_child_reverse(adev, acpi_bus_trim_one, NULL);
+	acpi_dev_for_each_child_reverse(adev, acpi_bus_trim_one, check_status);
+
+	if (check_status) {
+		acpi_bus_get_status(adev);
+		/*
+		 * Skip devices that are still there and take the enabled
+		 * flag into account.
+		 */
+		if (acpi_device_is_enabled(adev))
+			return 0;
+
+		/* Skip device that have not been enumerated. */
+		if (!acpi_device_enumerated(adev)) {
+			dev_dbg(&adev->dev, "Still not enumerated\n");
+			return 0;
+		}
+	}
 
 	adev->flags.match_driver = false;
 	if (handler) {
@@ -315,71 +331,67 @@ static int acpi_scan_hot_remove(struct a
 	return 0;
 }
 
-static int acpi_scan_device_not_enumerated(struct acpi_device *adev)
+static void acpi_scan_check_gone(struct acpi_device *adev)
 {
-	if (!acpi_device_enumerated(adev)) {
-		dev_warn(&adev->dev, "Still not enumerated\n");
-		return -EALREADY;
-	}
-	acpi_bus_trim(adev);
-	return 0;
+	acpi_bus_trim_one(adev, (void *)true);
 }
 
-static int acpi_scan_device_check(struct acpi_device *adev)
+static int acpi_scan_rescan_bus(struct acpi_device *adev)
 {
+	struct acpi_scan_handler *handler = adev->handler;
 	int error;
 
-	acpi_bus_get_status(adev);
-	if (acpi_device_is_present(adev)) {
-		/*
-		 * This function is only called for device objects for which
-		 * matching scan handlers exist.  The only situation in which
-		 * the scan handler is not attached to this device object yet
-		 * is when the device has just appeared (either it wasn't
-		 * present at all before or it was removed and then added
-		 * again).
-		 */
-		if (adev->handler) {
-			dev_dbg(&adev->dev, "Already enumerated\n");
-			return 0;
-		}
+	if (handler && handler->hotplug.scan_dependent)
+		error = handler->hotplug.scan_dependent(adev);
+	else
 		error = acpi_bus_scan(adev->handle);
-		if (error) {
-			dev_warn(&adev->dev, "Namespace scan failure\n");
-			return error;
-		}
-	} else {
-		error = acpi_scan_device_not_enumerated(adev);
-	}
+
+	if (error)
+		dev_info(&adev->dev, "Namespace scan failure\n");
+
 	return error;
 }
 
-static int acpi_scan_bus_check(struct acpi_device *adev, void *not_used)
+static int acpi_scan_device_check(struct acpi_device *adev)
 {
-	struct acpi_scan_handler *handler = adev->handler;
-	int error;
+	struct acpi_device *parent;
 
-	acpi_bus_get_status(adev);
-	if (!acpi_device_is_present(adev)) {
-		acpi_scan_device_not_enumerated(adev);
+	acpi_scan_check_gone(adev);
+
+	if (!acpi_device_is_enabled(adev))
 		return 0;
-	}
-	if (handler && handler->hotplug.scan_dependent)
-		return handler->hotplug.scan_dependent(adev);
 
-	error = acpi_bus_scan(adev->handle);
-	if (error) {
-		dev_warn(&adev->dev, "Namespace scan failure\n");
-		return error;
+	/*
+	 * This function is only called for device objects for which matching
+	 * scan handlers exist.  The only situation in which the scan handler
+	 * is not attached to this device object yet is when the device has
+	 * just appeared (either it wasn't present or enabled at all before or
+	 * it was removed and then added again).
+	 */
+	if (adev->handler) {
+		dev_dbg(&adev->dev, "Already enumerated\n");
+		return 0;
 	}
-	return acpi_dev_for_each_child(adev, acpi_scan_bus_check, NULL);
+
+	parent = acpi_dev_parent(adev);
+	if (!parent)
+		parent = adev;
+
+	return acpi_scan_rescan_bus(parent);
+}
+
+static int acpi_scan_bus_check(struct acpi_device *adev)
+{
+	acpi_scan_check_gone(adev);
+
+	return acpi_scan_rescan_bus(adev);
 }
 
 static int acpi_generic_hotplug_event(struct acpi_device *adev, u32 type)
 {
 	switch (type) {
 	case ACPI_NOTIFY_BUS_CHECK:
-		return acpi_scan_bus_check(adev, NULL);
+		return acpi_scan_bus_check(adev);
 	case ACPI_NOTIFY_DEVICE_CHECK:
 		return acpi_scan_device_check(adev);
 	case ACPI_NOTIFY_EJECT_REQUEST:
@@ -1945,6 +1957,11 @@ bool acpi_device_is_present(const struct
 	return adev->status.present || adev->status.functional;
 }
 
+bool acpi_device_is_enabled(const struct acpi_device *adev)
+{
+	return acpi_device_is_present(adev) && adev->status.enabled;
+}
+
 static bool acpi_scan_handler_matching(struct acpi_scan_handler *handler,
 				       const char *idstr,
 				       const struct acpi_device_id **matchid)
Index: linux-pm/drivers/acpi/internal.h
===================================================================
--- linux-pm.orig/drivers/acpi/internal.h
+++ linux-pm/drivers/acpi/internal.h
@@ -121,6 +121,7 @@ int acpi_device_setup_files(struct acpi_
 void acpi_device_remove_files(struct acpi_device *dev);
 void acpi_device_add_finalize(struct acpi_device *device);
 void acpi_free_pnp_ids(struct acpi_device_pnp *pnp);
+bool acpi_device_is_enabled(const struct acpi_device *adev);
 bool acpi_device_is_present(const struct acpi_device *adev);
 bool acpi_device_is_battery(struct acpi_device *adev);
 bool acpi_device_is_first_physical_node(struct acpi_device *adev,




