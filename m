Return-Path: <linux-kernel+bounces-21016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE7782888C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A25E01C24625
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCAD39AE7;
	Tue,  9 Jan 2024 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=projectyo.network header.i=@projectyo.network header.b="f2qcE4LT"
Received: from postmaster.projectyo.network (postmaster.projectyo.network [188.126.76.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E4B39AD6;
	Tue,  9 Jan 2024 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=projectyo.network
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=projectyo.network
From: Michael Maltsev <mekosko@projectyo.network>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=projectyo.network;
	s=mail; t=1704812049;
	bh=dWGm3uj6yVulnQWDtyyLi5N7wiOErAMktK9wj2tl1xE=;
	h=From:To:Cc:Subject;
	b=f2qcE4LTx6lBVWnXVmts0KGf87a5CzFAXsXLnNxYJynqgzfiUKPCcjzcuN7i9eXZc
	 L4dW1Ek1ouhphppBqmjaUxhxpODBVmsm9lHpI/b0+pCitDxFeqygL9l9bsygONYftE
	 qCjKYmp474xbpJPAOpfESrKiKDdpVWlRckRH/dBg=
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: Michael Maltsev <mekosko@projectyo.network>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] ACPI: resource: Skip IRQ override on ASUS ExpertBook B1502CGA
Date: Tue,  9 Jan 2024 19:53:05 +0500
Message-Id: <20240109145305.5680-1-mekosko@projectyo.network>
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
index 9bd9f79cd409..a03de3470776 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -461,6 +461,13 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "B1502CBA"),
 		},
 	},
+	{
+		/* Asus ExpertBook B1502CGA */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "B1502CGA"),
+		},
+	},
 	{
 		/* Asus ExpertBook B2402CBA */
 		.matches = {
-- 
2.39.2


