Return-Path: <linux-kernel+bounces-18820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FD582638B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 09:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0571F21B5D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 08:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C364125C4;
	Sun,  7 Jan 2024 08:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=projectyo.network header.i=@projectyo.network header.b="JDd+nwDH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from postmaster.projectyo.network (postmaster.projectyo.network [188.126.76.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A2C12B69;
	Sun,  7 Jan 2024 08:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=projectyo.network
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=projectyo.network
From: Michael Maltsev <mekosko@projectyo.network>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=projectyo.network;
	s=mail; t=1704617939;
	bh=6et/rZyJYLqDQALcNxZOrBgVtpgDmqB0oE4kmJNIJk0=;
	h=From:To:Cc:Subject;
	b=JDd+nwDHQNHixD0VhHvVptydhznd/4weaZsoUpx5Nf5qKlGK/h6zrNGySrp1mhMEM
	 gqJsEW0uVnTasHIeKdPjuZATYk9nIrMZpiFbSB0s9sSyBGdeGzCH9tuhLsVVNRM/nc
	 tsY4x5u71mhX2z29Jj8IPJbKWpUS7iEkgSj89xMI=
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: Michael Maltsev <mekosko@projectyo.network>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: resource: Skip IRQ override on ASUS ExpertBook B1502CGA
Date: Sun,  7 Jan 2024 13:53:07 +0500
Message-Id: <20240107085305.6981-1-mekosko@projectyo.network>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like the ASUS ExpertBook B1502CBA and various ASUS laptops, the
ASUS ExpertBook B1502CGA has an ACPI DSDT table that describes IRQ 1 as
ActiveLow while the kernel overrides it to Edge_High.

	$ sudo dmesg | grep DMI
	[    0.000000] DMI: ASUSTeK COMPUTER INC. ASUS EXPERTBOOK B1502CGA_B1502CGA/B1502CGA, BIOS B1502CGA.303 06/05/2023
	$ grep -A 40 PS2K dsdt.dsl | grep IRQ -A 1
	                IRQ (Level, ActiveLow, Exclusive, )
	                    {1}

This prevents the keyboard from working. To fix this issue, add this laptop
to the skip_override_table so that the kernel does not override IRQ 1.

Signed-off-by: Michael Maltsev <mekosko@projectyo.network>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index c297e40c5bdc..b0c3da70f809 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -453,6 +453,13 @@ static const struct dmi_system_id asus_laptop[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "B1402CVA"),
 		},
 	},
+	{
+		.ident = "Asus ExpertBook B1502CGA",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "B1502CGA"),
+		},
+	},
 	{
 		.ident = "Asus ExpertBook B2402CBA",
 		.matches = {
-- 
2.39.2


