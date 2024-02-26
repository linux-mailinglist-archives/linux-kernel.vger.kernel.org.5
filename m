Return-Path: <linux-kernel+bounces-81929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD78B867C63
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 759061F27D98
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB3612D750;
	Mon, 26 Feb 2024 16:47:07 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7E312C7EB;
	Mon, 26 Feb 2024 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966024; cv=none; b=hCfJv+w2eO+u5xcMt40eLAicjdM3xKnK3qvka76POcGyRZ7D16YFwaE0310L+mXLLxUgCpyqQmMAX5E/VsBPWk5vRKP9SW1I0+Sw3+jgg/CJaYWkQ0elZ0JR3WVlnI6bEK/Qy/m4SZ9yLbbOWXpUPRZqeWfHS2dPhpQjeWQFVzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966024; c=relaxed/simple;
	bh=TWH1mWeEyDwYEEfWcXxNAb+Yi2HEXBh8NMr9ZJ5qlNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cg5E2PD7PZCvp8bJzP1JXnmzlr2vjZlyeWWf366QCoEVERu+Zz1Wfsp4oOXiUKdGTOzIgxLSUn/OGBqle7e8RY8VKSSOqaV7glehToPtTI+nTTMCpLj1vOIpjgfxgerzEfsBHW5h1iHJNsiNyBlNKABrQb8V4GAn+bfVrrPxs4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 85ad80cd23f10339; Mon, 26 Feb 2024 17:46:54 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id C751166A4D4;
	Mon, 26 Feb 2024 17:46:53 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>
Subject:
 [PATCH v2 5/5] ACPI: scan: Consolidate Device Check and Bus Check
 notification handling
Date: Mon, 26 Feb 2024 17:46:41 +0100
Message-ID: <7632957.EvYhyI6sBW@kreacher>
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

There is no particular reason why device object subtree rescans in
acpi_scan_device_check() and acpi_scan_device_check() should be carried
out differently, so move the rescan code into a new function called
acpi_scan_rescan_bus() and make both the functions above invoke it.

While at it, in the Device Check case, start the device object subtree
rescan mentioned above from the target device's parent, as per the
specification. [1]

Link: https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#device-object-notification-values # [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * New patch (split off patch [3/4] from v1).

---
 drivers/acpi/scan.c |   44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -336,9 +336,25 @@ static int acpi_scan_hot_remove(struct a
 	return 0;
 }
 
+static int acpi_scan_rescan_bus(struct acpi_device *adev)
+{
+	struct acpi_scan_handler *handler = adev->handler;
+	int ret;
+
+	if (handler && handler->hotplug.scan_dependent)
+		ret = handler->hotplug.scan_dependent(adev);
+	else
+		ret = acpi_bus_scan(adev->handle);
+
+	if (ret)
+		dev_info(&adev->dev, "Namespace scan failure\n");
+
+	return ret;
+}
+
 static int acpi_scan_device_check(struct acpi_device *adev)
 {
-	int error;
+	struct acpi_device *parent;
 
 	acpi_scan_check_subtree(adev);
 
@@ -356,36 +372,26 @@ static int acpi_scan_device_check(struct
 		dev_dbg(&adev->dev, "Already enumerated\n");
 		return 0;
 	}
-	error = acpi_bus_scan(adev->handle);
-	if (error)
-		dev_warn(&adev->dev, "Namespace scan failure\n");
 
-	return error;
+	parent = acpi_dev_parent(adev);
+	if (!parent)
+		parent = adev;
+
+	return acpi_scan_rescan_bus(parent);
 }
 
-static int acpi_scan_bus_check(struct acpi_device *adev, void *not_used)
+static int acpi_scan_bus_check(struct acpi_device *adev)
 {
-	struct acpi_scan_handler *handler = adev->handler;
-	int error;
-
 	acpi_scan_check_subtree(adev);
 
-	if (handler && handler->hotplug.scan_dependent)
-		return handler->hotplug.scan_dependent(adev);
-
-	error = acpi_bus_scan(adev->handle);
-	if (error) {
-		dev_warn(&adev->dev, "Namespace scan failure\n");
-		return error;
-	}
-	return acpi_dev_for_each_child(adev, acpi_scan_bus_check, NULL);
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




