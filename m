Return-Path: <linux-kernel+bounces-115873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9C4889866
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 090F529DA18
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1244382C8D;
	Mon, 25 Mar 2024 03:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebWiMeE5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7C914830B;
	Sun, 24 Mar 2024 23:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322107; cv=none; b=tNSHWiKSFcLtpXrjBBS3fv5DWcHUc0ANHL22xUFZVJ9fZWDNB4XElY1TdfOxWJ1ov1lG96hu47k4CET5cAFcSFNAAdwVlCdFo7KbsnykxTAG/Wz/2uOriEI3M4oOkbshyHRfE51mJcGa5S2ULx0D2xpnbmMlZQSw8GCqO8z2jdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322107; c=relaxed/simple;
	bh=LwtYyCcaXx0HjQaLxL+6mDvVXrCjkIkao6cHiaHS30A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgUpwzuNKKJrgbxW5KMfWrxaV48pWI3vkxCxINZ5mpRQWEjNC7h/wV2ecBj3wMuYIctPlQZ6lVodtHheS28qc4yZ8oRnD8sGE1t2zMb/hPndFOu/LuAVn7uLlOfV3L+GIfZWxxslzr1J8mUa9T3ms3+r+HedwQtsleF3U00Z2FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebWiMeE5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9939FC43394;
	Sun, 24 Mar 2024 23:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322106;
	bh=LwtYyCcaXx0HjQaLxL+6mDvVXrCjkIkao6cHiaHS30A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ebWiMeE5Ufn+5WZzyvL/ppKqhMu+WK5FJjoL/IaRKFOFRRiuxnnwDIgywhIvwuXTC
	 KDD4z1RzdQkkXmt+duuKNLzwBliWBLxrF+pbuXYl42CUlgGXyCl0B4XHGh1lVKXYeT
	 EHw5QfYxEHGqKZXU1SkfIMLdZj4LJTh2tR7l8+88jj6laKp6by1TWjTF6XQUHwC4EC
	 uWzDyS0Ld0BcHOR5SAc448dlnOg2DNdJrVG6eOARpflVJLf0s3RFhZGpSHopzAbe8c
	 uOEM+BSiifvKwiUsaGQELk98rjFbn7qCwR0kpdC52owz5ALOWUlx2DjbgKIoMjZXur
	 a4HsejV2YZ25g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Alexey I. Froloff" <raorn@raorn.name>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 181/451] ACPI: resource: Do IRQ override on Lunnen Ground laptops
Date: Sun, 24 Mar 2024 19:07:37 -0400
Message-ID: <20240324231207.1351418-182-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 35a98a5916f63..8420d97287f86 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -555,6 +555,20 @@ static const struct dmi_system_id lg_laptop[] = {
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


