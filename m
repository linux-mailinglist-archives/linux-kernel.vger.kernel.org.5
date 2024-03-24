Return-Path: <linux-kernel+bounces-116032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A52EA889510
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45D461F303D1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4880226E5EE;
	Mon, 25 Mar 2024 03:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNpyfc0+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7382779DD;
	Sun, 24 Mar 2024 23:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323414; cv=none; b=PAVpzzq9VFdsMgpOqEtNpfhU9RCejdGU0SpoYQFZw0liVOXGm9J5Gx3OnfrWXxA4jN6olzn+Ps8h8Wd+Cf13MEup2L81PWhH5PHU9bYouTHiIfcQX2Ga8rZYNrq2d+TzGp3rcGDSQ5xG4lrePNSkb0+9NHWVWAvKmF4h2hcajmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323414; c=relaxed/simple;
	bh=/YcyTFGQuKRCQLnEtNVZ7X7oui9OK53d2UmFWsIndx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KGl43+OZYYj2buw9X/5RqQagw4HYKSMdgmynWgaQprLNMO8mrm5q6PGUSNzQfmCCSFQOD+vPmGaWtZ/dWC0Pp59f5p4bBtjkJP8FaP2FH7TnBD//cm7EC0xmV3Ox35dtzos8Hq1l1WZFdN33MTLVU+8Za+soYqwtQIGiDa897dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNpyfc0+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1590C433F1;
	Sun, 24 Mar 2024 23:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323414;
	bh=/YcyTFGQuKRCQLnEtNVZ7X7oui9OK53d2UmFWsIndx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mNpyfc0+z4QIYV+uQrKdMksN417XkywLDfuykTOqsbbgcyx3lE2xoV4ur16Wvbx7M
	 3NidfYao3UHkPnnAHeirIml3wM2mkPUBPKTejXSZkM9qusrp8+1UmUjAfcFTaO5K2h
	 Xp3SMID8A6JcKkj7BRaXVrBNiNxKAxcKuv3W+dkXewpfkNiJ5aOVrLWXrMbGfI8Xjd
	 +YdQeRz6mMt5LRMN5na0KKeJxf/giHref5vDDiQVHngOqY58yNwpUgLQ8WMu0qoSSW
	 dPYdURxpP1uL/2IKETMIv1M3K0O3t+P0mDpARRT7Db9A4DD0uypx131t11/xmD5KQj
	 IvNWDrxBGhD2w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David McFarland <corngood@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 116/317] ACPI: resource: Add Infinity laptops to irq1_edge_low_force_override
Date: Sun, 24 Mar 2024 19:31:36 -0400
Message-ID: <20240324233458.1352854-117-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: David McFarland <corngood@gmail.com>

[ Upstream commit e2605d4039a42a03000856b3229932455717b48b ]

A user reported a keyboard problem similar to ones reported with other
Zen laptops, on an Infinity E15-5A165-BM.

Add board name matches for this model and one (untested) close relative
to irq1_edge_low_force_override.

Link: https://lemmy.ml/post/9864736
Link: https://www.infinitygaming.com.au/bios/
Link: https://lore.kernel.org/linux-acpi/20231006123304.32686-1-hdegoede@redhat.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: 021a67d09615 ("ACPI: resource: Add MAIBENBEN X577 to irq1_edge_low_force_override")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/resource.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index a364cb07c5578..16a18654f6879 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -546,6 +546,18 @@ static const struct dmi_system_id lg_laptop[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "17U70P"),
 		},
 	},
+	{
+		/* Infinity E15-5A165-BM */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GM5RG1E0009COM"),
+		},
+	},
+	{
+		/* Infinity E15-5A305-1M */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GM5RGEE0016COM"),
+		},
+	},
 	{ }
 };
 
-- 
2.43.0


