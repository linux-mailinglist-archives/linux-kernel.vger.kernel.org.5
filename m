Return-Path: <linux-kernel+bounces-116033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C53E889577
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5B0D1F30A22
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5204526FA59;
	Mon, 25 Mar 2024 03:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNQUopKQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7488D2779E3;
	Sun, 24 Mar 2024 23:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323415; cv=none; b=GGc+5rIw+Ol7G6XVDJx3kRmj3ux1T7SSlUeNnbcfSYI3f5rK14FFnPW6SNim48U1tE80J4TjSm568UrjbnYaPMMg6PAU6aVbi1JG6VjRpissXwS9204avNW69uHotZjzXO8ObxjnGP6h/2qt9HbdpNuKf13LQ2rFItimvxZYmvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323415; c=relaxed/simple;
	bh=mzT4Q+z9FiXg3S/XaF8ChxTrhgd0KtXLW1G73ipIrx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gksnb0HbdXUxLDqUbC9HxxVjT5TYrJmvHG8JmMKKnHF410+gK6ZOmb3JNFolIV7UTuZ3sHvlDsb2zh0ZlcGLAbEK/7BJQhfuWv0DxnWnFMzef+L/NHhB4J2U8PIW2VltmNE8DZVZfLY6fPH5Ftpe2tNKi+cip+8SiW5wLu5pyaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNQUopKQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B415BC433C7;
	Sun, 24 Mar 2024 23:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323415;
	bh=mzT4Q+z9FiXg3S/XaF8ChxTrhgd0KtXLW1G73ipIrx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RNQUopKQOVemT4um65Qa3fugQL8fhq97zUcFqZs05gIBv563VLoMcH2VuUviaEQvg
	 t54Ha0+vF787EShQrAdkYOF51ay8dgUcT8dog0bv9OXWbfbJ149/2uWbDhFmRqwKFg
	 R5kzB0Bsu8VGsQEsvulN/Ytvo0pkzApHK6f86yfgduzIlWeBa75WSn9tBcc4b7XxWA
	 oiq+0UPsPMc+nRj0ZUnzAAZQp1VLntQcwkaXtNTFj2OAk5x4cDz7SWadNb4BIOH3kF
	 d9lKLNnLU2M4XwGXMmrNOAASuIO0Z9TuemQ8tnYwIp4H8r4V7pqO2PHSkcmUF0jyW1
	 Ro5TIgmvhTRqw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Alexey I. Froloff" <raorn@raorn.name>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 117/317] ACPI: resource: Do IRQ override on Lunnen Ground laptops
Date: Sun, 24 Mar 2024 19:31:37 -0400
Message-ID: <20240324233458.1352854-118-sashal@kernel.org>
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
index 16a18654f6879..a46e0bf0e1dc4 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -558,6 +558,20 @@ static const struct dmi_system_id lg_laptop[] = {
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


