Return-Path: <linux-kernel+bounces-81931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A9B867C66
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A10312942F7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E4C12DDAD;
	Mon, 26 Feb 2024 16:47:08 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9C912CD86;
	Mon, 26 Feb 2024 16:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966026; cv=none; b=nW3Y6hvaanTlkDTe1Ff7MVn1p+mti8DYyOD0205zM7j7VHhny6C5L2yGQU4ywKkPzrLRrdKlhYNg4yejhlMrbbF+e4Z3ni++a1KqQCB2r2gkp+qfNgEiddG4hMH8iPZSnuZAVu0B7/XetJTBbVODXEacssAfTKb2xwujXkBNkEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966026; c=relaxed/simple;
	bh=V8VjEBHHbro0LzuYQmikArpREkhS9oNaxPxTm/Z9jQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aDMmvR35nmaBW7Q/TwgsBLPWTQInAIqh6ySSnk+DZJ/ZLI2NtK6Xf9NjS1iKyid9y2G6aie1SG1T+E48y5uIBcd1e/rOACTJpQXxCDKGzK+RTAyfkg9WioUJrzMzAtj6LDO9DrqEXdCTBiNzVdLRDpLMJAXNV0S8thvwGXJG6wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id f2c25af9204c6c8c; Mon, 26 Feb 2024 17:46:56 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id E8A1866A4D4;
	Mon, 26 Feb 2024 17:46:55 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>
Subject: [PATCH v2 2/5] ACPI: scan: Relocate acpi_bus_trim_one()
Date: Mon, 26 Feb 2024 17:36:22 +0100
Message-ID: <2175138.irdbgypaU6@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrgedvgdeltdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhonhgrthhhrghnrdgtrghmvghrohhnsehhuhgrfigvihdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghl
 rdgtohhmpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhk
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Relocate acpi_bus_trim_one() (without modifications) so as to avoid the
need to add a forward declaration of it in a subsequent patch.

No functional changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Add R-by from Jonathan.

---
 drivers/acpi/scan.c |   52 ++++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -244,6 +244,32 @@ static int acpi_scan_try_to_offline(stru
 	return 0;
 }
 
+static int acpi_bus_trim_one(struct acpi_device *adev, void *not_used)
+{
+	struct acpi_scan_handler *handler = adev->handler;
+
+	acpi_dev_for_each_child_reverse(adev, acpi_bus_trim_one, NULL);
+
+	adev->flags.match_driver = false;
+	if (handler) {
+		if (handler->detach)
+			handler->detach(adev);
+
+		adev->handler = NULL;
+	} else {
+		device_release_driver(&adev->dev);
+	}
+	/*
+	 * Most likely, the device is going away, so put it into D3cold before
+	 * that.
+	 */
+	acpi_device_set_power(adev, ACPI_STATE_D3_COLD);
+	adev->flags.initialized = false;
+	acpi_device_clear_enumerated(adev);
+
+	return 0;
+}
+
 static int acpi_scan_hot_remove(struct acpi_device *device)
 {
 	acpi_handle handle = device->handle;
@@ -2547,32 +2573,6 @@ int acpi_bus_scan(acpi_handle handle)
 }
 EXPORT_SYMBOL(acpi_bus_scan);
 
-static int acpi_bus_trim_one(struct acpi_device *adev, void *not_used)
-{
-	struct acpi_scan_handler *handler = adev->handler;
-
-	acpi_dev_for_each_child_reverse(adev, acpi_bus_trim_one, NULL);
-
-	adev->flags.match_driver = false;
-	if (handler) {
-		if (handler->detach)
-			handler->detach(adev);
-
-		adev->handler = NULL;
-	} else {
-		device_release_driver(&adev->dev);
-	}
-	/*
-	 * Most likely, the device is going away, so put it into D3cold before
-	 * that.
-	 */
-	acpi_device_set_power(adev, ACPI_STATE_D3_COLD);
-	adev->flags.initialized = false;
-	acpi_device_clear_enumerated(adev);
-
-	return 0;
-}
-
 /**
  * acpi_bus_trim - Detach scan handlers and drivers from ACPI device objects.
  * @adev: Root of the ACPI namespace scope to walk.




