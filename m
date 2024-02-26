Return-Path: <linux-kernel+bounces-81930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E986E867C67
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FDE7289B63
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADA012E1D5;
	Mon, 26 Feb 2024 16:47:08 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2088B12C522;
	Mon, 26 Feb 2024 16:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966026; cv=none; b=UIdR4UDPDFZisBF4Xpnt6SDohDq3YJX5gC2yaxRVTTOU+BJanuXmWPVe+ixCHh3w5gBokziKBfX3NZQcWM1W8rFR6BslHSk9vt77s6EkOFK0hbzvg+T2I+RQkd0VS9xMySmbEynrXDPCk7DNl7AFg3Kbne8sosMh7OyrJkSHAng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966026; c=relaxed/simple;
	bh=80eMbshAOaGrGFUKm7chy0SE9XzQNdY5bar8g8qo9s0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oSOWjCnAxuzn8sZpGi9JWEOgJZ7OMx87+GdbdssUPzHaKmcvhoh2iGUVCgt2LC1MPJVwYTAETbe+gfLVvRKoDGdyIHckJLyOBv94NEqJV//ClRAqcR2UYT4wukVUjGPvPotE0kzFpEejERJ4mbAvNabO2MNILNjlP+zZXWxiDi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id fcde5ceec8ac2b3d; Mon, 26 Feb 2024 17:46:55 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 884C166A4D4;
	Mon, 26 Feb 2024 17:46:54 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>
Subject:
 [PATCH v2 4/5] ACPI: scan: Rework Device Check and Bus Check notification
 handling
Date: Mon, 26 Feb 2024 17:45:11 +0100
Message-ID: <1958983.PYKUYFuaPT@kreacher>
In-Reply-To: <6021126.lOV4Wx5bFT@kreacher>
References: <6021126.lOV4Wx5bFT@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrgedvgdeltdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeektddvveeijeekveekvdffieffheeitdehkeekfeeiheffkefgledtheelhedvudenucffohhmrghinhepuhgvfhhirdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhnrghthhgrnhdrtggrmhgvrhhonheshhhurgifvghirdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhikhgrrdifvghsthgv
 rhgsvghrgheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukh
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

 1. Rename acpi_bus_trim_one() to acpi_scan_check_and_detach() and make
    it check device status if its second argument is not NULL, in which
    case it will detach scan handlers or ACPI drivers from devices whose
    _STA returns the enabled bit clear.

 2. Make acpi_scan_device_check() and acpi_scan_bus_check() invoke
    acpi_scan_check_and_detach() with a non-NULL second argument
    unconditionally, so scan handlers and ACPI drivers are detached
    from the target device and its ancestors if their _STA returns the
    enabled bit clear.

Link: https://uefi.org/specs/ACPI/6.5/06_Device_Configuration.html#sta-device-status # [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Split patch [3/4] from v1 and put changes related to the "enabled" _STA bit
     into this patch.
   * Leave the acpi_device_is_present() check in acpi_scan_device_check(), so as to
     continue walking the bus below the device when it is not enabled (for
     backwards compatibility).

---
 drivers/acpi/scan.c |   84 +++++++++++++++++++++++++++-------------------------
 1 file changed, 45 insertions(+), 39 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -244,11 +244,27 @@ static int acpi_scan_try_to_offline(stru
 	return 0;
 }
 
-static int acpi_bus_trim_one(struct acpi_device *adev, void *not_used)
+static int acpi_scan_check_and_detach(struct acpi_device *adev, void *check)
 {
 	struct acpi_scan_handler *handler = adev->handler;
 
-	acpi_dev_for_each_child_reverse(adev, acpi_bus_trim_one, NULL);
+	acpi_dev_for_each_child_reverse(adev, acpi_scan_check_and_detach, check);
+
+	if (check) {
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
@@ -270,6 +286,11 @@ static int acpi_bus_trim_one(struct acpi
 	return 0;
 }
 
+static void acpi_scan_check_subtree(struct acpi_device *adev)
+{
+	acpi_scan_check_and_detach(adev, (void *)true);
+}
+
 static int acpi_scan_hot_remove(struct acpi_device *device)
 {
 	acpi_handle handle = device->handle;
@@ -315,42 +336,30 @@ static int acpi_scan_hot_remove(struct a
 	return 0;
 }
 
-static int acpi_scan_device_not_enumerated(struct acpi_device *adev)
-{
-	if (!acpi_device_enumerated(adev)) {
-		dev_warn(&adev->dev, "Still not enumerated\n");
-		return -EALREADY;
-	}
-	acpi_bus_trim(adev);
-	return 0;
-}
-
 static int acpi_scan_device_check(struct acpi_device *adev)
 {
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
-		error = acpi_bus_scan(adev->handle);
-		if (error) {
-			dev_warn(&adev->dev, "Namespace scan failure\n");
-			return error;
-		}
-	} else {
-		error = acpi_scan_device_not_enumerated(adev);
+	acpi_scan_check_subtree(adev);
+
+	if (!acpi_device_is_present(adev))
+		return 0;
+
+	/*
+	 * This function is only called for device objects for which matching
+	 * scan handlers exist.  The only situation in which the scan handler
+	 * is not attached to this device object yet is when the device has
+	 * just appeared (either it wasn't present at all before or it was
+	 * removed and then added again).
+	 */
+	if (adev->handler) {
+		dev_dbg(&adev->dev, "Already enumerated\n");
+		return 0;
 	}
+	error = acpi_bus_scan(adev->handle);
+	if (error)
+		dev_warn(&adev->dev, "Namespace scan failure\n");
+
 	return error;
 }
 
@@ -359,11 +368,8 @@ static int acpi_scan_bus_check(struct ac
 	struct acpi_scan_handler *handler = adev->handler;
 	int error;
 
-	acpi_bus_get_status(adev);
-	if (!acpi_device_is_present(adev)) {
-		acpi_scan_device_not_enumerated(adev);
-		return 0;
-	}
+	acpi_scan_check_subtree(adev);
+
 	if (handler && handler->hotplug.scan_dependent)
 		return handler->hotplug.scan_dependent(adev);
 
@@ -2586,7 +2592,7 @@ EXPORT_SYMBOL(acpi_bus_scan);
  */
 void acpi_bus_trim(struct acpi_device *adev)
 {
-	acpi_bus_trim_one(adev, NULL);
+	acpi_scan_check_and_detach(adev, NULL);
 }
 EXPORT_SYMBOL_GPL(acpi_bus_trim);
 




