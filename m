Return-Path: <linux-kernel+bounces-81932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BA4867C73
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C003B24E40
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3502712DD8A;
	Mon, 26 Feb 2024 16:47:09 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7E912C81A;
	Mon, 26 Feb 2024 16:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966026; cv=none; b=kpVvZJstz5Ip5+exIos4NhvBRirhMuRYUkAT9tbuw9LuHbMEi39qu5b7bI+/n4cmAGahqP3ktwvqKNXmSkCTCEasgZkGBPo31s5qqrNG/vFby0Jqr8w0scnO1IoxWvqvuNgyZvHOX+R1B4awnSd9kSqUlVxOAu8FrvxthFPPbvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966026; c=relaxed/simple;
	bh=H6jbNlhYPKxICX9pBOmoUAMwvEsvPiIS9SR2byJFPLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gYAqqHcsh9wtym5F0CvQNmx0vqcb/gavkbweCrJ4Fzy7yaXcTKW9CtF82G25mtawTkm4/cCuW9RLTuglv4hlIsN4u7jKqbHrfjGM3p+3y7jwVzPyga80mHJFgfTG/wDdnNV22rCLdekOW7PXK43szPa3fAALpffub02Qsh9akEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 109f2822a4f54781; Mon, 26 Feb 2024 17:46:55 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 4415566A4D4;
	Mon, 26 Feb 2024 17:46:55 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>
Subject:
 [PATCH v2 3/5] ACPI: scan: Make acpi_processor_add() check the device enabled
 bit
Date: Mon, 26 Feb 2024 17:40:52 +0100
Message-ID: <3283809.44csPzL39Z@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrgedvgdeltdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeektddvveeijeekveekvdffieffheeitdehkeekfeeiheffkefgledtheelhedvudenucffohhmrghinhepuhgvfhhirdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhnrghthhgrnhdrtggrmhgvrhhonheshhhurgifvghirdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhikhgrrdifvghsthgv
 rhgsvghrgheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Modify acpi_processor_add() return an error if _STA returns the enabled
bit clear for the given processor device, so as to avoid using processors
that don't decode their resources, as per the ACPI specification. [1]

Link: https://uefi.org/specs/ACPI/6.5/06_Device_Configuration.html#sta-device-status # [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Move acpi_device_is_enabled() to this patch.
   * Change patch ordering.
   * Do not check the "functional" _STA bit in acpi_device_is_present().

---
 drivers/acpi/acpi_processor.c |    3 +++
 drivers/acpi/internal.h       |    1 +
 drivers/acpi/scan.c           |    5 +++++
 3 files changed, 9 insertions(+)

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
Index: linux-pm/drivers/acpi/acpi_processor.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpi_processor.c
+++ linux-pm/drivers/acpi/acpi_processor.c
@@ -381,6 +381,9 @@ static int acpi_processor_add(struct acp
 	struct device *dev;
 	int result = 0;
 
+	if (!acpi_device_is_enabled(device))
+		return -ENODEV;
+
 	pr = kzalloc(sizeof(struct acpi_processor), GFP_KERNEL);
 	if (!pr)
 		return -ENOMEM;
Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -1945,6 +1945,11 @@ bool acpi_device_is_present(const struct
 	return adev->status.present || adev->status.functional;
 }
 
+bool acpi_device_is_enabled(const struct acpi_device *adev)
+{
+	return adev->status.present && adev->status.enabled;
+}
+
 static bool acpi_scan_handler_matching(struct acpi_scan_handler *handler,
 				       const char *idstr,
 				       const struct acpi_device_id **matchid)




