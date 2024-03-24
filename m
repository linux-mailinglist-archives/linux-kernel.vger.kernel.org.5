Return-Path: <linux-kernel+bounces-113162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C67B48881F4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B9ABB23D85
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3904F1304A2;
	Sun, 24 Mar 2024 22:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVyr+4IH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A2C130487;
	Sun, 24 Mar 2024 22:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319964; cv=none; b=DnPA7XZwOqK+RuSht+emxP8xFjhW1cb27//DoH5KNXgl2JTZ80UqpFd/mUsxR4Suyfmh4P++KtmEqGo3QzAEcq5DjcxjKGIgkO/ubRzTKHhy5jBqevLn8PMsR957Ej1GdsOMMT+6kz8pNfecPb+yPdEtmyUguwmjAg3Daz1Hp4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319964; c=relaxed/simple;
	bh=0STq7XixVzodxPyfWUmK0TRE9zcmsjRtxfTpQn9z/xI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNMKTJ7OkwNVLt4fh2c9mhtls63GGrIyaJXIFSDX2F8l7NLbSfr4Xr0k5ttOZzZ0Rxv9VxqGOYKKH09JQNPDl7+Ep4s28lSBOjjjVTrepbb2h957zRwOQOvLE64B+dRso4gDQET/7OrtRcgpHE9paaxeO1AikTTFWt4DZhcxDME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVyr+4IH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F3ACC433F1;
	Sun, 24 Mar 2024 22:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319964;
	bh=0STq7XixVzodxPyfWUmK0TRE9zcmsjRtxfTpQn9z/xI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EVyr+4IHf+YkEJ5Kmf1/1TlMKyYm0c+851CHriq4lVCj+NK5l8dWqenqnwllsfyCJ
	 2jGfplpZVmtAqSCjCDmiTQZoFbbsHo2axmI4TFM6GwxoPE3nOq/a6NnsovCwRqvkSd
	 zsehrA7UcIFcZombwk/fAGyIlAW8oWtnG2+R+qkdsw3HwdBTWu4brZtmtx0e5p4ndU
	 ownCJDPro5FXd/qFoRIU0RS73JgW4rwkOKJG07KlPuURbQc81T4WuiPEGDdtRmkUnH
	 AUArj16e2lwBNCfZudBdJAAiAx2K+LWwr3N20yuZvfOs+sElMnfLgXdKOEYCM74zRo
	 wlj9DoLNlklfw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Alexey I. Froloff" <raorn@raorn.name>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 271/715] ACPI: resource: Do IRQ override on Lunnen Ground laptops
Date: Sun, 24 Mar 2024 18:27:30 -0400
Message-ID: <20240324223455.1342824-272-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: "Alexey I. Froloff" <raorn@raorn.name>

[ Upstream commit e23ad54fef186aa66007895be1382c88f1ee2bf7 ]

The Lunnen Ground 15 and 16 needs IRQ overriding for the keyboard to
work.

Adding an entries for these laptops to the override_table makes the
internal keyboard functional.

Signed-off-by: Alexey I. Froloff <raorn@raorn.name>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: 021a67d09615 ("ACPI: resource: Add MAIBENBEN X577 to irq1_edge_low_force_override")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/resource.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index dacad1d846c0d..3ebb74eb768a5 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -588,6 +588,20 @@ static const struct dmi_system_id irq1_edge_low_force_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "GM5RGEE0016COM"),
 		},
 	},
+	{
+		/* Lunnen Ground 15 / AMD Ryzen 5 5500U */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Lunnen"),
+			DMI_MATCH(DMI_BOARD_NAME, "LLL5DAW"),
+		},
+	},
+	{
+		/* Lunnen Ground 16 / AMD Ryzen 7 5800U */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Lunnen"),
+			DMI_MATCH(DMI_BOARD_NAME, "LL6FA"),
+		},
+	},
 	{ }
 };
 
-- 
2.43.0


